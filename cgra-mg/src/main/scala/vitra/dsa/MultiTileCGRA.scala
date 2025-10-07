package tram.vitra.dsa

import chisel3._
import chisel3.util._
import scala.collection.mutable
import scala.collection.mutable.{ArrayBuffer, ListBuffer}
import tram.op._
import tram.ir._
import tram.common.MacroVar._
import tram.dsa.{SRAMIO, IOB, GPE, GIB}

/** CGRA module
 * @param attrs     module attributes
 */ 
class MultiTileCGRA(attrs: mutable.Map[String, Any]) extends Module with IR{
  override def desiredName = "CGRA"
  // CGRA parameters
  val param = MultiTileCgraParam(attrs)
  import param._

  val lgMaxCnt = attrs("cgra_lg_max_cycles").asInstanceOf[Int] * attrs("cgra_iob_ag_nest_levels").asInstanceOf[Int] // log2(max in/out cycles)
  apply("tile_num_row", tile_rows)
  apply("tile_num_col", tile_cols)
  apply("cgra_tile_num", tile_num)

  apply("data_width", dataWidth)
  apply("cfg_data_width", cfgDataWidth)
  apply("cfg_addr_width", cfgAddrWidth)
  apply("cfg_blk_offset", cfgBlkOffset)
//  apply("gib_num_track", numTrack)                // for debug
//  apply("gib_connect_flexibility", fcMap)         // for debug
//  apply("gib_diag_iopin_connect", diagPinConect)  // for debug
  // apply("num_input", numIOB)  // represented by IOB
  // apply("num_output", numIOB)
  apply("tile_num_input", tile_numIOB)  // represented by IOB
  apply("tile_num_output", tile_numIOB)  
  apply("iob_mode_names", iobModeNames)
  apply("iob_ag_nest_levels", agNestLevels)
  apply("iob_to_spad_banks", iob_to_spad_banks)
  apply("iob_spad_bank_size", (1 << spad_bank_lg_size))
  apply("cfg_spad_size", (1 << cfg_spad_lg_size))
  apply("cfg_spad_data_width", cfg_spad_data_width)
  apply("cfg_tile_offset", cfgTileOffset)
  apply("tile_modules", tile_numSubModules)
  println("cfg_tile_offset", cfgTileOffset)
  
  apply("connection_format", ("src_id", "src_type", "src_out_idx", "dst_id", "dst_type", "dst_in_idx"))
  // This:src_out_idx is the input index
  // This:dst_in_idx is the output index
  val connections = ListBuffer[(Int, String, Int, Int, String, Int)]()

  val io = IO(new Bundle{
    // config signals
    val cfg_en   = Input(Vec(tile_num, Bool()))
    // val cfg_en_w = Input(Bool())
    val cfg_addr = Input(UInt(cfgAddrWidth.W))
    val cfg_data = Input(UInt(cfgDataWidth.W))
//    val ii = Input(UInt(lgMaxII.W)) // Initialization Interval, shared among all IOB
//    val cycles = Input(UInt(lgMaxCycles.W)) // valid in/out cycles, shared among all IOB
    val iob_ens = Input(Vec(tile_num, UInt(tile_numIOB.W))) // enable signals for every IOB
    // computing signals
    val en  = Input(Vec(tile_num, Bool())) // enable for each component in array
    // val en_break  = Input(Bool())
    // val cnt_break = Input(UInt(lgMaxCnt.W))
    // val start = Input(Bool()) // pulse signal, should be valid before latency 0, namely -1
    // val done = Output(Bool()) // transfer done, keep true until next start
    val start = Input(Vec(tile_num, Bool())) // pulse signal, should be valid before latency 0, namely -1
    val done = Output(Vec(tile_num, Bool())) // transfer done, keep true until next start

    val srams = Vec(tile_num, Vec(tile_numIOB, Flipped(new SRAMIO(dataWidth, addrWidthSram, hasMaskSram))))
  })

  val gpe_attrs: mutable.Map[String, Any] = mutable.Map(
    "data_width" -> dataWidth,
    "cfg_data_width" -> cfgDataWidth,
    "cfg_addr_width" -> cfgAddrWidth,
    "cfg_blk_index" -> 0,
    "cfg_blk_offset" -> cfgBlkOffset,
    "x" -> 0,
    "y" -> 0,
    "tile" -> 0,
    "operations" -> ListBuffer(),
    "num_input_per_operand" -> ListBuffer(),
    "max_delay" -> 4,
    "lg_max_lat" -> lgMaxLat,
    "lg_max_wi" -> lgMaxCycles,
    "lg_max_cycles" -> lgMaxCycles,
    "lg_max_repeats" -> lgMaxCycles,
    "lg_max_ii" -> lgMaxII,
  )

  val gib_attrs: mutable.Map[String, Any] = mutable.Map(
    "data_width" -> dataWidth,
    "cfg_data_width" -> cfgDataWidth,
    "cfg_addr_width" -> cfgAddrWidth,
    "cfg_blk_index" -> 0,
    "cfg_blk_offset" -> cfgBlkOffset,
    "x" -> 0,
    "y" -> 0,
    "tile" -> 0,
    "num_track" -> numTrack,
    "diag_iopin_connect" -> true,
    "num_iopin_list" -> mutable.Map[String, Int](),
    "connect_flexibility" -> List(2, 2, 4),
	  "track_reged" -> false,
    "track_directions" -> ListBuffer()
  )

  val iob_attrs: mutable.Map[String, Any] = mutable.Map(
    "data_width" -> dataWidth,
    "cfg_data_width" -> cfgDataWidth,
    "cfg_addr_width" -> cfgAddrWidth,
    "cfg_blk_index" -> 0,
    "cfg_blk_offset" -> cfgBlkOffset,
    "x" -> 0,
    "y" -> 0,
    "tile" -> 0,
    "iob_index" -> 0,
    "addr_width_sram" -> addrWidthSram,
    "has_mask_sram" -> hasMaskSram,
    "add_reg_sram" -> addRegSram,
    "iob_mode" -> SRAM_MODE,
    "lg_max_lat" -> lgMaxLat,
    "lg_max_ii" -> lgMaxII,
    "lg_max_stride" -> lgMaxStride,
    "lg_max_cycles" -> lgMaxCycles,
    "ag_nest_levels" -> agNestLevels,
    "lg_max_Init" -> lgMaxInit,
    "max_delay" -> 4,
    "num_input_per_operand" -> ListBuffer()
  )

  // ======= sub_modules attribute ========//
  // 1-n : sub-modules
  //  indicate different sub module types
  val sm_id: mutable.Map[String, ListBuffer[Int]] = mutable.Map(
    "IOB" -> ListBuffer[Int](),
    "GPE" -> ListBuffer[Int](), 
    "GIB" -> ListBuffer[Int]()  
  )

  // ======= sub_module instances attribute ========//
  // 0 : this module
  // 1-n : sub-module instances 
  val smi_id: mutable.Map[String, ListBuffer[Int]] = mutable.Map(
    "This" -> ListBuffer(0),
    "IOB" -> ListBuffer[Int](),  // id = cfg_blk_idx
    "GPE" -> ListBuffer[Int](), // id = cfg_blk_idx
    "GIB" -> ListBuffer[Int]()  // id = cfg_blk_idx
  )
  var sm_id_offset = 0
  val iob_type_modid : mutable.Map[Int , Int] = mutable.Map()
  val gpe_type_modid : mutable.Map[Int , Int] = mutable.Map()
  val gib_type_modid : mutable.Map[Int , Int] = mutable.Map()
  // sub-module id to attribute
  val sm_id_attrs = mutable.Map[Int, mutable.Map[String, Any]]()
  // sub-module instance id to attribute
  val smi_id_attrs = mutable.Map[Int, mutable.Map[String, Any]]()
  var cfgRegNum = 0

  val iobs = new ArrayBuffer[IOB]()
  val pes = new ArrayBuffer[GPE]()
  val gibs = new ArrayBuffer[GIB]()

