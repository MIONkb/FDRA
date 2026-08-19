package tram.vitra

import java.nio.file.{Files, Path}

import chisel3._
import chisel3.stage.ChiselStage
import chiseltest._
import com.fasterxml.jackson.databind.{JsonNode, ObjectMapper}
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import org.scalatest.OptionValues
import tram.common.IobMode
import tram.common.MacroVar.{COND_LS_MODE, FIFO_MODE, SRAM_MODE}
import tram.dsa.{ALU, CGRA, IOController, IobParam => SingleTileIobParam, SharedDelayPipe}
import tram.op.OpInfo
import tram.spec.{IobSpec => SingleTileIobSpec, TramSpec}
import tram.vitra.dsa.{IobParam => MultiTileIobParam, MultiTileCGRA}
import tram.vitra.spec.{IobSpec, VitraSpec}

import scala.collection.mutable.ListBuffer
import scala.jdk.CollectionConverters._

class VitraTask2StructuralSpec extends AnyFlatSpec with Matchers with OptionValues with ChiselScalatestTester {
  behavior of "Vitra conditional IOB structure"

  it should "derive every IOB operand count from the shared mode contract" in {
    IobMode.numOperands(FIFO_MODE) shouldBe 1
    IobMode.numOperands(SRAM_MODE) shouldBe 2
    IobMode.numOperands(COND_LS_MODE) shouldBe 3
    an[IllegalArgumentException] should be thrownBy IobMode.numOperands(99)

    Seq(FIFO_MODE, SRAM_MODE, COND_LS_MODE).foreach { mode =>
      SingleTileIobParam(mode).num_input_per_operand.size shouldBe IobMode.numOperands(mode)
      MultiTileIobParam(mode).num_input_per_operand.size shouldBe IobMode.numOperands(mode)
    }
  }

  it should "elaborate the active MultiTile path with three-operand IOB specs" in {
    conditionalGeneration.circuitHeader should startWith("circuit CGRA")
  }

  it should "emit only the truthful conditional IOB operation capabilities" in {
    val operations = conditionalGeneration.operations.path("Operations")
    val ioOperationNames = operations.elements().asScala
      .map(_.path("name").asText())
      .filter(Set("INPUT", "OUTPUT", "LOAD", "STORE", "CINPUT", "COUTPUT", "CLOAD", "CSTORE"))
      .toSet

    ioOperationNames shouldBe Set("INPUT", "OUTPUT", "LOAD", "STORE", "CSTORE")

    val cstore = operations.elements().asScala
      .find(_.path("name").asText() == "CSTORE")
      .value
    cstore.path("numOperands").asInt() shouldBe 3
    cstore.path("numRes").asInt() shouldBe 0
    cstore.path("OPC").asInt() shouldBe OpInfo.OPCMap("CSTORE")
    cstore.path("latency").asInt() shouldBe OpInfo.getLatency("CSTORE")
  }

  it should "connect all three conditional operands through muxes and the shared delay" in {
    val iobModules = modulesOfType(conditionalGeneration.adg, "IOB")
    iobModules should not be empty

    iobModules.foreach { module =>
      val attrs = module.path("attributes")
      attrs.path("iob_mode").asInt() shouldBe COND_LS_MODE
      attrs.path("num_operands").asInt() shouldBe 3
      attrs.path("num_input").asInt() shouldBe 6

      val instances = attrs.path("instances").elements().asScala.toSeq
      instances.count(_.path("type").asText() == "Muxn") shouldBe 3
      instances.count(_.path("type").asText() == "DelayPipe") shouldBe 1
      instances.count(_.path("type").asText() == "IOController") shouldBe 1

      val connections = connectionValues(attrs.path("connections"))
      (0 until 3).foreach { operand =>
        val muxToDelay = connections.find { connection =>
          connection.srcType == "Muxn" && connection.dstType == "DelayPipe" && connection.dstPort == operand
        }.value
        connections.filter { connection =>
          connection.srcType == "This" && connection.dstType == "Muxn" && connection.dstId == muxToDelay.srcId
        }.map(_.srcPort).toSet shouldBe Set(operand * 2, operand * 2 + 1)
        connections.exists { connection =>
          connection.srcType == "DelayPipe" && connection.srcPort == operand &&
            connection.dstType == "IOController" && connection.dstPort == operand
        } shouldBe true
      }
    }

    val topLevelConnections = connectionValues(conditionalGeneration.adg.path("connections"))
    val iobInstanceIds = conditionalGeneration.adg.path("instances").elements().asScala
      .filter(_.path("type").asText() == "IOB")
      .map(_.path("id").asInt())
      .toSeq
    iobInstanceIds should not be empty
    iobInstanceIds.foreach { iobId =>
      topLevelConnections.filter { connection =>
        connection.dstType == "IOB" && connection.dstId == iobId
      }.map(_.dstPort).toSet shouldBe (0 until 6).toSet
    }
  }

