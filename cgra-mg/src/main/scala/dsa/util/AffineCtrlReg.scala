package tram.dsa

import chisel3._
import chisel3.util._
import scala.collection.mutable


/** Controlled Register with Affine Access (Write) Pattern
 * 
 * @param width          register data width
 * @param lgMaxWI        log2(max writing Interval)
 * @param lgMaxLat       log2(max starting latency)
 * @param lgMaxCycles    log2(max writing cycles)
 * @param lgMaxRepeats   log2(max repeat number)
 */
class AffineCtrlReg(width: Int, lgMaxWI: Int,numIn: Int, lgMaxLat: Int, lgMaxCycles: Int, lgMaxRepeats: Int,lgMaxII: Int,hasIACC : Boolean = false) extends Module {
  val cfgWidth = width + lgMaxWI + lgMaxLat + lgMaxCycles + lgMaxRepeats + 1 + {
    if (hasIACC) {
      2 + 2 + lgMaxWI + lgMaxII
    } else 0
  } // width : Initialized value; 1 : if accept io.in at the first cycle
  val io = IO(new Bundle {
    val start = Input(Bool()) // pulse signal, should be valid before latency 0, namely -1
    //val bypass = Input(Bool()) // in -> reg -> out
    val mode = Input(UInt(3.W)) // 0: no acc, in -> reg -> out; 1: acc; 2: conditional acc; 3: conditional init and acc; 4: INTLV
    val en = Input(Bool())
    val con_en = Input(Bool())
    val config = Input(UInt(cfgWidth.W))
    val init = Input(Bool()) // initialize reg value
    val launch = Output(Bool()) // s_pre_lat is over
    val in = Input(Vec(numIn, UInt(width.W)))
    val out = Output(Vec(2, UInt(width.W)))
  })

  val valueReg = RegInit(0.U(width.W))
  val secondIn = {
    if(numIn > 1) io.in(1)
    else 0.U
  }
  // Config elements
  // [name, (id, high-bit, low-bit)]
  val cfg_idx: mutable.Map[String, (Int, Int, Int)] = mutable.Map()
  // io.config should keep constant during io.en is true
  var offset = 0
  var id = 0
  val initVal = io.config(width+offset-1, offset)
  cfg_idx += "InitVal" -> (id, width+offset-1, offset)
  offset += width
  id += 1
  val WI = io.config(lgMaxWI+offset-1, offset)
  cfg_idx += "WI" -> (id, lgMaxWI+offset-1, offset)
  offset += lgMaxWI
  id += 1
  val latency = io.config(lgMaxLat+offset-1, offset) // the latency of starting input or output
  cfg_idx += "Latency" -> (id, lgMaxLat+offset-1, offset)
  offset += lgMaxLat
  id += 1
  val cycles = io.config(lgMaxCycles+offset-1, offset)
  cfg_idx += "Cycles"-> (id, lgMaxCycles+offset-1, offset)
  offset += lgMaxCycles
  id += 1
  val repeats = io.config(lgMaxRepeats+offset-1, offset)
  cfg_idx += "Repeats"-> (id, lgMaxRepeats+offset-1, offset)
  offset += lgMaxRepeats
  id += 1
  val skipFirst = io.config(offset, offset).asBool
  cfg_idx += "SkipFirst"-> (id, offset, offset)
  offset += 1
  id += 1
  val reverse_addr = WireInit(0.U(2.W))
  val useIn = WireInit(0.U(2.W))
  val OutWI = WireInit(0.U(lgMaxWI.W))
  val II = WireInit(0.U(lgMaxII.W))
  if (hasIACC) {
    cfg_idx += "UseIn" -> (id, offset+1, offset)
    useIn := io.config(offset+1, offset) // whether use Inductive as enable
    offset += 2
    id += 1
    cfg_idx += "Reverse" -> (id, offset+1, offset)
    reverse_addr := io.config(offset+1, offset)
    offset += 2
    id += 1
    cfg_idx += "OutWI" -> (id, lgMaxWI+offset-1, offset)
    OutWI := io.config(lgMaxWI + offset-1, offset)
    offset += lgMaxWI
    id += 1 
    cfg_idx += "IIdmr" -> (id, lgMaxII+offset-1, offset)
    II := io.config(lgMaxII + offset-1, offset)
    offset += lgMaxII
    id += 1 
  }

