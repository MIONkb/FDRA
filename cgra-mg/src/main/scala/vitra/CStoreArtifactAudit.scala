package tram.vitra

import java.nio.charset.StandardCharsets
import java.nio.file.{Files, Path, Paths}
import java.security.MessageDigest

import com.fasterxml.jackson.databind.{JsonNode, ObjectMapper}
import com.fasterxml.jackson.databind.node.{ArrayNode, ObjectNode}
import tram.common.MacroVar.COND_LS_MODE
import tram.op.OpInfo
import tram.vitra.dsa.MultiTileCgraParam
import tram.vitra.spec.VitraSpec

import scala.jdk.CollectionConverters._

case class CStoreArtifactSummary(
  targetDir: Path,
  fileSha256: Map[String, String],
  semanticJsonSha256: Map[String, String],
  cstoreOpc: Int,
  cstoreLatency: Int,
  iobModuleCount: Int)

case class CStoreArtifactProvenance(
  vitraCommit: String,
  chipyardCommit: String,
  fdraCommit: String,
  adoraCommit: String,
  adoraMapperParse: String)

object CStoreArtifactAudit {
  val generatorEntrypoint = "tram.vitra.CStoreVerilogGen"
  val generationCommand =
    "sbt -java-home /usr/lib/jvm/java-11-openjdk-amd64 -batch \"project fdra\" " +
      "\"runMain tram.vitra.CStoreVerilogGen -td <fresh-output>\""
  val requiredRelativePaths: Seq[String] = Seq(
    "CGRAWithAXI.v",
    "spec/vitra_spec.json",
    "spec/operations.json",
    "spec/vitra_cgra_adg.json",
    "spec/axilite_spec.json",
    LoopIndexContract.relativePath)
  val jsonRelativePaths: Seq[String] = requiredRelativePaths.filter(_.endsWith(".json"))
  val expectedIobOperations: Set[String] = Set("INPUT", "OUTPUT", "LOAD", "STORE", "CSTORE")

  private val mapper = new ObjectMapper()