  it should "append UseEn to the conditional configuration without disturbing packed ranges" in {
    modulesOfType(conditionalGeneration.adg, "IOB").foreach { module =>
      val attrs = module.path("attributes")
      val configuration = attrs.path("configuration")
      val ranges = configuration.fields().asScala.map { entry =>
        ConfigRange(entry.getValue.path(0).asText(), entry.getValue.path(1).asInt(), entry.getValue.path(2).asInt())
      }.toSeq
      val aggregate = ranges.find(_.name == "This").value
      val packed = ranges.filterNot(_.name == "This").sortBy(_.low)

      packed.head.low shouldBe 0
      packed.sliding(2).foreach { adjacent =>
        adjacent(1).low shouldBe adjacent(0).high + 1
      }
      packed.last.high shouldBe aggregate.high
      aggregate.low shouldBe 0
      val useEnId = attrs.path("io_controller_cfg_id").path("UseEn").asInt(-1)
      useEnId should be >= 0
      configuration.path(useEnId.toString).elements().asScala.map(_.asText()).toSeq shouldBe
        Seq("UseEn", "127", "127")
      ranges.count(_.name == "Muxn") shouldBe 3
      ranges.find(_.name == "DelayPipe").value shouldBe ConfigRange("DelayPipe", 139, 128)
      aggregate shouldBe ConfigRange("This", 142, 0)
    }
  }

  it should "keep the generated SRAM IOB layout at two operands" in {
    modulesOfType(sramGeneration.adg, "IOB").foreach { module =>
      val attrs = module.path("attributes")
      attrs.path("iob_mode").asInt() shouldBe SRAM_MODE
      attrs.path("num_operands").asInt() shouldBe 2
      attrs.path("num_input").asInt() shouldBe 4
      attrs.path("instances").elements().asScala.count(_.path("type").asText() == "Muxn") shouldBe 2

      val configuration = attrs.path("configuration")
      configuration.path("0").elements().asScala.map(_.asText()).toSeq shouldBe Seq("This", "136", "0")
      configuration.path("2").elements().asScala.map(_.asText()).toSeq shouldBe Seq("DelayPipe", "134", "127")
      configuration.path("3").elements().asScala.map(_.asText()).toSeq shouldBe Seq("Muxn", "135", "135")
      configuration.path("4").elements().asScala.map(_.asText()).toSeq shouldBe Seq("Muxn", "136", "136")
      attrs.path("io_controller_cfg_id").has("UseEn") shouldBe false
    }

    val operationNames = sramGeneration.operations.path("Operations").elements().asScala
      .map(_.path("name").asText()).toSet
    operationNames should contain allOf ("INPUT", "OUTPUT", "LOAD", "STORE")
    operationNames should not contain "CSTORE"
  }

  it should "delay three independently configured operand lanes" in {
    test(new SharedDelayPipe(width = 16, maxDelay = 4, num = 3)) { dut =>
      dut.io.config.getWidth shouldBe 9
      dut.io.en.poke(false.B)
      dut.io.config.poke((0 | (1 << 3) | (2 << 6)).U)
      dut.io.in.foreach(_.poke(0.U))
      dut.clock.step(2)

      dut.io.en.poke(true.B)
      val lane0 = Seq(10, 11, 12, 13)
      val lane1 = Seq(20, 21, 22, 23)
      val lane2 = Seq(30, 31, 32, 33)
      lane0.indices.foreach { cycle =>
        dut.io.in(0).poke(lane0(cycle).U)
        dut.io.in(1).poke(lane1(cycle).U)
        dut.io.in(2).poke(lane2(cycle).U)
        dut.io.out(0).expect(lane0(cycle).U)
        dut.io.out(1).expect(if (cycle >= 1) lane1(cycle - 1).U else 0.U)
        dut.io.out(2).expect(if (cycle >= 2) lane2(cycle - 2).U else 0.U)
        dut.clock.step()
      }
    }
  }

  it should "represent routed predicates in bit zero" in {
    val operations = ListBuffer("EQ", "SEL")
    OpInfo(16).apply(operations)

    test(new ALU(width = 16, ops = operations)) { dut =>
      dut.io.en.poke(false.B)
      dut.io.launch.poke(false.B)

      dut.io.config.poke(OpInfo.OPCMap("EQ").U)
      dut.io.in(0).poke(7.U)
      dut.io.in(1).poke(7.U)
      dut.io.in(2).poke(0.U)
      dut.io.out.expect(1.U)
      dut.io.in(1).poke(8.U)
      dut.io.out.expect(0.U)

      dut.io.config.poke(OpInfo.OPCMap("SEL").U)
      dut.io.in(0).poke("h11".U)
      dut.io.in(1).poke("h22".U)
      dut.io.in(2).poke(1.U)
      dut.io.out.expect("h22".U)
      dut.io.in(2).poke(0.U)
      dut.io.out.expect("h11".U)
      dut.io.in(2).poke(2.U)
      dut.io.out.expect("h11".U)
    }
  }

