package tram.vitra
import tram.vitra.dsa.{MultiTileCGRA}

import tram._
import tram.dsa._
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


/** CGRA controller
  * @param attrs     module attributes
  * CGRA control is achieved by some registers,
  * AXI Lite is controlled by independent state machine
  */
class AXICGRAController(attrs: mutable.Map[String, Any]) extends Module with IR{
  import VitraParam._
  val IRPath = rootDirPath + "/generators/fdra/cgra-mg/src/main/resources/axilite_spec.json"
  
  val idWidth = attrs("id_width").asInstanceOf[Int]
  val dataWidthCgra = attrs("cgra_data_width").asInstanceOf[Int]
  val nBanksIOB = attrs("cgra_iob_num_sides").asInstanceOf[Int] * attrs("cgra_num_colum").asInstanceOf[Int]
//  val nBanksCfg = attrs("cgra_cfg_sram_banks_cascade").asInstanceOf[Int]
//  val nBanks = nBanksIOB + nBanksCfg
  val addrWidthSram = attrs("spad_bank_lg_size").asInstanceOf[Int] - log2Ceil(dataWidthCgra/8) // add 1 per data
  val dataWidthSramCfg = attrs("spad_data_width").asInstanceOf[Int] // data width in bit
  val addrWidthSramCfg = attrs("spad_cfg_lg_size").asInstanceOf[Int] - log2Ceil(dataWidthSramCfg/8) // add 1 per data
  val hasMaskSram = false // attrs("cgra_iob_sram_has_mask").asInstanceOf[Boolean]
  val hasMaskSramCfg = false  // if has write data byte mask
  val readLatencySramCfg = 1  // read latency
  val coalesceBanksIOB = attrs("cgra_iob_sram_banks_coalesce").asInstanceOf[Int]
//  val lgMaxLoopCycles = attrs("cgra_exe_lg_max_loop_cycles").asInstanceOf[Int]  // log2(max in/out cycles)
//  val lgMaxExeCycles = attrs("cgra_exe_lg_max_execute_cycles").asInstanceOf[Int]  // log2(max execute cycles)
//  val lgMaxII = attrs("cgra_exe_lg_max_ii").asInstanceOf[Int]             // log2(max in/out Initialization Interval)
  val cfgDataWidth = attrs("cgra_cfg_data_width").asInstanceOf[Int]
  val cfgAddrWidth = attrs("cgra_cfg_addr_width").asInstanceOf[Int]
  val cfgAddrWidthAlign = attrs("cgra_cfg_addr_width_align").asInstanceOf[Int]

  val AxiLiteAddrSpace = VitraSpec.attrs("axilite_addrspace").asInstanceOf[Int] // Bytes
  val AxiLiteDataWidth = VitraSpec.attrs("axilite_datawidth").asInstanceOf[Int]   // Byte
  val AxiLiteAddrWidth = log2Ceil(AxiLiteAddrSpace)
  val AxiLiteParam = new AXI4BundleParameters(
                      addrBits = AxiLiteAddrWidth,
                      dataBits = AxiLiteDataWidth,
                      idBits   = 1) 
  val Num_regs_iob_ens = (nBanksIOB + AxiLiteDataWidth - 1) / AxiLiteDataWidth 
 

  val io = IO(new Bundle {
    // val core = new CoreIF(idWidth) /// io.core should be re-placed by axi-lite 
    val s_axilite = Flipped(new AXILiteBundle(AxiLiteParam))
    val srams_iob = Vec(nBanksIOB, Flipped(new SRAMIO(dataWidthCgra, addrWidthSram, hasMaskSram)))
    val sram_cfg  = Flipped(new SRAMIO(dataWidthSramCfg, addrWidthSramCfg, hasMaskSram))
  })
  ////////////////////////////////
  //// Registers address map defination
  ////////////////////////////////
  //// write regs
  val reg_cfg_base_addr = RegInit(0.U(AxiLiteDataWidth.W))
  val reg_cfg_num       = RegInit(0.U(AxiLiteDataWidth.W))
  val reg_cfg_en        = RegInit(false.B)
  val reg_cfg_en_next   = Wire(Bool())


