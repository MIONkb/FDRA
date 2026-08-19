package tram.vitra

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import tram.common.MacroVar.COND_LS_MODE
import tram.dsa.{IOB, IOController}

import scala.collection.mutable
import scala.collection.mutable.ListBuffer

class VitraTask3CStoreSpec extends AnyFlatSpec with Matchers with ChiselScalatestTester {
  behavior of "Vitra CSTORE write gating"

  it should "suppress a registered SRAM write for a false predicate without suppressing done" in {
    test(new Task3ControllerHarness(addRegSram = 2)) { dut =>
      val oldValue = 0x0bad
      val traces = runStore(
        dut,
        Seq(StoreInput(data = 0x55aa, byteAddress = 6, predicate = 0)),
        useEn = true,
        addRegSram = 2)
      val memory = applyWrites(Map(3 -> oldValue), traces)

      traces.last.done shouldBe true
      traces.last.sramEn shouldBe false
      traces.last.sramMask shouldBe 0
      writeEvents(traces) shouldBe empty
      memory(3) shouldBe oldValue
    }
  }

  it should "write new data exactly once for a true registered predicate" in {
    test(new Task3ControllerHarness(addRegSram = 2)) { dut =>
      val oldValue = 0x0bad
      val traces = runStore(
        dut,
        Seq(StoreInput(data = 0x55aa, byteAddress = 6, predicate = 1)),
        useEn = true,
        addRegSram = 2)
      val memory = applyWrites(Map(3 -> oldValue), traces)

      writeEvents(traces) shouldBe Seq(SramWrite(wordAddress = 3, data = 0x55aa, mask = 3))
      memory(3) shouldBe 0x55aa
      traces.last.done shouldBe true
    }
  }

  it should "ignore operand two for a normal STORE when UseEn is clear" in {
    test(new Task3ControllerHarness(addRegSram = 2)) { dut =>
      val traces = runStore(
        dut,
        Seq(StoreInput(data = 0x1234, byteAddress = 10, predicate = 0)),
        useEn = false,
        addRegSram = 2)

      writeEvents(traces) shouldBe Seq(SramWrite(wordAddress = 5, data = 0x1234, mask = 3))
    }
  }

  it should "keep alternating predicates aligned with registered data and addresses" in {
    test(new Task3ControllerHarness(addRegSram = 2)) { dut =>
      val inputs = Seq(
        StoreInput(data = 0x1011, byteAddress = 0, predicate = 1),
        StoreInput(data = 0x2022, byteAddress = 2, predicate = 0),
        StoreInput(data = 0x3033, byteAddress = 4, predicate = 1),
        StoreInput(data = 0x4044, byteAddress = 6, predicate = 0))
      val traces = runStore(dut, inputs, useEn = true, addRegSram = 2)

      traces.map(_.sramEn) shouldBe Seq(true, false, true, false)
      traces.map(_.sramMask) shouldBe Seq(3, 0, 3, 0)
      writeEvents(traces) shouldBe Seq(
        SramWrite(wordAddress = 0, data = 0x1011, mask = 3),
        SramWrite(wordAddress = 2, data = 0x3033, mask = 3))
      traces.map(_.done) shouldBe Seq(false, false, false, true)

      traces.foreach { trace =>
        println(
          s"TASK3_TRACE issue=${trace.issueCycle} data=0x${trace.input.data.toHexString} " +
            s"byte_addr=${trace.input.byteAddress} pred=${trace.input.predicate} " +
            s"wValid=true expected_write=${trace.expectedWrite} " +
            s"sram_en=${trace.sramEn} sram_we=0x${trace.sramMask.toHexString} " +
            s"sram_addr=${trace.sramAddress} sram_din=0x${trace.sramData.toHexString} done=${trace.done}")
      }
    }
  }

