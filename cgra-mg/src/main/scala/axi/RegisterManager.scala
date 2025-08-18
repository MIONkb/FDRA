package tram.axi
import chisel3._
import chisel3.util._

class RegisterManager {
  private var addrCounter: Int = 0
  private val regMap = scala.collection.mutable.Map[UInt, Int]()

  def addRegister(width: Int): UInt = {
    val reg = RegInit(0.U(width.W))
    val addr = addrCounter
    println("addr", addr.toInt)
    regMap(reg) = addr.toInt
    addrCounter = addrCounter + 1 // 1-byte alignment
    reg
  }

  /// addr -> reg
  def getRegMap: Map[UInt, Int] = regMap.toMap
}