  // val reg_exe_iob_ens   = Vec(Num_regs_iob_ens, RegInit(0.U(AxiLiteDataWidth.W)))
  val reg_exe_iob_ens   = Seq.fill(Num_regs_iob_ens){RegInit(0.U(AxiLiteDataWidth.W))}
  // val exe_task_id    = RegInit(0.U(AxiLiteDataWidth.W))
  val reg_exe_start     = RegInit(false.B)
  val reg_exe_start_next   = Wire(Bool())

  //// read regs
  val reg_exe_done      = RegInit(false.B)
  // val task_id_done  = RegInit(false.B)

  // val regManager = RegisterManager
  // val reg_cfg_base_addr = regManager.addRegister(AxiLiteDataWidth).asUInt
  // val reg_cfg_num = regManager.addRegister(AxiLiteDataWidth).asUInt
  // val reg_cfg_en = regManager.addRegister(1).asBool
  // val reg_exe_iob_ens = regManager.addRegister(nBanksIOB).asUInt
  // val reg_exe_start = regManager.addRegister(1).asBool

  val regMap = Map(
    reg_cfg_base_addr -> 0x0.U,
    reg_cfg_num       -> 0x1.U,
    reg_cfg_en        -> 0x2.U,
  ) ++ (0 until Num_regs_iob_ens).map { i =>
    reg_exe_iob_ens(i)-> (0x3 + i).U
  } ++ Map(
    reg_exe_start     -> (0x3 + Num_regs_iob_ens).U,
    reg_exe_done      -> (0x3 + Num_regs_iob_ens + 1).U // read only
  )

  //// Print the reg address map as a json
  apply("reg_bit_width", AxiLiteDataWidth)
  apply("axilite_addr_bit_with", AxiLiteAddrWidth)
  apply("iob_bank_num", nBanksIOB)
  
  apply("reg_cfg_base_addr", f"0x${regMap(reg_cfg_base_addr).litValue}%X")
  apply("reg_cfg_num", f"0x${regMap(reg_cfg_num).litValue}%X")
  apply("reg_cfg_en", f"0x${regMap(reg_cfg_en).litValue}%X")
  (0 until Num_regs_iob_ens).map { i =>
    apply(f"reg_exe_iob_ens_${i}", f"0x${regMap(reg_exe_iob_ens(i)).litValue}%X")
  }
  apply("reg_exe_start", f"0x${regMap(reg_exe_start).litValue}%X")
  apply("reg_exe_done", f"0x${regMap(reg_exe_done).litValue}%X")

  printIR(IRPath)
  // println(regMap, "regMap")
  ////////////////////////////////
  //// End of registers address map defination
  ////////////////////////////////


  // val cgra = Module(new CGRA(attrs))
  val cgra = Module(new MultiTileCGRA(attrs))
  
  // dontTouch(cgra.io.done)
  val cfgRegNum = cgra.cfgRegNum // config chain register number
  val cfgCtrl = Module(new ConfigController(dataWidthSramCfg, addrWidthSramCfg, hasMaskSramCfg, readLatencySramCfg,
    cfgDataWidth, cfgAddrWidth, cfgAddrWidthAlign, cfgRegNum))
  val sram_coalesce_iob = Module(new SRAMCoalesce(dataWidthCgra, addrWidthSram, hasMaskSram, nBanksIOB, coalesceBanksIOB))
  
  cgra.io.srams <> sram_coalesce_iob.io.coal
  io.srams_iob  <> sram_coalesce_iob.io.orig
  io.sram_cfg   <> cfgCtrl.io.sram

  cgra.io.cfg_en    := cfgCtrl.io.cfg_en
  cgra.io.cfg_addr  := cfgCtrl.io.cfg_addr
  cgra.io.cfg_data  := cfgCtrl.io.cfg_data

