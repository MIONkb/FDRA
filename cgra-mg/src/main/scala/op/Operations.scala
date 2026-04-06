package tram.op
// ALU/IOB operations

import chisel3._
import chisel3.util._

import scala.collection.immutable.ArraySeq
import scala.collection.mutable
import scala.collection.mutable.ListBuffer
import scala.Ordering.Implicits._
import scala.collection._
import tram.ir._
import tram.fpu._
import tram.common.CompileMacroVar.DIV_LATENCY

/**
	* Operation Code
	*/
//object OPC extends Enumeration {
//	type OPC = Value
//	// Operation Code
//	val PASS,    // passthrough from in to out
//		ADD,     // add
//	  SUB,     // substrate
//	  MUL,     // multiply
//	  UDIV,     // divide
//	  // MOD,     // modulo
//	  // MIN,
//	  // NOT,
////	  AND,
////	  OR,
////	  XOR,
//	  SHL,     // shift left
//	  LSHR,    // logic shift right
//		ASHR,    // arithmetic shift right
////	  CSHL,    // cyclic shift left
////	  CSHR,    // cyclic shift right
//	  EQ,      // equal to
//	  NE,      // not equal to
//	  ULT,      // less than
//	  ULE,      // less than or equal to
//		SEL,
//		ACC,	 // +=
//		ASUB,  // -=
////	  AMUL,  // *=
////		ADIV,  // /=
////		AMOD,  // %=
////		AAND,  // &=
////		AOR,   // |=
////		AXOR,  // ^=
////		ASHL,  // <<=
////		ALSHR, // >>=
////		AASHR, // >>>=
//		INPUT,
//		OUTPUT,
//		LOAD,
//		STORE = Value
//
//	val numOPC = this.values.size - 4 // not including INPUT/OUTPUT/LOAD/STORE, since ALU OPC config width is determined by numOPC
//
//	def printOPC = {
//		this.values.foreach{ op => println(s"$op\t: ${op.id}")}
//	}
//}

/**
	* Operation Information
	*/
object OpInfo {
	//	import OPC._
	// Basic ALU Operation Information
	val BasicOpInfoMap: Map[String, ListBuffer[Int]] = Map(
		// OpName -> List(NumOperands, NumRes, Latency, Operands-Commutative)
		// latency including the register outside ALU
		"PASS" -> ListBuffer(1, 1, 1, 0),
		"ADD" -> ListBuffer(2, 1, 1, 1),
		"SUB" -> ListBuffer(2, 1, 1, 0),
		"MUL" -> ListBuffer(2, 1, 1, 1),
		"UDIV" -> ListBuffer(2, 1, DIV_LATENCY, 0, 0),
		"SDIV" -> ListBuffer(2, 1, DIV_LATENCY, 0, 0),
		"UREM" -> ListBuffer(2, 1, DIV_LATENCY, 0, 0),
		"SREM" -> ListBuffer(2, 1, DIV_LATENCY, 0, 0),
		"MOD" -> ListBuffer(2, 1, 1, 0),
		"MIN" -> ListBuffer(2, 1, 1, 1),
		"MAX" -> ListBuffer(2, 1, 1, 1),
		"AND" -> ListBuffer(2, 1, 1, 1),
		"OR" -> ListBuffer(2, 1, 1, 1),
		"NOT" -> ListBuffer(1, 1, 1, 1),
		"XOR" -> ListBuffer(2, 1, 1, 1),
		"SHL" -> ListBuffer(2, 1, 1, 0),
		"LSHR" -> ListBuffer(2, 1, 1, 0),
		"ASHR" -> ListBuffer(2, 1, 1, 0),
		"CSHL" -> ListBuffer(2, 1, 1, 0),
		"CSHR" -> ListBuffer(2, 1, 1, 0),
		"EQ" -> ListBuffer(2, 1, 1, 1),
		"NE" -> ListBuffer(2, 1, 1, 1),
		"ULT" -> ListBuffer(2, 1, 1, 0),
		"ULE" -> ListBuffer(2, 1, 1, 0),
		"SLT" -> ListBuffer(2, 1, 1, 0),
		"SLE" -> ListBuffer(2, 1, 1, 0),
		"SEL" -> ListBuffer(3, 1, 1, 0),
		
		// not a complete macc base, maybe need a input(ask ydai about this)
		"MulAdd" -> ListBuffer(3, 1, 2, 0),

		// ListBuffer(NumOperands, NumRes, Latency, Operands-Commutative)
		"INTLV4BASE" -> ListBuffer(4, 1, 1, 0),
		"INTLV3BASE" -> ListBuffer(3, 1, 1, 0),
		"INTLV2BASE" -> ListBuffer(2, 1, 1, 0),
		"DEINTLV4BASE" -> ListBuffer(1, 4, 4, 0),
		"DEINTLV3BASE" -> ListBuffer(1, 3, 3, 0),
		"DEINTLV2BASE" -> ListBuffer(1, 2, 2, 0),
	)


	// val MergeInfoMap: Map[String, (ListBuffer[Int], String)] = Map(
	val InterleaverInfoMap: Map[String, (ListBuffer[Int], String)] = Map(
		// List(NumOperands, NumRes, Latency, Operands-Commutative), Basic OpName
		"INTLV4" -> (ListBuffer(4, 1, 1, 0), "INTLV4BASE"),
		"INTLV3" -> (ListBuffer(3, 1, 1, 0), "INTLV3BASE"),
		"INTLV2" -> (ListBuffer(2, 1, 1, 0), "INTLV2BASE"),
		"DEINTLV4" -> (ListBuffer(1, 4, 4, 0), "DEINTLV4BASE"),
		"DEINTLV3" -> (ListBuffer(1, 3, 3, 0), "DEINTLV3BASE"),
		"DEINTLV2" -> (ListBuffer(1, 2, 2, 0), "DEINTLV2BASE"),
	)
	
	//// Float Point
	val FP32OpInfoMap: Map[String, ListBuffer[Int]] = Map(
		// @LJH define:
		// ListBuffer(NumOperands, NumRes, Latency, Operands-Commutative)
		"FMUL32"-> ListBuffer(2, 1, 3, 1),   
		// "FADD32"-> ListBuffer(2, 1, 3, 1, 0),
		// "FSUB32"-> ListBuffer(2, 1, 3, 0, 0),
		"FADD32"-> ListBuffer(2, 1, 1, 1),
		"FSUB32"-> ListBuffer(2, 1, 1, 0),
		// "FDIV32"-> ListBuffer(2, 1, 13, 0),
		// "FDIV32"-> ListBuffer(2, 1, 6, 0),// jrzhang: no reuse fp32mul 
		"FDIV32"-> ListBuffer(2, 1, 7, 0), // jrzhang: reuse fp32mul 
		"FSQRT" -> ListBuffer(2, 1, 17, 0), // not support yet
		"FEQ32"  -> ListBuffer(2, 1, 1, 1),
		"FOLT32" -> ListBuffer(2, 1, 1, 0),
		"FOLE32" -> ListBuffer(2, 1, 1, 0),
		"FUNO32" -> ListBuffer(2, 1, 1, 0),

		"FMA32" -> ListBuffer(3, 1, 4, 0), //  a * b + c
	)

	//// Brain Float Point
	val BF16OpInfoMap: Map[String, ListBuffer[Int]] = Map(
		// @LJH define:
		// ListBuffer(NumOperands, NumRes, Latency, Operands-Commutative)
		"BFMUL16"-> ListBuffer(2, 1, 3, 1),   
		// "FADD32"-> ListBuffer(2, 1, 3, 1, 0),
		// "FSUB32"-> ListBuffer(2, 1, 3, 0, 0),
		"BFADD16"-> ListBuffer(2, 1, 1, 1),
		"BFSUB16"-> ListBuffer(2, 1, 1, 0),
		"BFDIV16"-> ListBuffer(2, 1, 4, 0),
		"BFSQRT" -> ListBuffer(2, 1, 17, 0), // not support yet
		"BFEQ16"  -> ListBuffer(2, 1, 1, 1),
		"BFOLT16" -> ListBuffer(2, 1, 1, 0),
		"BFOLE16" -> ListBuffer(2, 1, 1, 0),
		"BFUNO16" -> ListBuffer(2, 1, 1, 0),

		"BFMA16" -> ListBuffer(3, 1, 4, 0), //  a * b + c
	)

