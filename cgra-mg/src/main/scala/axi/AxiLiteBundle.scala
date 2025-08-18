package tram.axi
import tram._

import chisel3._
import chisel3.util._

import org.chipsalliance.cde.config._
import scala.collection.mutable 

import freechips.rocketchip.tile._
//import freechips.rocketchip.config._
import freechips.rocketchip.rocket._
import freechips.rocketchip.amba.axi4._
import freechips.rocketchip.amba.axi4.{AXI4BundleParameters, AXI4Bundle}

/**
  * AXI-Lite AW channel
  */
class AXILiteBundleAW(params: AXI4BundleParameters) extends AXI4BundleBase(params) {
  val addr = UInt(params.addrBits.W) // Address
  val prot = UInt(params.protBits.W) // Protection type
}

/**
  * AXI-Lite W channel
  */
class AXILiteBundleW(params: AXI4BundleParameters) extends AXI4BundleBase(params) {
  val data = UInt(params.dataBits.W) // Write data
  val strb = UInt((params.dataBits / 8).W) // Write strobe
}

/**
  * AXI-Lite B channel
  */
class AXILiteBundleB(params: AXI4BundleParameters) extends AXI4BundleBase(params) {
  val resp = UInt(params.respBits.W) // Write response
}

/**
  * AXI-Lite AR channel
  */
class AXILiteBundleAR(params: AXI4BundleParameters) extends AXI4BundleBase(params) {
  val addr = UInt(params.addrBits.W) // Address
  val prot = UInt(params.protBits.W) // Protection type
}

/**
  * AXI-Lite R channel
  */
class AXILiteBundleR(params: AXI4BundleParameters) extends AXI4BundleBase(params) {
  val data = UInt(params.dataBits.W) // Read data
  val resp = UInt(params.respBits.W) // Read response
}

/**
  * AXI-Lite protocol bundle
  */
class AXILiteBundle(params: AXI4BundleParameters) extends AXI4BundleBase(params) {
  val aw = Irrevocable(new AXILiteBundleAW(params)) // Write address channel
  val w  = Irrevocable(new AXILiteBundleW(params))  // Write data channel
  val b  = Flipped(Irrevocable(new AXILiteBundleB(params))) // Write response channel
  val ar = Irrevocable(new AXILiteBundleAR(params)) // Read address channel
  val r  = Flipped(Irrevocable(new AXILiteBundleR(params))) // Read data channel
}

object AXILiteBundle {
  def apply(params: AXI4BundleParameters) = new AXILiteBundle(params)
}