  val s_idle :: s_pre_lat :: s_data :: Nil = Enum(3)
  val state = RegInit(s_idle)
  val wiCnt = RegInit(0.U(lgMaxWI.W))
  val outWICnt = RegInit(0.U(lgMaxWI.W))
  val WiInit = RegInit(0.U(lgMaxWI.W))
  val latCnt = RegInit(0.U(lgMaxLat.W))
  val cycleCnt = RegInit(0.U(lgMaxCycles.W))
  val repeatCnt = RegInit(0.U(lgMaxRepeats.W))
  //val wiEnd_Indu = Mux(useIn(2),Mux(reverse_addr(2),repeatCnt*II,WI-repeatCnt * II),Mux(useIn(1),Mux(reverse_addr(1),cycleCnt*II,Mux(OutWI === 0.U,WI-cycleCnt * II,WiInit)),WI))
  val wiEnd = if(hasIACC){ wiCnt + 1.U >= Mux(useIn(1),Mux(reverse_addr(1),cycleCnt*II,Mux(OutWI === 0.U,WI-cycleCnt * II,WiInit)),WI)}else{(wiCnt+1.U >= WI)}//3 for lud app
  val cycleCntEnd = if(hasIACC){cycleCnt+1.U >= Mux(useIn(0),Mux(reverse_addr(0) ,secondIn,cycles-secondIn),cycles)}else{(cycleCnt+1.U >= cycles)}
  val repeatCntEnd = (repeatCnt+1.U >= repeats)

  ///// mode
  val INTLV = io.mode === 7.U
  val Mac   = io.mode === 6.U
  val initSel = io.mode === 5.U
  val IACC = io.mode === 4.U
  val init = (io.mode === 3.U && io.init) || (io.mode =/= 3.U && cycleCnt === 0.U && skipFirst)
  val en = (io.mode === 1.U) || (io.mode > 1.U && io.con_en)|| initSel || IACC || INTLV || Mac

  switch(state){
    is(s_idle){
      latCnt := 0.U
      when(io.start && latency === 0.U){
        state := s_data
      }.elsewhen(io.start && latency =/= 0.U){
        state := s_pre_lat
      }
    }
    is(s_pre_lat){ // the latency before starting to write
      when(latCnt + 1.U >= latency){
        state := s_data
      }
      latCnt := latCnt + 1.U
    }
    is(s_data){
      when(INTLV && io.en){
        state := s_data
      }
      .elsewhen((repeatCntEnd && cycleCntEnd && wiEnd) || !io.en){
        state := s_idle
      }
    }
  }

  val launch = (state === s_data)
  io.launch := launch

  when(state === s_idle){
    wiCnt := 0.U
    if(hasIACC) {
    outWICnt := OutWI
    WiInit := WI
    }
  }.elsewhen(launch){
    wiCnt := Mux(wiEnd, 0.U, wiCnt+1.U)
    if(hasIACC) {
    outWICnt := Mux(wiEnd, outWICnt-1.U, outWICnt)
    WiInit := Mux(wiEnd,WiInit-outWICnt*II+II,WiInit)
    }
  }

  when(state === s_idle){
    cycleCnt := 0.U
  }.elsewhen(launch && wiEnd){
    cycleCnt := Mux(cycleCntEnd, 0.U, cycleCnt + 1.U)
  }

  when(state === s_idle){
    repeatCnt := 0.U
  }.elsewhen(launch && wiEnd && cycleCntEnd){
    repeatCnt := repeatCnt + 1.U
  }

//  when(io.bypass || (launch && wiCnt === 0.U && cycleCnt > 0.U)){
//    valueReg := io.in
//  }.elsewhen(launch && wiCnt === 0.U && cycleCnt === 0.U && !skipFirst){
//    valueReg := io.in
//  }.elsewhen(launch && wiCnt === 0.U && cycleCnt === 0.U && skipFirst){
//    valueReg := initVal
//  }


  when(io.mode === 0.U || INTLV) {
    valueReg := io.in(0)
  }.elsewhen(launch && wiCnt === 0.U) { // the first is acc value
    when(init) { 
      when(IACC){
        valueReg := secondIn
      }.elsewhen(initSel){
        /// jhlou : seem to be wrong. ISEL should be more powerful. Not just a pass node.
        valueReg := secondIn 
      }.otherwise{
        valueReg := initVal
      }
    }.elsewhen(en) {
      valueReg := io.in(0)
    }
  }
  // // @ jhlou : when mode===5, valuereg should := io.in(0)
  // .elsewhen(initSel && io.en){
  //   valueReg := io.in(0)
  // }

  io.out(0) := valueReg

