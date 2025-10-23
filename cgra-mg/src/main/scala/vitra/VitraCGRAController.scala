package tram.vitra
// import tram.vitra.dsa.{SingleTileCGRA}
import tram.vitra.dsa.{MultiTileCGRA, MultiTileSRAMCoalesce}

import tram._
import tram.dsa.{SRAMIO}
// import tram.spec._
import tram.vitra.spec._
import tram.ir._
import tram.axi.{AXILiteBundle}
import TramISA._

import chisel3._
import chisel3.util._
import freechips.rocketchip.tile._
//import freechips.rocketchip.config._
import freechips.rocketchip.rocket._
import freechips.rocketchip.regmapper._
import freechips.rocketchip.amba.axi4.{AXI4BundleParameters, AXI4Bundle}

import org.chipsalliance.cde.config._
import scala.collection.mutable 


class TileStateCtrl(numIOB: Int) extends Module {
 val io = IO(new Bundle {
    // Inputs
    val cfgStartReq = Input(Bool())
    val cfgDoneIn   = Input(Bool())
    val exeStartReq = Input(Bool())
    val exeIobEnReq = Input(UInt(numIOB.W)) // will be saved when exeStartReq and can be changed to next after exeStartReq
    val exeDoneIn   = Input(Bool())

    // Outputs
    val cfgDone   = Output(Bool()) // state indictator: cfg done signal, default to be high
    val exeDone   = Output(Bool()) // state indictator: exe done signal, keep true until next start

    val exeStartP = Output(Bool()) // exe start pulse to iob, should be valid before latency 0, namely -1
    val exeIobEn  = Output(UInt(numIOB.W)) // keep still during once exe
    val exeEn     = Output(Bool()) // exe enable signal to tile
  })

  // val exeDoneReg  = RegInit(false.B)
  val exeIobEnReg = RegInit(0.U(numIOB.W))
  //////////////////////////////////////
  ///// state machine
  //////////////////////////////////////
  val s_idle :: s_cfg_wait :: s_cfg_run :: s_exe_wait :: s_exe_start :: s_exe_run :: Nil = Enum(6)  
  val tile_state = RegInit(s_idle) /// cgra state

  switch(tile_state){
    is(s_idle){
      when(io.cfgStartReq){
        tile_state    := s_cfg_wait
      }
      .elsewhen(io.exeStartReq){
        tile_state  := s_exe_start
        exeIobEnReg := io.exeIobEnReq
        // exeDoneReg  := false.B  
      }
    }
    is(s_cfg_wait){
      tile_state := s_cfg_run
    }
    is(s_cfg_run){
      when(io.cfgDoneIn){ // indicate config is running
        tile_state := s_idle
      }
      .elsewhen(io.exeStartReq){
        exeIobEnReg := io.exeIobEnReq
        tile_state := s_exe_wait
      }
    }
    is(s_exe_wait){
      // exeDoneReg := false.B
      when(io.cfgDoneIn){ // indicate config is running
        tile_state:= s_exe_start
      }
    }
    is(s_exe_start){
      /// generate exe start pulse
      tile_state := s_exe_run
    }
    is(s_exe_run){
      when(io.exeDoneIn){ // indicate execution is running
        tile_state := s_idle
        // exeDoneReg := true.B
      } 
    }
  }  


  ///////////////
  /// Combination logic
  ///////////////
  io.cfgDone    := tile_state=/=s_cfg_wait && tile_state=/=s_cfg_run
  io.exeDone    := tile_state=/=s_exe_wait && tile_state=/=s_exe_start && tile_state=/=s_exe_run

  io.exeStartP  := tile_state===s_exe_start
  io.exeEn      := tile_state===s_exe_run
  io.exeIobEn   := exeIobEnReg
}

/** CGRA controller
  * @param attrs     module attributes
  * CGRA control is achieved by some registers,
  * AXI Lite is controlled by independent state machine
  */
class VitraCGRAController(attrs: mutable.Map[String, Any]) extends Module with IR{
  import VitraParam._
  
