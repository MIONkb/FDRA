package tram.fpu

import chisel3._
import chisel3.util._
import tram.common.CompileMacroVar._
import tram.fpu.FPU._

class VarSizeAdder(val size1: Int, val size2: Int, val size3: Int) extends Module {
  val io = IO(new Bundle {
    val in1 = Input(UInt(size1.W))
    val in2 = Input(UInt(size2.W))
    val out = Output(UInt(size3.W))
  })
  
  io.out := (io.in1 + io.in2)(size1 - 1, size1 - size3)
}

class VarSizeSub(val size1: Int, val size2: Int, val size3: Int) extends Module {
  val io = IO(new Bundle {
    val in1 = Input(UInt(size1.W))
    val in2 = Input(UInt(size2.W))
    val out = Output(UInt(size3.W))
  })
  
  io.out := io.in1 + io.in2
}

class VarSizeMul(val size1: Int, val size2: Int, val size3: Int) extends Module {
  val io = IO(new Bundle {
    val in1 = Input(UInt(size1.W))
    val in2 = Input(UInt(size2.W))
    val out = Output(UInt(size3.W))
  })

  val result = Wire(UInt((size1 + size2).W))
  result := io.in1 * io.in2
  io.out := result(size1 + size2 - 1, size1 + size2 - size3)
}

class mul2(val size1: Int, val size2: Int, val size3: Int) extends Module {
  val io = IO(new Bundle {
    val in1 = Input(UInt(size1.W))
    val in2 = Input(UInt(size2.W))
    val out = Output(UInt(size3.W))
  })

  val result = Wire(UInt((size1 + size2).W))
  result := io.in1 * io.in2
  io.out := result(size1 + size2 - 1, size1 + size2 - size3)
}

class mul3(val size1: Int, val size2: Int, val size3: Int) extends Module {
  val io = IO(new Bundle {
    val in1 = Input(UInt(size1.W))
    val in2 = Input(UInt(size2.W))
    val out = Output(UInt(size3.W))
  })

  val result = Wire(UInt((size1 + size2).W))
  result := io.in1 * io.in2
  io.out := result(size1 + size2 - 1, size1 + size2 - size3)
}

class lookupL extends Module {
  val io = IO(new Bundle {
    val addr = Input(UInt(6.W))
    val out = Output(UInt(27.W))
  })

  val coeffL = VecInit(
    "b000000000000000000000000000".U(27.W), "b111111000000111111000000111".U(27.W),
    "b111110000011111000001111100".U(27.W), "b111101001000100110001101010".U(27.W),
    "b111100001111000011110000111".U(27.W), "b111011010111001100000011101".U(27.W),
    "b111010100000111010100000111".U(27.W), "b111001101100001010110100010".U(27.W),
    "b111000111000111000111000111".U(27.W), "b111000000111000000111000000".U(27.W),
    "b110111010110011111001000101".U(27.W), "b110110100111010000001101101".U(27.W),
    "b110101111001010000110101111".U(27.W), "b110101001100011101111011000".U(27.W),
    "b110100100000110100100000110".U(27.W), "b110011110110010001110100101".U(27.W),
    "b110011001100110011001100110".U(27.W), "b110010100100010110000111111".U(27.W),
    "b110001111100111000001100011".U(27.W), "b110001010110010111001000011".U(27.W),
    "b110000110000110000110000110".U(27.W), "b110000001100000011000000110".U(27.W),
    "b101111101000001011111010000".U(27.W), "b101111000101001001100100000".U(27.W),
    "b101110100010111010001011101".U(27.W), "b101110000001011100000010111".U(27.W),
    "b101101100000101101100000101".U(27.W), "b101101000000101101000000101".U(27.W),
    "b101100100001011001000010110".U(27.W), "b101100000010110000001011000".U(27.W),
    "b101011100100110001000001010".U(27.W), "b101011000111011010010001100".U(27.W),
    "b101010101010101010101010101".U(27.W), "b101010001110100000111111010".U(27.W),
    "b101001110010111100000101001".U(27.W), "b101001010111111010110101000".U(27.W),
    "b101000111101011100001010001".U(27.W), "b101000100011011111000011001".U(27.W),
    "b101000001010000010100000101".U(27.W), "b100111110001000101100101111".U(27.W),
    "b100111011000100111011000100".U(27.W), "b100111000000100111000000100".U(27.W),
    "b100110101001000011100111110".U(27.W), "b100110010001111100011010010".U(27.W),
    "b100101111011010000100101111".U(27.W), "b100101100100111111011010011".U(27.W),
    "b100101001111001000001001010".U(27.W), "b100100111001101010000101110".U(27.W),
    "b100100100100100100100100100".U(27.W), "b100100001111110110111100000".U(27.W),
    "b100011111011100000100011111".U(27.W), "b100011100111100000110101011".U(27.W),
    "b100011010011110111001011000".U(27.W), "b100011000000100011000000100".U(27.W),
    "b100010101101100011110010111".U(27.W), "b100010011010111001000000100".U(27.W),
    "b100010001000100010001000100".U(27.W), "b100001110110011110101011010".U(27.W),
    "b100001100100101110001010011".U(27.W), "b100001010011010000001000010".U(27.W),
    "b100001000010000100001000010".U(27.W), "b100000110001001001101110100".U(27.W),
    "b100000100000100000100000100".U(27.W), "b100000010000001000000100000".U(27.W)
  )

  val data = RegNext(coeffL(io.addr))
  io.out := data
}

