package tram.vitra

import java.nio.file.{Files, Path, Paths}

import chisel3._
import chiseltest._
import com.fasterxml.jackson.databind.ObjectMapper
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import tram.dsa.GPE
import tram.op.OpInfo
import tram.vitra.dsa.MultiTileCgraParam
import tram.vitra.spec.VitraSpec

import scala.collection.mutable
import scala.collection.mutable.{ArrayBuffer, ListBuffer}
import scala.jdk.CollectionConverters._

class VitraLoopIndexAccSpec extends AnyFlatSpec with Matchers with ChiselScalatestTester {
  behavior of "VITRA ACC loop-index lowering"

  it should "derive the public contract from production operation and ADG metadata" in {
    val output = Files.createTempDirectory("vitra-loop-index-contract-")
      .resolve("loop_index_contract.json")
    LoopIndexContract.write(
      operationsPath = checkedSpec.resolve("operations.json"),
      adgPath = checkedSpec.resolve("vitra_cgra_adg.json"),
      output = output)

    val contract = new ObjectMapper().readTree(output.toFile)
    contract.path("schema_version").asInt() shouldBe 1
    contract.path("logical_source").asText() shouldBe "affine.for induction value"
    contract.path("physical_operation").asText() shouldBe "ACC"
    contract.path("for_is_physical_operation").asBoolean() shouldBe false
    contract.path("data_width").asInt() shouldBe 16
    contract.path("signedness").asText() shouldBe "unsigned_16_bit_modular_bitvector"
    contract.path("data_width_bits").asInt() shouldBe 16
    contract.path("backpressure_supported").asBoolean() shouldBe false
    contract.path("enable_semantics").asText() shouldBe "abort_reset_suppress"
    contract.path("physical_for_supported").asBoolean() shouldBe false
    contract.path("supported_loop_subset").path("negative_step").asBoolean() shouldBe false
    contract.path("supported_loop_subset").path("minimum_trip_count").asInt() shouldBe 1
    contract.path("supported_loop_subset").path("maximum_trip_count").asInt() shouldBe 4095

    val operations = contract.path("operations")
    operations.path("ACC").path("opcode").asInt() shouldBe OpInfo.OPCMap("ACC")
    operations.path("ASUB").path("opcode").asInt() shouldBe OpInfo.OPCMap("ASUB")
    operations.path("ACC").path("logical_operands").asInt() shouldBe 1

    val fields = contract.path("configuration_fields")
    Set("InitVal", "WI", "Latency", "Cycles", "Repeats", "SkipFirst").foreach { name =>
      fields.has(name) shouldBe true
      fields.path(name).path("high").asInt() should be >= fields.path(name).path("low").asInt()
    }
    fields.path("InitVal").path("width").asInt() shouldBe 16
    fields.path("Cycles").path("width").asInt() shouldBe 12

    val formula = contract.path("configuration_formula")
    formula.path("WI").asInt() shouldBe 1
    formula.path("Latency").asInt() shouldBe 0
    formula.path("Repeats").asInt() shouldBe 1
    formula.path("SkipFirst").asInt() shouldBe 1
    formula.path("InitVal").asText() shouldBe "lower_bound mod 2^16"
    formula.path("Cycles").asText() shouldBe "trip_count"
    formula.path("routed_operand_0").asText() shouldBe "positive_step mod 2^16"
    contract.path("timing").path("start_pulse_to_first_output_cycles").asInt() shouldBe 2
    contract.path("timing").path("output_interval_cycles").asInt() shouldBe 1
    contract.path("timing").path("post_sequence_output").asText() shouldBe "holds_last_value_while_enabled"
    contract.path("first_value_timing").path("cycles_after_gpe_start_assertion").asInt() shouldBe 2
    contract.path("first_value_timing").path("value").asText() shouldBe "lower_bound"
    contract.path("last_value_behavior").path("state_after_last_value").asText() shouldBe "idle"
    contract.path("wraparound").path("arithmetic").asText() shouldBe "modulo_2^16"
    contract.path("execution_enable_semantics").path("en_zero").asText() shouldBe "abort_return_idle_and_zero_state"
    contract.path("byte_address_scaling").asText() shouldBe "external-explicit-arithmetic"
    contract.path("evidence").isArray shouldBe true
    contract.path("evidence").size() should be >= 4
  }