  val id            = RegInit(0.U(idWidth.W))
  val cfg_base_addr = RegInit(0.U(addrWidthSramCfg.W))
  val cfg_num       = RegInit(0.U(cfgAddrWidth.W))
  val iob_ens       = RegInit(0.U((nBanksIOB).W)) // enable signals for every IOB
  val cfg_start     = RegInit(false.B)
  val exe_start     = RegInit(false.B)
  val ex_enable     = RegInit(false.B)


  //////////////////////////////////////
  ///// CGRA Config and Exe controller
  //////////////////////////////////////
  //////////////////////////////////////
  ///// state machine
  //////////////////////////////////////
  val s_idle :: s_cfg_run :: s_exe_wait :: s_exe_start :: s_exe_run :: Nil = Enum(5)  
  val cgra_state = RegInit(s_idle) /// cgra state

  switch(cgra_state){
    is(s_idle){
      ex_enable := false.B
      when(reg_cfg_en){
        cgra_state    := s_cfg_run
        cfg_base_addr := reg_cfg_base_addr
        cfg_num       := reg_cfg_num
        cfg_start     := true.B
      }
      .elsewhen(reg_exe_start){
        cgra_state  := s_exe_start
        iob_ens     := Cat(reg_exe_iob_ens.reverse)(nBanksIOB-1, 0) // reverse the bits
        exe_start   := true.B
        reg_exe_done := false.B  
      }
    }
    is(s_cfg_run){
      cfg_start := false.B
      when(cfgCtrl.io.done){ // indicate config is running
        cgra_state := s_idle
      }
      .elsewhen(reg_exe_start){
        cgra_state := s_exe_wait
      }
    }
    is(s_exe_wait){
      reg_exe_done := false.B
      when(cfgCtrl.io.done){ // indicate config is running
        cgra_state:= s_exe_start
        iob_ens   := Cat(reg_exe_iob_ens.reverse)(nBanksIOB-1, 0)
        exe_start := true.B
      }
    }
    is(s_exe_start){
      exe_start := false.B
      ex_enable := true.B   
      when(!cgra.io.done){ // indicate execution is running
        cgra_state := s_exe_run
      } 
    }
    is(s_exe_run){
      when(cgra.io.done){ // indicate execution is running
        ex_enable := false.B 
        cgra_state := s_idle
        reg_exe_done := true.B
      } 
    }
  }  
  //////////////////////////////////////
  ///// combination logic
  //////////////////////////////////////
  cfgCtrl.io.start      := cfg_start
  cfgCtrl.io.base_addr  := cfg_base_addr
  cfgCtrl.io.cfg_num    := cfg_num

  cgra.io.start   := exe_start
  cgra.io.en      := ex_enable
  cgra.io.iob_ens := iob_ens

  val cfg_avail = Wire(Bool())
  val exe_avail = Wire(Bool())
  cfg_avail := cgra_state === s_idle
  exe_avail := cgra_state === s_idle | cgra_state === s_cfg_run

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
        reg_cfg_base_addr := Mux(w_reg_addr === regMap(reg_cfg_base_addr),
                                  io.s_axilite.w.bits.data,
                                  reg_cfg_base_addr)

        reg_cfg_num := Mux(w_reg_addr === regMap(reg_cfg_num),
                            io.s_axilite.w.bits.data,
                            reg_cfg_num)

        // reg_cfg_en := Mux(w_reg_addr === regMap(reg_cfg_en),
        //                     io.s_axilite.w.bits.data(0),
        //                     reg_cfg_en)

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
  when(w_state === s_w_write_cfg_en & cfg_avail){
    io.s_axilite.w.ready := true.B
  }
  .elsewhen(w_state === s_w_write_exe_start & exe_avail){
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
                          Mux(cgra_state === s_cfg_run,
                            false.B,
                            reg_cfg_en
                          )
                    )
  reg_cfg_en := reg_cfg_en_next

  //// reg_exe_start
  reg_exe_start_next := Mux(w_state === s_w_write_exe_start,
                          io.s_axilite.w.bits.data(0),
                          Mux(cgra_state === s_exe_run,
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