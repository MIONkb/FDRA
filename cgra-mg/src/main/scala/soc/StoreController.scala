package tram

import chisel3._
import chisel3.util._
import freechips.rocketchip.tile._
//import freechips.rocketchip.config._
import org.chipsalliance.cde.config._
import freechips.rocketchip.rocket._
import TramISA._

/** Store controller, transfer data from local scratchpad (physical address) to remote memory (virtual address)
  * @param spadAddrWidth  scratchpad address width, <= 32
  * @param lgMaxDataLen   log2(the max data length in one DMA request)
  * @param busDataWidth      bus data width in bits
  * @param hasMask        if has mask signal in the stream interface
  * @param idWidth        width of the ID for a DMA request
  * @param streamQueDepth stream queue depth, can be zero
  */
class StoreController(spadAddrWidth: Int, lgMaxDataLen: Int, busDataWidth: Int, customerDataWidth: Int, hasMask: Boolean, idWidth: Int, streamQueDepth: Int)
                    (implicit p: Parameters) extends CoreModule {
  val io = IO(new Bundle {
    val core = new CoreIF(idWidth)
    val dma = Flipped(new DMAStreamWriteIF(lgMaxDataLen, busDataWidth, hasMask, idWidth))
    val spad = Flipped(new SpadStreamReadIF(spadAddrWidth, lgMaxDataLen, busDataWidth, hasMask, idWidth))
  })

  // println("hasMask:", hasMask)

  val dataByte = busDataWidth/8
  val s_idle :: s_spad_req :: s_dma_req :: s_spad_prepare :: s_stream :: s_last_data :: s_exp :: s_resp :: Nil = Enum(8)
  val state = RegInit(s_idle)
  val remote_addr = RegInit(0.U(coreMaxAddrBits.W)) // remote DRAM virtual address
  // val request_addr = Cat(rs1.remote_addr(coreMaxAddrBits - 1, log2Ceil(busDataWidth/8)), 0.U(log2Ceil(busDataWidth/8).toInt.W))

  val spad_addr = RegInit(0.U(spadAddrWidth.W)) // scratchpad address from rs1
  val leftLen = RegInit(0.U(lgMaxDataLen.W)) // left data length
  val status = Reg(new MStatus)
  val id = RegInit(0.U(idWidth.W))
  val success = RegInit(true.B)
  val rs1 = io.core.req.bits.cmd.rs1.asTypeOf(new StoreRs1)
  val rs2 = io.core.req.bits.cmd.rs2.asTypeOf(new StoreRs2)

  // Mion Lou add:
  //// Use a buffer to align the data transfer between SPAD interface and bus width
  val dma_needed_len = RegInit(0.U(lgMaxDataLen.W)) // total data length for dma request
  val spad_request_len = RegInit(0.U(lgMaxDataLen.W)) // total data length for spad 

  val bias_element_num_wire = rs1.remote_addr(log2Ceil(busDataWidth/8) - 1, log2Ceil(customerDataWidth/8))
  val bias_element_num = RegInit(0.U(log2Ceil(busDataWidth/customerDataWidth) .W))
  val shift_element_num = Fill(log2Ceil(busDataWidth/customerDataWidth), 1.U) - bias_element_num + 1.U
  val shift_bits = Cat(shift_element_num, 0.U(log2Ceil(customerDataWidth).W)) // the bias to bus transfer

  val last_spad_stream_element_num_wire = rs2.total_len(log2Ceil(busDataWidth/customerDataWidth) - 1 + log2Ceil(customerDataWidth/8), log2Ceil(customerDataWidth/8))

  require(bias_element_num_wire.getWidth == last_spad_stream_element_num_wire.getWidth)

  val elements_buffer = RegInit(0.U((busDataWidth).W))
  val elements_queue = Wire(UInt((2 * busDataWidth).W))
  val elements_queue_shift = Wire(UInt((2 * busDataWidth).W))

  // val spad_data := Mux(state =/= s_last_data, 0.U, io.spad.stream.bits.data)
  elements_queue := Cat(io.spad.stream.bits.data, elements_buffer) 
  elements_queue_shift := (elements_queue >>  shift_bits) // address space grows upwards  

  //// mask is also needed to be queued
  val mask_buffer = RegNext(io.spad.stream.bits.mask)
  val mask_queue = Cat(io.spad.stream.bits.mask, mask_buffer) 
  val mask_shift_bits = Cat(shift_element_num, 0.U(log2Ceil(customerDataWidth/8).W))
  val mask_queue_shift = mask_queue >> mask_shift_bits

  //// Note by Mion Lou:
  //// For data block store operation with bias, there are 3 conditions
  ////  1. dma bias exists, but spad_request_len is aligned to bus_num(such as 4 elements). 
  ////     In this case, leftLen is initialized as spad_request_len + extra_byte.
  ////  2. dma bias exists, but spad_request_len is not aligned to bus width, and bias_num + spad_request_len%bus_width < bus_num.
  ////     In this case, leftLen is initialized as spad_request_len.
  ////  3. dma bias exists, but spad_request_len is not aligned to bus width, and bias_num + spad_request_len%bus_width > bus_num.
  ////     In this case, leftLen is initialized as spad_request_len  + extra_byte.
  val extra_Len = (bias_element_num_wire =/= 0.U & last_spad_stream_element_num_wire === 0.U) |
           (Cat(0.B, bias_element_num_wire) + Cat(0.B, last_spad_stream_element_num_wire)) > Cat(1.B, 0.U(log2Ceil(busDataWidth/customerDataWidth).W))
  val extraLen_reg = RegInit(0.B)
  switch(state){
    is(s_idle){
      when(io.core.req.fire){
        state := s_spad_req
        // remote_addr := rs1.remote_addr
        // remote_addr := Cat(rs1.remote_addr(coreMaxAddrBits - 1, log2Ceil(busDataWidth/8)), 0.U(log2Ceil(busDataWidth/8).toInt.W))
        remote_addr := Cat(rs1.remote_addr(coreMaxAddrBits - 1, log2Ceil(busDataWidth/8)), 0.U(log2Ceil(busDataWidth/8).toInt.W))
        bias_element_num := bias_element_num_wire
        extraLen_reg := extra_Len
        // dma_needed_len := Mux(bias_element_num_wire === 0.U, rs2.total_len, rs2.total_len + dataByte.U)
        dma_needed_len := Mux(extra_Len === true.B, rs2.total_len + dataByte.U, rs2.total_len)      
        spad_request_len := rs2.total_len

        spad_addr := rs2.spad_addr
        leftLen := Mux(extra_Len === true.B, rs2.total_len + dataByte.U, rs2.total_len)   
        
        status := io.core.req.bits.cmd.status
        id := io.core.req.bits.id
        success := true.B
      }
    }
    is(s_spad_req){
      when(io.spad.req.fire){
        state := s_dma_req
      }
    }
    is(s_dma_req){
      when(io.dma.req.fire){
        state := s_spad_prepare
      }
    }


    //Mion Lou add
    is(s_spad_prepare){
      when(io.spad.stream.fire){
        state := s_stream
        elements_buffer := io.spad.stream.bits.data
        // leftLen := Mux(bias_element_num === 0.U, leftLen - dataByte.U , leftLen)
        leftLen := leftLen - dataByte.U
      }
    }

    is(s_stream){
      when(io.dma.exp.req){
        state := s_exp
        success := false.B
      }.elsewhen(io.spad.stream.fire){
        elements_buffer := io.spad.stream.bits.data
        leftLen := leftLen - dataByte.U
        state := Mux(leftLen <= dataByte.U, s_last_data, s_stream)
      }
      .elsewhen(!io.spad.stream.fire & extraLen_reg === true.B){
        /// @jhlou : Is this right?
        elements_buffer := elements_buffer
        leftLen := leftLen
        state := Mux(leftLen < dataByte.U, s_last_data, s_stream)
      }
    }

    //Mion Lou add
    is(s_last_data){
      elements_buffer := elements_buffer  
      when(extraLen_reg === false.B){
        state := s_resp
      }.elsewhen(io.dma.stream.fire){
        /// The last data need to be transfered when bias_element_num =/= 0
        state := s_resp
      }
    }

    is(s_exp){
      when(io.spad.exp.ack){
        state := s_resp
      }
    }
    is(s_resp){
      when(io.core.resp.fire){
        state := s_idle
      }
    }
  }

  io.core.req.ready := (state === s_idle)
  // Scratchpad request
  io.spad.req.valid := (state === s_spad_req)
  io.spad.req.bits.addrs(0) := spad_addr
  io.spad.req.bits.len := spad_request_len
  io.spad.req.bits.id := id
  // DMA request
  io.dma.req.valid := (state === s_dma_req)
  io.dma.req.bits.addr := remote_addr
  io.dma.req.bits.len := dma_needed_len
  io.dma.req.bits.id := id
  io.dma.req.bits.status := status

  // data stream
  if(streamQueDepth == 0){
    io.spad.stream.ready := io.dma.stream.ready && (state === s_stream || state === s_spad_prepare || (bias_element_num =/= 0.U & state === s_last_data))
    // io.spad.stream.ready := output.dma.stream.ready && (state === s_stream | state === s_spad_prepare)

    io.dma.stream.valid := (io.spad.stream.valid && (state === s_stream || state === s_spad_prepare )) || (bias_element_num =/= 0.U & state === s_last_data)
    // io.dma.stream.valid := output.dma.stream.valid && (state === s_stream | state === s_spad_prepare)
    // io.dma.stream.bits := io.spad.stream.bits
    io.dma.stream.bits.id := io.spad.stream.bits.id
    io.dma.stream.bits.data := Mux(bias_element_num === 0.U, io.spad.stream.bits.data, elements_queue_shift(busDataWidth - 1, 0))
    io.dma.stream.bits.last := io.spad.stream.bits.last
    
    io.dma.stream.bits.mask := Mux(bias_element_num =/= 0.U, 
                                  mask_queue_shift(dataByte - 1, 0), 
                                  io.spad.stream.bits.mask)
    switch(state){
      is(s_spad_prepare){
        io.dma.stream.bits.mask := Mux(bias_element_num =/= 0.U, 
                                  ~((1.U << (bias_element_num << log2Ceil(customerDataWidth/8))) - 1.U), 
                                  io.spad.stream.bits.mask)
      }
      is(s_last_data){
        io.dma.stream.bits.mask := Mux(bias_element_num =/= 0.U, 
                                  (1.U << (bias_element_num << log2Ceil(customerDataWidth/8))) - 1.U, 
                                  io.spad.stream.bits.mask)
      }
    }
  }else{
    val que = Module(new Queue(new DMAStream(busDataWidth, hasMask, idWidth), streamQueDepth,
      false, false, false, true))
    io.spad.stream.ready := que.io.enq.ready && (state === s_stream || state === s_spad_prepare)
    que.io.enq.valid := (io.spad.stream.valid && (state === s_stream || state === s_spad_prepare )) || (bias_element_num =/= 0.U & state === s_last_data)
    // que.io.enq.bits := io.spad.stream.bits

    que.io.enq.bits.id := io.spad.stream.bits.id
    que.io.enq.bits.data := Mux(bias_element_num === 0.U, io.spad.stream.bits.data, elements_queue_shift(busDataWidth - 1, 0))
    que.io.enq.bits.last := io.spad.stream.bits.last

    que.io.enq.bits.mask := Mux(bias_element_num =/= 0.U, 
                                  mask_queue_shift(dataByte - 1, 0), 
                                  io.spad.stream.bits.mask)
    switch(state){
      is(s_spad_prepare){
        que.io.enq.bits.mask := Mux(bias_element_num =/= 0.U, 
                                  ~((1.U << (bias_element_num << log2Ceil(customerDataWidth/8))) - 1.U), 
                                  io.spad.stream.bits.mask)
      }
      is(s_last_data){
        que.io.enq.bits.mask := Mux(bias_element_num =/= 0.U, 
                                  (1.U << (bias_element_num << log2Ceil(customerDataWidth/8))) - 1.U, 
                                  io.spad.stream.bits.mask)
      }
    }                

    io.dma.stream <> que.io.deq
    que.io.flush.get := io.spad.exp.req
  }
  // exception
  io.spad.exp.req := (state === s_exp)
  io.spad.exp.id := id
  io.dma.exp.ack := io.spad.exp.ack
  // response
  io.core.resp.valid := (state === s_resp)
  io.core.resp.bits.success := success
  io.core.resp.bits.id := id
}