class lookupJ extends Module {
  val io = IO(new Bundle {
    val addr = Input(UInt(6.W))
    val out = Output(UInt(23.W))
  })

  val coeffJ = VecInit(
    "b00000011111111111110000".U(23.W), "b00000011111000001001111".U(23.W),
    "b00000011110000101100010".U(23.W), "b00000011101001100011111".U(23.W),
    "b00000011100010101111101".U(23.W), "b00000011011100001110000".U(23.W),
    "b00000011010101111110010".U(23.W), "b00000011001111111111010".U(23.W),
    "b00000011001010010000001".U(23.W), "b00000011000100101111111".U(23.W),
    "b00000010111111011101111".U(23.W), "b00000010111010011001011".U(23.W),
    "b00000010110101100001100".U(23.W), "b00000010110000110101110".U(23.W),
    "b00000010101100010101011".U(23.W), "b00000010101000000000000".U(23.W),
    "b00000010100011110100111".U(23.W), "b00000010011111110011101".U(23.W),
    "b00000010011011111011110".U(23.W), "b00000010011000001100110".U(23.W),
    "b00000010010100100110001".U(23.W), "b00000010010001000111110".U(23.W),
    "b00000010001101110001000".U(23.W), "b00000010001010100001101".U(23.W),
    "b00000010000111011001010".U(23.W), "b00000010000100010111101".U(23.W),
    "b00000010000001011100100".U(23.W), "b00000001111110100111011".U(23.W),
    "b00000001111011111000010".U(23.W), "b00000001111001001110101".U(23.W),
    "b00000001110110101010100".U(23.W), "b00000001110100001011011".U(23.W),
    "b00000001110001110001011".U(23.W), "b00000001101111011100000".U(23.W),
    "b00000001101101001011001".U(23.W), "b00000001101010111110110".U(23.W),
    "b00000001101000110110100".U(23.W), "b00000001100110110010010".U(23.W),
    "b00000001100100110001111".U(23.W), "b00000001100010110101010".U(23.W),
    "b00000001100000111100010".U(23.W), "b00000001011111000110101".U(23.W),
    "b00000001011101010100011".U(23.W), "b00000001011011100101010".U(23.W),
    "b00000001011001111001010".U(23.W), "b00000001011000010000001".U(23.W),
    "b00000001010110101001111".U(23.W), "b00000001010101000110011".U(23.W),
    "b00000001010011100101101".U(23.W), "b00000001010010000111011".U(23.W),
    "b00000001010000101011100".U(23.W), "b00000001001111010010001".U(23.W),
    "b00000001001101111011000".U(23.W), "b00000001001100100110001".U(23.W),
    "b00000001001011010011011".U(23.W), "b00000001001010000010110".U(23.W),
    "b00000001001000110100001".U(23.W), "b00000001000111100111011".U(23.W),
    "b00000001000110011100101".U(23.W), "b00000001000101010011101".U(23.W),
    "b00000001000100001100011".U(23.W), "b00000001000011000110110".U(23.W),
    "b00000001000010000010111".U(23.W), "b00000001000001000000101".U(23.W)
  )

  io.out := coeffJ(io.addr)
}

class lookupC extends Module {
  val io = IO(new Bundle {
    val addr = Input(UInt(6.W))
    val out = Output(UInt(24.W))
  })

  val coeffC = VecInit(
    "b000000000000111110100001".U(24.W), "b000000000000111011101101".U(24.W),
    "b000000000000111001000011".U(24.W), "b000000000000110110100011".U(24.W),
    "b000000000000110100001100".U(24.W), "b000000000000110001111110".U(24.W),
    "b000000000000101111111000".U(24.W), "b000000000000101101111001".U(24.W),
    "b000000000000101100000001".U(24.W), "b000000000000101010010000".U(24.W),
    "b000000000000101000100100".U(24.W), "b000000000000100110111111".U(24.W),
    "b000000000000100101011110".U(24.W), "b000000000000100100000010".U(24.W),
    "b000000000000100010101011".U(24.W), "b000000000000100001011001".U(24.W),
    "b000000000000100000001010".U(24.W), "b000000000000011110111111".U(24.W),
    "b000000000000011101111000".U(24.W), "b000000000000011100110100".U(24.W),
    "b000000000000011011110011".U(24.W), "b000000000000011010110101".U(24.W),
    "b000000000000011001111011".U(24.W), "b000000000000011001000010".U(24.W),
    "b000000000000011000001101".U(24.W), "b000000000000010111011001".U(24.W),
    "b000000000000010110101000".U(24.W), "b000000000000010101111001".U(24.W),
    "b000000000000010101001100".U(24.W), "b000000000000010100100001".U(24.W),
    "b000000000000010011111000".U(24.W), "b000000000000010011010000".U(24.W),
    "b000000000000010010101010".U(24.W), "b000000000000010010000110".U(24.W),
    "b000000000000010001100011".U(24.W), "b000000000000010001000010".U(24.W),
    "b000000000000010000100001".U(24.W), "b000000000000010000000010".U(24.W),
    "b000000000000001111100101".U(24.W), "b000000000000001111001000".U(24.W),
    "b000000000000001110101100".U(24.W), "b000000000000001110010010".U(24.W),
    "b000000000000001101111000".U(24.W), "b000000000000001101100000".U(24.W),
    "b000000000000001101001000".U(24.W), "b000000000000001100110001".U(24.W),
    "b000000000000001100011011".U(24.W), "b000000000000001100000110".U(24.W),
    "b000000000000001011110010".U(24.W), "b000000000000001011011110".U(24.W),
    "b000000000000001011001011".U(24.W), "b000000000000001010111000".U(24.W),
    "b000000000000001010100111".U(24.W), "b000000000000001010010101".U(24.W),
    "b000000000000001010000101".U(24.W), "b000000000000001001110101".U(24.W),
    "b000000000000001001100101".U(24.W), "b000000000000001001010110".U(24.W),
    "b000000000000001001001000".U(24.W), "b000000000000001000111010".U(24.W),
    "b000000000000001000101100".U(24.W), "b000000000000001000011111".U(24.W),
    "b000000000000001000010010".U(24.W), "b000000000000001000000110".U(24.W)
  )