  val idWidth = attrs("id_width").asInstanceOf[Int]
  val dataWidthCgra = attrs("cgra_data_width").asInstanceOf[Int]
  val nBanksIOB = attrs("cgra_iob_num_sides").asInstanceOf[Int] * attrs("tile_num_column").asInstanceOf[Int]
  val nTiles = attrs("cgra_tile_num").asInstanceOf[Int]
//  val nBanksCfg = attrs("cgra_cfg_sram_banks_cascade").asInstanceOf[Int]
//  val nBanks = nBanksIOB + nBanksCfg
  val addrWidthSram = attrs("spad_bank_lg_size").asInstanceOf[Int] - log2Ceil(dataWidthCgra/8) // add 1 per data
  val dataWidthSramCfg = attrs("spad_data_width").asInstanceOf[Int] // data width in bit
  val byteWidthSramCfg = dataWidthSramCfg / 8
  val addrWidthSramCfg = attrs("spad_cfg_lg_size").asInstanceOf[Int] - log2Ceil(dataWidthSramCfg/8) // add 1 per data
  val hasMaskSram = attrs("cgra_iob_sram_has_mask").asInstanceOf[Boolean]
  val hasMaskSramCfg = false  // if has write data byte mask
  val readLatencySramCfg = 1  // read latency
  val coalesceBanksIOB = attrs("cgra_iob_sram_banks_coalesce").asInstanceOf[Int]
//  val lgMaxLoopCycles = attrs("cgra_exe_lg_max_loop_cycles").asInstanceOf[Int]  // log2(max in/out cycles)
//  val lgMaxExeCycles = attrs("cgra_exe_lg_max_execute_cycles").asInstanceOf[Int]  // log2(max execute cycles)
//  val lgMaxII = attrs("cgra_exe_lg_max_ii").asInstanceOf[Int]             // log2(max in/out Initialization Interval)
  val cfgDataWidth = attrs("cgra_cfg_data_width").asInstanceOf[Int]
  val cfgAddrWidth = attrs("cgra_cfg_addr_width").asInstanceOf[Int]
  val cfgAddrWidthAlign = attrs("cgra_cfg_addr_width_align").asInstanceOf[Int]

  val AxiLiteAddrSpace = attrs("axilite_addrspace").asInstanceOf[Int] // Bytes
  val AxiLiteDataWidth = attrs("axilite_datawidth").asInstanceOf[Int]   // Byte
  val AxiLiteAddrWidth = log2Ceil(AxiLiteAddrSpace)
  val AxiLiteParam = new AXI4BundleParameters(
                      addrBits = AxiLiteAddrWidth,
                      dataBits = AxiLiteDataWidth,
                      idBits   = 1) 

  val io = IO(new Bundle {
    // val core = new CoreIF(idWidth) /// io.core should be re-placed by axi-lite 
    val s_axilite = Flipped(new AXILiteBundle(AxiLiteParam))
    val srams_iob = Vec(nTiles * nBanksIOB, Flipped(new SRAMIO(dataWidthCgra, addrWidthSram, hasMaskSram)))
    val sram_cfg  = Flipped(new SRAMIO(dataWidthSramCfg, addrWidthSramCfg, hasMaskSram))
  })
  ////////////////////////////////
  //// Registers address map defination
  ////////////////////////////////
  val Num_regs_cfg_base_addr =  (cfgAddrWidth / AxiLiteDataWidth) + 1
  val Num_regs_cfg_num = (cfgAddrWidth / AxiLiteDataWidth) + 1
  val Num_regs_cfg_en  = (cfgAddrWidth / AxiLiteDataWidth) + 1
  val Num_reg_cfg_en_tile = (nTiles / AxiLiteDataWidth) + 1
  val Num_regs_iob_ens = (nTiles * nBanksIOB + AxiLiteDataWidth - 1) / AxiLiteDataWidth 
  // val Num_regs_start   = (nTiles / AxiLiteDataWidth) + 1
  val Num_regs_done    = (nTiles / AxiLiteDataWidth) + 1
  val offsetBits       = math.min(/*4bytes*/ 2, log2Ceil(AxiLiteDataWidth))

  //// writable regs
  val reg_cfg_base_addr = Seq.fill(Num_regs_cfg_base_addr){RegInit(0.U(AxiLiteDataWidth.W))}
  val reg_cfg_num       = Seq.fill(Num_regs_cfg_num){RegInit(0.U(AxiLiteDataWidth.W))}
  val reg_cfg_en_tile   = Seq.fill(Num_reg_cfg_en_tile){RegInit(0.U(AxiLiteDataWidth.W))}

  val reg_cfg_en        = RegInit(false.B)
  val reg_cfg_en_next   = Wire(Bool())

  val reg_exe_iob_ens   = Seq.fill(Num_regs_iob_ens){RegInit(0.U(AxiLiteDataWidth.W))}
  val reg_exe_start     = RegInit(false.B)
  val reg_exe_start_next   = Wire(Bool())

