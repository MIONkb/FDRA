package tram.vitra

import java.nio.file.{Files, Path, Paths}
import java.security.MessageDigest

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
    error.getMessage should include("loop_index_contract.json")
  }

  it should "write machine-readable provenance without claiming trusted ADORA consumption" in {
    val targetDir = Files.createTempDirectory("vitra-task4-manifest-source-")
    val output = Files.createTempFile("vitra-task4-manifest-", ".json")
    val summary = CStoreArtifactSummary(
      targetDir = targetDir,
      fileSha256 = Map(
        "CGRAWithAXI.v" -> "a" * 64,
        "spec/operations.json" -> "b" * 64),
      semanticJsonSha256 = Map("spec/operations.json" -> "c" * 64),
      cstoreOpc = 4,
      cstoreLatency = 1,
      iobModuleCount = 8)
    val provenance = CStoreArtifactProvenance(
      vitraCommit = "vitra-sha",
      chipyardCommit = "chipyard-sha",
      fdraCommit = "fdra-sha",
      adoraCommit = "adora-sha",
      adoraMapperParse = "pass")

    CStoreArtifactAudit.writeManifest(summary, provenance, output)

    val manifest = readJson(output)
    manifest.path("schema_version").asInt() shouldBe 1
    manifest.path("generator").path("entrypoint").asText() shouldBe "tram.vitra.CStoreVerilogGen"
    manifest.path("generator").path("vitra_commit").asText() shouldBe "vitra-sha"
    manifest.path("environment").path("chipyard_commit").asText() shouldBe "chipyard-sha"
    manifest.path("environment").path("fdra_commit").asText() shouldBe "fdra-sha"
    manifest.path("environment").path("adora_commit").asText() shouldBe "adora-sha"
    manifest.path("artifacts").path("CGRAWithAXI.v").path("checked_in").asBoolean() shouldBe false
    manifest.path("artifacts").path("spec/operations.json").path("checked_in").asBoolean() shouldBe true
    manifest.path("artifacts").path("spec/operations.json").path("semantic_sha256").asText() shouldBe "c" * 64
    manifest.path("contract").path("loop_index_contract").asText() shouldBe LoopIndexContract.relativePath
    manifest.path("contract").path("acc_backpressure_supported").asBoolean() shouldBe false
    manifest.path("contract").path("physical_for_supported").asBoolean() shouldBe false
    manifest.path("consumer_compatibility").path("adora_mapper_parse").asText() shouldBe "pass"
    manifest.path("consumer_compatibility").path("trusted_capability_consumption").asText() shouldBe "blocked"
    manifest.path("consumer_compatibility").path("blocker").asText() should include("CLOAD")
  }

  it should "generate one complete audited bundle from the explicit CSTORE entrypoint" in {
    val (targetDir, summary) = firstGeneration

    summary.targetDir shouldBe targetDir
    summary.fileSha256.keySet shouldBe Set(
      "CGRAWithAXI.v",
      "spec/vitra_spec.json",
      "spec/operations.json",
      "spec/vitra_cgra_adg.json",
      "spec/axilite_spec.json",
      "spec/loop_index_contract.json")
    summary.fileSha256.values.foreach(_.length shouldBe 64)

    val vitraSpec = readJson(targetDir.resolve("spec/vitra_spec.json"))
    vitraSpec.path("operation_set_filename").asText() shouldBe "operations.json"
    vitraSpec.path("cgra_adg_filename").asText() shouldBe "vitra_cgra_adg.json"
    vitraSpec.path("cgra_iob_mode").asInt() shouldBe COND_LS_MODE
    VitraSpec.attrs("cgra_iob_mode") shouldBe SRAM_MODE

    val loopIndex = readJson(targetDir.resolve("spec/loop_index_contract.json"))
    loopIndex.path("operations").path("ACC").path("opcode").asInt() shouldBe OpInfo.OPCMap("ACC")
    loopIndex.path("configuration_formula").path("Cycles").asText() shouldBe "trip_count"
    loopIndex.path("backpressure_supported").asBoolean() shouldBe false
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

  it should "bind every checked-in JSON to the generated bundle and provenance manifest" in {
    val referenceDir = checkedInReferenceDir
    val manifest = readJson(referenceDir.resolve("manifest.json"))
    val generated = firstGeneration._2

    CStoreArtifactAudit.jsonRelativePaths.foreach { relative =>
      val filename = Paths.get(relative).getFileName.toString
      val checkedIn = referenceDir.resolve(filename)
      val manifestEntry = manifest.path("artifacts").path(relative)
      val checkedInHash = sha256(Files.readAllBytes(checkedIn))

      manifestEntry.path("checked_in").asBoolean() shouldBe true
      manifestEntry.path("sha256").asText() shouldBe checkedInHash
      generated.fileSha256(relative) shouldBe checkedInHash
    }
    manifest.path("artifacts").path("CGRAWithAXI.v").path("checked_in").asBoolean() shouldBe false
  }

  it should "reproduce all five semantic JSON contracts in a second fresh directory" in {
    firstGeneration._2.semanticJsonSha256 shouldBe secondGeneration._2.semanticJsonSha256
  }

  private lazy val firstGeneration = generate("vitra-task4-cstore-first-")
  private lazy val secondGeneration = generate("vitra-task4-cstore-second-")

  private def generate(prefix: String): (java.nio.file.Path, CStoreArtifactSummary) = {
    val targetDir = Files.createTempDirectory(prefix)
    targetDir -> CStoreVerilogGen.generate(targetDir)
  }

  private def readJson(path: java.nio.file.Path): JsonNode = new ObjectMapper().readTree(path.toFile)

  private def checkedInReferenceDir: Path = {
    val candidates = Seq(
      Paths.get("src/main/vitra_spec/cstore"),
      Paths.get("cgra-mg/src/main/vitra_spec/cstore"),
      Paths.get("generators/fdra/cgra-mg/src/main/vitra_spec/cstore"))
    candidates.find(path => Files.isRegularFile(path.resolve("manifest.json")))
      .getOrElse(fail(s"cannot locate checked-in CSTORE reference from ${Paths.get(".").toAbsolutePath}"))
  }

  private def sha256(bytes: Array[Byte]): String =
    MessageDigest.getInstance("SHA-256").digest(bytes).map("%02x".format(_)).mkString

  private def iobModes(attrs: scala.collection.mutable.Map[String, Any]): Seq[Int] =
    attrs("cgra_iobs")
      .asInstanceOf[ListBuffer[ListBuffer[IobSpec]]]
      .flatten
      .map(_.mode)
      .toSeq
}
