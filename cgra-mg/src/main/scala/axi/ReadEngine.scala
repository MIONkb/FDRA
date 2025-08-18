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

// AXI Read Interface View
class AXI4RdIntfView(params: AXI4BundleParameters) extends Bundle {
  val ar = Irrevocable(new AXI4BundleAR(params))
  val r  = Flipped(Irrevocable(new AXI4BundleR (params)))
}
/**
 *
 * Time --->
    s_axi.ar.valid:   ----|====|-----------------
    s_axi.ar.ready:   ----|====|-----------------
    iARready:         ----|====|-----------------
    iAddrvalid:       ---------|====|------------
    ivalid:           ---------|====|------------
    ready:            ---------|----|====|-------
    iRvalid:          ---------|----|====|-------
    s_axi.r.valid:    ---------|----|====|-------
    s_axi.r.ready:    ---------|----|----|====|--
 */
class ReadEngine(params: AXI4BundleParameters) extends RawModule {
    val AddrWidth = params.addrBits
    val DataWidth = params.dataBits
    val IdWidth   = params.idBits

    // =========================================================================
    // I/O
    // =========================================================================

    // Clock and Reset
    val aclk        = IO(Input(Clock()))
    val aresetn     = IO(Input(Bool()))

    // AXI Read Interface View
    val s_axi       = IO(Flipped(new AXI4RdIntfView(params)))

    // Upacked Transfers
    val ready       = IO(Input(Bool()))
    val valid       = IO(Output(Bool()))
    val addr        = IO(Output(UInt(AddrWidth.W)))
    val data        = IO(Input(UInt(DataWidth.W)))

    // =========================================================================
    // Chisel Work-Around for Active-Low Reset
    // =========================================================================
    val reset      = (!aresetn).asAsyncReset
    
    // =========================================================================
    // state machine
    // =========================================================================
    val s_idle :: s_r_wait :: s_r_stream :: s_r_last :: Nil = Enum(4)
    // val s_idle :: s_r_stream :: s_r_last :: Nil = Enum(3)

