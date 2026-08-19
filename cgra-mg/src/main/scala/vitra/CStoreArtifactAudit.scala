package tram.vitra

import java.nio.charset.StandardCharsets
import java.nio.file.{Files, Path}
import java.security.MessageDigest

import com.fasterxml.jackson.databind.{JsonNode, ObjectMapper}
import com.fasterxml.jackson.databind.node.{ArrayNode, ObjectNode}
import tram.common.MacroVar.COND_LS_MODE
import tram.op.OpInfo

import scala.jdk.CollectionConverters._

case class CStoreArtifactSummary(
  targetDir: Path,
  fileSha256: Map[String, String],
  semanticJsonSha256: Map[String, String],
  cstoreOpc: Int,
  cstoreLatency: Int,
  iobModuleCount: Int)

object CStoreArtifactAudit {
  val requiredRelativePaths: Seq[String] = Seq(
    "CGRAWithAXI.v",
    "spec/vitra_spec.json",
    "spec/operations.json",
    "spec/vitra_cgra_adg.json",
    "spec/axilite_spec.json")
  val jsonRelativePaths: Seq[String] = requiredRelativePaths.filter(_.endsWith(".json"))
  val expectedIobOperations: Set[String] = Set("INPUT", "OUTPUT", "LOAD", "STORE", "CSTORE")

  private val mapper = new ObjectMapper()

  def validate(targetDir: Path): CStoreArtifactSummary = {
    val files = requiredRelativePaths.map(relative => relative -> targetDir.resolve(relative)).toMap
    val missing = files.collect { case (relative, path) if !Files.isRegularFile(path) => relative }.toSeq.sorted
    require(missing.isEmpty, s"incomplete CSTORE artifact bundle; missing: ${missing.mkString(", ")}")
    files.foreach { case (relative, path) =>
      require(Files.size(path) > 0, s"empty CSTORE artifact: $relative")
    }

    val vitraSpec = readJson(files("spec/vitra_spec.json"))
    require(vitraSpec.path("cgra_iob_mode").asInt(-1) == COND_LS_MODE,
      "vitra_spec.json must select COND_LS_MODE")
    require(vitraSpec.path("operation_set_filename").asText() == "operations.json",
      "vitra_spec.json operation_set_filename must be portable")
    require(vitraSpec.path("cgra_adg_filename").asText() == "vitra_cgra_adg.json",
      "vitra_spec.json cgra_adg_filename must be portable")

    val operations = readJson(files("spec/operations.json")).path("Operations")
    require(operations.isArray, "operations.json must contain an Operations array")
    val operationEntries = operations.elements().asScala.toSeq
    val ioOperations = operationEntries.map(_.path("name").asText())
      .filter(Set("INPUT", "OUTPUT", "LOAD", "STORE", "CLOAD", "CSTORE"))
      .toSet
    require(ioOperations == expectedIobOperations,
      s"IO operation catalog must be exactly ${expectedIobOperations.toSeq.sorted.mkString(",")}; got ${ioOperations.toSeq.sorted.mkString(",")}")
    val cstore = operationEntries.find(_.path("name").asText() == "CSTORE")
      .getOrElse(throw new IllegalArgumentException("operations.json is missing CSTORE"))
    require(cstore.path("numOperands").asInt(-1) == OpInfo.getOperandNum("CSTORE"),
      "CSTORE numOperands does not match generator OpInfo")
    require(cstore.path("numRes").asInt(-1) == OpInfo.getResNum("CSTORE"),
      "CSTORE numRes does not match generator OpInfo")
    require(cstore.path("latency").asInt(-1) == OpInfo.getLatency("CSTORE"),
      "CSTORE latency does not match generator OpInfo")
    val cstoreOpc = cstore.path("OPC").asInt(-1)
    require(OpInfo.OPCMap.get("CSTORE").contains(cstoreOpc),
      "CSTORE OPC does not match generator OpInfo")

    val adg = readJson(files("spec/vitra_cgra_adg.json"))
    val iobs = adg.path("sub_modules").elements().asScala
      .filter(_.path("type").asText() == "IOB").toSeq
    require(iobs.nonEmpty, "ADG must contain at least one IOB module")
    iobs.foreach(auditIob)
    auditTopLevelIobInputs(adg, iobs)

    val rtl = Files.readString(files("CGRAWithAXI.v"), StandardCharsets.UTF_8)
    val rtlRequirements = Seq(
      "(?m)input\\s+\\[15:0\\]\\s+io_in_2".r -> "conditional controller input 2",
      "runtimePredicate = io_in_2\\[0\\]".r -> "bit-zero runtime predicate",
      "writeAllowed = ~useEn \\| runtimePredicate".r -> "UseEn write permission",
      "writeEnable = writeRequest & writeAllowed".r -> "gated write issue",
      "io_sram_en_REG <= writeEnable \\| readIssue".r -> "gated SRAM enable",
      "(?s)if \\(writeEnable\\).*io_sram_we_REG <= 2'h3".r -> "gated SRAM write mask")
    rtlRequirements.foreach { case (pattern, description) =>
      require(pattern.findFirstIn(rtl).nonEmpty, s"generated RTL is missing $description")
    }

    val fileSha256 = files.map { case (relative, path) => relative -> sha256(Files.readAllBytes(path)) }
    val semanticJsonSha256 = jsonRelativePaths.map { relative =>
      relative -> sha256(mapper.writeValueAsBytes(canonical(readJson(files(relative)))))
    }.toMap
    CStoreArtifactSummary(
      targetDir = targetDir,
      fileSha256 = fileSha256,
      semanticJsonSha256 = semanticJsonSha256,
      cstoreOpc = cstoreOpc,
      cstoreLatency = cstore.path("latency").asInt(),
      iobModuleCount = iobs.size)
  }

