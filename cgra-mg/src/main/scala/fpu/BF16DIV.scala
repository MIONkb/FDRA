package tram.fpu

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage

// ============================================================================
// BF16 Floating-Point Divider using Reciprocal-and-Multiply (HPS-inspired)
//
// BF16 format: [15] sign | [14:7] exponent (8-bit, bias 127) | [6:0] mantissa
// Division: a / b = a × (1/b)
// Pipeline latency: 3 cycles (1 inverter + 2 multiplier)
// ============================================================================

/** Decomposes a 16-bit BF16 value into its fields. */
class BF16Wrapper(val num: UInt) {
  require(num.getWidth == 16)
  val sign     = num(15)
  val exponent = num(14, 7)
  val mantissa = Cat(Mux(num(14, 7) === 0.U, 0.U(1.W), 1.U(1.W)), num(6, 0)) // 8 bits: 1.mmmmmmm
  val zero     = num(14, 0) === 0.U
  val isNaN    = num(14, 7) === "hFF".U && num(6, 0) =/= 0.U
  val isInf    = num(14, 7) === "hFF".U && num(6, 0) === 0.U
}

// ============================================================================
// BF16 Mantissa Inverter — combinational, direct 128-entry LUT
//
// Input:  7-bit mantissa m (without implicit leading 1; full value is 1.m)
// Output: 8-bit reciprocal code R where:
//   m = 0  → R = 0  (means reciprocal is exactly 1.0; exponent not corrected)
//   m ≠ 0  → R = round(256 / (1 + m/128)), range [129, 254], MSB always 1
//             The reciprocal is R/128 × 2^(-1), with exponent decremented by 1.
//             Mantissa field for the BF16 reciprocal = R(6, 0).
// ============================================================================

class BF16Inverter extends Module {
  val io = IO(new Bundle {
    val in  = Input(UInt(7.W))
    val out = Output(UInt(8.W))
  })

  // Generate LUT at elaboration time
  // Entry 0 = 0 (special: reciprocal is exactly 1.0)
  // Entry m (1..127) = round(256.0 / (1.0 + m / 128.0))
  val lutValues: Seq[Int] = (0 until 128).map { m =>
    if (m == 0) 0
    else math.round(256.0f / (1.0f + m.toFloat / 128.0f)).toInt
  }

  val lut = VecInit(lutValues.map(_.U(8.W)))
  io.out := lut(io.in)
}

// ============================================================================
// BF16 Mantissa Inverter — Wide (10-bit) variant used by BF16Div
//
// Same shape as BF16Inverter but returns a 10-bit reciprocal code:
//   m = 0  → R = 0 (reciprocal exactly 1.0, exponent not corrected)
//   m ≠ 0  → R = round(1024 / (1 + m/128)) ∈ [514, 1016], bit 9 always 1.
// The extra 2 precision bits shrink the LUT quantization error by 4×.
// ============================================================================

class BF16InverterWide extends Module {
  val io = IO(new Bundle {
    val in  = Input(UInt(7.W))
    val out = Output(UInt(10.W))
  })

  val lutValues: Seq[Int] = (0 until 128).map { m =>
    if (m == 0) 0
    else math.round(1024.0f / (1.0f + m.toFloat / 128.0f)).toInt
  }

  val lut = VecInit(lutValues.map(_.U(10.W)))
  io.out := lut(io.in)
}

// ============================================================================
// BF16 Multiplier — 2-cycle pipeline
//
// Cycle 0: sign XOR, exponent add, mantissa multiply (8×8=16 bit)
// Cycle 1: normalization + round-to-nearest-even
// ============================================================================

class BF16Mult extends Module {
  val io = IO(new Bundle {
    val a   = Input(UInt(16.W))
    val b   = Input(UInt(16.W))
    val res = Output(UInt(16.W))
  })

  val a_wrap = new BF16Wrapper(io.a)
  val b_wrap = new BF16Wrapper(io.b)

  // Stage 0: compute raw products
  val stage0_sign     = a_wrap.sign ^ b_wrap.sign
  val stage0_exponent = a_wrap.exponent +& b_wrap.exponent // 9 bits
  val stage0_mantissa = a_wrap.mantissa * b_wrap.mantissa   // 8×8 = 16 bits
  val stage0_zero     = a_wrap.zero || b_wrap.zero

