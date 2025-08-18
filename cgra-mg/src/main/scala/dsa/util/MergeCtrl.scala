package tram.dsa

import chisel3._
import chisel3.util._
import scala.collection.mutable

/** A controller to merge multiple inputs to a sequence output
  *
  * @param width          register data width
  * @param maxInputNum    max input number of merge
  * @param lgMaxII        log2(max output Interval)
  */
class MergeController(width: Int, maxInputNum: Int , lgMaxII: Int) extends Module {
  println("In merge, maxInputNum:", maxInputNum)
  val cfgWidth = log2Ceil(maxInputNum) + lgMaxII
  // val numOut = { if(isAffine) 2 else 1 }
  val io = IO(new Bundle {
    val start = Input(Bool()) // pulse signal, should be valid before latency 0, namely -1
    //val bypass = Input({if(isAffine) Bool() else UInt(0.W)}) // in -> reg -> out
    // val mergenum = Input(UInt({if(isAffine) 3 else 0}.W))
    val config = Input(UInt(cfgWidth.W))
    val in = Input(Vec(maxInputNum, UInt(width.W)))
    val en = Input(Bool())
    val out = Output(UInt(width.W))
  })
  // Config elements
  // [name, (id, high-bit, low-bit)]
  val cfg_idx: mutable.Map[String, (Int, Int, Int)] = mutable.Map()
  // io.config should keep constant during io.en is true
  var offset = 0
  var id = 0

  val MergeNum = io.config(log2Ceil(maxInputNum)+offset-1, offset)
  cfg_idx += "MergeNum" -> (id, log2Ceil(maxInputNum)+offset-1, offset)
  offset += log2Ceil(maxInputNum)
  id += 1

  val II = io.config(lgMaxII+offset-1, offset)
  cfg_idx += "II" -> (id, lgMaxII+offset-1, offset)
  offset += lgMaxII
  id += 1

  //// state machine
  val s_idle :: s_merge :: Nil = Enum(2)
  val state = RegInit(s_idle)
  val regs = RegInit(VecInit(Seq.fill(maxInputNum){0.U(width.W)}))
  val iiCnt = RegInit(0.U(lgMaxII.W))
  val iiEnd = iiCnt + 1.U >= II
  val mergeCnt = RegInit(0.U(log2Ceil(maxInputNum).W))
  val mergeEnd = mergeCnt + 1.U >= MergeNum

  switch(state){
    is(s_idle){
      iiCnt := 0.U
      mergeCnt := 0.U
      when(io.start){
        state := s_merge
      }
    }
    is(s_merge){
      iiCnt := Mux(iiEnd, 0.U, iiCnt + 1.U)
      mergeCnt := Mux(iiEnd, 
                    Mux(mergeEnd, 0.U, mergeCnt + 1.U),
                    mergeCnt)
      when(!io.en & iiEnd){
        state := s_idle
      }
    }
  }

  //// input
  regs.zipWithIndex.foreach{case (reg, i) =>
    when(i.U <= MergeNum){
      reg := io.in(i)
    }
  }

  //// output
  io.out := regs(mergeCnt)
}


// object VerilogGen extends App {
////   (new chisel3.stage.ChiselStage).emitVerilog(new AffineCtrlReg(32, 16, 8, 16, 16),args)
//   (new chisel3.stage.ChiselStage).emitVerilog(new DualModeReg(32, true, 16, 8, 16, 16),args)
// }
