package tram.axi

/* Chisel Imports */
import chisel3._
import chisel3.util.{Cat, is, switch, log2Ceil}
import freechips.rocketchip.util._

// arbitrate with combination logic
class SramArbiter(spadBanksNum: Int) extends RawModule {

    // Clock and Reset
    // val aclk        = IO(Input(Clock()))
    // val aresetn     = IO(Input(Bool()))

    // Write Channel
    val wrvalid     = IO(Input(Bool()))
    val wrready     = IO(Output(Bool()))

    // Read Channel
    val rdvalid     = IO(Input(Bool()))
    val rdready     = IO(Output(Bool()))

    // chip select for different banks
    val Cs_Width    = log2Ceil(spadBanksNum)
    val wr_cs       = IO(Input(UInt(Cs_Width.W)))
    val rd_cs       = IO(Input(UInt(Cs_Width.W)))
    // =========================================================================
    // Chisel Work-Around for Active-Low Reset
    // =========================================================================

    // val reset       = (!aresetn).asAsyncReset


    // =========================================================================
    // Internal Logic
    // =========================================================================

    // withClockAndReset(aclk, reset) {

        // val wrready_reg      = RegInit(false.B)
        // val rdready_reg      = RegInit(false.B)
        // val choiceNext  = Wire(Bool())

        // /// Choice/Grant
        // choice          := choiceNext

        /// Next Choice
        /// if read and write to the same bank, then arbitration is needed selection 
        // when(wr_cs === rd_cs)  {
        //     // choiceNext      := DontCare
        //     // switch (Cat(wrvalid, rdvalid)) {
        //     //     is (0.U) { choiceNext := choice }       /// No request, retain the current choice
        //     //     is (1.U) { choiceNext := false.B }      /// Only read request, select read operation
        //     //     is (2.U) { choiceNext := true.B }       /// Only write request, select write operation
        //     //     is (3.U) { choiceNext := ~choice }      // Both read and write requests, alternate selection
        //     // }
        //     // /// Output Assignments
        //     // wrready     := choice
        //     // rdready     := ~choice

        //     //// if wr&rd conflict, write first 
        //     when(wrvalid === true.B && rdvalid === true.B) {
        //         wrready_reg := true.B
        //         rdready_reg := false.B
        //     }.otherwise{
        //         wrready_reg := wrvalid
        //         rdready_reg := rdvalid
        //     }
        // }.otherwise{
        //     // choiceNext  := choice
        //     wrready_reg := wrvalid
        //     rdready_reg := rdvalid
        // }

        // wrready     :=  wrready_reg
        // rdready     :=  rdready_reg

        // when(wr_cs === rd_cs)  {
            // choiceNext      := DontCare
            // switch (Cat(wrvalid, rdvalid)) {
            //     is (0.U) { choiceNext := choice }       /// No request, retain the current choice
            //     is (1.U) { choiceNext := false.B }      /// Only read request, select read operation
            //     is (2.U) { choiceNext := true.B }       /// Only write request, select write operation
            //     is (3.U) { choiceNext := ~choice }      // Both read and write requests, alternate selection
            // }
            // /// Output Assignments
            // wrready     := choice
            // rdready     := ~choice

    // } // withClockAndReset(aclk, reset)
    when(wr_cs === rd_cs && wrvalid === true.B && rdvalid === true.B)  {
        wrready := true.B
        rdready := false.B
    } .otherwise{
        // choiceNext  := choice
        wrready := wrvalid
        rdready := rdvalid
    }

}
