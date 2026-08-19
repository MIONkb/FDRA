package tram.vitra

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import tram.common.MacroVar.{FIFO_MODE, SRAM_MODE}
import tram.dsa.IOController

class VitraTask4LegacyRegressionSpec
    extends AnyFlatSpec with Matchers with ChiselScalatestTester {
  behavior of "Vitra legacy IOB modes"

  it should "retain active FIFO write and read requests" in {
    test(new LegacyControllerHarness(FIFO_MODE)) { dut =>
      initialize(dut, controllerConfig(FIFO_MODE, isStore = true, useAddr = false, baseAddr = 3))
      issue(dut, Seq(0x5a5a))

      dut.io.done.expect(true.B)
      dut.io.sramEn.expect(true.B)
      dut.io.sramMask.expect(3.U)
      dut.io.sramAddress.expect(3.U)
      dut.io.sramData.expect("h5a5a".U)

      initialize(dut, controllerConfig(FIFO_MODE, isStore = false, useAddr = false, baseAddr = 4))
      issue(dut, Seq(0))

      dut.io.done.expect(true.B)
      dut.io.sramEn.expect(true.B)
      dut.io.sramMask.expect(0.U)
      dut.io.sramAddress.expect(4.U)
    }
  }

  it should "retain routed-address SRAM STORE and LOAD requests" in {
    test(new LegacyControllerHarness(SRAM_MODE)) { dut =>
      initialize(dut, controllerConfig(SRAM_MODE, isStore = true, useAddr = true, baseAddr = 0))
      issue(dut, Seq(0x1234, 10))

      dut.io.done.expect(true.B)
      dut.io.sramEn.expect(true.B)
      dut.io.sramMask.expect(3.U)
      dut.io.sramAddress.expect(5.U)
      dut.io.sramData.expect("h1234".U)

      initialize(dut, controllerConfig(SRAM_MODE, isStore = false, useAddr = true, baseAddr = 0))
      issue(dut, Seq(8, 0))

      dut.io.done.expect(true.B)
      dut.io.sramEn.expect(true.B)
      dut.io.sramMask.expect(0.U)
      dut.io.sramAddress.expect(4.U)
    }
  }

  private val DataWidth = 16
  private val AddrWidth = 8
  private val LgMaxII = 2
  private val LgMaxLat = 2
  private val LgMaxStride = 4
  private val LgMaxCycles = 3

  private class LegacyControllerHarness(mode: Int) extends Module {
    private val controller = Module(new IOController(
      dataWidth = DataWidth,
      addrWidth = AddrWidth,
      hasMask = true,
      mode = mode,
      lgMaxII = LgMaxII,
      lgMaxLat = LgMaxLat,
      lgMaxStride = LgMaxStride,
      lgMaxCycles = LgMaxCycles,
      agNestLevels = 1,
      addRegSram = 2))

    val io = IO(new Bundle {
      val start = Input(Bool())
      val config = Input(UInt(controller.io.config.getWidth.W))
      val in = Input(Vec(controller.numIn, UInt(DataWidth.W)))
      val done = Output(Bool())
      val sramEn = Output(Bool())
      val sramMask = Output(UInt(controller.io.sram.we.getWidth.W))
      val sramAddress = Output(UInt(AddrWidth.W))
      val sramData = Output(UInt(DataWidth.W))
    })

    controller.io.start := io.start
    controller.io.config := io.config
    controller.io.in.zip(io.in).foreach { case (sink, source) => sink := source }
    controller.io.sram.dout := 0.U
    io.done := controller.io.done
    io.sramEn := controller.io.sram.en
    io.sramMask := controller.io.sram.we
    io.sramAddress := controller.io.sram.addr
    io.sramData := controller.io.sram.din
  }

  private def initialize(dut: LegacyControllerHarness, config: BigInt): Unit = {
    dut.io.start.poke(false.B)
    dut.io.config.poke(config.U)
    dut.io.in.foreach(_.poke(0.U))
    dut.clock.step(2)
  }

  private def issue(dut: LegacyControllerHarness, operands: Seq[Int]): Unit = {
    dut.io.start.poke(true.B)
    dut.clock.step()
    dut.io.start.poke(false.B)
    dut.io.in.zip(operands).foreach { case (port, value) => port.poke(value.U) }
    dut.clock.step()
  }

  private def controllerConfig(
      mode: Int,
      isStore: Boolean,
      useAddr: Boolean,
      baseAddr: Int): BigInt = {
    var config = BigInt(0)
    var offset = 0

    def append(value: BigInt, width: Int): Unit = {
      config |= (value & ((BigInt(1) << width) - 1)) << offset
      offset += width
    }

    append(baseAddr, AddrWidth)
    append(1, LgMaxStride)
    append(1, LgMaxCycles)
    append(1, LgMaxII)
    append(0, LgMaxLat)
    append(if (isStore) 1 else 0, 1)
    if (mode != FIFO_MODE) append(if (useAddr) 1 else 0, 1)
    config
  }
}
