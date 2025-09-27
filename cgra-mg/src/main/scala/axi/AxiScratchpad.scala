package tram.axi

import tram._
import tram.dsa._

import chisel3._
import chisel3.util._
import org.chipsalliance.cde.config.Parameters
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.util._
import freechips.rocketchip.amba._
import freechips.rocketchip.amba.axi4._
import freechips.rocketchip.amba.axi4.{AXI4BundleParameters, AXI4Bundle}

/**
 * Address space:
 *  SRAM:       baseAddr + 0x0100 ~ baseAddr + lgSizeSpadBank - log2Ceil(axiBeatBytes) 
 *  Last sram:  baseAddr + lgSizeSpadBank - log2Ceil(axiBeatBytes) ~ baseAddr + lgSizeSpadBank - log2Ceil(axiBeatBytes) + lgSizeSpadBank - log2Ceil(bPortBytes)
 *  Registers:  baseAddr + 0x0000 ~ baseAddr + 0xFF
 */
class AXI4Scratchpad(
              // val AddrWidth         : Int,
              // val DataWidth         : Int
              //// axi port parameters
              idWidth : Int = 2,
              baseAddr: BigInt = 0,
              spadBanksNum: Int,
              lgSizeSpadBank: Int = 13, /// log Byte
              lgSizeLastBlock: Int = 10, /// log Bytes
              axiBeatBytes: Int = 8, /// 64bit

              //// B port parameters
              bPortBytes: Int = 4, /// 32bit
              hasMask: Boolean = false
          ) extends Module {

  /// set axi4 Parameters
  // val AxiAddrWidth = log2Ceil(baseAddr + spadBanksNum * (1 << lgSizeSpadBank) + lgSizeLastBlock - 1) - log2Ceil(axiBeatBytes)
  val AxiAddrWidth = log2Ceil(baseAddr + spadBanksNum * (1 << lgSizeSpadBank) + lgSizeLastBlock - 1)
  val SPMAddrWidth = lgSizeSpadBank - log2Ceil(axiBeatBytes) 
  val lgAPortBytes = log2Ceil(axiBeatBytes)

  val DataWidth = axiBeatBytes * 8
  val cfgSpadBanks = {
    if(lgSizeLastBlock <= lgSizeSpadBank) 1
    else 1 << (lgSizeLastBlock - lgSizeSpadBank)
  }
  require(cfgSpadBanks == 1) /// now we only handle one cfg bank

  val lgDepthLast = lgSizeLastBlock - log2Ceil(axiBeatBytes)

  println("AxiAddrWidth", AxiAddrWidth)
  println("lgSizeLastBlock", lgSizeLastBlock)
  println("cfgSpadBanks", cfgSpadBanks)
  println("lgDepthLast", lgDepthLast)


  require(isPow2(DataWidth))
  val axi4Param = new AXI4BundleParameters(
                      addrBits = AxiAddrWidth,
                      dataBits = axiBeatBytes * 8,
                      idBits   = idWidth) 
  // println("AxiAddrWidth", AxiAddrWidth)
  // println("SPMAddrWidth", SPMAddrWidth)

  // =========================================================================
  // I/O
  // =========================================================================
  val io = IO( new Bundle{
    // Clock and Reset
    val aclk        = Input(Clock())
    val aresetn     = Input(Bool())

    // AXI4 Interface
    val s_axi = Flipped(new AXI4Bundle(axi4Param))

    // SRAM Interface
    val srams = Vec(spadBanksNum, new SRAMIO(
                      bPortBytes * 8, 
                      lgSizeSpadBank - log2Ceil(bPortBytes), 
                      hasMask))

    val sram_last = new SRAMIO( 
                      DataWidth, 
                      lgDepthLast, 
                      hasMask)
  })

  val spads = Seq.fill(spadBanksNum){
    Module(new TrueDualPortSRAMAsym(
        /*aWidth=*/ axiBeatBytes * 8, 
        /*lgDepth=*/lgSizeSpadBank - log2Ceil(axiBeatBytes), 
        /*bWidth=*/ bPortBytes * 8, 
        /*hasMask=*/hasMask)
    ).io}

  val spad_last_bank_io = Module(new TrueDualPortSRAM(
        /*aWidth=*/axiBeatBytes * 8, 
        /*lgDepth=*/lgDepthLast, 
        hasMask)).io

  /// b port connection
  io.srams.zipWithIndex.foreach{ case (sram, i) =>
    spads(i).b <> io.srams(i)
    // sram <> spads(i).b
  }

  spad_last_bank_io.b <> io.sram_last

  // =========================================================================
  // Chisel Work-Around for Active-Low Reset
  // =========================================================================
  val asyncReset       = (!io.aresetn).asAsyncReset

  // =========================================================================
  // Internal Logic
  // =========================================================================
  val axi4RdView = Wire(new AXI4RdIntfView(axi4Param))
  axi4RdView.ar <> io.s_axi.ar
  axi4RdView.r  <> io.s_axi.r

  val axi4WrView  = Wire(new AXI4WrIntfView(axi4Param))
  axi4WrView.aw <> io.s_axi.aw
  axi4WrView.w  <> io.s_axi.w
  axi4WrView.b  <> io.s_axi.b

  val rdBankIdxSyn = RegInit(0.U((AxiAddrWidth-lgSizeSpadBank).W))

  withClockAndReset(io.aclk, asyncReset) {
    val wrIE    = Module(new WriteEngine(axi4Param))
    val rdIE    = Module(new ReadEngine(axi4Param))
    val arbiter = Module(new SramArbiter(spadBanksNum + 1))

    println("spadBanksNum:", spadBanksNum)
    println("lgDepthLast:", lgDepthLast)
    // require(spadBanksNum > lgDepthLast)
    val wr_csel       = wrIE.addr(AxiAddrWidth - 1, SPMAddrWidth + log2Ceil(axiBeatBytes))
    val wr_spad_addr  = wrIE.addr(SPMAddrWidth + log2Ceil(axiBeatBytes) - 1, log2Ceil(axiBeatBytes))
    val rd_csel       = rdIE.addr(AxiAddrWidth - 1, SPMAddrWidth + log2Ceil(axiBeatBytes))
    val rd_spad_addr  = rdIE.addr(SPMAddrWidth + log2Ceil(axiBeatBytes) - 1, log2Ceil(axiBeatBytes))
    // val wr_csel       = wrIE.addr(AxiAddrWidth - 1, SPMAddrWidth)
    // val wr_spad_addr  = wrIE.addr(SPMAddrWidth - 1, 0)
    // val rd_csel       = rdIE.addr(AxiAddrWidth - 1, SPMAddrWidth)
    // val rd_spad_addr  = rdIE.addr(SPMAddrWidth - 1, 0)

    wrIE.aclk       := io.aclk
    wrIE.aresetn    := io.aresetn
    wrIE.s_axi      <> axi4WrView
    wrIE.ready      := arbiter.wrready

    rdIE.aclk       := io.aclk
    rdIE.aresetn    := io.aresetn
    rdIE.s_axi      <> axi4RdView
    rdIE.ready      := arbiter.rdready

    /// connect the chip select signals to arbiter
    arbiter.wr_cs := wr_csel
    arbiter.rd_cs := rd_csel

    val doutTable1 = spads.zipWithIndex.map{ case (sp, i) => (i.U -> sp.a.dout) }
    val doutTable2 = (0 until cfgSpadBanks).map{ i => ((i+spadBanksNum).U -> spad_last_bank_io.a.dout) }
    val doutTable = doutTable1 ++ doutTable2

    val currentRdBank = RegNext(rd_csel)
    rdIE.data := MuxLookup(currentRdBank, 0.U, doutTable)

    // arbiter.aclk    := io.aclk
    // arbiter.aresetn := io.aresetn
    arbiter.wrvalid := wrIE.valid
    arbiter.rdvalid := rdIE.valid

    spads.zipWithIndex.foreach{ case (sp, i) =>
      /// sel signal
      // val en = Mux(wrIE.ready, wr_csel === i.U, rd_csel === i.U)
      val en = (wr_csel === i.U & wrIE.ready) | (rd_csel === i.U & rdIE.ready)
      val we = wrIE.ready & wrIE.valid & wr_csel === i.U
      val re = rdIE.ready & rdIE.valid & rd_csel === i.U
      when(en){
        sp.a.addr       := Mux(we, wr_spad_addr, rd_spad_addr)
        sp.a.en         := we | re
        sp.a.din        := wrIE.data
        sp.a.we         := {if(hasMask) ~wrIE.strb else we}
        // sp.a.strb       := ~wrIE.strb
      }.otherwise{
        sp.a.addr       := DontCare
        sp.a.en         := false.B
        sp.a.din        := DontCare
        sp.a.we         := 0.U
      }
    }

    /////////////////////
    /// last config spad
    /////////////////////
    val wr_last_addr = wrIE.addr(SPMAddrWidth + log2Ceil(axiBeatBytes) - 1, log2Ceil(axiBeatBytes))
    val rd_last_addr = rdIE.addr(SPMAddrWidth + log2Ceil(axiBeatBytes) - 1, log2Ceil(axiBeatBytes))
    // val wr_last_addr = wrIE.addr(SPMAddrWidth - 1, log2Ceil(axiBeatBytes))
    // val rd_last_addr = rdIE.addr(SPMAddrWidth - 1, log2Ceil(axiBeatBytes))

    val en_last = (wr_csel === spadBanksNum.U & wrIE.ready) | (rd_csel === spadBanksNum.U & rdIE.ready)
    val we_last = wrIE.ready & wrIE.valid & wr_csel === spadBanksNum.U
    val re_last = rdIE.ready & rdIE.valid & wr_csel === spadBanksNum.U
    when(en_last){
      spad_last_bank_io.a.addr   := Mux(we_last, wr_last_addr, rd_last_addr)
      spad_last_bank_io.a.en     := we_last | re_last
      spad_last_bank_io.a.din    := wrIE.data
      spad_last_bank_io.a.we     := {if(hasMask) ~wrIE.strb else we_last}
      // sp.a.strb       := ~wrIE.strb
    }.otherwise{
      spad_last_bank_io.a.addr   := DontCare
      spad_last_bank_io.a.en     := false.B
      spad_last_bank_io.a.din    := DontCare
      spad_last_bank_io.a.we     := 0.U
    }
    // val last_arbiter = Module(new SramArbiter(cfgSpadBanks))
    // val wr_last_csel  = wrIE.addr(AxiAddrWidth - 1, lgDepthLast)
    // val rd_last_csel  = rdIE.addr(AxiAddrWidth - 1, lgDepthLast)
    
    // /// connect the chip select signals to arbiter
    // last_arbiter.wr_cs := wr_last_csel === spadBanksNum << SPMAddrWidth - lgDepthLast
    // last_arbiter.rd_cs := rd_last_csel === spadBanksNum << SPMAddrWidth - lgDepthLast

  } // withClockAndReset(aclk, asyncReset)
}
