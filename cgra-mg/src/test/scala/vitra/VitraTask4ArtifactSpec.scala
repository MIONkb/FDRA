package tram.vitra

import java.nio.file.Files

import com.fasterxml.jackson.databind.{JsonNode, ObjectMapper}
import org.scalatest.OptionValues
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import tram.common.MacroVar.{COND_LS_MODE, SRAM_MODE}
import tram.op.OpInfo
import tram.vitra.spec.{IobSpec, VitraSpec}

import scala.collection.mutable.ListBuffer
import scala.jdk.CollectionConverters._

class VitraTask4ArtifactSpec extends AnyFlatSpec with Matchers with OptionValues {
  behavior of "Vitra CSTORE production artifacts"

  it should "build an isolated conditional target without changing the default SRAM spec" in {
    val defaultMode = VitraSpec.attrs("cgra_iob_mode")
    val defaultIobModes = iobModes(VitraSpec.attrs)

    val cstoreAttrs = VitraSpec.cstoreAttrs()

    cstoreAttrs("cgra_iob_mode") shouldBe COND_LS_MODE
    iobModes(cstoreAttrs) should contain only COND_LS_MODE
    VitraSpec.attrs("cgra_iob_mode") shouldBe defaultMode
    defaultMode shouldBe SRAM_MODE
    iobModes(VitraSpec.attrs) shouldBe defaultIobModes
  }

  it should "separate output paths from portable metadata filenames" in {
    val targetDir = Files.createTempDirectory("vitra-task4-portable-")
    val paths = VitraParam.metadataPathsFor(targetDir)
    val attrs = VitraSpec.cstoreAttrs()

    VitraParam.configureMetadata(
      attrs,
      paths,
      operationSetEnabled = true,
      adgEnabled = true)
    val portable = VitraParam.portableSpecAttrs(attrs)

    attrs("operation_set_filename") shouldBe paths.operationSet.toString
    attrs("cgra_adg_filename") shouldBe paths.cgraAdg.toString
    portable("operation_set_filename") shouldBe "operations.json"
    portable("cgra_adg_filename") shouldBe "vitra_cgra_adg.json"
    portable should not be theSameInstanceAs(attrs)
  }

  it should "reject an incomplete generated bundle before it can be published" in {
    val targetDir = Files.createTempDirectory("vitra-task4-incomplete-")

    val error = the[IllegalArgumentException] thrownBy CStoreArtifactAudit.validate(targetDir)

    error.getMessage should include("CGRAWithAXI.v")
    error.getMessage should include("operations.json")
  }

  it should "generate one complete audited bundle from the explicit CSTORE entrypoint" in {
    val (targetDir, summary) = firstGeneration

    summary.targetDir shouldBe targetDir
    summary.fileSha256.keySet shouldBe Set(
      "CGRAWithAXI.v",
      "spec/vitra_spec.json",
      "spec/operations.json",
      "spec/vitra_cgra_adg.json",
      "spec/axilite_spec.json")
    summary.fileSha256.values.foreach(_.length shouldBe 64)

    val vitraSpec = readJson(targetDir.resolve("spec/vitra_spec.json"))
    vitraSpec.path("operation_set_filename").asText() shouldBe "operations.json"
    vitraSpec.path("cgra_adg_filename").asText() shouldBe "vitra_cgra_adg.json"
    vitraSpec.path("cgra_iob_mode").asInt() shouldBe COND_LS_MODE
    VitraSpec.attrs("cgra_iob_mode") shouldBe SRAM_MODE
  }

  it should "audit truthful generated CSTORE operations and IOB capabilities" in {
    val (targetDir, summary) = firstGeneration
    val operations = readJson(targetDir.resolve("spec/operations.json")).path("Operations")
    val ioNames = operations.elements().asScala
      .map(_.path("name").asText())
      .filter(Set("INPUT", "OUTPUT", "LOAD", "STORE", "CLOAD", "CSTORE"))
      .toSet
    ioNames shouldBe Set("INPUT", "OUTPUT", "LOAD", "STORE", "CSTORE")

    val cstore = operations.elements().asScala.find(_.path("name").asText() == "CSTORE").value
    cstore.path("numOperands").asInt() shouldBe OpInfo.getOperandNum("CSTORE")
    cstore.path("numRes").asInt() shouldBe OpInfo.getResNum("CSTORE")
    cstore.path("OPC").asInt() shouldBe OpInfo.OPCMap("CSTORE")
    cstore.path("latency").asInt() shouldBe OpInfo.getLatency("CSTORE")
    summary.cstoreOpc shouldBe cstore.path("OPC").asInt()
    summary.cstoreLatency shouldBe cstore.path("latency").asInt()

    val iobs = readJson(targetDir.resolve("spec/vitra_cgra_adg.json"))
      .path("sub_modules").elements().asScala
      .filter(_.path("type").asText() == "IOB").toSeq
    iobs should not be empty
    iobs.size shouldBe summary.iobModuleCount
    iobs.foreach { iob =>
      val attrs = iob.path("attributes")
      attrs.path("operations").elements().asScala.map(_.asText()).toSet shouldBe ioNames
      attrs.path("num_operands").asInt() shouldBe 3
      attrs.path("num_input").asInt() shouldBe 6
      attrs.path("io_controller_cfg_id").path("IsStore").asInt() shouldBe 17
      attrs.path("io_controller_cfg_id").path("UseAddr").asInt() shouldBe 18
      attrs.path("io_controller_cfg_id").path("UseEn").asInt() shouldBe 19
    }
  }

  it should "trace the routed predicate through the generated RTL write gate" in {
    val rtl = Files.readString(firstGeneration._1.resolve("CGRAWithAXI.v"))

    rtl should include regex "input\\s+\\[15:0\\]\\s+io_in_2".r
    rtl should include("runtimePredicate = io_in_2[0]")
    rtl should include("writeAllowed = ~useEn | runtimePredicate")
    rtl should include("writeEnable = writeRequest & writeAllowed")
    rtl should include("io_sram_en_REG <= writeEnable | readIssue")
    rtl should include regex "(?s)if \\(writeEnable\\).*io_sram_we_REG <= 2'h3".r
  }

  it should "reproduce all four semantic JSON contracts in a second fresh directory" in {
    firstGeneration._2.semanticJsonSha256 shouldBe secondGeneration._2.semanticJsonSha256
  }

  private lazy val firstGeneration = generate("vitra-task4-cstore-first-")
  private lazy val secondGeneration = generate("vitra-task4-cstore-second-")

  private def generate(prefix: String): (java.nio.file.Path, CStoreArtifactSummary) = {
    val targetDir = Files.createTempDirectory(prefix)
    targetDir -> CStoreVerilogGen.generate(targetDir)
  }

  private def readJson(path: java.nio.file.Path): JsonNode = new ObjectMapper().readTree(path.toFile)

  private def iobModes(attrs: scala.collection.mutable.Map[String, Any]): Seq[Int] =
    attrs("cgra_iobs")
      .asInstanceOf[ListBuffer[ListBuffer[IobSpec]]]
      .flatten
      .map(_.mode)
      .toSeq
}