  it should "treat a predicate word containing only bit one as false" in {
    test(new Task3ControllerHarness(addRegSram = 2)) { dut =>
      val traces = runStore(
        dut,
        Seq(StoreInput(data = 0x7777, byteAddress = 12, predicate = 2)),
        useEn = true,
        addRegSram = 2)

      writeEvents(traces) shouldBe empty
      traces.last.sramEn shouldBe false
      traces.last.sramMask shouldBe 0
    }
  }

  it should "apply the same true and false permission in the combinational SRAM path" in {
    test(new Task3ControllerHarness(addRegSram = 0)) { dut =>
      val traces = runStore(
        dut,
        Seq(
          StoreInput(data = 0x1111, byteAddress = 2, predicate = 1),
          StoreInput(data = 0x2222, byteAddress = 4, predicate = 0)),
        useEn = true,
        addRegSram = 0)

      traces.map(_.sramEn) shouldBe Seq(true, false)
      writeEvents(traces) shouldBe Seq(SramWrite(wordAddress = 1, data = 0x1111, mask = 3))
      traces.last.done shouldBe true
    }
  }

  it should "leave a normal LOAD request independent of the predicate operand" in {
    test(new Task3ControllerHarness(addRegSram = 2)) { dut =>
      initialize(dut, controllerConfig(isStore = false, useAddr = true, useEn = false, iterations = 1))
      dut.io.in(0).poke(8.U) // LOAD uses operand 0 as its routed byte address
      dut.io.in(2).poke(0.U)

      dut.io.start.poke(true.B)
      dut.clock.step()
      dut.io.start.poke(false.B)
      dut.clock.step()

      dut.io.done.expect(true.B)
      dut.io.sramEn.expect(true.B)
      dut.io.sramMask.expect(0.U)
      dut.io.sramAddress.expect(4.U)
    }
  }

  it should "align skewed data address and predicate streams at the IOB controller inputs" in {
    test(new IOB(iobAttrs)) { dut =>
      initializeIob(dut)
      val controllerBits = dut.ioCtrl.io.config.getWidth
      val perLaneDelayBits = dut.delay_pipe.cfgWidth
      val delayConfig =
        (BigInt(2) << (perLaneDelayBits * 0)) |
          (BigInt(1) << (perLaneDelayBits * 1)) |
          (BigInt(0) << (perLaneDelayBits * 2))
      val packedConfig =
        controllerConfig(isStore = true, useAddr = true, useEn = true, iterations = 1) |
          (delayConfig << controllerBits)
      writeIobConfig(dut, packedConfig)

      dut.io.en.poke(false.B)
      dut.clock.step(2)
      dut.io.en.poke(true.B)
      dut.clock.step() // propagate IOB's registered enable into SharedDelayPipe

      // data is two cycles early, address one cycle early, and predicate arrives
      // in the controller issue cycle. The configured delays realign the tuple.
      dut.io.start.poke(true.B)
      pokeIobOperand(dut, operand = 0, value = 0x5a5a)
      pokeIobOperand(dut, operand = 1, value = 0)
      pokeIobOperand(dut, operand = 2, value = 0)
      dut.clock.step()

      dut.io.start.poke(false.B)
      pokeIobOperand(dut, operand = 0, value = 0)
      pokeIobOperand(dut, operand = 1, value = 10)
      pokeIobOperand(dut, operand = 2, value = 0)
      dut.clock.step()

      pokeIobOperand(dut, operand = 0, value = 0)
      pokeIobOperand(dut, operand = 1, value = 0)
      pokeIobOperand(dut, operand = 2, value = 1)
      dut.clock.step()

      dut.io.done.expect(true.B)
      dut.io.sram.en.expect(true.B)
      dut.io.sram.we.expect(3.U)
      dut.io.sram.addr.expect(5.U)
      dut.io.sram.din.expect("h5a5a".U)
    }
  }

  private val DataWidth = 16
  private val AddrWidth = 8
  private val LgMaxII = 2
  private val LgMaxLat = 2
  private val LgMaxStride = 4
  private val LgMaxCycles = 3
  private val AgNestLevels = 1

