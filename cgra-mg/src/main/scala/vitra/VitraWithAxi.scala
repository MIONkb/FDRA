package tram.vitra

import tram._
import tram.axi.{AXI4Scratchpad, AXILiteBundle}
import tram.vitra.spec._


import chisel3._
import chisel3.util._
import firrtl.Utils.True
import firrtl.stage.FirrtlStage

//import freechips.rocketchip.config._
import org.chipsalliance.cde.config._
import org.chipsalliance.cde.config.Parameters
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.tile._
import freechips.rocketchip.util._
import freechips.rocketchip.amba.axi4._
import freechips.rocketchip.amba.axi4.{AXI4BundleParameters, AXI4Bundle}
// import freechips.rocketchip.diplomacy._

import java.nio.file.{Files, Path, Paths}

case class VitraMetadataPaths(
  specDirectory: Path,
  vitraSpec: Path,
  operationSet: Path,
  cgraAdg: Path,
  axiLiteSpec: Path)

object VitraParam {
  val dumpSpec : Boolean = true
  val loadSpec : Boolean = false
  val dumpOperationSet : Boolean = true
  val dumpADG : Boolean = true
  val FPGAImp = false
  val defaultTargetDir: Path = Paths.get(".")

  def targetDirFromArgs(args: Seq[String]): Path = {
    args.zipWithIndex.collectFirst {
      case (option, index)
          if (option == "-td" || option == "--target-dir") && index + 1 < args.length =>
        Paths.get(args(index + 1))
    }.getOrElse(defaultTargetDir)
  }

  def metadataPathsFor(targetDir: Path): VitraMetadataPaths = {
    val specDirectory = targetDir.resolve("spec")
    Files.createDirectories(specDirectory)
    VitraMetadataPaths(
      specDirectory = specDirectory,
      vitraSpec = specDirectory.resolve("vitra_spec.json"),
      operationSet = specDirectory.resolve("operations.json"),
      cgraAdg = specDirectory.resolve("vitra_cgra_adg.json"),
      axiLiteSpec = specDirectory.resolve("axilite_spec.json"))
  }

  def configureMetadata(
    paths: VitraMetadataPaths,
    operationSetEnabled: Boolean,
    adgEnabled: Boolean): Unit = {
    VitraSpec.attrs("dumpOperationSet") = operationSetEnabled
    VitraSpec.attrs("operation_set_filename") = paths.operationSet.toString
    VitraSpec.attrs("dumpADG") = adgEnabled
    VitraSpec.attrs("cgra_adg_filename") = paths.cgraAdg.toString
  }

}

class VitraWithAxi(targetDir: Path = VitraParam.defaultTargetDir) extends Module  {
  override def desiredName = "CGRAWithAXI"
  // override def desiredName = "vitra"
  import VitraParam._
  val metadataPaths = metadataPathsFor(targetDir)
  configureMetadata(metadataPaths, dumpOperationSet, dumpADG)
  // println(tram_spec_filename)
  if(dumpSpec){ VitraSpec.dumpSpec(metadataPaths.vitraSpec.toString) }
  if(loadSpec){ VitraSpec.loadSpec(metadataPaths.vitraSpec.toString) }
  println(s"adg path: ${metadataPaths.cgraAdg}")
  // scratchpad banks used for IOB
  val lgSizeSpadBank = VitraSpec.attrs("spad_bank_lg_size").asInstanceOf[Int]
  val nSpadBanksEachTile = VitraSpec.attrs("tile_spad_num_banks").asInstanceOf[Int]
  val nTiles = VitraSpec.attrs("cgra_tile_num").asInstanceOf[Int]
  val nSpadBanksTotal = nSpadBanksEachTile * nTiles

  // scratchpad block used for Config
  val spadDataWidth = VitraSpec.attrs("spad_data_width").asInstanceOf[Int]
  val cgraDataWidth = VitraSpec.attrs("cgra_data_width").asInstanceOf[Int]
  val lgSizeSpadCfg = VitraSpec.attrs("spad_cfg_lg_size").asInstanceOf[Int]
  val cfgSpadBanks = {
    if(lgSizeSpadCfg <= lgSizeSpadBank) 1
    else 1 << (lgSizeSpadCfg - lgSizeSpadBank)
  }
  val spadAddrWidth = lgSizeSpadBank + log2Ceil(nSpadBanksTotal+cfgSpadBanks) // in bus width bytes
  // println("lgSizeSpadBank, nSpadBanksTotal, cfgSpadBanks", lgSizeSpadBank, nSpadBanksTotal, cfgSpadBanks)
  // println("spadAddrWidth", spadAddrWidth)

  val lgMaxDataLen = spadAddrWidth
  val spadAddrNum = VitraSpec.attrs("spad_addr_num").asInstanceOf[Int]
  val hasMask = VitraSpec.attrs("cgra_iob_sram_has_mask").asInstanceOf[Boolean] //true // spadDataWidth != cgraDataWidth

  val idWidth = VitraSpec.attrs("id_width").asInstanceOf[Int]
  val nReqInflight = VitraSpec.attrs("dma_num_req_in_flight").asInstanceOf[Int]
  val maxLgSizeTL = VitraSpec.attrs("dma_lg_max_burst_size").asInstanceOf[Int]
  val nWaysOfTLB = VitraSpec.attrs("tlb_num_ways").asInstanceOf[Int]
  val useSharedTLB = VitraSpec.attrs("tlb_is_shared").asInstanceOf[Boolean]