  io.out := coeffC(io.addr)
}

class FloatWrapper(val num: UInt) {
  val (sign, exponent, mantissa, zero) = num.getWidth match {
    case 32 => (
      num(31),
      num(30, 23),
      Cat(Mux(num(30, 23) === 0.U, 0.U(1.W), 1.U(1.W)), num(22, 0)),
      num(30, 0) === 0.U
    )
    case 64 => (
      num(63),
      num(62, 52),
      Cat(Mux(num(62, 52) === 0.U, 0.U(1.W), 1.U(1.W)), num(51, 0)),
      num(62, 0) === 0.U
    )
  }
}

class fpInverter(val w: Int) extends Module {
  val io = IO(new Bundle {
    val in1 = Input(UInt(w.W))
    val out = Output(UInt((w + 1).W))
  })

  val tableC = Module(new lookupC())
  val tableL = Module(new lookupL())
  val tableJ = Module(new lookupJ())
  
  val coeffAddr = io.in1(w - 1, w - 6)
  tableC.io.addr := coeffAddr
  tableL.io.addr := coeffAddr
  tableJ.io.addr := coeffAddr

  val sub1 = (~io.in1(22, 0)).asUInt + 1.U

  val mul1 = Module(new VarSizeMul(23, 17, 24))
  mul1.io.in1 := tableJ.io.out
  mul1.io.in2 := io.in1(w - 7, 0)

  val mul2 = Module(new mul2(24, 17, 29))
  mul2.io.in1 := tableC.io.out
  mul2.io.in2 := (io.in1(w - 7, 0) * io.in1(w - 7, 0))(33, 17)

  val w_sub1_reg = RegNext(sub1, 0.U)
  val w_mul1_reg = RegNext(mul1.io.out, 0.U)
  val w_mul2_reg = RegNext(mul2.io.out, 0.U)

  val tableL_out_reg = RegNext(tableL.io.out, 0.U)
  val sub1_out_reg1 = RegNext(w_sub1_reg, 0.U)
  val mul1_out_reg = RegNext(w_mul1_reg, 0.U)
  val mul2_out_reg = RegNext(w_mul2_reg, 0.U)

  val sub2 = Module(new VarSizeSub(27, 27, 27))
  val sub2_in2 = (~mul1_out_reg).asUInt + 1.U
  val temp3 = Cat(sub2_in2, 0.U(1.W))
  val temp4 = Cat(temp3, 0.U(1.W))
  sub2.io.in2 := Cat(temp4, 0.U(1.W))
  sub2.io.in1 := tableL_out_reg

  val adder = Module(new VarSizeAdder(29, 29, 25))
  val temp1 = Cat(sub2.io.out, 0.U(1.W))
  val temp2 = Cat(temp1, 0.U(1.W))
  adder.io.in1 := temp2
  adder.io.in2 := mul2_out_reg

  val sub1_out_reg2 = RegNext(sub1_out_reg1, 0.U)
  val adder_out_reg = RegNext(adder.io.out, 0.U)

  val mul3 = Module(new mul3(w, 25, 24))
  mul3.io.in1 := sub1_out_reg2
  mul3.io.in2 := adder_out_reg

  io.out := mul3.io.out
}

class MantissaRounder(val n: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(n.W))
    val out = Output(UInt((n - 1).W))
  })

  io.out := io.in(n - 1, 1)
}

class FPMult(val n: Int) extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(n.W))
    val b = Input(UInt(n.W))
    val res = Output(UInt(n.W))
  })

  val a_wrap = new FloatWrapper(io.a)
  val b_wrap = new FloatWrapper(io.b)

  val stage1_sign = a_wrap.sign ^ b_wrap.sign
  val stage1_exponent = a_wrap.exponent + b_wrap.exponent
  val stage1_mantissa = a_wrap.mantissa * b_wrap.mantissa
  val stage1_zero = a_wrap.zero || b_wrap.zero

  val sign_reg = RegNext(stage1_sign)
  val exponent_reg = RegNext(stage1_exponent)
  val mantissa_reg = RegNext(stage1_mantissa)
  val zero_reg = RegNext(stage1_zero)

  val stage2_sign = sign_reg
  val stage2_exponent = Wire(UInt())
  val stage2_mantissa = Wire(UInt())

  val (mantissaLead, mantissaSize, exponentSize, exponentSub) = n match {
    case 32 => (47, 23, 8, 127)
    case 64 => (105, 52, 11, 1023)
  }

  val rounder = Module(new MantissaRounder(mantissaSize + 1))
  
  when(zero_reg) {
    stage2_exponent := 0.U(exponentSize.W)
    rounder.io.in := 0.U((mantissaSize + 1).W)
  }.elsewhen(mantissa_reg(mantissaLead) === 1.U) {
    stage2_exponent := exponent_reg - (exponentSub - 1).U
    rounder.io.in := mantissa_reg(mantissaLead - 1, mantissaLead - mantissaSize - 1)
  }.otherwise {
    stage2_exponent := exponent_reg - exponentSub.U
    rounder.io.in := mantissa_reg(mantissaLead - 2, mantissaLead - mantissaSize - 2)
  }

  stage2_mantissa := rounder.io.out

  io.res := Cat(stage2_sign.asUInt, stage2_exponent.asUInt, stage2_mantissa.asUInt)
}