  private case class StoreInput(data: Int, byteAddress: Int, predicate: Int)
  private case class SramWrite(wordAddress: Int, data: Int, mask: Int)
  private case class StoreTrace(
    issueCycle: Int,
    input: StoreInput,
    expectedWrite: Boolean,
    sramEn: Boolean,
    sramMask: Int,
    sramAddress: Int,
    sramData: Int,
    done: Boolean)

  private def iobAttrs: mutable.Map[String, Any] = mutable.Map(
    "data_width" -> DataWidth,
    "cfg_data_width" -> 32,
    "cfg_addr_width" -> 6,
    "cfg_blk_index" -> 0,
    "cfg_blk_offset" -> 2,
    "iob_index" -> 0,
    "addr_width_sram" -> AddrWidth,
    "has_mask_sram" -> true,
    "add_reg_sram" -> 2,
    "iob_mode" -> COND_LS_MODE,
    "lg_max_lat" -> LgMaxLat,
    "lg_max_ii" -> LgMaxII,
    "lg_max_stride" -> LgMaxStride,
    "lg_max_cycles" -> LgMaxCycles,
    "ag_nest_levels" -> AgNestLevels,
    "max_delay" -> 4,
    "num_input_per_operand" -> ListBuffer(2, 2, 2))

  private class Task3ControllerHarness(addRegSram: Int) extends Module {
    private val controller = Module(new IOController(
      dataWidth = DataWidth,
      addrWidth = AddrWidth,
      hasMask = true,
      mode = COND_LS_MODE,
      lgMaxII = LgMaxII,
      lgMaxLat = LgMaxLat,
      lgMaxStride = LgMaxStride,
      lgMaxCycles = LgMaxCycles,
      agNestLevels = AgNestLevels,
      addRegSram = addRegSram))

    val io = IO(new Bundle {
      val start = Input(Bool())
      val config = Input(UInt(controller.io.config.getWidth.W))
      val in = Input(Vec(3, UInt(DataWidth.W)))
      val sramDout = Input(UInt(DataWidth.W))
      val done = Output(Bool())
      val sramEn = Output(Bool())
      val sramMask = Output(UInt(controller.io.sram.we.getWidth.W))
      val sramAddress = Output(UInt(AddrWidth.W))
      val sramData = Output(UInt(DataWidth.W))
    })

    controller.io.start := io.start
    controller.io.config := io.config
    controller.io.in.zip(io.in).foreach { case (sink, source) => sink := source }
    controller.io.sram.dout := io.sramDout
    io.done := controller.io.done
    io.sramEn := controller.io.sram.en
    io.sramMask := controller.io.sram.we
    io.sramAddress := controller.io.sram.addr
    io.sramData := controller.io.sram.din
  }

  private def initialize(dut: Task3ControllerHarness, config: BigInt): Unit = {
    dut.io.start.poke(false.B)
    dut.io.config.poke(config.U)
    dut.io.in.foreach(_.poke(0.U))
    dut.io.sramDout.poke(0.U)
    dut.clock.step(2)
  }

  private def initializeIob(dut: IOB): Unit = {
    dut.io.cfg_en.poke(false.B)
    dut.io.cfg_addr.poke(0.U)
    dut.io.cfg_data.poke(0.U)
    dut.io.start.poke(false.B)
    dut.io.en.poke(false.B)
    dut.io.in.foreach(_.poke(0.U))
    dut.io.sram.dout.poke(0.U)
    dut.clock.step(2)
  }