  ///// AXI LITE Parameters
  val AxiLiteAddrSpace = VitraSpec.attrs("axilite_addrspace").asInstanceOf[Int] // Bytes
  val AxiLiteDataWidth = VitraSpec.attrs("axilite_datawidth").asInstanceOf[Int]   // Byte
  val AxiLiteAddrWidth = log2Ceil(AxiLiteAddrSpace)

//  val cmdQueDepth = VitraSpec.attrs("rs_cmd_queue_depth").asInstanceOf[Int]
//   val loadQueDepth = VitraSpec.attrs("rs_load_queue_depth").asInstanceOf[Int]
//   val storeQueDepth = VitraSpec.attrs("rs_store_queue_depth").asInstanceOf[Int]
//   val exeQueDepth = VitraSpec.attrs("rs_exe_queue_depth").asInstanceOf[Int]
//   val streamQueDepth = VitraSpec.attrs("ls_stream_queue_depth").asInstanceOf[Int]
  
  // val module = Module(new TramModuleWithAxiImp(this))
  // val dma_node = LazyModule(new DMAController(lgMaxDataLen, spadDataWidth, hasMask, idWidth, nReqInflight, maxLgSizeTL, nWaysOfTLB, useSharedTLB))
  // override val tlNode = dma_node.id_node
  //  tlNode := dma_node.id_node
  // val axiAddrWidth = log2Ceil(nSpadBanksTotal * (1 << lgSizeSpadBank) - 1) - log2Ceil(spadDataWidth / 8)
  // val axiAddrWidth = log2Ceil(nSpadBanksTotal * (1 << lgSizeSpadBank) + lgSizeSpadCfg - 1) - log2Ceil(spadDataWidth / 8) // in bus width bytes
  val axiAddrWidth = log2Ceil(nSpadBanksTotal * (1 << lgSizeSpadBank) + lgSizeSpadCfg - 1) // in bus width bytes

  // println("axiAddrWidth", axiAddrWidth)
  val axi4Param = new AXI4BundleParameters(
                      addrBits = axiAddrWidth,
                      dataBits = spadDataWidth,
                      idBits   = idWidth) 
  
  println("lgSizeSpadCfg", lgSizeSpadCfg)
  println("AxiLiteAddrWidth", AxiLiteAddrWidth)
  // require(AxiLiteAddrWidth >= lgSizeSpadCfg - 3)
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
    spadBanksNum  = nSpadBanksTotal,
    lgSizeSpadBank= lgSizeSpadBank,
    lgSizeLastBlock= lgSizeSpadCfg,
    axiBeatBytes  = spadDataWidth / 8,

    bPortBytes    = cgraDataWidth / 8,
    hasMask       = hasMask
  ))

  val cgra = Module(new VitraCGRAController(VitraSpec.attrs, metadataPaths.axiLiteSpec.toString))

  io.s_axi          <> spad.io.s_axi
  io.s_axilite      <> cgra.io.s_axilite

  spad.io.aclk      := clock     
  spad.io.aresetn   := !reset.asBool 
  spad.io.srams     <> cgra.io.srams_iob
  spad.io.sram_last <> cgra.io.sram_cfg
}

// object SplitVerilogGen extends App {
//   (new chisel3.stage.ChiselStage).emitSystemVerilog(
//     new VitraWithAxi(),
//     Array(
//       "--split-verilog",
//       "--disable-all-randomization", // 可选
//       "--strip-debug-info"           // 可选
//     )
//   )
// }

import chisel3.stage.ChiselStage

object FirGen extends App {
  val stageArgs = Array("--target-dir", "build_ir")
  (new ChiselStage).emitFirrtl(
    new VitraWithAxi(VitraParam.targetDirFromArgs(stageArgs.toSeq)),
    stageArgs
  )
}

// object SplitVerilogGen extends App {
//   // val chiselArgs =
//   //   Array(
//   //     "--target",
//   //     "systemverilog"
//   //   )
//   // (new chisel3.stage.ChiselStage).execute(
//   //   chiselArgs,
//   //   Seq(
//   //     chisel3.stage.ChiselGeneratorAnnotation(() => new VitraWithAxi()),
//   //     firrtl.EmitAllModulesAnnotation(classOf[firrtl.SystemVerilogEmitter])
//   //   ),
//   // )

//   (new chisel3.stage.ChiselStage).emitSystemVerilogFile(
//     new VitraWithAxi(),
//     Array("--split-verilog",
//       "--target",
//       "systemverilog",
//       "--disable-all-randomization", 
//       "--strip-debug-info", 
//       "-lower-memories"),
//   )
// }



object VerilogGen extends App {
 (new chisel3.stage.ChiselStage).emitVerilog(
   new VitraWithAxi(VitraParam.targetDirFromArgs(args.toSeq)),
   args)
}


import firrtl.stage.RunFirrtlTransformAnnotation
import firrtl.transforms.{DeadCodeElimination, ConstantPropagation}

object VerilogGenFir extends App {
  (new chisel3.stage.ChiselStage).execute(
    Array(
      "-X", "verilog",
      // "--disable-all-randomization",
      // "--strip-debug-info",
      // "--remove-unused-modules"
    ),
    Seq(
      chisel3.stage.ChiselGeneratorAnnotation(() => new VitraWithAxi()),
      RunFirrtlTransformAnnotation(new DeadCodeElimination),
      RunFirrtlTransformAnnotation(new ConstantPropagation)
    )
  )
}