class fpDivWithInvert(val w: Int) extends Module {
  val io = IO(new Bundle {
    val in1 = Input(UInt(w.W))
    val in2 = Input(UInt(w.W))
    val out = Output(UInt(w.W))
  })

  val inverter = Module(new fpInverter(23))
  val multiplier = Module(new FPMult(w))

  inverter.io.in1 := io.in2(22, 0)

  val in1Reg0 = RegNext(io.in1, 0.U)
  val in1Reg1 = RegNext(in1Reg0, 0.U)
  val in1Reg2 = RegNext(in1Reg1, 0.U)
  val in1Reg3 = RegNext(in1Reg2, 0.U)

  val in2ExpReg0 = RegNext(io.in2(30, 23), 0.U)
  val in2SignReg0 = RegNext(io.in2(31), 0.U)
  val in2ExpReg1 = RegNext(in2ExpReg0, 0.U)
  val in2SignReg1 = RegNext(in2SignReg0, 0.U)
  val in2ExpReg2 = RegNext(in2ExpReg1, 0.U)
  val in2SignReg2 = RegNext(in2SignReg1, 0.U)
  val in2ExpReg3 = RegNext(in2ExpReg2, 0.U)
  val in2SignReg3 = RegNext(in2SignReg2, 0.U)
  val invMantReg = RegNext(inverter.io.out(23, 0), 0.U)

  val invMant = invMantReg
  val negExpTmp = 254.U - in2ExpReg3
  val negExp = Mux(invMant === 0.U, negExpTmp, negExpTmp - 1.U)

  multiplier.io.a := in1Reg3
  multiplier.io.b := Cat(in2SignReg3, negExp, invMant(23, 1))
  
  io.out := multiplier.io.res
}

class FPDiv32 extends fpDivWithInvert(32) {}


/**
  * FDIV32 "pre" stage for shared-multiplier reuse.
  *
  * It computes the reciprocal-based operand preparation (inverter + exponent/sign fixup),
  * and outputs the two fp32 operands to be consumed by an external/shared `FPMult32`.
  *
  * Total FDIV latency = this module's internal pipeline (3) + `FPMult32` latency (3) = 6.
  */
class FPDiv32ToMul extends Module {
  val io = IO(new Bundle {
    val in1 = Input(UInt(32.W)) // dividend
    val in2 = Input(UInt(32.W)) // divisor
    val mulA = Output(UInt(32.W))
    val mulB = Output(UInt(32.W))
  })

  val inverter = Module(new fpInverter(23))
  inverter.io.in1 := io.in2(22, 0)

  // delay dividend due to inverter pipeline
  val in1Reg0 = RegNext(io.in1, 0.U)
  val in1Reg1 = RegNext(in1Reg0, 0.U)
  val in1Reg2 = RegNext(in1Reg1, 0.U)
  val in1Reg3 = RegNext(in1Reg2, 0.U)

  // delay divisor exponent/sign to match inverter pipeline
  val in2ExpReg0 = RegNext(io.in2(30, 23), 0.U)
  val in2SignReg0 = RegNext(io.in2(31), 0.U)
  val in2ExpReg1 = RegNext(in2ExpReg0, 0.U)
  val in2SignReg1 = RegNext(in2SignReg0, 0.U)
  val in2ExpReg2 = RegNext(in2ExpReg1, 0.U)
  val in2SignReg2 = RegNext(in2SignReg1, 0.U)
  val in2ExpReg3 = RegNext(in2ExpReg2, 0.U)
  val in2SignReg3 = RegNext(in2SignReg2, 0.U)

  val invMantReg = RegNext(inverter.io.out(23, 0), 0.U)

  val invMant = invMantReg
  val negExpTmp = 254.U - in2ExpReg3
  val negExp = Mux(invMant === 0.U, negExpTmp, negExpTmp - 1.U)

  io.mulA := in1Reg3
  io.mulB := Cat(in2SignReg3, negExp, invMant(23, 1))
}







// import chisel3._
// import chisel3.util._
// import tram.common.CompileMacroVar._
// import tram.fpu.FPU._


// class VarSizeAdder(val size1 : Int, val size2 : Int, val size3 : Int) extends Module {
// // tested and works fine

// 	val io = IO(new Bundle{
// 		val in1 = Input(UInt(size1.W))
// 		val in2 = Input(UInt(size2.W))
// 		val out = Output(UInt(size3.W))
// 	})
// 	//io.out := io.in1 + io.in2 //this takes ls bits whereas we want ms bits
// 	io.out := (io.in1 + io.in2)(size1 - 1, size1 - size3)
// 	//printf("Adder in1: %d , in2: %d out: %d\n", io.in1, io.in2, io.in1 + io.in2)
// }

// class VarSizeSub(val size1 : Int, val size2 : Int, val size3 : Int) extends Module {
// // tested and works fine

