//package tram.fpu
//
//import chisel3._
//import chisel3.util._
//import fgra.op.FPU._
//
////@yuan: adding counters to control the float-point divider to execute correctly
//class FDIVTop(val expWidth: Int, val precision: Int, lgMaxII: Int) extends Module {
//  val io = IO(new Bundle() {
//    val a, b = Input(UInt((expWidth + precision).W))
//    val rm = Input(UInt(3.W))
//    val mode = Input(UInt(1.W))
//    val en = Input(Bool())
//    val II = Input(UInt(lgMaxII.W))
//    val result = Output(UInt((expWidth + precision).W))
//  })
//
//  //instance the float-point divider
//  val fdiv = Module(new FDIV(expWidth, precision))
//  fdiv.io.a := io.a
//  fdiv.io.b := io.b
//  fdiv.io.specialIO.isSqrt := io.mode
//  fdiv.io.specialIO.in_valid := io.en
//  fdiv.io.specialIO.out_ready := io.en
//  fdiv.io.rm := io.rm
//
//  val IICnt = RegInit(1.U(lgMaxII.W))
//  val IICntEnd = (IICnt + 2.U) >= io.II
//  val s_idle :: s_count :: s_kill :: Nil = Enum(3)
//  val state = RegInit(s_idle)
//  val isKill = WireInit(false.B)
//
//  //it's noted that the minimum value of II is 11
//  switch(state) {
//    is(s_idle) {
//      IICnt := 1.U
//      when(io.en) {
//        state := s_count
//      }
//      isKill := false.B
//    }
//    is(s_count) {
//      isKill := false.B
//      when(io.en && IICntEnd) {
//        state := s_kill
//      }
//      IICnt := IICnt + 1.U
//    }
//    is(s_kill) {
//      isKill := true.B
//      state := s_idle
//    }
//  }
//  fdiv.io.specialIO.kill := isKill
//  io.result := fdiv.io.result
//}
//
//object VerilogFDIVTopGen extends App {
//  (new chisel3.stage.ChiselStage).emitVerilog(new FDIVTop(8,24, 5), args)
//}