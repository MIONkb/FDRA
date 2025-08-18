package tram.axi

import tram._
import tram.spec._

import chisel3._
import chisel3.util._
import firrtl.Utils.True

//import freechips.rocketchip.config._
import org.chipsalliance.cde.config._
import org.chipsalliance.cde.config.Parameters
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.tile._
import freechips.rocketchip.util._
import freechips.rocketchip.amba.axi4._
import freechips.rocketchip.amba.axi4.{AXI4BundleParameters, AXI4Bundle}
// import freechips.rocketchip.diplomacy._

import java.io.File

class TramWithAxi(/*opcodes: OpcodeSet*/)/*(implicit p: Parameters)*/ extends Module  {
  import TramParam._
  // println(tram_spec_filename)
  if(dumpSpec){ TramSpec.dumpSpec(tram_spec_filename) }
  if(loadSpec){ TramSpec.loadSpec(tram_spec_filename) }
  TramSpec.attrs("dumpOperationSet") = dumpOperationSet
  if(dumpOperationSet){ TramSpec.attrs("operation_set_filename") = operation_set_filename }
  TramSpec.attrs("dumpOperationSet") = dumpADG
  if(dumpADG){ TramSpec.attrs("cgra_adg_filename") = cgra_adg_filename }
  // scratchpad banks used for IOB
  val lgSizeSpadBank = TramSpec.attrs("spad_bank_lg_size").asInstanceOf[Int]
  val nSpadBanks = TramSpec.attrs("spad_num_banks").asInstanceOf[Int]
  // scratchpad block used for Config
  val spadDataWidth = TramSpec.attrs("spad_data_width").asInstanceOf[Int]
  val cgraDataWidth = TramSpec.attrs("cgra_data_width").asInstanceOf[Int]
  val lgSizeSpadCfg = TramSpec.attrs("spad_cfg_lg_size").asInstanceOf[Int]
  val cfgSpadBanks = {
    if(lgSizeSpadCfg <= lgSizeSpadBank) 1
    else 1 << (lgSizeSpadCfg - lgSizeSpadBank)
  }
  val spadAddrWidth = lgSizeSpadBank + log2Ceil(nSpadBanks+cfgSpadBanks) // in bus width bytes
  // println("lgSizeSpadBank, nSpadBanks, cfgSpadBanks", lgSizeSpadBank, nSpadBanks, cfgSpadBanks)
  // println("spadAddrWidth", spadAddrWidth)

  val lgMaxDataLen = spadAddrWidth
  val spadAddrNum = TramSpec.attrs("spad_addr_num").asInstanceOf[Int]
  val hasMask = false //true // spadDataWidth != cgraDataWidth

  val idWidth = TramSpec.attrs("id_width").asInstanceOf[Int]
  val nReqInflight = TramSpec.attrs("dma_num_req_in_flight").asInstanceOf[Int]
  val maxLgSizeTL = TramSpec.attrs("dma_lg_max_burst_size").asInstanceOf[Int]
  val nWaysOfTLB = TramSpec.attrs("tlb_num_ways").asInstanceOf[Int]
  val useSharedTLB = TramSpec.attrs("tlb_is_shared").asInstanceOf[Boolean]


  ///// AXI LITE Parameters
  val AxiLiteAddrSpace = TramSpec.attrs("axilite_addrspace").asInstanceOf[Int] // Bytes
  val AxiLiteDataWidth = TramSpec.attrs("axilite_datawidth").asInstanceOf[Int]   // Byte
  val AxiLiteAddrWidth = log2Ceil(AxiLiteAddrSpace)

//  val cmdQueDepth = TramSpec.attrs("rs_cmd_queue_depth").asInstanceOf[Int]
//   val loadQueDepth = TramSpec.attrs("rs_load_queue_depth").asInstanceOf[Int]
//   val storeQueDepth = TramSpec.attrs("rs_store_queue_depth").asInstanceOf[Int]
//   val exeQueDepth = TramSpec.attrs("rs_exe_queue_depth").asInstanceOf[Int]
//   val streamQueDepth = TramSpec.attrs("ls_stream_queue_depth").asInstanceOf[Int]
  
  // val module = Module(new TramModuleWithAxiImp(this))
  // val dma_node = LazyModule(new DMAController(lgMaxDataLen, spadDataWidth, hasMask, idWidth, nReqInflight, maxLgSizeTL, nWaysOfTLB, useSharedTLB))
  // override val tlNode = dma_node.id_node
  //  tlNode := dma_node.id_node
  // val axiAddrWidth = log2Ceil(nSpadBanks * (1 << lgSizeSpadBank) - 1) - log2Ceil(spadDataWidth / 8)
  // val axiAddrWidth = log2Ceil(nSpadBanks * (1 << lgSizeSpadBank) + lgSizeSpadCfg - 1) - log2Ceil(spadDataWidth / 8) // in bus width bytes
  val axiAddrWidth = log2Ceil(nSpadBanks * (1 << lgSizeSpadBank) + lgSizeSpadCfg - 1) // in bus width bytes

  println("axiAddrWidth", axiAddrWidth)
  val axi4Param = new AXI4BundleParameters(
                      addrBits = axiAddrWidth,
                      dataBits = spadDataWidth,
                      idBits   = idWidth) 
  
  // println("lgSizeSpadCfg", lgSizeSpadCfg)
  // println("AxiLiteAddrWidth", AxiLiteAddrWidth)
  require(AxiLiteAddrWidth >= lgSizeSpadCfg - 3)
  val axiliteParam = new AXI4BundleParameters(
                      addrBits = AxiLiteAddrWidth,
                      dataBits = AxiLiteDataWidth,
                      idBits   = 1/* No id in axi lite*/) 

  val io = IO( new Bundle{
    // AXI4 Interface
    val s_axi = Flipped(new AXI4Bundle(axi4Param))

    // AXI4 Interface
    val s_axilite = Flipped(new AXILiteBundle(axiliteParam))
  })

  val spad = Module(new AXI4Scratchpad(
    idWidth       = idWidth,
    baseAddr      = 0,
    spadBanksNum  = nSpadBanks,
    lgSizeSpadBank= lgSizeSpadBank,
    lgSizeLastBlock= lgSizeSpadCfg,
    axiBeatBytes  = spadDataWidth / 8,

    bPortBytes    = cgraDataWidth / 8,
    hasMask       = hasMask
  ))

  val cgra = Module(new AXICGRAController(TramSpec.attrs))

  io.s_axi          <> spad.io.s_axi
  io.s_axilite      <> cgra.io.s_axilite

  spad.io.aclk      := clock     
  spad.io.aresetn   := !reset.asBool 
  spad.io.srams     <> cgra.io.srams_iob
  spad.io.sram_last <> cgra.io.sram_cfg
}

object VerilogGen extends App {
 (new chisel3.stage.ChiselStage).emitVerilog(new TramWithAxi(), args)
}