  private def writeIobConfig(dut: IOB, config: BigInt): Unit = {
    val cfgDataWidth = dut.io.cfg_data.getWidth
    val wordMask = (BigInt(1) << cfgDataWidth) - 1
    val words = (dut.sumCfgWidth + cfgDataWidth - 1) / cfgDataWidth
    dut.io.cfg_en.poke(true.B)
    (0 until words).foreach { word =>
      dut.io.cfg_addr.poke(word.U)
      dut.io.cfg_data.poke(((config >> (word * cfgDataWidth)) & wordMask).U)
      dut.clock.step()
    }
    dut.io.cfg_en.poke(false.B)
  }

  private def pokeIobOperand(dut: IOB, operand: Int, value: Int): Unit = {
    val firstPhysicalPort = operand * 2
    dut.io.in(firstPhysicalPort).poke(value.U)
    dut.io.in(firstPhysicalPort + 1).poke(0.U)
  }

  private def runStore(
    dut: Task3ControllerHarness,
    inputs: Seq[StoreInput],
    useEn: Boolean,
    addRegSram: Int): Seq[StoreTrace] = {
    initialize(
      dut,
      controllerConfig(isStore = true, useAddr = true, useEn = useEn, iterations = inputs.size))
    dut.io.start.poke(true.B)
    dut.clock.step()
    dut.io.start.poke(false.B)

    inputs.zipWithIndex.map { case (input, cycle) =>
      dut.io.in(0).poke(input.data.U)
      dut.io.in(1).poke(input.byteAddress.U)
      dut.io.in(2).poke(input.predicate.U)

      val beforeStep = observeSram(dut)
      dut.clock.step()
      val afterStep = observeSram(dut)
      val observed = if (addRegSram > 0) afterStep else beforeStep

      StoreTrace(
        issueCycle = cycle,
        input = input,
        expectedWrite = !useEn || (input.predicate & 1) == 1,
        sramEn = observed._1,
        sramMask = observed._2,
        sramAddress = observed._3,
        sramData = observed._4,
        done = dut.io.done.peek().litToBoolean)
    }
  }

  private def observeSram(dut: Task3ControllerHarness): (Boolean, Int, Int, Int) = (
    dut.io.sramEn.peek().litToBoolean,
    dut.io.sramMask.peek().litValue.toInt,
    dut.io.sramAddress.peek().litValue.toInt,
    dut.io.sramData.peek().litValue.toInt)

  private def writeEvents(traces: Seq[StoreTrace]): Seq[SramWrite] = traces.collect {
    case trace if trace.sramEn && trace.sramMask != 0 =>
      SramWrite(trace.sramAddress, trace.sramData, trace.sramMask)
  }

  private def applyWrites(initial: Map[Int, Int], traces: Seq[StoreTrace]): Map[Int, Int] = {
    traces.foldLeft(initial) { case (memory, trace) =>
      if (!trace.sramEn || trace.sramMask == 0) {
        memory
      } else {
        val oldValue = memory.getOrElse(trace.sramAddress, 0)
        val newValue = (0 until DataWidth / 8).foldLeft(oldValue) { case (value, byte) =>
          if ((trace.sramMask & (1 << byte)) == 0) {
            value
          } else {
            val byteMask = 0xff << (byte * 8)
            (value & ~byteMask) | (trace.sramData & byteMask)
          }
        }
        memory.updated(trace.sramAddress, newValue)
      }
    }
  }

  private def controllerConfig(
    isStore: Boolean,
    useAddr: Boolean,
    useEn: Boolean,
    iterations: Int): BigInt = {
    var config = BigInt(0)
    var offset = 0

    def append(value: BigInt, width: Int): Unit = {
      val mask = (BigInt(1) << width) - 1
      config |= (value & mask) << offset
      offset += width
    }

    append(0, AddrWidth) // BaseAddr
    append(0, LgMaxStride) // Stride0
    append(iterations, LgMaxCycles) // Cycles0
    append(1, LgMaxII) // II
    append(0, LgMaxLat) // Latency
    append(if (isStore) 1 else 0, 1)
    append(if (useAddr) 1 else 0, 1)
    append(if (useEn) 1 else 0, 1)
    config
  }
}
