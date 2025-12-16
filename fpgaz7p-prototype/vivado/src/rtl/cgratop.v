`define TOPAXIDATAWIDTH 128
`define TOPAXIDATAADDR 18
`define TOPAXISTRB 16

module CGRAAXITop(
  input         clock,
  input         reset,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 AWREADY" *)
  (* X_INTERFACE_PARAMETER = "ADDR_WIDTH 18,PROTOCOL AXI4,DATA_WIDTH 128" *)
  output        io_s_axi_aw_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 AWVALID" *)
  input         io_s_axi_aw_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 AWID" *)
  input  [5:0]  io_s_axi_aw_bits_id,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 AWADDR" *)
  input  [(`TOPAXIDATAADDR-1):0] io_s_axi_aw_bits_addr,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 AWLEN" *)
  input  [7:0]  io_s_axi_aw_bits_len,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 AWSIZE" *)
  input  [2:0]  io_s_axi_aw_bits_size,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 AWBURST" *)
  input  [1:0]  io_s_axi_aw_bits_burst,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 AWLOCK" *)
  input         io_s_axi_aw_bits_lock,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 AWCACHE" *)
  input  [3:0]  io_s_axi_aw_bits_cache,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 AWPROT" *)
  input  [2:0]  io_s_axi_aw_bits_prot,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 AWQOS" *)
  input  [3:0]  io_s_axi_aw_bits_qos,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 WREADY" *)
  output        io_s_axi_w_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 WVALID" *)
  input         io_s_axi_w_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 WDATA" *)
  input  [(`TOPAXIDATAWIDTH-1):0] io_s_axi_w_bits_data,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 WSTRB" *)
  input  [(`TOPAXISTRB-1):0]  io_s_axi_w_bits_strb,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 WLAST" *)
  input         io_s_axi_w_bits_last,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 BREADY" *)
  input         io_s_axi_b_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 BVALID" *)
  output        io_s_axi_b_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 BID" *)
  output [5:0]  io_s_axi_b_bits_id,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 BRESP" *)
  output [1:0]  io_s_axi_b_bits_resp,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 ARREADY" *)
  output        io_s_axi_ar_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 ARVALID" *)
  input         io_s_axi_ar_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 ARID" *)
  input  [5:0]  io_s_axi_ar_bits_id,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 ARADDR" *)
  input  [(`TOPAXIDATAADDR-1):0] io_s_axi_ar_bits_addr,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 ARLEN" *)
  input  [7:0]  io_s_axi_ar_bits_len,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 ARSIZE" *)
  input  [2:0]  io_s_axi_ar_bits_size,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 ARBURST" *)
  input  [1:0]  io_s_axi_ar_bits_burst,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 ARLOCK" *)
  input         io_s_axi_ar_bits_lock,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 ARCACHE" *)
  input  [3:0]  io_s_axi_ar_bits_cache,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 ARPROT" *)
  input  [2:0]  io_s_axi_ar_bits_prot,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 ARQOS" *)
  input  [3:0]  io_s_axi_ar_bits_qos,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 RREADY" *)
  input         io_s_axi_r_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 RVALID" *)
  output        io_s_axi_r_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 RID" *)
  output [5:0]  io_s_axi_r_bits_id,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 RDATA" *)
  output [(`TOPAXIDATAWIDTH-1):0] io_s_axi_r_bits_data,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 RRESP" *)
  output [1:0]  io_s_axi_r_bits_resp,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI4 RLAST" *)
  output        io_s_axi_r_bits_last,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE AWREADY" *)
  (* X_INTERFACE_PARAMETER = "ADDR_WIDTH 10,PROTOCOL AXI4LITE,DATA_WIDTH 32" *)
  output        io_s_axilite_aw_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE AWVALID" *)
  input         io_s_axilite_aw_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE AWADDR" *)
  input  [9:0]  io_s_axilite_aw_bits_addr,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE AWPROT" *)
  input  [2:0]  io_s_axilite_aw_bits_prot,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE WREADY" *)
  output        io_s_axilite_w_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE WVALID" *)
  input         io_s_axilite_w_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE WDATA" *)
  input  [31:0]  io_s_axilite_w_bits_data,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE WSTRB" *)
  input  [3:0]   io_s_axilite_w_bits_strb,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE BREADY" *)
  input         io_s_axilite_b_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE BVALID" *)
  output        io_s_axilite_b_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE BRESP" *)
  output [1:0]  io_s_axilite_b_bits_resp,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE ARREADY" *)
  output        io_s_axilite_ar_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE ARVALID" *)
  input         io_s_axilite_ar_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE ARADDR" *)
  input  [9:0]  io_s_axilite_ar_bits_addr,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE ARPROT" *)
  input  [2:0]  io_s_axilite_ar_bits_prot,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE RREADY" *)
  input         io_s_axilite_r_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE RVALID" *)
  output        io_s_axilite_r_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE RDATA" *)
  output [31:0]  io_s_axilite_r_bits_data,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI_LITE RRESP" *)
  output [1:0]  io_s_axilite_r_bits_resp
);