  val sign_reg     = RegNext(stage0_sign)
  val exponent_reg = RegNext(stage0_exponent)
  val mantissa_reg = RegNext(stage0_mantissa)
  val zero_reg     = RegNext(stage0_zero)

  // Stage 1: normalize and round
  // 1.xxx × 1.yyy = [1.0, 4.0), so product mantissa is 16 bits:
  //   bit 15 = 1 → product in [2, 4): take bits [14:8], round bit [7], exp += 1
  //   bit 15 = 0 → product in [1, 2): take bits [13:7], round bit [6]
  val finalSign     = sign_reg
  val finalExponent = Wire(UInt(8.W))
  val finalMantissa = Wire(UInt(7.W))

  // when(zero_reg) {
  //   finalExponent := 0.U
  //   finalMantissa := 0.U
  // }.elsewhen(mantissa_reg(15)) {
  //   finalExponent := (exponent_reg - 126.U)(7, 0)
  //   val rawMant = mantissa_reg(14, 8)
  //   val roundBit = mantissa_reg(7)
  //   val stickyBit = mantissa_reg(6, 0).orR
  //   // Round to nearest, ties to even
  //   val roundUp = roundBit & (stickyBit | rawMant(0))
  //   finalMantissa := rawMant + roundUp
  // }.otherwise {
  //   finalExponent := (exponent_reg - 127.U)(7, 0)
  //   val rawMant = mantissa_reg(13, 7)
  //   val roundBit = mantissa_reg(6)
  //   val stickyBit = mantissa_reg(5, 0).orR
  //   val roundUp = roundBit & (stickyBit | rawMant(0))
  //   finalMantissa := rawMant + roundUp
  // }
  when(zero_reg) {
    finalExponent := 0.U
    finalMantissa := 0.U
  }.elsewhen(mantissa_reg(15)) {
    val rawMant      = mantissa_reg(14, 8)
    val roundBit     = mantissa_reg(7)
    val stickyBit    = mantissa_reg(6, 0).orR
    // RNE 
    val roundUp      = roundBit & (stickyBit | rawMant(0))
    val mantAfterRound = rawMant +& roundUp 
    finalMantissa := Mux(mantAfterRound(7), 0.U, mantAfterRound(6, 0))
    finalExponent := Mux(mantAfterRound(7), (exponent_reg - 125.U), (exponent_reg - 126.U))(7, 0)

  }.otherwise {
    val rawMant      = mantissa_reg(13, 7)
    val roundBit     = mantissa_reg(6)
    val stickyBit    = mantissa_reg(5, 0).orR
    val roundUp      = roundBit & (stickyBit | rawMant(0))
    val mantAfterRound = rawMant +& roundUp
    finalMantissa := Mux(mantAfterRound(7), 0.U, mantAfterRound(6, 0))
    finalExponent := Mux(mantAfterRound(7), (exponent_reg - 126.U), (exponent_reg - 127.U))(7, 0)
  }


  io.res := RegNext(Cat(finalSign, finalExponent, finalMantissa))
}

// ============================================================================
// BF16 Multiplier — Wide-B variant for BF16Div
//
// Same pipeline as BF16Mult but accepts the b operand as pre-split fields
// with a 9-bit explicit mantissa (implicit 1 prepended internally) for 10-bit
// total mantissa precision.  Product is 8×10 = 18 bits; normalization and
// RNE bit positions shift by +2 compared to BF16Mult.
// ============================================================================

class BF16MultWideB extends Module {
  val io = IO(new Bundle {
    val a          = Input(UInt(16.W))
    val bSign      = Input(UInt(1.W))
    val bExp       = Input(UInt(8.W))
    val bMantField = Input(UInt(9.W))   // explicit fraction; implicit 1 added here
    val res        = Output(UInt(16.W))
  })

  val a_wrap    = new BF16Wrapper(io.a)
  val bMantFull = Cat(1.U(1.W), io.bMantField)  // 10 bits; m=0 → 1.0 exactly

