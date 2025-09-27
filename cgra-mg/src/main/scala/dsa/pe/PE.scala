package tram.dsa

import chisel3._
import chisel3.util._
import scala.collection.mutable
import scala.collection.mutable.{ListBuffer, ArrayBuffer}
import scala.math.{pow}
import tram.op._
import tram.ir._

//// GPE: Generic Processing Element
//// GPE attributes
//trait GpeAttrs {
//  // data width
//  val width : Int
//  // cfgParams
//  val cfgDataWidth : Int
//  val cfgAddrWidth : Int
//  val cfgBlkIndex : Int   // configuration index of this block, cfg_addr[width-1 : offset]
//  val cfgBlkOffset : Int  // configuration offset bit of blocks
//}

/** GPE: Generic Processing Element
 * 
 * @param attrs     module attributes
 */ 
class GPE(attrs: mutable.Map[String, Any]) extends Module with IR {
//  apply(attrs)
  val width = attrs("data_width").asInstanceOf[Int]
  // cfgParams
  val cfgDataWidth = attrs("cfg_data_width").asInstanceOf[Int]
  val cfgAddrWidth = attrs("cfg_addr_width").asInstanceOf[Int]
  val cfgBlkIndex  = attrs("cfg_blk_index").asInstanceOf[Int]     // configuration index of this block, cfg_addr[width-1 : offset]
  val cfgBlkOffset = attrs("cfg_blk_offset").asInstanceOf[Int]   // configuration offset bit of blocks
  // number of registers in Regfile
//  val numRegRF = attrs("num_rf_reg").asInstanceOf[Int]
  // supported operations
  val ops = attrs("operations").asInstanceOf[ListBuffer[String]]
  //val ops = opsStr.map(OPC.withName(_))
  val hasISel = ops.map(OpInfo.isISelection(_) < 0).reduce(_ | _)
  val hasInterleaverOp = ops.map { op => OpInfo.InterleaverInfoMap.contains(op) }.reduce(_ | _) // @jhlou: has INTLV operations
  val hasMac = ops.map { op => OpInfo.MacOpInfoMap.contains(op) }.reduce(_ | _) // @jhlou: has mac operations
  val hasAcc = ops.map(OpInfo.isAccumulative(_) > 0).reduce(_ | _) || hasISel || hasInterleaverOp || hasMac// has accumulate operations
//  val hasNonAcc = ops.map(OpInfo.isAccumulative(_) == 0).reduce(_ | _) // has no accumulate operations
//  val hasCondAcc = ops.map { op =>
//    OpInfo.CondAccOpInfoMap.contains(op) || OpInfo.CondInitAccOpInfoMap.contains(op)
//  }.reduce(_ | _) // has conditional (reset) accumulate operations
  val hasNonAcc = ops.map(OpInfo.isAccumulative(_) == 0).reduce(_ | _) // has no accumulate operations
  val hasCondAcc = ops.map { op =>
    OpInfo.CondAccOpInfoMap.contains(op) || OpInfo.CondInitAccOpInfoMap.contains(op)
  }.reduce(_ | _) // has conditional (reset) accumulate operations
  val useDualDMRInput =  hasISel
  val operandNum = ops.map(OpInfo.getOperandNum(_)).max
  val aluOperandNum = ops.map(OpInfo.getOperandNum(_)).max

  // val aluCfgWidth = log2Ceil(OPC.numOPC) // ALU Config width
  val numInPerOperand = attrs("num_input_per_operand").asInstanceOf[ListBuffer[Int]]

  // println("aluOperandNum", aluOperandNum)
  // println("numInPerOperand", numInPerOperand)
  // max delay cycles of the DelayPipe
  val maxDelay = attrs("max_delay").asInstanceOf[Int]
  val hasIACC = ops.map(OpInfo.isISelection(_) == -2 ).reduce(_ | _)
  val lgMaxWI = { if(hasAcc) attrs("lg_max_wi").asInstanceOf[Int] else 0 }              // log2(max writing Interval)
  val lgMaxLat = { if(hasAcc) attrs("lg_max_lat").asInstanceOf[Int] else 0 }            // log2(max starting latency)
  val lgMaxCycles = { if(hasAcc) attrs("lg_max_cycles").asInstanceOf[Int] else 0 }      // log2(max writing cycles)
  val lgMaxRepeats = { if(hasAcc) attrs("lg_max_repeats").asInstanceOf[Int] else 0 }    // log2(max repeat number)
  val lgMaxII = {if(hasAcc) attrs("lg_max_ii").asInstanceOf[Int] else 0}              // log2(max in/out Initialization Interval)
  apply("data_width", width)
  apply("num_operands", aluOperandNum)
  apply("num_input", numInPerOperand.sum)
  apply("num_output", 1)
  apply("cfg_blk_index", cfgBlkIndex)
//  apply("num_rf_reg", numRegRF)
  apply("operations", ops)
  apply("max_delay", maxDelay)