  //// readable regs
  val reg_exe_done      = Seq.fill(Num_regs_done){Wire(UInt(AxiLiteDataWidth.W))}

  val regMap : Map[UInt, UInt] = (
    /// cfg regs
    (0 until Num_regs_cfg_base_addr).map { i =>
      reg_cfg_base_addr(i) -> (i << offsetBits).U
    } ++ (0 until Num_regs_cfg_num).map { i =>
      reg_cfg_num(i)       -> ((i + Num_regs_cfg_base_addr) << offsetBits).U
    } ++ (0 until Num_reg_cfg_en_tile).map { i =>
      reg_cfg_en_tile(i)   -> ((i + Num_regs_cfg_base_addr + Num_regs_cfg_num)<< offsetBits).U
    } ++ Map(
      reg_cfg_en        -> ((Num_regs_cfg_base_addr + Num_regs_cfg_num + Num_reg_cfg_en_tile) << offsetBits).U,
    ) 
    /// exe regs
    ++ (0 until Num_regs_iob_ens).map { i =>
      reg_exe_iob_ens(i)  -> ((i + Num_regs_cfg_base_addr + Num_regs_cfg_num + Num_reg_cfg_en_tile + 0x1) << offsetBits).U
    } ++ Map(
      reg_exe_start     -> ((Num_regs_cfg_base_addr + Num_regs_cfg_num + Num_reg_cfg_en_tile + 0x1 
                            + Num_regs_iob_ens) << offsetBits).U,
    ) ++ (0 until Num_regs_done).map { i =>
      reg_exe_done(i)     -> ((i + Num_regs_cfg_base_addr + Num_regs_cfg_num + Num_reg_cfg_en_tile + 0x1 
                              + Num_regs_iob_ens + 0x1) << offsetBits).U
    }
  ).toMap

  //// Print the reg address map as a json
  apply("reg_bit_width", AxiLiteDataWidth)
  apply("axilite_addr_bit_with", AxiLiteAddrWidth)
  apply("tile_iob_bank_num", nBanksIOB)
  apply("tile_num", nTiles)
  
  // apply("reg_cfg_base_addr", f"0x${regMap(reg_cfg_base_addr).litValue}%X")
  (0 until Num_regs_cfg_base_addr).map { i =>
    apply(f"reg_cfg_base_addr_${i}", f"0x${regMap(reg_cfg_base_addr(i)).litValue}%X")
  }

  (0 until Num_regs_cfg_num).map { i =>
    apply(f"reg_cfg_num_${i}", f"0x${regMap(reg_cfg_num(i)).litValue}%X")
  }

  (0 until Num_reg_cfg_en_tile).map { i =>
    apply(f"reg_cfg_en_tile_${i}", f"0x${regMap(reg_cfg_en_tile(i)).litValue}%X")
  }  

  apply("reg_cfg_en", f"0x${regMap(reg_cfg_en).litValue}%X")

  (0 until Num_regs_iob_ens).map { i =>
    apply(f"reg_exe_iob_ens_${i}", f"0x${regMap(reg_exe_iob_ens(i)).litValue}%X")
  }

  apply(f"reg_exe_start", f"0x${regMap(reg_exe_start).litValue}%X")

  (0 until Num_regs_done).map { i =>
    apply(f"reg_exe_done_${i}", f"0x${regMap(reg_exe_done(i)).litValue}%X")
  }

  printIR(axil_reg_spec_filename)
  println(s"axilite reg spec path: $axil_reg_spec_filename")
  // println(regMap, "regMap")
  ////////////////////////////////
  //// End of registers address map defination
  ////////////////////////////////

  ////////////////////////////////
  //// Start cgra controller
  ////////////////////////////////
  // val cgra = Module(new CGRA(attrs))
  // val cgra = Module(new SingleTileCGRA(attrs))
  val cgra = Module(new MultiTileCGRA(attrs))
  
  // dontTouch(cgra.io.done)
  val cfgRegNum = cgra.cfgRegNum // config chain register number
  val cfgBroadcastBufferLevel = 1 // for one level buffer's latency in broadcast the config to every tile
  val cfgCtrl = Module(new ConfigController(dataWidthSramCfg, addrWidthSramCfg, hasMaskSramCfg, readLatencySramCfg,
    cfgDataWidth, cfgAddrWidth, cfgAddrWidthAlign, cfgRegNum,
    cfgBroadcastBufferLevel))