	// Accumulative Operation Information
	// Periodic initialization and accumulation
	// res = f(op)
	val AccOpInfoMap: Map[String, (ListBuffer[Int], String)] = Map(
		// OpName -> List(NumOperands, NumRes, Latency, Operands-Commutative), Basic OpName
		// latency including the register outside ALU
		"ACC" -> (ListBuffer(1, 1, 1, 0), "ADD"), // +=
		"ASUB" -> (ListBuffer(1, 1, 1, 0), "SUB"), // -=
		"AMUL" -> (ListBuffer(1, 1, 1, 0), "MUL"), // *=
		"ADIV" -> (ListBuffer(1, 1, 1, 0), "DIV"), // /=
		"AMOD" -> (ListBuffer(1, 1, 1, 0), "MOD"), // %=
		"AAND" -> (ListBuffer(1, 1, 1, 0), "AND"), // &=
		"AOR" -> (ListBuffer(1, 1, 1, 0), "OR"), // |=
		"AXOR" -> (ListBuffer(1, 1, 1, 0), "XOR"), // ^=
		"ASHL" -> (ListBuffer(1, 1, 1, 0), "SHL"), // <<=
		"ALSHR" -> (ListBuffer(1, 1, 1, 0), "LSHR"), // >>=
		"AASHR" -> (ListBuffer(1, 1, 1, 0), "ASHR"), // >>>=

		"FACC32"-> (ListBuffer(1, 1, 1, 0), "FADD32"),
		"FASUB32"-> (ListBuffer(1, 1, 1, 0), "FSUB32"),
		"BFACC16"-> (ListBuffer(1, 1, 1, 0), "BFADD16"),
		"BFASUB16"-> (ListBuffer(1, 1, 1, 0), "BFSUB16"),		
	)

	val MacOpInfoMap: Map[String, (ListBuffer[Int], String)] = Map(
		// OpName -> List(NumOperands, NumRes, Latency, Operands-Commutative), Basic OpName
		"MAC" -> (ListBuffer(2, 1, 2, 1), "MulAdd"),
		"FMAC32" -> (ListBuffer(2, 1, 4, 1), "FMA32"),
		"BFMAC32" -> (ListBuffer(2, 1, 4, 1), "FMA32"),
	)



	// Conditionally accumulative Operation Information
	// Periodic initialization and irregular conditional accumulation
	// res = f(op, en)
	val CondAccOpInfoMap: Map[String, (ListBuffer[Int], String)] = Map(
		// OpName -> List(NumOperands, NumRes, Latency, Operands-Commutative)
		// latency including the register outside ALU
		// the second operand is accumulation enable
		"CACC" -> (ListBuffer(2, 1, 1, 0), "ADD"), // +=
		"CASUB" -> (ListBuffer(2, 1, 1, 0), "SUB"), // -=
		"CAMUL" -> (ListBuffer(2, 1, 1, 0), "MUL"), // *=
		"CADIV" -> (ListBuffer(2, 1, 1, 0), "DIV"), // /=
		"CAMOD" -> (ListBuffer(2, 1, 1, 0), "MOD"), // %=
		"CAAND" -> (ListBuffer(2, 1, 1, 0), "AND"), // &=
		"CAOR" -> (ListBuffer(2, 1, 1, 0), "OR"), // |=
		"CAXOR" -> (ListBuffer(2, 1, 1, 0), "XOR"), // ^=
		"CASHL" -> (ListBuffer(2, 1, 1, 0), "SHL"), // <<=
		"CALSHR" -> (ListBuffer(2, 1, 1, 0), "LSHR"), // >>=
		"CAASHR" -> (ListBuffer(2, 1, 1, 0), "ASHR"), // >>>=
	)

	// Conditionally initial and accumulative Operation Information
	// irregular conditional initialization and accumulation
	// res = f(op, en, init)
	val CondInitAccOpInfoMap: Map[String, (ListBuffer[Int], String)] = Map(
		// OpName -> List(NumOperands, NumRes, Latency, Operands-Commutative)
		// latency including the register outside ALU
		// the second operand is accumulation enable
		// the third operand is initialize
		"CIACC" -> (ListBuffer(3, 1, 1, 0), "ADD"), // +=
		"CIASUB" -> (ListBuffer(3, 1, 1, 0), "SUB"), // -=
		"CIAMUL" -> (ListBuffer(3, 1, 1, 0), "MUL"), // *=
		"CIADIV" -> (ListBuffer(3, 1, 1, 0), "DIV"), // /=
		"CIAMOD" -> (ListBuffer(3, 1, 1, 0), "MOD"), // %=
		"CIAAND" -> (ListBuffer(3, 1, 1, 0), "AND"), // &=
		"CIAOR" -> (ListBuffer(3, 1, 1, 0), "OR"), // |=
		"CIAXOR" -> (ListBuffer(3, 1, 1, 0), "XOR"), // ^=
		"CIASHL" -> (ListBuffer(3, 1, 1, 0), "SHL"), // <<=
		"CIALSHR" -> (ListBuffer(3, 1, 1, 0), "LSHR"), // >>=
		"CIAASHR" -> (ListBuffer(3, 1, 1, 0), "ASHR"), // >>>=
	)

	// Load/Store Operation Information
	val LSOpInfoMap: Map[String, ListBuffer[Int]] = Map(
		// OpName -> List(NumOperands, NumRes, Latency, Operands-Commutative)
		// latency including the register outside ALU
		"INPUT" -> ListBuffer(0, 1, 2, 0),
		"OUTPUT" -> ListBuffer(1, 0, 1, 0),
		"LOAD" -> ListBuffer(1, 1, 2, 0),
		"STORE" -> ListBuffer(2, 0, 1, 0),
		"CINPUT" -> ListBuffer(1, 1, 2, 0),
		"COUTPUT" -> ListBuffer(2, 0, 1, 0),
		"CLOAD" -> ListBuffer(2, 1, 2, 0),
		"CSTORE" -> ListBuffer(3, 0, 1, 0)
	)
	val ISelInfoMap: Map[String, (ListBuffer[Int], String)] = Map(
		// "ISEL" -> (ListBuffer(1, 1, 1, 0), "PASS"), // isel
		"ISEL" -> (ListBuffer(1, 1, 1, 0), "PASS"), // isel
	)
	val IACCInfoMap: Map[String, (ListBuffer[Int], String)] = Map(
		"IACC" -> (ListBuffer(2, 1, 1, 0), "ADD"), // isel
	)

	// OPName -> List(NumOperands, NumRes, Latency, Operands-Commutative, Accumulative-operation)
	// latency including the register outside ALU
	val OpInfoMap: Map[String, ListBuffer[Int]] = {
		BasicOpInfoMap.map { case (name, info) => name -> (info :+ 0) } ++
		FP32OpInfoMap.map { case (name, info) => name -> (info :+ 0) } ++  /// jhlou add
		BF16OpInfoMap.map { case (name, info) => name -> (info :+ 0) } ++  /// jhlou add
		InterleaverInfoMap.map { case (name, (info, basic)) => name -> (info :+ 1) } ++ /// jhlou add
		AccOpInfoMap.map { case (name, (info, basic)) => name -> (info :+ 1) } ++
		MacOpInfoMap.map { case (name, (info, basic)) => name -> (info :+ 1) } ++ /// jhlou add
		CondAccOpInfoMap.map { case (name, (info, basic)) => name -> (info :+ 1) } ++
		CondInitAccOpInfoMap.map { case (name, (info, basic)) => name -> (info :+ 1) } ++
		// ISelInfoMap.map{case (name, (info, basic)) => name -> (info :+ -1)} ++ 
		ISelInfoMap.map{case (name, (info, basic)) => name -> (info :+ 1)} ++ ////@ jhlou: handle isel as a acc op
		// CombinedAccOpInfoMap.map{case (name, (info, basicOps)) => name -> (info :+ 1)} ++ 
		IACCInfoMap.map{case (name, (info, basic)) => name -> (info :+ -2)} ++
		LSOpInfoMap.map { case (name, info) => name -> (info :+ 0) }
	}