  private def auditIob(module: JsonNode): Unit = {
    val attrs = module.path("attributes")
    val operations = attrs.path("operations").elements().asScala.map(_.asText()).toSet
    require(operations == expectedIobOperations, s"IOB capability mismatch: $operations")
    require(attrs.path("iob_mode").asInt(-1) == COND_LS_MODE, "IOB mode must be conditional")
    require(attrs.path("num_operands").asInt(-1) == 3, "conditional IOB must have 3 operands")
    require(attrs.path("num_input").asInt(-1) == 6, "conditional IOB must have 6 physical inputs")
    val controllerIds = attrs.path("io_controller_cfg_id")
    val isStoreId = controllerIds.path("IsStore").asInt(-1)
    val useAddrId = controllerIds.path("UseAddr").asInt(-1)
    val useEnId = controllerIds.path("UseEn").asInt(-1)
    require(isStoreId == 17, s"IsStore config ID must be 17; got $isStoreId")
    require(useAddrId == 18, s"UseAddr config ID must be 18; got $useAddrId")
    require(useEnId == 19, s"UseEn config ID must be 19; got $useEnId")
    require(attrs.path("configuration").path(isStoreId.toString).path(0).asText() == "IsStore",
      "IsStore configuration entry is missing")
    require(attrs.path("configuration").path(useAddrId.toString).path(0).asText() == "UseAddr",
      "UseAddr configuration entry is missing")
    val useEnRange = attrs.path("configuration").path(useEnId.toString)
    require(useEnRange.isArray && useEnRange.size() == 3 &&
      useEnRange.path(0).asText() == "UseEn" &&
      useEnRange.path(1).asInt(-1) == 127 && useEnRange.path(2).asInt(-1) == 127,
      "UseEn must occupy aggregate IOB bit 127")

    val connections = attrs.path("connections").elements().asScala.toSeq
    (0 until 3).foreach { operand =>
      val muxToDelay = connections.find { edge =>
        edge.path(1).asText() == "Muxn" && edge.path(4).asText() == "DelayPipe" &&
          edge.path(5).asInt(-1) == operand
      }.getOrElse(throw new IllegalArgumentException(s"operand $operand lacks mux-to-delay connection"))
      val muxId = muxToDelay.path(0).asInt()
      val physicalInputs = connections.filter { edge =>
        edge.path(1).asText() == "This" && edge.path(3).asInt(-1) == muxId &&
          edge.path(4).asText() == "Muxn"
      }.map(_.path(2).asInt()).toSet
      require(physicalInputs == Set(operand * 2, operand * 2 + 1),
        s"operand $operand physical inputs are $physicalInputs")
      require(connections.exists { edge =>
        edge.path(1).asText() == "DelayPipe" && edge.path(2).asInt(-1) == operand &&
          edge.path(4).asText() == "IOController" && edge.path(5).asInt(-1) == operand
      }, s"operand $operand lacks delay-to-controller connection")
    }
  }

  private def auditTopLevelIobInputs(adg: JsonNode, iobModules: Seq[JsonNode]): Unit = {
    val iobModuleIds = iobModules.map(_.path("id").asInt()).toSet
    val iobInstances = adg.path("instances").elements().asScala
      .filter(instance => instance.path("type").asText() == "IOB" &&
        iobModuleIds.contains(instance.path("module_id").asInt())).toSeq
    require(iobInstances.nonEmpty, "ADG must instantiate conditional IOB modules")
    val connections = adg.path("connections").elements().asScala.toSeq
    iobInstances.foreach { instance =>
      val instanceId = instance.path("id").asInt()
      val inputPorts = connections.filter { edge =>
        edge.path(3).asInt(-1) == instanceId && edge.path(4).asText() == "IOB"
      }.map(_.path(5).asInt()).toSet
      require(inputPorts == (0 until 6).toSet,
        s"IOB instance $instanceId top-level input ports are $inputPorts")
    }
  }

  private def readJson(path: Path): JsonNode = mapper.readTree(path.toFile)

  private def canonical(node: JsonNode): JsonNode = {
    if (node.isObject) {
      val result: ObjectNode = mapper.createObjectNode()
      node.fieldNames().asScala.toSeq.sorted.foreach { name =>
        result.set[JsonNode](name, canonical(node.get(name)))
      }
      result
    } else if (node.isArray) {
      val result: ArrayNode = mapper.createArrayNode()
      node.elements().asScala.foreach(value => result.add(canonical(value)))
      result
    } else {
      node.deepCopy[JsonNode]()
    }
  }

  private def sha256(bytes: Array[Byte]): String =
    MessageDigest.getInstance("SHA-256").digest(bytes).map("%02x".format(_)).mkString
}