  // Stage 0
  val stage0_sign     = a_wrap.sign ^ io.bSign(0)
  val stage0_exponent = a_wrap.exponent +& io.bExp        // 9 bits
  val stage0_mantissa = a_wrap.mantissa * bMantFull        // 8 × 10 = 18 bits
  val stage0_zero     = a_wrap.zero

  val sign_reg     = RegNext(stage0_sign)
  val exponent_reg = RegNext(stage0_exponent)
  val mantissa_reg = RegNext(stage0_mantissa)
  val zero_reg     = RegNext(stage0_zero)

  // Stage 1: normalize + RNE round
  // Product in [1, 4): bit 17 set ⇒ [2,4), shift right; bit 17 clear ⇒ [1,2)
  val finalSign     = sign_reg
  val finalExponent = Wire(UInt(8.W))
  val finalMantissa = Wire(UInt(7.W))

  when(zero_reg) {
    finalExponent := 0.U
    finalMantissa := 0.U
  }.elsewhen(mantissa_reg(17)) {
    val rawMant        = mantissa_reg(16, 10)
    val roundBit       = mantissa_reg(9)
    val stickyBit      = mantissa_reg(8, 0).orR
    val roundUp        = roundBit & (stickyBit | rawMant(0))
    val mantAfterRound = rawMant +& roundUp
    finalMantissa := Mux(mantAfterRound(7), 0.U, mantAfterRound(6, 0))
    finalExponent := Mux(mantAfterRound(7), (exponent_reg - 125.U), (exponent_reg - 126.U))(7, 0)
  }.otherwise {
    val rawMant        = mantissa_reg(15, 9)
    val roundBit       = mantissa_reg(8)
    val stickyBit      = mantissa_reg(7, 0).orR
    val roundUp        = roundBit & (stickyBit | rawMant(0))
    val mantAfterRound = rawMant +& roundUp
    finalMantissa := Mux(mantAfterRound(7), 0.U, mantAfterRound(6, 0))
    finalExponent := Mux(mantAfterRound(7), (exponent_reg - 126.U), (exponent_reg - 127.U))(7, 0)
  }

  io.res := RegNext(Cat(finalSign, finalExponent, finalMantissa))
}

// ============================================================================
// BF16 Divider — Top level, 3-cycle pipeline
//
// Cycle 0→1: LUT reciprocal + dividend/sign/exp delayed 1 register
// Cycle 1→2: Multiplier stage 0 (mantissa multiply)
// Cycle 2→3: Multiplier stage 1 (normalize + round) → output
//
// Special cases detected at input, propagated through 3-stage delay chain.
// ============================================================================

class BF16Div extends Module {
  val io = IO(new Bundle {
    val in1 = Input(UInt(16.W))   // dividend (a)
    val in2 = Input(UInt(16.W))   // divisor  (b)
    val out = Output(UInt(16.W))  // result   (a / b)
  })

  // --- Special case detection (combinational, at input) ---
  val a_wrap = new BF16Wrapper(io.in1)
  val b_wrap = new BF16Wrapper(io.in2)

  val resultSign = a_wrap.sign ^ b_wrap.sign

  val isNaN_a  = a_wrap.isNaN
  val isNaN_b  = b_wrap.isNaN
  val isInf_a  = a_wrap.isInf
  val isInf_b  = b_wrap.isInf
  val isZero_a = a_wrap.zero
  val isZero_b = b_wrap.zero

  val specialNaN  = isNaN_a || isNaN_b || (isInf_a && isInf_b) || (isZero_a && isZero_b)
  val specialInf  = (isInf_a && !isInf_b && !isNaN_b) || (!isNaN_a && !isZero_a && isZero_b)
  val specialZero = (isZero_a && !isZero_b && !isNaN_b) || (!isNaN_a && !isInf_a && isInf_b)
  val isSpecial   = specialNaN || specialInf || specialZero

  val canonicalNaN  = "h7FC0".U(16.W)
  val specialResult = Wire(UInt(16.W))
  specialResult := Mux(specialNaN, canonicalNaN,
                   Mux(specialInf, Cat(resultSign, "hFF".U(8.W), 0.U(7.W)),
                                   Cat(resultSign, 0.U(15.W))))

  // --- Inverter: combinational LUT (10-bit wide for improved precision) ---
  val inverter = Module(new BF16InverterWide)
  inverter.io.in := io.in2(6, 0)