  var unconnectedIOBs  = mutable.Map[Int, IOB]() //// iob index -> iob
  var unconnectedGPEs  = mutable.Map[(Int, Int), GPE]() //// GPE x y -> GPE
  var unconnectedGIBs  = mutable.Map[(Int, Int), GIB]() //// GIB x y -> GIB
  for(tile <- 0 until tile_num){
    //////////////////////////////
    /// Construct single tile
    //////////////////////////////

    val row_idxs_iob = ListBuffer[Int]()
    val row_idxs_pe = ListBuffer[Int]()
    val row_idxs_gib = ListBuffer[Int]()
    val col_idxs_iob = ListBuffer[Int]()
    val col_idxs_pe = ListBuffer[Int]()
    val col_idxs_gib = ListBuffer[Int]()
    row_idxs_iob += 0
    var idx = 1
    for(i <- 0 to tile_rows){
      row_idxs_gib += idx
      idx += 1
      if(i < tile_rows){
        row_idxs_pe += idx
        idx += 1
      }
    }
    if(numIOBSides > 1){
      row_idxs_iob += idx
      idx += 1
    }
    val totalRows = idx

    var col_idx = 1
    col_idxs_iob += 0 // Left most column IOB
    if (numIOBSides > 2) {
      for (i <- 0 to tile_cols) {
        col_idxs_gib += col_idx
        col_idx += 1
        if (i < tile_cols) {
          col_idxs_pe += col_idx
          col_idx += 1
        }
      }
      // col_idxs_iob += col_idx /// Right most column IOB is not initialized 
      col_idx += 1
    }
    
    ////////////////////////////////////
    /// Generate IOB row by row
    ////////////////////////////////////
    // top/bottom row
    for(i <- 0 until numIOBSides) {
      if (i < 2) { // 顶部和底部
        val x = row_idxs_iob(i)
        // val iob_index_base = if(numIOBSides>2) x * (cols + 1+ numIOBSides - 2 ) else x * (cols + 1)
        val iob_index_base = if(numIOBSides>2) x * (tile_cols + numIOBSides - 2)
                             else x * (tile_cols) 
        for (j <- 0 until tile_cols) {
          val y = if(numIOBSides>2) 2 * j + 2 else 2 * j + 1
          val index = iob_index_base + j + 1 + tile_numSubModules * tile // start from 1
          iob_attrs("cfg_blk_index") = index
          iob_attrs("iob_index") = i * tile_cols + j + tile * numIOBSides * tile_cols
          iob_attrs("tile") = tile
          iob_attrs("x") = x
          iob_attrs("y") = y
          val iob_type = iob_posmap((tile, i, j))
          val iob_param = iob_typemap(iob_type)
          iob_attrs("iob_mode") = iob_param.mode
          iob_attrs("num_input_per_operand") = iob_param.num_input_per_operand
          iob_attrs("max_delay") = iobsParam(i)(j).max_delay // do not affect type decision
          iobs += Module(new IOB(iob_attrs))
          if (!iob_type_modid.contains(iob_type)) { // new IOB type
            sm_id_offset += 1
            iob_type_modid += (iob_type -> sm_id_offset)
            sm_id("IOB") += sm_id_offset
            sm_id_attrs += sm_id_offset -> iobs.last.getAttrs
          }
          val smi_id_attr: mutable.Map[String, Any] = mutable.Map(
            "module_id" -> iob_type_modid(iob_type),
            "cfg_blk_index" -> index,
            "iob_index" -> (i * tile_cols + j + tile * numIOBSides * tile_cols),
            "max_delay" -> iobsParam(i)(j).max_delay,
            "tile" -> tile,
            "x" -> x,
            "y" -> y
          )
          smi_id("IOB") += index
          smi_id_attrs += index -> smi_id_attr
        }
      } else { // 左侧和右侧 // TODO: Do not support left and right iobs in multitile cgra
        val y = col_idxs_iob(i - 2) // 左侧和右侧的列索引
        for (j <- 0 until tile_rows) {
          val x = 2 * j + 2
          val index = if(y == 0)  (tile_cols + numIOBSides - 2) * 2 *(j+1) + 1 + tile_numSubModules * tile
                      else (tile_cols + numIOBSides - 2) * 2 *(j) + 1 + tile_cols + 1 + tile_numSubModules * tile
          iob_attrs("cfg_blk_index") = index
          iob_attrs("iob_index") = tile_cols * 2  + (i-2) * tile_rows + j  + tile * numIOBSides * tile_cols
          iob_attrs("x") = x
          iob_attrs("y") = y
          iob_attrs("tile") = tile
          val iob_type = iob_posmap((tile, i, j))
          val iob_param = iob_typemap(iob_type)
          iob_attrs("iob_mode") = iob_param.mode
          iob_attrs("num_input_per_operand") = iob_param.num_input_per_operand
          iob_attrs("max_delay") = iobsParam(i)(j).max_delay // 不影响类型决定
          iobs += Module(new IOB(iob_attrs))
          if (!iob_type_modid.contains(iob_type)) { // 新的 IOB 类型
            sm_id_offset += 1
            iob_type_modid += (iob_type -> sm_id_offset)
            sm_id("IOB") += sm_id_offset
            sm_id_attrs += sm_id_offset -> iobs.last.getAttrs
          }
          val smi_id_attr: mutable.Map[String, Any] = mutable.Map(
            "module_id" -> iob_type_modid(iob_type),
            "cfg_blk_index" -> index,
            "iob_index" -> (tile_cols * 2  + (i-2) * tile_rows + j + tile * numIOBSides * tile_cols),
            "max_delay" -> iobsParam(i)(j).max_delay,
            "x" -> x,
            "y" -> y,
            "tile" -> tile
          )
          smi_id("IOB") += index
          smi_id_attrs += index -> smi_id_attr
        }
      }
    }
    //  sm_id("IOB") += sm_id_offset
    //  sm_id_attrs += sm_id_offset -> iobs.last.getAttrs

    // GPE
    for(i <- 0 until tile_rows){
      val x = row_idxs_pe(i)
      for(j <- 0 until tile_cols){
        val y = if(numIOBSides>2) 2 * j + 2 else 2 * j + 1
        val index = if(numIOBSides>2) x*(tile_cols+numIOBSides-2) + j + 2 + 1 + tile_numSubModules * tile
                   else x*(tile_cols) + j + 1 + tile_numSubModules * tile
        gpe_attrs("cfg_blk_index") = index 
        gpe_attrs("x") = x
        gpe_attrs("y") = y
        val gpe_type = gpe_posmap((tile, i, j))
        val gpe_param = gpe_typemap(gpe_type)
        gpe_attrs("operations") = gpe_param.operations
        gpe_attrs("num_input_per_operand") = gpe_param.num_input_per_operand
        gpe_attrs("max_delay") = gpesParam(i)(j).max_delay  // do not affect type decision
        pes += Module(new GPE(gpe_attrs))
        if(!gpe_type_modid.contains(gpe_type)){ // new GPE type
          sm_id_offset += 1
          gpe_type_modid += (gpe_type -> sm_id_offset)
          sm_id("GPE") += sm_id_offset
          sm_id_attrs += sm_id_offset -> pes.last.getAttrs
        }
        val smi_id_attr: mutable.Map[String, Any] = mutable.Map(
          "module_id" -> gpe_type_modid(gpe_type),
          "cfg_blk_index" -> index,
          "x" -> x,
          "y" -> y,
          "tile" -> tile,
          "max_delay" -> gpesParam(i)(j).max_delay
        )
        smi_id("GPE") += index
        smi_id_attrs += index -> smi_id_attr
      }
    }
    
    // println("smi_id(\"GPE\"):", smi_id("GPE"))
    //  sm_id("GPE") += sm_id_offset
    //  sm_id_attrs += sm_id_offset -> pes.last.getAttrs

    // GIB
  //  val iopin_list_map = mutable.Map[mutable.Map[String, Int], Int]()
    // for(i <- 0 to tile_rows){
    //   for(j <- 0 to tile_cols){
    for(i <- 0 to tile_rows){
      for(j <- 0 until tile_cols){
        //      val num_iopin_list = mutable.Map[String, Int]()
        //      num_iopin_list += "ipin_nw" -> {
        //        if(i == 0 && j > 0) numInIOCtrl
        //        else if(i > 0 && j > 0) aluOperandNum
        //        else 0
        //      }
        //      num_iopin_list += "opin_nw" -> {
        //        if(j > 0) 1 else 0
        //      }
        //      num_iopin_list += "ipin_ne" -> {
        //        if(i == 0 && j < cols) numInIOCtrl
        //        else if(i > 0 && j < cols) aluOperandNum
        //        else 0
        //      }
        //      num_iopin_list += "opin_ne" -> {
        //        if(j < cols) 1 else 0
        //      }
        //      num_iopin_list += "ipin_se" -> {
        //        if(i == rows && j < cols) numInIOCtrl
        //        else if(i < rows && j < cols) aluOperandNum
        //        else 0
        //      }
        //      num_iopin_list += "opin_se" -> {
        //        if(j < cols) 1 else 0
        //      }
        //      num_iopin_list += "ipin_sw" -> {
        //        if(i == rows && j > 0) numInIOCtrl
        //        else if(i < rows && j > 0) aluOperandNum
        //        else 0
        //      }
        //      num_iopin_list += "opin_sw" -> {
        //        if(j > 0) 1 else 0
        //      }
        val gib_type = gib_posmap(tile, i, j)
        val gib_param = gib_typemap(gib_type)
        val x = row_idxs_gib(i)
        val y = if(numIOBSides>2) 2*(j+1)-1 else 2*j
        val index = if(numIOBSides>2) x*(tile_cols+numIOBSides-2) + j + 1 + tile_numSubModules * tile
                    else x*(tile_cols) + j + 1 + tile_numSubModules * tile
        gib_attrs("cfg_blk_index") = index
        gib_attrs("x") = x
        gib_attrs("y") = y
        gib_attrs("tile") = tile

        // if there are register behind the GIB
        //	    val reged = {
        //        if(trackRegedMode == 0) false
        //        else if(trackRegedMode == 2) true
        //        else (i%2 + j%2) == 1
        //      }
        // val reged = gibsParam(i)(j).track_reged // gib_param.track_reged //
        // val reged = if(tile % 2 == 0) gibsParam(i)(j).track_reged else !(gibsParam(i)(j).track_reged) // gib_param.track_reged //
        val reged = gib_param.track_reged
        gib_attrs("track_reged") = reged
        gib_attrs("num_iopin_list") = gib_param.num_iopin_list
        gib_attrs("diag_iopin_connect") = gib_param.diag_iopin_connect
        gib_attrs("connect_flexibility") = gib_param.fc_list
        gib_attrs("track_directions") = gib_param.track_directions
        gibs += Module(new GIB(gib_attrs))
        //      if(!iopin_list_map.contains(num_iopin_list)){
        //        iopin_list_map += num_iopin_list -> sm_id_offset
        //        sm_id("GIB") += sm_id_offset
        //        sm_id_attrs += sm_id_offset -> gibs.last.getAttrs
        //        sm_id_offset += 1
        //      }
        if(!gib_type_modid.contains(gib_type)){ // new GIB type
          sm_id_offset += 1
          gib_type_modid += (gib_type -> sm_id_offset)
          sm_id("GIB") += sm_id_offset
          sm_id_attrs += sm_id_offset -> gibs.last.getAttrs
        }
        val smi_id_attr: mutable.Map[String, Any] = mutable.Map(
          "module_id" -> gib_type_modid(gib_type),
          "cfg_blk_index" -> index,
          "x" -> x,
          "y" -> y,
          "tile" -> tile,
          "track_reged" -> reged
        )
        smi_id("GIB") += index
        smi_id_attrs += index -> smi_id_attr
      }
    }

    ////////////////////////////////////
    /// connections attribute
    ////////////////////////////////////

    //////////////////////////////////////
    /// Firstly, connect left most column gib with last tile
    //////////////////////////////////////
    if(tile > 0){
      // IOB connections to GIB
      for((iob_idx, iob) <- unconnectedIOBs){
        if(iob_idx == tile_cols - 1){
          val c_idx = iob_idx + tile_cols * numIOBSides * (tile - 1)
          val gib_idx = 0 + tile_cols * (tile_rows + 1) * tile
          iob.io.in.zipWithIndex.foreach { case (in, j) =>
            if (j % 2 != 0) {
              in := gibs(gib_idx).io.ipinNW(j / 2)
              val index = gibs(gib_idx).oPortMap("ipinNW" + (j / 2).toString)
              connections.append((smi_id("GIB")(gib_idx), "GIB", index, smi_id("IOB")(c_idx), "IOB", j))
            } 
          }
          iob.io.out.zipWithIndex.foreach { case (out, j) =>
            gibs(gib_idx).io.opinNW(j) := out
            val index1 = gibs(gib_idx).iPortMap("opinNW" + j.toString)
            connections.append((smi_id("IOB")(c_idx), "IOB", j, smi_id("GIB")(gib_idx), "GIB", index1))
          }
        }
        else if(iob_idx == 2 * tile_cols - 1){
          val c_idx = iob_idx + tile_cols * numIOBSides * (tile - 1)
          val gib_idx = tile_rows * tile_cols + tile_cols * (tile_rows + 1) * tile
          iob.io.in.zipWithIndex.foreach { case (in, j) =>
            if (j % 2 != 0) {
              in := gibs(gib_idx).io.ipinSW(j / 2)
              val index = gibs(gib_idx).oPortMap("ipinSW" + (j / 2).toString)
              connections.append((smi_id("GIB")(gib_idx), "GIB", index, smi_id("IOB")(c_idx), "IOB", j))
            } 
          }
          iob.io.out.zipWithIndex.foreach { case (out, j) =>
            gibs(gib_idx).io.opinSW(j) := out
            val index1 = gibs(gib_idx).iPortMap("opinSW" + j.toString)
            connections.append((smi_id("IOB")(c_idx), "IOB", j, smi_id("GIB")(gib_idx), "GIB", index1))
          }          
        }        
        else{
          assert(false)
        }
      }

      for(((i, j), gpe) <- unconnectedGPEs){
        val idx_c_pe = i*tile_cols + j + tile_cols * tile_rows * (tile - 1)
        val idx_sw = i*(tile_cols)+0 + tile_cols * (tile_rows + 1) * tile // in GIB's perspective
        val idx_nw = (i+1)*(tile_cols)+0 + tile_cols * (tile_rows + 1) * tile
        
        val gpe_param = gpe_typemap(gpe_posmap(tile - 1, i, j))
        val numOperand = gpe_param.num_input_per_operand.size // operand number
        val from_dir = gpesParam(i)(j).from_dir

        if(from_dir.contains(NORTHEAST)){
          val baseindex = from_dir.indexOf(NORTHEAST)
          for( k <- 0 until numOperand ){
            val indexgpe = baseindex + k*from_dir.size
            gpe.io.in(indexgpe) := gibs(idx_sw).io.ipinSW(k)
            val indexgib = gibs(idx_sw).oPortMap("ipinSW" + (k).toString)
            connections.append((smi_id("GIB")(idx_sw), "GIB", indexgib, smi_id("GPE")(idx_c_pe), "GPE", indexgpe))
          }
        }
        if(from_dir.contains(SOUTHEAST)){
          val baseindex = from_dir.indexOf(SOUTHEAST)
          for( k <- 0 until numOperand ){
            val indexgpe = baseindex + k*from_dir.size
            gpe.io.in(indexgpe) := gibs(idx_nw).io.ipinNW(k)
            val indexgib = gibs(idx_nw).oPortMap("ipinNW" + (k).toString)
            connections.append((smi_id("GIB")(idx_nw), "GIB", indexgib, smi_id("GPE")(idx_c_pe), "GPE", indexgpe))
          }
        }

        val to_dir = gpe_param.to_dir
        gpe.io.out.zipWithIndex.foreach { case (out, k) =>
          if (to_dir.contains(NORTHEAST)) {
            gibs(idx_sw).io.opinSW(k) := out
            val index = gibs(idx_sw).iPortMap("opinSW" + k.toString)
            connections.append((smi_id("GPE")(idx_c_pe), "GPE", k, smi_id("GIB")(idx_sw), "GIB", index))
          }
          if (to_dir.contains(SOUTHEAST)) {
            gibs(idx_nw).io.opinNW(k) := out
            val index = gibs(idx_nw).iPortMap("opinNW" + k.toString)
            connections.append((smi_id("GPE")(idx_c_pe), "GPE", k, smi_id("GIB")(idx_nw), "GIB", index))
          }
          // dontTouch(pes(idx_c).io.out) /// add by jhlou
        }
      }
      // GIB to GIB connections
      if(numTrack > 0) {
        for(((i, j), gib) <- unconnectedGIBs){
          val idx_w = i * (tile_cols) + j + (tile_rows + 1) * tile_cols * (tile - 1)
          val idx_e = i * (tile_cols) + (tile_rows + 1) * tile_cols * tile
          gibs(idx_e).io.itrackW.zipWithIndex.foreach { case (in, k) =>
            in := gib.io.otrackE(k)
            val index1 = gibs(idx_e).iPortMap("itrackW" + k.toString)
            val index2 = gib.oPortMap("otrackE" + k.toString)
            connections.append((smi_id("GIB")(idx_w), "GIB", index2, smi_id("GIB")(idx_e), "GIB", index1))
          }

          gib.io.itrackE.zipWithIndex.foreach { case (in, k) =>
            in := gibs(idx_e).io.otrackW(k)
            val index1 = gib.iPortMap("itrackE" + k.toString)
            val index2 = gibs(idx_e).oPortMap("otrackW" + k.toString)
            connections.append((smi_id("GIB")(idx_e), "GIB", index2, smi_id("GIB")(idx_w), "GIB", index1))
          }
        }
      }
    }

    //// clear map
    unconnectedIOBs = mutable.Map[Int, IOB] ()
    unconnectedGPEs = mutable.Map[(Int, Int), GPE] ()
    unconnectedGIBs = mutable.Map[(Int, Int), GIB] ()

    //////////////////////////////////////
    /// Secondly, connect within this tile
    //////////////////////////////////////
    // IOB connections to GIB
    val done = Wire(Vec(numIOBSides * tile_cols, Bool()))
    // iobs.zipWithIndex.foreach { case (iob, i) =>
    for(i <- 0 until numIOBSides * tile_cols) {  
      val iobIdx = i + tile_cols * numIOBSides * tile
      val iob = iobs(iobIdx)
      iob.io.start := io.start(tile) && io.iob_ens(tile)(i)
      iob.io.en := io.en(tile) && io.iob_ens(tile)(i)
      iob.io.sram <> io.srams(tile)(i)
      done(i) := iob.io.done || (!io.iob_ens(tile)(i).asBool)

      if(i < tile_cols - 1){ // top row
        val gibIdx = i + tile_cols * (tile_rows + 1) * tile
        iob.io.in.zipWithIndex.foreach { case (in, j) =>
          if (j % 2 == 0) {
            in := gibs(gibIdx).io.ipinNE(j / 2)
            val index = gibs(gibIdx).oPortMap("ipinNE" + (j / 2).toString)
            connections.append((smi_id("GIB")(gibIdx), "GIB", index, smi_id("IOB")(iobIdx), "IOB", j))
          } else {
            in := gibs(gibIdx + 1).io.ipinNW(j / 2)
            val index = gibs(gibIdx + 1).oPortMap("ipinNW" + (j / 2).toString)
            connections.append((smi_id("GIB")(gibIdx + 1), "GIB", index, smi_id("IOB")(iobIdx), "IOB", j))
          }
        }
        iob.io.out.zipWithIndex.foreach { case (out, j) =>
          gibs(gibIdx).io.opinNE(j) := out
          gibs(gibIdx+1).io.opinNW(j) := out
          val index1 = gibs(gibIdx).iPortMap("opinNE" + j.toString)
          val index2 = gibs(gibIdx+1).iPortMap("opinNW" + j.toString)
          connections.append((smi_id("IOB")(iobIdx), "IOB", j, smi_id("GIB")(gibIdx), "GIB", index1))
          connections.append((smi_id("IOB")(iobIdx), "IOB", j, smi_id("GIB")(gibIdx+1), "GIB", index2))
        }
      }
      else if(i == tile_cols - 1){ // last iob of top row
        val gibIdx = i + tile_cols * (tile_rows + 1) * tile
        iob.io.in.zipWithIndex.foreach { case (in, j) =>
          if (j % 2 == 0) {
            in := gibs(gibIdx).io.ipinNE(j / 2)
            val index = gibs(gibIdx).oPortMap("ipinNE" + (j / 2).toString)
            connections.append((smi_id("GIB")(gibIdx), "GIB", index, smi_id("IOB")(iobIdx), "IOB", j))
          }
        }
        iob.io.out.zipWithIndex.foreach { case (out, j) =>
          gibs(gibIdx).io.opinNE(j) := out
          // gibs(gibIdx+1).io.opinNW(j) := out
          val index1 = gibs(gibIdx).iPortMap("opinNE" + j.toString)
          // val index2 = gibs(gibIdx+1).iPortMap("opinNW" + j.toString)
          connections.append((smi_id("IOB")(iobIdx), "IOB", j, smi_id("GIB")(gibIdx), "GIB", index1))
          // connections.append((smi_id("IOB")(i), "IOB", j, smi_id("GIB")(gibIdx+1), "GIB", index2))
        }
        unconnectedIOBs += i -> iob
      }
      else if (i < 2 * tile_cols - 1) { // Bottom row IOB (cols+rows to 2*cols+rows-1)
        // val gibIdx = (rows * (cols + 1) - cols) + (i - cols - rows) // 底部行 GIB 索引// buttom row
        // val gibIdx = rows * (cols + 1) - cols + i
        val gibIdx = tile_rows * (tile_cols) + i - tile_cols + tile_cols * (tile_rows + 1) * tile
        iob.io.in.zipWithIndex.foreach { case (in, j) =>
          if (j % 2 == 0) {
            in := gibs(gibIdx).io.ipinSE(j / 2)
            val index = gibs(gibIdx).oPortMap("ipinSE" + (j / 2).toString)
            connections.append((smi_id("GIB")(gibIdx), "GIB", index, smi_id("IOB")(iobIdx), "IOB", j))
          } else {
            in := gibs(gibIdx + 1).io.ipinSW(j / 2)
            val index = gibs(gibIdx + 1).oPortMap("ipinSW" + (j / 2).toString)
            connections.append((smi_id("GIB")(gibIdx + 1), "GIB", index, smi_id("IOB")(iobIdx), "IOB", j))
          }
        }
        iob.io.out.zipWithIndex.foreach { case (out, j) =>
          gibs(gibIdx).io.opinSE(j) := out
          gibs(gibIdx + 1).io.opinSW(j) := out
          val index1 = gibs(gibIdx).iPortMap("opinSE" + j.toString)
          val index2 = gibs(gibIdx + 1).iPortMap("opinSW" + j.toString)
          connections.append((smi_id("IOB")(iobIdx), "IOB", j, smi_id("GIB")(gibIdx), "GIB", index1))
          connections.append((smi_id("IOB")(iobIdx), "IOB", j, smi_id("GIB")(gibIdx + 1), "GIB", index2))
        }
      } 
      else if (i == 2 * tile_cols - 1) { // Bottom row last IOB 
        //val gibIdx = (rows * (cols + 1) - cols) + (i - cols - rows) // buttom row
        // val gibIdx = rows * (cols + 1) - cols + i
        val gibIdx = tile_rows * (tile_cols) + i - tile_cols + tile_cols * (tile_rows + 1) * tile
        iob.io.in.zipWithIndex.foreach { case (in, j) =>
          if (j % 2 == 0) {
            in := gibs(gibIdx).io.ipinSE(j / 2)
            val index = gibs(gibIdx).oPortMap("ipinSE" + (j / 2).toString)
            connections.append((smi_id("GIB")(gibIdx), "GIB", index, smi_id("IOB")(iobIdx), "IOB", j))
          } 
          // else {
          //   in := gibs(gibIdx + 1).io.ipinSW(j / 2)
          //   val index = gibs(gibIdx + 1).oPortMap("ipinSW" + (j / 2).toString)
          //   connections.append((smi_id("GIB")(gibIdx + 1), "GIB", index, smi_id("IOB")(i), "IOB", j))
          // }
        }
        iob.io.out.zipWithIndex.foreach { case (out, j) =>
          gibs(gibIdx).io.opinSE(j) := out
          // gibs(gibIdx + 1).io.opinSW(j) := out
          val index1 = gibs(gibIdx).iPortMap("opinSE" + j.toString)
          // val index2 = gibs(gibIdx + 1).iPortMap("opinSW" + j.toString)
          connections.append((smi_id("IOB")(iobIdx), "IOB", j, smi_id("GIB")(gibIdx), "GIB", index1))
          // connections.append((smi_id("IOB")(i), "IOB", j, smi_id("GIB")(gibIdx + 1), "GIB", index2))
        }
        unconnectedIOBs += i -> iob
      } 
      else {
        //// do not support iob at left or right side
        assert(false)
      }
    }

    io.done(tile) := RegNext(done.asUInt)

    // PE to GIB connections
    for(i <- 0 until tile_rows){
      for(j <- 0 until tile_cols){
        // println("i", i, "j", j)
        val idx_c = i*tile_cols+j + tile_cols * tile_rows * tile // center
        val idx_se = i*(tile_cols)+j + tile_cols * (tile_rows + 1) * tile // in GIB's perspective
        val idx_sw = i*(tile_cols)+j+1 + tile_cols * (tile_rows + 1) * tile
        val idx_ne = (i+1)*(tile_cols)+j + tile_cols * (tile_rows + 1) * tile
        val idx_nw = (i+1)*(tile_cols)+j+1 + tile_cols * (tile_rows + 1) * tile
        pes(idx_c).io.start := io.start(tile)
        pes(idx_c).io.en := io.en(tile) /// TODO 
        val gpe_param = gpe_typemap(gpe_posmap(tile, i, j))
        val numOperand = gpe_param.num_input_per_operand.size // operand number
        // which directions of GIBs are connected to GPE input ports
        // number of inputs from each direction: numOperand
        val from_dir = gpesParam(i)(j).from_dir
        if(from_dir.contains(NORTHWEST)){
          val baseindex = from_dir.indexOf(NORTHWEST)
          for( k <- 0 until numOperand ){
            val indexgpe = baseindex + k*from_dir.size // input order: inputs for 1st operand, inputs for 2nd operand...
            pes(idx_c).io.in(indexgpe) := gibs(idx_se).io.ipinSE(k)
            val indexgib = gibs(idx_se).oPortMap("ipinSE" + (k).toString)
            connections.append((smi_id("GIB")(idx_se), "GIB", indexgib, smi_id("GPE")(idx_c), "GPE", indexgpe))
          }
        }
        if(from_dir.contains(NORTHEAST) && j != tile_cols - 1){
          val baseindex = from_dir.indexOf(NORTHEAST)
          for( k <- 0 until numOperand ){
            val indexgpe = baseindex + k*from_dir.size
            pes(idx_c).io.in(indexgpe) := gibs(idx_sw).io.ipinSW(k)
            val indexgib = gibs(idx_sw).oPortMap("ipinSW" + (k).toString)
            connections.append((smi_id("GIB")(idx_sw), "GIB", indexgib, smi_id("GPE")(idx_c), "GPE", indexgpe))
          }
        }
        // if(from_dir.contains(SOUTHWEST)){
        if(from_dir.contains(SOUTHWEST) ){
          val baseindex = from_dir.indexOf(SOUTHWEST)
          for( k <- 0 until numOperand ){
            val indexgpe = baseindex + k*from_dir.size
            pes(idx_c).io.in(baseindex + k*from_dir.size) := gibs(idx_ne).io.ipinNE(k)
            val indexgib = gibs(idx_ne).oPortMap("ipinNE" + (k).toString)
            connections.append((smi_id("GIB")(idx_ne), "GIB", indexgib, smi_id("GPE")(idx_c), "GPE", indexgpe))
          }
        }
        if(from_dir.contains(SOUTHEAST) && j != tile_cols - 1){
          val baseindex = from_dir.indexOf(SOUTHEAST)
          for( k <- 0 until numOperand ){
            val indexgpe = baseindex + k*from_dir.size
            pes(idx_c).io.in(indexgpe) := gibs(idx_nw).io.ipinNW(k)
            val indexgib = gibs(idx_nw).oPortMap("ipinNW" + (k).toString)
            connections.append((smi_id("GIB")(idx_nw), "GIB", indexgib, smi_id("GPE")(idx_c), "GPE", indexgpe))
          }
        }

        // which directions of GIBs are connected to GPE output port
        val to_dir = gpesParam(i)(j).to_dir
        pes(idx_c).io.out.zipWithIndex.foreach { case (out, k) =>
          if (to_dir.contains(NORTHWEST)) {
            gibs(idx_se).io.opinSE(k) := out
            val index = gibs(idx_se).iPortMap("opinSE" + k.toString)
            connections.append((smi_id("GPE")(idx_c), "GPE", k, smi_id("GIB")(idx_se), "GIB", index))
          }
          if (to_dir.contains(NORTHEAST) && j != tile_cols - 1) {
            gibs(idx_sw).io.opinSW(k) := out
            val index = gibs(idx_sw).iPortMap("opinSW" + k.toString)
            connections.append((smi_id("GPE")(idx_c), "GPE", k, smi_id("GIB")(idx_sw), "GIB", index))
          }
          if (to_dir.contains(SOUTHWEST)) {
            gibs(idx_ne).io.opinNE(k) := out
            val index = gibs(idx_ne).iPortMap("opinNE" + k.toString)
            connections.append((smi_id("GPE")(idx_c), "GPE", k, smi_id("GIB")(idx_ne), "GIB", index))
          }
          if (to_dir.contains(SOUTHEAST) && j != tile_cols - 1) {
            gibs(idx_nw).io.opinNW(k) := out
            val index = gibs(idx_nw).iPortMap("opinNW" + k.toString)
            connections.append((smi_id("GPE")(idx_c), "GPE", k, smi_id("GIB")(idx_nw), "GIB", index))
          }
          // dontTouch(pes(idx_c).io.out) /// add by jhlou

          if(j == tile_cols - 1){
            unconnectedGPEs += (i, j) -> pes(idx_c)
          }
        }
      }
    }

    // GIB to GIB connections
    if(numTrack > 0) {
      for (i <- 0 to tile_rows) {
        // for (j <- 0 to tile_cols) {
        for (j <- 0 until tile_cols) {
          // println("i", i, "j", j)
          val idx_c = i * (tile_cols) + j + (tile_rows + 1) * tile_cols * tile // center
          val idx_n = (i - 1) * (tile_cols) + j + (tile_rows + 1) * tile_cols * tile // in center GIB's perspective
          val idx_w = i * (tile_cols) + j - 1 + (tile_rows + 1) * tile_cols * tile
          val idx_e = i * (tile_cols ) + j + 1 + (tile_rows + 1) * tile_cols * tile
          val idx_s = (i + 1) * (tile_cols) + j + (tile_rows + 1) * tile_cols * tile
          if (i == 0) {
            gibs(idx_c).io.itrackN.foreach { in => in := 0.U }
            gibs(idx_c).io.itrackS.zipWithIndex.foreach { case (in, k) =>
              in := gibs(idx_s).io.otrackN(k)
              val index1 = gibs(idx_c).iPortMap("itrackS" + k.toString)
              val index2 = gibs(idx_s).oPortMap("otrackN" + k.toString)
              connections.append((smi_id("GIB")(idx_s), "GIB", index2, smi_id("GIB")(idx_c), "GIB", index1))
            }
          } else if (i == tile_rows) {
            gibs(idx_c).io.itrackS.foreach { in => in := 0.U }
            gibs(idx_c).io.itrackN.zipWithIndex.foreach { case (in, k) =>
              in := gibs(idx_n).io.otrackS(k)
              val index1 = gibs(idx_c).iPortMap("itrackN" + k.toString)
              val index2 = gibs(idx_n).oPortMap("otrackS" + k.toString)
              connections.append((smi_id("GIB")(idx_n), "GIB", index2, smi_id("GIB")(idx_c), "GIB", index1))
            }
          } else {
            gibs(idx_c).io.itrackN.zipWithIndex.foreach { case (in, k) =>
              in := gibs(idx_n).io.otrackS(k)
              val index1 = gibs(idx_c).iPortMap("itrackN" + k.toString)
              val index2 = gibs(idx_n).oPortMap("otrackS" + k.toString)
              connections.append((smi_id("GIB")(idx_n), "GIB", index2, smi_id("GIB")(idx_c), "GIB", index1))
            }
            gibs(idx_c).io.itrackS.zipWithIndex.foreach { case (in, k) =>
              in := gibs(idx_s).io.otrackN(k)
              val index1 = gibs(idx_c).iPortMap("itrackS" + k.toString)
              val index2 = gibs(idx_s).oPortMap("otrackN" + k.toString)
              connections.append((smi_id("GIB")(idx_s), "GIB", index2, smi_id("GIB")(idx_c), "GIB", index1))
            }
          }

          if (tile_cols == 1) {
            gibs(idx_c).io.itrackW.foreach { in => in := 0.U }
            unconnectedGIBs += (i, j) -> gibs(idx_c)
          }
          else if (j == 0) {
            gibs(idx_c).io.itrackW.foreach { in => in := 0.U }
            gibs(idx_c).io.itrackE.zipWithIndex.foreach { case (in, k) =>
              in := gibs(idx_e).io.otrackW(k)
              val index1 = gibs(idx_c).iPortMap("itrackE" + k.toString)
              val index2 = gibs(idx_e).oPortMap("otrackW" + k.toString)
              connections.append((smi_id("GIB")(idx_e), "GIB", index2, smi_id("GIB")(idx_c), "GIB", index1))
            }
          } else if (j == tile_cols - 1) {
            gibs(idx_c).io.itrackE.foreach { in => in := 0.U }
            gibs(idx_c).io.itrackW.zipWithIndex.foreach { case (in, k) =>
              in := gibs(idx_w).io.otrackE(k)
              val index1 = gibs(idx_c).iPortMap("itrackW" + k.toString)
              val index2 = gibs(idx_w).oPortMap("otrackE" + k.toString)
              connections.append((smi_id("GIB")(idx_w), "GIB", index2, smi_id("GIB")(idx_c), "GIB", index1))
            }
            unconnectedGIBs += (i, j) -> gibs(idx_c)
          } else{
            gibs(idx_c).io.itrackW.zipWithIndex.foreach { case (in, k) =>
              in := gibs(idx_w).io.otrackE(k)
              val index1 = gibs(idx_c).iPortMap("itrackW" + k.toString)
              val index2 = gibs(idx_w).oPortMap("otrackE" + k.toString)
              connections.append((smi_id("GIB")(idx_w), "GIB", index2, smi_id("GIB")(idx_c), "GIB", index1))
            }
            gibs(idx_c).io.itrackE.zipWithIndex.foreach { case (in, k) =>
              in := gibs(idx_e).io.otrackW(k)
              val index1 = gibs(idx_c).iPortMap("itrackE" + k.toString)
              val index2 = gibs(idx_e).oPortMap("otrackW" + k.toString)
              connections.append((smi_id("GIB")(idx_e), "GIB", index2, smi_id("GIB")(idx_c), "GIB", index1))
            }
          }
        }
      }
    }

    /////////////////////////////
    /// Thirdly, for the last tile , add one column of GIB at right side
    /////////////////////////////
    if(tile == tile_num - 1){
      /// generate gib
      for(i <- 0 to tile_rows){
        val gib_type = gib_posmap(tile, i, tile_cols)
        val gib_param = gib_typemap(gib_type)
        val x = row_idxs_gib(i)
        val y = if(numIOBSides>2) 2*(tile_cols + 1) - 1 else 2 * tile_cols
        val index = if(numIOBSides>2) x*(tile_cols+1+numIOBSides-2) + tile_numSubModules + i + 1 + tile_numSubModules * tile
                    else tile_numSubModules + i + 1 + tile_numSubModules * tile
        gib_attrs("cfg_blk_index") = index
        gib_attrs("x") = x
        gib_attrs("y") = y
        gib_attrs("tile") = tile

        // if there are register behind the GIB
        //	    val reged = {
        //        if(trackRegedMode == 0) false
        //        else if(trackRegedMode == 2) true
        //        else (i%2 + j%2) == 1
        // //      }
        // val reged = gibsParam(i)(tile_cols).track_reged // gib_param.track_reged //
        // val reged = if(tile % 2 == 0) gibsParam(i)(tile_cols).track_reged else !(gibsParam(i)(tile_cols).track_reged)
        val reged = gib_param.track_reged
        gib_attrs("track_reged") = reged
        gib_attrs("num_iopin_list") = gib_param.num_iopin_list
        gib_attrs("diag_iopin_connect") = gib_param.diag_iopin_connect
        gib_attrs("connect_flexibility") = gib_param.fc_list
        gib_attrs("track_directions") = gib_param.track_directions
        gibs += Module(new GIB(gib_attrs))
        //      if(!iopin_list_map.contains(num_iopin_list)){
        //        iopin_list_map += num_iopin_list -> sm_id_offset
        //        sm_id("GIB") += sm_id_offset
        //        sm_id_attrs += sm_id_offset -> gibs.last.getAttrs
        //        sm_id_offset += 1
        //      }
        if(!gib_type_modid.contains(gib_type)){ // new GIB type
          sm_id_offset += 1
          gib_type_modid += (gib_type -> sm_id_offset)
          sm_id("GIB") += sm_id_offset
          sm_id_attrs += sm_id_offset -> gibs.last.getAttrs
        }
        val smi_id_attr: mutable.Map[String, Any] = mutable.Map(
          "module_id" -> gib_type_modid(gib_type),
          "cfg_blk_index" -> index,
          "x" -> x,
          "y" -> y,
          "tile" -> tile,
          "track_reged" -> reged
        )
        smi_id("GIB") += index
        smi_id_attrs += index -> smi_id_attr
      }

      // IOB connections to GIB
      for((iob_idx, iob) <- unconnectedIOBs){
        if(iob_idx == tile_cols - 1){
          val c_idx = iob_idx + tile_cols * numIOBSides * tile
          val gib_idx = (tile_rows + 1) * tile_cols + tile_cols * (tile_rows + 1) * tile
          iob.io.in.zipWithIndex.foreach { case (in, j) =>
            if (j % 2 != 0) {
              in := gibs(gib_idx).io.ipinNW(j / 2)
              val index = gibs(gib_idx).oPortMap("ipinNW" + (j / 2).toString)
              connections.append((smi_id("GIB")(gib_idx), "GIB", index, smi_id("IOB")(c_idx), "IOB", j))
            } 
          }
          iob.io.out.zipWithIndex.foreach { case (out, j) =>
            gibs(gib_idx).io.opinNW(j) := out
            val index1 = gibs(gib_idx).iPortMap("opinNW" + j.toString)
            connections.append((smi_id("IOB")(c_idx), "IOB", j, smi_id("GIB")(gib_idx), "GIB", index1))
          }
        }
        else if(iob_idx == 2 * tile_cols - 1){
          val c_idx = iob_idx + tile_cols * numIOBSides * tile
          val gib_idx = (tile_rows + 1) * tile_cols + tile_rows + tile_cols * (tile_rows + 1) * tile
          iob.io.in.zipWithIndex.foreach { case (in, j) =>
            if (j % 2 != 0) {
              in := gibs(gib_idx).io.ipinSW(j / 2)
              val index = gibs(gib_idx).oPortMap("ipinSW" + (j / 2).toString)
              connections.append((smi_id("GIB")(gib_idx), "GIB", index, smi_id("IOB")(c_idx), "IOB", j))
            } 
          }
          iob.io.out.zipWithIndex.foreach { case (out, j) =>
            gibs(gib_idx).io.opinSW(j) := out
            val index1 = gibs(gib_idx).iPortMap("opinSW" + j.toString)
            connections.append((smi_id("IOB")(c_idx), "IOB", j, smi_id("GIB")(gib_idx), "GIB", index1))
          }          
        }
        else{
          assert(false)
        }
      }

      for(((i, j), gpe) <- unconnectedGPEs){
        val idx_c_pe = i*tile_cols + j + tile_cols * tile_rows * tile
        val idx_sw = (tile_rows + 1) * tile_cols + i + tile_cols * (tile_rows + 1) * tile // in GIB's perspective
        val idx_nw = (tile_rows + 1) * tile_cols + i + 1 + tile_cols * (tile_rows + 1) * tile

        val gpe_param = gpe_typemap(gpe_posmap(tile, i, j))
        val numOperand = gpe_param.num_input_per_operand.size // operand number
        val from_dir = gpesParam(i)(j).from_dir

        if(from_dir.contains(NORTHEAST)){
          val baseindex = from_dir.indexOf(NORTHEAST)
          for( k <- 0 until numOperand ){
            val indexgpe = baseindex + k*from_dir.size
            gpe.io.in(indexgpe) := gibs(idx_sw).io.ipinSW(k)
            val indexgib = gibs(idx_sw).oPortMap("ipinSW" + (k).toString)
            connections.append((smi_id("GIB")(idx_sw), "GIB", indexgib, smi_id("GPE")(idx_c_pe), "GPE", indexgpe))
          }
        }
        if(from_dir.contains(SOUTHEAST)){
          val baseindex = from_dir.indexOf(SOUTHEAST)
          for( k <- 0 until numOperand ){
            val indexgpe = baseindex + k*from_dir.size
            gpe.io.in(indexgpe) := gibs(idx_nw).io.ipinNW(k)
            val indexgib = gibs(idx_nw).oPortMap("ipinNW" + (k).toString)
            connections.append((smi_id("GIB")(idx_nw), "GIB", indexgib, smi_id("GPE")(idx_c_pe), "GPE", indexgpe))
          }
        }

        val to_dir = gpesParam(i)(j).to_dir
        gpe.io.out.zipWithIndex.foreach { case (out, k) =>
          if (to_dir.contains(NORTHEAST)) {
            gibs(idx_sw).io.opinSW(k) := out
            val index = gibs(idx_sw).iPortMap("opinSW" + k.toString)
            connections.append((smi_id("GPE")(idx_c_pe), "GPE", k, smi_id("GIB")(idx_sw), "GIB", index))
          }
          if (to_dir.contains(SOUTHEAST)) {
            gibs(idx_nw).io.opinNW(k) := out
            val index = gibs(idx_nw).iPortMap("opinNW" + k.toString)
            connections.append((smi_id("GPE")(idx_c_pe), "GPE", k, smi_id("GIB")(idx_nw), "GIB", index))
          }
          // dontTouch(pes(idx_c).io.out) /// add by jhlou
        }
      }
      // GIB to GIB connections
      if(numTrack > 0) {
        for(((i, j), gib) <- unconnectedGIBs){
          val idx_w = i * (tile_cols) + j + (tile_rows + 1) * tile_cols * tile
          val idx_e = (tile_rows + 1) * tile_cols + i + (tile_rows + 1) * tile_cols * tile
          // println("idx_e:", idx_e, "i, j:", i, j)
          gibs(idx_e).io.itrackE.foreach { in => in := 0.U }
          gibs(idx_e).io.itrackW.zipWithIndex.foreach { case (in, k) =>
            in := gib.io.otrackE(k)
            val index1 = gibs(idx_e).iPortMap("itrackW" + k.toString)
            val index2 = gib.oPortMap("otrackE" + k.toString)
            connections.append((smi_id("GIB")(idx_w), "GIB", index2, smi_id("GIB")(idx_e), "GIB", index1))
          }

          gib.io.itrackE.zipWithIndex.foreach { case (in, k) =>
            in := gibs(idx_e).io.otrackW(k)
            val index1 = gib.iPortMap("itrackE" + k.toString)
            val index2 = gibs(idx_e).oPortMap("otrackW" + k.toString)
            connections.append((smi_id("GIB")(idx_e), "GIB", index2, smi_id("GIB")(idx_w), "GIB", index1))
          }
        }

        /// N and S
        for (i <- 0 to tile_rows) {
          val idx_c = (tile_rows + 1) * tile_cols + i + (tile_rows + 1) * tile_cols * tile // center
          val idx_n = (tile_rows + 1) * tile_cols + i - 1 + (tile_rows + 1) * tile_cols * tile // in center GIB's perspective
          val idx_w = i * (tile_cols) + tile_cols - 1 + (tile_rows + 1) * tile_cols * tile
          // val idx_e = 
          val idx_s = (tile_rows + 1) * tile_cols + i + 1 + (tile_rows + 1) * tile_cols * tile
          if (i == 0) {
            gibs(idx_c).io.itrackN.foreach { in => in := 0.U }
            gibs(idx_c).io.itrackS.zipWithIndex.foreach { case (in, k) =>
              in := gibs(idx_s).io.otrackN(k)
              val index1 = gibs(idx_c).iPortMap("itrackS" + k.toString)
              val index2 = gibs(idx_s).oPortMap("otrackN" + k.toString)
              connections.append((smi_id("GIB")(idx_s), "GIB", index2, smi_id("GIB")(idx_c), "GIB", index1))
            }
          } else if (i == tile_rows) {
            gibs(idx_c).io.itrackS.foreach { in => in := 0.U }
            gibs(idx_c).io.itrackN.zipWithIndex.foreach { case (in, k) =>
              in := gibs(idx_n).io.otrackS(k)
              val index1 = gibs(idx_c).iPortMap("itrackN" + k.toString)
              val index2 = gibs(idx_n).oPortMap("otrackS" + k.toString)
              connections.append((smi_id("GIB")(idx_n), "GIB", index2, smi_id("GIB")(idx_c), "GIB", index1))
            }
          } else {
            gibs(idx_c).io.itrackN.zipWithIndex.foreach { case (in, k) =>
              in := gibs(idx_n).io.otrackS(k)
              val index1 = gibs(idx_c).iPortMap("itrackN" + k.toString)
              val index2 = gibs(idx_n).oPortMap("otrackS" + k.toString)
              connections.append((smi_id("GIB")(idx_n), "GIB", index2, smi_id("GIB")(idx_c), "GIB", index1))
            }
            gibs(idx_c).io.itrackS.zipWithIndex.foreach { case (in, k) =>
              in := gibs(idx_s).io.otrackN(k)
              val index1 = gibs(idx_c).iPortMap("itrackS" + k.toString)
              val index2 = gibs(idx_s).oPortMap("otrackN" + k.toString)
              connections.append((smi_id("GIB")(idx_s), "GIB", index2, smi_id("GIB")(idx_c), "GIB", index1))
            }
          }
        }
      }
    } //// End of "if tile == tile_num - 1"

    // Configurations, each row share one config bus
    cfgRegNum = totalRows - 1
 
    ///////////////////////////////
    /// connect cfg_addr cfg_en cfg_data
    ///////////////////////////////
    for(i <- 0 until numIOBSides * tile_cols) {  
      val iob = iobs(i + tile*numIOBSides * tile_cols)
      iob.io.cfg_en   := io.cfg_en(tile)
      // iob.io.cfg_en_w := io.cfg_en_w
      iob.io.cfg_addr := io.cfg_addr
      iob.io.cfg_data := io.cfg_data
    }

    for(i <- 0 to tile_rows){
      val gibCfgIdx = row_idxs_gib(i) - 1
      val peCfgIdx = {if(i < tile_rows) row_idxs_pe(i) - 1 else 0}
      // for(j <- 0 to tile_cols){
      for(j <- 0 until tile_cols){  
        gibs(i*(tile_cols)+j +tile*(tile_rows+1)*tile_cols).io.cfg_en   := io.cfg_en(tile)
        // gibs(i*(cols+1)+j).io.cfg_en_w   := io.cfg_en_w
        gibs(i*(tile_cols)+j +tile*(tile_rows+1)*tile_cols).io.cfg_addr := io.cfg_addr
        gibs(i*(tile_cols)+j +tile*(tile_rows+1)*tile_cols).io.cfg_data := io.cfg_data
        if((i < tile_rows) && (j < tile_cols)){
          pes(i*tile_cols+j +tile*(tile_rows)*tile_cols).io.cfg_en   := io.cfg_en(tile)
          // pes(i*cols+j).io.cfg_en_w   := io.cfg_en_w
          pes(i*tile_cols+j +tile*(tile_rows)*tile_cols).io.cfg_addr := io.cfg_addr
          pes(i*tile_cols+j +tile*(tile_rows)*tile_cols).io.cfg_data := io.cfg_data
        }
      }

      if(tile == tile_num - 1){
        gibs((tile_rows + 1) * tile_cols + i +tile*(tile_rows+1)*tile_cols).io.cfg_en   := io.cfg_en(tile)
        gibs((tile_rows + 1) * tile_cols + i +tile*(tile_rows+1)*tile_cols).io.cfg_addr := io.cfg_addr
        gibs((tile_rows + 1) * tile_cols + i +tile*(tile_rows+1)*tile_cols).io.cfg_data := io.cfg_data
      }
    }
  } /// end of multi tile
  