  val io = IO(new Bundle {
    val cfg_en = Input(Bool())
    // val cfg_en_w = Input(Bool())
    val cfg_addr = Input(UInt(cfgAddrWidth.W))
    val cfg_data = Input(UInt(cfgDataWidth.W))
    val start = Input(Bool()) // pulse signal, should be valid before latency 0, namely -1
    val en = Input(Bool())
    val in = Input(Vec(numInPerOperand.sum, UInt(width.W)))   
    val out = Output(Vec(1, UInt(width.W))) 
  })
  val aluOps = ops.map(OpInfo.getALUOp(_)).distinct
  // println("aluOps: ", aluOps)
  val alu = Module(new ALU(width, aluOps))
//  val rf = Module(new RF(width, numRegRF, 1, 2))
  val dmr = Module(new DualModeReg(width, hasAcc, useDualDMRInput,lgMaxWI, lgMaxLat, lgMaxCycles, lgMaxRepeats,lgMaxII ,hasIACC))
  val delay_pipe = Module(new SharedDelayPipe(width, maxDelay, aluOperandNum))
  //  val delay_pipes = Array.fill(aluOperandNum){ Module(new DelayPipe(width, maxDelay)).io }
  val const = Wire(UInt(width.W))
//  val extraMuxIns = {
//    if(hasAcc && aluOperandNum > 1){
//      2 // const + REG
//    }else{
//      1 // const
//    }
//  }
  //val imuxs = numInPerOperand.map{ num => Module(new Muxn(width, num+extraMuxIns)).io } // input + const + (rf_out)
  val imuxs = numInPerOperand.map{ num => Module(new Muxn(width, num+1)).io } // input + const
  val opcWidth = OpInfo.ALUOPCWidth
  val opc = Wire(UInt(opcWidth.W))

  // ======= sub_module attribute ========//
  // 1 : Constant
  // 2-n : sub-modules
  val sm_id: Map[String, Int] = Map(
    "Const" -> 1,
    "ALU" -> 2,
    "REG" -> 3,
    "DelayPipe" -> 4,
    "Muxn" -> 5
  )

  val sub_modules = sm_id.map{case (name, id) => Map(
    "id" -> id,
    "type" -> name
  )}
  apply("sub_modules", sub_modules)

  // ======= sub_module instance attribute ========//
  // 0 : this module
  // 1 : Constant
  // 2-n : sub-modules
  val smi_id: Map[String, List[Int]] = Map(
    "This" -> List(0),
    "Const" -> List(1),
    "ALU" -> List(2),
    "REG" -> List(3),
    "DelayPipe" -> List(4), // (4 until aluOperandNum+4).toList,
    "Muxn" -> (5 until aluOperandNum+5).toList, // (aluOperandNum+4 until 2*aluOperandNum+4).toList
  )
  val next_smi_id : Int = aluOperandNum+5
  val instances = smi_id.map{case (name, ids) =>
    ids.map{id => Map(
      "id" -> id,
      "type" -> name,
      "module_id" -> {if(name == "This") 0 else sm_id(name)}
    )}
  }.flatten
  apply("instances", instances)