  it should "emit zero through fifteen through the real production GPE path" in {
    test(newProductionGpe()) { dut =>
      initialize(dut)
      programLoop(dut, lowerBound = 0, step = 1, tripCount = 16)

      runLoop(dut, expectedCount = 16) shouldBe (0 until 16)
      dut.clock.step(3)
      dut.io.out(0).expect(15.U)
    }
  }

  it should "publish the first induction value exactly two cycles after start assertion" in {
    test(newProductionGpe()) { dut =>
      initialize(dut)
      programLoop(dut, lowerBound = 3, step = 1, tripCount = 2)

      dut.io.start.poke(true.B)
      dut.clock.step()
      dut.io.start.poke(false.B)
      dut.io.out(0).expect(0.U)
      dut.clock.step()
      dut.io.out(0).expect(0.U)
      dut.clock.step()
      dut.io.out(0).expect(3.U)
    }
  }

  it should "honor a nonzero lower bound and a step larger than one" in {
    test(newProductionGpe()) { dut =>
      initialize(dut)
      programLoop(dut, lowerBound = 3, step = 2, tripCount = 5)

      runLoop(dut, expectedCount = 5) shouldBe Seq(3, 5, 7, 9, 11)
    }
  }

  it should "abort and suppress rather than stall when enable is removed" in {
    test(newProductionGpe()) { dut =>
      initialize(dut)
      programLoop(dut, lowerBound = 7, step = 1, tripCount = 8)
      pulseStart(dut)

      val prefix = collectLaunches(dut, expectedCount = 3, maxCycles = 32)
      prefix shouldBe Seq(7, 8, 9)

      dut.io.en.poke(false.B)
      dut.clock.step(3)
      dut.io.out(0).expect(0.U)

      dut.io.en.poke(true.B)
      dut.clock.step(3)
      dut.io.out(0).expect(0.U)

      pulseStart(dut)
      collectLaunches(dut, expectedCount = 8, maxCycles = 48) shouldBe (7 until 15)
    }
  }

  it should "retain only the low sixteen accumulator bits on arithmetic wrap" in {
    test(newProductionGpe()) { dut =>
      initialize(dut)
      programLoop(dut, lowerBound = 65534, step = 1, tripCount = 3)

      runLoop(dut, expectedCount = 3) shouldBe Seq(65534, 65535, 0)
    }
  }

  it should "characterize ASUB as subtracting the routed operand from feedback" in {
    test(newProductionGpe()) { dut =>
      initialize(dut)
      programLoop(dut, lowerBound = 5, step = 1, tripCount = 3, operation = "ASUB")

      runLoop(dut, expectedCount = 3) shouldBe Seq(5, 4, 3)
    }
  }

  private def newProductionGpe(): GPE = {
    val params = MultiTileCgraParam(VitraSpec.cstoreAttrs())
    val gpe = params.gpesParam.head.head
    new GPE(mutable.Map[String, Any](
      "data_width" -> params.dataWidth,
      "cfg_data_width" -> params.cfgDataWidth,
      "cfg_addr_width" -> params.cfgAddrWidth,
      "cfg_blk_index" -> 1,
      "cfg_blk_offset" -> params.cfgBlkOffset,
      "operations" -> ListBuffer.from(gpe.operations),
      "num_input_per_operand" -> ListBuffer.from(gpe.num_input_per_operand),
      "max_delay" -> gpe.max_delay,
      "lg_max_lat" -> params.lgMaxLat,
      "lg_max_wi" -> params.lgMaxCycles,
      "lg_max_cycles" -> params.lgMaxCycles,
      "lg_max_repeats" -> params.lgMaxCycles,
      "lg_max_ii" -> params.lgMaxII))
  }