	//	val OpInfoMap: Map[String, ListBuffer[Int]] = Map(
	//		// OPC -> List(NumOperands, NumRes, Latency, Operands-Commutative, Accumulative-operation)
	//		// latency including the register outside ALU
	//		"PASS" -> ListBuffer(1, 1, 1, 0, 0),
	//		"ADD" -> ListBuffer(2, 1, 1, 1, 0),
	//		"SUB" -> ListBuffer(2, 1, 1, 0, 0),
	//		"MUL" -> ListBuffer(2, 1, 1, 1, 0),
	//		"UDIV" -> ListBuffer(2, 1, 1, 0, 0),
	//		"MOD" -> ListBuffer(2, 1, 1, 0, 0),
	//		"MIN" -> ListBuffer(2, 1, 1, 1, 0),
	//		"MAX" -> ListBuffer(2, 1, 1, 1, 0),
	//		"AND" -> ListBuffer(2, 1, 1, 1, 0),
	//		"OR"  -> ListBuffer(2, 1, 1, 1, 0),
	//		"XOR" -> ListBuffer(2, 1, 1, 1, 0),
	//		"SHL" -> ListBuffer(2, 1, 1, 0, 0),
	//		"LSHR" -> ListBuffer(2, 1, 1, 0, 0),
	//		"ASHR" -> ListBuffer(2, 1, 1, 0, 0),
	//		"CSHL" -> ListBuffer(2, 1, 1, 0, 0),
	//		"CSHR" -> ListBuffer(2, 1, 1, 0, 0),
	//		"EQ"  -> ListBuffer(2, 1, 1, 1, 0),
	//		"NE"  -> ListBuffer(2, 1, 1, 1, 0),
	//		"ULT" -> ListBuffer(2, 1, 1, 0, 0),
	//		"ULE" -> ListBuffer(2, 1, 1, 0, 0),
	//		"SLT" -> ListBuffer(2, 1, 1, 0, 0),
	//		"SLE" -> ListBuffer(2, 1, 1, 0, 0),
	//		"SEL" -> ListBuffer(3, 1, 1, 0, 0),
	//		"ACC"  -> ListBuffer(1, 1, 1, 0, 1),  // +=
	//		"ASUB" -> ListBuffer(1, 1, 1, 0, 1), // -=
	//		"AMUL" -> ListBuffer(1, 1, 1, 0, 1), // *=
	//		"ADIV" -> ListBuffer(1, 1, 1, 0, 1), // /=
	//		"AMOD" -> ListBuffer(1, 1, 1, 0, 1), // %=
	//		"AAND" -> ListBuffer(1, 1, 1, 0, 1), // &=
	//		"AOR"  -> ListBuffer(1, 1, 1, 0, 1),  // |=
	//		"AXOR" -> ListBuffer(1, 1, 1, 0, 1), // ^=
	//		"ASHL" -> ListBuffer(1, 1, 1, 0, 1), // <<=
	//		"ALSHR" -> ListBuffer(1, 1, 1, 0, 1),// >>=
	//		"AASHR" -> ListBuffer(1, 1, 1, 0, 1),// >>>=
	//		"INPUT"  -> ListBuffer(0, 1, 2, 0, 0),
	//		"OUTPUT" -> ListBuffer(1, 0, 1, 0, 0),
	//		"LOAD"   -> ListBuffer(1, 1, 2, 0, 0),
	//		"STORE"  -> ListBuffer(2, 0, 1, 0, 0)
	//	)

	def getOperandNum(op: String): Int = {
		OpInfoMap(op)(0)
	}

	def getResNum(op: String): Int = {
		OpInfoMap(op)(1)
	}

	def getLatency(op: String): Int = {
		OpInfoMap(op)(2)
	}

	def setLatency(op: String, lat: Int): Unit = {
		OpInfoMap(op)(2) = lat
	}

	def isCommutative(op: String): Int = {
		OpInfoMap(op)(3)
	}

	def isAccumulative(op: String): Int = {
		OpInfoMap(op)(4)
	}

	def isISelection(op: String): Int = {
		OpInfoMap(op)(4)
	}
	def getALUOp(op: String): String = {
		if (AccOpInfoMap.contains(op)) {
			AccOpInfoMap(op)._2
		} 
		else if (CondAccOpInfoMap.contains(op)) {
			CondAccOpInfoMap(op)._2
		} else if (CondInitAccOpInfoMap.contains(op)) {
			CondInitAccOpInfoMap(op)._2
		} else if (ISelInfoMap.contains(op)) {
			ISelInfoMap(op)._2
		} else if (IACCInfoMap.contains(op)) {
			IACCInfoMap(op)._2
		} else if (InterleaverInfoMap.contains(op)) {
			InterleaverInfoMap(op)._2
		} else if (MacOpInfoMap.contains(op)) {
			MacOpInfoMap(op)._2
		} else {
			op
		}
	}

	def getALUOperandNum(op: String): Int = {
		if (AccOpInfoMap.contains(op)) {
			OpInfoMap(AccOpInfoMap(op)._2)(0)
		} else if (CondAccOpInfoMap.contains(op)) {
			OpInfoMap(CondAccOpInfoMap(op)._2)(0)
		} else if (CondInitAccOpInfoMap.contains(op)) {
			OpInfoMap(CondInitAccOpInfoMap(op)._2)(0)
		} else if (IACCInfoMap.contains(op)) {
			OpInfoMap(IACCInfoMap(op)._2)(0)
		} else if (ISelInfoMap.contains(op)) {
			OpInfoMap(ISelInfoMap(op)._2)(0)
		}else {
			OpInfoMap(op)(0)
		}
	}

	def getALUResultNum(op: String): Int = {
		if (AccOpInfoMap.contains(op)) {
			OpInfoMap(AccOpInfoMap(op)._2)(1)
		} else if (CondAccOpInfoMap.contains(op)) {
			OpInfoMap(CondAccOpInfoMap(op)._2)(1)
		} else if (CondInitAccOpInfoMap.contains(op)) {
			OpInfoMap(CondInitAccOpInfoMap(op)._2)(1)
		} else if (IACCInfoMap.contains(op)) {
			OpInfoMap(IACCInfoMap(op)._2)(1)
		} else if (ISelInfoMap.contains(op)) {
			OpInfoMap(ISelInfoMap(op)._2)(1)
		}else {
			OpInfoMap(op)(1)
		}
	}


	private var width = 32
	private var high = width - 1

	def apply(opWidth: Int) = {
		width = opWidth
		high = width - 1
		this
	}

	private var OPSet: ListBuffer[String] = ListBuffer(
		"PASS", // passthrough from in to out
		"ADD", // add
		"SUB", // substrate
		"MUL", // multiply
		//		"UDIV",     // divide
		//		"MOD",     // modulo
		//		"MIN",
		//		"NOT",
		//		"AND",
		//		"OR",
		//		"XOR",
		//		"SHL",     // shift left
		//		"LSHR",    // logic shift right
		//		"ASHR",    // arithmetic shift right
		//		"CSHL",    // cyclic shift left
		//		"CSHR",    // cyclic shift right
		"EQ", // equal to
		"NE", // not equal to
		"ULT", // less than
		"ULE", // less than or equal to
		"SEL",
		"ACC", // +=

		//		"ASUB",  // -=
		//		"AMUL",  // *=
		//		"ADIV",  // /=
		//		"AMOD",  // %=
		//		"AAND",  // &=
		//		"AOR",   // |=
		//		"AXOR",  // ^=
		//		"ASHL",  // <<=
		//		"ALSHR", // >>=
		//		"AASHR", // >>>=
		"INPUT",
		"OUTPUT",
		"LOAD",
		"STORE"
	)

	val OPCMap = mutable.Map[String, Int]("PASS" -> 0)
	var BasicOPCWidth: Int = 0
	var ALUOPCWidth: Int = 0
	var LSOPCWidth: Int = 0