  // ======= connections attribute ========//
  // apply("connection_format", ("src_id", "src_type", "src_out_idx", "dst_id", "dst_type", "dst_in_idx"))
  // This:src_out_idx is the input index
  // This:dst_in_idx is the output index
  val connections = ListBuffer(
    (smi_id("ALU")(0), "ALU", 0, smi_id("REG")(0), "REG", 0),
    (smi_id("REG")(0), "REG", 0, smi_id("This")(0), "This", 0)
  )
  delay_pipe.io.en := io.en
  alu.io.en := io.en
  dmr.io.en := io.en
  dmr.io.in(0) := alu.io.out
  alu.io.launch := dmr.io.launch
  io.out(0) := dmr.io.out(0)
  if(useDualDMRInput){
    dmr.io.in(1) := delay_pipe.io.out(1)
//    connections.append((smi_id("DelayPipeCG")(0), "DelayPipeCG", 1, smi_id("DMR")(0), "DMR", 1, width))
  }
  dmr.io.con_en := DontCare
  dmr.io.init := DontCare
//  val isAccOp = RegInit(false.B)
//  if(hasAcc){
//    dmr.io.start := io.start //TODO:
//    isAccOp := OpInfo.isAccOp(opc)
//    dmr.io.bypass := !isAccOp
//  }else{
//    dmr.io.start := DontCare
//    dmr.io.bypass := DontCare
//  }
  if (!hasAcc) {
    dmr.io.start := DontCare
    dmr.io.mode := DontCare
  } else {
    dmr.io.start := io.start
    dmr.io.mode := OpInfo.getAccMode(opc)
    if (hasCondAcc) { // do not record connections
      dmr.io.con_en := delay_pipe.io.out(1)(0)
      if (operandNum > 2) {
        dmr.io.init := delay_pipe.io.out(2)(0)
      }
    }
  }

  /////// IMUX
  var offset = 0
  for(i <- 0 until aluOperandNum){
    val num = numInPerOperand(i)
    imuxs(i).in.zipWithIndex.foreach{ case (in, j) =>
      if(j == 0) {
        in := const
        connections.append((smi_id("Const")(0), "Const", 0, smi_id("Muxn")(i), "Muxn", j))
        //     } else if(j <= num) {
      }else {
        in := io.in(offset+j-1)
        connections.append((smi_id("This")(0), "This", offset+j-1, smi_id("Muxn")(i), "Muxn", j))
      }
//      else {
//        in := dmr.io.out(1)
//        connections.append((smi_id("REG")(0), "REG", 1, smi_id("Muxn")(i), "Muxn", j))
//      }
    }
    delay_pipe.io.in(i) := imuxs(i).out
    //alu.io.in(i) := delay_pipe.io.out(i)
    connections.append((smi_id("Muxn")(i), "Muxn", 0, smi_id("DelayPipe")(0), "DelayPipe", i))
    //connections.append((smi_id("DelayPipe")(0), "DelayPipe", i, smi_id("ALU")(0), "ALU", i))
    //    delay_pipes(i).en := io.en
    //    delay_pipes(i).in := imuxs(i).out
    //    alu.io.in(i) := delay_pipes(i).out
    offset += num
  }
//  if(hasAcc && aluOperandNum == 1){
//    alu.io.in(1) := dmr.io.out(1)
//    connections.append((smi_id("REG")(0), "REG", 1, smi_id("ALU")(0), "ALU", 1))
//  }
  if(!hasAcc && !hasInterleaverOp) { // no accumulative operation
    alu.io.in.zipWithIndex.foreach { case (in, i) =>
      in := delay_pipe.io.out(i)
      connections.append((smi_id("DelayPipe")(0), "DelayPipe", i, smi_id("ALU")(0), "ALU", i))
    }
  }else if(!hasNonAcc && !hasInterleaverOp){ // no basic (non-acc) operation
    when(OpInfo.isMacOp(opc)) {
      alu.io.in(0) := delay_pipe.io.out(0)
      alu.io.in(1) := delay_pipe.io.out(1)
      alu.io.in(2) := dmr.io.out(1)
    }.otherwise{
      alu.io.in(0) := dmr.io.out(1)
      alu.io.in(1) := delay_pipe.io.out(0)
    }
    //    connections.append((smi_id("DMR")(0), "DMR", 1, smi_id("ALU")(0), "ALU", 0))
    connections.append((smi_id("DelayPipe")(0), "DelayPipe", 0, smi_id("ALU")(0), "ALU", 1))
  } else { // has both basic and acc operations
    when(OpInfo.isnotAccOp(opc) || OpInfo.isInterleaverOp(opc)) {
      alu.io.in(0) := delay_pipe.io.out(0)
      alu.io.in(1) := delay_pipe.io.out(1)
    }.elsewhen(OpInfo.isMacOp(opc)) {
      alu.io.in(0) := delay_pipe.io.out(0)
      alu.io.in(1) := delay_pipe.io.out(1)
    }.otherwise {
      alu.io.in(0) := dmr.io.out(1)
      alu.io.in(1) := delay_pipe.io.out(0)
    }
   
    alu.io.in.zipWithIndex.foreach { case (in, i) =>
      if(hasMac && i == 2){
        when(OpInfo.isMacOp(opc)){
          in := dmr.io.out(1)
        }
        .otherwise{
          in := delay_pipe.io.out(i) 
        }
      }
      else if (i > 1) {
        in := delay_pipe.io.out(i)
      }
      connections.append((smi_id("DelayPipe")(0), "DelayPipe", i, smi_id("ALU")(0), "ALU", i))
    }
  }

