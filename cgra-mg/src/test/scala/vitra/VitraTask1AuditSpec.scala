package tram.vitra

import java.nio.file.{Files, Paths}

import chisel3.stage.ChiselStage
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import tram.common.MacroVar.{COND_LS_MODE, SRAM_MODE}
import tram.dsa.IOController
import tram.vitra.dsa.MultiTileCGRA
import tram.vitra.spec.{IobSpec, VitraSpec}

import scala.collection.mutable.ListBuffer

class VitraTask1AuditSpec extends AnyFlatSpec with Matchers {
  behavior of "Vitra metadata output routing"

  it should "derive all metadata files from the short target-directory option" in {
    val targetDir = Files.createTempDirectory("vitra-task1-short-")

    VitraParam.targetDirFromArgs(Seq("-td", targetDir.toString)) shouldBe targetDir
    val paths = VitraParam.metadataPathsFor(targetDir)

    paths.specDirectory shouldBe targetDir.resolve("spec")
    paths.vitraSpec shouldBe targetDir.resolve("spec/vitra_spec.json")
    paths.operationSet shouldBe targetDir.resolve("spec/operations.json")
    paths.cgraAdg shouldBe targetDir.resolve("spec/vitra_cgra_adg.json")
    paths.axiLiteSpec shouldBe targetDir.resolve("spec/axilite_spec.json")
  }

  it should "accept the long target-directory option and create its spec directory" in {
    val targetDir = Files.createTempDirectory("vitra-task1-target-").resolve("nested")

    VitraParam.targetDirFromArgs(Seq("--target-dir", targetDir.toString)) shouldBe targetDir
    val paths = VitraParam.metadataPathsFor(targetDir)

    Files.isDirectory(paths.specDirectory) shouldBe true
  }

  it should "use a portable current-directory default when no target directory is supplied" in {
    val targetDir = VitraParam.targetDirFromArgs(Seq.empty)

    targetDir shouldBe Paths.get(".")
  }

  it should "configure the ADG dump flag independently from the operation-set flag" in {
    val savedAttrs = VitraSpec.attrs.clone()
    val paths = VitraParam.metadataPathsFor(Files.createTempDirectory("vitra-task1-flags-"))

    try {
      VitraParam.configureMetadata(paths, operationSetEnabled = false, adgEnabled = true)

      VitraSpec.attrs("dumpOperationSet") shouldBe false
      VitraSpec.attrs("dumpADG") shouldBe true
    } finally {
      restoreAttrs(savedAttrs)
    }
  }

  it should "route no-SRAM AXI-lite metadata through its command-line target directory" in {
    val savedAttrs = VitraSpec.attrs.clone()
    val targetDir = Files.createTempDirectory("vitra-task1-no-sram-")

    try {
      VitraSpec.attrs("dumpOperationSet") = false
      VitraSpec.attrs("dumpADG") = false

      VerilogGenWithoutSRAM.main(Array("-td", targetDir.toString))

      Files.isRegularFile(targetDir.resolve("spec/axilite_spec.json")) shouldBe true
    } finally {
      restoreAttrs(savedAttrs)
    }
  }

  behavior of "Vitra IOB elaboration"

  it should "elaborate the smallest stable SRAM_MODE controller baseline" in {
    val targetDir = Files.createTempDirectory("vitra-task1-sram-")
    val chirrtl = (new ChiselStage).emitChirrtl(
      new IOController(
        dataWidth = 16,
        addrWidth = 12,
        hasMask = true,
        mode = SRAM_MODE,
        lgMaxII = 4,
        lgMaxLat = 6,
        lgMaxStride = 13,
        lgMaxCycles = 12,
        agNestLevels = 4,
        addRegSram = 2),
      Array("--target-dir", targetDir.toString))

    chirrtl should include("module IOController")
  }

  it should "record the current COND_LS_MODE elaboration failure without claiming support" in {
    val savedAttrs = VitraSpec.attrs.clone()
    val targetDir = Files.createTempDirectory("vitra-task1-cond-ls-")

    try {
      val currentIobs = VitraSpec.attrs("cgra_iobs")
        .asInstanceOf[ListBuffer[ListBuffer[IobSpec]]]
      val conditionalIobs = currentIobs.map { row =>
        row.map(spec => spec.copy(mode = COND_LS_MODE))
      }

      VitraSpec.attrs("cgra_iob_mode") = COND_LS_MODE
      VitraSpec.attrs("cgra_iobs") = conditionalIobs
      VitraSpec.attrs("dumpOperationSet") = false
      VitraSpec.attrs("dumpADG") = false

      val failure = intercept[Throwable] {
        (new ChiselStage).emitChirrtl(
          new MultiTileCGRA(VitraSpec.attrs),
          Array("--target-dir", targetDir.toString))
      }
      val firstUserFrame = failure.getStackTrace.find { frame =>
        frame.getClassName.startsWith("tram.") &&
          !frame.getClassName.startsWith("tram.vitra.VitraTask1AuditSpec")
      }

      withClue(s"COND_LS_MODE first user-code frame was $firstUserFrame; CLOAD is not claimed working: ") {
        failure.getClass shouldBe classOf[IndexOutOfBoundsException]
        failure.getMessage shouldBe "2"
        firstUserFrame.map(_.getClassName) shouldBe Some("tram.dsa.IOB")
        firstUserFrame.map(_.getMethodName) shouldBe Some("$anonfun$new$6")
        firstUserFrame.map(_.getFileName) shouldBe Some("IOB.scala")
        firstUserFrame.map(_.getLineNumber) shouldBe Some(132)
      }
    } finally {
      restoreAttrs(savedAttrs)
    }
  }

  private def restoreAttrs(savedAttrs: scala.collection.mutable.Map[String, Any]): Unit = {
    VitraSpec.attrs.clear()
    VitraSpec.attrs ++= savedAttrs
  }
}