  val valueRegAcc = RegInit(0.U(width.W))
//  when(state === s_idle){
//    valueRegAcc := initVal
//  }.elsewhen(launch && wiCnt === 0.U && cycleCnt === 0.U && skipFirst){
//    valueRegAcc := initVal
//  }.elsewhen(launch && wiCnt === 0.U && cycleCntEnd && !skipFirst){
//    valueRegAcc := initVal
//  }.elsewhen(launch && wiCnt === 0.U){
//    valueRegAcc := io.in
//  }
  val initAcc = (io.mode === 3.U && io.init) || (io.mode =/= 3.U && ((cycleCnt === 0.U && skipFirst) || (cycleCntEnd && !skipFirst)))
  when(state === s_idle) {
    valueRegAcc := initVal
  }.elsewhen(launch && wiCnt === 0.U) {
    when(initAcc) {
      when(IACC) {
        valueRegAcc := secondIn
      }.otherwise {
        valueRegAcc := initVal
      }
    }.elsewhen(en) {
      valueRegAcc := io.in(0)
    }
  }
  when(!io.en) {
    valueReg := 0.U
    valueRegAcc := 0.U
  }
  io.out(1) := valueRegAcc
}


/** Dual-mode Register supporting Affine Access (Write) Pattern and simple reg
  *
  * @param width          register data width
  * @param isAffine       is Affine Access (Write) Pattern
  * @param lgMaxWI        log2(max writing Interval)
  * @param lgMaxLat       log2(max starting latency)
  * @param lgMaxCycles    log2(max writing cycles)
  * @param lgMaxRepeats   log2(max repeat number)
  */
class DualModeReg(width: Int, isAffine: Boolean,isDualIn: Boolean, lgMaxWI: Int, lgMaxLat: Int, lgMaxCycles: Int, lgMaxRepeats: Int,lgMaxII: Int,hasIACC : Boolean = false) extends Module {
  val numIn = {if(isDualIn) 2 else 1}
  val cfgWidth = {
    if(isAffine){
      width + lgMaxWI + lgMaxLat + lgMaxCycles + lgMaxRepeats + 1 + {
        if (hasIACC) {
          2 + 2 + lgMaxWI + lgMaxII
        } else 0
      } // width : Initialized value; 1 : if accept io.in at the first cycle
    }else{
      0
    }
  }
  val numOut = { if(isAffine) 2 else 1 }
  val io = IO(new Bundle {
    val start = Input({if(isAffine) Bool() else UInt(0.W)}) // pulse signal, should be valid before latency 0, namely -1
    //val bypass = Input({if(isAffine) Bool() else UInt(0.W)}) // in -> reg -> out
    val mode = Input(UInt({if(isAffine) 3 else 0}.W))
    val con_en = Input({if(isAffine) Bool() else UInt(0.W)})  // acc enable
    val config = Input(UInt(cfgWidth.W))
    val in = Input(Vec(numIn, UInt(width.W)))
    val init = Input({if(isAffine) Bool() else UInt(0.W)}) // initialize reg value
    val en = Input({if(isAffine) Bool() else UInt(0.W)})
    val launch = Output({if(isAffine) Bool() else UInt(0.W)}) // for INTLV/DEINTLV
    val out = Output(Vec(numOut, UInt(width.W)))
  })

  // Config elements
  // [name, (id, high-bit, low-bit)]
  val cfg_idx: mutable.Map[String, (Int, Int, Int)] = mutable.Map()

  if(isAffine){
    val acr = Module(new AffineCtrlReg(width, lgMaxWI,numIn, lgMaxLat, lgMaxCycles, lgMaxRepeats,lgMaxII,hasIACC))
    acr.io.start := io.start
    acr.io.mode := io.mode
    acr.io.config := io.config
    acr.io.init := io.init
    acr.io.con_en := io.con_en
    acr.io.in(0) := io.in(0)
    if(isDualIn){
      acr.io.in(1) := io.in(1)
    }
    acr.io.en := io.en
    io.launch := acr.io.launch
    io.out := acr.io.out
    cfg_idx ++= acr.cfg_idx
  }else{
    io.out(0) := RegNext(io.in(0))
    io.launch := DontCare
  }

}


// object VerilogGen extends App {
////   (new chisel3.stage.ChiselStage).emitVerilog(new AffineCtrlReg(32, 16, 8, 16, 16),args)
//   (new chisel3.stage.ChiselStage).emitVerilog(new DualModeReg(32, true, 16, 8, 16, 16),args)
// }