  // apply("connections", connections)
  apply("connections", connections.zipWithIndex.map{case (c, i) => i -> c}.toMap)

  // ======= configuration attribute ========//
  // configuration memory
  val constCfgWidth = width // constant
  val aluCfgWidth = alu.io.config.getWidth // ALU Config width
  val rfCfgWidth = dmr.io.config.getWidth  // REG
  //  val delayCfgWidthEach = delay_pipes(0).config.getWidth // DelayPipe Config width
  //  val delayCfgWidth = aluOperandNum * delayCfgWidthEach
  val delayCfgWidth = delay_pipe.io.config.getWidth
  val imuxCfgWidthList = imuxs.map{ mux => mux.config.getWidth } // input Muxes
  val imuxCfgWidth = imuxCfgWidthList.sum
  val sumCfgWidth = constCfgWidth + opcWidth + rfCfgWidth + delayCfgWidth + imuxCfgWidth

  val cfg = Module(new ConfigMem(sumCfgWidth, 1, cfgDataWidth))
  cfg.io.cfg_en := io.cfg_en && (cfgBlkIndex.U === io.cfg_addr(cfgAddrWidth-1, cfgBlkOffset))
  cfg.io.cfg_addr := io.cfg_addr(cfgBlkOffset-1, 0)
  cfg.io.cfg_data := io.cfg_data
  assert(cfg.cfgAddrWidth <= cfgBlkOffset)
  assert(cfgBlkIndex < (1 << (cfgAddrWidth-cfgBlkOffset)))

  val configuration = mutable.Map( // id : type, high, low
    smi_id("This")(0) -> ("This", sumCfgWidth-1, 0),
    smi_id("Const")(0) -> ("Const", constCfgWidth-1, 0)
  )

  val cfgOut = Wire(UInt(sumCfgWidth.W))//RegInit(0.U(sumCfgWidth.W))//Wire(UInt(sumCfgWidth.W))
  // val cfgOut_r = RegInit(0.U(sumCfgWidth.W))
  // cfgOut_r := Mux(io.cfg_en_w,cfg.io.out(0),cfgOut_r)
  // cfgOut := cfgOut_r
  cfgOut := cfg.io.out(0)


  //// config of alu
  const := cfgOut(constCfgWidth-1, 0)
  offset = constCfgWidth
  if(aluCfgWidth != 0){
    alu.io.config := cfgOut(offset+aluCfgWidth-1, offset)
    opc := cfgOut(offset+opcWidth-1, offset)
    configuration += smi_id("ALU")(0) -> ("ALU", offset+opcWidth-1, offset)
  } else {
    alu.io.config := DontCare
  }
  offset += opcWidth

//  if(rfCfgWidth != 0){
//    dmr.io.config := cfgOut(offset+rfCfgWidth-1, offset)
//    configuration += smi_id("REG")(0) -> ("REG", offset+rfCfgWidth-1, offset)
//  } else{
//    dmr.io.config := DontCare
//  }
//  offset += rfCfgWidth
  //  for(i <- 0 until aluOperandNum){
  //    if(delayCfgWidthEach != 0){
  //      delay_pipes(i).config := cfgOut(offset+delayCfgWidthEach-1, offset)
  //    } else {
  //      delay_pipes(i).config := DontCare
  //    }
  //    offset += delayCfgWidthEach
  //  }

