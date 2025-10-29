package tram

import chisel3._
import chisel3.util._
import tram.dsa.SRAMIO


/** Configuration Controller, read config data and address from SRAM and output to config bus
 * @param dataWidthSram      SRAM data width in bits
 * @param addrWidthSram      SRAM address width (+1 every data width)
 * @param hasMaskSram        if SRAM has write data byte mask
 * @param readLatencySram    SRAM read latency
 * @param cfgDataWidth       Config data width in bits
 * @param cfgAddrWidth       Config address width
 * @param cfgAddrWidthAlign  Config address width aligned to power2
 * @param cfgRegNum          Config chain register number, the last config data arrive in the last row of IOB after cfgRegNum cycles
 */
// class ConfigController(dataWidthSram: Int, addrWidthSram: Int, hasMaskSram: Boolean, readLatencySram: Int,
                      //  cfgDataWidth: Int, cfgAddrWidth: Int, cfgAddrWidthAlign: Int, cfgRegNum: Int) extends Module {
class ConfigController(dataWidthSram: Int, addrWidthSram: Int, hasMaskSram: Boolean, readLatencySram: Int,
                       cfgDataWidth: Int, cfgAddrWidth: Int, cfgAddrWidthAlign: Int, cfgRegNum: Int, waitLatency: Int = 0) extends Module {
  val io = IO(new Bundle {
    val start = Input(Bool()) // pulse signal
    val done = Output(Bool()) // config done, keep true until next start
//    val busy = Output(Bool())
    val base_addr = Input(UInt(addrWidthSram.W))
    val cfg_num = Input(UInt(cfgAddrWidth.W))
    val sram = Flipped(new SRAMIO(dataWidthSram, addrWidthSram, hasMaskSram))
    // config bus
    val cfg_en   = Output(Bool())
    val cfg_addr = Output(UInt(cfgAddrWidth.W))
    val cfg_data = Output(UInt(cfgDataWidth.W))
  })
  val cfgWidth = cfgDataWidth + cfgAddrWidthAlign // total per-entry bit-width

  // FSM
  val s_idle :: s_data :: s_wait :: Nil = Enum(3)
  val state   = RegInit(s_idle)
  val cnt     = RegInit(0.U(cfgAddrWidth.W)) // Number of emitted cfg entries
  val waitCnt = RegInit(0.U(log2Ceil(cfgRegNum + waitLatency + 1).W))
  val doneReg = RegInit(false.B)
  io.done := doneReg

  // ------------------------------
  // LSB-PACKED BIT BUFFER
  // ------------------------------

  // Capacity design:
  // Must support: one-in + one-out in same cycle + multiple in-flight reads
  private val safetyWords = 2 + readLatencySram
  private val ACC_W_raw   = cfgWidth + dataWidthSram * safetyWords
  private val ACC_W       = ((ACC_W_raw + dataWidthSram - 1) / dataWidthSram) * dataWidthSram
  println("safetyWords, dataWidthSram, ACC_W_raw, ACC_W: ",safetyWords, dataWidthSram, ACC_W_raw, ACC_W)
  require(ACC_W >= 2*cfgWidth)

  val dataReg      = RegInit(0.U(ACC_W.W)) // LSB-packed buffer storage
  val validBits    = RegInit(0.U(log2Ceil(ACC_W + 1).W)) // Valid packed bits in dataReg
  val reservedBits = RegInit(0.U(log2Ceil(ACC_W + 1).W)) // Space allocated for in-flight reads

  val freeBits = (ACC_W.U - validBits) - reservedBits
  val canPull  = (state === s_data) && (freeBits >= dataWidthSram.U)

  val sramRen = canPull
  val wen     = ShiftRegister(sramRen, readLatencySram) // read data valid
  val ren     = (validBits >= cfgWidth.U) && (cnt < io.cfg_num) // cfg output consumes cfgWidth bits

  // ------------------------------
  // FSM
  // ------------------------------
  switch(state) {
    is(s_idle) {
      when(io.start) {
        state   := s_data
        doneReg := false.B
      }
    }
    is(s_data) {
      when(cnt >= io.cfg_num) {
        state := s_wait
      }
    }
    is(s_wait) {
      when(waitCnt >= (cfgRegNum + waitLatency).U) {
        state   := s_idle
        doneReg := true.B
      }
    }
  }

  // Track number of emitted cfg entries
  when(state === s_idle) {
    cnt := 0.U
  }.elsewhen(ren) {
    cnt := cnt + 1.U
  }

  // Tail pipeline wait for config shift chain
  when(state === s_idle) {
    waitCnt := 0.U
  }.elsewhen(state === s_wait) {
    waitCnt := waitCnt + 1.U
  }

  // ------------------------------
  // LSB-PACKED READ/WRITE HANDLING
  // ------------------------------
  val incRes  = Mux(sramRen, dataWidthSram.U, 0.U)    // reserve on issue
  val decRes  = Mux(wen,     dataWidthSram.U, 0.U)    // release on return
  val incVal  = Mux(wen,     dataWidthSram.U, 0.U)    // valid grows on return
  val decVal  = Mux(ren,     cfgWidth.U,      0.U)    // valid shrinks on emit

  when (state === s_idle) {
    dataReg      := 0.U
    validBits    := 0.U
    reservedBits := 0.U
  } .otherwise {
    // dataReg update: 4-case mux,保持与你原来的优先级一致
    when (wen && ren) {
      val withNew = dataReg | (io.sram.dout << validBits)
      dataReg := (withNew >> cfgWidth.U).asUInt
    } .elsewhen (wen) {
      dataReg := dataReg | (io.sram.dout << validBits)
    } .elsewhen (ren) {
      dataReg := (dataReg >> cfgWidth.U).asUInt
    } .otherwise {
      dataReg := dataReg
    }

    // counters with net effects in one place
    validBits    := validBits + incVal - decVal
    reservedBits := reservedBits + incRes - decRes
  }

  // ------------------------------
  // SRAM interface
  // ------------------------------
  val addrSram = RegInit(0.U(addrWidthSram.W))
  when(state === s_idle) {
    addrSram := io.base_addr
  }.elsewhen(sramRen) {
    addrSram := addrSram + 1.U
  }

  io.sram.en   := sramRen
  io.sram.we   := 0.U
  io.sram.addr := addrSram
  io.sram.din  := 0.U

  // ------------------------------
  // CONFIG BUS OUTPUT
  // Lowest cfgWidth bits always represent the next ready cfg entry
  // ------------------------------
  io.cfg_en   := ren
  io.cfg_addr := dataReg(cfgWidth-1, cfgDataWidth)
  io.cfg_data := dataReg(cfgDataWidth-1, 0)

  // ------------------------------
  // SAFE-BOUNDS ASSERTIONS (recommended during simulation)
  // ------------------------------
  assert(validBits    <= ACC_W.U)
  assert(reservedBits <= ACC_W.U)
  assert((validBits + reservedBits) <= ACC_W.U,
    "dataReg overflow: insufficient free bits before issuing SRAM read.")
  when(sramRen) {
    assert(freeBits >= dataWidthSram.U,
      "Read issued without guaranteeing enough buffer space.")
  }
}