// 	val io = IO(new Bundle{
// 		val in1 = Input(UInt(size1.W))
// 		val in2 = Input(UInt(size2.W))
// 		val out = Output(UInt(size3.W))
// 	})
// 	//io.out := Cat((io.in1 + io.in2)(size1 - 1 , 0), "b00".U)
// 	io.out := (io.in1 + io.in2)
// //	printf("Adder in1: %d , in2: %d out: %d\n", io.in1, io.in2, io.out)
// }

// class VarSizeMul(val size1 : Int, val size2 : Int, val size3 : Int) extends Module {
// 	val io = IO(new Bundle{
// 		val in1 = Input(UInt(size1.W))
// 		val in2 = Input(UInt(size2.W))
// 		val out = Output(UInt(size3.W))
// 	})

// 	val result  = Wire(UInt((size1 + size2).W))
	
// 	result := io.in1 * io.in2
// 	//io.out := result(size1 + size2 - 3, size1 + size2 - size3-2 )
// 	io.out := result(size1 + size2 - 1, size1 + size2 - size3 )
// 	//printf("mult in1: %d , in2: %d out: %d\n", io.in1, io.in2, io.out)
// }

// class mul2(val size1 : Int, val size2 : Int, val size3 : Int) extends Module {
// 	val io = IO(new Bundle{
// 		val in1 = Input(UInt(size1.W))
// 		val in2 = Input(UInt(size2.W))
// 		val out = Output(UInt(size3.W))
// 	})

// 	val result  = Wire(UInt((size1 + size2).W))
	
// 	result := io.in1 * io.in2
// 	io.out := result(size1 + size2 - 1, size1 + size2 - size3 )
// 	//io.out := result(size1 + size2 - 1, size1 + size2 - size3 )
// 	//printf("mult in1: %d , in2: %d out: %d\n", io.in1, io.in2, io.in1 * io.in2)
// }

// class mul3(val size1 : Int, val size2 : Int, val size3 : Int) extends Module {
// 	val io = IO(new Bundle{
// 		val in1 = Input(UInt(size1.W))
// 		val in2 = Input(UInt(size2.W))
// 		val out = Output(UInt(size3.W))
// 	})

// 	val result  = Wire(UInt((size1 + size2).W))
	
// 	result := io.in1 * io.in2
// 	io.out := result(size1 + size2 - 1, size1 + size2 - size3 )
// 	//io.out := result(size1 + size2 - 1, size1 + size2 - size3 )
// 	//printf("mult in1: %d , in2: %d out: %d\n", io.in1, io.in2, io.out)
// }

// class lookupL() extends Module {
// 	val io = IO(new Bundle{

// 		val addr = Input(UInt(6.W))
// 		val out  = Output(UInt(27.W))
// 	})

// 	//Let's prepare the lookup tables
// 	val coeffL = Vec(
// 		UInt("b000000000000000000000000000"), UInt("b111111000000111111000000111"), 
// 		UInt("b111110000011111000001111100"), UInt("b111101001000100110001101010"),
// 		UInt("b111100001111000011110000111"), UInt("b111011010111001100000011101"),
// 		UInt("b111010100000111010100000111"), UInt("b111001101100001010110100010"),
// 		UInt("b111000111000111000111000111"), UInt("b111000000111000000111000000"),
// 		UInt("b110111010110011111001000101"), UInt("b110110100111010000001101101"),
// 		UInt("b110101111001010000110101111"), UInt("b110101001100011101111011000"),
// 		UInt("b110100100000110100100000110"), UInt("b110011110110010001110100101"),

// 		UInt("b110011001100110011001100110"), UInt("b110010100100010110000111111"),
// 		UInt("b110001111100111000001100011"), UInt("b110001010110010111001000011"),
// 		UInt("b110000110000110000110000110"), UInt("b110000001100000011000000110"),
// 		UInt("b101111101000001011111010000"), UInt("b101111000101001001100100000"),
// 		UInt("b101110100010111010001011101"), UInt("b101110000001011100000010111"),
// 		UInt("b101101100000101101100000101"), UInt("b101101000000101101000000101"),
// 		UInt("b101100100001011001000010110"), UInt("b101100000010110000001011000"),
// 		UInt("b101011100100110001000001010"), UInt("b101011000111011010010001100"),

// 		UInt("b101010101010101010101010101"), UInt("b101010001110100000111111010"),
// 		UInt("b101001110010111100000101001"), UInt("b101001010111111010110101000"),
// 		UInt("b101000111101011100001010001"), UInt("b101000100011011111000011001"),
// 		UInt("b101000001010000010100000101"), UInt("b100111110001000101100101111"),
// 		UInt("b100111011000100111011000100"), UInt("b100111000000100111000000100"),
// 		UInt("b100110101001000011100111110"), UInt("b100110010001111100011010010"),
// 		UInt("b100101111011010000100101111"), UInt("b100101100100111111011010011"),
// 		UInt("b100101001111001000001001010"), UInt("b100100111001101010000101110"),

// 		UInt("b100100100100100100100100100"), UInt("b100100001111110110111100000"),
// 		UInt("b100011111011100000100011111"), UInt("b100011100111100000110101011"),
// 		UInt("b100011010011110111001011000"), UInt("b100011000000100011000000100"),
// 		UInt("b100010101101100011110010111"), UInt("b100010011010111001000000100"),
// 		UInt("b100010001000100010001000100"), UInt("b100001110110011110101011010"),
// 		UInt("b100001100100101110001010011"), UInt("b100001010011010000001000010"),
// 		UInt("b100001000010000100001000010"), UInt("b100000110001001001101110100"),
// 		UInt("b100000100000100000100000100"), UInt("b100000010000001000000100000")
// 	)