  val sram_coalesce_iob = Module(new MultiTileSRAMCoalesce(dataWidthCgra, addrWidthSram, hasMaskSram, nTiles, nBanksIOB, coalesceBanksIOB))
  
  cgra.io.srams     <> sram_coalesce_iob.io.coal
  io.srams_iob      <> sram_coalesce_iob.io.orig
  io.sram_cfg       <> cfgCtrl.io.sram

  // cgra.io.cfg_en    := cfgCtrl.io.cfg_en
  cgra.io.cfg_addr  := cfgCtrl.io.cfg_addr
  cgra.io.cfg_data  := cfgCtrl.io.cfg_data

  val id            = RegInit(0.U(idWidth.W))
  val cfg_base_addr = RegInit(0.U(addrWidthSramCfg.W))
  val cfg_num       = RegInit(0.U(cfgAddrWidth.W))
  val cfg_en_tiles  = RegInit(0.U((nTiles).W))
  val iob_ens       = RegInit(0.U((nBanksIOB*nTiles).W)) // enable signals for every IOB
  val cfg_start     = RegInit(false.B)
  val exe_start     = RegInit(false.B)

  val exe_en_tiles  = VecInit((0 until nTiles).map { t =>
    val lo = t * nBanksIOB
    val hi = (t + 1) * nBanksIOB - 1
    iob_ens(hi, lo).orR
  }).asUInt

  //////////////////////////////////////
  ///// CGRA Config and Exe controller
  //////////////////////////////////////
  val tile_cfg_done = Wire(Vec(nTiles, Bool()))
  val tile_exe_run  = Wire(Vec(nTiles, Bool()))
  val cfg_avail = Wire(Bool()) // no conflict with current cfg requset
  val exe_avail = Wire(Bool()) // no conflict with current exe requset
  
  //////////////////////////////////////
  ///// state ctrl for whole CGRA
  //////////////////////////////////////
  val s_cgra_idle :: s_cgra_cfg_wait :: s_cgra_cfg_start :: s_cgra_cfg_run :: s_cgra_exe_wait :: s_cgra_exe :: Nil = Enum(6)
  val cgra_state = RegInit(s_cgra_idle) /// cgra state

  switch(cgra_state){
    is(s_cgra_idle){
      //// could emit cfg or exe
      when(reg_cfg_en){
        cgra_state    := s_cgra_cfg_wait
        cfg_base_addr := Cat(reg_cfg_base_addr.reverse)(AxiLiteDataWidth * Num_regs_cfg_base_addr - 1, log2Ceil(byteWidthSramCfg))
        cfg_num       := Cat(reg_cfg_num.reverse)
        cfg_en_tiles  := Cat(reg_cfg_en_tile.reverse)
      }
      .elsewhen(reg_exe_start){
        cgra_state  := s_cgra_exe_wait
        iob_ens := Cat(reg_exe_iob_ens.reverse)(nBanksIOB*nTiles-1, 0)
      }
    }
    is(s_cgra_cfg_wait){
      //// check the permission of emit cfg
      when(cfg_avail){
        cgra_state := s_cgra_cfg_run
        cfg_start  := true.B
      }
    }
    is(s_cgra_cfg_run){
      //// cfg is running
      cfg_start  := false.B
      when(cfgCtrl.io.done){ // indicate config is running
        cgra_state := s_cgra_idle
      }
      .elsewhen(reg_exe_start){
        cgra_state := s_cgra_exe_wait
        iob_ens := Cat(reg_exe_iob_ens.reverse)(nBanksIOB*nTiles-1, 0)
      }
    }
    is(s_cgra_exe_wait){
      //// check the permission of emit exe
      when(exe_avail){ // indicate config is running
        cgra_state:= s_cgra_exe
        exe_start := true.B
      }
    }
    is(s_cgra_exe){
      //// emit exe
      /// generate exe start pulse
      exe_start := false.B
      when(cfgCtrl.io.done){
        cgra_state := s_cgra_idle
      }
      .otherwise{
        cgra_state := s_cgra_cfg_run
      }

    }
  }  