  private def initialize(dut: GPE): Unit = {
    dut.io.cfg_en.poke(false.B)
    dut.io.cfg_addr.poke(0.U)
    dut.io.cfg_data.poke(0.U)
    dut.io.start.poke(false.B)
    dut.io.en.poke(false.B)
    dut.io.in.foreach(_.poke(0.U))
    dut.clock.step(3)
  }

  private def programLoop(
      dut: GPE,
      lowerBound: Int,
      step: Int,
      tripCount: Int,
      operation: String = "ACC"): Unit = {
    val ranges = configurationRanges(dut)
    var config = BigInt(0)
    def set(name: String, value: BigInt, occurrence: Int = 0): Unit = {
      val range = ranges.filter(_._1 == name).sortBy(_._3).apply(occurrence)
      val width = range._2 - range._3 + 1
      require(value >= 0 && value < (BigInt(1) << width), s"$name value $value does not fit $width bits")
      config |= value << range._3
    }

    set("ALU", OpInfo.OPCMap(operation))
    set("Muxn", 1, occurrence = 0)
    set("InitVal", lowerBound & 0xffff)
    set("WI", 1)
    set("Latency", 0)
    set("Cycles", tripCount)
    set("Repeats", 1)
    set("SkipFirst", 1)

    dut.io.in(0).poke((step & 0xffff).U)
    val totalBits = ranges.find(_._1 == "This").map(_._2 + 1).get
    val words = (totalBits + dut.io.cfg_data.getWidth - 1) / dut.io.cfg_data.getWidth
    val wordMask = (BigInt(1) << dut.io.cfg_data.getWidth) - 1
    val baseAddress = dut.cfgBlkIndex << dut.cfgBlkOffset
    dut.io.cfg_en.poke(true.B)
    (0 until words).foreach { word =>
      dut.io.cfg_addr.poke((baseAddress + word).U)
      dut.io.cfg_data.poke(((config >> (word * dut.io.cfg_data.getWidth)) & wordMask).U)
      dut.clock.step()
    }
    dut.io.cfg_en.poke(false.B)
    dut.io.en.poke(true.B)
    dut.clock.step(3)
  }

  private def runLoop(dut: GPE, expectedCount: Int): Seq[Int] = {
    pulseStart(dut)
    collectLaunches(dut, expectedCount, maxCycles = expectedCount * 4 + 16)
  }

  private def pulseStart(dut: GPE): Unit = {
    dut.io.start.poke(true.B)
    dut.clock.step()
    dut.io.start.poke(false.B)
  }

  private def collectLaunches(dut: GPE, expectedCount: Int, maxCycles: Int): Seq[Int] = {
    val outputs = ArrayBuffer[Int]()
    // GPE registers start once before AffineCtrlReg enters s_data. The first
    // public output update is therefore the following edge.
    dut.clock.step()
    var cycles = 1
    while (outputs.size < expectedCount && cycles < maxCycles) {
      dut.clock.step()
      outputs += dut.io.out(0).peek().litValue.toInt
      cycles += 1
    }
    withClue(s"captured ${outputs.size} launches in $cycles cycles: ") {
      outputs.size shouldBe expectedCount
    }
    outputs.toSeq
  }

  private def configurationRanges(dut: GPE): Seq[(String, Int, Int)] =
    dut.getAttrValue("configuration")
      .asInstanceOf[mutable.Map[Int, (String, Int, Int)]]
      .values.toSeq

  private lazy val checkedSpec: Path = {
    Iterator.iterate(Paths.get("").toAbsolutePath)(_.getParent)
      .takeWhile(_ != null)
      .map(_.resolve("generators/fdra/cgra-mg/src/main/vitra_spec/cstore"))
      .find(Files.isDirectory(_))
      .orElse {
        Iterator.iterate(Paths.get("").toAbsolutePath)(_.getParent)
          .takeWhile(_ != null)
          .map(_.resolve("cgra-mg/src/main/vitra_spec/cstore"))
          .find(Files.isDirectory(_))
      }
      .getOrElse(throw new IllegalStateException("cannot locate checked CSTORE spec directory"))
  }
}
