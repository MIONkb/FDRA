package tram.axi

/* Chisel Imports */
import chisel3._
import chisel3.util._
import chisel3.util.{Irrevocable}
import chisel3.experimental.ChiselEnum
import org.chipsalliance.cde.config.Parameters
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.util._
import freechips.rocketchip.amba._
import freechips.rocketchip.amba.axi4._
import freechips.rocketchip.amba.axi4.{AXI4BundleParameters, AXI4Bundle}

// AXI Write Interface View
class AXI4WrIntfView(params: AXI4BundleParameters) extends Bundle {
  val aw = Irrevocable(new AXI4BundleAW(params))
  val w  = Irrevocable(new AXI4BundleW (params))
  val b  = Flipped(Irrevocable(new AXI4BundleB (params)))
}

class WriteEngine(params: AXI4BundleParameters) extends RawModule {
    val AddrWidth = params.addrBits
    val DataWidth = params.dataBits
    val IdWidth   = params.idBits

    // =========================================================================
    // I/O
    // =========================================================================
    // Clock and Reset
    val aclk        = IO(Input(Clock()))
    val aresetn     = IO(Input(Bool()))

    val s_axi       = IO(Flipped(new AXI4WrIntfView(params)))

    // Upacked Transfers
    val ready       = IO(Input(Bool()))
    val valid       = IO(Output(Bool()))
    val addr        = IO(Output(UInt(AddrWidth.W)))
    val data        = IO(Output(UInt(DataWidth.W)))
    val strb        = IO(Output(UInt((DataWidth/8).W)))

 
    // =========================================================================
    // Chisel Work-Around for Active-Low Reset
    // =========================================================================
    val reset      = (!aresetn).asAsyncReset
    

    withClockAndReset(aclk, reset) {
        // =========================================================================
        // state machine
        // =========================================================================
        val s_idle :: s_w_wait :: s_w_stream :: s_b_valid :: Nil = Enum(4)

        val state = RegInit(s_idle)
        val spad_needed_len = RegInit(0.U(8.W))
        // val iCounter = RegInit(0.U(8.W))

        //// w channel signals
        val wValid = RegInit(false.B)
        val wId = RegInit(0.U(IdWidth.W))
        // val wLast = RegInit(false.B)
        val wBurst = RegInit(0.U(2.W))
        val wSize = RegInit(0.U(3.W))

        //// b channel signals
        // val iBValid = RegInit(false.B)
        val iBID = RegInit(0.U(IdWidth.W))

        //// Data streams
        val leftLen = RegInit(0.U(8.W)) // left data length
        val success = RegInit(true.B)
        // val leftNum = RegInit(0.U(log2Ceil(spadAddrNum).W))
        
        //// Addr signal
        val iAddr       = RegInit(0.U(AddrWidth.W))
        val iAddrvalid  = RegInit(false.B)
        val NextAddr    = Wire(UInt(AddrWidth.W))
        NextAddr    := SramAddrGen(AddrWidth, iAddr, spad_needed_len, wSize, wBurst)
        
        // //// two recoder regs to solve the problem of rready negedge when rvalid posedge
        // val pre_Rready  = RegNext(s_axi.r.ready)
        // val pre_Addr    = RegNext(iAddr)
        // val pre_state   = RegInit(s_idle)
        // pre_state  := state

        ///// Need to handle following regs: 
        /////   state spad_needed_len rId rLast iAddr leftLen rBurst rSize        
        switch(state) {
            is(s_idle) {
                when(s_axi.aw.valid) {
                    state           := s_w_stream
                    spad_needed_len := s_axi.aw.bits.len
                    iBID            := s_axi.aw.bits.id
                    // wLast           := false.B
                    iAddr           := s_axi.aw.bits.addr
                    leftLen         := s_axi.aw.bits.len
                    wBurst          := s_axi.aw.bits.burst
                    wSize           := s_axi.aw.bits.size
                }.otherwise{
                    state   := state
                    iBID    := 0.U
                    // wLast   := false.B
                    wBurst  := 0.U
                    wSize   := 0.U
                }
            }
            is(s_w_wait) {
                when(ready) {
                    state   := s_w_stream
                    leftLen := leftLen
                    iAddr   := Mux(s_axi.w.ready, NextAddr, iAddr)
                }
            }
            is(s_w_stream) {
                when(!ready) {
                    state   := s_w_wait
                    leftLen := leftLen
                }.elsewhen(s_axi.w.bits.last & s_axi.w.valid) {
                    //// TODO: how to do this
                    // state   := Mux(s_axi.r.ready, s_r_last, state)
                    // iAddr   := Mux(s_axi.r.ready, NextAddr, iAddr)
                    // leftLen := Mux(s_axi.r.ready, leftLen - 1.U, leftLen)
                    // rLast   := true.B

                    state   := s_b_valid
                    iAddr   := iAddr
                    leftLen := leftLen
                }.elsewhen(s_axi.w.valid){
                    state   := state
                    leftLen := leftLen - 1.U
                    iAddr   := NextAddr
                }.otherwise{
                    state   := state
                    leftLen := leftLen
                    iAddr   := iAddr
                }
            }
            is(s_b_valid){
                when(s_axi.b.ready){
                    state   := s_idle
                }
            }
        }
        // =========================================================================
        // Combination Logic
        // =========================================================================
        /// aw signals
        s_axi.aw.ready      := state === s_idle

        /// w signals   
        s_axi.w.ready       := state === s_w_stream
        data                := s_axi.w.bits.data 
        strb                := s_axi.w.bits.strb

        /// b signals
        s_axi.b.bits.id     := iBID
        s_axi.b.bits.resp   := 0.U
        s_axi.b.valid       := state === s_b_valid

        /// Upacked signals to SRAM
        valid       := state === s_w_stream
        addr        := iAddr
    }
}
