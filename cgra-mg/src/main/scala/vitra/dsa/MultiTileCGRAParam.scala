package tram.vitra.dsa

import scala.collection.mutable
import scala.collection.mutable.ListBuffer
import chisel3.util._
import tram.common.MacroVar._
import tram.common.IobMode
// import tram.spec._
import tram.vitra.spec._
import tram.op._


// GPE parameters
case class GpeParam(
  max_delay : Int = 4,
  operations : ListBuffer[String] = ListBuffer("PASS", "ADD", "SUB"),
  from_dir : List[Int] =  List(NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST),
  to_dir : List[Int] =  List(NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST)
){
  val num_input_per_operand  = ListBuffer.fill(operations.map(OpInfo.getOperandNum(_)).max){from_dir.size}
  val num_output : Int = 1

  def == (gpe : GpeParam): Boolean = {
    operations == gpe.operations &&  num_input_per_operand == gpe.num_input_per_operand
  }
}

//object GpeParam {
//  def apply(spec : GpeSpec)= {
//    new GpeParam(spec)
//  }
//}

// IOB parameters
case class IobParam(
  mode : Int = SRAM_MODE,
  max_delay : Int = 4
) {

  val num_input_per_operand = {
    val numOperand = IobMode.numOperands(mode)
    ListBuffer.fill(numOperand){2}
  }

  val num_output : Int = 1

  def == (iob : IobParam): Boolean = {
    mode == iob.mode
  }

}


// GIB parameters
case class GibParam(
  num_track : Int = 1,
  diag_iopin_connect : Boolean = true,
  fc_list : List[Int] = List(2, 4, 4)
//  val connect_flexibility = mutable.Map(
//    ("num_itrack_per_ipin" -> fc_list(0)),
//    ("num_otrack_per_opin" -> fc_list(1)),
//    ("num_ipin_per_opin" -> fc_list(2))
//  )
){
  var num_iopin_list = mutable.Map[String, Int]()
  var track_directions : ListBuffer[Int] = ListBuffer()
  var track_reged = false

  def == (gib : GibParam):Boolean = {

    // if(num_track == gib.num_track &&
    // diag_iopin_connect == gib.diag_iopin_connect &&
    // fc_list == gib.fc_list &&
    // track_directions == gib.track_directions &&
    // num_iopin_list == gib.num_iopin_list){
    //   println("this.num_iopin_list:", num_iopin_list)
    //   println("that.num_iopin_list:", gib.num_iopin_list)
    // }

    num_track == gib.num_track &&
    diag_iopin_connect == gib.diag_iopin_connect &&
    fc_list == gib.fc_list &&
    track_directions == gib.track_directions &&
    num_iopin_list == gib.num_iopin_list && 
    track_reged == gib.track_reged
  }

}

//object GibParam {
//  def apply (spec : GibSpec) : GibParam = {
//    new GibParam(spec)
//  }
//}