  // --- Pipeline stage 0→1: register everything to align with multiplier input ---
  val in1Reg       = RegNext(io.in1, 0.U)
  val in2ExpReg    = RegNext(io.in2(14, 7), 0.U)
  val in2SignReg   = RegNext(io.in2(15), 0.U)
  val invMantReg   = RegNext(inverter.io.out, 0.U(10.W))
  val specialReg0  = RegNext(isSpecial, false.B)
  val specResReg0  = RegNext(specialResult, 0.U)

  // --- Reconstruct reciprocal exponent from registered inverter output ---
  // invMantReg = 0 → reciprocal is 1.0 × 2^(254-exp-127) → exp = 254-exp_b
  // invMantReg ≠ 0 → reciprocal is (1.xxx) × 2^(-1) × 2^(254-exp-127)
  //                   → exp = 254-exp_b-1 = 253-exp_b
  val negExpTmp = 254.U(9.W) - in2ExpReg
  val negExp    = Mux(invMantReg === 0.U, negExpTmp, negExpTmp - 1.U)(7, 0)

  // --- Multiplier: dividend × reciprocal (2 cycles, wide-B variant) ---
  // invMantReg is 10 bits; bits [8:0] are the 9-bit explicit fraction field
  // (bit 9 is always 1 for m≠0; for m=0 the whole word is 0 and the
  //  multiplier's internal Cat(1, 0…0) yields exactly 1.0)
  val multiplier = Module(new BF16MultWideB)
  multiplier.io.a          := in1Reg
  multiplier.io.bSign      := in2SignReg
  multiplier.io.bExp       := negExp
  multiplier.io.bMantField := invMantReg(8, 0)

  // --- Delay special case flags through multiplier (1 more cycle to match mult's 1 RegNext) ---
  val specialReg1  = RegNext(specialReg0, false.B)
  val specResReg1  = RegNext(specResReg0, 0.U)

  // --- Output: special case or normal result ---
  // Normal path: 1 reg (alignment) + 1 reg (mult stage0) = 2 regs, then combinational output
  // Special path: specialReg0 + specialReg1 = 2 regs, matching normal path
  val specialReg2 = RegNext(specialReg1, false.B)
  val specResReg2 = RegNext(specResReg1, 0.U)
  io.out := Mux(specialReg2, specResReg2, multiplier.io.res)

  // io.out := Mux(specialReg1, specResReg1, multiplier.io.res)
}

/** Variant that outputs operands for an external/shared BF16 multiplier. */
class BF16DivToMul extends Module {
  val io = IO(new Bundle {
    val in1  = Input(UInt(16.W))
    val in2  = Input(UInt(16.W))
    val mulA = Output(UInt(16.W))
    val mulB = Output(UInt(16.W))
  })

  val inverter = Module(new BF16Inverter)
  inverter.io.in := io.in2(6, 0)

  val in1Reg     = RegNext(io.in1, 0.U)
  val in2ExpReg  = RegNext(io.in2(14, 7), 0.U)
  val in2SignReg = RegNext(io.in2(15), 0.U)
  val invMantReg = RegNext(inverter.io.out, 0.U(8.W))

  val negExpTmp = 254.U(9.W) - in2ExpReg
  val negExp    = Mux(invMantReg === 0.U, negExpTmp, negExpTmp - 1.U)(7, 0)

  io.mulA := in1Reg
  io.mulB := Cat(in2SignReg, negExp, invMantReg(6, 0))
}

// ============================================================================
// 16-Entry LUT Variant (area-optimised)
//
// Uses the same multi-LUT + linear-interpolation technique as the FP32 design:
//   - Top 4 mantissa bits index two 16-entry LUTs (L base, J slope)
//   - Bottom 3 mantissa bits are the interpolation offset δ
//   - L has a 1-cycle registered output (mirrors FP32 lookupL)
//   - J is combinational (mirrors FP32 lookupJ)
//   - Pipeline computes:  reciprocal ≈ L[addr] − ⌊J[addr]·δ / 8⌋
//   - Inverter latency: 1 cycle (L register)
//
// Total divider latency: 2 cycles (same as 128-entry variant)
// ============================================================================

