package tram.vitra

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers

class VitraTileStateCtrlSpec extends AnyFlatSpec with Matchers with ChiselScalatestTester {
  behavior of "Vitra tile execution completion tracking"

  it should "retain completion dependencies above the IOB mask width" in {
    test(new TileStateCtrl(numIOB = 6, numTiles = 8)) { dut =>
      dut.io.exeIobEnReq.getWidth shouldBe 6
      dut.io.exeTileEnReq.getWidth shouldBe 8
      dut.io.exeDoneIn.getWidth shouldBe 8

      dut.io.cfgStartReq.poke(false.B)
      dut.io.cfgDoneIn.poke(true.B)
      dut.io.exeStartReq.poke(false.B)
      dut.io.exeIobEnReq.poke(0.U)
      dut.io.exeTileEnReq.poke(0.U)
      dut.io.exeDoneIn.poke(0.U)
      dut.clock.step(2)

      dut.io.exeStartReq.poke(true.B)
      dut.io.exeTileEnReq.poke((BigInt(1) << 7).U)
      dut.clock.step()

      dut.io.exeStartReq.poke(false.B)
      dut.clock.step()
      dut.io.exeEn.expect(true.B)
      dut.io.exeDone.expect(false.B)

      dut.io.exeDoneIn.poke("h7f".U)
      dut.clock.step()
      dut.io.exeEn.expect(true.B)
      dut.io.exeDone.expect(false.B)

      dut.io.exeDoneIn.poke("hff".U)
      dut.clock.step()
      dut.io.exeEn.expect(false.B)
      dut.io.exeDone.expect(true.B)
    }
  }
}