// CGRA Parameters
case class MultiTileCgraParam(attrs: mutable.Map[String, Any]){
  // ====== Global attributes =======//
  val tile_rows = attrs("tile_num_row").asInstanceOf[Int]     // PE number in a row
  val tile_cols = attrs("tile_num_column").asInstanceOf[Int]   // PE number in a colum
  val tile_num  = attrs("cgra_tile_num").asInstanceOf[Int]   // PE number in a colum
  val dataWidth = attrs("cgra_data_width").asInstanceOf[Int] // data width in bit
  // cfgParams
  val cfgDataWidth = attrs("cgra_cfg_data_width").asInstanceOf[Int]
  val cfgAddrWidth = attrs("cgra_cfg_addr_width").asInstanceOf[Int]
  val cfgBlkOffset = attrs("cgra_cfg_blk_offset").asInstanceOf[Int]   // configuration offset bit of blocks

  // ====== GPE-Specific attributes =======//
  // parameters of GPEs in 2D
  // which directions are the GPE input from
  val gpeInFromDir = attrs("cgra_gpe_in_from_dir").asInstanceOf[List[Int]]
  // which directions are the GPE output to
  val gpeOutToDir= attrs("cgra_gpe_out_to_dir").asInstanceOf[List[Int]]
  val gpesSpec = attrs("cgra_gpes").asInstanceOf[ListBuffer[ListBuffer[GpeSpec]]]
  val gpesParam = gpesSpec.map{ buf =>
    buf.map{ spec => GpeParam(spec.max_delay, spec.operations, gpeInFromDir, gpeOutToDir) }
  }
  val gpe_operations = gpesSpec.flatten.map(_.operations).reduce(_++_).distinct
  // different types of GPEs (as submodules)
  // the type of each GPE (as instance)
  val gpe_typemap : mutable.Map[Int, GpeParam] =  mutable.Map() // [type-id, GpeParam]
  val gpe_posmap : mutable.Map[(Int,Int,Int), Int] = mutable.Map() // [(tile, x, y), type-id]

  // ====== GIB-Specific attributes =======//
  val numTrack = attrs("cgra_gib_num_track").asInstanceOf[Int]
  // trackRegedMode, 0: no reg; 1: half of GIBs reged; 2: all GIBs reged
  val trackRegedMode = attrs("cgra_gib_track_reged_mode").asInstanceOf[Int]
  // parameters of GIBs in 2D
  val gibsSpec = attrs("cgra_gibs").asInstanceOf[ListBuffer[ListBuffer[GibSpec]]]
  val gibsParam = gibsSpec.map{ buf =>
    buf.map{ spec => GibParam(numTrack, spec.diag_iopin_connect, spec.fc_list) }
  }
  // println("gibsParam:", gibsParam)
  // different types of GIBs (as submodules)
  // the type of each GIB (as instance)
  val gib_typemap : mutable.Map[Int, GibParam] =  mutable.Map()
  val gib_posmap : mutable.Map[(Int,Int,Int), Int] = mutable.Map()// [(tile, x, y), type-id] 

  // ====== IOB-Specific attributes =======//
  val addrWidthSram = attrs("cgra_iob_sram_addr_width").asInstanceOf[Int] - log2Ceil(dataWidth/8)   // address width (+1 every data width)
  val hasMaskSram = attrs("cgra_iob_sram_has_mask").asInstanceOf[Boolean]  // if has write data byte mask
  val addRegSram = attrs("cgra_iob_sram_add_reg").asInstanceOf[Int]        // write/read latency, 0 : 0/1; 1 : 1/2; 2 : 1/3;
  val load_latency = addRegSram + 1
  val store_latency = {if(addRegSram > 0) 1 else 0}
//  val iobMode = attrs("cgra_iob_mode").asInstanceOf[Int]                   // 0: FIFO mode (with din, dout), 1: SRAM mode (with addr, din, dout)
  val numIOBSides = attrs("cgra_iob_num_sides").asInstanceOf[Int]          // IOB in one/two sides
  val agNestLevels = attrs("cgra_iob_ag_nest_levels").asInstanceOf[Int]    // nested levels of the address generation
//  val maxDelayIob = attrs("cgra_iob_max_delay").asInstanceOf[Int]          // max delay cycles of the DelayPipe in IOB
//  val numInIOCtrl = { if(iobMode == FIFO_MODE) 1 else 2 }
  val tile_numIOB = if(numIOBSides>2) 2*tile_cols+(numIOBSides-2)*tile_rows  else numIOBSides*tile_cols

  require(numIOBSides<=2)
  val tile_numSubModules = numIOBSides*tile_cols/*iobs*/ + tile_rows*tile_cols/*gpes*/ + (tile_rows + 1)*tile_cols/*gibs*/
  var cfgTileOffset = tile_numSubModules << cfgBlkOffset
  
  val iobModeNames = Map(
    FIFO_MODE -> "FIFO_MODE",
    SRAM_MODE -> "SRAM_MODE",
    COND_LS_MODE -> "COND_LS_MODE"
  )

  // parameters of IOBs in 2D
  val iobsSpec = attrs("cgra_iobs").asInstanceOf[ListBuffer[ListBuffer[IobSpec]]]
  val iobsParam = iobsSpec.map{ buf =>
    buf.map{ spec => IobParam(spec.mode, spec.max_delay) }
  }
  val iob_modes = iobsSpec.flatten.map(_.mode).distinct
  val iob_operations = ListBuffer[String]()
  iob_operations ++= iob_modes.flatMap(IobMode.operationCapabilities).distinct

  // set operation set and data width
  OpInfo.apply(dataWidth).apply(gpe_operations ++ iob_operations)
  // different types of IOBs (as submodules)
  // the type of each IOB (as instance)
  val iob_typemap : mutable.Map[Int, IobParam] =  mutable.Map() // [type-id, IobParam]
  val iob_posmap : mutable.Map[(Int, Int, Int), Int] = mutable.Map() // [(tile, x, y), type-id]


  val lgMaxLat = attrs("cgra_lg_max_lat").asInstanceOf[Int]            // log2(max in/out latency)
  val lgMaxII = attrs("cgra_lg_max_ii").asInstanceOf[Int]              // log2(max in/out Initialization Interval)
  val lgMaxStride = attrs("cgra_lg_max_stride").asInstanceOf[Int]      // log2(max address stride, n represent n*dataWidth bits)
  val lgMaxCycles = attrs("cgra_lg_max_cycles").asInstanceOf[Int]      // log2(max in/out cycles)
  val lgMaxInit = attrs("cgra_lg_max_init").asInstanceOf[Int]      // log2(max init)
  val iob_to_spad_banks = mutable.Map[Int, List[Int]]() // the scratchpad banks connected to each IOB
  var spad_bank_lg_size : Int = 0
  var cfg_spad_lg_size : Int = 0
  var cfg_spad_data_width : Int = cfgDataWidth

  for(tile <- 0 until tile_num){
    /// set coalesce after initialize each tile
    if(attrs.contains("cgra_iob_sram_banks_coalesce")){
      // divide all the banks into n groups where the internal banks are coalesced
      // eg. {0, 1}, {2, 3}, {4, 5},...
      // val coalesceBanksIOB = attrs("cgra_iob_sram_banks_coalesce").asInstanceOf[Int]
      val i_offset = tile*tile_numIOB
      for(i <- 0 until tile_numIOB by tile_numIOB/2){
        val coalBanks = tile_numIOB/2 min (tile_numIOB-(i)) // last group may have banks no more than coalesceBanks
        // println(i, coalBanks)
        val range = (i+i_offset until (i+coalBanks+i_offset)).toList
        range.foreach{ x =>
          iob_to_spad_banks += x -> range
        }
        // println(range)
      }
      spad_bank_lg_size = attrs("spad_bank_lg_size").asInstanceOf[Int]
      cfg_spad_lg_size = attrs("spad_cfg_lg_size").asInstanceOf[Int]
      cfg_spad_data_width = attrs("spad_data_width").asInstanceOf[Int]
    }else{
      (0 until tile_numIOB).foreach{ x =>
        iob_to_spad_banks += x -> List(x)
      }
      spad_bank_lg_size = attrs("cgra_iob_sram_addr_width").asInstanceOf[Int]
    }


    // find different types of GPEs (as submodules) according to the GPE Parameter
    // get the type of each GPE (as instance)
    for( x <- 0 until gpesParam.size){
      for( y <- 0 until gpesParam.head.size){
        val gpe = gpesParam(x)(y)
        val res = gpe_typemap.find(ins => ins._2 == gpe)
        val type_id = {
          if(res.isDefined){ // find a type
            res.get._1
          }else{ // create a new type
            val new_type_id = gpe_typemap.size
            gpe_typemap += (new_type_id -> gpe)
            new_type_id
          }
        }
        gpe_posmap += ((tile, x, y) -> type_id)
      }
    }

    // get the type of each IOB (as instance)
    for( x <- 0 until iobsParam.size){
      for( y <- 0 until iobsParam.head.size){
        val iob = iobsParam(x)(y)
        val res = iob_typemap.find(ins => ins._2 == iob)
        val type_id = {
          if(res.isDefined){ // find a type
            res.get._1
          }else{ // create a new type
            val new_type_id = iob_typemap.size
            iob_typemap += (new_type_id -> iob)
            new_type_id
          }
        }
        iob_posmap += ((tile,x,y) -> type_id)
      }
    }

    // find different types of GIBs (as submodules) according to the GIB Parameter
    // get the type of each GIB (as instance)
    for(i <- 0 until gibsParam.size){
      for(j <- 0 until gibsParam.head.size){
        val gib = gibsParam(i)(j).copy()
        val num_iopin_list = mutable.Map[String, Int]()
        num_iopin_list += "ipin_nw" -> {
          if(i == 0 && j > 0)
            iobsParam(0)(j - 1).num_input_per_operand.size // operand number
          else if(i > 0 && j > 0) {
            if(gpesParam(i - 1)(j - 1).from_dir.contains(SOUTHEAST)) {
              gpesParam(i - 1)(j - 1).num_input_per_operand.size // operand number
            } else {
              0
            }
          }
          else if(i == 0 && j == 0 && tile > 0)
            iobsParam(0)(tile_cols - 1).num_input_per_operand.size // operand number
          else if(i > 0 && j ==0 && tile > 0) {
            // println("here")
            // println("gpesParam(i - 1)(tile_cols - 1):", gpesParam(i - 1)(tile_cols - 1))
            if(gpesParam(i - 1)(tile_cols - 1).from_dir.contains(SOUTHEAST)) {
              // println("gpesParam(i - 1)(tile_cols - 1).num_input_per_operand.size:", gpesParam(i - 1)(tile_cols - 1).num_input_per_operand.size)
              gpesParam(i - 1)(tile_cols - 1).num_input_per_operand.size // operand number
            } else {
              0
            }
          }
          else if(i>0 && j ==0  && tile == 0){
            if (numIOBSides > 2)
              iobsParam(2)(i - 1).num_input_per_operand.size // operand number
            else
              0
          }
          else 0
        }
        num_iopin_list += "opin_nw" -> {
          if(i == 0 && j > 0)
            iobsParam(0)(j - 1).num_output
          else if(i > 0 && j > 0){
            if(gpesParam(i - 1)(j - 1).to_dir.contains(SOUTHEAST)){
              gpesParam(i - 1)(j - 1).num_output
            }else {
              0
            }
          } 
          else if(i == 0 && j == 0 && tile > 0)
            iobsParam(0)(tile_cols - 1).num_output
          else if(i>0 && j ==0 && tile > 0) {
            if(gpesParam(i - 1)(tile_cols - 1).to_dir.contains(SOUTHEAST)){
              gpesParam(i - 1)(tile_cols - 1).num_output
            }else {
              0
            }
          } 
          else if (i > 0 && j == 0 && tile == 0) {
            if (numIOBSides > 2)
              iobsParam(2)(i - 1).num_output // operand number
            else
              0
          }
          else 0
        }
        num_iopin_list += "ipin_ne" -> {
          if(i == 0 && j < tile_cols)
            iobsParam(0)(j).num_input_per_operand.size // operand number
          else if(i > 0 && j < tile_cols) {
            if(gpesParam(i-1)(j).from_dir.contains(SOUTHWEST)) {
              gpesParam(i-1)(j).num_input_per_operand.size
            }else{
              0
            }
          }
          else if (i > 0 && j == tile_cols) {
            if (numIOBSides > 3)
              iobsParam(3)(i - 1).num_input_per_operand.size // operand number
            else
              0
          }
          else 0
        }
        num_iopin_list += "opin_ne" -> {
          if(i == 0 && j < tile_cols)
            iobsParam(0)(j).num_output
          else if(i > 0 && j < tile_cols) {
            if(gpesParam(i-1)(j).to_dir.contains(SOUTHWEST)){
              gpesParam(i-1)(j).num_output
            }else{
              0
            }
          }
          else if (i > 0 && j == tile_cols) {
            if (numIOBSides > 3)
              iobsParam(3)(i - 1).num_output // operand number
            else
              0
          }
          else 0
        }
        num_iopin_list += "ipin_se" -> {
          if(i == tile_rows && j < tile_cols) {
            if(numIOBSides > 1)
              iobsParam(1)(j).num_input_per_operand.size // operand number
            else
              0
          } else if(i < tile_rows && j < tile_cols) {
            if(gpesParam(i)(j).from_dir.contains(NORTHWEST)) {
              gpesParam(i)(j).num_input_per_operand.size
            }else{
              0
            }
          }
          else if(i < tile_rows && j == tile_cols) {
            if (numIOBSides > 3)
              iobsParam(3)(i).num_input_per_operand.size
            else
              0
          }
          else 0
        }
        num_iopin_list += "opin_se" -> {
          if(i == tile_rows && j < tile_cols){
            if(numIOBSides > 1)
              iobsParam(1)(j).num_output
            else
              0
          } else if(i < tile_rows && j < tile_cols) {
            if(gpesParam(i)(j).to_dir.contains(NORTHWEST)){
              gpesParam(i)(j).num_output
            }else {
              0
            }
          }
          else if (i < tile_rows && j == tile_cols) {
            if (numIOBSides > 3)
              iobsParam(3)(i).num_output
            else
              0
          }
          else 0
        }
        num_iopin_list += "ipin_sw" -> {
          if(i == tile_rows && j > 0) {
            if(numIOBSides > 1)
              iobsParam(1)(j-1).num_input_per_operand.size // operand number
            else
              0
          }
          else if(i < tile_rows && j > 0) {
            if(gpesParam(i)(j-1).from_dir.contains(NORTHEAST)) {
              gpesParam(i)(j-1).num_input_per_operand.size
            }else{
              0
            }
          }
          else if(i == tile_rows && j == 0 && tile > 0) {
            if(numIOBSides > 1)
              iobsParam(1)(tile_cols-1).num_input_per_operand.size // operand number
            else
              0
          }
          else if (i < tile_rows && j == 0 && tile > 0){
            if(gpesParam(i)(tile_cols-1).from_dir.contains(NORTHEAST)) {
              gpesParam(i)(tile_cols-1).num_input_per_operand.size
            }else{
              0
            }
          }
          else if (i < tile_rows && j == 0 && tile == 0) {
            if (numIOBSides > 2)
              iobsParam(2)(i).num_input_per_operand.size
            else
              0
          }
          else 0
        }
        num_iopin_list += "opin_sw" -> {
          if(i == tile_rows && j > 0) {
            if(numIOBSides > 1)
              iobsParam(1)(j-1).num_output
            else
              0
          }
          else if(i < tile_rows && j > 0) {
            if(gpesParam(i)(j-1).to_dir.contains(NORTHEAST)){
              gpesParam(i)(j-1).num_output
            }else{
              0
            }
          }
          else if(i == tile_rows && j == 0 && tile > 0) {
            if(numIOBSides > 1)
              iobsParam(1)(tile_cols-1).num_output 
            else
              0
          }
          else if(i < tile_rows && j == 0 && tile > 0) {
            if(gpesParam(i)(tile_cols - 1).to_dir.contains(NORTHEAST)){
              gpesParam(i)(tile_cols - 1).num_output
            }else{
              0
            }
          }
          else if (i < tile_rows && j == 0) {
            if(numIOBSides > 2)
              iobsParam(2)(i).num_output
            else
              0
          }
          else 0
        }
        // println("num_iopin_list:", num_iopin_list)
        gib.num_iopin_list = num_iopin_list
        // if there are register behind the GIB
        val reged = {
          if(trackRegedMode == 0) false
          else if(trackRegedMode == 2) true
          else (i%2 + j%2) == 1
        }
        gib.track_reged = if(tile % 2 == 1 && tile_cols % 2 == 1) !reged else reged
        // which side has tracks
        val trackdirbuf : ListBuffer[Int] = ListBuffer()
        if(j > 0 || tile > 0) trackdirbuf.append( WEST ) // WEST
        if(i > 0) trackdirbuf.append( NORTH ) // NORTH
        if((j + 1) < gibsParam.head.size || tile < tile_num - 1)  trackdirbuf.append( EAST ) // EAST
        if((i + 1) < gibsParam.size)  trackdirbuf.append( SOUTH )  // SOUTH
        gib.track_directions = trackdirbuf
        // find the type of each GIB
        val res = gib_typemap.find(ins => ins._2 == gib)

        val type_id = {
          if(res.isDefined){ // find a type
            res.get._1
          }else{ // create a new type
            val new_type_id = gib_typemap.size
            gib_typemap += (new_type_id -> gib)
            new_type_id
          }
        }
        // println("tile, i , j, tracked_reg: gib type", tile, i, j,gib.track_reged, type_id)
        gib_posmap += ((tile, i, j) -> type_id)
      }
    }
  } /// end tile
}

//object CgraParam{
//  def apply(attrs: mutable.Map[String, Any]) = {
//    new CgraParam(attrs)
//  }
//}