  it should "retain the conditional controller endpoint in emitted Verilog" in {
    val targetDir = Files.createTempDirectory("vitra-task2-controller-verilog-")
    val verilog = (new ChiselStage).emitVerilog(
      new IOController(
        dataWidth = 16,
        addrWidth = 12,
        hasMask = true,
        mode = COND_LS_MODE,
        lgMaxII = 4,
        lgMaxLat = 6,
        lgMaxStride = 13,
        lgMaxCycles = 12,
        agNestLevels = 4,
        addRegSram = 2),
      Array("--target-dir", targetDir.toString))

    verilog should include regex """input\s+\[15:0\]\s+io_in_2""".r
  }

  it should "elaborate the single-tile generator with the same conditional contract" in {
    val targetDir = Files.createTempDirectory("vitra-task2-single-tile-")
    val attrs = conditionalSingleTileAttrs()
    val chirrtl = (new ChiselStage).emitChirrtl(
      new CGRA(attrs),
      Array("--target-dir", targetDir.toString))

    chirrtl should startWith("circuit CGRA")
  }

  private case class GeneratedContract(circuitHeader: String, adg: JsonNode, operations: JsonNode, targetDir: Path)
  private case class Connection(srcId: Int, srcType: String, srcPort: Int, dstId: Int, dstType: String, dstPort: Int)
  private case class ConfigRange(name: String, high: Int, low: Int)

  private lazy val conditionalGeneration = generateContract(conditionalVitraAttrs(), "vitra-task2-cond-generation-")
  private lazy val sramGeneration = generateContract(VitraSpec.attrs.clone(), "vitra-task2-sram-generation-")

  private def generateContract(attrs: scala.collection.mutable.Map[String, Any], prefix: String): GeneratedContract = {
    val targetDir = Files.createTempDirectory(prefix)
    val specDir = Files.createDirectories(targetDir.resolve("spec"))
    val adgPath = specDir.resolve("vitra_cgra_adg.json")
    val operationPath = specDir.resolve("operations.json")

    attrs("dumpOperationSet") = true
    attrs("operation_set_filename") = operationPath.toString
    attrs("dumpADG") = true
    attrs("cgra_adg_filename") = adgPath.toString

    val circuitHeader = (new ChiselStage).emitChirrtl(
      new MultiTileCGRA(attrs),
      Array("--target-dir", targetDir.toString)).linesIterator.next()
    val mapper = new ObjectMapper()
    GeneratedContract(
      circuitHeader,
      mapper.readTree(adgPath.toFile),
      mapper.readTree(operationPath.toFile),
      targetDir)
  }

  private def modulesOfType(adg: JsonNode, moduleType: String): Seq[JsonNode] = {
    adg.path("sub_modules").elements().asScala
      .filter(_.path("type").asText() == moduleType).toSeq
  }

  private def connectionValues(connections: JsonNode): Seq[Connection] = {
    connections.elements().asScala.map { value =>
      Connection(
        value.path(0).asInt(), value.path(1).asText(), value.path(2).asInt(),
        value.path(3).asInt(), value.path(4).asText(), value.path(5).asInt())
    }.toSeq
  }

  private def conditionalVitraAttrs(): scala.collection.mutable.Map[String, Any] = {
    val attrs = VitraSpec.attrs.clone()
    val currentIobs = attrs("cgra_iobs")
      .asInstanceOf[ListBuffer[ListBuffer[IobSpec]]]

    attrs("cgra_iob_mode") = COND_LS_MODE
    attrs("cgra_iobs") = currentIobs.map { row =>
      row.map(spec => spec.copy(mode = COND_LS_MODE))
    }
    attrs
  }

  private def conditionalSingleTileAttrs(): scala.collection.mutable.Map[String, Any] = {
    val attrs = TramSpec.attrs.clone()
    val currentIobs = attrs("cgra_iobs")
      .asInstanceOf[ListBuffer[ListBuffer[SingleTileIobSpec]]]

    attrs("cgra_iob_mode") = COND_LS_MODE
    attrs("cgra_iobs") = currentIobs.map { row =>
      row.map(spec => spec.copy(mode = COND_LS_MODE))
    }
    attrs("dumpOperationSet") = false
    attrs("dumpADG") = false
    attrs
  }
}