	def apply(ops: ListBuffer[String]): Unit = {
		OPSet = ops
		var hasAcc = false
		var hasCondAcc = false
		var hasCondRstAcc = false
		var hasInitSelection = false
		var hasInitACC = false
		var hasInterleaver = false
		var hasMac = false
		val ALUOpc = mutable.Map[String, Int]("PASS" -> 0)
		var LSOpNum = 0
		// first traversal
		ops.foreach { op =>
			val basicOp = {
				if (BasicOpInfoMap.contains(op)) {
					op
				} 
				else if (FP32OpInfoMap.contains(op) ||
						 BF16OpInfoMap.contains(op)) {
					op
				} 
				else if(InterleaverInfoMap.contains(op)){
					hasInterleaver = true
					InterleaverInfoMap(op)._2
				} else if (AccOpInfoMap.contains(op)) {
					hasAcc = true
					AccOpInfoMap(op)._2
				} else if (MacOpInfoMap.contains(op)) {
					hasMac = true
					hasAcc = true
					MacOpInfoMap(op)._2
				} else if (CondAccOpInfoMap.contains(op)) {
					hasCondAcc = true
					CondAccOpInfoMap(op)._2
				} else if (CondInitAccOpInfoMap.contains(op)) {
					hasCondRstAcc = true
					CondInitAccOpInfoMap(op)._2
				} else if (IACCInfoMap.contains(op)) {
					hasInitACC = true;
					IACCInfoMap(op)._2
				} else if (ISelInfoMap.contains(op)) {
					hasInitSelection = true;
					ISelInfoMap(op)._2
				} 
				else {
					if (LSOpInfoMap.contains(op)) {
						OPCMap += (op -> LSOpNum)
						LSOpNum += 1
					}
					"NULL"
				}
			}
			if (basicOp != "NULL" && !ALUOpc.contains(basicOp)) {
				val newopc = ALUOpc.size
				ALUOpc += (basicOp -> newopc)
				OPCMap += (basicOp -> newopc)
			}
		}
		LSOPCWidth = {
			if (LSOpNum > 0) log2Ceil(LSOpNum) else 0
		}
		BasicOPCWidth = log2Ceil(ALUOpc.size)
		ALUOPCWidth = BasicOPCWidth + {
			if(hasInitSelection || hasInitACC || hasInterleaver || hasMac){
				3
			} else if (hasCondRstAcc || hasCondAcc) {
				2
			} else if (hasAcc) {
				1
			} else {
				0
			}
		}
		// second traversal
		ops.foreach { op =>
			if (AccOpInfoMap.contains(op)) {
				val basicOp = AccOpInfoMap(op)._2
				val newopc = ALUOpc(basicOp) + (1 << BasicOPCWidth)
				OPCMap += (op -> newopc)
			} else if (CondAccOpInfoMap.contains(op)) {
				val basicOp = CondAccOpInfoMap(op)._2
				val newopc = ALUOpc(basicOp) + (2 << BasicOPCWidth)
				OPCMap += (op -> newopc)
			} else if (CondInitAccOpInfoMap.contains(op)) {
				val basicOp = CondInitAccOpInfoMap(op)._2
				val newopc = ALUOpc(basicOp) + (3 << BasicOPCWidth)
				OPCMap += (op -> newopc)
			} else if (IACCInfoMap.contains(op)) {
				val basicOp = IACCInfoMap(op)._2
				val newopc = ALUOpc(basicOp) + (4 << BasicOPCWidth)
				OPCMap += (op -> newopc)
			} else if (ISelInfoMap.contains(op)) {
				val basicOp = ISelInfoMap(op)._2
				val newopc = ALUOpc(basicOp) + (5 << BasicOPCWidth)
				OPCMap += (op -> newopc)
			} else if(MacOpInfoMap.contains(op)){
				val basicOp = MacOpInfoMap(op)._2
				val newopc = ALUOpc(basicOp) + (6 << BasicOPCWidth)
				OPCMap += (op -> newopc)				
			} else if(InterleaverInfoMap.contains(op)){
				val basicOp = InterleaverInfoMap(op)._2
				val newopc = ALUOpc(basicOp) + (7 << BasicOPCWidth)
				OPCMap += (op -> newopc)				
			} 
		}
		// println("ALUOpc:", ALUOpc)
		// println("OPCMap:", OPCMap)
	}

	apply(OPSet)


	def isnotAccOp(op: UInt): Bool = {
		op(ALUOPCWidth - 1, BasicOPCWidth) === 0.U || op(ALUOPCWidth - 1, BasicOPCWidth) === 5.U
	}

	def isAccOp(op: UInt): Bool = {
		op(ALUOPCWidth - 1, BasicOPCWidth) === 1.U
	}

	def isCondAccOp(op: UInt): Bool = {
		op(ALUOPCWidth - 1, BasicOPCWidth) === 2.U
	}

	def isCondRstAccOp(op: UInt): Bool = {
		op(ALUOPCWidth - 1, BasicOPCWidth) === 3.U
	}


	def isMacOp(op: UInt): Bool = {
		op(ALUOPCWidth - 1, BasicOPCWidth) === 6.U
	}


	def isInterleaverOp(op: UInt): Bool = {
		op(ALUOPCWidth - 1, BasicOPCWidth) === 7.U
	}

	def getAccMode(op: UInt): UInt = {
		op(ALUOPCWidth - 1, BasicOPCWidth)
	}

	// @jhlou
	def InterleaveOps(ops: Seq[UInt], InterleaveNum: Int, width: Int, launch: Bool): UInt = {
		require(width <= ops.head.getWidth, "Width must be less than or equal to the width of the UInt.")
		// require(ops.size >= InterleaveNum)
		if(ops.size < InterleaveNum){
			return ops.head(width - 1, 0)
		}
  		val InterleaveCnt = RegInit(0.U(log2Ceil(InterleaveNum).W))
 	 	val InterleaveCntEnd = InterleaveCnt === (InterleaveNum - 1).U
		
		when(launch) {
  			InterleaveCnt := Mux(InterleaveCntEnd, 0.U, InterleaveCnt + 1.U)
		}
		.otherwise{
			InterleaveCnt := 0.U
		}

  		val input = Wire(Vec(InterleaveNum, UInt(width.W)))

		input.zipWithIndex.foreach { case (in, i) =>
			if (i == 0) 
				in := ops.head(width - 1, 0)
			else 
				in := ops(i)(width - 1, 0)
		}

	    input(InterleaveCnt)
	}

	// @jhlou
	def DeinterleaveOps(op: UInt, DeinterleaveNum: Int, width: Int, launch: Bool): Vec[UInt] = {
		require(width <= op.getWidth, "Width must be less than or equal to the width of the UInt.")

		val DeinterleaveCnt = RegInit(0.U(log2Ceil(DeinterleaveNum).W))
		val DeinterleaveCntEnd = DeinterleaveCnt === (DeinterleaveNum - 1).U

		when(launch) {
			DeinterleaveCnt := Mux(DeinterleaveCntEnd, 0.U, DeinterleaveCnt + 1.U)
		}.otherwise {
			DeinterleaveCnt := 0.U
		}

		val output = Wire(Vec(DeinterleaveNum, UInt(width.W)))
		output.foreach(_ := 0.U)

		output(DeinterleaveCnt) := op(width - 1, 0)

		output
	}