// //	val coeffL = Mem(Bits(width = 27), 64, seqRead = true)
// 	// val	data = Reg(init = coeffL(io.addr), next = coeffL(io.addr))
// 	val data = RegNext(coeffL(io.addr))
// 	io.out   := data

// }

// class lookupJ() extends Module {
// 	val io = IO(new Bundle{

// 		val addr = Input(UInt(6.W))
// 		val out  = Output(UInt(23.W))
// 	})

// 	//Let's prepare the lookup tables
// 	val coeffJ = Vec(
// 		UInt("b00000011111111111110000"), UInt("b00000011111000001001111"),
// 		UInt("b00000011110000101100010"), UInt("b00000011101001100011111"),
// 		UInt("b00000011100010101111101"), UInt("b00000011011100001110000"),
// 		UInt("b00000011010101111110010"), UInt("b00000011001111111111010"),
// 		UInt("b00000011001010010000001"), UInt("b00000011000100101111111"),
// 		UInt("b00000010111111011101111"), UInt("b00000010111010011001011"),
// 		UInt("b00000010110101100001100"), UInt("b00000010110000110101110"),
// 		UInt("b00000010101100010101011"), UInt("b00000010101000000000000"),

// 		UInt("b00000010100011110100111"), UInt("b00000010011111110011101"),
// 		UInt("b00000010011011111011110"), UInt("b00000010011000001100110"),
// 		UInt("b00000010010100100110001"), UInt("b00000010010001000111110"),
// 		UInt("b00000010001101110001000"), UInt("b00000010001010100001101"),
// 		UInt("b00000010000111011001010"), UInt("b00000010000100010111101"),
// 		UInt("b00000010000001011100100"), UInt("b00000001111110100111011"),
// 		UInt("b00000001111011111000010"), UInt("b00000001111001001110101"),
// 		UInt("b00000001110110101010100"), UInt("b00000001110100001011011"),

// 		UInt("b00000001110001110001011"), UInt("b00000001101111011100000"),
// 		UInt("b00000001101101001011001"), UInt("b00000001101010111110110"),
// 		UInt("b00000001101000110110100"), UInt("b00000001100110110010010"),
// 		UInt("b00000001100100110001111"), UInt("b00000001100010110101010"),
// 		UInt("b00000001100000111100010"), UInt("b00000001011111000110101"),
// 		UInt("b00000001011101010100011"), UInt("b00000001011011100101010"),
// 		UInt("b00000001011001111001010"), UInt("b00000001011000010000001"),
// 		UInt("b00000001010110101001111"), UInt("b00000001010101000110011"),

// 		UInt("b00000001010011100101101"), UInt("b00000001010010000111011"),
// 		UInt("b00000001010000101011100"), UInt("b00000001001111010010001"),
// 		UInt("b00000001001101111011000"), UInt("b00000001001100100110001"),
// 		UInt("b00000001001011010011011"), UInt("b00000001001010000010110"),
// 		UInt("b00000001001000110100001"), UInt("b00000001000111100111011"),
// 		UInt("b00000001000110011100101"), UInt("b00000001000101010011101"),
// 		UInt("b00000001000100001100011"), UInt("b00000001000011000110110"),
// 		UInt("b00000001000010000010111"), UInt("b00000001000001000000101")
// 	)

// 	io.out := coeffJ(io.addr)
// }

// class lookupC() extends Module {
// 	val io = IO(new Bundle{

// 		val addr = Input(UInt(6.W))
// 		val out  = Output(UInt(24.W))
// 	})

// 	//Let's prepare the lookup tables
// 	val coeffC = Vec(
// 		UInt("b000000000000111110100001"), UInt("b000000000000111011101101"),
// 		UInt("b000000000000111001000011"), UInt("b000000000000110110100011"),
// 		UInt("b000000000000110100001100"), UInt("b000000000000110001111110"),
// 		UInt("b000000000000101111111000"), UInt("b000000000000101101111001"),
// 		UInt("b000000000000101100000001"), UInt("b000000000000101010010000"),
// 		UInt("b000000000000101000100100"), UInt("b000000000000100110111111"),
// 		UInt("b000000000000100101011110"), UInt("b000000000000100100000010"),
// 		UInt("b000000000000100010101011"), UInt("b000000000000100001011001"),

// 		UInt("b000000000000100000001010"), UInt("b000000000000011110111111"),
// 		UInt("b000000000000011101111000"), UInt("b000000000000011100110100"),
// 		UInt("b000000000000011011110011"), UInt("b000000000000011010110101"),
// 		UInt("b000000000000011001111011"), UInt("b000000000000011001000010"),
// 		UInt("b000000000000011000001101"), UInt("b000000000000010111011001"),
// 		UInt("b000000000000010110101000"), UInt("b000000000000010101111001"),
// 		UInt("b000000000000010101001100"), UInt("b000000000000010100100001"),
// 		UInt("b000000000000010011111000"), UInt("b000000000000010011010000"),

// 		UInt("b000000000000010010101010"), UInt("b000000000000010010000110"),
// 		UInt("b000000000000010001100011"), UInt("b000000000000010001000010"),
// 		UInt("b000000000000010000100001"), UInt("b000000000000010000000010"),
// 		UInt("b000000000000001111100101"), UInt("b000000000000001111001000"),
// 		UInt("b000000000000001110101100"), UInt("b000000000000001110010010"),
// 		UInt("b000000000000001101111000"), UInt("b000000000000001101100000"),
// 		UInt("b000000000000001101001000"), UInt("b000000000000001100110001"),
// 		UInt("b000000000000001100011011"), UInt("b000000000000001100000110"),