  println("sm_id:", sm_id)
  println("smi_id:", smi_id)

  val sub_modules = sm_id.map{case (name, ids) =>
    ids.map{id => mutable.Map(
      "id" -> id, 
      "type" -> name,
      "attributes" -> sm_id_attrs(id)
    )}
  }.flatten
  apply("sub_modules", sub_modules)
  // println("smi_id_attrs:", smi_id_attrs)

  val instances = smi_id.map{case (name, ids) =>
    ids.map{id => mutable.Map(
      "id" -> id, 
      "type" -> name) ++ 
      {if(name != "This") smi_id_attrs(id) else mutable.Map[String, Any]()}
    }
  }.flatten

  apply("instances", instances)
  // println("instances", instances)
  
  apply("connections", connections.zipWithIndex.map{case (c, i) => i -> c}.toMap)

  // config bits of the blocks
  val blkCfgBits = ListBuffer[Int]()
  blkCfgBits ++= iobs.map(_.sumCfgWidth).toList
  blkCfgBits ++= pes.map(_.sumCfgWidth).toList
  blkCfgBits ++= gibs.map(_.cfgsBit).toList
  val maxCfgDataNum = blkCfgBits.map{ x => (x+cfgDataWidth-1)/cfgDataWidth }.sum
  //  println("Max cfg bits: " + blkCfgBits.max, ", Min cfg bits: " + blkCfgBits.min, ", Total cfg bits: " + blkCfgBits.sum)
  apply("max_blk_cfg_bits", blkCfgBits.max)
  apply("min_blk_cfg_bits", blkCfgBits.min)
  apply("sum_blk_cfg_bits", blkCfgBits.sum)
  apply("max_cfg_data_num", maxCfgDataNum)  
  
