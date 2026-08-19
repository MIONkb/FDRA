package tram.common


/**
 * Macro Variables
 */ 
object MacroVar {
	// Directions
	val WEST = 0
	val NORTH = 1
	val EAST = 2
	val SOUTH = 3
	val NORTHWEST = 4
	val NORTHEAST = 5
	val SOUTHEAST = 6
	val SOUTHWEST = 7
	// GIB port type	
	val TYPE_IPIN = 0
	val TYPE_OPIN = 1
	val TYPE_ITRACK = 2
	val TYPE_OTRACK = 3
	// IOB mode
	val FIFO_MODE = 0
	val SRAM_MODE = 1
	val COND_LS_MODE = 2
}

object IobMode {
	import MacroVar._

	def numOperands(mode: Int): Int = mode match {
		case FIFO_MODE => 1
		case SRAM_MODE => 2
		case COND_LS_MODE => 3
		case _ => throw new IllegalArgumentException(s"Unsupported IOB mode: $mode")
	}

	def operationCapabilities(mode: Int): List[String] = mode match {
		case FIFO_MODE => List("INPUT", "OUTPUT")
		case SRAM_MODE => List("INPUT", "OUTPUT", "LOAD", "STORE")
		case COND_LS_MODE => List("INPUT", "OUTPUT", "LOAD", "STORE", "CSTORE")
		case _ => throw new IllegalArgumentException(s"Unsupported IOB mode: $mode")
	}
}


/**
	* Compile Macro Variables
	*/
object CompileMacroVar {
	//	var USE_SRAM_BLACKBOX = false
	// var USE_DIV_DW = false
	//	var USE_DIV_FPGA = false
	var USE_SRAM_BLACKBOX = false
	val DIV_LATENCY = 6
	val FPDIV_LATENCY = 6
	val TARGET_SIM = 0
	val TARGET_FPGA = 1
	val TARGET_ASIC = 2
	var TARGET_TYPE = TARGET_SIM
	// var TARGET_TYPE = TARGET_ASIC
}