// 		UInt("b000000000000001011110010"), UInt("b000000000000001011011110"),
// 		UInt("b000000000000001011001011"), UInt("b000000000000001010111000"),
// 		UInt("b000000000000001010100111"), UInt("b000000000000001010010101"),
// 		UInt("b000000000000001010000101"), UInt("b000000000000001001110101"),
// 		UInt("b000000000000001001100101"), UInt("b000000000000001001010110"),
// 		UInt("b000000000000001001001000"), UInt("b000000000000001000111010"),
// 		UInt("b000000000000001000101100"), UInt("b000000000000001000011111"),
// 		UInt("b000000000000001000010010"), UInt("b000000000000001000000110")
// 	)

// 	io.out := coeffC(io.addr)
// }

// class FloatWrapper(val num: Bits) {
//     val (sign, exponent, mantissa, zero) = num.getWidth match {
//         case 32 => (num(31).toBool(),
//                     num(30, 23).toUInt(),
//                     // if the exponent is 0
//                     // this is a denormalized number
//                     Cat(Mux(num(30, 23) === Bits(0),
//                             Bits(0, 1), Bits(1, 1)),
//                         num(22, 0).toUInt()),
//                     num(30, 0) === Bits(0))
//         case 64 => (num(63).toBool(),
//                     num(62, 52).toUInt(),
//                     Cat(Mux(num(62, 52) === Bits(0),
//                             Bits(0, 1), Bits(1, 1)),
//                         num(51, 0).toUInt()),
//                     num(62, 0) === Bits(0))
//     }
// }

// class fpInverter(val w : Int) extends Module {
// 	val io = IO(new Bundle{
// 		val in1 = Input(UInt(w.W))
// 		val out = Output(UInt((w + 1).W))

// 	})

// 	// instantiate lookup tables
// 	val tableC = Module(new lookupC())
// 	val tableL = Module(new lookupL())
// 	val tableJ = Module(new lookupJ())
	
// 	// Most significant 9 bits of the input (mantissa) is used as address
// 	// to the coefficient lookup tables
// 	val coeffAddr   = io.in1(w - 1, w - 6)
// 	tableC.io.addr := coeffAddr
// 	tableL.io.addr := coeffAddr
// 	tableJ.io.addr := coeffAddr

// 	val sub1 = (io.in1 ^ "b11111111111111111111111".U) + 1.U

// 	val mul1 = Module(new VarSizeMul(23, 17, 24))
// 	mul1.io.in1 := tableJ.io.out
// 	mul1.io.in2 := io.in1(w - 7, 0)
// 	// result will be input to adder1

// 	val mul2 = Module(new mul2(24, 17, 29)) 
// 	mul2.io.in1 := tableC.io.out
// 	mul2.io.in2 := (io.in1(w - 7, 0) * io.in1(w - 7, 0))(33, 17)
// 	// result will be input to sub2

// 	// workaround registers (sub1 reg, mul1 reg and mul2 reg does not delay their input)
// 	val w_sub1_reg = Reg(init = 0.U, next = sub1)
// 	val w_mul1_reg = Reg(init = 0.U, next = mul1.io.out)
// 	val w_mul2_reg = Reg(init = 0.U, next = mul2.io.out)
// 	//val w_tableL_reg = Reg(init = 0.U, next = tableL.io.out)
// /*
// 	// stage1 registers
// 	val tableL_out_reg = Reg(init = 0.U, next = tableL.io.out)
// 	val sub1_out_reg1  = Reg(init = 0.U, next = sub1)
// 	val mul1_out_reg   = Reg(init = 0.U, next = mul1.io.out)
// 	val mul2_out_reg   = Reg(init = 0.U, next = mul2.io.out)
// */
// 	//stage1 registers with workaround
// 	val tableL_out_reg = Reg(init = 0.U, next = tableL.io.out)
// //	val tableL_out_reg = Reg(init = 0.U, next = w_tableL_reg)
// 	val sub1_out_reg1  = Reg(init = 0.U, next = w_sub1_reg)
// 	val mul1_out_reg   = Reg(init = 0.U, next = w_mul1_reg)
// 	val mul2_out_reg   = Reg(init = 0.U, next = w_mul2_reg)


// // using sub due to the sign value of the j coefficients
// 	val sub2     = Module(new VarSizeSub(27, 27, 27))
// 	val sub2_in2 = (mul1_out_reg ^ "b111111111111111111111111".U) + 1.U
// 	val temp3    = Cat(sub2_in2, "b0".U)
// 	val temp4    = Cat(temp3, "b0".U)
// 	sub2.io.in2 := Cat(temp4, "b0".U)
// 	sub2.io.in1 := tableL_out_reg
// 	// result will be input to sub2

// //	using an adder due to the sign value of the c coefficients
// 	val adder     = Module(new VarSizeAdder(29, 29, 25))
// 	val temp1     = Cat(sub2.io.out, "b0".U)
// 	val temp2     = Cat(temp1, "b0".U)
// 	adder.io.in1 := temp2
// 	adder.io.in2 := mul2_out_reg
// 	// result will be input to mul3

// 	//stage2 registers
// 	val sub1_out_reg2 = Reg(init = 0.U, next = sub1_out_reg1)
// 	val adder_out_reg = Reg(init = 0.U, next = adder.io.out)

