package tram.dsa

import chisel3._
import chisel3.util._
import scala.collection.mutable.ListBuffer
import tram.op._


/** reconfigurable arithmetic unit
 * 
 * @param width   data width
 */
class ALU(width: Int, ops: ListBuffer[String]) extends Module {
  val op_info = OpInfo(width)
  val maxNumOperands  = ops.map(OpInfo(width).getALUOperandNum(_)).max
  val maxNumResults   = ops.map(OpInfo(width).getALUResultNum(_)).max
  // println("maxNumOperands:", maxNumOperands)
  val cfgDataWidth =  OpInfo.BasicOPCWidth
  val io = IO(new Bundle {
    val en = Input(Bool())
    val launch = Input(Bool()) /// For INTLV DEINTLV
    val config = Input(UInt(cfgDataWidth.W))
    val in = Input(Vec(maxNumOperands, UInt(width.W)))
    val out = Output(UInt(width.W))
    // val out = Output(Vec(maxNumResults, UInt(width.W)))
  })

  // val op_func_map = OpInfo(width).OpFuncs(io.in.toSeq)
  val (op_func_map, shareUnitsCfgBits, op_SUCfg_map) = OpInfo(width).OpFuncs2(ops, io.in.toSeq, io.en, io.launch)
  // println("op_func_map", op_func_map)
  // println("shareUnitsCfgBits", shareUnitsCfgBits)
  // println("op_SUCfg_map", op_SUCfg_map)

  val op2res = ops.map{op =>
    (OpInfo.OPCMap(op).U -> op_func_map(op)(0))
    // (OpInfo.OPCMap(op).U -> op_func_map(op))
  }.toSeq
  // println("op2res", op2res)

  val op2shucfg = ops.filter(op => op_SUCfg_map.contains(op)).map { op =>
    (OpInfo.OPCMap(op).U -> op_SUCfg_map(op))
  }.toSeq
  // println("op2shucfg", op2shucfg)


  // val op2resSeq: Seq[(chisel3.UInt, chisel3.Data)] = op2res.toList.map{ case (k, v) => (k, v) }
  // println("op2resSeq", op2resSeq)

  io.out := MuxLookup(io.config, 0.U, op2res)

  shareUnitsCfgBits := MuxLookup(io.config, 0.U, op2shucfg)
}


// object VerilogGen extends App {
//   (new chisel3.stage.ChiselStage).emitVerilog(new ALU(32, ListBuffer("INTLV4", "ADD")),args)
// }