	def OpFuncs(ops: Seq[UInt], en: Bool, launch: Bool): (Map[String, Seq[UInt]], UInt, Map[String, UInt]) = {
		//		def OpFuncs(ops: Seq[UInt], opc: UInt, opset: ListBuffer[OPC]) : Map[String, Seq[UInt]] = {
		//		val op_names = opset.map(_.toString)
		val op0 = ops.head(high, 0)
		val op1 = ops(1)(high, 0)
		val op2 = {
			if (ops.size > 2) ops(2)(0)
			else 0.U(1.W)
		}
		val udiv = Module(new Div(width, false, DIV_LATENCY - 1))
		val sdiv = Module(new Div(width, true, DIV_LATENCY - 1))
		udiv.io.op0 := DontCare
		udiv.io.op1 := DontCare
		sdiv.io.op0 := DontCare
		sdiv.io.op1 := DontCare
		//		val op1_inv = (~op1).asUInt
		//		val op1_new = Wire(UInt(width.W))
		//		val op2_new = Wire(UInt(1.W))
		//		op1_new := op1
		//		op2_new := 0.U(1.W)
		//		if(op_names.contains("SUB")){
		//			when(opc === OPC.withName("SUB").id.U){
		//				op1_new := op1_inv
		//				op2_new := 1.U(1.W)
		//			}
		//		}
		//		if(op_names.contains("ASUB")){
		//			when(opc === OPC.withName("ASUB").id.U){
		//				op1_new := op1_inv
		//				op2_new := 1.U(1.W)
		//			}
		//		}
		//		val adder = Wire(UInt((width+1).W))
		//		adder := Cat(0.U(1.W), op0) + op1_new + op2_new
		// shift number
		val shn = op1(log2Ceil(width) - 1, 0)
		//		val shn0 = op0(log2Ceil(width)-1, 0)
		
		//// Shared Units
		// val SharedUnitsExist = false.B
		val ShareUnitsCfgBitsWidth = 3
		lazy val shareUnitsCfgBits = Wire(UInt(ShareUnitsCfgBitsWidth.W))
		//// fp32 share units:  add cmp div
		lazy val fAdd32_io = Module(new FPAdd32).io
		lazy val fCmp32_io = Module(new FPCmp32).io
		lazy val fMul32_io = Module(new FPMult32).io
		lazy val fDiv32_io = Module(new FPDiv32).io

		//// bf16 share units:  add cmp div
		lazy val bfAdd16_io = Module(new BFAdd16).io
		lazy val bfCmp16_io = Module(new BFCmp16).io
		lazy val bfMul16_io = Module(new BFMult16).io
		lazy val bfDiv16_io = Module(new BFDiv16).io

		lazy val opToShareUnitCfg = Map(
			"FADD32"   ->  { /*fAdd32_io.subOp = */ 0.U},
			"FSUB32"   ->  { /*fAdd32_io.subOp = */ 1.U},

			//// FEQ32 FOLT32 FOLE32 FUNO32 share the same ValExec_CompareRecFN
			"FEQ32"    ->  { /*fCmp32_io.cmpType = */  0.U},
	 		"FOLE32"   ->  { /*fCmp32_io.cmpType = */  1.U},
			"FOLT32"   ->  { /*fCmp32_io.cmpType = */  2.U},
	 		// "FUNO32"   ->  { /*fCmp32_io.cmpType = */  3.U}, //// not supported

			/// bf's share unit cfg is the same with fp32
			"BFADD16"   ->  { /*bfAdd16_io.subOp = */ 0.U},
			"BFSUB16"   ->  { /*bfAdd16_io.subOp = */ 1.U},

			"BFEQ16"    ->  { /*bfCmp16_io.cmpType = */  0.U},
	 		"BFOLE16"   ->  { /*bfCmp16_io.cmpType = */  1.U},
			"BFOLT16"   ->  { /*bfCmp16_io.cmpType = */  2.U},			
		)

		lazy val opToRes = Map(
			"PASS" -> Seq(op0),
			"ADD" -> Seq(op0 + op1),
			"SUB" -> Seq(op0 - op1),
			"MUL" -> Seq(op0 * op1),
			"UDIV" -> {
				udiv.io.op0 := op0
				udiv.io.op1 := op1
				Seq(udiv.io.quo)
			},
			"UREM" -> {
				udiv.io.op0 := op0
				udiv.io.op1 := op1
				Seq(udiv.io.rem)
			},
			"SDIV" -> {
				sdiv.io.op0 := op0
				sdiv.io.op1 := op1
				Seq(sdiv.io.quo)
			},
			"SREM" -> {
				sdiv.io.op0 := op0
				sdiv.io.op1 := op1
				Seq(sdiv.io.rem)
			},
			"MOD" -> Seq(op0 % op1),
			"MIN" -> Seq(Mux(op0 < op1, op0, op1)),
			"MAX" -> Seq(Mux(op0 > op1, op0, op1)),
			"AND" -> Seq(op0 & op1),
			"OR" -> Seq(op0 | op1),
			"NOT" -> Seq(~op0),
			"XOR" -> Seq(op0 ^ op1),
			"SHL" -> Seq((op0 << shn).asUInt),
			"LSHR" -> Seq((op0 >> shn).asUInt),
			"ASHR" -> Seq((op0.asSInt >> shn).asUInt),
			"CSHL" -> {
				val res1 = (op0 << shn).asUInt
				val res2 = (op0 >> (width.U - shn)).asUInt
				Seq(res1 | res2)
			},
			"CSHR" -> {
				val res1 = (op0 >> shn).asUInt
				val res2 = (op0 << (width.U - shn)).asUInt
				Seq(res1 | res2)
			},
			"EQ" -> {
				val res = op0 === op1
				Seq(res)
			},
			"NE" -> {
				val res = op0 =/= op1
				Seq(res)
			},
			"ULT" -> { // unsigned less than
				val res = op0 < op1
				Seq(res)
			},
			"ULE" -> { // unsigned less than or equal
				val res = op0 <= op1
				Seq(res)
			},
			"SLT" -> { // signed less than
				val res = op0.asSInt < op1.asSInt
				Seq(res)
			},
			"SLE" -> { // signed less than or equal
				val res = op0.asSInt <= op1.asSInt
				Seq(res)
			},
			"SEL" -> {
				Seq(Mux(op2.asBool, op1, op0))
			},

			//			"ACC"   -> Seq(op1 + op0), // the SECOND operand is the register value. the following is similar
			//			"ASUB"  -> Seq(op1 - op0),
			//			"AMUL"  -> Seq(op1 * op0),
			//			"ADIV"  -> Seq(op1 / op0),
			//			"AMOD"  -> Seq(op1 % op0),
			//			"AAND"  -> Seq(op1 & op0),
			//			"AOR"   -> Seq(op1 | op0),
			//			"AXOR"  -> Seq(op1 ^ op0),
			//			"ASHL"  -> Seq((op1 << shn0).asUInt),
			//			"ALSHR" -> Seq((op1 >> shn0).asUInt),
			//			"AASHR" -> Seq((op1.asSInt >> shn0).asUInt)


			//// Float Point 
			//// FP32
			"FMUL32"   ->  {
				if (ops.head.getWidth < 32 || ops(1).getWidth < 32) {
    				Seq()
  				} else {
      				val op0 = ops.head.apply(31,0)
      				val op1 = ops(1).apply(31,0)
      				// val fMul32_io = Module(new FPMult32).io
      				fMul32_io.a := op0
      				fMul32_io.b := op1
					fMul32_io.rm := 0.U
      				Seq(fMul32_io.result)
  				}
    		},
    		/*
    		"FDiv32"    -> ((ops : Seq[UInt]) => { // TODO: Need Implementation
      		val op0 = ops.head.apply(31,0)
      		val op1 = ops(1).apply(31,0)
      		op0 / op1
    		}),
     		*/

	 		"FDIV32"    ->  {
				if (ops.head.getWidth < 32 || ops(1).getWidth < 32) {
    				Seq()
  				} else {
					lazy val op0 = ops.head.apply(31,0)
					lazy val op1 = ops(1).apply(31,0)
					
					fDiv32_io.in1 := op0
					fDiv32_io.in2 := op1
					// fDiv32_io.rm := 0.U
					// fDiv32_io.en := en
					// fDiv32_io.II := 13.U
					// fDiv32_io.mode := 0.U /// 0: div, 1: sqrt
					Seq(fDiv32_io.out)
				}
    		},


    		"FADD32"    ->  {
				if (ops.head.getWidth < 32 || ops(1).getWidth < 32) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(31,0)
					val op1 = ops(1).apply(31,0)
					fAdd32_io.a := op0
					fAdd32_io.b := op1
					fAdd32_io.sub := shareUnitsCfgBits
					fAdd32_io.rm := 0.U
					Seq(fAdd32_io.result)
				}
    		},

			"FSUB32"    ->  {
				if (ops.head.getWidth < 32 || ops(1).getWidth < 32) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(31,0)
					val op1 = ops(1).apply(31,0)
					fAdd32_io.a := op0
					fAdd32_io.b := op1
					fAdd32_io.sub := shareUnitsCfgBits
					Seq(fAdd32_io.result)
				}
    		},

			// "FACC32"    ->  {
      		// 	val op0 = ops.head.apply(31,0)
      		// 	val op1 = ops(1).apply(31,0)
      		// 	fAdd32_io.a := op0
      		// 	fAdd32_io.b := op1
			// 	fAdd32_io.subOp := false.B
      		// 	Seq(fAdd32_io.res)
    		// },

			// "FASUB32"    ->  {
      		// 	val op0 = ops.head.apply(31,0)
      		// 	val op1 = ops(1).apply(31,0)
      		// 	fAdd32_io.a := op0
      		// 	fAdd32_io.b := op1
			// 	fAdd32_io.subOp := true.B
      		// 	Seq(fAdd32_io.res)
    		// },

	 		// "FEQ32"    ->  {
      		// 	val op0 = ops.head.apply(31,0)
      		// 	val op1 = ops(1).apply(31,0)
      		// 	val fEq32_io = Module(new FPCmpEQ32).io
      		// 	fEq32_io.a := op0
      		// 	fEq32_io.b := op1
      		// 	Seq(fEq32_io.out, fEq32_io.out)
    		// },
	 		// "FOLT32"    ->  {
      		// 	val op0 = ops.head.apply(31,0)
      		// 	val op1 = ops(1).apply(31,0)
      		// 	val fLgt32_io = Module(new FPCmpLT32).io
      		// 	fLgt32_io.a := op0
      		// 	fLgt32_io.b := op1
      		// 	Seq(fLgt32_io.out, fLgt32_io.out)
    		// },		
	 		// "FOLE32"    ->  {
      		// 	val op0 = ops.head.apply(31,0)
      		// 	val op1 = ops(1).apply(31,0)
      		// 	val fLge32_io = Module(new FPCmpLE32).io
      		// 	fLge32_io.a := op0
      		// 	fLge32_io.b := op1
      		// 	Seq(fLge32_io.out, fLge32_io.out)
    		// },				