  //////////////////////////////////////
  ///// state ctrl for each tile
  //////////////////////////////////////
  val exeDoneBits = Wire(Vec(nTiles, Bool()))
  val tileStates = Seq.fill(nTiles)(Module(new TileStateCtrl(nBanksIOB)))
  tileStates.zipWithIndex.foreach { case (tileState, idx) =>
    tileState.io.cfgStartReq  := cfg_start & cfg_en_tiles(idx)
    tileState.io.cfgDoneIn    := cfgCtrl.io.done
    tileState.io.exeStartReq  := exe_start & exe_en_tiles(idx)
    tileState.io.exeIobEnReq  := iob_ens((idx + 1) * nBanksIOB - 1, idx * nBanksIOB)
    tileState.io.exeDoneIn    := cgra.io.done(idx)

    cgra.io.start(idx)        := tileState.io.exeStartP // pulse signal, should be valid before latency 0, namely -1
    cgra.io.en(idx)           := tileState.io.exeEn
    cgra.io.iob_ens(idx)      := tileState.io.exeIobEn
    tile_cfg_done(idx)        := tileState.io.cfgDone
    // println(reg_exe_done)
    // println(reg_exe_done(idx/AxiLiteDataWidth))
    // reg_exe_done(idx/AxiLiteDataWidth)(idx%AxiLiteDataWidth) := tileState.io.exeDone
    exeDoneBits(idx) := tileState.io.exeDone

    cgra.io.cfg_en(idx)       := cfg_en_tiles(idx) & cfgCtrl.io.cfg_en
    tile_exe_run(idx)         := tileState.io.exeEn | tileState.io.exeStartP
  }


  for (w <- 0 until Num_regs_done) {
    val lo = w * AxiLiteDataWidth
    val hi = math.min(lo + AxiLiteDataWidth, nTiles)

    val slice = (lo until hi).map(i => exeDoneBits(i).asUInt)                  
    val pad   = Seq.fill(AxiLiteDataWidth - (hi - lo))(0.U(1.W))               

    reg_exe_done(w) := Cat((slice ++ pad).reverse)
  }
  //////////////////////////////////////
  ///// combination logic
  //////////////////////////////////////
  cfgCtrl.io.start      := cfg_start
  cfgCtrl.io.base_addr  := cfg_base_addr
  cfgCtrl.io.cfg_num    := cfg_num

  cfg_avail := ((cgra_state === s_cgra_idle | cgra_state === s_cgra_cfg_wait) 
                & ~((cfg_en_tiles & ~(tile_cfg_done.asUInt)).orR) // orR: reduction, every selected tile must be cfg done
                & ~((cfg_en_tiles & tile_exe_run.asUInt).orR))   // orR: reduction, every selected tile must not be exe running
  
  exe_avail := (cgra_state =/= s_cgra_exe 
                // & ~((exe_en_tiles & ~(tile_cfg_done.asUInt)).orR) // orR: reduction, every selected tile must be cfg done
                & ~((exe_en_tiles & tile_exe_run.asUInt).orR))   // orR: reduction, every selected tile must not be exe running


  //////////////////////////////////////
  ///// AXI lite controller
  //////////////////////////////////////
  //////////////////////////////////////
  ///// write state machine
  //////////////////////////////////////
  //// state variables
  val w_reg_addr = RegInit(0.U(AxiLiteAddrWidth.W))

  // val s_idle :: s_cfg_run :: s_cfg_resp :: s_exe_wait :: s_exe_run :: s_exe_resp :: Nil = Enum(6)
  val s_w_idle :: s_w_write_cfg_en :: s_w_write_exe_start :: s_w_write_other_reg :: s_b_valid :: Nil = Enum(5)  
  val w_state = RegInit(s_w_idle)