CGRAWithAXI instance_1 (
  .clock(clock),
  .reset(reset),
  .io_s_axi_aw_ready(io_s_axi_aw_ready),
  .io_s_axi_aw_valid(io_s_axi_aw_valid),
  .io_s_axi_aw_bits_id(io_s_axi_aw_bits_id),
  .io_s_axi_aw_bits_addr(io_s_axi_aw_bits_addr),
  .io_s_axi_aw_bits_len(io_s_axi_aw_bits_len),
  .io_s_axi_aw_bits_size(io_s_axi_aw_bits_size),
  .io_s_axi_aw_bits_burst(io_s_axi_aw_bits_burst),
  .io_s_axi_aw_bits_lock(io_s_axi_aw_bits_lock),
  .io_s_axi_aw_bits_cache(io_s_axi_aw_bits_cache),
  .io_s_axi_aw_bits_prot(io_s_axi_aw_bits_prot),
  .io_s_axi_aw_bits_qos(io_s_axi_aw_bits_qos),
  .io_s_axi_w_ready(io_s_axi_w_ready),
  .io_s_axi_w_valid(io_s_axi_w_valid),
  .io_s_axi_w_bits_data(io_s_axi_w_bits_data),
  .io_s_axi_w_bits_strb(io_s_axi_w_bits_strb),
  .io_s_axi_w_bits_last(io_s_axi_w_bits_last),
  .io_s_axi_b_ready(io_s_axi_b_ready),
  .io_s_axi_b_valid(io_s_axi_b_valid),
  .io_s_axi_b_bits_id(io_s_axi_b_bits_id),
  .io_s_axi_b_bits_resp(io_s_axi_b_bits_resp),
  .io_s_axi_ar_ready(io_s_axi_ar_ready),
  .io_s_axi_ar_valid(io_s_axi_ar_valid),
  .io_s_axi_ar_bits_id(io_s_axi_ar_bits_id),
  .io_s_axi_ar_bits_addr(io_s_axi_ar_bits_addr),
  .io_s_axi_ar_bits_len(io_s_axi_ar_bits_len),
  .io_s_axi_ar_bits_size(io_s_axi_ar_bits_size),
  .io_s_axi_ar_bits_burst(io_s_axi_ar_bits_burst),
  .io_s_axi_ar_bits_lock(io_s_axi_ar_bits_lock),
  .io_s_axi_ar_bits_cache(io_s_axi_ar_bits_cache),
  .io_s_axi_ar_bits_prot(io_s_axi_ar_bits_prot),
  .io_s_axi_ar_bits_qos(io_s_axi_ar_bits_qos),
  .io_s_axi_r_ready(io_s_axi_r_ready),
  .io_s_axi_r_valid(io_s_axi_r_valid),
  .io_s_axi_r_bits_id(io_s_axi_r_bits_id),
  .io_s_axi_r_bits_data(io_s_axi_r_bits_data),
  .io_s_axi_r_bits_resp(io_s_axi_r_bits_resp),
  .io_s_axi_r_bits_last(io_s_axi_r_bits_last),
  
  .io_s_axilite_aw_ready(io_s_axilite_aw_ready),
  .io_s_axilite_aw_valid(io_s_axilite_aw_valid),
  .io_s_axilite_aw_bits_addr(io_s_axilite_aw_bits_addr),
  .io_s_axilite_aw_bits_prot(io_s_axilite_aw_bits_prot),
  .io_s_axilite_w_ready(io_s_axilite_w_ready),
  .io_s_axilite_w_valid(io_s_axilite_w_valid),
  .io_s_axilite_w_bits_data(io_s_axilite_w_bits_data[7:0]),
  .io_s_axilite_w_bits_strb(io_s_axilite_w_bits_strb),
  .io_s_axilite_b_ready(io_s_axilite_b_ready),
  .io_s_axilite_b_valid(io_s_axilite_b_valid),
  .io_s_axilite_b_bits_resp(io_s_axilite_b_bits_resp),
  .io_s_axilite_ar_ready(io_s_axilite_ar_ready),
  .io_s_axilite_ar_valid(io_s_axilite_ar_valid),
  .io_s_axilite_ar_bits_addr(io_s_axilite_ar_bits_addr),
  .io_s_axilite_ar_bits_prot(io_s_axilite_ar_bits_prot),
  .io_s_axilite_r_ready(io_s_axilite_r_ready),
  .io_s_axilite_r_valid(io_s_axilite_r_valid),
  .io_s_axilite_r_bits_data(io_s_axilite_r_bits_data[7:0]),
  .io_s_axilite_r_bits_resp(io_s_axilite_r_bits_resp)
);

endmodule