// 	val mul3     = Module(new mul3(w, 25, 24))
// 	mul3.io.in1 := sub1_out_reg2
// 	mul3.io.in2 := adder_out_reg

// 	//val outReg = Reg(init = UInt(0, width = w + 1), next = mul3.io.out)
// 	//io.out := outReg

// 	io.out := mul3.io.out
// }



// class MantissaRounder(val n: Int) extends Module {
//     val io = IO(new Bundle {
//         val in  = Input(UInt(n.W))
//         val out = Output(UInt((n - 1).W))
//     })

//     io.out := io.in(n - 1, 1)// + io.in(0)
// }

// class FPMult(val n: Int) extends Module {
//     val io = IO(new Bundle {
//         val a   = Input(UInt(n.W))
//         val b   = Input(UInt(n.W))
//         val res = Output(UInt(n.W))
//     })

//     val a_wrap = new FloatWrapper(io.a)
//     val b_wrap = new FloatWrapper(io.b)

//     val stage1_sign     = a_wrap.sign ^ b_wrap.sign
//     val stage1_exponent = a_wrap.exponent + b_wrap.exponent
//     val stage1_mantissa = a_wrap.mantissa * b_wrap.mantissa
//     val stage1_zero     = a_wrap.zero || b_wrap.zero

//     val sign_reg     = Reg(next = stage1_sign)
//     val exponent_reg = Reg(next = stage1_exponent)
//     val mantissa_reg = Reg(next = stage1_mantissa)
//     val zero_reg     = Reg(next = stage1_zero)

//     val stage2_sign     = sign_reg
//     val stage2_exponent = Wire(UInt(width = a_wrap.exponent.getWidth))
//     val stage2_mantissa = Wire(UInt(width = a_wrap.mantissa.getWidth - 1))

//     val (mantissaLead, mantissaSize, exponentSize, exponentSub) = n match {
//         case 32 => (47, 23, 8, 127)
//         case 64 => (105, 52, 11, 1023)
//     }

//     val rounder = Module(new MantissaRounder(mantissaSize + 1))
       
//     when (zero_reg) {
// 		stage2_exponent := UInt(0, exponentSize)
//         rounder.io.in   := UInt(0, mantissaSize + 1)
//     } .elsewhen (mantissa_reg(mantissaLead) === Bits(1)) {
//         stage2_exponent := exponent_reg - UInt(exponentSub - 1)
//         rounder.io.in   := mantissa_reg(mantissaLead - 1,
//                                       mantissaLead - mantissaSize - 1)
//     } .otherwise {
//         stage2_exponent := exponent_reg - UInt(exponentSub)
//         rounder.io.in   := mantissa_reg(mantissaLead - 2,
//                                       mantissaLead - mantissaSize - 2)
//     }

//     stage2_mantissa := rounder.io.out

//     io.res := Cat(stage2_sign.toBits(),
//                   stage2_exponent.toBits(),
//                   stage2_mantissa.toBits())
// }


// class fpDivWithInvert(val w : Int) extends Module{ //w = 32
// 	val io = IO(new Bundle{
// 		val in1  = Input(UInt(w.W))	
// 		val in2  = Input(UInt(w.W))
// 		val out  = Output(UInt(w.W))
// 	})

// 	val inverter   = Module(new fpInverter(23))
// 	val multiplier = Module(new FPMult(w))

// 	inverter.io.in1 := io.in2(22, 0)	//mantissa 
// 	// delay input1 due to the inverter
// 	val in1Reg0 = Reg(init = 0.U, next = io.in1)	// stage 0
// 	val in1Reg1 = Reg(init = 0.U, next = in1Reg0)	// stage 1
// 	val in1Reg2 = Reg(init = 0.U, next = in1Reg1)	// stage 2
// 	val in1Reg3 = Reg(init = 0.U, next = in1Reg2)	// stage 3

// 	// delay input2 exponent and sign due to the inverter
// 	val in2ExpReg0  = Reg(init = 0.U, next = io.in2(30,23))	// stage 0
// 	val in2SignReg0 = Reg(init = 0.U, next = io.in2(31))	// stage 0
// 	val in2ExpReg1  = Reg(init = 0.U, next = in2ExpReg0)	// stage 1
// 	val in2SignReg1 = Reg(init = 0.U, next = in2SignReg0)	// stage 1
// 	val in2ExpReg2  = Reg(init = 0.U, next = in2ExpReg1)	// stage 2
// 	val in2SignReg2 = Reg(init = 0.U, next = in2SignReg1)	// stage 2
// 	val in2ExpReg3  = Reg(init = 0.U, next = in2ExpReg2)	// stage 3
// 	val in2SignReg3 = Reg(init = 0.U, next = in2SignReg2)	// stage 3
// 	val invMantReg  = Reg(init = 0.U, next = inverter.io.out(23, 0)) //stage 3

// 	val invMant       = invMantReg
// 	val negExpTmp     = 254.U - in2ExpReg3
// 	val negExp        = Mux(invMant === 0.U, negExpTmp, negExpTmp - 1.U)

// 	// we should raise an execption if both mantissa and exponent are zero (the final result should be inf

// 	multiplier.io.a := in1Reg3
// 	multiplier.io.b := Cat(in2SignReg3, negExp, invMant(23, 1))
// 	// skipping msb of inverter (multiplying mantissa by 2)
	
// 	io.out := multiplier.io.res

// }

// class FPDiv32 extends fpDivWithInvert(32) {}