  switch(w_state){
    is(s_w_idle){
      when(io.s_axilite.aw.fire){
        // when(io.s_axilite.aw.bits.addr === regMap(reg_exe_start)){
          w_state := Mux(io.s_axilite.aw.bits.addr === regMap(reg_cfg_en),
                          s_w_write_cfg_en,
                          Mux(io.s_axilite.aw.bits.addr === regMap(reg_exe_start),
                            s_w_write_exe_start,
                            s_w_write_other_reg))
          w_reg_addr := io.s_axilite.aw.bits.addr
        // }
        //// TODO: how to handle id
      }
    }
    is(s_w_write_cfg_en){
      when(io.s_axilite.w.fire) {
        // reg_cfg_en := io.s_axilite.w.bits.data(0)
        w_state := s_b_valid
      }
    }
    is(s_w_write_exe_start){
      when(io.s_axilite.w.fire) {
        // reg_exe_start := io.s_axilite.w.bits.data(0)
        w_state := s_b_valid
      }
    }
    is(s_w_write_other_reg){
      when(io.s_axilite.w.fire) {
        /// transfer to when here
        (0 until Num_regs_cfg_base_addr).map { i =>
          reg_cfg_base_addr(i) := Mux(w_reg_addr === regMap(reg_cfg_base_addr(i)),
                                  io.s_axilite.w.bits.data,
                                  reg_cfg_base_addr(i))
        } 

        (0 until Num_regs_cfg_num).map { i =>
          reg_cfg_num(i) := Mux(w_reg_addr === regMap(reg_cfg_num(i)),
                              io.s_axilite.w.bits.data,
                              reg_cfg_num(i))
        }

        (0 until Num_reg_cfg_en_tile).map { i =>
          reg_cfg_en_tile(i) := Mux(w_reg_addr === regMap(reg_cfg_en_tile(i)),
                              io.s_axilite.w.bits.data,
                              reg_cfg_en_tile(i))
        }



        // reg_exe_iob_ens Vec
        for (i <- 0 until Num_regs_iob_ens) {
          reg_exe_iob_ens(i) := Mux(w_reg_addr === regMap(reg_exe_iob_ens(i)),
                                      io.s_axilite.w.bits.data,
                                      reg_exe_iob_ens(i))
        }

        // reg_exe_start := Mux(w_reg_addr === regMap(reg_exe_start),
        //                       io.s_axilite.w.bits.data(0),
        //                       reg_exe_start)

        w_state := s_b_valid
      }
    }
    is(s_b_valid){
      when(io.s_axilite.b.fire){
        w_state := s_w_idle
      }
    }
  }
  //// axilite channels
  /// aw channel
  io.s_axilite.aw.ready  := (w_state === s_w_idle)
  /// w channel
  when(w_state === s_w_write_cfg_en & cgra_state === s_cgra_idle){
    io.s_axilite.w.ready := true.B
  }
  .elsewhen(w_state === s_w_write_exe_start 
          & (cgra_state === s_cgra_idle | cgra_state === s_cgra_cfg_run)){
    io.s_axilite.w.ready := true.B    
  }
  .elsewhen(w_state === s_w_write_other_reg){
    io.s_axilite.w.ready := true.B    
  }
  .otherwise{
    io.s_axilite.w.ready := false.B    
  }
  
  /// b channel
  io.s_axilite.b.valid      := (w_state === s_b_valid)
  io.s_axilite.b.bits.resp  := 0.U

  //////////////////////////////////////
  ///// read state machine
  //////////////////////////////////////
  //// state variables
  val r_reg_addr = RegInit(0.U(AxiLiteAddrWidth.W))
  val r_data = Wire(UInt(AxiLiteDataWidth.W))

  val s_r_idle :: s_r_read_reg :: Nil = Enum(2)  
  val r_state = RegInit(s_r_idle)

  switch(r_state){
    is(s_r_idle){
      when(io.s_axilite.ar.fire){
        r_state := s_r_read_reg
        r_reg_addr := io.s_axilite.ar.bits.addr
        //// TODO: how to handle id
      }
    }
    is(s_r_read_reg){
      when(io.s_axilite.r.fire) {
        r_state := s_r_idle
      }
    }
  }

  /////////////////////////
  //// Combination logic
  /////////////////////////
  val AddrRegTable = regMap.map { case (reg, addr) => addr -> reg }.toSeq
  r_data := MuxLookup(r_reg_addr, 0.U, AddrRegTable)

  //// reg_cfg_en
  reg_cfg_en_next := Mux(w_state === s_w_write_cfg_en,
                          io.s_axilite.w.bits.data(0),
                          Mux(cgra_state === s_cgra_cfg_run | cgra_state === s_cgra_cfg_run,
                            false.B,
                            reg_cfg_en
                          )
                    )
  reg_cfg_en := reg_cfg_en_next

  //// reg_exe_start
  reg_exe_start_next := Mux(w_state === s_w_write_exe_start,
                          io.s_axilite.w.bits.data(0),
                          Mux(cgra_state === s_cgra_cfg_wait
                            | cgra_state === s_cgra_exe_wait | cgra_state === s_cgra_exe,
                            false.B,
                            reg_exe_start
                          )
                    )
  reg_exe_start := reg_exe_start_next
  
  //// axilite channels
  /// ar channel
  io.s_axilite.ar.ready     := (r_state === s_r_idle)
  /// r channel
  io.s_axilite.r.valid      := (r_state === s_r_read_reg)
  io.s_axilite.r.bits.data  := r_data
  io.s_axilite.r.bits.resp  := 0.U
}



object VerilogGenWithoutSRAM extends App {
 (new chisel3.stage.ChiselStage).emitVerilog(new VitraCGRAController(VitraSpec.attrs), args)
}