/** 16-entry base reciprocal LUT, 9-bit values.
  * L(i) = round(256 / (1 + i/16)) — registered output like FP32's lookupL. */
class BF16LookupL16 extends Module {
  val io = IO(new Bundle {
    val addr = Input(UInt(4.W))
    val out  = Output(UInt(9.W))
  })

  // 1/(1+i/16) × 256, rounded:
  //  i= 0: 256   i= 1: 241   i= 2: 228   i= 3: 216
  //  i= 4: 205   i= 5: 195   i= 6: 186   i= 7: 178
  //  i= 8: 171   i= 9: 164   i=10: 158   i=11: 152
  //  i=12: 146   i=13: 141   i=14: 137   i=15: 132
  val coeffL = VecInit(Seq(
    256.U(9.W), 241.U(9.W), 228.U(9.W), 216.U(9.W),
    205.U(9.W), 195.U(9.W), 186.U(9.W), 178.U(9.W),
    171.U(9.W), 164.U(9.W), 158.U(9.W), 152.U(9.W),
    146.U(9.W), 141.U(9.W), 137.U(9.W), 132.U(9.W)
  ))

  io.out := RegNext(coeffL(io.addr), 0.U(9.W))
}

/** 16-entry slope LUT, 5-bit values.
  * J(i) = L(i) − L(i+1) — combinational output like FP32's lookupJ. */
class BF16LookupJ16 extends Module {
  val io = IO(new Bundle {
    val addr = Input(UInt(4.W))
    val out  = Output(UInt(5.W))
  })

  val coeffJ = VecInit(Seq(
    15.U(5.W), 13.U(5.W), 12.U(5.W), 11.U(5.W),
    10.U(5.W),  9.U(5.W),  8.U(5.W),  7.U(5.W),
     7.U(5.W),  6.U(5.W),  6.U(5.W),  6.U(5.W),
     5.U(5.W),  4.U(5.W),  5.U(5.W),  3.U(5.W)
  ))

  io.out := coeffJ(io.addr)
}

/** 16-entry mantissa inverter — 1-cycle pipeline (mirrors FP32 fpInverter style).
  *
  * Datapath (following the FP32 pattern):
  *   Stage 0 (combinational): LUT address decode, J×δ multiply
  *   Register barrier: L registered inside lookupL; J×δ registered here
  *   Stage 1 (combinational): subtract → reciprocal = L − ⌊J·δ/8⌋
  *
  * For m=0 the output is forced to 0 (reciprocal = exact 1.0).
  */
class BF16Inverter16 extends Module {
  val io = IO(new Bundle {
    val in  = Input(UInt(7.W))
    val out = Output(UInt(8.W))
  })

  val tableL = Module(new BF16LookupL16)
  val tableJ = Module(new BF16LookupJ16)

  val addr   = io.in(6, 3)
  val offset = io.in(2, 0)

  tableL.io.addr := addr
  tableJ.io.addr := addr

  // Combinational: J[addr] × δ  (max 15×7 = 105, fits in 7 bits)
  val jTimesOff = tableJ.io.out * offset

  // Pipeline register aligned with tableL's internal RegNext
  val jxReg = RegNext(jTimesOff, 0.U)
  val inReg = RegNext(io.in, 0.U(7.W))

  // Stage 1: L[addr] − (J·δ)>>3   (integer divide-by-8 for the 3-bit sub-interval)
  val recipFull = tableL.io.out - (jxReg >> 3)   // 9-bit

  // m=0 → output 0 (exact 1.0, no exponent correction)
  // m≠0 → recipFull(7,0) always has MSB=1 (values 129-255)
  io.out := Mux(inReg === 0.U, 0.U(8.W), recipFull(7, 0))
}

/** BF16 Divider using 16-entry LUTs — same interface & latency as BF16Div. */
class BF16DivSmall extends Module {
  val io = IO(new Bundle {
    val in1 = Input(UInt(16.W))
    val in2 = Input(UInt(16.W))
    val out = Output(UInt(16.W))
  })

  // --- Special case detection ---
  val a_wrap = new BF16Wrapper(io.in1)
  val b_wrap = new BF16Wrapper(io.in2)

  val resultSign = a_wrap.sign ^ b_wrap.sign