  //// config of delay pipe
  if(delayCfgWidth != 0){
    delay_pipe.io.config := cfgOut(offset+delayCfgWidth-1, offset)
    configuration += smi_id("DelayPipe")(0) -> ("DelayPipe", offset+delayCfgWidth-1, offset)
  } else{
    delay_pipe.io.config := DontCare
  }
//  if(hasAcc && (aluOperandNum > 1)){
//    when(isAccOp){
//      val spCfgWidth = delay_pipe.cfgWidth // single port config width
//      if(aluOperandNum > 2){
//        delay_pipe.io.config := Cat(cfgOut(offset+delayCfgWidth-1, offset+2*spCfgWidth), 0.U(spCfgWidth.W), cfgOut(offset+spCfgWidth-1, offset))
//      }else{
//        delay_pipe.io.config := Cat(0.U(spCfgWidth.W), cfgOut(offset+spCfgWidth-1, offset))
//      }
//    }
//  }
  offset += delayCfgWidth

  //// config of imux
  for(i <- 0 until aluOperandNum){
    if(imuxCfgWidthList(i) != 0){
      imuxs(i).config := cfgOut(offset+imuxCfgWidthList(i)-1, offset)
      configuration += smi_id("Muxn")(i) -> ("Muxn", offset+imuxCfgWidthList(i)-1, offset)
    } else {
      imuxs(i).config := DontCare
    }
    offset += imuxCfgWidthList(i)
  }
//  if(hasAcc && aluOperandNum > 1){
//    when(isAccOp){
//      imuxs(1).config := (imuxs(1).in.size - 1).asUInt
//    }
//  }

  //// config of dmr
  if(rfCfgWidth != 0){
    dmr.io.config := cfgOut(offset+rfCfgWidth-1, offset)
    // AffineCtrlReg Config Ids
    val acr_cfg_id: mutable.Map[String, Int] = mutable.Map()
    dmr.cfg_idx.foreach{ case (key, (idx, high, low)) =>
      configuration += (next_smi_id+idx) -> (key, high+offset, low+offset)
      acr_cfg_id += key -> (next_smi_id+idx)
    }
    apply("affine_ctrl_reg_cfg_id", acr_cfg_id)
  } else{
    dmr.io.config := DontCare
  }
  offset += rfCfgWidth

  apply("configuration", configuration)
}
//class OneBitCrtlNet(numCores: Int) extends Module {
//  val io = IO(new Bundle {
//    val in  = Vec(numCores, Flipped(Decoupled(Bool())))
//    val out = Vec(numCores, Decoupled(Bool()))
////    val config = Input(UInt(log2Ceil(numCores * numCores).W))
////    val setConnection = Input(Bool())
//  })
//
//  val connections = RegInit(VecInit(Seq.fill(numCores)(VecInit(Seq.fill(numCores)(true.B)))))
//
//  // 配置交叉开关
//  //  when(io.setConnection) {
//  //    val src = io.config / numCores.U
//  //    val dst = io.config % numCores.U
//  //    connections(src)(dst) := true.B
//  //  }.otherwise {
//  //    val src = io.config / numCores.U
//  //    val dst = io.config % numCores.U
//  //    connections(src)(dst) := false.B
//  //  }
//
//  // 连接生成
//  for (i <- 0 until numCores) {
//    io.out(i).bits := 0.U
//    io.out(i).valid := false.B
//    io.in(i).ready := false.B
//    for (j <- 0 until numCores) {
//      when(connections(j)(i)) {
//        when(io.in(j).valid) { // 当输入有效时，进行连接
//          io.out(i).bits := io.in(j).bits
//          io.out(i).valid := true.B
//          io.in(j).ready := io.out(i).ready
//        }
//      }
//    }
//  }
//}
//
//object CrossbarSwitch extends App {
//  (new chisel3.stage.ChiselStage).emitVerilog(new OneBitCrtlNet(numCores = 4))
//}





// object VerilogGen extends App {
//   val attrs: mutable.Map[String, Any] = mutable.Map(
//     "data_width" -> 32,
//     "cfg_data_width" -> 32,
//     "cfg_addr_width" -> 8,
//     "cfg_blk_index" -> 1,
//     "cfg_blk_offset" -> 4,
//     "num_rf_reg" -> 1,
//     "operations" -> ListBuffer(/*"ADD", "SUB", "ACC", "ASUB",*/ "INTLV4"),
//     "num_input_per_operand" -> ListBuffer(4, 4, 4, 4),
//     "max_delay" -> 7,
//     "lg_max_lat" -> 8,
//     "lg_max_repeats" -> 8,
//     "lg_max_wi" -> 10,
//     "lg_max_ii" -> 5, 
//     "lg_max_cycles" -> 10,
//   )

//   (new chisel3.stage.ChiselStage).emitVerilog(new GPE(attrs),args)
// }