  if(attrs("dumpADG").asInstanceOf[Boolean]){
    printIR(attrs("cgra_adg_filename").asInstanceOf[String])
  }
  if(attrs("dumpOperationSet").asInstanceOf[Boolean]){
    OpInfo.setLatency("INPUT", load_latency)
    OpInfo.setLatency("OUTPUT", store_latency)
    OpInfo.setLatency("LOAD", load_latency)
    OpInfo.setLatency("STORE", store_latency)
    OpInfo.setLatency("CINPUT", load_latency)
    OpInfo.setLatency("COUTPUT", store_latency)
    OpInfo.setLatency("CLOAD", load_latency)
    OpInfo.setLatency("CSTORE", store_latency)
    OpInfo.dumpOpInfo(attrs("operation_set_filename").asInstanceOf[String])
  }
}





// object VerilogGen extends App {
//  val connect_flexibility = mutable.Map(
//    "num_itrack_per_ipin" -> 2, // ipin number = 3
//    "num_otrack_per_opin" -> 6, // opin number = 1
//    "num_ipin_per_opin"   -> 9
//  )
//  val attrs: mutable.Map[String, Any] = mutable.Map(
//    "cgra_num_row" -> 4,
//    "cgra_num_colum" -> 4,
//    "cgra_data_width" -> 32,
//    "cgra_cfg_data_width" -> 64,
//    "cgra_cfg_addr_width" -> 8,
//    "cgra_cfg_blk_offset" -> 2,
//    "num_rf_reg" -> 1,
//   //  "operations" -> ListBuffer("PASS", "ADD", "SUB", "MUL", "AND", "OR", "XOR", "SEL"),
//    "operations" -> ListBuffer("INTLV4"),
//    "max_delay" -> 4,
//    "num_track" -> 3,
//    "connect_flexibility" -> connect_flexibility,
//    "num_output_ib" -> 3,
//    "num_input_ob" -> 6,
//     "lg_max_ii" -> 5, 
//     "lg_max_cycles" -> 10,
//  "cgra_gpe_max_delay" -> 10,
//     "cgra_gpe_in_from_dir" -> List(NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST),
//     "cgra_gpe_out_to_dir" -> List(NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST),
//     // 1.3. GIB attributes (default for all)
//     "cgra_gib_num_track" -> 1,
//     "cgra_gib_track_reged_mode" -> 1,
//     "cgra_gib_connect_flexibility" -> List(2, 2, 4), // (track2IPinConnect, oPin2TrackConnect, oPin2IPinConnect)
//     "cgra_gib_diag_iopin_connect" -> true,
//     // 1.4. IOB attributes (default for all)
//     "cgra_iob_num_sides" -> 2,   // now only support top/bottom side
//     "cgra_iob_mode" -> SRAM_MODE,        // 0: FIFO mode, 1: SRAM mode
//     "cgra_iob_max_delay" -> 10,   // only valid for SRAM Mode
//     "cgra_iob_ag_nest_levels" -> 4, // adora: 4 fdra: 3
//     "cgra_iob_sram_add_reg" -> 2, // add pipeline register into the SRAM IF to improve timing, write/read latency, 0 : 0/1; 1 : 1/2; 2 : 1/3;
//     "cgra_iob_sram_has_mask" -> true, // byte mask in the SRAM IF
//     "cgra_iob_sram_addr_width" -> 13, // address in byte
//     "cgra_iob_sram_banks_coalesce" -> 4,
//     "cgra_lg_max_lat" -> 6, // log2(max in/out latency)
//     "cgra_lg_max_ii" ->  4, //1,
//     "cgra_lg_max_stride" -> 13,
//     "cgra_lg_max_cycles" -> 12,
//     "cgra_lg_max_init" -> 12,
//     // 1.5. CGRA Config controller parameters
//     "cgra_cfg_addr_width_align" -> 16, // cfg_data and cfg_addr are stored as an array in scratchpad, cfg_addr_width should be aligned
// //    "cgra_cfg_sram_banks_cascade" -> cgra_cfg_sram_banks_cascade,
// //    "cgra_cfg_sram_data_width" -> 32,
// //    "cgra_cfg_sram_addr_width" -> (spad_bank_lg_size + log2Ceil(cgra_cfg_sram_banks_cascade)), // address in byte
//     "cgra_cfg_sram_add_reg" -> false, // add pipeline register into the SRAM IF to improve timing
// //    "cgra_cfg_sram_read_latency" -> 1,
//     // 1.6. CGRA Execute controller parameters
// //    "cgra_exe_lg_max_ii" -> 4,
// //    "cgra_exe_lg_max_loop_cycles" -> 10,
// //    "cgra_exe_lg_max_execute_cycles" -> 16,
//     // 2. Scratchpad parameters
//     "spad_data_width" -> 64,
//     "spad_bank_lg_size" -> 13,
//     "spad_cfg_lg_size" -> 10,
//     "spad_addr_num" -> 5, // scratchpad add
//  )

//  (new chisel3.stage.ChiselStage).emitVerilog(new CGRA(attrs),args)
// }