  val specialNaN  = a_wrap.isNaN || b_wrap.isNaN ||
                    (a_wrap.isInf && b_wrap.isInf) || (a_wrap.zero && b_wrap.zero)
  val specialInf  = (a_wrap.isInf && !b_wrap.isInf && !b_wrap.isNaN) ||
                    (!a_wrap.isNaN && !a_wrap.zero && b_wrap.zero)
  val specialZero = (a_wrap.zero && !b_wrap.zero && !b_wrap.isNaN) ||
                    (!a_wrap.isNaN && !a_wrap.isInf && b_wrap.isInf)
  val isSpecial   = specialNaN || specialInf || specialZero

  val canonicalNaN  = "h7FC0".U(16.W)
  val specialResult = Wire(UInt(16.W))
  specialResult := Mux(specialNaN, canonicalNaN,
                   Mux(specialInf, Cat(resultSign, "hFF".U(8.W), 0.U(7.W)),
                                   Cat(resultSign, 0.U(15.W))))

  // --- 16-entry inverter (1-cycle internal pipeline) ---
  val inverter = Module(new BF16Inverter16)
  inverter.io.in := io.in2(6, 0)

  // Alignment registers (match inverter's 1-cycle latency)
  val in1Reg      = RegNext(io.in1, 0.U)
  val in2ExpReg   = RegNext(io.in2(14, 7), 0.U)
  val in2SignReg  = RegNext(io.in2(15), 0.U)
  val specialReg0 = RegNext(isSpecial, false.B)
  val specResReg0 = RegNext(specialResult, 0.U)

  // Reconstruct reciprocal BF16
  val invMant   = inverter.io.out
  val negExpTmp = 254.U(9.W) - in2ExpReg
  val negExp    = Mux(invMant === 0.U, negExpTmp, negExpTmp - 1.U)(7, 0)
  val recipBF16 = Cat(in2SignReg, negExp, invMant(6, 0))

  // --- Multiplier (1 internal RegNext + combinational output) ---
  val multiplier = Module(new BF16Mult)
  multiplier.io.a := in1Reg
  multiplier.io.b := recipBF16

  // Delay special flags through multiplier's 1 register stage
  val specialReg1 = RegNext(specialReg0, false.B)
  val specResReg1 = RegNext(specResReg0, 0.U)
  // io.out := Mux(specialReg1, specResReg1, multiplier.io.res)

  //------suggestion from deepseek------//
  val specialReg2 = RegNext(specialReg1, false.B)
  val specResReg2 = RegNext(specResReg1, 0.U)
  io.out := Mux(specialReg2, specResReg2, multiplier.io.res)
  //------suggestion from deepseek------//

}

/** 16-entry variant that outputs operands for an external multiplier. */
class BF16DivSmallToMul extends Module {
  val io = IO(new Bundle {
    val in1  = Input(UInt(16.W))
    val in2  = Input(UInt(16.W))
    val mulA = Output(UInt(16.W))
    val mulB = Output(UInt(16.W))
  })

  val inverter = Module(new BF16Inverter16)
  inverter.io.in := io.in2(6, 0)

  val in1Reg     = RegNext(io.in1, 0.U)
  val in2ExpReg  = RegNext(io.in2(14, 7), 0.U)
  val in2SignReg = RegNext(io.in2(15), 0.U)

  val invMant   = inverter.io.out
  val negExpTmp = 254.U(9.W) - in2ExpReg
  val negExp    = Mux(invMant === 0.U, negExpTmp, negExpTmp - 1.U)(7, 0)

  io.mulA := in1Reg
  io.mulB := Cat(in2SignReg, negExp, invMant(6, 0))
}

class BFDiv16 extends BF16Div() {}

// object GenerateRTL extends App {
//   
//   (new ChiselStage).emitVerilog(new BF16Div, Array("--target-dir", "generated"))
//   (new ChiselStage).emitVerilog(new BF16DivSmall, Array("--target-dir", "generated"))
// }



// object GenerateRTL extends App {
//   (new ChiselStage).emitVerilog(new BF16Div, Array("--target-dir", "generated"))
//   (new ChiselStage).emitVerilog(new BF16DivSmall, Array("--target-dir", "generated"))
// }