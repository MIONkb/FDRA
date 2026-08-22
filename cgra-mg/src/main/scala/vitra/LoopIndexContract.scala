package tram.vitra

import java.nio.file.{Files, Path}

import com.fasterxml.jackson.databind.{JsonNode, ObjectMapper}
import com.fasterxml.jackson.databind.node.ObjectNode
import tram.op.OpInfo
import tram.vitra.dsa.MultiTileCgraParam
import tram.vitra.spec.VitraSpec

import scala.jdk.CollectionConverters._

object LoopIndexContract {
  val relativePath = "spec/loop_index_contract.json"
  private val requiredFields = Seq("InitVal", "WI", "Latency", "Cycles", "Repeats", "SkipFirst")
  private val mapper = new ObjectMapper()

  final case class ConfigField(high: Int, low: Int) {
    val width: Int = high - low + 1
  }

  def write(operationsPath: Path, adgPath: Path, output: Path): Path = {
    // Initialize the same dynamic operation map used by the production target.
    MultiTileCgraParam(VitraSpec.cstoreAttrs())
    val operationsRoot = readJson(operationsPath)
    val adg = readJson(adgPath)
    val operations = operationsRoot.path("Operations")
    require(operations.isArray, s"$operationsPath must contain an Operations array")
    require(!operations.elements().asScala.exists(_.path("name").asText() == "FOR"),
      "physical FOR must not appear in the production operation catalog")

    val operationEntries = Seq("ACC", "ASUB").map { name =>
      val entry = operations.elements().asScala.find(_.path("name").asText() == name)
        .getOrElse(throw new IllegalArgumentException(s"$operationsPath is missing $name"))
      require(entry.path("OPC").asInt(-1) == OpInfo.OPCMap(name),
        s"$name opcode differs from production OpInfo")
      require(entry.path("numOperands").asInt(-1) == 1, s"$name must have one logical operand")
      require(entry.path("numRes").asInt(-1) == 1, s"$name must have one result")
      require(entry.path("accumulative").asInt(-1) == 1, s"$name must be accumulative")
      name -> entry
    }.toMap

    val gpeAttrs = adg.path("sub_modules").elements().asScala
      .filter(_.path("type").asText() == "GPE")
      .map(_.path("attributes"))
      .filter(attrs => {
        val names = attrs.path("operations").elements().asScala.map(_.asText()).toSet
        names.contains("ACC") && names.contains("ASUB")
      }).toSeq
    require(gpeAttrs.nonEmpty, s"$adgPath has no production GPE supporting ACC and ASUB")

    val dataWidths = gpeAttrs.map(_.path("data_width").asInt(-1)).distinct
    require(dataWidths.size == 1 && dataWidths.head > 0, s"inconsistent GPE data widths: $dataWidths")
    val dataWidth = dataWidths.head
    val allFields = gpeAttrs.map(extractFields)
    require(allFields.distinct.size == 1, "ACC affine configuration fields differ across production GPE types")
    val fields = allFields.head
    val maximumTripCount = (BigInt(1) << fields("Cycles").width) - 1

    val root = mapper.createObjectNode()
    root.put("schema_version", 1)
    root.put("target", "vitra-cstore")
    root.put("logical_source", "affine.for induction value")
    root.put("physical_operation", "ACC")
    root.put("for_is_physical_operation", false)
    root.put("data_width", dataWidth)
    root.put("signedness", s"unsigned_${dataWidth}_bit_modular_bitvector")
    root.put("data_width_bits", dataWidth)
    root.put("index_arithmetic", s"unsigned_${dataWidth}_bit_modular_bitvector")
    root.put("backpressure_supported", false)
    root.put("enable_semantics", "abort_reset_suppress")
    root.put("physical_for_supported", false)

    val operationObject = root.putObject("operations")
    operationEntries.toSeq.sortBy(_._1).foreach { case (name, entry) =>
      val node = operationObject.putObject(name)
      node.put("opcode", entry.path("OPC").asInt())
      node.put("logical_operands", entry.path("numOperands").asInt())
      node.put("results", entry.path("numRes").asInt())
      node.put("latency", entry.path("latency").asInt())
      node.put("accumulative", true)
      node.put("alu_operation", OpInfo.getALUOp(name))
    }

    val fieldObject = root.putObject("configuration_fields")
    requiredFields.foreach { name =>
      val field = fields(name)
      val node = fieldObject.putObject(name)
      node.put("high", field.high)
      node.put("low", field.low)
      node.put("width", field.width)
    }

    val formula = root.putObject("configuration_formula")
    formula.put("operation", "ACC")
    formula.put("InitVal", s"lower_bound mod 2^$dataWidth")
    formula.put("routed_operand_0", s"positive_step mod 2^$dataWidth")
    formula.put("WI", 1)
    formula.put("Latency", 0)
    formula.put("Cycles", "trip_count")
    formula.put("Repeats", 1)
    formula.put("SkipFirst", 1)
    formula.put("output", s"(lower_bound + iteration * positive_step) mod 2^$dataWidth")
    val fieldSemantics = formula.putObject("field_semantics")
    fieldSemantics.put("WI", "launch intervals per accumulator update; one updates every data cycle")
    fieldSemantics.put("Latency", "AffineCtrlReg pre-data control cycles; not ALU output latency")
    fieldSemantics.put("Cycles", "accumulator update opportunities in each repeat group")
    fieldSemantics.put("Repeats", "cycle groups before returning idle; v1 fixes this to one")
    fieldSemantics.put("SkipFirst", "emit InitVal on the first update without applying routed_operand_0")

    val physicalPath = root.putObject("physical_path")
    physicalPath.put("feedback", "DualModeReg.out(1) to ALU.in(0)")
    physicalPath.put("routed_operand", "SharedDelayPipe.out(0) to ALU.in(1)")
    physicalPath.put("public_output", "DualModeReg.out(0) after the accumulator register update")
    physicalPath.put("ASUB_usage", "characterized subtract feedback operation; not supported by v1 negative-step lowering")

    val timing = root.putObject("timing")
    timing.put("start_pulse_to_first_output_cycles", 2)
    timing.put("output_interval_cycles", 1)
    timing.put("post_sequence_output", "holds_last_value_while_enabled")
    timing.put("enable_deassertion", "registered_abort_then_zero")

    val firstValue = root.putObject("first_value_timing")
    firstValue.put("cycles_after_gpe_start_assertion", 2)
    firstValue.put("value", "lower_bound")
    firstValue.put("reason", "one GPE start register followed by AffineCtrlReg entry into data state")

    val lastValue = root.putObject("last_value_behavior")
    lastValue.put("value", "lower_bound + (trip_count - 1) * positive_step")
    lastValue.put("state_after_last_value", "idle")
    lastValue.put("output_while_enabled", "holds_last_value")
    lastValue.put("next_start", "restarts_from_InitVal")

    val wraparound = root.putObject("wraparound")
    wraparound.put("arithmetic", s"modulo_2^$dataWidth")
    wraparound.put("hardware_behavior", "low data_width bits are retained")
    wraparound.put("supported_loop_subset", "logical wrap before the final iteration is rejected")

    val enableSemantics = root.putObject("execution_enable_semantics")
    enableSemantics.put("backpressure_supported", false)
    enableSemantics.put("en_zero", "abort_return_idle_and_zero_state")
    enableSemantics.put("en_zero_is_stall", false)
    enableSemantics.put("en_zero_is_pause", false)
    enableSemantics.put("normal_execution", "hold enable high from before start through the final value")

    root.put("byte_address_scaling", "external-explicit-arithmetic")
    root.put("byte_address_scaling_detail",
      "ACC emits a logical element index; ADORA CDFG/GPE arithmetic multiplies by element-byte-width")

    val subset = root.putObject("supported_loop_subset")
    subset.put("minimum_trip_count", 1)
    subset.put("maximum_trip_count", maximumTripCount.bigInteger)
    subset.put("lower_bound", s"unsigned $dataWidth-bit value")
    subset.put("positive_step", s"unsigned nonzero $dataWidth-bit value")
    subset.put("negative_step", false)
    subset.put("zero_trip_count", false)
    subset.put("logical_wrap_before_last_iteration", false)
    subset.put("ASUB_characterized_only", true)

    val evidence = root.putArray("evidence")
    evidence.add("src/main/scala/op/Operations.scala: ACC/ASUB dynamic operation definitions")
    evidence.add("src/main/scala/dsa/pe/PE.scala: routed operand, feedback, start, enable, and output path")
    evidence.add("src/main/scala/dsa/util/AffineCtrlReg.scala: affine fields, state transitions, and abort/reset semantics")
    evidence.add("src/test/scala/vitra/VitraLoopIndexAccSpec.scala: production GPE 0..15, nonzero lower bound/step, and abort proof")

    Option(output.getParent).foreach(Files.createDirectories(_))
    mapper.writerWithDefaultPrettyPrinter().writeValue(output.toFile, root)
    output
  }

  private def extractFields(attrs: JsonNode): Map[String, ConfigField] = {
    val ids = attrs.path("affine_ctrl_reg_cfg_id")
    val configuration = attrs.path("configuration")
    requiredFields.map { name =>
      val id = ids.path(name).asInt(-1)
      require(id >= 0, s"GPE is missing affine configuration id $name")
      val range = configuration.path(id.toString)
      require(range.isArray && range.size() == 3 && range.path(0).asText() == name,
        s"GPE configuration id $id does not describe $name")
      val field = ConfigField(range.path(1).asInt(-1), range.path(2).asInt(-1))
      require(field.low >= 0 && field.high >= field.low, s"invalid $name range: $field")
      name -> field
    }.toMap
  }

  private def readJson(path: Path): JsonNode = {
    require(Files.isRegularFile(path), s"missing JSON input: $path")
    mapper.readTree(path.toFile)
  }
}