  def validate(targetDir: Path): CStoreArtifactSummary = {
    // Standalone audit/manifest processes have not elaborated a CGRA yet. Build
    // the same parameter contract first so dynamic OPC and latency maps match
    // the production generator instead of depending on ambient JVM state.
    MultiTileCgraParam(VitraSpec.cstoreAttrs())
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
    auditLoopIndexContract(
      readJson(files(LoopIndexContract.relativePath)),
      operationEntries,
      adg)

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

  def writeManifest(
      summary: CStoreArtifactSummary,
      provenance: CStoreArtifactProvenance,
      output: Path): Unit = {
    require(Set("pass", "fail", "not_run").contains(provenance.adoraMapperParse),
      s"unsupported ADORA Mapper parse status: ${provenance.adoraMapperParse}")

    val root = mapper.createObjectNode()
    root.put("schema_version", 1)
    root.put("target", "vitra-cstore")

    val generator = root.putObject("generator")
    generator.put("entrypoint", generatorEntrypoint)
    generator.put("vitra_commit", provenance.vitraCommit)
    generator.put("command", generationCommand)

    val environment = root.putObject("environment")
    environment.put("chipyard_commit", provenance.chipyardCommit)
    environment.put("fdra_commit", provenance.fdraCommit)
    environment.put("adora_commit", provenance.adoraCommit)

    val contract = root.putObject("contract")
    contract.put("cstore_opc", summary.cstoreOpc)
    contract.put("cstore_latency", summary.cstoreLatency)
    contract.put("iob_module_count", summary.iobModuleCount)
    contract.put("predicate_word_semantics", "bit0")
    contract.put("cload_supported", false)
    contract.put("loop_index_contract", LoopIndexContract.relativePath)
    contract.put("acc_backpressure_supported", false)
    contract.put("physical_for_supported", false)

    val artifacts = root.putObject("artifacts")
    summary.fileSha256.toSeq.sortBy(_._1).foreach { case (relative, fileHash) =>
      val artifact = artifacts.putObject(relative)
      artifact.put("sha256", fileHash)
      summary.semanticJsonSha256.get(relative).foreach(artifact.put("semantic_sha256", _))
      artifact.put("checked_in", relative.endsWith(".json"))
    }

    val compatibility = root.putObject("consumer_compatibility")
    compatibility.put("adora_mapper_parse", provenance.adoraMapperParse)
    compatibility.put("trusted_capability_consumption", "blocked")
    compatibility.put(
      "blocker",
      "ADORA Mapper currently infers both CLOAD and CSTORE for every COND_LS_MODE IOB; " +
        "the truthful VITRA artifact intentionally omits unimplemented CLOAD")

    Option(output.getParent).foreach(parent => Files.createDirectories(parent))
    mapper.writerWithDefaultPrettyPrinter().writeValue(output.toFile, root)
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

  private def auditLoopIndexContract(
      contract: JsonNode,
      operationEntries: Seq[JsonNode],
      adg: JsonNode): Unit = {
    require(contract.path("schema_version").asInt(-1) == 1,
      "loop_index_contract.json schema_version must be 1")
    require(contract.path("data_width_bits").asInt(-1) == 16,
      "loop_index_contract.json must describe the 16-bit production datapath")
    require(!contract.path("backpressure_supported").asBoolean(true),
      "ACC enable must not be described as backpressure")
    require(contract.path("enable_semantics").asText() == "abort_reset_suppress",
      "ACC enable semantics must be abort/reset/suppress")
    require(!contract.path("physical_for_supported").asBoolean(true),
      "physical FOR must remain unsupported")

    Seq("ACC", "ASUB").foreach { name =>
      val operation = operationEntries.find(_.path("name").asText() == name)
        .getOrElse(throw new IllegalArgumentException(s"operations.json is missing $name"))
      val contractOperation = contract.path("operations").path(name)
      require(contractOperation.path("opcode").asInt(-1) == operation.path("OPC").asInt(-2),
        s"$name opcode differs between loop-index contract and operations.json")
      require(contractOperation.path("logical_operands").asInt(-1) == 1,
        s"$name loop-index contract must expose one logical operand")
    }

    val gpeAttrs = adg.path("sub_modules").elements().asScala
      .filter(_.path("type").asText() == "GPE")
      .map(_.path("attributes"))
      .find(_.path("operations").elements().asScala.exists(_.asText() == "ACC"))
      .getOrElse(throw new IllegalArgumentException("ADG has no ACC-capable GPE"))
    val ids = gpeAttrs.path("affine_ctrl_reg_cfg_id")
    val configuration = gpeAttrs.path("configuration")
    Seq("InitVal", "WI", "Latency", "Cycles", "Repeats", "SkipFirst").foreach { name =>
      val range = configuration.path(ids.path(name).asInt(-1).toString)
      val contractRange = contract.path("configuration_fields").path(name)
      require(range.isArray && range.path(0).asText() == name,
        s"ADG is missing affine field $name")
      require(contractRange.path("high").asInt(-1) == range.path(1).asInt(-2) &&
        contractRange.path("low").asInt(-1) == range.path(2).asInt(-2),
        s"$name range differs between loop-index contract and ADG")
    }
    require(contract.path("configuration_formula").path("Cycles").asText() == "trip_count",
      "loop-index Cycles formula must be trip_count")
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

object CStoreArtifactManifestGen {
  def main(args: Array[String]): Unit = {
    require(args.length == 7,
      "Usage: CStoreArtifactManifestGen <target-dir> <manifest-file> <vitra-commit> " +
        "<chipyard-commit> <fdra-commit> <adora-commit> <adora-mapper-parse-status>")
    val summary = CStoreArtifactAudit.validate(Paths.get(args(0)))
    val output = Paths.get(args(1))
    val provenance = CStoreArtifactProvenance(
      vitraCommit = args(2),
      chipyardCommit = args(3),
      fdraCommit = args(4),
      adoraCommit = args(5),
      adoraMapperParse = args(6))
    CStoreArtifactAudit.writeManifest(summary, provenance, output)
    println(s"CSTORE_MANIFEST path=$output")
  }
}