			//// FEQ32 FOLT32 FOLE32 FUNO32 share the same ValExec_CompareRecFN
			"FEQ32"    ->  {
				if (ops.head.getWidth < 32 || ops(1).getWidth < 32) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(31,0)
					val op1 = ops(1).apply(31,0)
					fCmp32_io.a := op0
					fCmp32_io.b := op1
					fCmp32_io.cmpType := shareUnitsCfgBits
					Seq(fCmp32_io.result)
				}
    		},
	 		"FOLT32"    ->  {
				if (ops.head.getWidth < 32 || ops(1).getWidth < 32) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(31,0)
					val op1 = ops(1).apply(31,0)
					fCmp32_io.a := op0
					fCmp32_io.b := op1
					fCmp32_io.cmpType := shareUnitsCfgBits
					Seq(fCmp32_io.result)
				}
    		},		
	 		"FOLE32"    ->  {
				if (ops.head.getWidth < 32 || ops(1).getWidth < 32) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(31,0)
					val op1 = ops(1).apply(31,0)
					fCmp32_io.a := op0
					fCmp32_io.b := op1
					fCmp32_io.cmpType := shareUnitsCfgBits
					Seq(fCmp32_io.result)
				}
    		},					
	 		"FUNO32"    ->  {
				if (ops.head.getWidth < 32 || ops(1).getWidth < 32) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(31,0)
					val op1 = ops(1).apply(31,0)
					fCmp32_io.a := op0
					fCmp32_io.b := op1
					fCmp32_io.cmpType := shareUnitsCfgBits
					Seq(fCmp32_io.result)
				}
    		},		

			//// BF16
			"BFMUL16"   ->  {
				if (ops.head.getWidth < 16 || ops(1).getWidth < 16) {
    				Seq()
  				} else {
      				val op0 = ops.head.apply(15,0)
      				val op1 = ops(1).apply(15,0)
      				bfMul16_io.a := op0
      				bfMul16_io.b := op1
					bfMul16_io.rm := 0.U
      				Seq(bfMul16_io.result)
				}
    		},

	 		"BFDIV16"    ->  {
				if (ops.head.getWidth < 16 || ops(1).getWidth < 16) {
    				Seq()
  				} else {
					lazy val op0 = ops.head.apply(15,0)
					lazy val op1 = ops(1).apply(15,0)
					
					bfDiv16_io.in1 := op0
					bfDiv16_io.in2 := op1
					// bfDiv16_io.rm := 0.U
					// bfDiv16_io.en := en
					// bfDiv16_io.II := 8.U
					// bfDiv16_io.mode := 0.U /// 0: div, 1: sqrt
					Seq(bfDiv16_io.out)
				}
    		},


    		"BFADD16"    ->  {
				if (ops.head.getWidth < 16 || ops(1).getWidth < 16) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(15,0)
					val op1 = ops(1).apply(15,0)
					bfAdd16_io.a := op0
					bfAdd16_io.b := op1
					bfAdd16_io.sub := shareUnitsCfgBits
					bfAdd16_io.rm := 0.U
					Seq(bfAdd16_io.result)
				}
    		},

			"BFSUB16"    ->  {
				if (ops.head.getWidth < 16 || ops(1).getWidth < 16) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(15,0)
					val op1 = ops(1).apply(15,0)
					bfAdd16_io.a := op0
					bfAdd16_io.b := op1
					bfAdd16_io.sub := shareUnitsCfgBits
					Seq(bfAdd16_io.result)
				}
    		},

			//// BFEQ16 BFOLT16 BFOLE16 BFUNO16 share the same ValExec_CompareRecFN
			"BFEQ16"    ->  {
				if (ops.head.getWidth < 16 || ops(1).getWidth < 16) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(15,0)
					val op1 = ops(1).apply(15,0)
					bfCmp16_io.a := op0
					bfCmp16_io.b := op1
					bfCmp16_io.cmpType := shareUnitsCfgBits
					Seq(bfCmp16_io.result)
				}
    		},
	 		"BFOLT16"    ->  {
				if (ops.head.getWidth < 16 || ops(1).getWidth < 16) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(15,0)
					val op1 = ops(1).apply(15,0)
					bfCmp16_io.a := op0
					bfCmp16_io.b := op1
					bfCmp16_io.cmpType := shareUnitsCfgBits
					Seq(bfCmp16_io.result)
				}
    		},		
	 		"BFOLE16"    ->  {
				if (ops.head.getWidth < 16 || ops(1).getWidth < 16) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(15,0)
					val op1 = ops(1).apply(15,0)
					bfCmp16_io.a := op0
					bfCmp16_io.b := op1
					bfCmp16_io.cmpType := shareUnitsCfgBits
					Seq(bfCmp16_io.result)
				}
    		},					
	 		"BFUNO16"    ->  {
				if (ops.head.getWidth < 16 || ops(1).getWidth < 16) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(15,0)
					val op1 = ops(1).apply(15,0)
					bfCmp16_io.a := op0
					bfCmp16_io.b := op1
					bfCmp16_io.cmpType := shareUnitsCfgBits
					Seq(bfCmp16_io.result)
				}
    		},		


			// INTLV interleave
			// = Merge op
			"INTLV4BASE"    ->  {
				val output = InterleaveOps(ops, 4, width, launch)
				Seq(output)
    		},		
			"INTLV3BASE"    ->  {
				val output = InterleaveOps(ops, 3, width, launch)
				Seq(output)
    		},	
			"INTLV2BASE"    ->  {
				val output = InterleaveOps(ops, 2, width, launch)
				Seq(output)
    		},	

			// = Merge op
			"DEINTLV4BASE"    ->  {
				val output = DeinterleaveOps(ops.head, 4, width, launch)
				Seq(output(0), output(1), output(2), output(3))
    		},		
			"DEINTLV3BASE"    ->  {
				val output = DeinterleaveOps(ops.head, 3, width, launch)
				Seq(output(0), output(1), output(2))
    		},	
			"DEINTLV2BASE"    ->  {
				val output = DeinterleaveOps(ops.head, 2, width, launch)
				Seq(output(0), output(1))
    		},	

			//// MAC @jhlou
			"MulAdd" -> {
				val addLhs = RegNext(op0 * op1)
				val addRhs = RegNext(op2)
				Seq(addLhs + addRhs)
			},
			"FMA32" -> {
				if (ops.head.getWidth < 32 || ops(1).getWidth < 32 || ops.size < 3) {
    				Seq()
  				} else {
      				val op0 = ops.head.apply(31,0)
      				val op1 = ops(1).apply(31,0)
					val op2 = ops(2).apply(31,0)
      				// val fMul32_io = Module(new FPMult32).io
      				fMul32_io.a := op0
      				fMul32_io.b := op1
					fMul32_io.rm := 0.U
					val addLhs = RegNext(fMul32_io.result)
      				// Seq(fMul32_io.result)
					val addRhs = RegNext(op2)
      				fAdd32_io.a := addLhs
      				fAdd32_io.b := addRhs
					fAdd32_io.sub := shareUnitsCfgBits
					fAdd32_io.rm := 0.U
      				Seq(fAdd32_io.result)
				}
			},
			"BFMA16" -> {
				if (ops.head.getWidth < 16 || ops(1).getWidth < 16 || ops.size < 3) {
    				Seq()
  				} else {
					val op0 = ops.head.apply(15,0)
					val op1 = ops(1).apply(15,0)
					val op2 = ops(2).apply(15,0)
					bfMul16_io.a := op0
					bfMul16_io.b := op1
					bfMul16_io.rm := 0.U
					val addLhs = RegNext(bfMul16_io.result)
					val addRhs = RegNext(op2)
					bfAdd16_io.a := addLhs
					bfAdd16_io.b := addRhs
					bfAdd16_io.sub := shareUnitsCfgBits
					bfAdd16_io.rm := 0.U
					Seq(bfAdd16_io.result)
				}
			},
		)
		(opToRes, shareUnitsCfgBits, opToShareUnitCfg)
	}


	def OpFuncs2(opset: ListBuffer[String], ops: Seq[UInt], en: Bool, launch: Bool): (Map[String, Seq[UInt]], UInt, Map[String, UInt]) = {
		//		def OpFuncs(ops: Seq[UInt], opc: UInt, opset: ListBuffer[OPC]) : Map[String, Seq[UInt]] = {
		//		val op_names = opset.map(_.toString)
		val op0 = ops.head(high, 0)
		val op1 = ops(1)(high, 0)
		val op2 = {
			if (ops.size > 2) ops(2)
			else 0.U(1.W)
		}

		def have(op: String): Boolean = opset.contains(op)

		///// Some optional instance implementation
		val udivOpt =
			if (have("UDIV") || have("UREM")) Some(Module(new Div(width, false, DIV_LATENCY-1))) else None
		val sdivOpt =
			if (have("SDIV") || have("SREM")) Some(Module(new Div(width, true,  DIV_LATENCY-1))) else None

		val fAdd32Opt =
			if (have("FADD32") || have("FSUB32") || have("FMA32")) Some(Module(new FPAdd32).io) else None
		val fMul32Opt =
			if (have("FMUL32") || have("FMA32") || have("FDIV32")) Some(Module(new FPMult32).io) else None
		val fDivPrepOpt =
			if (have("FDIV32")) Some(Module(new FPDiv32ToMul).io) else None
		val fCmp32Opt =
			if (have("FEQ32") || have("FOLT32") || have("FOLE32") || have("FUNO32"))
			Some(Module(new FPCmp32).io) else None

		val bfAdd16Opt =
			if (have("BFADD16") || have("BFSUB16") || have("BFMA16")) Some(Module(new BFAdd16).io) else None
		val bfMul16Opt =
			if (have("BFMUL16") || have("BFMA16")) Some(Module(new BFMult16).io) else None
		val bfDiv16Opt =
			if (have("BFDIV16")) Some(Module(new BFDiv16).io) else None
		val bfCmp16Opt =
			if (have("BFEQ16") || have("BFOLT16") || have("BFOLE16") || have("BFUNO16"))
			Some(Module(new BFCmp16).io) else None
		//// fp32 share units:  add cmp div
		// lazy val fAdd32_io = Module(new FPAdd32).io
		// lazy val fCmp32_io = Module(new FPCmp32).io
		// lazy val fMul32_io = Module(new FPMult32).io
		// lazy val fDiv32_io = Module(new FPDiv32).io

		// //// bf16 share units:  add cmp div
		// lazy val bfAdd16_io = Module(new BFAdd16).io
		// lazy val bfCmp16_io = Module(new BFCmp16).io
		// lazy val bfMul16_io = Module(new BFMult16).io
		// lazy val bfDiv16_io = Module(new BFDiv16).io

		val shn = op1(log2Ceil(width) - 1, 0)
		
		//// Shared Units
		// val SharedUnitsExist = false.B
		val ShareUnitsCfgBitsWidth = 3
		lazy val shareUnitsCfgBits = Wire(UInt(ShareUnitsCfgBitsWidth.W))
		shareUnitsCfgBits := 0.U 

		lazy val opToShareUnitCfg: Map[String, UInt] = Map(
			"FADD32"   ->  { /*fAdd32_io.subOp = */ 0.U},
			"FSUB32"   ->  { /*fAdd32_io.subOp = */ 1.U},
			"FMA"      ->  { /*fAdd32_io.subOp = */ 4.U},

			// Reuse the shared fp32 multiplier (FPMult32) across FMUL32/FDIV32.
			// 0.U: normal multiply (a*b), 6.U: division path (a * (1/b))
			"FMUL32"   ->  { 0.U },
			"FDIV32"   ->  { 6.U },

			//// FEQ32 FOLT32 FOLE32 FUNO32 share the same ValExec_CompareRecFN
			"FEQ32"    ->  { /*fCmp32_io.cmpType = */  0.U},
	 		"FOLE32"   ->  { /*fCmp32_io.cmpType = */  1.U},
			"FOLT32"   ->  { /*fCmp32_io.cmpType = */  2.U},
	 		// "FUNO32"   ->  { /*fCmp32_io.cmpType = */  3.U}, //// not supported

			/// bf's share unit cfg is the same with fp32
			"BFADD16"   ->  { /*bfAdd16_io.subOp = */ 0.U},
			"BFSUB16"   ->  { /*bfAdd16_io.subOp = */ 1.U},
			"BFMA16"   	->  { /*bfAdd16_io.subOp = */ 4.U},

			"BFEQ16"    ->  { /*bfCmp16_io.cmpType = */  0.U},
	 		"BFOLE16"   ->  { /*bfCmp16_io.cmpType = */  1.U},
			"BFOLT16"   ->  { /*bfCmp16_io.cmpType = */  2.U},			
		).filter{ case (k,_) => have(k) }

		// ------------------connection ------------------//
		// UDIV/UREM
		udivOpt.foreach { d =>
			d.io.op0 := op0
			d.io.op1 := op1
		}
		val udivQuo = udivOpt.map(_.io.quo).getOrElse(0.U(width.W))
		val udivRem = udivOpt.map(_.io.rem).getOrElse(0.U(width.W))		

		// SDIV/SREM
		sdivOpt.foreach { d =>
			d.io.op0 := op0
			d.io.op1 := op1
		}
		val sdivQuo = sdivOpt.map(_.io.quo).getOrElse(0.U(width.W))
		val sdivRem = sdivOpt.map(_.io.rem).getOrElse(0.U(width.W))

		// FP32
		val f32a = if(op0.getWidth < 32) op0 else op0(31,0)
		val f32b = if(op1.getWidth < 32) op1 else op1(31,0)

		// FDIV32 operand preparation (reciprocal + exponent/sign fixup) for shared multiplier
		fDivPrepOpt.foreach { p =>
			p.in1 := f32a
			p.in2 := f32b
		}
		val divMulA = fDivPrepOpt.map(_.mulA).getOrElse(0.U(32.W))
		val divMulB = fDivPrepOpt.map(_.mulB).getOrElse(0.U(32.W))

		val mulA = Wire(UInt(32.W))
		val mulB = Wire(UInt(32.W))
		mulA := f32a
		mulB := f32b
		when(shareUnitsCfgBits === 6.U) {
			mulA := divMulA
			mulB := divMulB
		}

		fMul32Opt.foreach { m => m.a := mulA; m.b := mulB; m.rm := 0.U }
		val fmul32Res = fMul32Opt.map(_.result).getOrElse(0.U(32.W))

		fAdd32Opt.foreach { a =>
			a.a  := f32a
			a.b  := f32b
			a.sub:= shareUnitsCfgBits
			a.rm := 0.U
		}
		val fadd32Res = fAdd32Opt.map(_.result).getOrElse(0.U(32.W))

		// FDIV32 result comes from the shared multiplier output (via the div-prep MUX).
		val fdiv32Res = fmul32Res

		fCmp32Opt.foreach { c => c.a := f32a; c.b := f32b; c.cmpType := shareUnitsCfgBits}
		val fcmp32Res = fCmp32Opt.map(_.result).getOrElse(0.U(1.W))		

		// BF16
		val bf16a = op0(15,0)
		val bf16b = op1(15,0)
		val bf16c = op2(15,0)
		bfMul16Opt.foreach { m => m.a := bf16a; m.b := bf16b; m.rm := 0.U }
		val bfmul16Res = bfMul16Opt.map(_.result).getOrElse(0.U(16.W))

		// BFMA/BFADD/BFSUB share adds
		val bfadd16Res = bfAdd16Opt.map(_.result).getOrElse(0.U(16.W))
		if(have("BFMA16")){
			val lhs = Mux(shareUnitsCfgBits === 4.U, RegNext(bfmul16Res), bf16a)
			val rhs = Mux(shareUnitsCfgBits === 4.U, RegNext(op2), bf16b)
			bfAdd16Opt.map(_.a).getOrElse(0.U(16.W)) := lhs
			bfAdd16Opt.map(_.b).getOrElse(0.U(16.W)) := rhs
			bfAdd16Opt.map(_.rm).getOrElse(0.U(16.W)) := 0.U
			bfAdd16Opt.map(_.sub).getOrElse(0.U(16.W)) := shareUnitsCfgBits(0)
		}
		else if(!have("BFMA16")&have("BFADD16")){
			bfAdd16Opt.map(_.a).getOrElse(0.U(16.W)) := bf16a
			bfAdd16Opt.map(_.b).getOrElse(0.U(16.W)) := bf16b
			bfAdd16Opt.map(_.rm).getOrElse(0.U(16.W)) := 0.U
			bfAdd16Opt.map(_.sub).getOrElse(0.U(16.W)) := shareUnitsCfgBits(0)
		}

		bfDiv16Opt.foreach { d =>
			// d.a := bf16a; d.b := bf16b; d.rm := 0.U; d.en := en; d.II := 8.U; d.mode := 0.U
			d.in1 := bf16a; d.in2 := bf16b
		}
		val bfdiv16Res = bfDiv16Opt.map(_.out).getOrElse(0.U(16.W))

		bfCmp16Opt.foreach { c => c.a := bf16a; c.b := bf16b; c.cmpType := shareUnitsCfgBits }
		val bfcmp16Res = bfCmp16Opt.map(_.result).getOrElse(0.U(1.W))

		val resbuf = scala.collection.mutable.ArrayBuffer[(String, Seq[UInt])]()
		def add(op: String)(res: => Seq[UInt]): Unit =
			if (have(op)) resbuf += (op -> res)

		// INT
		add("PASS"){ Seq(op0) }
		add("ADD"){  Seq(op0 + op1) }
		add("SUB"){  Seq(op0 - op1) }
		add("MUL"){  Seq(op0 * op1) }
		add("UDIV"){ Seq(udivQuo) }
		add("UREM"){ Seq(udivRem) }
		add("SDIV"){ Seq(sdivQuo) }
		add("SREM"){ Seq(sdivRem) }
		add("MOD"){  Seq(op0 % op1) }
		add("MIN"){  Seq(Mux(op0 < op1, op0, op1)) }
		add("MAX"){  Seq(Mux(op0 > op1, op0, op1)) }
		add("AND"){  Seq(op0 & op1) }
		add("OR"){   Seq(op0 | op1) }
		add("NOT"){  Seq(~op0) }
		add("XOR"){  Seq(op0 ^ op1) }
		add("SHL"){  Seq((op0 << shn).asUInt) }
		add("LSHR"){ Seq((op0 >> shn).asUInt) }
		add("ASHR"){ Seq((op0.asSInt >> shn).asUInt) }
		add("CSHL"){ Seq(((op0 << shn).asUInt) | ((op0 >> (width.U - shn)).asUInt)) }
		add("CSHR"){ Seq(((op0 >> shn).asUInt) | ((op0 << (width.U - shn)).asUInt)) }
		add("EQ"){   Seq((op0 === op1).asUInt) }
		add("NE"){   Seq((op0 =/= op1).asUInt) }
		add("ULT"){  Seq((op0 <  op1).asUInt) }
		add("ULE"){  Seq((op0 <= op1).asUInt) }
		add("SLT"){  Seq((op0.asSInt <  op1.asSInt).asUInt) }
		add("SLE"){  Seq((op0.asSInt <= op1.asSInt).asUInt) }
		add("SEL"){  Seq(Mux(op2(0), op1, op0)) }

		// FP32
		add("FMUL32"){ Seq(fmul32Res) }
		add("FDIV32"){ Seq(fdiv32Res) }
		add("FADD32"){ Seq(fadd32Res) }
		add("FSUB32"){ Seq(fadd32Res) }
		add("FEQ32"){  Seq(fcmp32Res) }
		add("FOLT32"){ Seq(fcmp32Res) }
		add("FOLE32"){ Seq(fcmp32Res) }
		add("FUNO32"){ Seq(fcmp32Res) }

		// BF16
		add("BFMUL16"){ Seq(bfmul16Res) }
		add("BFDIV16"){ Seq(bfdiv16Res) }
		add("BFADD16"){ Seq(bfadd16Res) }
		add("BFSUB16"){ Seq(bfadd16Res) }
		add("BFEQ16"){  Seq(bfcmp16Res) }
		add("BFOLT16"){ Seq(bfcmp16Res) }
		add("BFOLE16"){ Seq(bfcmp16Res) }
		add("BFUNO16"){ Seq(bfcmp16Res) }

		// INTLV interleave
		// = Merge op
		add("INTLV4BASE") {
			val output = InterleaveOps(ops, 4, width, launch)
			Seq(output)
    	}
		add("INTLV3BASE") {
			val output = InterleaveOps(ops, 3, width, launch)
			Seq(output)
    	}
		add("INTLV2BASE") {
			val output = InterleaveOps(ops, 2, width, launch)
			Seq(output)
    	}		
		
		// DEINTLV deinterleave
		add("DEINTLV4BASE" )     {
			val output = DeinterleaveOps(ops.head, 4, width, launch)
			Seq(output(0), output(1), output(2), output(3))
    	}		
		add("DEINTLV3BASE")      {
			val output = DeinterleaveOps(ops.head, 3, width, launch)
			Seq(output(0), output(1), output(2))
    	}	
		add("DEINTLV2BASE")     {
			val output = DeinterleaveOps(ops.head, 2, width, launch)
			Seq(output(0), output(1))
    	}	

		//// MAC @jhlou
		add("MulAdd"){ Seq(RegNext(op0 * op1) + RegNext(op2)) }
		add("FMA32"){
			val lhs = RegNext(fmul32Res); val rhs = RegNext(f32b) // 这里只演示，实际按你定义
			Seq(fadd32Res) // 若要严格 FMA，请用 add 的输入换成 lhs/rhs
		}

		// 仅输出存在的 op 的映射表
		val opToRes: Map[String, Seq[UInt]] = resbuf.result().toMap

		(opToRes, shareUnitsCfgBits, opToShareUnitCfg)

		// lazy val opToRes = Map(

		// //// MAC @jhlou
		// "MulAdd" -> {
		// 	val addLhs = RegNext(op0 * op1)
		// 	val addRhs = RegNext(op2)
		// 	Seq(addLhs + addRhs)
		// },
		// "FMA32" -> {
		// 	if (ops.head.getWidth < 32 || ops(1).getWidth < 32 || ops.size < 3) {
    	// 		Seq()
  		// 	} else {
      	// 		val op0 = ops.head.apply(31,0)
      	// 		val op1 = ops(1).apply(31,0)
		// 		val op2 = ops(2).apply(31,0)
      	// 		// val fMul32_io = Module(new FPMult32).io
      	// 		fMul32_io.a := op0
      	// 			fMul32_io.b := op1
		// 			fMul32_io.rm := 0.U
		// 			val addLhs = RegNext(fMul32_io.result)
      	// 			// Seq(fMul32_io.result)
		// 			val addRhs = RegNext(op2)
      	// 			fAdd32_io.a := addLhs
      	// 			fAdd32_io.b := addRhs
		// 			fAdd32_io.sub := shareUnitsCfgBits
		// 			fAdd32_io.rm := 0.U
      	// 			Seq(fAdd32_io.result)
		// 		}
		// 	},
		// 	"BFMA16" -> {
		// 		if (ops.head.getWidth < 16 || ops(1).getWidth < 16 || ops.size < 3) {
    	// 			Seq()
  		// 		} else {
		// 			val op0 = ops.head.apply(15,0)
		// 			val op1 = ops(1).apply(15,0)
		// 			val op2 = ops(2).apply(15,0)
		// 			bfMul16_io.a := op0
		// 			bfMul16_io.b := op1
		// 			bfMul16_io.rm := 0.U
		// 			val addLhs = RegNext(bfMul16_io.result)
		// 			val addRhs = RegNext(op2)
		// 			bfAdd16_io.a := addLhs
		// 			bfAdd16_io.b := addRhs
		// 			bfAdd16_io.sub := shareUnitsCfgBits
		// 			bfAdd16_io.rm := 0.U
		// 			Seq(bfAdd16_io.result)
		// 		}
		// 	},
		// )
	}

	def dumpOpInfo(filename: String): Unit = {
		val infos = ListBuffer[Map[String, Any]]();
		OPSet.foreach { op =>
			val info = Map(
				"name" -> op,
				"OPC" -> OPCMap(op),
				"numOperands" -> getOperandNum(op),
				"numRes" -> getResNum(op),
				"latency" -> getLatency(op),
				"commutative" -> isCommutative(op),
				"accumulative" -> isAccumulative(op)
			)
			infos += info
			// println("info:", info)
		}
		val ops: mutable.Map[String, Any] = mutable.Map("Operations" -> infos)
		IRHandler.dumpIR(ops, filename)
	}

}


//object test extends App {
//	println(OPC.values)
//	println(s"OPC number: ${OPC.numOPC}")
//	println(OPC(0), OPC.withName("ADD"))
//	OPC.printOPC
//	val outFilename = "src/main/resources/operations.json"
//	OpInfo.dumpOpInfo(outFilename)
//	// println(OpInfo.OpFuncMap(OPC.ADD)(Seq(1.U, 2.U)))
//}