    withClockAndReset(aclk, reset) {
        val state = RegInit(s_idle)
        val spad_needed_len = RegInit(0.U(8.W))
        // val iCounter = RegInit(0.U(8.W))

        //// r channel signals
        val rValid = RegInit(false.B)
        val rId = RegInit(0.U(IdWidth.W))
        val rLast = RegInit(false.B)
        val rBurst = RegInit(0.U(2.W))
        val rSize = RegInit(0.U(3.W))

        //// Data streams
        val leftLen = RegInit(0.U(8.W)) // left data length
        val success = RegInit(true.B)
        // val leftNum = RegInit(0.U(log2Ceil(spadAddrNum).W))
        
        //// Addr signal
        val iAddr       = RegInit(0.U(AddrWidth.W))
        val iAddrvalid  = RegInit(false.B)
        val NextAddr    = Wire(UInt(AddrWidth.W))
        NextAddr    := SramAddrGen(AddrWidth, iAddr, spad_needed_len, rSize, rBurst)
        
        //// two recoder regs to solve the problem of rready negedge when rvalid posedge
        val pre_Rready  = RegNext(s_axi.r.ready)
        val pre_Addr    = RegNext(iAddr)
        val pre_state   = RegInit(s_idle)
        pre_state  := state

        ///// Need to handle following regs: 
        /////   state spad_needed_len rId rLast iAddr leftLen rBurst rSize        
        switch(state) {
            is(s_idle) {
                when(s_axi.ar.valid) {
                    state           := s_r_wait
                    spad_needed_len := s_axi.ar.bits.len
                    rId             := s_axi.ar.bits.id
                    rLast           := false.B
                    iAddr           := s_axi.ar.bits.addr
                    leftLen         := s_axi.ar.bits.len
                    rBurst          := s_axi.ar.bits.burst
                    rSize           := s_axi.ar.bits.size
                }.otherwise{
                    state   := state
                    rId     := 0.U
                    rLast   := false.B
                    rBurst  := 0.U
                    rSize   := 0.U
                }
            }
            is(s_r_wait) {
                when(ready) {
                    when(leftLen === 0.U) {
                        state   := s_r_last
                        rLast   := true.B
                        leftLen := leftLen
                        iAddr   := iAddr
                    }.otherwise{
                        state   := s_r_stream
                        rLast   := false.B
                        leftLen := leftLen
                        // iAddr   := Mux(s_axi.r.ready, NextAddr, iAddr)
                        iAddr   := NextAddr
                    }
                }
            }
            is(s_r_stream) {
                // when(pre_Rready & !s_axi.r.ready & pre_state === s_r_wait) {
                // when(pre_Rready & !s_axi.r.ready) {
                //     /// To solve the problem of rready get negedge when rvalid get posedge
                //     state   := s_r_wait
                //     iAddr   := pre_Addr
                // }
                // .elsewhen(!ready) {
                when(!ready) {
                    state   := s_r_wait
                    leftLen := Mux(s_axi.r.ready, leftLen - 1.U, leftLen)
                    // iAddr   := Mux(s_axi.r.ready, NextAddr, iAddr)
                    iAddr   := iAddr
                }.elsewhen(leftLen === 1.U) {
                    //// TODO: how to do this
                    // state   := Mux(s_axi.r.ready, s_r_last, state)
                    // iAddr   := Mux(s_axi.r.ready, NextAddr, iAddr)
                    // leftLen := Mux(s_axi.r.ready, leftLen - 1.U, leftLen)
                    // rLast   := true.B

                    state   := Mux(s_axi.r.ready, s_r_last, state)
                    iAddr   := Mux(s_axi.r.ready, NextAddr, iAddr)
                    leftLen := Mux(s_axi.r.ready, leftLen - 1.U, leftLen)
                    rLast   := false.B
                }.elsewhen(s_axi.r.ready){
                    state   := state
                    leftLen := leftLen - 1.U
                    iAddr   := NextAddr
                    rLast   := false.B
                }.otherwise{
                    state   := state
                    leftLen := leftLen
                    iAddr   := iAddr
                }
            }
            is(s_r_last){
                // when(pre_Rready & !s_axi.r.ready) {
                // when(pre_Rready & !s_axi.r.ready & pre_state === s_r_wait) {
                //     /// To solve the problem of rready get negedge when rvalid get posedge
                //     state   := s_r_wait
                //     iAddr   := pre_Addr
                // }.elsewhen(s_axi.r.ready){
                when(s_axi.r.ready){
                    state   := s_idle
                    leftLen := 0.U
                    iAddr   := 0.U
                    rLast   := false.B
                }
                // .elsewhen(!ready) {
                //     state   := s_r_wait
                //     iAddr   := iAddr
                //     leftLen := leftLen
                //     rLast   := false.B
                // }
                .otherwise{
                    state   := state
                    leftLen := leftLen
                    iAddr   := iAddr
                    rLast   := true.B
                }
            }
        }
        // =========================================================================
        // Combination Logic
        // =========================================================================
        /// ar signals
        // axi io
        s_axi.ar.ready  := state === s_idle

        /// r signals   
        val output_data = Wire(UInt(DataWidth.W))
        s_axi.r.valid       := state === s_r_stream || state === s_r_last
        s_axi.r.bits.id     := rId
        s_axi.r.bits.data   := output_data
        s_axi.r.bits.last   := state === s_r_last
        s_axi.r.bits.resp   := 0.U

        /// Upacked signals to SRAM
        valid       := state === s_r_stream || state === s_r_wait || state === s_r_last
        addr        := iAddr

        /// to keep the data when ready goes low 
        val Stream_data = data
        val Stream_data_reg = RegInit(0.U(DataWidth.W)) //@yuan: keep the spad output data for longer time
        val s_output_switch :: s_output_keep :: Nil = Enum(2)
        val SpadState = RegInit(s_output_switch)
        switch(SpadState) {
            is(s_output_switch) {
                Stream_data_reg := Stream_data
                // SpadState := Mux(!s_axi.r.ready, s_output_keep, SpadState)
                when(state === s_idle | state === s_r_wait){
                    SpadState := s_output_switch
                }
                .elsewhen(!s_axi.r.ready) {
                    SpadState := s_output_keep
                }
            }
            is(s_output_keep) {
                Stream_data_reg := Stream_data_reg
                when(state === s_idle){
                    SpadState := s_output_switch
                }
                .elsewhen(s_axi.r.ready) {
                    SpadState := s_output_switch
                }
            }
        }
        output_data := Mux(SpadState === s_output_switch , Stream_data, Stream_data_reg)

    }
}
