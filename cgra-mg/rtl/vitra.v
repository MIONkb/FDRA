module TrueDualPortSRAM_16_10(
  input         clock,
  input         io_a_en,
  input         io_a_we,
  input  [9:0]  io_a_addr,
  input  [15:0] io_a_din,
  output [15:0] io_a_dout,
  input         io_b_en,
  input         io_b_we,
  input  [9:0]  io_b_addr,
  input  [15:0] io_b_din,
  output [15:0] io_b_dout
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] mem [0:1023]; // @[SRAM.scala 75:28]
  wire  mem_rwPort_r_en; // @[SRAM.scala 75:28]
  wire [9:0] mem_rwPort_r_addr; // @[SRAM.scala 75:28]
  wire [15:0] mem_rwPort_r_data; // @[SRAM.scala 75:28]
  wire  mem_rwPort_1_r_en; // @[SRAM.scala 75:28]
  wire [9:0] mem_rwPort_1_r_addr; // @[SRAM.scala 75:28]
  wire [15:0] mem_rwPort_1_r_data; // @[SRAM.scala 75:28]
  wire [15:0] mem_rwPort_w_data; // @[SRAM.scala 75:28]
  wire [9:0] mem_rwPort_w_addr; // @[SRAM.scala 75:28]
  wire  mem_rwPort_w_mask; // @[SRAM.scala 75:28]
  wire  mem_rwPort_w_en; // @[SRAM.scala 75:28]
  wire [15:0] mem_rwPort_1_w_data; // @[SRAM.scala 75:28]
  wire [9:0] mem_rwPort_1_w_addr; // @[SRAM.scala 75:28]
  wire  mem_rwPort_1_w_mask; // @[SRAM.scala 75:28]
  wire  mem_rwPort_1_w_en; // @[SRAM.scala 75:28]
  reg  mem_rwPort_r_en_pipe_0;
  reg [9:0] mem_rwPort_r_addr_pipe_0;
  reg  mem_rwPort_1_r_en_pipe_0;
  reg [9:0] mem_rwPort_1_r_addr_pipe_0;
  assign mem_rwPort_r_en = mem_rwPort_r_en_pipe_0;
  assign mem_rwPort_r_addr = mem_rwPort_r_addr_pipe_0;
  assign mem_rwPort_r_data = mem[mem_rwPort_r_addr]; // @[SRAM.scala 75:28]
  assign mem_rwPort_1_r_en = mem_rwPort_1_r_en_pipe_0;
  assign mem_rwPort_1_r_addr = mem_rwPort_1_r_addr_pipe_0;
  assign mem_rwPort_1_r_data = mem[mem_rwPort_1_r_addr]; // @[SRAM.scala 75:28]
  assign mem_rwPort_w_data = io_a_din;
  assign mem_rwPort_w_addr = io_a_addr;
  assign mem_rwPort_w_mask = io_a_we;
  assign mem_rwPort_w_en = io_a_en & (io_a_en & io_a_we);
  assign mem_rwPort_1_w_data = io_b_din;
  assign mem_rwPort_1_w_addr = io_b_addr;
  assign mem_rwPort_1_w_mask = io_b_we;
  assign mem_rwPort_1_w_en = io_b_en & (io_b_en & io_b_we);
  assign io_a_dout = mem_rwPort_r_data; // @[SRAM.scala 80:29 83:20]
  assign io_b_dout = mem_rwPort_1_r_data; // @[SRAM.scala 80:29 83:20]
  always @(posedge clock) begin
    if (mem_rwPort_w_en & mem_rwPort_w_mask) begin
      mem[mem_rwPort_w_addr] <= mem_rwPort_w_data; // @[SRAM.scala 75:28]
    end
    if (mem_rwPort_1_w_en & mem_rwPort_1_w_mask) begin
      mem[mem_rwPort_1_w_addr] <= mem_rwPort_1_w_data; // @[SRAM.scala 75:28]
    end
    mem_rwPort_r_en_pipe_0 <= io_a_en & ~(io_a_en & io_a_we);
    if (io_a_en & ~(io_a_en & io_a_we)) begin
      mem_rwPort_r_addr_pipe_0 <= io_a_addr;
    end
    mem_rwPort_1_r_en_pipe_0 <= io_b_en & ~(io_b_en & io_b_we);
    if (io_b_en & ~(io_b_en & io_b_we)) begin
      mem_rwPort_1_r_addr_pipe_0 <= io_b_addr;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[15:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_rwPort_r_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_rwPort_r_addr_pipe_0 = _RAND_2[9:0];
  _RAND_3 = {1{`RANDOM}};
  mem_rwPort_1_r_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mem_rwPort_1_r_addr_pipe_0 = _RAND_4[9:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TrueDualPortSRAMAsym(
  input         clock,
  input         io_a_en,
  input         io_a_we,
  input  [9:0]  io_a_addr,
  input  [63:0] io_a_din,
  output [63:0] io_a_dout,
  input         io_b_en,
  input         io_b_we,
  input  [11:0] io_b_addr,
  input  [15:0] io_b_din,
  output [15:0] io_b_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  TrueDualPortSRAM_16_10_clock; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_io_a_en; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_io_a_we; // @[SRAM.scala 249:32]
  wire [9:0] TrueDualPortSRAM_16_10_io_a_addr; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_io_a_din; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_io_a_dout; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_io_b_en; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_io_b_we; // @[SRAM.scala 249:32]
  wire [9:0] TrueDualPortSRAM_16_10_io_b_addr; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_io_b_din; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_io_b_dout; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_1_clock; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_1_io_a_en; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_1_io_a_we; // @[SRAM.scala 249:32]
  wire [9:0] TrueDualPortSRAM_16_10_1_io_a_addr; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_1_io_a_din; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_1_io_a_dout; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_1_io_b_en; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_1_io_b_we; // @[SRAM.scala 249:32]
  wire [9:0] TrueDualPortSRAM_16_10_1_io_b_addr; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_1_io_b_din; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_1_io_b_dout; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_2_clock; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_2_io_a_en; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_2_io_a_we; // @[SRAM.scala 249:32]
  wire [9:0] TrueDualPortSRAM_16_10_2_io_a_addr; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_2_io_a_din; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_2_io_a_dout; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_2_io_b_en; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_2_io_b_we; // @[SRAM.scala 249:32]
  wire [9:0] TrueDualPortSRAM_16_10_2_io_b_addr; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_2_io_b_din; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_2_io_b_dout; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_3_clock; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_3_io_a_en; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_3_io_a_we; // @[SRAM.scala 249:32]
  wire [9:0] TrueDualPortSRAM_16_10_3_io_a_addr; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_3_io_a_din; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_3_io_a_dout; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_3_io_b_en; // @[SRAM.scala 249:32]
  wire  TrueDualPortSRAM_16_10_3_io_b_we; // @[SRAM.scala 249:32]
  wire [9:0] TrueDualPortSRAM_16_10_3_io_b_addr; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_3_io_b_din; // @[SRAM.scala 249:32]
  wire [15:0] TrueDualPortSRAM_16_10_3_io_b_dout; // @[SRAM.scala 249:32]
  wire [31:0] io_a_dout_lo = {TrueDualPortSRAM_16_10_1_io_a_dout,TrueDualPortSRAM_16_10_io_a_dout}; // @[Cat.scala 33:92]
  wire [31:0] io_a_dout_hi = {TrueDualPortSRAM_16_10_3_io_a_dout,TrueDualPortSRAM_16_10_2_io_a_dout}; // @[Cat.scala 33:92]
  reg  benRegs_0; // @[SRAM.scala 268:41]
  reg  benRegs_1; // @[SRAM.scala 268:41]
  reg  benRegs_2; // @[SRAM.scala 268:41]
  reg  benRegs_3; // @[SRAM.scala 268:41]
  wire [15:0] _io_b_dout_T = benRegs_3 ? TrueDualPortSRAM_16_10_3_io_b_dout : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_b_dout_T_1 = benRegs_2 ? TrueDualPortSRAM_16_10_2_io_b_dout : _io_b_dout_T; // @[Mux.scala 101:16]
  wire [15:0] _io_b_dout_T_2 = benRegs_1 ? TrueDualPortSRAM_16_10_1_io_b_dout : _io_b_dout_T_1; // @[Mux.scala 101:16]
  TrueDualPortSRAM_16_10 TrueDualPortSRAM_16_10 ( // @[SRAM.scala 249:32]
    .clock(TrueDualPortSRAM_16_10_clock),
    .io_a_en(TrueDualPortSRAM_16_10_io_a_en),
    .io_a_we(TrueDualPortSRAM_16_10_io_a_we),
    .io_a_addr(TrueDualPortSRAM_16_10_io_a_addr),
    .io_a_din(TrueDualPortSRAM_16_10_io_a_din),
    .io_a_dout(TrueDualPortSRAM_16_10_io_a_dout),
    .io_b_en(TrueDualPortSRAM_16_10_io_b_en),
    .io_b_we(TrueDualPortSRAM_16_10_io_b_we),
    .io_b_addr(TrueDualPortSRAM_16_10_io_b_addr),
    .io_b_din(TrueDualPortSRAM_16_10_io_b_din),
    .io_b_dout(TrueDualPortSRAM_16_10_io_b_dout)
  );
  TrueDualPortSRAM_16_10 TrueDualPortSRAM_16_10_1 ( // @[SRAM.scala 249:32]
    .clock(TrueDualPortSRAM_16_10_1_clock),
    .io_a_en(TrueDualPortSRAM_16_10_1_io_a_en),
    .io_a_we(TrueDualPortSRAM_16_10_1_io_a_we),
    .io_a_addr(TrueDualPortSRAM_16_10_1_io_a_addr),
    .io_a_din(TrueDualPortSRAM_16_10_1_io_a_din),
    .io_a_dout(TrueDualPortSRAM_16_10_1_io_a_dout),
    .io_b_en(TrueDualPortSRAM_16_10_1_io_b_en),
    .io_b_we(TrueDualPortSRAM_16_10_1_io_b_we),
    .io_b_addr(TrueDualPortSRAM_16_10_1_io_b_addr),
    .io_b_din(TrueDualPortSRAM_16_10_1_io_b_din),
    .io_b_dout(TrueDualPortSRAM_16_10_1_io_b_dout)
  );
  TrueDualPortSRAM_16_10 TrueDualPortSRAM_16_10_2 ( // @[SRAM.scala 249:32]
    .clock(TrueDualPortSRAM_16_10_2_clock),
    .io_a_en(TrueDualPortSRAM_16_10_2_io_a_en),
    .io_a_we(TrueDualPortSRAM_16_10_2_io_a_we),
    .io_a_addr(TrueDualPortSRAM_16_10_2_io_a_addr),
    .io_a_din(TrueDualPortSRAM_16_10_2_io_a_din),
    .io_a_dout(TrueDualPortSRAM_16_10_2_io_a_dout),
    .io_b_en(TrueDualPortSRAM_16_10_2_io_b_en),
    .io_b_we(TrueDualPortSRAM_16_10_2_io_b_we),
    .io_b_addr(TrueDualPortSRAM_16_10_2_io_b_addr),
    .io_b_din(TrueDualPortSRAM_16_10_2_io_b_din),
    .io_b_dout(TrueDualPortSRAM_16_10_2_io_b_dout)
  );
  TrueDualPortSRAM_16_10 TrueDualPortSRAM_16_10_3 ( // @[SRAM.scala 249:32]
    .clock(TrueDualPortSRAM_16_10_3_clock),
    .io_a_en(TrueDualPortSRAM_16_10_3_io_a_en),
    .io_a_we(TrueDualPortSRAM_16_10_3_io_a_we),
    .io_a_addr(TrueDualPortSRAM_16_10_3_io_a_addr),
    .io_a_din(TrueDualPortSRAM_16_10_3_io_a_din),
    .io_a_dout(TrueDualPortSRAM_16_10_3_io_a_dout),
    .io_b_en(TrueDualPortSRAM_16_10_3_io_b_en),
    .io_b_we(TrueDualPortSRAM_16_10_3_io_b_we),
    .io_b_addr(TrueDualPortSRAM_16_10_3_io_b_addr),
    .io_b_din(TrueDualPortSRAM_16_10_3_io_b_din),
    .io_b_dout(TrueDualPortSRAM_16_10_3_io_b_dout)
  );
  assign io_a_dout = {io_a_dout_hi,io_a_dout_lo}; // @[Cat.scala 33:92]
  assign io_b_dout = benRegs_0 ? TrueDualPortSRAM_16_10_io_b_dout : _io_b_dout_T_2; // @[Mux.scala 101:16]
  assign TrueDualPortSRAM_16_10_clock = clock;
  assign TrueDualPortSRAM_16_10_io_a_en = io_a_en; // @[SRAM.scala 254:20]
  assign TrueDualPortSRAM_16_10_io_a_we = io_a_we; // @[SRAM.scala 258:22]
  assign TrueDualPortSRAM_16_10_io_a_addr = io_a_addr; // @[SRAM.scala 260:22]
  assign TrueDualPortSRAM_16_10_io_a_din = io_a_din[15:0]; // @[SRAM.scala 261:32]
  assign TrueDualPortSRAM_16_10_io_b_en = io_b_en & io_b_addr[1:0] == 2'h0; // @[SRAM.scala 262:31]
  assign TrueDualPortSRAM_16_10_io_b_we = io_b_we; // @[SRAM.scala 263:20]
  assign TrueDualPortSRAM_16_10_io_b_addr = io_b_addr[11:2]; // @[SRAM.scala 264:34]
  assign TrueDualPortSRAM_16_10_io_b_din = io_b_din; // @[SRAM.scala 265:21]
  assign TrueDualPortSRAM_16_10_1_clock = clock;
  assign TrueDualPortSRAM_16_10_1_io_a_en = io_a_en; // @[SRAM.scala 254:20]
  assign TrueDualPortSRAM_16_10_1_io_a_we = io_a_we; // @[SRAM.scala 258:22]
  assign TrueDualPortSRAM_16_10_1_io_a_addr = io_a_addr; // @[SRAM.scala 260:22]
  assign TrueDualPortSRAM_16_10_1_io_a_din = io_a_din[31:16]; // @[SRAM.scala 261:32]
  assign TrueDualPortSRAM_16_10_1_io_b_en = io_b_en & io_b_addr[1:0] == 2'h1; // @[SRAM.scala 262:31]
  assign TrueDualPortSRAM_16_10_1_io_b_we = io_b_we; // @[SRAM.scala 263:20]
  assign TrueDualPortSRAM_16_10_1_io_b_addr = io_b_addr[11:2]; // @[SRAM.scala 264:34]
  assign TrueDualPortSRAM_16_10_1_io_b_din = io_b_din; // @[SRAM.scala 265:21]
  assign TrueDualPortSRAM_16_10_2_clock = clock;
  assign TrueDualPortSRAM_16_10_2_io_a_en = io_a_en; // @[SRAM.scala 254:20]
  assign TrueDualPortSRAM_16_10_2_io_a_we = io_a_we; // @[SRAM.scala 258:22]
  assign TrueDualPortSRAM_16_10_2_io_a_addr = io_a_addr; // @[SRAM.scala 260:22]
  assign TrueDualPortSRAM_16_10_2_io_a_din = io_a_din[47:32]; // @[SRAM.scala 261:32]
  assign TrueDualPortSRAM_16_10_2_io_b_en = io_b_en & io_b_addr[1:0] == 2'h2; // @[SRAM.scala 262:31]
  assign TrueDualPortSRAM_16_10_2_io_b_we = io_b_we; // @[SRAM.scala 263:20]
  assign TrueDualPortSRAM_16_10_2_io_b_addr = io_b_addr[11:2]; // @[SRAM.scala 264:34]
  assign TrueDualPortSRAM_16_10_2_io_b_din = io_b_din; // @[SRAM.scala 265:21]
  assign TrueDualPortSRAM_16_10_3_clock = clock;
  assign TrueDualPortSRAM_16_10_3_io_a_en = io_a_en; // @[SRAM.scala 254:20]
  assign TrueDualPortSRAM_16_10_3_io_a_we = io_a_we; // @[SRAM.scala 258:22]
  assign TrueDualPortSRAM_16_10_3_io_a_addr = io_a_addr; // @[SRAM.scala 260:22]
  assign TrueDualPortSRAM_16_10_3_io_a_din = io_a_din[63:48]; // @[SRAM.scala 261:32]
  assign TrueDualPortSRAM_16_10_3_io_b_en = io_b_en & io_b_addr[1:0] == 2'h3; // @[SRAM.scala 262:31]
  assign TrueDualPortSRAM_16_10_3_io_b_we = io_b_we; // @[SRAM.scala 263:20]
  assign TrueDualPortSRAM_16_10_3_io_b_addr = io_b_addr[11:2]; // @[SRAM.scala 264:34]
  assign TrueDualPortSRAM_16_10_3_io_b_din = io_b_din; // @[SRAM.scala 265:21]
  always @(posedge clock) begin
    benRegs_0 <= TrueDualPortSRAM_16_10_io_b_en; // @[SRAM.scala 268:41]
    benRegs_1 <= TrueDualPortSRAM_16_10_1_io_b_en; // @[SRAM.scala 268:41]
    benRegs_2 <= TrueDualPortSRAM_16_10_2_io_b_en; // @[SRAM.scala 268:41]
    benRegs_3 <= TrueDualPortSRAM_16_10_3_io_b_en; // @[SRAM.scala 268:41]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  benRegs_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  benRegs_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  benRegs_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  benRegs_3 = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module TrueDualPortSRAM_64_9(
  input         clock,
  input         io_a_en,
  input         io_a_we,
  input  [8:0]  io_a_addr,
  input  [63:0] io_a_din,
  output [63:0] io_a_dout,
  input         io_b_en,
  input  [8:0]  io_b_addr,
  output [63:0] io_b_dout
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] mem [0:511]; // @[SRAM.scala 75:28]
  wire  mem_rwPort_r_en; // @[SRAM.scala 75:28]
  wire [8:0] mem_rwPort_r_addr; // @[SRAM.scala 75:28]
  wire [63:0] mem_rwPort_r_data; // @[SRAM.scala 75:28]
  wire  mem_rwPort_1_r_en; // @[SRAM.scala 75:28]
  wire [8:0] mem_rwPort_1_r_addr; // @[SRAM.scala 75:28]
  wire [63:0] mem_rwPort_1_r_data; // @[SRAM.scala 75:28]
  wire [63:0] mem_rwPort_w_data; // @[SRAM.scala 75:28]
  wire [8:0] mem_rwPort_w_addr; // @[SRAM.scala 75:28]
  wire  mem_rwPort_w_mask; // @[SRAM.scala 75:28]
  wire  mem_rwPort_w_en; // @[SRAM.scala 75:28]
  wire [63:0] mem_rwPort_1_w_data; // @[SRAM.scala 75:28]
  wire [8:0] mem_rwPort_1_w_addr; // @[SRAM.scala 75:28]
  wire  mem_rwPort_1_w_mask; // @[SRAM.scala 75:28]
  wire  mem_rwPort_1_w_en; // @[SRAM.scala 75:28]
  reg  mem_rwPort_r_en_pipe_0;
  reg [8:0] mem_rwPort_r_addr_pipe_0;
  reg  mem_rwPort_1_r_en_pipe_0;
  reg [8:0] mem_rwPort_1_r_addr_pipe_0;
  assign mem_rwPort_r_en = mem_rwPort_r_en_pipe_0;
  assign mem_rwPort_r_addr = mem_rwPort_r_addr_pipe_0;
  assign mem_rwPort_r_data = mem[mem_rwPort_r_addr]; // @[SRAM.scala 75:28]
  assign mem_rwPort_1_r_en = mem_rwPort_1_r_en_pipe_0;
  assign mem_rwPort_1_r_addr = mem_rwPort_1_r_addr_pipe_0;
  assign mem_rwPort_1_r_data = mem[mem_rwPort_1_r_addr]; // @[SRAM.scala 75:28]
  assign mem_rwPort_w_data = io_a_din;
  assign mem_rwPort_w_addr = io_a_addr;
  assign mem_rwPort_w_mask = io_a_we;
  assign mem_rwPort_w_en = io_a_en & (io_a_en & io_a_we);
  assign mem_rwPort_1_w_data = 64'h0;
  assign mem_rwPort_1_w_addr = io_b_addr;
  assign mem_rwPort_1_w_mask = 1'h0;
  assign mem_rwPort_1_w_en = io_b_en & 1'h0;
  assign io_a_dout = mem_rwPort_r_data; // @[SRAM.scala 80:29 83:20]
  assign io_b_dout = mem_rwPort_1_r_data; // @[SRAM.scala 80:29 83:20]
  always @(posedge clock) begin
    if (mem_rwPort_w_en & mem_rwPort_w_mask) begin
      mem[mem_rwPort_w_addr] <= mem_rwPort_w_data; // @[SRAM.scala 75:28]
    end
    if (mem_rwPort_1_w_en & mem_rwPort_1_w_mask) begin
      mem[mem_rwPort_1_w_addr] <= mem_rwPort_1_w_data; // @[SRAM.scala 75:28]
    end
    mem_rwPort_r_en_pipe_0 <= io_a_en & ~(io_a_en & io_a_we);
    if (io_a_en & ~(io_a_en & io_a_we)) begin
      mem_rwPort_r_addr_pipe_0 <= io_a_addr;
    end
    mem_rwPort_1_r_en_pipe_0 <= io_b_en & ~1'h0;
    if (io_b_en & ~1'h0) begin
      mem_rwPort_1_r_addr_pipe_0 <= io_b_addr;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 512; initvar = initvar+1)
    mem[initvar] = _RAND_0[63:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_rwPort_r_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_rwPort_r_addr_pipe_0 = _RAND_2[8:0];
  _RAND_3 = {1{`RANDOM}};
  mem_rwPort_1_r_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mem_rwPort_1_r_addr_pipe_0 = _RAND_4[8:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SramAddrGen(
  input  [16:0] CurAddr,
  input  [7:0]  Len,
  input  [2:0]  Size,
  input  [1:0]  Burst,
  output [16:0] NextAddr
);
  wire [11:0] iCurAddr = CurAddr[11:0]; // @[SramAddrGen.scala 26:30]
  wire [1:0] _iSize_T_3 = 3'h2 == Size ? 2'h2 : {{1'd0}, 3'h1 == Size}; // @[Mux.scala 81:58]
  wire [1:0] _iSize_T_5 = 3'h3 == Size ? 2'h3 : _iSize_T_3; // @[Mux.scala 81:58]
  wire [2:0] _iSize_T_7 = 3'h4 == Size ? 3'h4 : {{1'd0}, _iSize_T_5}; // @[Mux.scala 81:58]
  wire [2:0] _iSize_T_9 = 3'h5 == Size ? 3'h5 : _iSize_T_7; // @[Mux.scala 81:58]
  wire [2:0] _iSize_T_11 = 3'h6 == Size ? 3'h6 : _iSize_T_9; // @[Mux.scala 81:58]
  wire [2:0] iSize = 3'h7 == Size ? 3'h7 : _iSize_T_11; // @[Mux.scala 81:58]
  wire [11:0] wordAddress = iCurAddr >> iSize; // @[SramAddrGen.scala 33:32]
  wire [11:0] _incrNextAddr_T_1 = wordAddress + 12'h1; // @[SramAddrGen.scala 36:37]
  wire [18:0] _GEN_1 = {{7'd0}, _incrNextAddr_T_1}; // @[SramAddrGen.scala 36:44]
  wire [18:0] incrNextAddr = _GEN_1 << iSize; // @[SramAddrGen.scala 36:44]
  wire [3:0] _wrapBound_T_3 = ~Len[3:0]; // @[SramAddrGen.scala 39:68]
  wire [3:0] _wrapBound_T_4 = wordAddress[3:0] & _wrapBound_T_3; // @[SramAddrGen.scala 39:66]
  wire [11:0] _wrapBound_T_5 = {wordAddress[11:4],_wrapBound_T_4}; // @[Cat.scala 33:92]
  wire [18:0] _GEN_2 = {{7'd0}, _wrapBound_T_5}; // @[SramAddrGen.scala 39:80]
  wire [18:0] wrapBound = _GEN_2 << iSize; // @[SramAddrGen.scala 39:80]
  wire [4:0] _totSize_T_1 = Len[3:0] + 4'h1; // @[SramAddrGen.scala 40:33]
  wire [11:0] _GEN_3 = {{7'd0}, _totSize_T_1}; // @[SramAddrGen.scala 40:41]
  wire [11:0] totSize = _GEN_3 << iSize; // @[SramAddrGen.scala 40:41]
  wire [18:0] _GEN_0 = {{7'd0}, totSize}; // @[SramAddrGen.scala 41:55]
  wire [18:0] _wrapNextAddr_T_1 = wrapBound + _GEN_0; // @[SramAddrGen.scala 41:55]
  wire [18:0] wrapNextAddr = incrNextAddr == _wrapNextAddr_T_1 ? wrapBound : incrNextAddr; // @[SramAddrGen.scala 41:27]
  wire [18:0] _iNextAddr_T_3 = 2'h1 == Burst ? incrNextAddr : {{2'd0}, CurAddr}; // @[Mux.scala 81:58]
  wire [18:0] _iNextAddr_T_5 = 2'h2 == Burst ? wrapNextAddr : _iNextAddr_T_3; // @[Mux.scala 81:58]
  wire [11:0] iNextAddr = _iNextAddr_T_5[11:0]; // @[SramAddrGen.scala 27:27 43:15]
  assign NextAddr = {CurAddr[16:12],iNextAddr}; // @[Cat.scala 33:92]
endmodule
module WriteEngine(
  input         aclk,
  input         aresetn,
  output        s_axi_aw_ready,
  input         s_axi_aw_valid,
  input  [5:0]  s_axi_aw_bits_id,
  input  [16:0] s_axi_aw_bits_addr,
  input  [7:0]  s_axi_aw_bits_len,
  input  [2:0]  s_axi_aw_bits_size,
  input  [1:0]  s_axi_aw_bits_burst,
  output        s_axi_w_ready,
  input         s_axi_w_valid,
  input  [63:0] s_axi_w_bits_data,
  input         s_axi_w_bits_last,
  input         s_axi_b_ready,
  output        s_axi_b_valid,
  output [5:0]  s_axi_b_bits_id,
  input         ready,
  output        valid,
  output [16:0] addr,
  output [63:0] data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire [16:0] NextAddr_m_CurAddr; // @[SramAddrGen.scala 50:23]
  wire [7:0] NextAddr_m_Len; // @[SramAddrGen.scala 50:23]
  wire [2:0] NextAddr_m_Size; // @[SramAddrGen.scala 50:23]
  wire [1:0] NextAddr_m_Burst; // @[SramAddrGen.scala 50:23]
  wire [16:0] NextAddr_m_NextAddr; // @[SramAddrGen.scala 50:23]
  wire  reset = ~aresetn; // @[WriteEngine.scala 47:33]
  reg [1:0] state; // @[WriteEngine.scala 56:28]
  reg [7:0] spad_needed_len; // @[WriteEngine.scala 57:38]
  reg [1:0] wBurst; // @[WriteEngine.scala 64:29]
  reg [2:0] wSize; // @[WriteEngine.scala 65:28]
  reg [5:0] iBID; // @[WriteEngine.scala 69:27]
  reg [16:0] iAddr; // @[WriteEngine.scala 77:34]
  wire [16:0] NextAddr = NextAddr_m_NextAddr; // @[WriteEngine.scala 79:31 80:21]
  wire [16:0] _GEN_12 = s_axi_w_valid ? NextAddr : iAddr; // @[WriteEngine.scala 130:42 133:29 137:29]
  wire [1:0] _GEN_13 = s_axi_w_bits_last & s_axi_w_valid ? 2'h3 : state; // @[WriteEngine.scala 120:63 127:29]
  wire [16:0] _GEN_14 = s_axi_w_bits_last & s_axi_w_valid ? iAddr : _GEN_12; // @[WriteEngine.scala 120:63 128:29]
  wire [1:0] _GEN_19 = s_axi_b_ready ? 2'h0 : state; // @[WriteEngine.scala 141:36 142:29 56:28]
  SramAddrGen NextAddr_m ( // @[SramAddrGen.scala 50:23]
    .CurAddr(NextAddr_m_CurAddr),
    .Len(NextAddr_m_Len),
    .Size(NextAddr_m_Size),
    .Burst(NextAddr_m_Burst),
    .NextAddr(NextAddr_m_NextAddr)
  );
  assign s_axi_aw_ready = state == 2'h0; // @[WriteEngine.scala 150:38]
  assign s_axi_w_ready = state == 2'h2; // @[WriteEngine.scala 153:38]
  assign s_axi_b_valid = state == 2'h3; // @[WriteEngine.scala 160:38]
  assign s_axi_b_bits_id = iBID; // @[WriteEngine.scala 158:29]
  assign valid = state == 2'h2; // @[WriteEngine.scala 163:30]
  assign addr = iAddr; // @[WriteEngine.scala 164:21]
  assign data = s_axi_w_bits_data; // @[WriteEngine.scala 154:29]
  assign NextAddr_m_CurAddr = iAddr; // @[SramAddrGen.scala 51:21]
  assign NextAddr_m_Len = spad_needed_len; // @[SramAddrGen.scala 52:21]
  assign NextAddr_m_Size = wSize; // @[SramAddrGen.scala 53:21]
  assign NextAddr_m_Burst = wBurst; // @[SramAddrGen.scala 54:21]
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[WriteEngine.scala 90:23]
      state <= 2'h0; // @[WriteEngine.scala 102:29 92:38 93:37]
    end else if (2'h0 == state) begin // @[WriteEngine.scala 90:23]
      if (s_axi_aw_valid) begin // @[WriteEngine.scala 110:29]
        state <= 2'h2; // @[WriteEngine.scala 111:29]
      end
    end else if (2'h1 == state) begin // @[WriteEngine.scala 90:23]
      if (ready) begin // @[WriteEngine.scala 117:30]
        state <= 2'h2; // @[WriteEngine.scala 118:29]
      end
    end else if (2'h2 == state) begin // @[WriteEngine.scala 90:23]
      if (~ready) begin
        state <= 2'h1;
      end else begin
        state <= _GEN_13;
      end
    end else if (2'h3 == state) begin // @[WriteEngine.scala 56:28]
      state <= _GEN_19;
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[WriteEngine.scala 90:23]
      spad_needed_len <= 8'h0; // @[WriteEngine.scala 92:38 94:37 57:38]
    end else if (2'h0 == state) begin // @[WriteEngine.scala 57:38]
      if (s_axi_aw_valid) begin
        spad_needed_len <= s_axi_aw_bits_len;
      end
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[WriteEngine.scala 90:23]
      wBurst <= 2'h0; // @[WriteEngine.scala 105:29 92:38 99:37]
    end else if (2'h0 == state) begin // @[WriteEngine.scala 64:29]
      if (s_axi_aw_valid) begin
        wBurst <= s_axi_aw_bits_burst;
      end else begin
        wBurst <= 2'h0;
      end
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[WriteEngine.scala 90:23]
      wSize <= 3'h0; // @[WriteEngine.scala 100:37 106:29 92:38]
    end else if (2'h0 == state) begin // @[WriteEngine.scala 65:28]
      if (s_axi_aw_valid) begin
        wSize <= s_axi_aw_bits_size;
      end else begin
        wSize <= 3'h0;
      end
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[WriteEngine.scala 90:23]
      iBID <= 6'h0; // @[WriteEngine.scala 103:29 92:38 95:37]
    end else if (2'h0 == state) begin // @[WriteEngine.scala 69:27]
      if (s_axi_aw_valid) begin
        iBID <= s_axi_aw_bits_id;
      end else begin
        iBID <= 6'h0;
      end
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[WriteEngine.scala 90:23]
      iAddr <= 17'h0; // @[WriteEngine.scala 77:34 92:38 97:37]
    end else if (2'h0 == state) begin // @[WriteEngine.scala 90:23]
      if (s_axi_aw_valid) begin // @[WriteEngine.scala 110:29]
        iAddr <= s_axi_aw_bits_addr; // @[WriteEngine.scala 113:35]
      end
    end else if (2'h1 == state) begin // @[WriteEngine.scala 90:23]
      if (ready) begin // @[WriteEngine.scala 117:30]
        if (s_axi_w_ready) begin // @[WriteEngine.scala 77:34]
          iAddr <= NextAddr;
        end
      end
    end else if (2'h2 == state) begin // @[WriteEngine.scala 77:34]
      if (!(~ready)) begin
        iAddr <= _GEN_14;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  spad_needed_len = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  wBurst = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  wSize = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  iBID = _RAND_4[5:0];
  _RAND_5 = {1{`RANDOM}};
  iAddr = _RAND_5[16:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    state = 2'h0;
  end
  if (reset) begin
    spad_needed_len = 8'h0;
  end
  if (reset) begin
    wBurst = 2'h0;
  end
  if (reset) begin
    wSize = 3'h0;
  end
  if (reset) begin
    iBID = 6'h0;
  end
  if (reset) begin
    iAddr = 17'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ReadEngine(
  input         aclk,
  input         aresetn,
  output        s_axi_ar_ready,
  input         s_axi_ar_valid,
  input  [5:0]  s_axi_ar_bits_id,
  input  [16:0] s_axi_ar_bits_addr,
  input  [7:0]  s_axi_ar_bits_len,
  input  [2:0]  s_axi_ar_bits_size,
  input  [1:0]  s_axi_ar_bits_burst,
  input         s_axi_r_ready,
  output        s_axi_r_valid,
  output [5:0]  s_axi_r_bits_id,
  output [63:0] s_axi_r_bits_data,
  output        s_axi_r_bits_last,
  input         ready,
  output        valid,
  output [16:0] addr,
  input  [63:0] data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  wire [16:0] NextAddr_m_CurAddr; // @[SramAddrGen.scala 50:23]
  wire [7:0] NextAddr_m_Len; // @[SramAddrGen.scala 50:23]
  wire [2:0] NextAddr_m_Size; // @[SramAddrGen.scala 50:23]
  wire [1:0] NextAddr_m_Burst; // @[SramAddrGen.scala 50:23]
  wire [16:0] NextAddr_m_NextAddr; // @[SramAddrGen.scala 50:23]
  wire  reset = ~aresetn; // @[ReadEngine.scala 58:33]
  reg [1:0] state; // @[ReadEngine.scala 67:28]
  reg [7:0] spad_needed_len; // @[ReadEngine.scala 68:38]
  reg [5:0] rId; // @[ReadEngine.scala 73:26]
  reg [1:0] rBurst; // @[ReadEngine.scala 75:29]
  reg [2:0] rSize; // @[ReadEngine.scala 76:28]
  reg [7:0] leftLen; // @[ReadEngine.scala 79:30]
  reg [16:0] iAddr; // @[ReadEngine.scala 84:34]
  wire [16:0] NextAddr = NextAddr_m_NextAddr; // @[ReadEngine.scala 86:31 87:21]
  wire [7:0] _leftLen_T_1 = leftLen - 8'h1; // @[ReadEngine.scala 142:59]
  wire [7:0] _leftLen_T_2 = s_axi_r_ready ? _leftLen_T_1 : leftLen; // @[ReadEngine.scala 142:35]
  wire [1:0] _state_T = s_axi_r_ready ? 2'h3 : state; // @[ReadEngine.scala 152:35]
  wire [16:0] _iAddr_T = s_axi_r_ready ? NextAddr : iAddr; // @[ReadEngine.scala 153:35]
  wire [1:0] _GEN_20 = leftLen == 8'h1 ? _state_T : state; // @[ReadEngine.scala 145:45 152:29]
  wire [16:0] _GEN_21 = leftLen == 8'h1 ? _iAddr_T : _iAddr_T; // @[ReadEngine.scala 145:45 153:29]
  wire [7:0] _GEN_22 = leftLen == 8'h1 ? _leftLen_T_2 : _leftLen_T_2; // @[ReadEngine.scala 145:45 154:29]
  wire [1:0] _GEN_28 = s_axi_r_ready ? 2'h0 : state; // @[ReadEngine.scala 174:36 175:29 187:29]
  wire [7:0] _GEN_29 = s_axi_r_ready ? 8'h0 : leftLen; // @[ReadEngine.scala 174:36 176:29 188:29]
  wire [16:0] _GEN_30 = s_axi_r_ready ? 17'h0 : iAddr; // @[ReadEngine.scala 174:36 177:29 189:29]
  wire  _s_axi_ar_ready_T = state == 2'h0; // @[ReadEngine.scala 199:34]
  wire  _s_axi_r_valid_T = state == 2'h2; // @[ReadEngine.scala 203:38]
  wire  _s_axi_r_valid_T_1 = state == 2'h3; // @[ReadEngine.scala 203:62]
  wire  _valid_T_1 = state == 2'h1; // @[ReadEngine.scala 210:54]
  reg [63:0] Stream_data_reg; // @[ReadEngine.scala 215:38]
  reg  SpadState; // @[ReadEngine.scala 217:32]
  wire  _T_7 = ~SpadState; // @[ReadEngine.scala 218:27]
  wire  _GEN_52 = ~s_axi_r_ready | SpadState; // @[ReadEngine.scala 225:43 226:31 217:32]
  SramAddrGen NextAddr_m ( // @[SramAddrGen.scala 50:23]
    .CurAddr(NextAddr_m_CurAddr),
    .Len(NextAddr_m_Len),
    .Size(NextAddr_m_Size),
    .Burst(NextAddr_m_Burst),
    .NextAddr(NextAddr_m_NextAddr)
  );
  assign s_axi_ar_ready = state == 2'h0; // @[ReadEngine.scala 199:34]
  assign s_axi_r_valid = state == 2'h2 | state == 2'h3; // @[ReadEngine.scala 203:53]
  assign s_axi_r_bits_id = rId; // @[ReadEngine.scala 204:29]
  assign s_axi_r_bits_data = _T_7 ? data : Stream_data_reg; // @[ReadEngine.scala 239:27]
  assign s_axi_r_bits_last = state == 2'h3; // @[ReadEngine.scala 206:38]
  assign valid = _s_axi_r_valid_T | state == 2'h1 | _s_axi_r_valid_T_1; // @[ReadEngine.scala 210:67]
  assign addr = iAddr; // @[ReadEngine.scala 211:21]
  assign NextAddr_m_CurAddr = iAddr; // @[SramAddrGen.scala 51:21]
  assign NextAddr_m_Len = spad_needed_len; // @[SramAddrGen.scala 52:21]
  assign NextAddr_m_Size = rSize; // @[SramAddrGen.scala 53:21]
  assign NextAddr_m_Burst = rBurst; // @[SramAddrGen.scala 54:21]
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[ReadEngine.scala 97:23]
      state <= 2'h0; // @[ReadEngine.scala 100:37 109:29 99:38]
    end else if (2'h0 == state) begin // @[ReadEngine.scala 97:23]
      if (s_axi_ar_valid) begin // @[ReadEngine.scala 117:29]
        state <= 2'h1; // @[ReadEngine.scala 118:43 119:33 124:33]
      end
    end else if (2'h1 == state) begin // @[ReadEngine.scala 97:23]
      if (ready) begin // @[ReadEngine.scala 140:30]
        if (leftLen == 8'h0) begin // @[ReadEngine.scala 141:29]
          state <= 2'h3;
        end else begin
          state <= 2'h2;
        end
      end
    end else if (2'h2 == state) begin // @[ReadEngine.scala 97:23]
      if (~ready) begin
        state <= 2'h1;
      end else begin
        state <= _GEN_20;
      end
    end else if (2'h3 == state) begin // @[ReadEngine.scala 67:28]
      state <= _GEN_28;
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[ReadEngine.scala 97:23]
      spad_needed_len <= 8'h0; // @[ReadEngine.scala 101:37 68:38 99:38]
    end else if (2'h0 == state) begin // @[ReadEngine.scala 68:38]
      if (s_axi_ar_valid) begin
        spad_needed_len <= s_axi_ar_bits_len;
      end
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[ReadEngine.scala 97:23]
      rId <= 6'h0; // @[ReadEngine.scala 102:37 110:29 99:38]
    end else if (2'h0 == state) begin // @[ReadEngine.scala 73:26]
      if (s_axi_ar_valid) begin
        rId <= s_axi_ar_bits_id;
      end else begin
        rId <= 6'h0;
      end
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[ReadEngine.scala 97:23]
      rBurst <= 2'h0; // @[ReadEngine.scala 106:37 112:29 99:38]
    end else if (2'h0 == state) begin // @[ReadEngine.scala 75:29]
      if (s_axi_ar_valid) begin
        rBurst <= s_axi_ar_bits_burst;
      end else begin
        rBurst <= 2'h0;
      end
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[ReadEngine.scala 97:23]
      rSize <= 3'h0; // @[ReadEngine.scala 107:37 113:29 99:38]
    end else if (2'h0 == state) begin // @[ReadEngine.scala 76:28]
      if (s_axi_ar_valid) begin
        rSize <= s_axi_ar_bits_size;
      end else begin
        rSize <= 3'h0;
      end
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[ReadEngine.scala 97:23]
      leftLen <= 8'h0; // @[ReadEngine.scala 105:37 79:30 99:38]
    end else if (2'h0 == state) begin // @[ReadEngine.scala 97:23]
      if (s_axi_ar_valid) begin
        leftLen <= s_axi_ar_bits_len;
      end
    end else if (!(2'h1 == state)) begin // @[ReadEngine.scala 97:23]
      if (2'h2 == state) begin // @[ReadEngine.scala 97:23]
        if (~ready) begin
          leftLen <= _leftLen_T_2;
        end else begin
          leftLen <= _GEN_22;
        end
      end else if (2'h3 == state) begin // @[ReadEngine.scala 79:30]
        leftLen <= _GEN_29;
      end
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[ReadEngine.scala 97:23]
      iAddr <= 17'h0; // @[ReadEngine.scala 104:37 84:34 99:38]
    end else if (2'h0 == state) begin // @[ReadEngine.scala 97:23]
      if (s_axi_ar_valid) begin // @[ReadEngine.scala 117:29]
        iAddr <= s_axi_ar_bits_addr; // @[ReadEngine.scala 118:43 122:33 128:33]
      end
    end else if (2'h1 == state) begin // @[ReadEngine.scala 97:23]
      if (ready) begin // @[ReadEngine.scala 140:30]
        if (!(leftLen == 8'h0)) begin // @[ReadEngine.scala 144:29]
          iAddr <= NextAddr;
        end
      end
    end else if (2'h2 == state) begin // @[ReadEngine.scala 97:23]
      if (!(~ready)) begin
        iAddr <= _GEN_21;
      end
    end else if (2'h3 == state) begin // @[ReadEngine.scala 84:34]
      iAddr <= _GEN_30;
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[ReadEngine.scala 218:27]
      Stream_data_reg <= 64'h0; // @[ReadEngine.scala 220:33]
    end else if (~SpadState) begin
      Stream_data_reg <= data;
    end
  end
  always @(posedge aclk or posedge reset) begin
    if (reset) begin // @[ReadEngine.scala 218:27]
      SpadState <= 1'h0; // @[ReadEngine.scala 222:60 223:31]
    end else if (~SpadState) begin // @[ReadEngine.scala 218:27]
      if (_s_axi_ar_ready_T | _valid_T_1) begin // @[ReadEngine.scala 231:39]
        SpadState <= 1'h0; // @[ReadEngine.scala 232:31]
      end else begin
        SpadState <= _GEN_52; // @[ReadEngine.scala 234:42 235:31 217:32]
      end
    end else if (SpadState) begin // @[ReadEngine.scala 217:32]
      if (_s_axi_ar_ready_T) begin
        SpadState <= 1'h0;
      end else if (s_axi_r_ready) begin
        SpadState <= 1'h0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  spad_needed_len = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  rId = _RAND_2[5:0];
  _RAND_3 = {1{`RANDOM}};
  rBurst = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  rSize = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  leftLen = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  iAddr = _RAND_6[16:0];
  _RAND_7 = {2{`RANDOM}};
  Stream_data_reg = _RAND_7[63:0];
  _RAND_8 = {1{`RANDOM}};
  SpadState = _RAND_8[0:0];
`endif // RANDOMIZE_REG_INIT
  if (reset) begin
    state = 2'h0;
  end
  if (reset) begin
    spad_needed_len = 8'h0;
  end
  if (reset) begin
    rId = 6'h0;
  end
  if (reset) begin
    rBurst = 2'h0;
  end
  if (reset) begin
    rSize = 3'h0;
  end
  if (reset) begin
    leftLen = 8'h0;
  end
  if (reset) begin
    iAddr = 17'h0;
  end
  if (reset) begin
    Stream_data_reg = 64'h0;
  end
  if (reset) begin
    SpadState = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SramArbiter(
  input        wrvalid,
  output       wrready,
  input        rdvalid,
  output       rdready,
  input  [3:0] wr_cs,
  input  [3:0] rd_cs
);
  assign wrready = wr_cs == rd_cs & wrvalid & rdvalid | wrvalid; // @[SramArbiter.scala 91:72 92:17 96:17]
  assign rdready = wr_cs == rd_cs & wrvalid & rdvalid ? 1'h0 : rdvalid; // @[SramArbiter.scala 91:72 93:17 97:17]
endmodule
module AXI4Scratchpad(
  input         clock,
  input         io_aclk,
  input         io_aresetn,
  output        io_s_axi_aw_ready,
  input         io_s_axi_aw_valid,
  input  [5:0]  io_s_axi_aw_bits_id,
  input  [16:0] io_s_axi_aw_bits_addr,
  input  [7:0]  io_s_axi_aw_bits_len,
  input  [2:0]  io_s_axi_aw_bits_size,
  input  [1:0]  io_s_axi_aw_bits_burst,
  output        io_s_axi_w_ready,
  input         io_s_axi_w_valid,
  input  [63:0] io_s_axi_w_bits_data,
  input         io_s_axi_w_bits_last,
  input         io_s_axi_b_ready,
  output        io_s_axi_b_valid,
  output [5:0]  io_s_axi_b_bits_id,
  output        io_s_axi_ar_ready,
  input         io_s_axi_ar_valid,
  input  [5:0]  io_s_axi_ar_bits_id,
  input  [16:0] io_s_axi_ar_bits_addr,
  input  [7:0]  io_s_axi_ar_bits_len,
  input  [2:0]  io_s_axi_ar_bits_size,
  input  [1:0]  io_s_axi_ar_bits_burst,
  input         io_s_axi_r_ready,
  output        io_s_axi_r_valid,
  output [5:0]  io_s_axi_r_bits_id,
  output [63:0] io_s_axi_r_bits_data,
  output        io_s_axi_r_bits_last,
  input         io_srams_0_en,
  input         io_srams_0_we,
  input  [11:0] io_srams_0_addr,
  input  [15:0] io_srams_0_din,
  output [15:0] io_srams_0_dout,
  input         io_srams_1_en,
  input         io_srams_1_we,
  input  [11:0] io_srams_1_addr,
  input  [15:0] io_srams_1_din,
  output [15:0] io_srams_1_dout,
  input         io_srams_2_en,
  input         io_srams_2_we,
  input  [11:0] io_srams_2_addr,
  input  [15:0] io_srams_2_din,
  output [15:0] io_srams_2_dout,
  input         io_srams_3_en,
  input         io_srams_3_we,
  input  [11:0] io_srams_3_addr,
  input  [15:0] io_srams_3_din,
  output [15:0] io_srams_3_dout,
  input         io_srams_4_en,
  input         io_srams_4_we,
  input  [11:0] io_srams_4_addr,
  input  [15:0] io_srams_4_din,
  output [15:0] io_srams_4_dout,
  input         io_srams_5_en,
  input         io_srams_5_we,
  input  [11:0] io_srams_5_addr,
  input  [15:0] io_srams_5_din,
  output [15:0] io_srams_5_dout,
  input         io_srams_6_en,
  input         io_srams_6_we,
  input  [11:0] io_srams_6_addr,
  input  [15:0] io_srams_6_din,
  output [15:0] io_srams_6_dout,
  input         io_srams_7_en,
  input         io_srams_7_we,
  input  [11:0] io_srams_7_addr,
  input  [15:0] io_srams_7_din,
  output [15:0] io_srams_7_dout,
  input         io_srams_8_en,
  input         io_srams_8_we,
  input  [11:0] io_srams_8_addr,
  input  [15:0] io_srams_8_din,
  output [15:0] io_srams_8_dout,
  input         io_srams_9_en,
  input         io_srams_9_we,
  input  [11:0] io_srams_9_addr,
  input  [15:0] io_srams_9_din,
  output [15:0] io_srams_9_dout,
  input         io_sram_last_en,
  input  [8:0]  io_sram_last_addr,
  output [63:0] io_sram_last_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  TrueDualPortSRAMAsym_clock; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_io_a_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_io_a_we; // @[AxiScratchpad.scala 90:11]
  wire [9:0] TrueDualPortSRAMAsym_io_a_addr; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_io_a_din; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_io_a_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_io_b_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_io_b_we; // @[AxiScratchpad.scala 90:11]
  wire [11:0] TrueDualPortSRAMAsym_io_b_addr; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_io_b_din; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_io_b_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_1_clock; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_1_io_a_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_1_io_a_we; // @[AxiScratchpad.scala 90:11]
  wire [9:0] TrueDualPortSRAMAsym_1_io_a_addr; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_1_io_a_din; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_1_io_a_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_1_io_b_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_1_io_b_we; // @[AxiScratchpad.scala 90:11]
  wire [11:0] TrueDualPortSRAMAsym_1_io_b_addr; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_1_io_b_din; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_1_io_b_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_2_clock; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_2_io_a_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_2_io_a_we; // @[AxiScratchpad.scala 90:11]
  wire [9:0] TrueDualPortSRAMAsym_2_io_a_addr; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_2_io_a_din; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_2_io_a_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_2_io_b_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_2_io_b_we; // @[AxiScratchpad.scala 90:11]
  wire [11:0] TrueDualPortSRAMAsym_2_io_b_addr; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_2_io_b_din; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_2_io_b_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_3_clock; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_3_io_a_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_3_io_a_we; // @[AxiScratchpad.scala 90:11]
  wire [9:0] TrueDualPortSRAMAsym_3_io_a_addr; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_3_io_a_din; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_3_io_a_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_3_io_b_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_3_io_b_we; // @[AxiScratchpad.scala 90:11]
  wire [11:0] TrueDualPortSRAMAsym_3_io_b_addr; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_3_io_b_din; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_3_io_b_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_4_clock; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_4_io_a_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_4_io_a_we; // @[AxiScratchpad.scala 90:11]
  wire [9:0] TrueDualPortSRAMAsym_4_io_a_addr; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_4_io_a_din; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_4_io_a_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_4_io_b_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_4_io_b_we; // @[AxiScratchpad.scala 90:11]
  wire [11:0] TrueDualPortSRAMAsym_4_io_b_addr; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_4_io_b_din; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_4_io_b_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_5_clock; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_5_io_a_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_5_io_a_we; // @[AxiScratchpad.scala 90:11]
  wire [9:0] TrueDualPortSRAMAsym_5_io_a_addr; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_5_io_a_din; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_5_io_a_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_5_io_b_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_5_io_b_we; // @[AxiScratchpad.scala 90:11]
  wire [11:0] TrueDualPortSRAMAsym_5_io_b_addr; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_5_io_b_din; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_5_io_b_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_6_clock; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_6_io_a_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_6_io_a_we; // @[AxiScratchpad.scala 90:11]
  wire [9:0] TrueDualPortSRAMAsym_6_io_a_addr; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_6_io_a_din; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_6_io_a_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_6_io_b_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_6_io_b_we; // @[AxiScratchpad.scala 90:11]
  wire [11:0] TrueDualPortSRAMAsym_6_io_b_addr; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_6_io_b_din; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_6_io_b_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_7_clock; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_7_io_a_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_7_io_a_we; // @[AxiScratchpad.scala 90:11]
  wire [9:0] TrueDualPortSRAMAsym_7_io_a_addr; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_7_io_a_din; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_7_io_a_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_7_io_b_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_7_io_b_we; // @[AxiScratchpad.scala 90:11]
  wire [11:0] TrueDualPortSRAMAsym_7_io_b_addr; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_7_io_b_din; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_7_io_b_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_8_clock; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_8_io_a_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_8_io_a_we; // @[AxiScratchpad.scala 90:11]
  wire [9:0] TrueDualPortSRAMAsym_8_io_a_addr; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_8_io_a_din; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_8_io_a_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_8_io_b_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_8_io_b_we; // @[AxiScratchpad.scala 90:11]
  wire [11:0] TrueDualPortSRAMAsym_8_io_b_addr; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_8_io_b_din; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_8_io_b_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_9_clock; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_9_io_a_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_9_io_a_we; // @[AxiScratchpad.scala 90:11]
  wire [9:0] TrueDualPortSRAMAsym_9_io_a_addr; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_9_io_a_din; // @[AxiScratchpad.scala 90:11]
  wire [63:0] TrueDualPortSRAMAsym_9_io_a_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_9_io_b_en; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAMAsym_9_io_b_we; // @[AxiScratchpad.scala 90:11]
  wire [11:0] TrueDualPortSRAMAsym_9_io_b_addr; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_9_io_b_din; // @[AxiScratchpad.scala 90:11]
  wire [15:0] TrueDualPortSRAMAsym_9_io_b_dout; // @[AxiScratchpad.scala 90:11]
  wire  TrueDualPortSRAM_64_9_clock; // @[AxiScratchpad.scala 97:33]
  wire  TrueDualPortSRAM_64_9_io_a_en; // @[AxiScratchpad.scala 97:33]
  wire  TrueDualPortSRAM_64_9_io_a_we; // @[AxiScratchpad.scala 97:33]
  wire [8:0] TrueDualPortSRAM_64_9_io_a_addr; // @[AxiScratchpad.scala 97:33]
  wire [63:0] TrueDualPortSRAM_64_9_io_a_din; // @[AxiScratchpad.scala 97:33]
  wire [63:0] TrueDualPortSRAM_64_9_io_a_dout; // @[AxiScratchpad.scala 97:33]
  wire  TrueDualPortSRAM_64_9_io_b_en; // @[AxiScratchpad.scala 97:33]
  wire [8:0] TrueDualPortSRAM_64_9_io_b_addr; // @[AxiScratchpad.scala 97:33]
  wire [63:0] TrueDualPortSRAM_64_9_io_b_dout; // @[AxiScratchpad.scala 97:33]
  wire  wrIE_aclk; // @[AxiScratchpad.scala 130:25]
  wire  wrIE_aresetn; // @[AxiScratchpad.scala 130:25]
  wire  wrIE_s_axi_aw_ready; // @[AxiScratchpad.scala 130:25]
  wire  wrIE_s_axi_aw_valid; // @[AxiScratchpad.scala 130:25]
  wire [5:0] wrIE_s_axi_aw_bits_id; // @[AxiScratchpad.scala 130:25]
  wire [16:0] wrIE_s_axi_aw_bits_addr; // @[AxiScratchpad.scala 130:25]
  wire [7:0] wrIE_s_axi_aw_bits_len; // @[AxiScratchpad.scala 130:25]
  wire [2:0] wrIE_s_axi_aw_bits_size; // @[AxiScratchpad.scala 130:25]
  wire [1:0] wrIE_s_axi_aw_bits_burst; // @[AxiScratchpad.scala 130:25]
  wire  wrIE_s_axi_w_ready; // @[AxiScratchpad.scala 130:25]
  wire  wrIE_s_axi_w_valid; // @[AxiScratchpad.scala 130:25]
  wire [63:0] wrIE_s_axi_w_bits_data; // @[AxiScratchpad.scala 130:25]
  wire  wrIE_s_axi_w_bits_last; // @[AxiScratchpad.scala 130:25]
  wire  wrIE_s_axi_b_ready; // @[AxiScratchpad.scala 130:25]
  wire  wrIE_s_axi_b_valid; // @[AxiScratchpad.scala 130:25]
  wire [5:0] wrIE_s_axi_b_bits_id; // @[AxiScratchpad.scala 130:25]
  wire  wrIE_ready; // @[AxiScratchpad.scala 130:25]
  wire  wrIE_valid; // @[AxiScratchpad.scala 130:25]
  wire [16:0] wrIE_addr; // @[AxiScratchpad.scala 130:25]
  wire [63:0] wrIE_data; // @[AxiScratchpad.scala 130:25]
  wire  rdIE_aclk; // @[AxiScratchpad.scala 131:25]
  wire  rdIE_aresetn; // @[AxiScratchpad.scala 131:25]
  wire  rdIE_s_axi_ar_ready; // @[AxiScratchpad.scala 131:25]
  wire  rdIE_s_axi_ar_valid; // @[AxiScratchpad.scala 131:25]
  wire [5:0] rdIE_s_axi_ar_bits_id; // @[AxiScratchpad.scala 131:25]
  wire [16:0] rdIE_s_axi_ar_bits_addr; // @[AxiScratchpad.scala 131:25]
  wire [7:0] rdIE_s_axi_ar_bits_len; // @[AxiScratchpad.scala 131:25]
  wire [2:0] rdIE_s_axi_ar_bits_size; // @[AxiScratchpad.scala 131:25]
  wire [1:0] rdIE_s_axi_ar_bits_burst; // @[AxiScratchpad.scala 131:25]
  wire  rdIE_s_axi_r_ready; // @[AxiScratchpad.scala 131:25]
  wire  rdIE_s_axi_r_valid; // @[AxiScratchpad.scala 131:25]
  wire [5:0] rdIE_s_axi_r_bits_id; // @[AxiScratchpad.scala 131:25]
  wire [63:0] rdIE_s_axi_r_bits_data; // @[AxiScratchpad.scala 131:25]
  wire  rdIE_s_axi_r_bits_last; // @[AxiScratchpad.scala 131:25]
  wire  rdIE_ready; // @[AxiScratchpad.scala 131:25]
  wire  rdIE_valid; // @[AxiScratchpad.scala 131:25]
  wire [16:0] rdIE_addr; // @[AxiScratchpad.scala 131:25]
  wire [63:0] rdIE_data; // @[AxiScratchpad.scala 131:25]
  wire  arbiter_wrvalid; // @[AxiScratchpad.scala 132:25]
  wire  arbiter_wrready; // @[AxiScratchpad.scala 132:25]
  wire  arbiter_rdvalid; // @[AxiScratchpad.scala 132:25]
  wire  arbiter_rdready; // @[AxiScratchpad.scala 132:25]
  wire [3:0] arbiter_wr_cs; // @[AxiScratchpad.scala 132:25]
  wire [3:0] arbiter_rd_cs; // @[AxiScratchpad.scala 132:25]
  wire [3:0] wr_csel = wrIE_addr[16:13]; // @[AxiScratchpad.scala 137:34]
  wire [9:0] wr_spad_addr = wrIE_addr[12:3]; // @[AxiScratchpad.scala 138:34]
  wire [3:0] rd_csel = rdIE_addr[16:13]; // @[AxiScratchpad.scala 139:34]
  wire [9:0] rd_spad_addr = rdIE_addr[12:3]; // @[AxiScratchpad.scala 140:34]
  reg [3:0] currentRdBank; // @[AxiScratchpad.scala 164:32]
  wire [63:0] _rdIE_data_T_1 = 4'h0 == currentRdBank ? TrueDualPortSRAMAsym_io_a_dout : 64'h0; // @[Mux.scala 81:58]
  wire [63:0] _rdIE_data_T_3 = 4'h1 == currentRdBank ? TrueDualPortSRAMAsym_1_io_a_dout : _rdIE_data_T_1; // @[Mux.scala 81:58]
  wire [63:0] _rdIE_data_T_5 = 4'h2 == currentRdBank ? TrueDualPortSRAMAsym_2_io_a_dout : _rdIE_data_T_3; // @[Mux.scala 81:58]
  wire [63:0] _rdIE_data_T_7 = 4'h3 == currentRdBank ? TrueDualPortSRAMAsym_3_io_a_dout : _rdIE_data_T_5; // @[Mux.scala 81:58]
  wire [63:0] _rdIE_data_T_9 = 4'h4 == currentRdBank ? TrueDualPortSRAMAsym_4_io_a_dout : _rdIE_data_T_7; // @[Mux.scala 81:58]
  wire [63:0] _rdIE_data_T_11 = 4'h5 == currentRdBank ? TrueDualPortSRAMAsym_5_io_a_dout : _rdIE_data_T_9; // @[Mux.scala 81:58]
  wire [63:0] _rdIE_data_T_13 = 4'h6 == currentRdBank ? TrueDualPortSRAMAsym_6_io_a_dout : _rdIE_data_T_11; // @[Mux.scala 81:58]
  wire [63:0] _rdIE_data_T_15 = 4'h7 == currentRdBank ? TrueDualPortSRAMAsym_7_io_a_dout : _rdIE_data_T_13; // @[Mux.scala 81:58]
  wire [63:0] _rdIE_data_T_17 = 4'h8 == currentRdBank ? TrueDualPortSRAMAsym_8_io_a_dout : _rdIE_data_T_15; // @[Mux.scala 81:58]
  wire [63:0] _rdIE_data_T_19 = 4'h9 == currentRdBank ? TrueDualPortSRAMAsym_9_io_a_dout : _rdIE_data_T_17; // @[Mux.scala 81:58]
  wire  _en_T = wr_csel == 4'h0; // @[AxiScratchpad.scala 175:25]
  wire  _en_T_2 = rd_csel == 4'h0; // @[AxiScratchpad.scala 175:58]
  wire  en = wr_csel == 4'h0 & wrIE_ready | rd_csel == 4'h0 & rdIE_ready; // @[AxiScratchpad.scala 175:47]
  wire  _we_T = wrIE_ready & wrIE_valid; // @[AxiScratchpad.scala 176:27]
  wire  we = wrIE_ready & wrIE_valid & _en_T; // @[AxiScratchpad.scala 176:40]
  wire  _re_T = rdIE_ready & rdIE_valid; // @[AxiScratchpad.scala 177:27]
  wire  re = rdIE_ready & rdIE_valid & _en_T_2; // @[AxiScratchpad.scala 177:40]
  wire  _en_T_4 = wr_csel == 4'h1; // @[AxiScratchpad.scala 175:25]
  wire  _en_T_6 = rd_csel == 4'h1; // @[AxiScratchpad.scala 175:58]
  wire  en_1 = wr_csel == 4'h1 & wrIE_ready | rd_csel == 4'h1 & rdIE_ready; // @[AxiScratchpad.scala 175:47]
  wire  we_1 = wrIE_ready & wrIE_valid & _en_T_4; // @[AxiScratchpad.scala 176:40]
  wire  re_1 = rdIE_ready & rdIE_valid & _en_T_6; // @[AxiScratchpad.scala 177:40]
  wire  _en_T_8 = wr_csel == 4'h2; // @[AxiScratchpad.scala 175:25]
  wire  _en_T_10 = rd_csel == 4'h2; // @[AxiScratchpad.scala 175:58]
  wire  en_2 = wr_csel == 4'h2 & wrIE_ready | rd_csel == 4'h2 & rdIE_ready; // @[AxiScratchpad.scala 175:47]
  wire  we_2 = wrIE_ready & wrIE_valid & _en_T_8; // @[AxiScratchpad.scala 176:40]
  wire  re_2 = rdIE_ready & rdIE_valid & _en_T_10; // @[AxiScratchpad.scala 177:40]
  wire  _en_T_12 = wr_csel == 4'h3; // @[AxiScratchpad.scala 175:25]
  wire  _en_T_14 = rd_csel == 4'h3; // @[AxiScratchpad.scala 175:58]
  wire  en_3 = wr_csel == 4'h3 & wrIE_ready | rd_csel == 4'h3 & rdIE_ready; // @[AxiScratchpad.scala 175:47]
  wire  we_3 = wrIE_ready & wrIE_valid & _en_T_12; // @[AxiScratchpad.scala 176:40]
  wire  re_3 = rdIE_ready & rdIE_valid & _en_T_14; // @[AxiScratchpad.scala 177:40]
  wire  _en_T_16 = wr_csel == 4'h4; // @[AxiScratchpad.scala 175:25]
  wire  _en_T_18 = rd_csel == 4'h4; // @[AxiScratchpad.scala 175:58]
  wire  en_4 = wr_csel == 4'h4 & wrIE_ready | rd_csel == 4'h4 & rdIE_ready; // @[AxiScratchpad.scala 175:47]
  wire  we_4 = wrIE_ready & wrIE_valid & _en_T_16; // @[AxiScratchpad.scala 176:40]
  wire  re_4 = rdIE_ready & rdIE_valid & _en_T_18; // @[AxiScratchpad.scala 177:40]
  wire  _en_T_20 = wr_csel == 4'h5; // @[AxiScratchpad.scala 175:25]
  wire  _en_T_22 = rd_csel == 4'h5; // @[AxiScratchpad.scala 175:58]
  wire  en_5 = wr_csel == 4'h5 & wrIE_ready | rd_csel == 4'h5 & rdIE_ready; // @[AxiScratchpad.scala 175:47]
  wire  we_5 = wrIE_ready & wrIE_valid & _en_T_20; // @[AxiScratchpad.scala 176:40]
  wire  re_5 = rdIE_ready & rdIE_valid & _en_T_22; // @[AxiScratchpad.scala 177:40]
  wire  _en_T_24 = wr_csel == 4'h6; // @[AxiScratchpad.scala 175:25]
  wire  _en_T_26 = rd_csel == 4'h6; // @[AxiScratchpad.scala 175:58]
  wire  en_6 = wr_csel == 4'h6 & wrIE_ready | rd_csel == 4'h6 & rdIE_ready; // @[AxiScratchpad.scala 175:47]
  wire  we_6 = wrIE_ready & wrIE_valid & _en_T_24; // @[AxiScratchpad.scala 176:40]
  wire  re_6 = rdIE_ready & rdIE_valid & _en_T_26; // @[AxiScratchpad.scala 177:40]
  wire  _en_T_28 = wr_csel == 4'h7; // @[AxiScratchpad.scala 175:25]
  wire  _en_T_30 = rd_csel == 4'h7; // @[AxiScratchpad.scala 175:58]
  wire  en_7 = wr_csel == 4'h7 & wrIE_ready | rd_csel == 4'h7 & rdIE_ready; // @[AxiScratchpad.scala 175:47]
  wire  we_7 = wrIE_ready & wrIE_valid & _en_T_28; // @[AxiScratchpad.scala 176:40]
  wire  re_7 = rdIE_ready & rdIE_valid & _en_T_30; // @[AxiScratchpad.scala 177:40]
  wire  _en_T_32 = wr_csel == 4'h8; // @[AxiScratchpad.scala 175:25]
  wire  _en_T_34 = rd_csel == 4'h8; // @[AxiScratchpad.scala 175:58]
  wire  en_8 = wr_csel == 4'h8 & wrIE_ready | rd_csel == 4'h8 & rdIE_ready; // @[AxiScratchpad.scala 175:47]
  wire  we_8 = wrIE_ready & wrIE_valid & _en_T_32; // @[AxiScratchpad.scala 176:40]
  wire  re_8 = rdIE_ready & rdIE_valid & _en_T_34; // @[AxiScratchpad.scala 177:40]
  wire  _en_T_36 = wr_csel == 4'h9; // @[AxiScratchpad.scala 175:25]
  wire  _en_T_38 = rd_csel == 4'h9; // @[AxiScratchpad.scala 175:58]
  wire  en_9 = wr_csel == 4'h9 & wrIE_ready | rd_csel == 4'h9 & rdIE_ready; // @[AxiScratchpad.scala 175:47]
  wire  we_9 = wrIE_ready & wrIE_valid & _en_T_36; // @[AxiScratchpad.scala 176:40]
  wire  re_9 = rdIE_ready & rdIE_valid & _en_T_38; // @[AxiScratchpad.scala 177:40]
  wire  _en_last_T = wr_csel == 4'ha; // @[AxiScratchpad.scala 200:28]
  wire  en_last = wr_csel == 4'ha & wrIE_ready | rd_csel == 4'ha & rdIE_ready; // @[AxiScratchpad.scala 200:61]
  wire  we_last = _we_T & _en_last_T; // @[AxiScratchpad.scala 201:43]
  wire  re_last = _re_T & _en_last_T; // @[AxiScratchpad.scala 202:43]
  wire [9:0] _T_20 = we_last ? wr_spad_addr : rd_spad_addr; // @[AxiScratchpad.scala 204:40]
  TrueDualPortSRAMAsym TrueDualPortSRAMAsym ( // @[AxiScratchpad.scala 90:11]
    .clock(TrueDualPortSRAMAsym_clock),
    .io_a_en(TrueDualPortSRAMAsym_io_a_en),
    .io_a_we(TrueDualPortSRAMAsym_io_a_we),
    .io_a_addr(TrueDualPortSRAMAsym_io_a_addr),
    .io_a_din(TrueDualPortSRAMAsym_io_a_din),
    .io_a_dout(TrueDualPortSRAMAsym_io_a_dout),
    .io_b_en(TrueDualPortSRAMAsym_io_b_en),
    .io_b_we(TrueDualPortSRAMAsym_io_b_we),
    .io_b_addr(TrueDualPortSRAMAsym_io_b_addr),
    .io_b_din(TrueDualPortSRAMAsym_io_b_din),
    .io_b_dout(TrueDualPortSRAMAsym_io_b_dout)
  );
  TrueDualPortSRAMAsym TrueDualPortSRAMAsym_1 ( // @[AxiScratchpad.scala 90:11]
    .clock(TrueDualPortSRAMAsym_1_clock),
    .io_a_en(TrueDualPortSRAMAsym_1_io_a_en),
    .io_a_we(TrueDualPortSRAMAsym_1_io_a_we),
    .io_a_addr(TrueDualPortSRAMAsym_1_io_a_addr),
    .io_a_din(TrueDualPortSRAMAsym_1_io_a_din),
    .io_a_dout(TrueDualPortSRAMAsym_1_io_a_dout),
    .io_b_en(TrueDualPortSRAMAsym_1_io_b_en),
    .io_b_we(TrueDualPortSRAMAsym_1_io_b_we),
    .io_b_addr(TrueDualPortSRAMAsym_1_io_b_addr),
    .io_b_din(TrueDualPortSRAMAsym_1_io_b_din),
    .io_b_dout(TrueDualPortSRAMAsym_1_io_b_dout)
  );
  TrueDualPortSRAMAsym TrueDualPortSRAMAsym_2 ( // @[AxiScratchpad.scala 90:11]
    .clock(TrueDualPortSRAMAsym_2_clock),
    .io_a_en(TrueDualPortSRAMAsym_2_io_a_en),
    .io_a_we(TrueDualPortSRAMAsym_2_io_a_we),
    .io_a_addr(TrueDualPortSRAMAsym_2_io_a_addr),
    .io_a_din(TrueDualPortSRAMAsym_2_io_a_din),
    .io_a_dout(TrueDualPortSRAMAsym_2_io_a_dout),
    .io_b_en(TrueDualPortSRAMAsym_2_io_b_en),
    .io_b_we(TrueDualPortSRAMAsym_2_io_b_we),
    .io_b_addr(TrueDualPortSRAMAsym_2_io_b_addr),
    .io_b_din(TrueDualPortSRAMAsym_2_io_b_din),
    .io_b_dout(TrueDualPortSRAMAsym_2_io_b_dout)
  );
  TrueDualPortSRAMAsym TrueDualPortSRAMAsym_3 ( // @[AxiScratchpad.scala 90:11]
    .clock(TrueDualPortSRAMAsym_3_clock),
    .io_a_en(TrueDualPortSRAMAsym_3_io_a_en),
    .io_a_we(TrueDualPortSRAMAsym_3_io_a_we),
    .io_a_addr(TrueDualPortSRAMAsym_3_io_a_addr),
    .io_a_din(TrueDualPortSRAMAsym_3_io_a_din),
    .io_a_dout(TrueDualPortSRAMAsym_3_io_a_dout),
    .io_b_en(TrueDualPortSRAMAsym_3_io_b_en),
    .io_b_we(TrueDualPortSRAMAsym_3_io_b_we),
    .io_b_addr(TrueDualPortSRAMAsym_3_io_b_addr),
    .io_b_din(TrueDualPortSRAMAsym_3_io_b_din),
    .io_b_dout(TrueDualPortSRAMAsym_3_io_b_dout)
  );
  TrueDualPortSRAMAsym TrueDualPortSRAMAsym_4 ( // @[AxiScratchpad.scala 90:11]
    .clock(TrueDualPortSRAMAsym_4_clock),
    .io_a_en(TrueDualPortSRAMAsym_4_io_a_en),
    .io_a_we(TrueDualPortSRAMAsym_4_io_a_we),
    .io_a_addr(TrueDualPortSRAMAsym_4_io_a_addr),
    .io_a_din(TrueDualPortSRAMAsym_4_io_a_din),
    .io_a_dout(TrueDualPortSRAMAsym_4_io_a_dout),
    .io_b_en(TrueDualPortSRAMAsym_4_io_b_en),
    .io_b_we(TrueDualPortSRAMAsym_4_io_b_we),
    .io_b_addr(TrueDualPortSRAMAsym_4_io_b_addr),
    .io_b_din(TrueDualPortSRAMAsym_4_io_b_din),
    .io_b_dout(TrueDualPortSRAMAsym_4_io_b_dout)
  );
  TrueDualPortSRAMAsym TrueDualPortSRAMAsym_5 ( // @[AxiScratchpad.scala 90:11]
    .clock(TrueDualPortSRAMAsym_5_clock),
    .io_a_en(TrueDualPortSRAMAsym_5_io_a_en),
    .io_a_we(TrueDualPortSRAMAsym_5_io_a_we),
    .io_a_addr(TrueDualPortSRAMAsym_5_io_a_addr),
    .io_a_din(TrueDualPortSRAMAsym_5_io_a_din),
    .io_a_dout(TrueDualPortSRAMAsym_5_io_a_dout),
    .io_b_en(TrueDualPortSRAMAsym_5_io_b_en),
    .io_b_we(TrueDualPortSRAMAsym_5_io_b_we),
    .io_b_addr(TrueDualPortSRAMAsym_5_io_b_addr),
    .io_b_din(TrueDualPortSRAMAsym_5_io_b_din),
    .io_b_dout(TrueDualPortSRAMAsym_5_io_b_dout)
  );
  TrueDualPortSRAMAsym TrueDualPortSRAMAsym_6 ( // @[AxiScratchpad.scala 90:11]
    .clock(TrueDualPortSRAMAsym_6_clock),
    .io_a_en(TrueDualPortSRAMAsym_6_io_a_en),
    .io_a_we(TrueDualPortSRAMAsym_6_io_a_we),
    .io_a_addr(TrueDualPortSRAMAsym_6_io_a_addr),
    .io_a_din(TrueDualPortSRAMAsym_6_io_a_din),
    .io_a_dout(TrueDualPortSRAMAsym_6_io_a_dout),
    .io_b_en(TrueDualPortSRAMAsym_6_io_b_en),
    .io_b_we(TrueDualPortSRAMAsym_6_io_b_we),
    .io_b_addr(TrueDualPortSRAMAsym_6_io_b_addr),
    .io_b_din(TrueDualPortSRAMAsym_6_io_b_din),
    .io_b_dout(TrueDualPortSRAMAsym_6_io_b_dout)
  );
  TrueDualPortSRAMAsym TrueDualPortSRAMAsym_7 ( // @[AxiScratchpad.scala 90:11]
    .clock(TrueDualPortSRAMAsym_7_clock),
    .io_a_en(TrueDualPortSRAMAsym_7_io_a_en),
    .io_a_we(TrueDualPortSRAMAsym_7_io_a_we),
    .io_a_addr(TrueDualPortSRAMAsym_7_io_a_addr),
    .io_a_din(TrueDualPortSRAMAsym_7_io_a_din),
    .io_a_dout(TrueDualPortSRAMAsym_7_io_a_dout),
    .io_b_en(TrueDualPortSRAMAsym_7_io_b_en),
    .io_b_we(TrueDualPortSRAMAsym_7_io_b_we),
    .io_b_addr(TrueDualPortSRAMAsym_7_io_b_addr),
    .io_b_din(TrueDualPortSRAMAsym_7_io_b_din),
    .io_b_dout(TrueDualPortSRAMAsym_7_io_b_dout)
  );
  TrueDualPortSRAMAsym TrueDualPortSRAMAsym_8 ( // @[AxiScratchpad.scala 90:11]
    .clock(TrueDualPortSRAMAsym_8_clock),
    .io_a_en(TrueDualPortSRAMAsym_8_io_a_en),
    .io_a_we(TrueDualPortSRAMAsym_8_io_a_we),
    .io_a_addr(TrueDualPortSRAMAsym_8_io_a_addr),
    .io_a_din(TrueDualPortSRAMAsym_8_io_a_din),
    .io_a_dout(TrueDualPortSRAMAsym_8_io_a_dout),
    .io_b_en(TrueDualPortSRAMAsym_8_io_b_en),
    .io_b_we(TrueDualPortSRAMAsym_8_io_b_we),
    .io_b_addr(TrueDualPortSRAMAsym_8_io_b_addr),
    .io_b_din(TrueDualPortSRAMAsym_8_io_b_din),
    .io_b_dout(TrueDualPortSRAMAsym_8_io_b_dout)
  );
  TrueDualPortSRAMAsym TrueDualPortSRAMAsym_9 ( // @[AxiScratchpad.scala 90:11]
    .clock(TrueDualPortSRAMAsym_9_clock),
    .io_a_en(TrueDualPortSRAMAsym_9_io_a_en),
    .io_a_we(TrueDualPortSRAMAsym_9_io_a_we),
    .io_a_addr(TrueDualPortSRAMAsym_9_io_a_addr),
    .io_a_din(TrueDualPortSRAMAsym_9_io_a_din),
    .io_a_dout(TrueDualPortSRAMAsym_9_io_a_dout),
    .io_b_en(TrueDualPortSRAMAsym_9_io_b_en),
    .io_b_we(TrueDualPortSRAMAsym_9_io_b_we),
    .io_b_addr(TrueDualPortSRAMAsym_9_io_b_addr),
    .io_b_din(TrueDualPortSRAMAsym_9_io_b_din),
    .io_b_dout(TrueDualPortSRAMAsym_9_io_b_dout)
  );
  TrueDualPortSRAM_64_9 TrueDualPortSRAM_64_9 ( // @[AxiScratchpad.scala 97:33]
    .clock(TrueDualPortSRAM_64_9_clock),
    .io_a_en(TrueDualPortSRAM_64_9_io_a_en),
    .io_a_we(TrueDualPortSRAM_64_9_io_a_we),
    .io_a_addr(TrueDualPortSRAM_64_9_io_a_addr),
    .io_a_din(TrueDualPortSRAM_64_9_io_a_din),
    .io_a_dout(TrueDualPortSRAM_64_9_io_a_dout),
    .io_b_en(TrueDualPortSRAM_64_9_io_b_en),
    .io_b_addr(TrueDualPortSRAM_64_9_io_b_addr),
    .io_b_dout(TrueDualPortSRAM_64_9_io_b_dout)
  );
  WriteEngine wrIE ( // @[AxiScratchpad.scala 130:25]
    .aclk(wrIE_aclk),
    .aresetn(wrIE_aresetn),
    .s_axi_aw_ready(wrIE_s_axi_aw_ready),
    .s_axi_aw_valid(wrIE_s_axi_aw_valid),
    .s_axi_aw_bits_id(wrIE_s_axi_aw_bits_id),
    .s_axi_aw_bits_addr(wrIE_s_axi_aw_bits_addr),
    .s_axi_aw_bits_len(wrIE_s_axi_aw_bits_len),
    .s_axi_aw_bits_size(wrIE_s_axi_aw_bits_size),
    .s_axi_aw_bits_burst(wrIE_s_axi_aw_bits_burst),
    .s_axi_w_ready(wrIE_s_axi_w_ready),
    .s_axi_w_valid(wrIE_s_axi_w_valid),
    .s_axi_w_bits_data(wrIE_s_axi_w_bits_data),
    .s_axi_w_bits_last(wrIE_s_axi_w_bits_last),
    .s_axi_b_ready(wrIE_s_axi_b_ready),
    .s_axi_b_valid(wrIE_s_axi_b_valid),
    .s_axi_b_bits_id(wrIE_s_axi_b_bits_id),
    .ready(wrIE_ready),
    .valid(wrIE_valid),
    .addr(wrIE_addr),
    .data(wrIE_data)
  );
  ReadEngine rdIE ( // @[AxiScratchpad.scala 131:25]
    .aclk(rdIE_aclk),
    .aresetn(rdIE_aresetn),
    .s_axi_ar_ready(rdIE_s_axi_ar_ready),
    .s_axi_ar_valid(rdIE_s_axi_ar_valid),
    .s_axi_ar_bits_id(rdIE_s_axi_ar_bits_id),
    .s_axi_ar_bits_addr(rdIE_s_axi_ar_bits_addr),
    .s_axi_ar_bits_len(rdIE_s_axi_ar_bits_len),
    .s_axi_ar_bits_size(rdIE_s_axi_ar_bits_size),
    .s_axi_ar_bits_burst(rdIE_s_axi_ar_bits_burst),
    .s_axi_r_ready(rdIE_s_axi_r_ready),
    .s_axi_r_valid(rdIE_s_axi_r_valid),
    .s_axi_r_bits_id(rdIE_s_axi_r_bits_id),
    .s_axi_r_bits_data(rdIE_s_axi_r_bits_data),
    .s_axi_r_bits_last(rdIE_s_axi_r_bits_last),
    .ready(rdIE_ready),
    .valid(rdIE_valid),
    .addr(rdIE_addr),
    .data(rdIE_data)
  );
  SramArbiter arbiter ( // @[AxiScratchpad.scala 132:25]
    .wrvalid(arbiter_wrvalid),
    .wrready(arbiter_wrready),
    .rdvalid(arbiter_rdvalid),
    .rdready(arbiter_rdready),
    .wr_cs(arbiter_wr_cs),
    .rd_cs(arbiter_rd_cs)
  );
  assign io_s_axi_aw_ready = wrIE_s_axi_aw_ready; // @[AxiScratchpad.scala 122:25 148:21]
  assign io_s_axi_w_ready = wrIE_s_axi_w_ready; // @[AxiScratchpad.scala 122:25 148:21]
  assign io_s_axi_b_valid = wrIE_s_axi_b_valid; // @[AxiScratchpad.scala 122:25 148:21]
  assign io_s_axi_b_bits_id = wrIE_s_axi_b_bits_id; // @[AxiScratchpad.scala 122:25 148:21]
  assign io_s_axi_ar_ready = rdIE_s_axi_ar_ready; // @[AxiScratchpad.scala 118:24 153:21]
  assign io_s_axi_r_valid = rdIE_s_axi_r_valid; // @[AxiScratchpad.scala 118:24 153:21]
  assign io_s_axi_r_bits_id = rdIE_s_axi_r_bits_id; // @[AxiScratchpad.scala 118:24 153:21]
  assign io_s_axi_r_bits_data = rdIE_s_axi_r_bits_data; // @[AxiScratchpad.scala 118:24 153:21]
  assign io_s_axi_r_bits_last = rdIE_s_axi_r_bits_last; // @[AxiScratchpad.scala 118:24 153:21]
  assign io_srams_0_dout = TrueDualPortSRAMAsym_io_b_dout; // @[AxiScratchpad.scala 104:16]
  assign io_srams_1_dout = TrueDualPortSRAMAsym_1_io_b_dout; // @[AxiScratchpad.scala 104:16]
  assign io_srams_2_dout = TrueDualPortSRAMAsym_2_io_b_dout; // @[AxiScratchpad.scala 104:16]
  assign io_srams_3_dout = TrueDualPortSRAMAsym_3_io_b_dout; // @[AxiScratchpad.scala 104:16]
  assign io_srams_4_dout = TrueDualPortSRAMAsym_4_io_b_dout; // @[AxiScratchpad.scala 104:16]
  assign io_srams_5_dout = TrueDualPortSRAMAsym_5_io_b_dout; // @[AxiScratchpad.scala 104:16]
  assign io_srams_6_dout = TrueDualPortSRAMAsym_6_io_b_dout; // @[AxiScratchpad.scala 104:16]
  assign io_srams_7_dout = TrueDualPortSRAMAsym_7_io_b_dout; // @[AxiScratchpad.scala 104:16]
  assign io_srams_8_dout = TrueDualPortSRAMAsym_8_io_b_dout; // @[AxiScratchpad.scala 104:16]
  assign io_srams_9_dout = TrueDualPortSRAMAsym_9_io_b_dout; // @[AxiScratchpad.scala 104:16]
  assign io_sram_last_dout = TrueDualPortSRAM_64_9_io_b_dout; // @[AxiScratchpad.scala 108:23]
  assign TrueDualPortSRAMAsym_clock = clock;
  assign TrueDualPortSRAMAsym_io_a_en = en & (we | re); // @[AxiScratchpad.scala 178:15 180:25 186:25]
  assign TrueDualPortSRAMAsym_io_a_we = en & we; // @[AxiScratchpad.scala 178:15 182:25 188:25]
  assign TrueDualPortSRAMAsym_io_a_addr = we ? wr_spad_addr : rd_spad_addr; // @[AxiScratchpad.scala 179:31]
  assign TrueDualPortSRAMAsym_io_a_din = wrIE_data; // @[AxiScratchpad.scala 178:15 181:25]
  assign TrueDualPortSRAMAsym_io_b_en = io_srams_0_en; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_io_b_we = io_srams_0_we; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_io_b_addr = io_srams_0_addr; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_io_b_din = io_srams_0_din; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_1_clock = clock;
  assign TrueDualPortSRAMAsym_1_io_a_en = en_1 & (we_1 | re_1); // @[AxiScratchpad.scala 178:15 180:25 186:25]
  assign TrueDualPortSRAMAsym_1_io_a_we = en_1 & we_1; // @[AxiScratchpad.scala 178:15 182:25 188:25]
  assign TrueDualPortSRAMAsym_1_io_a_addr = we_1 ? wr_spad_addr : rd_spad_addr; // @[AxiScratchpad.scala 179:31]
  assign TrueDualPortSRAMAsym_1_io_a_din = wrIE_data; // @[AxiScratchpad.scala 178:15 181:25]
  assign TrueDualPortSRAMAsym_1_io_b_en = io_srams_1_en; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_1_io_b_we = io_srams_1_we; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_1_io_b_addr = io_srams_1_addr; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_1_io_b_din = io_srams_1_din; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_2_clock = clock;
  assign TrueDualPortSRAMAsym_2_io_a_en = en_2 & (we_2 | re_2); // @[AxiScratchpad.scala 178:15 180:25 186:25]
  assign TrueDualPortSRAMAsym_2_io_a_we = en_2 & we_2; // @[AxiScratchpad.scala 178:15 182:25 188:25]
  assign TrueDualPortSRAMAsym_2_io_a_addr = we_2 ? wr_spad_addr : rd_spad_addr; // @[AxiScratchpad.scala 179:31]
  assign TrueDualPortSRAMAsym_2_io_a_din = wrIE_data; // @[AxiScratchpad.scala 178:15 181:25]
  assign TrueDualPortSRAMAsym_2_io_b_en = io_srams_2_en; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_2_io_b_we = io_srams_2_we; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_2_io_b_addr = io_srams_2_addr; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_2_io_b_din = io_srams_2_din; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_3_clock = clock;
  assign TrueDualPortSRAMAsym_3_io_a_en = en_3 & (we_3 | re_3); // @[AxiScratchpad.scala 178:15 180:25 186:25]
  assign TrueDualPortSRAMAsym_3_io_a_we = en_3 & we_3; // @[AxiScratchpad.scala 178:15 182:25 188:25]
  assign TrueDualPortSRAMAsym_3_io_a_addr = we_3 ? wr_spad_addr : rd_spad_addr; // @[AxiScratchpad.scala 179:31]
  assign TrueDualPortSRAMAsym_3_io_a_din = wrIE_data; // @[AxiScratchpad.scala 178:15 181:25]
  assign TrueDualPortSRAMAsym_3_io_b_en = io_srams_3_en; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_3_io_b_we = io_srams_3_we; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_3_io_b_addr = io_srams_3_addr; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_3_io_b_din = io_srams_3_din; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_4_clock = clock;
  assign TrueDualPortSRAMAsym_4_io_a_en = en_4 & (we_4 | re_4); // @[AxiScratchpad.scala 178:15 180:25 186:25]
  assign TrueDualPortSRAMAsym_4_io_a_we = en_4 & we_4; // @[AxiScratchpad.scala 178:15 182:25 188:25]
  assign TrueDualPortSRAMAsym_4_io_a_addr = we_4 ? wr_spad_addr : rd_spad_addr; // @[AxiScratchpad.scala 179:31]
  assign TrueDualPortSRAMAsym_4_io_a_din = wrIE_data; // @[AxiScratchpad.scala 178:15 181:25]
  assign TrueDualPortSRAMAsym_4_io_b_en = io_srams_4_en; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_4_io_b_we = io_srams_4_we; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_4_io_b_addr = io_srams_4_addr; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_4_io_b_din = io_srams_4_din; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_5_clock = clock;
  assign TrueDualPortSRAMAsym_5_io_a_en = en_5 & (we_5 | re_5); // @[AxiScratchpad.scala 178:15 180:25 186:25]
  assign TrueDualPortSRAMAsym_5_io_a_we = en_5 & we_5; // @[AxiScratchpad.scala 178:15 182:25 188:25]
  assign TrueDualPortSRAMAsym_5_io_a_addr = we_5 ? wr_spad_addr : rd_spad_addr; // @[AxiScratchpad.scala 179:31]
  assign TrueDualPortSRAMAsym_5_io_a_din = wrIE_data; // @[AxiScratchpad.scala 178:15 181:25]
  assign TrueDualPortSRAMAsym_5_io_b_en = io_srams_5_en; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_5_io_b_we = io_srams_5_we; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_5_io_b_addr = io_srams_5_addr; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_5_io_b_din = io_srams_5_din; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_6_clock = clock;
  assign TrueDualPortSRAMAsym_6_io_a_en = en_6 & (we_6 | re_6); // @[AxiScratchpad.scala 178:15 180:25 186:25]
  assign TrueDualPortSRAMAsym_6_io_a_we = en_6 & we_6; // @[AxiScratchpad.scala 178:15 182:25 188:25]
  assign TrueDualPortSRAMAsym_6_io_a_addr = we_6 ? wr_spad_addr : rd_spad_addr; // @[AxiScratchpad.scala 179:31]
  assign TrueDualPortSRAMAsym_6_io_a_din = wrIE_data; // @[AxiScratchpad.scala 178:15 181:25]
  assign TrueDualPortSRAMAsym_6_io_b_en = io_srams_6_en; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_6_io_b_we = io_srams_6_we; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_6_io_b_addr = io_srams_6_addr; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_6_io_b_din = io_srams_6_din; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_7_clock = clock;
  assign TrueDualPortSRAMAsym_7_io_a_en = en_7 & (we_7 | re_7); // @[AxiScratchpad.scala 178:15 180:25 186:25]
  assign TrueDualPortSRAMAsym_7_io_a_we = en_7 & we_7; // @[AxiScratchpad.scala 178:15 182:25 188:25]
  assign TrueDualPortSRAMAsym_7_io_a_addr = we_7 ? wr_spad_addr : rd_spad_addr; // @[AxiScratchpad.scala 179:31]
  assign TrueDualPortSRAMAsym_7_io_a_din = wrIE_data; // @[AxiScratchpad.scala 178:15 181:25]
  assign TrueDualPortSRAMAsym_7_io_b_en = io_srams_7_en; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_7_io_b_we = io_srams_7_we; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_7_io_b_addr = io_srams_7_addr; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_7_io_b_din = io_srams_7_din; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_8_clock = clock;
  assign TrueDualPortSRAMAsym_8_io_a_en = en_8 & (we_8 | re_8); // @[AxiScratchpad.scala 178:15 180:25 186:25]
  assign TrueDualPortSRAMAsym_8_io_a_we = en_8 & we_8; // @[AxiScratchpad.scala 178:15 182:25 188:25]
  assign TrueDualPortSRAMAsym_8_io_a_addr = we_8 ? wr_spad_addr : rd_spad_addr; // @[AxiScratchpad.scala 179:31]
  assign TrueDualPortSRAMAsym_8_io_a_din = wrIE_data; // @[AxiScratchpad.scala 178:15 181:25]
  assign TrueDualPortSRAMAsym_8_io_b_en = io_srams_8_en; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_8_io_b_we = io_srams_8_we; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_8_io_b_addr = io_srams_8_addr; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_8_io_b_din = io_srams_8_din; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_9_clock = clock;
  assign TrueDualPortSRAMAsym_9_io_a_en = en_9 & (we_9 | re_9); // @[AxiScratchpad.scala 178:15 180:25 186:25]
  assign TrueDualPortSRAMAsym_9_io_a_we = en_9 & we_9; // @[AxiScratchpad.scala 178:15 182:25 188:25]
  assign TrueDualPortSRAMAsym_9_io_a_addr = we_9 ? wr_spad_addr : rd_spad_addr; // @[AxiScratchpad.scala 179:31]
  assign TrueDualPortSRAMAsym_9_io_a_din = wrIE_data; // @[AxiScratchpad.scala 178:15 181:25]
  assign TrueDualPortSRAMAsym_9_io_b_en = io_srams_9_en; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_9_io_b_we = io_srams_9_we; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_9_io_b_addr = io_srams_9_addr; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAMAsym_9_io_b_din = io_srams_9_din; // @[AxiScratchpad.scala 104:16]
  assign TrueDualPortSRAM_64_9_clock = clock;
  assign TrueDualPortSRAM_64_9_io_a_en = en_last & (we_last | re_last); // @[AxiScratchpad.scala 203:18 205:34 211:34]
  assign TrueDualPortSRAM_64_9_io_a_we = en_last & we_last; // @[AxiScratchpad.scala 203:18 207:34 213:34]
  assign TrueDualPortSRAM_64_9_io_a_addr = _T_20[8:0];
  assign TrueDualPortSRAM_64_9_io_a_din = wrIE_data; // @[AxiScratchpad.scala 203:18 206:34]
  assign TrueDualPortSRAM_64_9_io_b_en = io_sram_last_en; // @[AxiScratchpad.scala 108:23]
  assign TrueDualPortSRAM_64_9_io_b_addr = io_sram_last_addr; // @[AxiScratchpad.scala 108:23]
  assign wrIE_aclk = io_aclk; // @[AxiScratchpad.scala 146:21]
  assign wrIE_aresetn = io_aresetn; // @[AxiScratchpad.scala 147:21]
  assign wrIE_s_axi_aw_valid = io_s_axi_aw_valid; // @[AxiScratchpad.scala 122:25 123:17]
  assign wrIE_s_axi_aw_bits_id = io_s_axi_aw_bits_id; // @[AxiScratchpad.scala 122:25 123:17]
  assign wrIE_s_axi_aw_bits_addr = io_s_axi_aw_bits_addr; // @[AxiScratchpad.scala 122:25 123:17]
  assign wrIE_s_axi_aw_bits_len = io_s_axi_aw_bits_len; // @[AxiScratchpad.scala 122:25 123:17]
  assign wrIE_s_axi_aw_bits_size = io_s_axi_aw_bits_size; // @[AxiScratchpad.scala 122:25 123:17]
  assign wrIE_s_axi_aw_bits_burst = io_s_axi_aw_bits_burst; // @[AxiScratchpad.scala 122:25 123:17]
  assign wrIE_s_axi_w_valid = io_s_axi_w_valid; // @[AxiScratchpad.scala 122:25 124:17]
  assign wrIE_s_axi_w_bits_data = io_s_axi_w_bits_data; // @[AxiScratchpad.scala 122:25 124:17]
  assign wrIE_s_axi_w_bits_last = io_s_axi_w_bits_last; // @[AxiScratchpad.scala 122:25 124:17]
  assign wrIE_s_axi_b_ready = io_s_axi_b_ready; // @[AxiScratchpad.scala 122:25 125:17]
  assign wrIE_ready = arbiter_wrready; // @[AxiScratchpad.scala 149:21]
  assign rdIE_aclk = io_aclk; // @[AxiScratchpad.scala 151:21]
  assign rdIE_aresetn = io_aresetn; // @[AxiScratchpad.scala 152:21]
  assign rdIE_s_axi_ar_valid = io_s_axi_ar_valid; // @[AxiScratchpad.scala 118:24 119:17]
  assign rdIE_s_axi_ar_bits_id = io_s_axi_ar_bits_id; // @[AxiScratchpad.scala 118:24 119:17]
  assign rdIE_s_axi_ar_bits_addr = io_s_axi_ar_bits_addr; // @[AxiScratchpad.scala 118:24 119:17]
  assign rdIE_s_axi_ar_bits_len = io_s_axi_ar_bits_len; // @[AxiScratchpad.scala 118:24 119:17]
  assign rdIE_s_axi_ar_bits_size = io_s_axi_ar_bits_size; // @[AxiScratchpad.scala 118:24 119:17]
  assign rdIE_s_axi_ar_bits_burst = io_s_axi_ar_bits_burst; // @[AxiScratchpad.scala 118:24 119:17]
  assign rdIE_s_axi_r_ready = io_s_axi_r_ready; // @[AxiScratchpad.scala 118:24 120:17]
  assign rdIE_ready = arbiter_rdready; // @[AxiScratchpad.scala 154:21]
  assign rdIE_data = 4'ha == currentRdBank ? TrueDualPortSRAM_64_9_io_a_dout : _rdIE_data_T_19; // @[Mux.scala 81:58]
  assign arbiter_wrvalid = wrIE_valid; // @[AxiScratchpad.scala 169:21]
  assign arbiter_rdvalid = rdIE_valid; // @[AxiScratchpad.scala 170:21]
  assign arbiter_wr_cs = wrIE_addr[16:13]; // @[AxiScratchpad.scala 137:34]
  assign arbiter_rd_cs = rdIE_addr[16:13]; // @[AxiScratchpad.scala 139:34]
  always @(posedge io_aclk) begin
    currentRdBank <= rdIE_addr[16:13]; // @[AxiScratchpad.scala 139:34]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  currentRdBank = _RAND_0[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IOController(
  input          clock,
  input          reset,
  output         io_sram_en,
  output [1:0]   io_sram_we,
  output [14:0]  io_sram_addr,
  output [15:0]  io_sram_din,
  input  [15:0]  io_sram_dout,
  input          io_start,
  output         io_done,
  input  [126:0] io_config,
  input  [15:0]  io_in_0,
  input  [15:0]  io_in_1,
  output [15:0]  io_out_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire [14:0] baseAddr = io_config[14:0]; // @[IOController.scala 49:27]
  wire [12:0] stride_0 = io_config[27:15]; // @[IOController.scala 56:55]
  wire [11:0] cycles_0 = io_config[39:28]; // @[IOController.scala 59:24]
  wire [12:0] stride_1 = io_config[52:40]; // @[IOController.scala 56:55]
  wire [11:0] cycles_1 = io_config[64:53]; // @[IOController.scala 59:24]
  wire [12:0] stride_2 = io_config[77:65]; // @[IOController.scala 56:55]
  wire [11:0] cycles_2 = io_config[89:78]; // @[IOController.scala 59:24]
  wire [12:0] stride_3 = io_config[102:90]; // @[IOController.scala 56:55]
  wire [11:0] cycles_3 = io_config[114:103]; // @[IOController.scala 59:24]
  wire [3:0] II = io_config[118:115]; // @[IOController.scala 64:21]
  wire [5:0] latency = io_config[124:119]; // @[IOController.scala 68:26]
  wire  isStore = io_config[125]; // @[IOController.scala 72:26]
  wire  useAddr = io_config[126]; // @[IOController.scala 79:16]
  reg [1:0] state; // @[IOController.scala 84:22]
  reg [5:0] latCnt; // @[IOController.scala 85:23]
  reg [11:0] cycleCnt_0; // @[IOController.scala 86:48]
  reg [11:0] cycleCnt_1; // @[IOController.scala 86:48]
  reg [11:0] cycleCnt_2; // @[IOController.scala 86:48]
  reg [11:0] cycleCnt_3; // @[IOController.scala 86:48]
  reg [3:0] iiCnt; // @[IOController.scala 87:22]
  reg  done; // @[IOController.scala 88:21]
  wire [3:0] _iiEnd_T_1 = iiCnt + 4'h1; // @[IOController.scala 89:21]
  wire  iiEnd = _iiEnd_T_1 >= II; // @[IOController.scala 89:26]
  wire [11:0] _cycleCntEnd_T_1 = cycleCnt_0 + 12'h1; // @[IOController.scala 91:36]
  wire  cycleCntEnd_0 = _cycleCntEnd_T_1 >= cycles_0; // @[IOController.scala 91:42]
  wire [11:0] _cycleCntEnd_T_6 = cycleCnt_1 + 12'h1; // @[IOController.scala 91:36]
  wire  _cycleCntEnd_T_7 = _cycleCntEnd_T_6 >= cycles_1; // @[IOController.scala 91:42]
  wire  cycleCntEnd_1 = cycleCntEnd_0 & _cycleCntEnd_T_6 >= cycles_1; // @[IOController.scala 91:65]
  wire [11:0] _cycleCntEnd_T_15 = cycleCnt_2 + 12'h1; // @[IOController.scala 91:36]
  wire  _cycleCntEnd_T_16 = _cycleCntEnd_T_15 >= cycles_2; // @[IOController.scala 91:42]
  wire  cycleCntEnd_2 = cycleCntEnd_1 & _cycleCntEnd_T_15 >= cycles_2; // @[IOController.scala 91:65]
  wire [11:0] _cycleCntEnd_T_28 = cycleCnt_3 + 12'h1; // @[IOController.scala 91:36]
  wire  _cycleCntEnd_T_29 = _cycleCntEnd_T_28 >= cycles_3; // @[IOController.scala 91:42]
  wire  cntEnd = cycleCntEnd_2 & _cycleCntEnd_T_28 >= cycles_3; // @[IOController.scala 91:65]
  wire [5:0] _T_11 = latCnt + 6'h1; // @[IOController.scala 108:19]
  wire [1:0] _GEN_5 = cntEnd & iiEnd ? 2'h0 : state; // @[IOController.scala 114:28 115:15 84:22]
  wire  _GEN_6 = cntEnd & iiEnd | done; // @[IOController.scala 114:28 116:14 88:21]
  wire  launch = state == 2'h2; // @[IOController.scala 121:23]
  wire  _T_15 = state == 2'h0; // @[IOController.scala 122:14]
  wire [11:0] _GEN_17 = iiEnd ? 12'h0 : cycleCnt_0; // @[IOController.scala 137:24 138:21 86:48]
  wire [11:0] _GEN_40 = {{11'd0}, cycleCntEnd_0}; // @[IOController.scala 133:36]
  wire [11:0] _cycleCnt_1_T_1 = cycleCnt_1 + _GEN_40; // @[IOController.scala 133:36]
  wire [11:0] _GEN_21 = iiEnd ? 12'h0 : cycleCnt_1; // @[IOController.scala 137:24 138:21 86:48]
  wire [11:0] _GEN_41 = {{11'd0}, cycleCntEnd_1}; // @[IOController.scala 133:36]
  wire [11:0] _cycleCnt_2_T_1 = cycleCnt_2 + _GEN_41; // @[IOController.scala 133:36]
  wire [11:0] _GEN_25 = iiEnd ? 12'h0 : cycleCnt_2; // @[IOController.scala 137:24 138:21 86:48]
  wire [11:0] _GEN_42 = {{11'd0}, cycleCntEnd_2}; // @[IOController.scala 133:36]
  wire [11:0] _cycleCnt_3_T_1 = cycleCnt_3 + _GEN_42; // @[IOController.scala 133:36]
  wire [11:0] _GEN_29 = iiEnd ? 12'h0 : cycleCnt_3; // @[IOController.scala 137:24 138:21 86:48]
  wire  _wRealValid_T = $signed(stride_0) == 13'sh0; // @[IOController.scala 145:18]
  wire  _wRealValid_T_5 = $signed(stride_0) != 13'sh0; // @[IOController.scala 145:74]
  wire  _wRealValid_T_6 = $signed(stride_0) == 13'sh0 & cycleCntEnd_0 | $signed(stride_0) != 13'sh0; // @[IOController.scala 145:61]
  wire  _wRealValid_T_7 = $signed(stride_1) == 13'sh0; // @[IOController.scala 145:18]
  wire  _wRealValid_T_12 = $signed(stride_1) != 13'sh0; // @[IOController.scala 145:74]
  wire  _wRealValid_T_13 = $signed(stride_1) == 13'sh0 & _cycleCntEnd_T_7 | $signed(stride_1) != 13'sh0; // @[IOController.scala 145:61]
  wire  _wRealValid_T_14 = $signed(stride_2) == 13'sh0; // @[IOController.scala 145:18]
  wire  _wRealValid_T_19 = $signed(stride_2) != 13'sh0; // @[IOController.scala 145:74]
  wire  _wRealValid_T_20 = $signed(stride_2) == 13'sh0 & _cycleCntEnd_T_16 | $signed(stride_2) != 13'sh0; // @[IOController.scala 145:61]
  wire  _wRealValid_T_21 = $signed(stride_3) == 13'sh0; // @[IOController.scala 145:18]
  wire  _wRealValid_T_26 = $signed(stride_3) != 13'sh0; // @[IOController.scala 145:74]
  wire  _wRealValid_T_27 = $signed(stride_3) == 13'sh0 & _cycleCntEnd_T_29 | $signed(stride_3) != 13'sh0; // @[IOController.scala 145:61]
  wire  wRealValid = _wRealValid_T_6 & _wRealValid_T_13 & _wRealValid_T_20 & _wRealValid_T_27; // @[IOController.scala 146:13]
  wire  _rRealValid_T_4 = _wRealValid_T & cycleCnt_0 == 12'h0 | _wRealValid_T_5; // @[IOController.scala 150:48]
  wire  _rRealValid_T_9 = _wRealValid_T_7 & cycleCnt_1 == 12'h0 | _wRealValid_T_12; // @[IOController.scala 150:48]
  wire  _rRealValid_T_14 = _wRealValid_T_14 & cycleCnt_2 == 12'h0 | _wRealValid_T_19; // @[IOController.scala 150:48]
  wire  _rRealValid_T_19 = _wRealValid_T_21 & cycleCnt_3 == 12'h0 | _wRealValid_T_26; // @[IOController.scala 150:48]
  wire  rRealValid = _rRealValid_T_4 & _rRealValid_T_9 & _rRealValid_T_14 & _rRealValid_T_19; // @[IOController.scala 151:13]
  wire  _wValid_T_1 = iiCnt == 4'h0; // @[IOController.scala 154:44]
  wire  wValid = isStore & launch & iiCnt == 4'h0; // @[IOController.scala 154:34]
  wire  _raValid_T = ~isStore; // @[IOController.scala 157:17]
  wire  raValid = ~isStore & launch & _wValid_T_1; // @[IOController.scala 157:36]
  reg [15:0] genAddrReg; // @[IOController.scala 159:27]
  wire [15:0] _genAddrReg_T_1 = {1'h0,baseAddr}; // @[IOController.scala 173:43]
  wire [12:0] _genAddrReg_T_2 = cycleCntEnd_0 ? $signed(stride_1) : $signed(stride_0); // @[Mux.scala 47:70]
  wire [12:0] _genAddrReg_T_3 = cycleCntEnd_1 ? $signed(stride_2) : $signed(_genAddrReg_T_2); // @[Mux.scala 47:70]
  wire [12:0] _genAddrReg_T_4 = cycleCntEnd_2 ? $signed(stride_3) : $signed(_genAddrReg_T_3); // @[Mux.scala 47:70]
  wire [15:0] _GEN_43 = {{3{_genAddrReg_T_4[12]}},_genAddrReg_T_4}; // @[IOController.scala 175:30]
  wire [15:0] _genAddrReg_T_7 = $signed(genAddrReg) + $signed(_GEN_43); // @[IOController.scala 175:30]
  wire [14:0] _addr_T_2 = baseAddr + io_in_1[15:1]; // @[IOController.scala 183:25]
  wire [14:0] _addr_T_5 = baseAddr + io_in_0[15:1]; // @[IOController.scala 185:25]
  wire [15:0] _GEN_35 = useAddr & _raValid_T ? {{1'd0}, _addr_T_5} : genAddrReg; // @[IOController.scala 184:35 185:12 187:12]
  wire [15:0] _GEN_36 = useAddr & isStore ? {{1'd0}, _addr_T_2} : _GEN_35; // @[IOController.scala 182:28 183:12]
  reg [14:0] addrReg; // @[IOController.scala 192:26]
  wire [14:0] addr = _GEN_36[14:0]; // @[IOController.scala 158:18]
  reg [15:0] wDataReg; // @[IOController.scala 196:27]
  reg  io_sram_en_REG; // @[IOController.scala 200:26]
  reg [1:0] io_sram_we_REG; // @[IOController.scala 201:26]
  reg [15:0] dout; // @[IOController.scala 212:23]
  reg  REG; // @[IOController.scala 213:17]
  assign io_sram_en = io_sram_en_REG; // @[IOController.scala 200:16]
  assign io_sram_we = io_sram_we_REG; // @[IOController.scala 201:16]
  assign io_sram_addr = addrReg; // @[IOController.scala 202:18]
  assign io_sram_din = wDataReg; // @[IOController.scala 203:17]
  assign io_done = done; // @[IOController.scala 95:11]
  assign io_out_0 = dout; // @[IOController.scala 216:15]
  always @(posedge clock) begin
    if (reset) begin // @[IOController.scala 84:22]
      state <= 2'h0; // @[IOController.scala 84:22]
    end else if (2'h0 == state) begin // @[IOController.scala 96:16]
      if (io_start & latency == 6'h0) begin // @[IOController.scala 99:40]
        state <= 2'h2; // @[IOController.scala 100:15]
      end else if (io_start & latency != 6'h0) begin // @[IOController.scala 102:46]
        state <= 2'h1; // @[IOController.scala 103:15]
      end
    end else if (2'h1 == state) begin // @[IOController.scala 96:16]
      if (_T_11 >= latency) begin // @[IOController.scala 108:36]
        state <= 2'h2; // @[IOController.scala 109:15]
      end
    end else if (2'h2 == state) begin // @[IOController.scala 96:16]
      state <= _GEN_5;
    end
    if (reset) begin // @[IOController.scala 85:23]
      latCnt <= 6'h0; // @[IOController.scala 85:23]
    end else if (2'h0 == state) begin // @[IOController.scala 96:16]
      latCnt <= 6'h0; // @[IOController.scala 98:14]
    end else if (2'h1 == state) begin // @[IOController.scala 96:16]
      latCnt <= _T_11; // @[IOController.scala 111:14]
    end
    if (reset) begin // @[IOController.scala 86:48]
      cycleCnt_0 <= 12'h0; // @[IOController.scala 86:48]
    end else if (_T_15) begin // @[IOController.scala 129:27]
      cycleCnt_0 <= 12'h0; // @[IOController.scala 130:19]
    end else if (launch) begin // @[IOController.scala 131:23]
      if (iiEnd & ~cycleCntEnd_0) begin // @[IOController.scala 132:37]
        cycleCnt_0 <= _cycleCntEnd_T_1; // @[IOController.scala 133:21]
      end else begin
        cycleCnt_0 <= _GEN_17;
      end
    end
    if (reset) begin // @[IOController.scala 86:48]
      cycleCnt_1 <= 12'h0; // @[IOController.scala 86:48]
    end else if (_T_15) begin // @[IOController.scala 129:27]
      cycleCnt_1 <= 12'h0; // @[IOController.scala 130:19]
    end else if (launch) begin // @[IOController.scala 131:23]
      if (iiEnd & ~cycleCntEnd_1) begin // @[IOController.scala 132:37]
        cycleCnt_1 <= _cycleCnt_1_T_1; // @[IOController.scala 133:21]
      end else begin
        cycleCnt_1 <= _GEN_21;
      end
    end
    if (reset) begin // @[IOController.scala 86:48]
      cycleCnt_2 <= 12'h0; // @[IOController.scala 86:48]
    end else if (_T_15) begin // @[IOController.scala 129:27]
      cycleCnt_2 <= 12'h0; // @[IOController.scala 130:19]
    end else if (launch) begin // @[IOController.scala 131:23]
      if (iiEnd & ~cycleCntEnd_2) begin // @[IOController.scala 132:37]
        cycleCnt_2 <= _cycleCnt_2_T_1; // @[IOController.scala 133:21]
      end else begin
        cycleCnt_2 <= _GEN_25;
      end
    end
    if (reset) begin // @[IOController.scala 86:48]
      cycleCnt_3 <= 12'h0; // @[IOController.scala 86:48]
    end else if (_T_15) begin // @[IOController.scala 129:27]
      cycleCnt_3 <= 12'h0; // @[IOController.scala 130:19]
    end else if (launch) begin // @[IOController.scala 131:23]
      if (iiEnd & ~cntEnd) begin // @[IOController.scala 132:37]
        cycleCnt_3 <= _cycleCnt_3_T_1; // @[IOController.scala 133:21]
      end else begin
        cycleCnt_3 <= _GEN_29;
      end
    end
    if (reset) begin // @[IOController.scala 87:22]
      iiCnt <= 4'h0; // @[IOController.scala 87:22]
    end else if (state == 2'h0) begin // @[IOController.scala 122:25]
      iiCnt <= 4'h0; // @[IOController.scala 123:11]
    end else if (launch) begin // @[IOController.scala 124:21]
      if (iiEnd) begin // @[IOController.scala 125:17]
        iiCnt <= 4'h0;
      end else begin
        iiCnt <= _iiEnd_T_1;
      end
    end
    if (reset) begin // @[IOController.scala 88:21]
      done <= 1'h0; // @[IOController.scala 88:21]
    end else if (2'h0 == state) begin // @[IOController.scala 96:16]
      if (io_start & latency == 6'h0) begin // @[IOController.scala 99:40]
        done <= 1'h0; // @[IOController.scala 101:14]
      end else if (io_start & latency != 6'h0) begin // @[IOController.scala 102:46]
        done <= 1'h0; // @[IOController.scala 104:14]
      end
    end else if (!(2'h1 == state)) begin // @[IOController.scala 96:16]
      if (2'h2 == state) begin // @[IOController.scala 96:16]
        done <= _GEN_6;
      end
    end
    if (reset) begin // @[IOController.scala 159:27]
      genAddrReg <= 16'sh0; // @[IOController.scala 159:27]
    end else if (~launch) begin // @[IOController.scala 172:16]
      genAddrReg <= _genAddrReg_T_1; // @[IOController.scala 173:16]
    end else if (iiEnd) begin // @[IOController.scala 174:20]
      genAddrReg <= _genAddrReg_T_7; // @[IOController.scala 175:16]
    end
    if (reset) begin // @[IOController.scala 192:26]
      addrReg <= 15'h0; // @[IOController.scala 192:26]
    end else if (wValid | raValid) begin // @[IOController.scala 193:28]
      addrReg <= addr; // @[IOController.scala 194:15]
    end
    if (reset) begin // @[IOController.scala 196:27]
      wDataReg <= 16'h0; // @[IOController.scala 196:27]
    end else if (wValid) begin // @[IOController.scala 197:17]
      wDataReg <= io_in_0; // @[IOController.scala 198:16]
    end
    io_sram_en_REG <= wValid & (wRealValid | useAddr) | raValid & (rRealValid | useAddr); // @[IOController.scala 170:52]
    if (wValid) begin // @[IOController.scala 201:30]
      io_sram_we_REG <= 2'h3;
    end else begin
      io_sram_we_REG <= 2'h0;
    end
    if (reset) begin // @[IOController.scala 212:23]
      dout <= 16'h0; // @[IOController.scala 212:23]
    end else if (REG) begin // @[IOController.scala 213:54]
      dout <= io_sram_dout; // @[IOController.scala 214:12]
    end
    REG <= io_sram_en & io_sram_we == 2'h0; // @[IOController.scala 213:29]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  latCnt = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  cycleCnt_0 = _RAND_2[11:0];
  _RAND_3 = {1{`RANDOM}};
  cycleCnt_1 = _RAND_3[11:0];
  _RAND_4 = {1{`RANDOM}};
  cycleCnt_2 = _RAND_4[11:0];
  _RAND_5 = {1{`RANDOM}};
  cycleCnt_3 = _RAND_5[11:0];
  _RAND_6 = {1{`RANDOM}};
  iiCnt = _RAND_6[3:0];
  _RAND_7 = {1{`RANDOM}};
  done = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  genAddrReg = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  addrReg = _RAND_9[14:0];
  _RAND_10 = {1{`RANDOM}};
  wDataReg = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  io_sram_en_REG = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  io_sram_we_REG = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  dout = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  REG = _RAND_14[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SharedDelayPipe(
  input         clock,
  input         reset,
  input         io_en,
  input  [7:0]  io_config,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  output [15:0] io_out_0,
  output [15:0] io_out_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] regs_0; // @[DelayPipe.scala 142:21]
  reg [15:0] regs_1; // @[DelayPipe.scala 142:21]
  reg [15:0] regs_2; // @[DelayPipe.scala 142:21]
  reg [15:0] regs_3; // @[DelayPipe.scala 142:21]
  reg [15:0] regs_4; // @[DelayPipe.scala 142:21]
  reg [15:0] regs_5; // @[DelayPipe.scala 142:21]
  reg [15:0] regs_6; // @[DelayPipe.scala 142:21]
  reg [15:0] regs_7; // @[DelayPipe.scala 142:21]
  reg [15:0] regs_8; // @[DelayPipe.scala 142:21]
  reg [15:0] regs_9; // @[DelayPipe.scala 142:21]
  reg [15:0] regs_10; // @[DelayPipe.scala 142:21]
  reg [15:0] regs_11; // @[DelayPipe.scala 142:21]
  reg [3:0] wptr_0; // @[DelayPipe.scala 143:21]
  reg [3:0] wptr_1; // @[DelayPipe.scala 143:21]
  wire [3:0] config_0 = io_config[3:0]; // @[DelayPipe.scala 148:27]
  wire [3:0] config_1 = io_config[7:4]; // @[DelayPipe.scala 148:27]
  wire [3:0] offset_0 = config_1 + 4'h1; // @[DelayPipe.scala 153:32]
  wire [3:0] _wptr_0_T_1 = wptr_0 + 4'h1; // @[DelayPipe.scala 162:28]
  wire [3:0] _rptr_0_T_1 = wptr_0 - config_0; // @[DelayPipe.scala 179:26]
  wire [3:0] _rptr_0_T_3 = 4'hc + wptr_0; // @[DelayPipe.scala 181:27]
  wire [3:0] _rptr_0_T_5 = _rptr_0_T_3 - config_0; // @[DelayPipe.scala 181:37]
  wire [3:0] rptr_0 = wptr_0 >= config_0 ? _rptr_0_T_1 : _rptr_0_T_5; // @[DelayPipe.scala 178:31 179:15 181:15]
  wire [15:0] _GEN_3 = 4'h1 == rptr_0 ? regs_1 : regs_0; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_4 = 4'h2 == rptr_0 ? regs_2 : _GEN_3; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_5 = 4'h3 == rptr_0 ? regs_3 : _GEN_4; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_6 = 4'h4 == rptr_0 ? regs_4 : _GEN_5; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_7 = 4'h5 == rptr_0 ? regs_5 : _GEN_6; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_8 = 4'h6 == rptr_0 ? regs_6 : _GEN_7; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_9 = 4'h7 == rptr_0 ? regs_7 : _GEN_8; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_10 = 4'h8 == rptr_0 ? regs_8 : _GEN_9; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_11 = 4'h9 == rptr_0 ? regs_9 : _GEN_10; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_12 = 4'ha == rptr_0 ? regs_10 : _GEN_11; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_13 = 4'hb == rptr_0 ? regs_11 : _GEN_12; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_14 = io_en ? _GEN_13 : 16'h0; // @[DelayPipe.scala 191:22 192:17 194:17]
  wire [3:0] _wptr_1_T_1 = wptr_1 + 4'h1; // @[DelayPipe.scala 169:30]
  wire [3:0] _rptr_1_T_1 = wptr_1 - config_1; // @[DelayPipe.scala 179:26]
  wire [3:0] _rptr_1_T_3 = 4'hc + wptr_1; // @[DelayPipe.scala 181:27]
  wire [3:0] _rptr_1_T_5 = _rptr_1_T_3 - config_1; // @[DelayPipe.scala 181:37]
  wire [3:0] rptr_1 = wptr_1 >= config_1 ? _rptr_1_T_1 : _rptr_1_T_5; // @[DelayPipe.scala 178:31 179:15 181:15]
  wire [15:0] _GEN_20 = 4'h1 == rptr_1 ? regs_1 : regs_0; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_21 = 4'h2 == rptr_1 ? regs_2 : _GEN_20; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_22 = 4'h3 == rptr_1 ? regs_3 : _GEN_21; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_23 = 4'h4 == rptr_1 ? regs_4 : _GEN_22; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_24 = 4'h5 == rptr_1 ? regs_5 : _GEN_23; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_25 = 4'h6 == rptr_1 ? regs_6 : _GEN_24; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_26 = 4'h7 == rptr_1 ? regs_7 : _GEN_25; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_27 = 4'h8 == rptr_1 ? regs_8 : _GEN_26; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_28 = 4'h9 == rptr_1 ? regs_9 : _GEN_27; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_29 = 4'ha == rptr_1 ? regs_10 : _GEN_28; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_30 = 4'hb == rptr_1 ? regs_11 : _GEN_29; // @[DelayPipe.scala 192:{17,17}]
  wire [15:0] _GEN_31 = io_en ? _GEN_30 : 16'h0; // @[DelayPipe.scala 191:22 192:17 194:17]
  assign io_out_0 = io_en & 4'h0 == config_0 ? io_in_0 : _GEN_14; // @[DelayPipe.scala 189:39 190:17]
  assign io_out_1 = io_en & 4'h0 == config_1 ? io_in_1 : _GEN_31; // @[DelayPipe.scala 189:39 190:17]
  always @(posedge clock) begin
    if (reset) begin // @[DelayPipe.scala 142:21]
      regs_0 <= 16'h0; // @[DelayPipe.scala 142:21]
    end else if (io_en) begin // @[DelayPipe.scala 199:14]
      if (4'h0 == wptr_1) begin // @[DelayPipe.scala 201:21]
        regs_0 <= io_in_1; // @[DelayPipe.scala 201:21]
      end else if (4'h0 == wptr_0) begin // @[DelayPipe.scala 201:21]
        regs_0 <= io_in_0; // @[DelayPipe.scala 201:21]
      end
    end else begin
      regs_0 <= 16'h0; // @[DelayPipe.scala 205:15]
    end
    if (reset) begin // @[DelayPipe.scala 142:21]
      regs_1 <= 16'h0; // @[DelayPipe.scala 142:21]
    end else if (io_en) begin // @[DelayPipe.scala 199:14]
      if (4'h1 == wptr_1) begin // @[DelayPipe.scala 201:21]
        regs_1 <= io_in_1; // @[DelayPipe.scala 201:21]
      end else if (4'h1 == wptr_0) begin // @[DelayPipe.scala 201:21]
        regs_1 <= io_in_0; // @[DelayPipe.scala 201:21]
      end
    end else begin
      regs_1 <= 16'h0; // @[DelayPipe.scala 205:15]
    end
    if (reset) begin // @[DelayPipe.scala 142:21]
      regs_2 <= 16'h0; // @[DelayPipe.scala 142:21]
    end else if (io_en) begin // @[DelayPipe.scala 199:14]
      if (4'h2 == wptr_1) begin // @[DelayPipe.scala 201:21]
        regs_2 <= io_in_1; // @[DelayPipe.scala 201:21]
      end else if (4'h2 == wptr_0) begin // @[DelayPipe.scala 201:21]
        regs_2 <= io_in_0; // @[DelayPipe.scala 201:21]
      end
    end else begin
      regs_2 <= 16'h0; // @[DelayPipe.scala 205:15]
    end
    if (reset) begin // @[DelayPipe.scala 142:21]
      regs_3 <= 16'h0; // @[DelayPipe.scala 142:21]
    end else if (io_en) begin // @[DelayPipe.scala 199:14]
      if (4'h3 == wptr_1) begin // @[DelayPipe.scala 201:21]
        regs_3 <= io_in_1; // @[DelayPipe.scala 201:21]
      end else if (4'h3 == wptr_0) begin // @[DelayPipe.scala 201:21]
        regs_3 <= io_in_0; // @[DelayPipe.scala 201:21]
      end
    end else begin
      regs_3 <= 16'h0; // @[DelayPipe.scala 205:15]
    end
    if (reset) begin // @[DelayPipe.scala 142:21]
      regs_4 <= 16'h0; // @[DelayPipe.scala 142:21]
    end else if (io_en) begin // @[DelayPipe.scala 199:14]
      if (4'h4 == wptr_1) begin // @[DelayPipe.scala 201:21]
        regs_4 <= io_in_1; // @[DelayPipe.scala 201:21]
      end else if (4'h4 == wptr_0) begin // @[DelayPipe.scala 201:21]
        regs_4 <= io_in_0; // @[DelayPipe.scala 201:21]
      end
    end else begin
      regs_4 <= 16'h0; // @[DelayPipe.scala 205:15]
    end
    if (reset) begin // @[DelayPipe.scala 142:21]
      regs_5 <= 16'h0; // @[DelayPipe.scala 142:21]
    end else if (io_en) begin // @[DelayPipe.scala 199:14]
      if (4'h5 == wptr_1) begin // @[DelayPipe.scala 201:21]
        regs_5 <= io_in_1; // @[DelayPipe.scala 201:21]
      end else if (4'h5 == wptr_0) begin // @[DelayPipe.scala 201:21]
        regs_5 <= io_in_0; // @[DelayPipe.scala 201:21]
      end
    end else begin
      regs_5 <= 16'h0; // @[DelayPipe.scala 205:15]
    end
    if (reset) begin // @[DelayPipe.scala 142:21]
      regs_6 <= 16'h0; // @[DelayPipe.scala 142:21]
    end else if (io_en) begin // @[DelayPipe.scala 199:14]
      if (4'h6 == wptr_1) begin // @[DelayPipe.scala 201:21]
        regs_6 <= io_in_1; // @[DelayPipe.scala 201:21]
      end else if (4'h6 == wptr_0) begin // @[DelayPipe.scala 201:21]
        regs_6 <= io_in_0; // @[DelayPipe.scala 201:21]
      end
    end else begin
      regs_6 <= 16'h0; // @[DelayPipe.scala 205:15]
    end
    if (reset) begin // @[DelayPipe.scala 142:21]
      regs_7 <= 16'h0; // @[DelayPipe.scala 142:21]
    end else if (io_en) begin // @[DelayPipe.scala 199:14]
      if (4'h7 == wptr_1) begin // @[DelayPipe.scala 201:21]
        regs_7 <= io_in_1; // @[DelayPipe.scala 201:21]
      end else if (4'h7 == wptr_0) begin // @[DelayPipe.scala 201:21]
        regs_7 <= io_in_0; // @[DelayPipe.scala 201:21]
      end
    end else begin
      regs_7 <= 16'h0; // @[DelayPipe.scala 205:15]
    end
    if (reset) begin // @[DelayPipe.scala 142:21]
      regs_8 <= 16'h0; // @[DelayPipe.scala 142:21]
    end else if (io_en) begin // @[DelayPipe.scala 199:14]
      if (4'h8 == wptr_1) begin // @[DelayPipe.scala 201:21]
        regs_8 <= io_in_1; // @[DelayPipe.scala 201:21]
      end else if (4'h8 == wptr_0) begin // @[DelayPipe.scala 201:21]
        regs_8 <= io_in_0; // @[DelayPipe.scala 201:21]
      end
    end else begin
      regs_8 <= 16'h0; // @[DelayPipe.scala 205:15]
    end
    if (reset) begin // @[DelayPipe.scala 142:21]
      regs_9 <= 16'h0; // @[DelayPipe.scala 142:21]
    end else if (io_en) begin // @[DelayPipe.scala 199:14]
      if (4'h9 == wptr_1) begin // @[DelayPipe.scala 201:21]
        regs_9 <= io_in_1; // @[DelayPipe.scala 201:21]
      end else if (4'h9 == wptr_0) begin // @[DelayPipe.scala 201:21]
        regs_9 <= io_in_0; // @[DelayPipe.scala 201:21]
      end
    end else begin
      regs_9 <= 16'h0; // @[DelayPipe.scala 205:15]
    end
    if (reset) begin // @[DelayPipe.scala 142:21]
      regs_10 <= 16'h0; // @[DelayPipe.scala 142:21]
    end else if (io_en) begin // @[DelayPipe.scala 199:14]
      if (4'ha == wptr_1) begin // @[DelayPipe.scala 201:21]
        regs_10 <= io_in_1; // @[DelayPipe.scala 201:21]
      end else if (4'ha == wptr_0) begin // @[DelayPipe.scala 201:21]
        regs_10 <= io_in_0; // @[DelayPipe.scala 201:21]
      end
    end else begin
      regs_10 <= 16'h0; // @[DelayPipe.scala 205:15]
    end
    if (reset) begin // @[DelayPipe.scala 142:21]
      regs_11 <= 16'h0; // @[DelayPipe.scala 142:21]
    end else if (io_en) begin // @[DelayPipe.scala 199:14]
      if (4'hb == wptr_1) begin // @[DelayPipe.scala 201:21]
        regs_11 <= io_in_1; // @[DelayPipe.scala 201:21]
      end else if (4'hb == wptr_0) begin // @[DelayPipe.scala 201:21]
        regs_11 <= io_in_0; // @[DelayPipe.scala 201:21]
      end
    end else begin
      regs_11 <= 16'h0; // @[DelayPipe.scala 205:15]
    end
    if (reset) begin // @[DelayPipe.scala 143:21]
      wptr_0 <= 4'h0; // @[DelayPipe.scala 143:21]
    end else if (io_en & wptr_0 < 4'hb) begin // @[DelayPipe.scala 161:46]
      wptr_0 <= _wptr_0_T_1; // @[DelayPipe.scala 162:17]
    end else begin
      wptr_0 <= 4'h0; // @[DelayPipe.scala 164:17]
    end
    if (reset) begin // @[DelayPipe.scala 143:21]
      wptr_1 <= 4'h0; // @[DelayPipe.scala 143:21]
    end else if (io_en) begin // @[DelayPipe.scala 167:19]
      if (wptr_1 < 4'hb) begin // @[DelayPipe.scala 168:40]
        wptr_1 <= _wptr_1_T_1; // @[DelayPipe.scala 169:19]
      end else begin
        wptr_1 <= 4'h0; // @[DelayPipe.scala 171:19]
      end
    end else begin
      wptr_1 <= offset_0; // @[DelayPipe.scala 174:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regs_0 = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  regs_1 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  regs_2 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  regs_3 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  regs_4 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  regs_5 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  regs_6 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  regs_7 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  regs_8 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  regs_9 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  regs_10 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  regs_11 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  wptr_0 = _RAND_12[3:0];
  _RAND_13 = {1{`RANDOM}};
  wptr_1 = _RAND_13[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Muxn(
  input         io_config,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  output [15:0] io_out
);
  assign io_out = io_config ? io_in_1 : io_in_0; // @[Mux.scala 81:58]
endmodule
module ConfigMem(
  input          clock,
  input          reset,
  input          io_cfg_en,
  input  [2:0]   io_cfg_addr,
  input  [31:0]  io_cfg_data,
  output [136:0] io_out_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [159:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [136:0] regs_0; // @[ConfigMem.scala 27:21]
  wire [136:0] _regs_0_T_1 = {regs_0[136:32],io_cfg_data}; // @[Cat.scala 33:92]
  wire [136:0] _GEN_0 = io_cfg_en & io_cfg_addr == 3'h0 ? _regs_0_T_1 : regs_0; // @[ConfigMem.scala 39:47 41:19 27:21]
  wire [136:0] _regs_0_T_4 = {regs_0[136:64],io_cfg_data,regs_0[31:0]}; // @[Cat.scala 33:92]
  wire [136:0] _GEN_1 = io_cfg_en & io_cfg_addr == 3'h1 ? _regs_0_T_4 : _GEN_0; // @[ConfigMem.scala 39:47 45:19]
  wire [136:0] _regs_0_T_7 = {regs_0[136:96],io_cfg_data,regs_0[63:0]}; // @[Cat.scala 33:92]
  wire [136:0] _GEN_2 = io_cfg_en & io_cfg_addr == 3'h2 ? _regs_0_T_7 : _GEN_1; // @[ConfigMem.scala 39:47 45:19]
  wire [136:0] _regs_0_T_10 = {regs_0[136:128],io_cfg_data,regs_0[95:0]}; // @[Cat.scala 33:92]
  wire [136:0] _GEN_3 = io_cfg_en & io_cfg_addr == 3'h3 ? _regs_0_T_10 : _GEN_2; // @[ConfigMem.scala 39:47 45:19]
  wire [159:0] _regs_0_T_12 = {io_cfg_data,regs_0[127:0]}; // @[Cat.scala 33:92]
  wire [159:0] _GEN_4 = io_cfg_en & io_cfg_addr == 3'h4 ? _regs_0_T_12 : {{23'd0}, _GEN_3}; // @[ConfigMem.scala 39:47 43:19]
  wire [159:0] _GEN_5 = reset ? 160'h0 : _GEN_4; // @[ConfigMem.scala 27:{21,21}]
  assign io_out_0 = regs_0; // @[ConfigMem.scala 52:45]
  always @(posedge clock) begin
    regs_0 <= _GEN_5[136:0]; // @[ConfigMem.scala 27:{21,21}]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {5{`RANDOM}};
  regs_0 = _RAND_0[136:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IOB(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  output        io_done,
  input         io_en,
  input  [15:0] io_in_1,
  output [15:0] io_out_0,
  output        io_sram_en,
  output [1:0]  io_sram_we,
  output [14:0] io_sram_addr,
  output [15:0] io_sram_din,
  input  [15:0] io_sram_dout
);
  wire  ioCtrl_clock; // @[IOB.scala 67:22]
  wire  ioCtrl_reset; // @[IOB.scala 67:22]
  wire  ioCtrl_io_sram_en; // @[IOB.scala 67:22]
  wire [1:0] ioCtrl_io_sram_we; // @[IOB.scala 67:22]
  wire [14:0] ioCtrl_io_sram_addr; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_din; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_dout; // @[IOB.scala 67:22]
  wire  ioCtrl_io_start; // @[IOB.scala 67:22]
  wire  ioCtrl_io_done; // @[IOB.scala 67:22]
  wire [126:0] ioCtrl_io_config; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_0; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_1; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_out_0; // @[IOB.scala 67:22]
  wire  delay_pipe_clock; // @[IOB.scala 68:66]
  wire  delay_pipe_reset; // @[IOB.scala 68:66]
  wire  delay_pipe_io_en; // @[IOB.scala 68:66]
  wire [7:0] delay_pipe_io_config; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_1; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_1; // @[IOB.scala 68:66]
  wire  Muxn_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_out; // @[IOB.scala 70:43]
  wire  Muxn_1_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_out; // @[IOB.scala 70:43]
  wire  cfg_clock; // @[IOB.scala 152:19]
  wire  cfg_reset; // @[IOB.scala 152:19]
  wire  cfg_io_cfg_en; // @[IOB.scala 152:19]
  wire [2:0] cfg_io_cfg_addr; // @[IOB.scala 152:19]
  wire [31:0] cfg_io_cfg_data; // @[IOB.scala 152:19]
  wire [136:0] cfg_io_out_0; // @[IOB.scala 152:19]
  IOController ioCtrl ( // @[IOB.scala 67:22]
    .clock(ioCtrl_clock),
    .reset(ioCtrl_reset),
    .io_sram_en(ioCtrl_io_sram_en),
    .io_sram_we(ioCtrl_io_sram_we),
    .io_sram_addr(ioCtrl_io_sram_addr),
    .io_sram_din(ioCtrl_io_sram_din),
    .io_sram_dout(ioCtrl_io_sram_dout),
    .io_start(ioCtrl_io_start),
    .io_done(ioCtrl_io_done),
    .io_config(ioCtrl_io_config),
    .io_in_0(ioCtrl_io_in_0),
    .io_in_1(ioCtrl_io_in_1),
    .io_out_0(ioCtrl_io_out_0)
  );
  SharedDelayPipe delay_pipe ( // @[IOB.scala 68:66]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn Muxn ( // @[IOB.scala 70:43]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_out(Muxn_io_out)
  );
  Muxn Muxn_1 ( // @[IOB.scala 70:43]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem cfg ( // @[IOB.scala 152:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_done = ioCtrl_io_done; // @[IOB.scala 121:11]
  assign io_out_0 = ioCtrl_io_out_0; // @[IOB.scala 122:13]
  assign io_sram_en = ioCtrl_io_sram_en; // @[IOB.scala 119:18]
  assign io_sram_we = ioCtrl_io_sram_we; // @[IOB.scala 119:18]
  assign io_sram_addr = ioCtrl_io_sram_addr; // @[IOB.scala 119:18]
  assign io_sram_din = ioCtrl_io_sram_din; // @[IOB.scala 119:18]
  assign ioCtrl_clock = clock;
  assign ioCtrl_reset = reset;
  assign ioCtrl_io_sram_dout = io_sram_dout; // @[IOB.scala 119:18]
  assign ioCtrl_io_start = io_start; // @[IOB.scala 120:19]
  assign ioCtrl_io_config = cfg_io_out_0[126:0]; // @[IOB.scala 169:29]
  assign ioCtrl_io_in_0 = delay_pipe_io_out_0; // @[IOB.scala 134:23]
  assign ioCtrl_io_in_1 = delay_pipe_io_out_1; // @[IOB.scala 134:23]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[IOB.scala 132:24]
  assign delay_pipe_io_config = cfg_io_out_0[134:127]; // @[IOB.scala 180:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[IOB.scala 133:27]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[IOB.scala 133:27]
  assign Muxn_io_config = cfg_io_out_0[135]; // @[IOB.scala 186:32]
  assign Muxn_io_in_0 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_io_in_1 = io_in_1; // @[IOB.scala 128:10]
  assign Muxn_1_io_config = cfg_io_out_0[136]; // @[IOB.scala 186:32]
  assign Muxn_1_io_in_0 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_1_io_in_1 = 16'h0; // @[IOB.scala 128:10]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h1 == io_cfg_addr[11:3]; // @[IOB.scala 153:30]
  assign cfg_io_cfg_addr = io_cfg_addr[2:0]; // @[IOB.scala 154:33]
  assign cfg_io_cfg_data = io_cfg_data; // @[IOB.scala 155:19]
endmodule
module IOB_1(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  output        io_done,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  output [15:0] io_out_0,
  output        io_sram_en,
  output [1:0]  io_sram_we,
  output [14:0] io_sram_addr,
  output [15:0] io_sram_din,
  input  [15:0] io_sram_dout
);
  wire  ioCtrl_clock; // @[IOB.scala 67:22]
  wire  ioCtrl_reset; // @[IOB.scala 67:22]
  wire  ioCtrl_io_sram_en; // @[IOB.scala 67:22]
  wire [1:0] ioCtrl_io_sram_we; // @[IOB.scala 67:22]
  wire [14:0] ioCtrl_io_sram_addr; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_din; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_dout; // @[IOB.scala 67:22]
  wire  ioCtrl_io_start; // @[IOB.scala 67:22]
  wire  ioCtrl_io_done; // @[IOB.scala 67:22]
  wire [126:0] ioCtrl_io_config; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_0; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_1; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_out_0; // @[IOB.scala 67:22]
  wire  delay_pipe_clock; // @[IOB.scala 68:66]
  wire  delay_pipe_reset; // @[IOB.scala 68:66]
  wire  delay_pipe_io_en; // @[IOB.scala 68:66]
  wire [7:0] delay_pipe_io_config; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_1; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_1; // @[IOB.scala 68:66]
  wire  Muxn_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_out; // @[IOB.scala 70:43]
  wire  Muxn_1_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_out; // @[IOB.scala 70:43]
  wire  cfg_clock; // @[IOB.scala 152:19]
  wire  cfg_reset; // @[IOB.scala 152:19]
  wire  cfg_io_cfg_en; // @[IOB.scala 152:19]
  wire [2:0] cfg_io_cfg_addr; // @[IOB.scala 152:19]
  wire [31:0] cfg_io_cfg_data; // @[IOB.scala 152:19]
  wire [136:0] cfg_io_out_0; // @[IOB.scala 152:19]
  IOController ioCtrl ( // @[IOB.scala 67:22]
    .clock(ioCtrl_clock),
    .reset(ioCtrl_reset),
    .io_sram_en(ioCtrl_io_sram_en),
    .io_sram_we(ioCtrl_io_sram_we),
    .io_sram_addr(ioCtrl_io_sram_addr),
    .io_sram_din(ioCtrl_io_sram_din),
    .io_sram_dout(ioCtrl_io_sram_dout),
    .io_start(ioCtrl_io_start),
    .io_done(ioCtrl_io_done),
    .io_config(ioCtrl_io_config),
    .io_in_0(ioCtrl_io_in_0),
    .io_in_1(ioCtrl_io_in_1),
    .io_out_0(ioCtrl_io_out_0)
  );
  SharedDelayPipe delay_pipe ( // @[IOB.scala 68:66]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn Muxn ( // @[IOB.scala 70:43]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_out(Muxn_io_out)
  );
  Muxn Muxn_1 ( // @[IOB.scala 70:43]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem cfg ( // @[IOB.scala 152:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_done = ioCtrl_io_done; // @[IOB.scala 121:11]
  assign io_out_0 = ioCtrl_io_out_0; // @[IOB.scala 122:13]
  assign io_sram_en = ioCtrl_io_sram_en; // @[IOB.scala 119:18]
  assign io_sram_we = ioCtrl_io_sram_we; // @[IOB.scala 119:18]
  assign io_sram_addr = ioCtrl_io_sram_addr; // @[IOB.scala 119:18]
  assign io_sram_din = ioCtrl_io_sram_din; // @[IOB.scala 119:18]
  assign ioCtrl_clock = clock;
  assign ioCtrl_reset = reset;
  assign ioCtrl_io_sram_dout = io_sram_dout; // @[IOB.scala 119:18]
  assign ioCtrl_io_start = io_start; // @[IOB.scala 120:19]
  assign ioCtrl_io_config = cfg_io_out_0[126:0]; // @[IOB.scala 169:29]
  assign ioCtrl_io_in_0 = delay_pipe_io_out_0; // @[IOB.scala 134:23]
  assign ioCtrl_io_in_1 = delay_pipe_io_out_1; // @[IOB.scala 134:23]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[IOB.scala 132:24]
  assign delay_pipe_io_config = cfg_io_out_0[134:127]; // @[IOB.scala 180:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[IOB.scala 133:27]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[IOB.scala 133:27]
  assign Muxn_io_config = cfg_io_out_0[135]; // @[IOB.scala 186:32]
  assign Muxn_io_in_0 = io_in_0; // @[IOB.scala 128:10]
  assign Muxn_io_in_1 = io_in_1; // @[IOB.scala 128:10]
  assign Muxn_1_io_config = cfg_io_out_0[136]; // @[IOB.scala 186:32]
  assign Muxn_1_io_in_0 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_1_io_in_1 = 16'h0; // @[IOB.scala 128:10]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h2 == io_cfg_addr[11:3]; // @[IOB.scala 153:30]
  assign cfg_io_cfg_addr = io_cfg_addr[2:0]; // @[IOB.scala 154:33]
  assign cfg_io_cfg_data = io_cfg_data; // @[IOB.scala 155:19]
endmodule
module IOB_2(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  output        io_done,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  output [15:0] io_out_0,
  output        io_sram_en,
  output [1:0]  io_sram_we,
  output [14:0] io_sram_addr,
  output [15:0] io_sram_din,
  input  [15:0] io_sram_dout
);
  wire  ioCtrl_clock; // @[IOB.scala 67:22]
  wire  ioCtrl_reset; // @[IOB.scala 67:22]
  wire  ioCtrl_io_sram_en; // @[IOB.scala 67:22]
  wire [1:0] ioCtrl_io_sram_we; // @[IOB.scala 67:22]
  wire [14:0] ioCtrl_io_sram_addr; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_din; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_dout; // @[IOB.scala 67:22]
  wire  ioCtrl_io_start; // @[IOB.scala 67:22]
  wire  ioCtrl_io_done; // @[IOB.scala 67:22]
  wire [126:0] ioCtrl_io_config; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_0; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_1; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_out_0; // @[IOB.scala 67:22]
  wire  delay_pipe_clock; // @[IOB.scala 68:66]
  wire  delay_pipe_reset; // @[IOB.scala 68:66]
  wire  delay_pipe_io_en; // @[IOB.scala 68:66]
  wire [7:0] delay_pipe_io_config; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_1; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_1; // @[IOB.scala 68:66]
  wire  Muxn_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_out; // @[IOB.scala 70:43]
  wire  Muxn_1_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_out; // @[IOB.scala 70:43]
  wire  cfg_clock; // @[IOB.scala 152:19]
  wire  cfg_reset; // @[IOB.scala 152:19]
  wire  cfg_io_cfg_en; // @[IOB.scala 152:19]
  wire [2:0] cfg_io_cfg_addr; // @[IOB.scala 152:19]
  wire [31:0] cfg_io_cfg_data; // @[IOB.scala 152:19]
  wire [136:0] cfg_io_out_0; // @[IOB.scala 152:19]
  IOController ioCtrl ( // @[IOB.scala 67:22]
    .clock(ioCtrl_clock),
    .reset(ioCtrl_reset),
    .io_sram_en(ioCtrl_io_sram_en),
    .io_sram_we(ioCtrl_io_sram_we),
    .io_sram_addr(ioCtrl_io_sram_addr),
    .io_sram_din(ioCtrl_io_sram_din),
    .io_sram_dout(ioCtrl_io_sram_dout),
    .io_start(ioCtrl_io_start),
    .io_done(ioCtrl_io_done),
    .io_config(ioCtrl_io_config),
    .io_in_0(ioCtrl_io_in_0),
    .io_in_1(ioCtrl_io_in_1),
    .io_out_0(ioCtrl_io_out_0)
  );
  SharedDelayPipe delay_pipe ( // @[IOB.scala 68:66]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn Muxn ( // @[IOB.scala 70:43]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_out(Muxn_io_out)
  );
  Muxn Muxn_1 ( // @[IOB.scala 70:43]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem cfg ( // @[IOB.scala 152:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_done = ioCtrl_io_done; // @[IOB.scala 121:11]
  assign io_out_0 = ioCtrl_io_out_0; // @[IOB.scala 122:13]
  assign io_sram_en = ioCtrl_io_sram_en; // @[IOB.scala 119:18]
  assign io_sram_we = ioCtrl_io_sram_we; // @[IOB.scala 119:18]
  assign io_sram_addr = ioCtrl_io_sram_addr; // @[IOB.scala 119:18]
  assign io_sram_din = ioCtrl_io_sram_din; // @[IOB.scala 119:18]
  assign ioCtrl_clock = clock;
  assign ioCtrl_reset = reset;
  assign ioCtrl_io_sram_dout = io_sram_dout; // @[IOB.scala 119:18]
  assign ioCtrl_io_start = io_start; // @[IOB.scala 120:19]
  assign ioCtrl_io_config = cfg_io_out_0[126:0]; // @[IOB.scala 169:29]
  assign ioCtrl_io_in_0 = delay_pipe_io_out_0; // @[IOB.scala 134:23]
  assign ioCtrl_io_in_1 = delay_pipe_io_out_1; // @[IOB.scala 134:23]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[IOB.scala 132:24]
  assign delay_pipe_io_config = cfg_io_out_0[134:127]; // @[IOB.scala 180:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[IOB.scala 133:27]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[IOB.scala 133:27]
  assign Muxn_io_config = cfg_io_out_0[135]; // @[IOB.scala 186:32]
  assign Muxn_io_in_0 = io_in_0; // @[IOB.scala 128:10]
  assign Muxn_io_in_1 = io_in_1; // @[IOB.scala 128:10]
  assign Muxn_1_io_config = cfg_io_out_0[136]; // @[IOB.scala 186:32]
  assign Muxn_1_io_in_0 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_1_io_in_1 = 16'h0; // @[IOB.scala 128:10]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h3 == io_cfg_addr[11:3]; // @[IOB.scala 153:30]
  assign cfg_io_cfg_addr = io_cfg_addr[2:0]; // @[IOB.scala 154:33]
  assign cfg_io_cfg_data = io_cfg_data; // @[IOB.scala 155:19]
endmodule
module IOB_3(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  output        io_done,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  output [15:0] io_out_0,
  output        io_sram_en,
  output [1:0]  io_sram_we,
  output [14:0] io_sram_addr,
  output [15:0] io_sram_din,
  input  [15:0] io_sram_dout
);
  wire  ioCtrl_clock; // @[IOB.scala 67:22]
  wire  ioCtrl_reset; // @[IOB.scala 67:22]
  wire  ioCtrl_io_sram_en; // @[IOB.scala 67:22]
  wire [1:0] ioCtrl_io_sram_we; // @[IOB.scala 67:22]
  wire [14:0] ioCtrl_io_sram_addr; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_din; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_dout; // @[IOB.scala 67:22]
  wire  ioCtrl_io_start; // @[IOB.scala 67:22]
  wire  ioCtrl_io_done; // @[IOB.scala 67:22]
  wire [126:0] ioCtrl_io_config; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_0; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_1; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_out_0; // @[IOB.scala 67:22]
  wire  delay_pipe_clock; // @[IOB.scala 68:66]
  wire  delay_pipe_reset; // @[IOB.scala 68:66]
  wire  delay_pipe_io_en; // @[IOB.scala 68:66]
  wire [7:0] delay_pipe_io_config; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_1; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_1; // @[IOB.scala 68:66]
  wire  Muxn_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_out; // @[IOB.scala 70:43]
  wire  Muxn_1_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_out; // @[IOB.scala 70:43]
  wire  cfg_clock; // @[IOB.scala 152:19]
  wire  cfg_reset; // @[IOB.scala 152:19]
  wire  cfg_io_cfg_en; // @[IOB.scala 152:19]
  wire [2:0] cfg_io_cfg_addr; // @[IOB.scala 152:19]
  wire [31:0] cfg_io_cfg_data; // @[IOB.scala 152:19]
  wire [136:0] cfg_io_out_0; // @[IOB.scala 152:19]
  IOController ioCtrl ( // @[IOB.scala 67:22]
    .clock(ioCtrl_clock),
    .reset(ioCtrl_reset),
    .io_sram_en(ioCtrl_io_sram_en),
    .io_sram_we(ioCtrl_io_sram_we),
    .io_sram_addr(ioCtrl_io_sram_addr),
    .io_sram_din(ioCtrl_io_sram_din),
    .io_sram_dout(ioCtrl_io_sram_dout),
    .io_start(ioCtrl_io_start),
    .io_done(ioCtrl_io_done),
    .io_config(ioCtrl_io_config),
    .io_in_0(ioCtrl_io_in_0),
    .io_in_1(ioCtrl_io_in_1),
    .io_out_0(ioCtrl_io_out_0)
  );
  SharedDelayPipe delay_pipe ( // @[IOB.scala 68:66]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn Muxn ( // @[IOB.scala 70:43]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_out(Muxn_io_out)
  );
  Muxn Muxn_1 ( // @[IOB.scala 70:43]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem cfg ( // @[IOB.scala 152:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_done = ioCtrl_io_done; // @[IOB.scala 121:11]
  assign io_out_0 = ioCtrl_io_out_0; // @[IOB.scala 122:13]
  assign io_sram_en = ioCtrl_io_sram_en; // @[IOB.scala 119:18]
  assign io_sram_we = ioCtrl_io_sram_we; // @[IOB.scala 119:18]
  assign io_sram_addr = ioCtrl_io_sram_addr; // @[IOB.scala 119:18]
  assign io_sram_din = ioCtrl_io_sram_din; // @[IOB.scala 119:18]
  assign ioCtrl_clock = clock;
  assign ioCtrl_reset = reset;
  assign ioCtrl_io_sram_dout = io_sram_dout; // @[IOB.scala 119:18]
  assign ioCtrl_io_start = io_start; // @[IOB.scala 120:19]
  assign ioCtrl_io_config = cfg_io_out_0[126:0]; // @[IOB.scala 169:29]
  assign ioCtrl_io_in_0 = delay_pipe_io_out_0; // @[IOB.scala 134:23]
  assign ioCtrl_io_in_1 = delay_pipe_io_out_1; // @[IOB.scala 134:23]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[IOB.scala 132:24]
  assign delay_pipe_io_config = cfg_io_out_0[134:127]; // @[IOB.scala 180:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[IOB.scala 133:27]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[IOB.scala 133:27]
  assign Muxn_io_config = cfg_io_out_0[135]; // @[IOB.scala 186:32]
  assign Muxn_io_in_0 = io_in_0; // @[IOB.scala 128:10]
  assign Muxn_io_in_1 = io_in_1; // @[IOB.scala 128:10]
  assign Muxn_1_io_config = cfg_io_out_0[136]; // @[IOB.scala 186:32]
  assign Muxn_1_io_in_0 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_1_io_in_1 = 16'h0; // @[IOB.scala 128:10]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h4 == io_cfg_addr[11:3]; // @[IOB.scala 153:30]
  assign cfg_io_cfg_addr = io_cfg_addr[2:0]; // @[IOB.scala 154:33]
  assign cfg_io_cfg_data = io_cfg_data; // @[IOB.scala 155:19]
endmodule
module IOB_4(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  output        io_done,
  input         io_en,
  input  [15:0] io_in_0,
  output [15:0] io_out_0,
  output        io_sram_en,
  output [1:0]  io_sram_we,
  output [14:0] io_sram_addr,
  output [15:0] io_sram_din,
  input  [15:0] io_sram_dout
);
  wire  ioCtrl_clock; // @[IOB.scala 67:22]
  wire  ioCtrl_reset; // @[IOB.scala 67:22]
  wire  ioCtrl_io_sram_en; // @[IOB.scala 67:22]
  wire [1:0] ioCtrl_io_sram_we; // @[IOB.scala 67:22]
  wire [14:0] ioCtrl_io_sram_addr; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_din; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_dout; // @[IOB.scala 67:22]
  wire  ioCtrl_io_start; // @[IOB.scala 67:22]
  wire  ioCtrl_io_done; // @[IOB.scala 67:22]
  wire [126:0] ioCtrl_io_config; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_0; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_1; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_out_0; // @[IOB.scala 67:22]
  wire  delay_pipe_clock; // @[IOB.scala 68:66]
  wire  delay_pipe_reset; // @[IOB.scala 68:66]
  wire  delay_pipe_io_en; // @[IOB.scala 68:66]
  wire [7:0] delay_pipe_io_config; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_1; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_1; // @[IOB.scala 68:66]
  wire  Muxn_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_out; // @[IOB.scala 70:43]
  wire  Muxn_1_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_out; // @[IOB.scala 70:43]
  wire  cfg_clock; // @[IOB.scala 152:19]
  wire  cfg_reset; // @[IOB.scala 152:19]
  wire  cfg_io_cfg_en; // @[IOB.scala 152:19]
  wire [2:0] cfg_io_cfg_addr; // @[IOB.scala 152:19]
  wire [31:0] cfg_io_cfg_data; // @[IOB.scala 152:19]
  wire [136:0] cfg_io_out_0; // @[IOB.scala 152:19]
  IOController ioCtrl ( // @[IOB.scala 67:22]
    .clock(ioCtrl_clock),
    .reset(ioCtrl_reset),
    .io_sram_en(ioCtrl_io_sram_en),
    .io_sram_we(ioCtrl_io_sram_we),
    .io_sram_addr(ioCtrl_io_sram_addr),
    .io_sram_din(ioCtrl_io_sram_din),
    .io_sram_dout(ioCtrl_io_sram_dout),
    .io_start(ioCtrl_io_start),
    .io_done(ioCtrl_io_done),
    .io_config(ioCtrl_io_config),
    .io_in_0(ioCtrl_io_in_0),
    .io_in_1(ioCtrl_io_in_1),
    .io_out_0(ioCtrl_io_out_0)
  );
  SharedDelayPipe delay_pipe ( // @[IOB.scala 68:66]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn Muxn ( // @[IOB.scala 70:43]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_out(Muxn_io_out)
  );
  Muxn Muxn_1 ( // @[IOB.scala 70:43]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem cfg ( // @[IOB.scala 152:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_done = ioCtrl_io_done; // @[IOB.scala 121:11]
  assign io_out_0 = ioCtrl_io_out_0; // @[IOB.scala 122:13]
  assign io_sram_en = ioCtrl_io_sram_en; // @[IOB.scala 119:18]
  assign io_sram_we = ioCtrl_io_sram_we; // @[IOB.scala 119:18]
  assign io_sram_addr = ioCtrl_io_sram_addr; // @[IOB.scala 119:18]
  assign io_sram_din = ioCtrl_io_sram_din; // @[IOB.scala 119:18]
  assign ioCtrl_clock = clock;
  assign ioCtrl_reset = reset;
  assign ioCtrl_io_sram_dout = io_sram_dout; // @[IOB.scala 119:18]
  assign ioCtrl_io_start = io_start; // @[IOB.scala 120:19]
  assign ioCtrl_io_config = cfg_io_out_0[126:0]; // @[IOB.scala 169:29]
  assign ioCtrl_io_in_0 = delay_pipe_io_out_0; // @[IOB.scala 134:23]
  assign ioCtrl_io_in_1 = delay_pipe_io_out_1; // @[IOB.scala 134:23]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[IOB.scala 132:24]
  assign delay_pipe_io_config = cfg_io_out_0[134:127]; // @[IOB.scala 180:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[IOB.scala 133:27]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[IOB.scala 133:27]
  assign Muxn_io_config = cfg_io_out_0[135]; // @[IOB.scala 186:32]
  assign Muxn_io_in_0 = io_in_0; // @[IOB.scala 128:10]
  assign Muxn_io_in_1 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_1_io_config = cfg_io_out_0[136]; // @[IOB.scala 186:32]
  assign Muxn_1_io_in_0 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_1_io_in_1 = 16'h0; // @[IOB.scala 128:10]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h5 == io_cfg_addr[11:3]; // @[IOB.scala 153:30]
  assign cfg_io_cfg_addr = io_cfg_addr[2:0]; // @[IOB.scala 154:33]
  assign cfg_io_cfg_data = io_cfg_data; // @[IOB.scala 155:19]
endmodule
module IOB_5(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  output        io_done,
  input         io_en,
  input  [15:0] io_in_1,
  output [15:0] io_out_0,
  output        io_sram_en,
  output [1:0]  io_sram_we,
  output [14:0] io_sram_addr,
  output [15:0] io_sram_din,
  input  [15:0] io_sram_dout
);
  wire  ioCtrl_clock; // @[IOB.scala 67:22]
  wire  ioCtrl_reset; // @[IOB.scala 67:22]
  wire  ioCtrl_io_sram_en; // @[IOB.scala 67:22]
  wire [1:0] ioCtrl_io_sram_we; // @[IOB.scala 67:22]
  wire [14:0] ioCtrl_io_sram_addr; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_din; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_dout; // @[IOB.scala 67:22]
  wire  ioCtrl_io_start; // @[IOB.scala 67:22]
  wire  ioCtrl_io_done; // @[IOB.scala 67:22]
  wire [126:0] ioCtrl_io_config; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_0; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_1; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_out_0; // @[IOB.scala 67:22]
  wire  delay_pipe_clock; // @[IOB.scala 68:66]
  wire  delay_pipe_reset; // @[IOB.scala 68:66]
  wire  delay_pipe_io_en; // @[IOB.scala 68:66]
  wire [7:0] delay_pipe_io_config; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_1; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_1; // @[IOB.scala 68:66]
  wire  Muxn_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_out; // @[IOB.scala 70:43]
  wire  Muxn_1_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_out; // @[IOB.scala 70:43]
  wire  cfg_clock; // @[IOB.scala 152:19]
  wire  cfg_reset; // @[IOB.scala 152:19]
  wire  cfg_io_cfg_en; // @[IOB.scala 152:19]
  wire [2:0] cfg_io_cfg_addr; // @[IOB.scala 152:19]
  wire [31:0] cfg_io_cfg_data; // @[IOB.scala 152:19]
  wire [136:0] cfg_io_out_0; // @[IOB.scala 152:19]
  IOController ioCtrl ( // @[IOB.scala 67:22]
    .clock(ioCtrl_clock),
    .reset(ioCtrl_reset),
    .io_sram_en(ioCtrl_io_sram_en),
    .io_sram_we(ioCtrl_io_sram_we),
    .io_sram_addr(ioCtrl_io_sram_addr),
    .io_sram_din(ioCtrl_io_sram_din),
    .io_sram_dout(ioCtrl_io_sram_dout),
    .io_start(ioCtrl_io_start),
    .io_done(ioCtrl_io_done),
    .io_config(ioCtrl_io_config),
    .io_in_0(ioCtrl_io_in_0),
    .io_in_1(ioCtrl_io_in_1),
    .io_out_0(ioCtrl_io_out_0)
  );
  SharedDelayPipe delay_pipe ( // @[IOB.scala 68:66]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn Muxn ( // @[IOB.scala 70:43]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_out(Muxn_io_out)
  );
  Muxn Muxn_1 ( // @[IOB.scala 70:43]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem cfg ( // @[IOB.scala 152:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_done = ioCtrl_io_done; // @[IOB.scala 121:11]
  assign io_out_0 = ioCtrl_io_out_0; // @[IOB.scala 122:13]
  assign io_sram_en = ioCtrl_io_sram_en; // @[IOB.scala 119:18]
  assign io_sram_we = ioCtrl_io_sram_we; // @[IOB.scala 119:18]
  assign io_sram_addr = ioCtrl_io_sram_addr; // @[IOB.scala 119:18]
  assign io_sram_din = ioCtrl_io_sram_din; // @[IOB.scala 119:18]
  assign ioCtrl_clock = clock;
  assign ioCtrl_reset = reset;
  assign ioCtrl_io_sram_dout = io_sram_dout; // @[IOB.scala 119:18]
  assign ioCtrl_io_start = io_start; // @[IOB.scala 120:19]
  assign ioCtrl_io_config = cfg_io_out_0[126:0]; // @[IOB.scala 169:29]
  assign ioCtrl_io_in_0 = delay_pipe_io_out_0; // @[IOB.scala 134:23]
  assign ioCtrl_io_in_1 = delay_pipe_io_out_1; // @[IOB.scala 134:23]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[IOB.scala 132:24]
  assign delay_pipe_io_config = cfg_io_out_0[134:127]; // @[IOB.scala 180:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[IOB.scala 133:27]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[IOB.scala 133:27]
  assign Muxn_io_config = cfg_io_out_0[135]; // @[IOB.scala 186:32]
  assign Muxn_io_in_0 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_io_in_1 = io_in_1; // @[IOB.scala 128:10]
  assign Muxn_1_io_config = cfg_io_out_0[136]; // @[IOB.scala 186:32]
  assign Muxn_1_io_in_0 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_1_io_in_1 = 16'h0; // @[IOB.scala 128:10]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h3d == io_cfg_addr[11:3]; // @[IOB.scala 153:30]
  assign cfg_io_cfg_addr = io_cfg_addr[2:0]; // @[IOB.scala 154:33]
  assign cfg_io_cfg_data = io_cfg_data; // @[IOB.scala 155:19]
endmodule
module IOB_6(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  output        io_done,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  output [15:0] io_out_0,
  output        io_sram_en,
  output [1:0]  io_sram_we,
  output [14:0] io_sram_addr,
  output [15:0] io_sram_din,
  input  [15:0] io_sram_dout
);
  wire  ioCtrl_clock; // @[IOB.scala 67:22]
  wire  ioCtrl_reset; // @[IOB.scala 67:22]
  wire  ioCtrl_io_sram_en; // @[IOB.scala 67:22]
  wire [1:0] ioCtrl_io_sram_we; // @[IOB.scala 67:22]
  wire [14:0] ioCtrl_io_sram_addr; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_din; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_dout; // @[IOB.scala 67:22]
  wire  ioCtrl_io_start; // @[IOB.scala 67:22]
  wire  ioCtrl_io_done; // @[IOB.scala 67:22]
  wire [126:0] ioCtrl_io_config; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_0; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_1; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_out_0; // @[IOB.scala 67:22]
  wire  delay_pipe_clock; // @[IOB.scala 68:66]
  wire  delay_pipe_reset; // @[IOB.scala 68:66]
  wire  delay_pipe_io_en; // @[IOB.scala 68:66]
  wire [7:0] delay_pipe_io_config; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_1; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_1; // @[IOB.scala 68:66]
  wire  Muxn_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_out; // @[IOB.scala 70:43]
  wire  Muxn_1_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_out; // @[IOB.scala 70:43]
  wire  cfg_clock; // @[IOB.scala 152:19]
  wire  cfg_reset; // @[IOB.scala 152:19]
  wire  cfg_io_cfg_en; // @[IOB.scala 152:19]
  wire [2:0] cfg_io_cfg_addr; // @[IOB.scala 152:19]
  wire [31:0] cfg_io_cfg_data; // @[IOB.scala 152:19]
  wire [136:0] cfg_io_out_0; // @[IOB.scala 152:19]
  IOController ioCtrl ( // @[IOB.scala 67:22]
    .clock(ioCtrl_clock),
    .reset(ioCtrl_reset),
    .io_sram_en(ioCtrl_io_sram_en),
    .io_sram_we(ioCtrl_io_sram_we),
    .io_sram_addr(ioCtrl_io_sram_addr),
    .io_sram_din(ioCtrl_io_sram_din),
    .io_sram_dout(ioCtrl_io_sram_dout),
    .io_start(ioCtrl_io_start),
    .io_done(ioCtrl_io_done),
    .io_config(ioCtrl_io_config),
    .io_in_0(ioCtrl_io_in_0),
    .io_in_1(ioCtrl_io_in_1),
    .io_out_0(ioCtrl_io_out_0)
  );
  SharedDelayPipe delay_pipe ( // @[IOB.scala 68:66]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn Muxn ( // @[IOB.scala 70:43]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_out(Muxn_io_out)
  );
  Muxn Muxn_1 ( // @[IOB.scala 70:43]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem cfg ( // @[IOB.scala 152:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_done = ioCtrl_io_done; // @[IOB.scala 121:11]
  assign io_out_0 = ioCtrl_io_out_0; // @[IOB.scala 122:13]
  assign io_sram_en = ioCtrl_io_sram_en; // @[IOB.scala 119:18]
  assign io_sram_we = ioCtrl_io_sram_we; // @[IOB.scala 119:18]
  assign io_sram_addr = ioCtrl_io_sram_addr; // @[IOB.scala 119:18]
  assign io_sram_din = ioCtrl_io_sram_din; // @[IOB.scala 119:18]
  assign ioCtrl_clock = clock;
  assign ioCtrl_reset = reset;
  assign ioCtrl_io_sram_dout = io_sram_dout; // @[IOB.scala 119:18]
  assign ioCtrl_io_start = io_start; // @[IOB.scala 120:19]
  assign ioCtrl_io_config = cfg_io_out_0[126:0]; // @[IOB.scala 169:29]
  assign ioCtrl_io_in_0 = delay_pipe_io_out_0; // @[IOB.scala 134:23]
  assign ioCtrl_io_in_1 = delay_pipe_io_out_1; // @[IOB.scala 134:23]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[IOB.scala 132:24]
  assign delay_pipe_io_config = cfg_io_out_0[134:127]; // @[IOB.scala 180:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[IOB.scala 133:27]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[IOB.scala 133:27]
  assign Muxn_io_config = cfg_io_out_0[135]; // @[IOB.scala 186:32]
  assign Muxn_io_in_0 = io_in_0; // @[IOB.scala 128:10]
  assign Muxn_io_in_1 = io_in_1; // @[IOB.scala 128:10]
  assign Muxn_1_io_config = cfg_io_out_0[136]; // @[IOB.scala 186:32]
  assign Muxn_1_io_in_0 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_1_io_in_1 = 16'h0; // @[IOB.scala 128:10]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h3e == io_cfg_addr[11:3]; // @[IOB.scala 153:30]
  assign cfg_io_cfg_addr = io_cfg_addr[2:0]; // @[IOB.scala 154:33]
  assign cfg_io_cfg_data = io_cfg_data; // @[IOB.scala 155:19]
endmodule
module IOB_7(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  output        io_done,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  output [15:0] io_out_0,
  output        io_sram_en,
  output [1:0]  io_sram_we,
  output [14:0] io_sram_addr,
  output [15:0] io_sram_din,
  input  [15:0] io_sram_dout
);
  wire  ioCtrl_clock; // @[IOB.scala 67:22]
  wire  ioCtrl_reset; // @[IOB.scala 67:22]
  wire  ioCtrl_io_sram_en; // @[IOB.scala 67:22]
  wire [1:0] ioCtrl_io_sram_we; // @[IOB.scala 67:22]
  wire [14:0] ioCtrl_io_sram_addr; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_din; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_dout; // @[IOB.scala 67:22]
  wire  ioCtrl_io_start; // @[IOB.scala 67:22]
  wire  ioCtrl_io_done; // @[IOB.scala 67:22]
  wire [126:0] ioCtrl_io_config; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_0; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_1; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_out_0; // @[IOB.scala 67:22]
  wire  delay_pipe_clock; // @[IOB.scala 68:66]
  wire  delay_pipe_reset; // @[IOB.scala 68:66]
  wire  delay_pipe_io_en; // @[IOB.scala 68:66]
  wire [7:0] delay_pipe_io_config; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_1; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_1; // @[IOB.scala 68:66]
  wire  Muxn_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_out; // @[IOB.scala 70:43]
  wire  Muxn_1_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_out; // @[IOB.scala 70:43]
  wire  cfg_clock; // @[IOB.scala 152:19]
  wire  cfg_reset; // @[IOB.scala 152:19]
  wire  cfg_io_cfg_en; // @[IOB.scala 152:19]
  wire [2:0] cfg_io_cfg_addr; // @[IOB.scala 152:19]
  wire [31:0] cfg_io_cfg_data; // @[IOB.scala 152:19]
  wire [136:0] cfg_io_out_0; // @[IOB.scala 152:19]
  IOController ioCtrl ( // @[IOB.scala 67:22]
    .clock(ioCtrl_clock),
    .reset(ioCtrl_reset),
    .io_sram_en(ioCtrl_io_sram_en),
    .io_sram_we(ioCtrl_io_sram_we),
    .io_sram_addr(ioCtrl_io_sram_addr),
    .io_sram_din(ioCtrl_io_sram_din),
    .io_sram_dout(ioCtrl_io_sram_dout),
    .io_start(ioCtrl_io_start),
    .io_done(ioCtrl_io_done),
    .io_config(ioCtrl_io_config),
    .io_in_0(ioCtrl_io_in_0),
    .io_in_1(ioCtrl_io_in_1),
    .io_out_0(ioCtrl_io_out_0)
  );
  SharedDelayPipe delay_pipe ( // @[IOB.scala 68:66]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn Muxn ( // @[IOB.scala 70:43]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_out(Muxn_io_out)
  );
  Muxn Muxn_1 ( // @[IOB.scala 70:43]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem cfg ( // @[IOB.scala 152:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_done = ioCtrl_io_done; // @[IOB.scala 121:11]
  assign io_out_0 = ioCtrl_io_out_0; // @[IOB.scala 122:13]
  assign io_sram_en = ioCtrl_io_sram_en; // @[IOB.scala 119:18]
  assign io_sram_we = ioCtrl_io_sram_we; // @[IOB.scala 119:18]
  assign io_sram_addr = ioCtrl_io_sram_addr; // @[IOB.scala 119:18]
  assign io_sram_din = ioCtrl_io_sram_din; // @[IOB.scala 119:18]
  assign ioCtrl_clock = clock;
  assign ioCtrl_reset = reset;
  assign ioCtrl_io_sram_dout = io_sram_dout; // @[IOB.scala 119:18]
  assign ioCtrl_io_start = io_start; // @[IOB.scala 120:19]
  assign ioCtrl_io_config = cfg_io_out_0[126:0]; // @[IOB.scala 169:29]
  assign ioCtrl_io_in_0 = delay_pipe_io_out_0; // @[IOB.scala 134:23]
  assign ioCtrl_io_in_1 = delay_pipe_io_out_1; // @[IOB.scala 134:23]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[IOB.scala 132:24]
  assign delay_pipe_io_config = cfg_io_out_0[134:127]; // @[IOB.scala 180:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[IOB.scala 133:27]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[IOB.scala 133:27]
  assign Muxn_io_config = cfg_io_out_0[135]; // @[IOB.scala 186:32]
  assign Muxn_io_in_0 = io_in_0; // @[IOB.scala 128:10]
  assign Muxn_io_in_1 = io_in_1; // @[IOB.scala 128:10]
  assign Muxn_1_io_config = cfg_io_out_0[136]; // @[IOB.scala 186:32]
  assign Muxn_1_io_in_0 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_1_io_in_1 = 16'h0; // @[IOB.scala 128:10]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h3f == io_cfg_addr[11:3]; // @[IOB.scala 153:30]
  assign cfg_io_cfg_addr = io_cfg_addr[2:0]; // @[IOB.scala 154:33]
  assign cfg_io_cfg_data = io_cfg_data; // @[IOB.scala 155:19]
endmodule
module IOB_8(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  output        io_done,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  output [15:0] io_out_0,
  output        io_sram_en,
  output [1:0]  io_sram_we,
  output [14:0] io_sram_addr,
  output [15:0] io_sram_din,
  input  [15:0] io_sram_dout
);
  wire  ioCtrl_clock; // @[IOB.scala 67:22]
  wire  ioCtrl_reset; // @[IOB.scala 67:22]
  wire  ioCtrl_io_sram_en; // @[IOB.scala 67:22]
  wire [1:0] ioCtrl_io_sram_we; // @[IOB.scala 67:22]
  wire [14:0] ioCtrl_io_sram_addr; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_din; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_dout; // @[IOB.scala 67:22]
  wire  ioCtrl_io_start; // @[IOB.scala 67:22]
  wire  ioCtrl_io_done; // @[IOB.scala 67:22]
  wire [126:0] ioCtrl_io_config; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_0; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_1; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_out_0; // @[IOB.scala 67:22]
  wire  delay_pipe_clock; // @[IOB.scala 68:66]
  wire  delay_pipe_reset; // @[IOB.scala 68:66]
  wire  delay_pipe_io_en; // @[IOB.scala 68:66]
  wire [7:0] delay_pipe_io_config; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_1; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_1; // @[IOB.scala 68:66]
  wire  Muxn_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_out; // @[IOB.scala 70:43]
  wire  Muxn_1_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_out; // @[IOB.scala 70:43]
  wire  cfg_clock; // @[IOB.scala 152:19]
  wire  cfg_reset; // @[IOB.scala 152:19]
  wire  cfg_io_cfg_en; // @[IOB.scala 152:19]
  wire [2:0] cfg_io_cfg_addr; // @[IOB.scala 152:19]
  wire [31:0] cfg_io_cfg_data; // @[IOB.scala 152:19]
  wire [136:0] cfg_io_out_0; // @[IOB.scala 152:19]
  IOController ioCtrl ( // @[IOB.scala 67:22]
    .clock(ioCtrl_clock),
    .reset(ioCtrl_reset),
    .io_sram_en(ioCtrl_io_sram_en),
    .io_sram_we(ioCtrl_io_sram_we),
    .io_sram_addr(ioCtrl_io_sram_addr),
    .io_sram_din(ioCtrl_io_sram_din),
    .io_sram_dout(ioCtrl_io_sram_dout),
    .io_start(ioCtrl_io_start),
    .io_done(ioCtrl_io_done),
    .io_config(ioCtrl_io_config),
    .io_in_0(ioCtrl_io_in_0),
    .io_in_1(ioCtrl_io_in_1),
    .io_out_0(ioCtrl_io_out_0)
  );
  SharedDelayPipe delay_pipe ( // @[IOB.scala 68:66]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn Muxn ( // @[IOB.scala 70:43]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_out(Muxn_io_out)
  );
  Muxn Muxn_1 ( // @[IOB.scala 70:43]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem cfg ( // @[IOB.scala 152:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_done = ioCtrl_io_done; // @[IOB.scala 121:11]
  assign io_out_0 = ioCtrl_io_out_0; // @[IOB.scala 122:13]
  assign io_sram_en = ioCtrl_io_sram_en; // @[IOB.scala 119:18]
  assign io_sram_we = ioCtrl_io_sram_we; // @[IOB.scala 119:18]
  assign io_sram_addr = ioCtrl_io_sram_addr; // @[IOB.scala 119:18]
  assign io_sram_din = ioCtrl_io_sram_din; // @[IOB.scala 119:18]
  assign ioCtrl_clock = clock;
  assign ioCtrl_reset = reset;
  assign ioCtrl_io_sram_dout = io_sram_dout; // @[IOB.scala 119:18]
  assign ioCtrl_io_start = io_start; // @[IOB.scala 120:19]
  assign ioCtrl_io_config = cfg_io_out_0[126:0]; // @[IOB.scala 169:29]
  assign ioCtrl_io_in_0 = delay_pipe_io_out_0; // @[IOB.scala 134:23]
  assign ioCtrl_io_in_1 = delay_pipe_io_out_1; // @[IOB.scala 134:23]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[IOB.scala 132:24]
  assign delay_pipe_io_config = cfg_io_out_0[134:127]; // @[IOB.scala 180:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[IOB.scala 133:27]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[IOB.scala 133:27]
  assign Muxn_io_config = cfg_io_out_0[135]; // @[IOB.scala 186:32]
  assign Muxn_io_in_0 = io_in_0; // @[IOB.scala 128:10]
  assign Muxn_io_in_1 = io_in_1; // @[IOB.scala 128:10]
  assign Muxn_1_io_config = cfg_io_out_0[136]; // @[IOB.scala 186:32]
  assign Muxn_1_io_in_0 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_1_io_in_1 = 16'h0; // @[IOB.scala 128:10]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h40 == io_cfg_addr[11:3]; // @[IOB.scala 153:30]
  assign cfg_io_cfg_addr = io_cfg_addr[2:0]; // @[IOB.scala 154:33]
  assign cfg_io_cfg_data = io_cfg_data; // @[IOB.scala 155:19]
endmodule
module IOB_9(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  output        io_done,
  input         io_en,
  input  [15:0] io_in_0,
  output [15:0] io_out_0,
  output        io_sram_en,
  output [1:0]  io_sram_we,
  output [14:0] io_sram_addr,
  output [15:0] io_sram_din,
  input  [15:0] io_sram_dout
);
  wire  ioCtrl_clock; // @[IOB.scala 67:22]
  wire  ioCtrl_reset; // @[IOB.scala 67:22]
  wire  ioCtrl_io_sram_en; // @[IOB.scala 67:22]
  wire [1:0] ioCtrl_io_sram_we; // @[IOB.scala 67:22]
  wire [14:0] ioCtrl_io_sram_addr; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_din; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_sram_dout; // @[IOB.scala 67:22]
  wire  ioCtrl_io_start; // @[IOB.scala 67:22]
  wire  ioCtrl_io_done; // @[IOB.scala 67:22]
  wire [126:0] ioCtrl_io_config; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_0; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_in_1; // @[IOB.scala 67:22]
  wire [15:0] ioCtrl_io_out_0; // @[IOB.scala 67:22]
  wire  delay_pipe_clock; // @[IOB.scala 68:66]
  wire  delay_pipe_reset; // @[IOB.scala 68:66]
  wire  delay_pipe_io_en; // @[IOB.scala 68:66]
  wire [7:0] delay_pipe_io_config; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_in_1; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_0; // @[IOB.scala 68:66]
  wire [15:0] delay_pipe_io_out_1; // @[IOB.scala 68:66]
  wire  Muxn_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_io_out; // @[IOB.scala 70:43]
  wire  Muxn_1_io_config; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_0; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_in_1; // @[IOB.scala 70:43]
  wire [15:0] Muxn_1_io_out; // @[IOB.scala 70:43]
  wire  cfg_clock; // @[IOB.scala 152:19]
  wire  cfg_reset; // @[IOB.scala 152:19]
  wire  cfg_io_cfg_en; // @[IOB.scala 152:19]
  wire [2:0] cfg_io_cfg_addr; // @[IOB.scala 152:19]
  wire [31:0] cfg_io_cfg_data; // @[IOB.scala 152:19]
  wire [136:0] cfg_io_out_0; // @[IOB.scala 152:19]
  IOController ioCtrl ( // @[IOB.scala 67:22]
    .clock(ioCtrl_clock),
    .reset(ioCtrl_reset),
    .io_sram_en(ioCtrl_io_sram_en),
    .io_sram_we(ioCtrl_io_sram_we),
    .io_sram_addr(ioCtrl_io_sram_addr),
    .io_sram_din(ioCtrl_io_sram_din),
    .io_sram_dout(ioCtrl_io_sram_dout),
    .io_start(ioCtrl_io_start),
    .io_done(ioCtrl_io_done),
    .io_config(ioCtrl_io_config),
    .io_in_0(ioCtrl_io_in_0),
    .io_in_1(ioCtrl_io_in_1),
    .io_out_0(ioCtrl_io_out_0)
  );
  SharedDelayPipe delay_pipe ( // @[IOB.scala 68:66]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn Muxn ( // @[IOB.scala 70:43]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_out(Muxn_io_out)
  );
  Muxn Muxn_1 ( // @[IOB.scala 70:43]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem cfg ( // @[IOB.scala 152:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_done = ioCtrl_io_done; // @[IOB.scala 121:11]
  assign io_out_0 = ioCtrl_io_out_0; // @[IOB.scala 122:13]
  assign io_sram_en = ioCtrl_io_sram_en; // @[IOB.scala 119:18]
  assign io_sram_we = ioCtrl_io_sram_we; // @[IOB.scala 119:18]
  assign io_sram_addr = ioCtrl_io_sram_addr; // @[IOB.scala 119:18]
  assign io_sram_din = ioCtrl_io_sram_din; // @[IOB.scala 119:18]
  assign ioCtrl_clock = clock;
  assign ioCtrl_reset = reset;
  assign ioCtrl_io_sram_dout = io_sram_dout; // @[IOB.scala 119:18]
  assign ioCtrl_io_start = io_start; // @[IOB.scala 120:19]
  assign ioCtrl_io_config = cfg_io_out_0[126:0]; // @[IOB.scala 169:29]
  assign ioCtrl_io_in_0 = delay_pipe_io_out_0; // @[IOB.scala 134:23]
  assign ioCtrl_io_in_1 = delay_pipe_io_out_1; // @[IOB.scala 134:23]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[IOB.scala 132:24]
  assign delay_pipe_io_config = cfg_io_out_0[134:127]; // @[IOB.scala 180:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[IOB.scala 133:27]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[IOB.scala 133:27]
  assign Muxn_io_config = cfg_io_out_0[135]; // @[IOB.scala 186:32]
  assign Muxn_io_in_0 = io_in_0; // @[IOB.scala 128:10]
  assign Muxn_io_in_1 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_1_io_config = cfg_io_out_0[136]; // @[IOB.scala 186:32]
  assign Muxn_1_io_in_0 = 16'h0; // @[IOB.scala 128:10]
  assign Muxn_1_io_in_1 = 16'h0; // @[IOB.scala 128:10]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h41 == io_cfg_addr[11:3]; // @[IOB.scala 153:30]
  assign cfg_io_cfg_addr = io_cfg_addr[2:0]; // @[IOB.scala 154:33]
  assign cfg_io_cfg_data = io_cfg_data; // @[IOB.scala 155:19]
endmodule
module ALU(
  input  [2:0]  io_config,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  output [15:0] io_out
);
  wire [3:0] shn = io_in_1[3:0]; // @[Operations.scala 667:30]
  wire [15:0] _T_1 = io_in_0 + io_in_1; // @[Operations.scala 707:42]
  wire [15:0] _T_3 = io_in_0 - io_in_1; // @[Operations.scala 708:42]
  wire [31:0] _T_4 = io_in_0 * io_in_1; // @[Operations.scala 709:42]
  wire [30:0] _GEN_0 = {{15'd0}, io_in_0}; // @[Operations.scala 737:43]
  wire [30:0] _T_14 = _GEN_0 << shn; // @[Operations.scala 737:43]
  wire [15:0] _T_15 = io_in_0 >> shn; // @[Operations.scala 738:44]
  wire [15:0] _T_18 = $signed(io_in_0) >>> shn; // @[Operations.scala 739:59]
  wire [15:0] _io_out_T_1 = 3'h0 == io_config ? io_in_0 : 16'h0; // @[Mux.scala 81:58]
  wire [15:0] _io_out_T_3 = 3'h1 == io_config ? _T_1 : _io_out_T_1; // @[Mux.scala 81:58]
  wire [15:0] _io_out_T_5 = 3'h2 == io_config ? _T_3 : _io_out_T_3; // @[Mux.scala 81:58]
  wire [31:0] _io_out_T_7 = 3'h3 == io_config ? _T_4 : {{16'd0}, _io_out_T_5}; // @[Mux.scala 81:58]
  wire [31:0] _io_out_T_9 = 3'h4 == io_config ? {{1'd0}, _T_14} : _io_out_T_7; // @[Mux.scala 81:58]
  wire [31:0] _io_out_T_11 = 3'h5 == io_config ? {{16'd0}, _T_15} : _io_out_T_9; // @[Mux.scala 81:58]
  wire [31:0] _io_out_T_13 = 3'h6 == io_config ? {{16'd0}, _T_18} : _io_out_T_11; // @[Mux.scala 81:58]
  assign io_out = _io_out_T_13[15:0]; // @[ALU.scala 46:10]
endmodule
module AffineCtrlReg(
  input         clock,
  input         reset,
  input         io_start,
  input  [2:0]  io_mode,
  input         io_en,
  input  [58:0] io_config,
  input  [15:0] io_in_0,
  output [15:0] io_out_0,
  output [15:0] io_out_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] valueReg; // @[AffineCtrlReg.scala 35:25]
  wire [15:0] initVal = io_config[15:0]; // @[AffineCtrlReg.scala 46:26]
  wire [11:0] WI = io_config[27:16]; // @[AffineCtrlReg.scala 50:21]
  wire [5:0] latency = io_config[33:28]; // @[AffineCtrlReg.scala 54:26]
  wire [11:0] cycles = io_config[45:34]; // @[AffineCtrlReg.scala 58:25]
  wire [11:0] repeats = io_config[57:46]; // @[AffineCtrlReg.scala 62:26]
  wire  skipFirst = io_config[58]; // @[AffineCtrlReg.scala 66:28]
  reg [1:0] state; // @[AffineCtrlReg.scala 94:22]
  reg [11:0] wiCnt; // @[AffineCtrlReg.scala 95:22]
  reg [5:0] latCnt; // @[AffineCtrlReg.scala 98:23]
  reg [11:0] cycleCnt; // @[AffineCtrlReg.scala 99:25]
  reg [11:0] repeatCnt; // @[AffineCtrlReg.scala 100:26]
  wire [11:0] _wiEnd_T_1 = wiCnt + 12'h1; // @[AffineCtrlReg.scala 102:147]
  wire  wiEnd = _wiEnd_T_1 >= WI; // @[AffineCtrlReg.scala 102:152]
  wire [11:0] _cycleCntEnd_T_1 = cycleCnt + 12'h1; // @[AffineCtrlReg.scala 103:131]
  wire  cycleCntEnd = _cycleCntEnd_T_1 >= cycles; // @[AffineCtrlReg.scala 103:136]
  wire [11:0] _repeatCntEnd_T_1 = repeatCnt + 12'h1; // @[AffineCtrlReg.scala 104:32]
  wire  repeatCntEnd = _repeatCntEnd_T_1 >= repeats; // @[AffineCtrlReg.scala 104:37]
  wire  INTLV = io_mode == 3'h7; // @[AffineCtrlReg.scala 107:23]
  wire  Mac = io_mode == 3'h6; // @[AffineCtrlReg.scala 108:23]
  wire  initSel = io_mode == 3'h5; // @[AffineCtrlReg.scala 109:25]
  wire  IACC = io_mode == 3'h4; // @[AffineCtrlReg.scala 110:22]
  wire  _init_T_2 = io_mode != 3'h3; // @[AffineCtrlReg.scala 111:55]
  wire  _init_T_3 = cycleCnt == 12'h0; // @[AffineCtrlReg.scala 111:75]
  wire  init = io_mode != 3'h3 & cycleCnt == 12'h0 & skipFirst; // @[AffineCtrlReg.scala 111:83]
  wire  en = io_mode == 3'h1 | initSel | IACC | INTLV | Mac; // @[AffineCtrlReg.scala 112:89]
  wire [5:0] _T_7 = latCnt + 6'h1; // @[AffineCtrlReg.scala 124:19]
  wire  _T_13 = ~io_en; // @[AffineCtrlReg.scala 133:59]
  wire [1:0] _GEN_3 = repeatCntEnd & cycleCntEnd & wiEnd | ~io_en ? 2'h0 : state; // @[AffineCtrlReg.scala 133:66 134:15 94:22]
  wire [1:0] _GEN_4 = INTLV & io_en ? 2'h2 : _GEN_3; // @[AffineCtrlReg.scala 130:27 131:15]
  wire  launch = state == 2'h2; // @[AffineCtrlReg.scala 139:23]
  wire  _T_15 = state == 2'h0; // @[AffineCtrlReg.scala 142:14]
  wire  _T_17 = launch & wiEnd; // @[AffineCtrlReg.scala 158:21]
  wire  _T_24 = launch & wiCnt == 12'h0; // @[AffineCtrlReg.scala 179:21]
  wire [15:0] _GEN_16 = initSel ? 16'h0 : initVal; // @[AffineCtrlReg.scala 183:26 185:18 187:18]
  wire [15:0] _GEN_17 = IACC ? 16'h0 : _GEN_16; // @[AffineCtrlReg.scala 181:17 182:18]
  wire [15:0] _GEN_18 = en ? io_in_0 : valueReg; // @[AffineCtrlReg.scala 189:20 190:16 35:25]
  wire [15:0] _GEN_19 = init ? _GEN_17 : _GEN_18; // @[AffineCtrlReg.scala 180:16]
  reg [15:0] valueRegAcc; // @[AffineCtrlReg.scala 200:28]
  wire  initAcc = _init_T_2 & (_init_T_3 & skipFirst | cycleCntEnd & ~skipFirst); // @[AffineCtrlReg.scala 210:66]
  wire [15:0] _GEN_22 = IACC ? 16'h0 : initVal; // @[AffineCtrlReg.scala 215:18 216:21 218:21]
  wire [15:0] _GEN_23 = en ? io_in_0 : valueRegAcc; // @[AffineCtrlReg.scala 220:20 221:19 200:28]
  wire [15:0] _GEN_24 = initAcc ? _GEN_22 : _GEN_23; // @[AffineCtrlReg.scala 214:19]
  assign io_out_0 = valueReg; // @[AffineCtrlReg.scala 198:13]
  assign io_out_1 = valueRegAcc; // @[AffineCtrlReg.scala 228:13]
  always @(posedge clock) begin
    if (reset) begin // @[AffineCtrlReg.scala 35:25]
      valueReg <= 16'h0; // @[AffineCtrlReg.scala 35:25]
    end else if (_T_13) begin // @[AffineCtrlReg.scala 224:16]
      valueReg <= 16'h0; // @[AffineCtrlReg.scala 225:14]
    end else if (io_mode == 3'h0 | INTLV) begin // @[AffineCtrlReg.scala 177:34]
      valueReg <= io_in_0; // @[AffineCtrlReg.scala 178:14]
    end else if (launch & wiCnt == 12'h0) begin // @[AffineCtrlReg.scala 179:39]
      valueReg <= _GEN_19;
    end
    if (reset) begin // @[AffineCtrlReg.scala 94:22]
      state <= 2'h0; // @[AffineCtrlReg.scala 94:22]
    end else if (2'h0 == state) begin // @[AffineCtrlReg.scala 114:16]
      if (io_start & latency == 6'h0) begin // @[AffineCtrlReg.scala 117:40]
        state <= 2'h2; // @[AffineCtrlReg.scala 118:15]
      end else if (io_start & latency != 6'h0) begin // @[AffineCtrlReg.scala 119:46]
        state <= 2'h1; // @[AffineCtrlReg.scala 120:15]
      end
    end else if (2'h1 == state) begin // @[AffineCtrlReg.scala 114:16]
      if (_T_7 >= latency) begin // @[AffineCtrlReg.scala 124:36]
        state <= 2'h2; // @[AffineCtrlReg.scala 125:15]
      end
    end else if (2'h2 == state) begin // @[AffineCtrlReg.scala 114:16]
      state <= _GEN_4;
    end
    if (reset) begin // @[AffineCtrlReg.scala 95:22]
      wiCnt <= 12'h0; // @[AffineCtrlReg.scala 95:22]
    end else if (state == 2'h0) begin // @[AffineCtrlReg.scala 142:25]
      wiCnt <= 12'h0; // @[AffineCtrlReg.scala 143:11]
    end else if (launch) begin // @[AffineCtrlReg.scala 148:21]
      if (wiEnd) begin // @[AffineCtrlReg.scala 149:17]
        wiCnt <= 12'h0;
      end else begin
        wiCnt <= _wiEnd_T_1;
      end
    end
    if (reset) begin // @[AffineCtrlReg.scala 98:23]
      latCnt <= 6'h0; // @[AffineCtrlReg.scala 98:23]
    end else if (2'h0 == state) begin // @[AffineCtrlReg.scala 114:16]
      latCnt <= 6'h0; // @[AffineCtrlReg.scala 116:14]
    end else if (2'h1 == state) begin // @[AffineCtrlReg.scala 114:16]
      latCnt <= _T_7; // @[AffineCtrlReg.scala 127:14]
    end
    if (reset) begin // @[AffineCtrlReg.scala 99:25]
      cycleCnt <= 12'h0; // @[AffineCtrlReg.scala 99:25]
    end else if (_T_15) begin // @[AffineCtrlReg.scala 156:25]
      cycleCnt <= 12'h0; // @[AffineCtrlReg.scala 157:14]
    end else if (launch & wiEnd) begin // @[AffineCtrlReg.scala 158:30]
      if (cycleCntEnd) begin // @[AffineCtrlReg.scala 159:20]
        cycleCnt <= 12'h0;
      end else begin
        cycleCnt <= _cycleCntEnd_T_1;
      end
    end
    if (reset) begin // @[AffineCtrlReg.scala 100:26]
      repeatCnt <= 12'h0; // @[AffineCtrlReg.scala 100:26]
    end else if (_T_15) begin // @[AffineCtrlReg.scala 162:25]
      repeatCnt <= 12'h0; // @[AffineCtrlReg.scala 163:15]
    end else if (_T_17 & cycleCntEnd) begin // @[AffineCtrlReg.scala 164:45]
      repeatCnt <= _repeatCntEnd_T_1; // @[AffineCtrlReg.scala 165:15]
    end
    if (reset) begin // @[AffineCtrlReg.scala 200:28]
      valueRegAcc <= 16'h0; // @[AffineCtrlReg.scala 200:28]
    end else if (_T_13) begin // @[AffineCtrlReg.scala 224:16]
      valueRegAcc <= 16'h0; // @[AffineCtrlReg.scala 226:17]
    end else if (_T_15) begin // @[AffineCtrlReg.scala 211:26]
      valueRegAcc <= initVal; // @[AffineCtrlReg.scala 212:17]
    end else if (_T_24) begin // @[AffineCtrlReg.scala 213:39]
      valueRegAcc <= _GEN_24;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  valueReg = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  state = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  wiCnt = _RAND_2[11:0];
  _RAND_3 = {1{`RANDOM}};
  latCnt = _RAND_3[5:0];
  _RAND_4 = {1{`RANDOM}};
  cycleCnt = _RAND_4[11:0];
  _RAND_5 = {1{`RANDOM}};
  repeatCnt = _RAND_5[11:0];
  _RAND_6 = {1{`RANDOM}};
  valueRegAcc = _RAND_6[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DualModeReg(
  input         clock,
  input         reset,
  input         io_start,
  input  [2:0]  io_mode,
  input  [58:0] io_config,
  input  [15:0] io_in_0,
  input         io_en,
  output [15:0] io_out_0,
  output [15:0] io_out_1
);
  wire  acr_clock; // @[AffineCtrlReg.scala 273:21]
  wire  acr_reset; // @[AffineCtrlReg.scala 273:21]
  wire  acr_io_start; // @[AffineCtrlReg.scala 273:21]
  wire [2:0] acr_io_mode; // @[AffineCtrlReg.scala 273:21]
  wire  acr_io_en; // @[AffineCtrlReg.scala 273:21]
  wire [58:0] acr_io_config; // @[AffineCtrlReg.scala 273:21]
  wire [15:0] acr_io_in_0; // @[AffineCtrlReg.scala 273:21]
  wire [15:0] acr_io_out_0; // @[AffineCtrlReg.scala 273:21]
  wire [15:0] acr_io_out_1; // @[AffineCtrlReg.scala 273:21]
  AffineCtrlReg acr ( // @[AffineCtrlReg.scala 273:21]
    .clock(acr_clock),
    .reset(acr_reset),
    .io_start(acr_io_start),
    .io_mode(acr_io_mode),
    .io_en(acr_io_en),
    .io_config(acr_io_config),
    .io_in_0(acr_io_in_0),
    .io_out_0(acr_io_out_0),
    .io_out_1(acr_io_out_1)
  );
  assign io_out_0 = acr_io_out_0; // @[AffineCtrlReg.scala 285:12]
  assign io_out_1 = acr_io_out_1; // @[AffineCtrlReg.scala 285:12]
  assign acr_clock = clock;
  assign acr_reset = reset;
  assign acr_io_start = io_start; // @[AffineCtrlReg.scala 274:18]
  assign acr_io_mode = io_mode; // @[AffineCtrlReg.scala 275:17]
  assign acr_io_en = io_en; // @[AffineCtrlReg.scala 283:15]
  assign acr_io_config = io_config; // @[AffineCtrlReg.scala 276:19]
  assign acr_io_in_0 = io_in_0; // @[AffineCtrlReg.scala 279:18]
endmodule
module Muxn_20(
  input  [2:0]  io_config,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  input  [15:0] io_in_4,
  output [15:0] io_out
);
  wire [15:0] _io_out_T_3 = 3'h1 == io_config ? io_in_1 : io_in_0; // @[Mux.scala 81:58]
  wire [15:0] _io_out_T_5 = 3'h2 == io_config ? io_in_2 : _io_out_T_3; // @[Mux.scala 81:58]
  wire [15:0] _io_out_T_7 = 3'h3 == io_config ? io_in_3 : _io_out_T_5; // @[Mux.scala 81:58]
  assign io_out = 3'h4 == io_config ? io_in_4 : _io_out_T_7; // @[Mux.scala 81:58]
endmodule
module ConfigMem_10(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [1:0]  io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [92:0] io_out_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [95:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [92:0] regs_0; // @[ConfigMem.scala 27:21]
  wire [92:0] _regs_0_T_1 = {regs_0[92:32],io_cfg_data}; // @[Cat.scala 33:92]
  wire [92:0] _GEN_0 = io_cfg_en & io_cfg_addr == 2'h0 ? _regs_0_T_1 : regs_0; // @[ConfigMem.scala 39:47 41:19 27:21]
  wire [92:0] _regs_0_T_4 = {regs_0[92:64],io_cfg_data,regs_0[31:0]}; // @[Cat.scala 33:92]
  wire [92:0] _GEN_1 = io_cfg_en & io_cfg_addr == 2'h1 ? _regs_0_T_4 : _GEN_0; // @[ConfigMem.scala 39:47 45:19]
  wire [95:0] _regs_0_T_6 = {io_cfg_data,regs_0[63:0]}; // @[Cat.scala 33:92]
  wire [95:0] _GEN_2 = io_cfg_en & io_cfg_addr == 2'h2 ? _regs_0_T_6 : {{3'd0}, _GEN_1}; // @[ConfigMem.scala 39:47 43:19]
  wire [95:0] _GEN_3 = reset ? 96'h0 : _GEN_2; // @[ConfigMem.scala 27:{21,21}]
  assign io_out_0 = regs_0; // @[ConfigMem.scala 52:45]
  always @(posedge clock) begin
    regs_0 <= _GEN_3[92:0]; // @[ConfigMem.scala 27:{21,21}]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {3{`RANDOM}};
  regs_0 = _RAND_0[92:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GPE(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_1,
  input  [15:0] io_in_3,
  input  [15:0] io_in_4,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = io_in_4; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'hb == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_1(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  input  [15:0] io_in_4,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = io_in_4; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'hc == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_2(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  input  [15:0] io_in_4,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = io_in_4; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'hd == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_3(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  input  [15:0] io_in_4,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = io_in_4; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'he == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_4(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_2,
  input  [15:0] io_in_4,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = io_in_4; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'hf == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_5(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_1,
  input  [15:0] io_in_3,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h15 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_6(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h16 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_7(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h17 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_8(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h18 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_9(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_2,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h19 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_10(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_1,
  input  [15:0] io_in_3,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h1f == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_11(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h20 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_12(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h21 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_13(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h22 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_14(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_2,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h23 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_15(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_1,
  input  [15:0] io_in_3,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h29 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_16(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h2a == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_17(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h2b == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_18(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h2c == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_19(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_2,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h2d == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_20(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_1,
  input  [15:0] io_in_3,
  input  [15:0] io_in_7,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = io_in_7; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h33 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_21(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  input  [15:0] io_in_7,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = io_in_7; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h34 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_22(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  input  [15:0] io_in_7,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = io_in_7; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h35 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_23(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  input  [15:0] io_in_3,
  input  [15:0] io_in_7,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = io_in_1; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = io_in_3; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = io_in_7; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h36 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GPE_24(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input         io_start,
  input         io_en,
  input  [15:0] io_in_0,
  input  [15:0] io_in_2,
  input  [15:0] io_in_7,
  output [15:0] io_out_0
);
  wire [2:0] alu_io_config; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_0; // @[PE.scala 91:19]
  wire [15:0] alu_io_in_1; // @[PE.scala 91:19]
  wire [15:0] alu_io_out; // @[PE.scala 91:19]
  wire  dmr_clock; // @[PE.scala 93:19]
  wire  dmr_reset; // @[PE.scala 93:19]
  wire  dmr_io_start; // @[PE.scala 93:19]
  wire [2:0] dmr_io_mode; // @[PE.scala 93:19]
  wire [58:0] dmr_io_config; // @[PE.scala 93:19]
  wire [15:0] dmr_io_in_0; // @[PE.scala 93:19]
  wire  dmr_io_en; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_0; // @[PE.scala 93:19]
  wire [15:0] dmr_io_out_1; // @[PE.scala 93:19]
  wire  delay_pipe_clock; // @[PE.scala 94:26]
  wire  delay_pipe_reset; // @[PE.scala 94:26]
  wire  delay_pipe_io_en; // @[PE.scala 94:26]
  wire [7:0] delay_pipe_io_config; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_in_1; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_0; // @[PE.scala 94:26]
  wire [15:0] delay_pipe_io_out_1; // @[PE.scala 94:26]
  wire [2:0] Muxn_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_io_out; // @[PE.scala 105:49]
  wire [2:0] Muxn_1_io_config; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_0; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_1; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_2; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_3; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_in_4; // @[PE.scala 105:49]
  wire [15:0] Muxn_1_io_out; // @[PE.scala 105:49]
  wire  cfg_clock; // @[PE.scala 281:19]
  wire  cfg_reset; // @[PE.scala 281:19]
  wire  cfg_io_cfg_en; // @[PE.scala 281:19]
  wire [1:0] cfg_io_cfg_addr; // @[PE.scala 281:19]
  wire [31:0] cfg_io_cfg_data; // @[PE.scala 281:19]
  wire [92:0] cfg_io_out_0; // @[PE.scala 281:19]
  wire [92:0] cfgOut = cfg_io_out_0; // @[PE.scala 293:20 297:10]
  wire [3:0] opc = cfgOut[19:16]; // @[PE.scala 305:18]
  wire [2:0] _GEN_4 = {{2'd0}, opc[3]}; // @[Operations.scala 552:98]
  wire  _T_4 = ~opc[3] | _GEN_4 == 3'h5; // @[Operations.scala 552:60]
  wire  _T_6 = _GEN_4 == 3'h7; // @[Operations.scala 574:52]
  wire  _T_9 = _GEN_4 == 3'h6; // @[Operations.scala 569:52]
  wire [15:0] _GEN_0 = _T_9 ? delay_pipe_io_out_0 : dmr_io_out_1; // @[PE.scala 242:37 243:20 246:20]
  wire [15:0] _GEN_1 = _T_9 ? delay_pipe_io_out_1 : delay_pipe_io_out_0; // @[PE.scala 242:37 244:20 247:20]
  ALU alu ( // @[PE.scala 91:19]
    .io_config(alu_io_config),
    .io_in_0(alu_io_in_0),
    .io_in_1(alu_io_in_1),
    .io_out(alu_io_out)
  );
  DualModeReg dmr ( // @[PE.scala 93:19]
    .clock(dmr_clock),
    .reset(dmr_reset),
    .io_start(dmr_io_start),
    .io_mode(dmr_io_mode),
    .io_config(dmr_io_config),
    .io_in_0(dmr_io_in_0),
    .io_en(dmr_io_en),
    .io_out_0(dmr_io_out_0),
    .io_out_1(dmr_io_out_1)
  );
  SharedDelayPipe delay_pipe ( // @[PE.scala 94:26]
    .clock(delay_pipe_clock),
    .reset(delay_pipe_reset),
    .io_en(delay_pipe_io_en),
    .io_config(delay_pipe_io_config),
    .io_in_0(delay_pipe_io_in_0),
    .io_in_1(delay_pipe_io_in_1),
    .io_out_0(delay_pipe_io_out_0),
    .io_out_1(delay_pipe_io_out_1)
  );
  Muxn_20 Muxn ( // @[PE.scala 105:49]
    .io_config(Muxn_io_config),
    .io_in_0(Muxn_io_in_0),
    .io_in_1(Muxn_io_in_1),
    .io_in_2(Muxn_io_in_2),
    .io_in_3(Muxn_io_in_3),
    .io_in_4(Muxn_io_in_4),
    .io_out(Muxn_io_out)
  );
  Muxn_20 Muxn_1 ( // @[PE.scala 105:49]
    .io_config(Muxn_1_io_config),
    .io_in_0(Muxn_1_io_in_0),
    .io_in_1(Muxn_1_io_in_1),
    .io_in_2(Muxn_1_io_in_2),
    .io_in_3(Muxn_1_io_in_3),
    .io_in_4(Muxn_1_io_in_4),
    .io_out(Muxn_1_io_out)
  );
  ConfigMem_10 cfg ( // @[PE.scala 281:19]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_addr(cfg_io_cfg_addr),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  assign io_out_0 = dmr_io_out_0; // @[PE.scala 161:13]
  assign alu_io_config = cfgOut[18:16]; // @[PE.scala 304:28]
  assign alu_io_in_0 = _T_4 | _T_6 ? delay_pipe_io_out_0 : _GEN_0; // @[PE.scala 239:65 240:20]
  assign alu_io_in_1 = _T_4 | _T_6 ? delay_pipe_io_out_1 : _GEN_1; // @[PE.scala 239:65 241:20]
  assign dmr_clock = clock;
  assign dmr_reset = reset;
  assign dmr_io_start = io_start; // @[PE.scala 181:18]
  assign dmr_io_mode = {{2'd0}, opc[3]}; // @[PE.scala 182:17]
  assign dmr_io_config = cfgOut[92:34]; // @[PE.scala 365:28]
  assign dmr_io_in_0 = alu_io_out; // @[PE.scala 159:16]
  assign dmr_io_en = io_en; // @[PE.scala 158:13]
  assign delay_pipe_clock = clock;
  assign delay_pipe_reset = reset;
  assign delay_pipe_io_en = io_en; // @[PE.scala 156:20]
  assign delay_pipe_io_config = cfgOut[27:20]; // @[PE.scala 330:35]
  assign delay_pipe_io_in_0 = Muxn_io_out; // @[PE.scala 209:25]
  assign delay_pipe_io_in_1 = Muxn_1_io_out; // @[PE.scala 209:25]
  assign Muxn_io_config = cfgOut[30:28]; // @[PE.scala 350:32]
  assign Muxn_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_io_in_1 = io_in_0; // @[PE.scala 201:12]
  assign Muxn_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_io_in_3 = io_in_2; // @[PE.scala 201:12]
  assign Muxn_io_in_4 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_config = cfgOut[33:31]; // @[PE.scala 350:32]
  assign Muxn_1_io_in_0 = cfgOut[15:0]; // @[PE.scala 301:18]
  assign Muxn_1_io_in_1 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_2 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_3 = 16'h0; // @[PE.scala 201:12]
  assign Muxn_1_io_in_4 = io_in_7; // @[PE.scala 201:12]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h37 == io_cfg_addr[11:3]; // @[PE.scala 282:30]
  assign cfg_io_cfg_addr = io_cfg_addr[1:0]; // @[PE.scala 283:19]
  assign cfg_io_cfg_data = io_cfg_data; // @[PE.scala 284:19]
endmodule
module GIB(
  input  [15:0] io_opinNE_0,
  output [15:0] io_ipinSE_1,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  assign io_ipinSE_1 = io_opinNE_0; // @[Interconnect.scala 520:41]
  assign io_otrackE_0 = io_itrackS_0; // @[Interconnect.scala 520:41]
  assign io_otrackS_0 = io_itrackE_0; // @[Interconnect.scala 520:41]
endmodule
module ConfigMem_35(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [31:0] io_cfg_data,
  output [3:0]  io_out_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] regs_0; // @[ConfigMem.scala 27:21]
  assign io_out_0 = regs_0; // @[ConfigMem.scala 52:45]
  always @(posedge clock) begin
    if (reset) begin // @[ConfigMem.scala 27:21]
      regs_0 <= 4'h0; // @[ConfigMem.scala 27:21]
    end else if (io_cfg_en) begin // @[ConfigMem.scala 32:54]
      regs_0 <= io_cfg_data[3:0]; // @[ConfigMem.scala 33:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regs_0 = _RAND_0[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_1(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  input  [15:0] io_opinNE_0,
  output [15:0] io_ipinSE_0,
  output [15:0] io_ipinSE_1,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [3:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire  mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_35 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  Muxn mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_1 = io_opinNE_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h7 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_opinNE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_opinSE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[3]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_3_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_2(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  input  [15:0] io_opinNE_0,
  output [15:0] io_ipinSE_0,
  output [15:0] io_ipinSE_1,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [3:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire  mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_35 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  Muxn mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_1 = io_opinNE_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackW_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_3_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h8 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_opinNE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_opinSE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[3]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_3(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  input  [15:0] io_opinNE_0,
  output [15:0] io_ipinSE_0,
  output [15:0] io_ipinSE_1,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [3:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire  mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_35 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  Muxn mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_1 = io_opinNE_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h9 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_opinNE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_opinSE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[3]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_3_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_4(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  input  [15:0] io_opinNE_0,
  output [15:0] io_ipinSE_0,
  output [15:0] io_ipinSE_1,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [3:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire  mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_35 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  Muxn mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_1 = io_opinNE_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackW_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_3_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'ha == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_opinNE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_opinSE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[3]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
endmodule
module ConfigMem_39(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [31:0] io_cfg_data,
  output [2:0]  io_out_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] regs_0; // @[ConfigMem.scala 27:21]
  assign io_out_0 = regs_0; // @[ConfigMem.scala 52:45]
  always @(posedge clock) begin
    if (reset) begin // @[ConfigMem.scala 27:21]
      regs_0 <= 3'h0; // @[ConfigMem.scala 27:21]
    end else if (io_cfg_en) begin // @[ConfigMem.scala 32:54]
      regs_0 <= io_cfg_data[2:0]; // @[ConfigMem.scala 33:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regs_0 = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_5(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [2:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_39 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h10 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackN_0_REG <= mux_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ConfigMem_40(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [31:0] io_cfg_data,
  output [7:0]  io_out_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] regs_0; // @[ConfigMem.scala 27:21]
  assign io_out_0 = regs_0; // @[ConfigMem.scala 52:45]
  always @(posedge clock) begin
    if (reset) begin // @[ConfigMem.scala 27:21]
      regs_0 <= 8'h0; // @[ConfigMem.scala 27:21]
    end else if (io_cfg_en) begin // @[ConfigMem.scala 32:54]
      regs_0 <= io_cfg_data[7:0]; // @[ConfigMem.scala 33:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regs_0 = _RAND_0[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Muxn_89(
  input  [1:0]  io_config,
  input  [15:0] io_in_0,
  input  [15:0] io_in_1,
  input  [15:0] io_in_2,
  output [15:0] io_out
);
  wire [15:0] _io_out_T_3 = 2'h1 == io_config ? io_in_1 : io_in_0; // @[Mux.scala 81:58]
  assign io_out = 2'h2 == io_config ? io_in_2 : _io_out_T_3; // @[Mux.scala 81:58]
endmodule
module GIB_6(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackN_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_3_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h11 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_7(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h12 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_io_out; // @[Interconnect.scala 504:55]
    io_otrackN_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_3_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_3[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_8(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackN_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_3_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h13 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_9(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h14 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_io_out; // @[Interconnect.scala 504:55]
    io_otrackN_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_3_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_3[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_10(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [2:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_39 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  assign io_otrackN_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h1a == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_11(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h1b == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_io_out; // @[Interconnect.scala 504:55]
    io_otrackN_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_3_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_3[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_12(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackN_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_3_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h1c == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_13(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h1d == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_io_out; // @[Interconnect.scala 504:55]
    io_otrackN_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_3_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_3[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_14(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackN_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_3_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h1e == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_15(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [2:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_39 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h24 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackN_0_REG <= mux_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_16(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackN_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_3_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h25 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_17(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h26 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_io_out; // @[Interconnect.scala 504:55]
    io_otrackN_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_3_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_3[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_18(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackN_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_3_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h27 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_19(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h28 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_io_out; // @[Interconnect.scala 504:55]
    io_otrackN_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_3_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_3[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_20(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [2:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_39 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  assign io_otrackN_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h2e == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_21(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h2f == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_io_out; // @[Interconnect.scala 504:55]
    io_otrackN_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_3_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_3[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_22(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackN_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_3_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h30 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_23(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h31 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_io_out; // @[Interconnect.scala 504:55]
    io_otrackN_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_3_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_3[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_24(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [7:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire [1:0] mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire [1:0] mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_2; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_40 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn_89 mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_in_2(mux_io_in_2),
    .io_out(mux_io_out)
  );
  Muxn_89 mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_in_2(mux_1_io_in_2),
    .io_out(mux_1_io_out)
  );
  Muxn_89 mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_in_2(mux_2_io_in_2),
    .io_out(mux_2_io_out)
  );
  Muxn_89 mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_in_2(mux_3_io_in_2),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackN_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_3_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h32 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[1:0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[3:2]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[5:4]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_2 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[7:6]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_2 = io_itrackE_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_25(
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0
);
  assign io_otrackN_0 = io_itrackE_0; // @[Interconnect.scala 520:41]
  assign io_otrackE_0 = io_itrackN_0; // @[Interconnect.scala 520:41]
endmodule
module GIB_26(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  output [15:0] io_ipinNW_1,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_opinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [3:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire  mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_35 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  Muxn mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNW_1 = io_opinSW_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackN_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_3_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h39 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_opinNW_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_opinSW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[3]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_27(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  output [15:0] io_ipinNW_1,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_opinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [3:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire  mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_35 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  Muxn mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNW_1 = io_opinSW_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h3a == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_opinNW_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_opinSW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[3]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackN_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_3_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_28(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  output [15:0] io_ipinNW_1,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_opinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [3:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire  mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_35 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  Muxn mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNW_1 = io_opinSW_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackN_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackE_0 = mux_3_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h3b == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_opinNW_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_opinSW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[3]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_29(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  output [15:0] io_ipinNW_0,
  output [15:0] io_ipinNW_1,
  input  [15:0] io_opinNW_0,
  output [15:0] io_ipinNE_0,
  output [15:0] io_ipinSE_0,
  input  [15:0] io_opinSE_0,
  output [15:0] io_ipinSW_0,
  input  [15:0] io_opinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackE_0,
  output [15:0] io_otrackE_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [3:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  wire  mux_3_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_3_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackE_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_35 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  Muxn mux_3 ( // @[Interconnect.scala 500:25]
    .io_config(mux_3_io_config),
    .io_in_0(mux_3_io_in_0),
    .io_in_1(mux_3_io_in_1),
    .io_out(mux_3_io_out)
  );
  assign io_ipinNW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_ipinNW_1 = io_opinSW_0; // @[Interconnect.scala 514:43]
  assign io_ipinNE_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_ipinSE_0 = io_opinNW_0; // @[Interconnect.scala 514:43]
  assign io_ipinSW_0 = io_opinSE_0; // @[Interconnect.scala 514:43]
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackE_0 = io_otrackE_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h3c == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_opinNW_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_opinSW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackE_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_config = cfg_io_out_0[3]; // @[Interconnect.scala 510:39]
  assign mux_3_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_3_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackN_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
    io_otrackE_0_REG <= mux_3_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackE_0_REG = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_30(
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  assign io_otrackW_0 = io_itrackS_0; // @[Interconnect.scala 520:41]
  assign io_otrackS_0 = io_itrackW_0; // @[Interconnect.scala 520:41]
endmodule
module GIB_31(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [2:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_39 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  assign io_otrackW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackN_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h43 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_32(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [2:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_39 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h44 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_io_out; // @[Interconnect.scala 504:55]
    io_otrackN_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_33(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [2:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  ConfigMem_39 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  assign io_otrackW_0 = mux_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackN_0 = mux_1_io_out; // @[Interconnect.scala 506:45]
  assign io_otrackS_0 = mux_2_io_out; // @[Interconnect.scala 506:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h45 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
endmodule
module GIB_34(
  input         clock,
  input         reset,
  input         io_cfg_en,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0,
  input  [15:0] io_itrackS_0,
  output [15:0] io_otrackS_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  cfg_clock; // @[Interconnect.scala 490:21]
  wire  cfg_reset; // @[Interconnect.scala 490:21]
  wire  cfg_io_cfg_en; // @[Interconnect.scala 490:21]
  wire [31:0] cfg_io_cfg_data; // @[Interconnect.scala 490:21]
  wire [2:0] cfg_io_out_0; // @[Interconnect.scala 490:21]
  wire  mux_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_io_out; // @[Interconnect.scala 500:25]
  wire  mux_1_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_1_io_out; // @[Interconnect.scala 500:25]
  wire  mux_2_io_config; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_0; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_in_1; // @[Interconnect.scala 500:25]
  wire [15:0] mux_2_io_out; // @[Interconnect.scala 500:25]
  reg [15:0] io_otrackW_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackN_0_REG; // @[Interconnect.scala 504:55]
  reg [15:0] io_otrackS_0_REG; // @[Interconnect.scala 504:55]
  ConfigMem_39 cfg ( // @[Interconnect.scala 490:21]
    .clock(cfg_clock),
    .reset(cfg_reset),
    .io_cfg_en(cfg_io_cfg_en),
    .io_cfg_data(cfg_io_cfg_data),
    .io_out_0(cfg_io_out_0)
  );
  Muxn mux ( // @[Interconnect.scala 500:25]
    .io_config(mux_io_config),
    .io_in_0(mux_io_in_0),
    .io_in_1(mux_io_in_1),
    .io_out(mux_io_out)
  );
  Muxn mux_1 ( // @[Interconnect.scala 500:25]
    .io_config(mux_1_io_config),
    .io_in_0(mux_1_io_in_0),
    .io_in_1(mux_1_io_in_1),
    .io_out(mux_1_io_out)
  );
  Muxn mux_2 ( // @[Interconnect.scala 500:25]
    .io_config(mux_2_io_config),
    .io_in_0(mux_2_io_in_0),
    .io_in_1(mux_2_io_in_1),
    .io_out(mux_2_io_out)
  );
  assign io_otrackW_0 = io_otrackW_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackN_0 = io_otrackN_0_REG; // @[Interconnect.scala 504:45]
  assign io_otrackS_0 = io_otrackS_0_REG; // @[Interconnect.scala 504:45]
  assign cfg_clock = clock;
  assign cfg_reset = reset;
  assign cfg_io_cfg_en = io_cfg_en & 9'h46 == io_cfg_addr[11:3]; // @[Interconnect.scala 491:32]
  assign cfg_io_cfg_data = io_cfg_data; // @[Interconnect.scala 493:21]
  assign mux_io_config = cfg_io_out_0[0]; // @[Interconnect.scala 510:39]
  assign mux_io_in_0 = io_itrackN_0; // @[Interconnect.scala 502:63]
  assign mux_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_config = cfg_io_out_0[1]; // @[Interconnect.scala 510:39]
  assign mux_1_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_1_io_in_1 = io_itrackS_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_config = cfg_io_out_0[2]; // @[Interconnect.scala 510:39]
  assign mux_2_io_in_0 = io_itrackW_0; // @[Interconnect.scala 502:63]
  assign mux_2_io_in_1 = io_itrackN_0; // @[Interconnect.scala 502:63]
  always @(posedge clock) begin
    io_otrackW_0_REG <= mux_io_out; // @[Interconnect.scala 504:55]
    io_otrackN_0_REG <= mux_1_io_out; // @[Interconnect.scala 504:55]
    io_otrackS_0_REG <= mux_2_io_out; // @[Interconnect.scala 504:55]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_otrackW_0_REG = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_otrackN_0_REG = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_otrackS_0_REG = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module GIB_35(
  output [15:0] io_ipinNW_1,
  input  [15:0] io_opinSW_0,
  input  [15:0] io_itrackW_0,
  output [15:0] io_otrackW_0,
  input  [15:0] io_itrackN_0,
  output [15:0] io_otrackN_0
);
  assign io_ipinNW_1 = io_opinSW_0; // @[Interconnect.scala 520:41]
  assign io_otrackW_0 = io_itrackN_0; // @[Interconnect.scala 520:41]
  assign io_otrackN_0 = io_itrackW_0; // @[Interconnect.scala 520:41]
endmodule
module CGRA(
  input         clock,
  input         reset,
  input         io_cfg_en_0,
  input  [11:0] io_cfg_addr,
  input  [31:0] io_cfg_data,
  input  [9:0]  io_iob_ens_0,
  input         io_en_0,
  input         io_start_0,
  output        io_done_0,
  output        io_srams_0_0_en,
  output [1:0]  io_srams_0_0_we,
  output [14:0] io_srams_0_0_addr,
  output [15:0] io_srams_0_0_din,
  input  [15:0] io_srams_0_0_dout,
  output        io_srams_0_1_en,
  output [1:0]  io_srams_0_1_we,
  output [14:0] io_srams_0_1_addr,
  output [15:0] io_srams_0_1_din,
  input  [15:0] io_srams_0_1_dout,
  output        io_srams_0_2_en,
  output [1:0]  io_srams_0_2_we,
  output [14:0] io_srams_0_2_addr,
  output [15:0] io_srams_0_2_din,
  input  [15:0] io_srams_0_2_dout,
  output        io_srams_0_3_en,
  output [1:0]  io_srams_0_3_we,
  output [14:0] io_srams_0_3_addr,
  output [15:0] io_srams_0_3_din,
  input  [15:0] io_srams_0_3_dout,
  output        io_srams_0_4_en,
  output [1:0]  io_srams_0_4_we,
  output [14:0] io_srams_0_4_addr,
  output [15:0] io_srams_0_4_din,
  input  [15:0] io_srams_0_4_dout,
  output        io_srams_0_5_en,
  output [1:0]  io_srams_0_5_we,
  output [14:0] io_srams_0_5_addr,
  output [15:0] io_srams_0_5_din,
  input  [15:0] io_srams_0_5_dout,
  output        io_srams_0_6_en,
  output [1:0]  io_srams_0_6_we,
  output [14:0] io_srams_0_6_addr,
  output [15:0] io_srams_0_6_din,
  input  [15:0] io_srams_0_6_dout,
  output        io_srams_0_7_en,
  output [1:0]  io_srams_0_7_we,
  output [14:0] io_srams_0_7_addr,
  output [15:0] io_srams_0_7_din,
  input  [15:0] io_srams_0_7_dout,
  output        io_srams_0_8_en,
  output [1:0]  io_srams_0_8_we,
  output [14:0] io_srams_0_8_addr,
  output [15:0] io_srams_0_8_din,
  input  [15:0] io_srams_0_8_dout,
  output        io_srams_0_9_en,
  output [1:0]  io_srams_0_9_we,
  output [14:0] io_srams_0_9_addr,
  output [15:0] io_srams_0_9_din,
  input  [15:0] io_srams_0_9_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  iobs_0_clock; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_0_reset; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_0_io_cfg_en; // @[MultiTileCGRA.scala 231:25]
  wire [11:0] iobs_0_io_cfg_addr; // @[MultiTileCGRA.scala 231:25]
  wire [31:0] iobs_0_io_cfg_data; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_0_io_start; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_0_io_done; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_0_io_en; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_0_io_in_1; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_0_io_out_0; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_0_io_sram_en; // @[MultiTileCGRA.scala 231:25]
  wire [1:0] iobs_0_io_sram_we; // @[MultiTileCGRA.scala 231:25]
  wire [14:0] iobs_0_io_sram_addr; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_0_io_sram_din; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_0_io_sram_dout; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_1_clock; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_1_reset; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_1_io_cfg_en; // @[MultiTileCGRA.scala 231:25]
  wire [11:0] iobs_1_io_cfg_addr; // @[MultiTileCGRA.scala 231:25]
  wire [31:0] iobs_1_io_cfg_data; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_1_io_start; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_1_io_done; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_1_io_en; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_1_io_in_0; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_1_io_in_1; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_1_io_out_0; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_1_io_sram_en; // @[MultiTileCGRA.scala 231:25]
  wire [1:0] iobs_1_io_sram_we; // @[MultiTileCGRA.scala 231:25]
  wire [14:0] iobs_1_io_sram_addr; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_1_io_sram_din; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_1_io_sram_dout; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_2_clock; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_2_reset; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_2_io_cfg_en; // @[MultiTileCGRA.scala 231:25]
  wire [11:0] iobs_2_io_cfg_addr; // @[MultiTileCGRA.scala 231:25]
  wire [31:0] iobs_2_io_cfg_data; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_2_io_start; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_2_io_done; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_2_io_en; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_2_io_in_0; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_2_io_in_1; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_2_io_out_0; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_2_io_sram_en; // @[MultiTileCGRA.scala 231:25]
  wire [1:0] iobs_2_io_sram_we; // @[MultiTileCGRA.scala 231:25]
  wire [14:0] iobs_2_io_sram_addr; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_2_io_sram_din; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_2_io_sram_dout; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_3_clock; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_3_reset; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_3_io_cfg_en; // @[MultiTileCGRA.scala 231:25]
  wire [11:0] iobs_3_io_cfg_addr; // @[MultiTileCGRA.scala 231:25]
  wire [31:0] iobs_3_io_cfg_data; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_3_io_start; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_3_io_done; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_3_io_en; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_3_io_in_0; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_3_io_in_1; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_3_io_out_0; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_3_io_sram_en; // @[MultiTileCGRA.scala 231:25]
  wire [1:0] iobs_3_io_sram_we; // @[MultiTileCGRA.scala 231:25]
  wire [14:0] iobs_3_io_sram_addr; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_3_io_sram_din; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_3_io_sram_dout; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_4_clock; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_4_reset; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_4_io_cfg_en; // @[MultiTileCGRA.scala 231:25]
  wire [11:0] iobs_4_io_cfg_addr; // @[MultiTileCGRA.scala 231:25]
  wire [31:0] iobs_4_io_cfg_data; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_4_io_start; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_4_io_done; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_4_io_en; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_4_io_in_0; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_4_io_out_0; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_4_io_sram_en; // @[MultiTileCGRA.scala 231:25]
  wire [1:0] iobs_4_io_sram_we; // @[MultiTileCGRA.scala 231:25]
  wire [14:0] iobs_4_io_sram_addr; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_4_io_sram_din; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_4_io_sram_dout; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_5_clock; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_5_reset; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_5_io_cfg_en; // @[MultiTileCGRA.scala 231:25]
  wire [11:0] iobs_5_io_cfg_addr; // @[MultiTileCGRA.scala 231:25]
  wire [31:0] iobs_5_io_cfg_data; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_5_io_start; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_5_io_done; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_5_io_en; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_5_io_in_1; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_5_io_out_0; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_5_io_sram_en; // @[MultiTileCGRA.scala 231:25]
  wire [1:0] iobs_5_io_sram_we; // @[MultiTileCGRA.scala 231:25]
  wire [14:0] iobs_5_io_sram_addr; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_5_io_sram_din; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_5_io_sram_dout; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_6_clock; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_6_reset; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_6_io_cfg_en; // @[MultiTileCGRA.scala 231:25]
  wire [11:0] iobs_6_io_cfg_addr; // @[MultiTileCGRA.scala 231:25]
  wire [31:0] iobs_6_io_cfg_data; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_6_io_start; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_6_io_done; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_6_io_en; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_6_io_in_0; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_6_io_in_1; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_6_io_out_0; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_6_io_sram_en; // @[MultiTileCGRA.scala 231:25]
  wire [1:0] iobs_6_io_sram_we; // @[MultiTileCGRA.scala 231:25]
  wire [14:0] iobs_6_io_sram_addr; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_6_io_sram_din; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_6_io_sram_dout; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_7_clock; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_7_reset; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_7_io_cfg_en; // @[MultiTileCGRA.scala 231:25]
  wire [11:0] iobs_7_io_cfg_addr; // @[MultiTileCGRA.scala 231:25]
  wire [31:0] iobs_7_io_cfg_data; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_7_io_start; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_7_io_done; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_7_io_en; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_7_io_in_0; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_7_io_in_1; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_7_io_out_0; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_7_io_sram_en; // @[MultiTileCGRA.scala 231:25]
  wire [1:0] iobs_7_io_sram_we; // @[MultiTileCGRA.scala 231:25]
  wire [14:0] iobs_7_io_sram_addr; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_7_io_sram_din; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_7_io_sram_dout; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_8_clock; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_8_reset; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_8_io_cfg_en; // @[MultiTileCGRA.scala 231:25]
  wire [11:0] iobs_8_io_cfg_addr; // @[MultiTileCGRA.scala 231:25]
  wire [31:0] iobs_8_io_cfg_data; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_8_io_start; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_8_io_done; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_8_io_en; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_8_io_in_0; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_8_io_in_1; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_8_io_out_0; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_8_io_sram_en; // @[MultiTileCGRA.scala 231:25]
  wire [1:0] iobs_8_io_sram_we; // @[MultiTileCGRA.scala 231:25]
  wire [14:0] iobs_8_io_sram_addr; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_8_io_sram_din; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_8_io_sram_dout; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_9_clock; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_9_reset; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_9_io_cfg_en; // @[MultiTileCGRA.scala 231:25]
  wire [11:0] iobs_9_io_cfg_addr; // @[MultiTileCGRA.scala 231:25]
  wire [31:0] iobs_9_io_cfg_data; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_9_io_start; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_9_io_done; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_9_io_en; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_9_io_in_0; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_9_io_out_0; // @[MultiTileCGRA.scala 231:25]
  wire  iobs_9_io_sram_en; // @[MultiTileCGRA.scala 231:25]
  wire [1:0] iobs_9_io_sram_we; // @[MultiTileCGRA.scala 231:25]
  wire [14:0] iobs_9_io_sram_addr; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_9_io_sram_din; // @[MultiTileCGRA.scala 231:25]
  wire [15:0] iobs_9_io_sram_dout; // @[MultiTileCGRA.scala 231:25]
  wire  pes_0_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_0_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_0_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_0_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_0_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_0_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_0_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_0_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_0_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_0_io_in_4; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_0_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_1_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_1_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_1_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_1_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_1_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_1_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_1_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_1_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_1_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_1_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_1_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_1_io_in_4; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_1_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_2_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_2_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_2_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_2_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_2_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_2_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_2_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_2_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_2_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_2_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_2_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_2_io_in_4; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_2_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_3_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_3_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_3_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_3_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_3_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_3_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_3_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_3_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_3_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_3_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_3_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_3_io_in_4; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_3_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_4_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_4_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_4_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_4_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_4_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_4_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_4_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_4_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_4_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_4_io_in_4; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_4_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_5_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_5_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_5_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_5_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_5_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_5_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_5_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_5_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_5_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_5_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_6_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_6_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_6_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_6_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_6_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_6_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_6_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_6_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_6_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_6_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_6_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_6_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_7_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_7_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_7_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_7_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_7_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_7_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_7_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_7_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_7_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_7_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_7_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_7_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_8_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_8_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_8_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_8_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_8_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_8_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_8_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_8_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_8_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_8_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_8_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_8_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_9_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_9_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_9_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_9_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_9_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_9_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_9_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_9_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_9_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_9_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_10_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_10_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_10_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_10_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_10_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_10_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_10_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_10_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_10_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_10_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_11_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_11_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_11_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_11_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_11_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_11_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_11_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_11_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_11_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_11_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_11_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_11_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_12_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_12_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_12_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_12_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_12_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_12_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_12_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_12_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_12_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_12_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_12_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_12_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_13_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_13_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_13_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_13_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_13_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_13_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_13_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_13_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_13_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_13_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_13_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_13_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_14_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_14_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_14_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_14_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_14_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_14_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_14_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_14_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_14_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_14_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_15_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_15_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_15_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_15_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_15_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_15_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_15_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_15_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_15_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_15_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_16_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_16_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_16_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_16_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_16_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_16_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_16_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_16_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_16_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_16_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_16_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_16_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_17_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_17_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_17_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_17_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_17_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_17_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_17_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_17_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_17_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_17_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_17_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_17_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_18_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_18_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_18_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_18_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_18_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_18_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_18_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_18_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_18_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_18_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_18_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_18_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_19_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_19_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_19_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_19_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_19_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_19_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_19_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_19_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_19_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_19_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_20_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_20_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_20_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_20_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_20_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_20_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_20_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_20_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_20_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_20_io_in_7; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_20_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_21_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_21_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_21_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_21_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_21_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_21_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_21_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_21_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_21_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_21_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_21_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_21_io_in_7; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_21_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_22_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_22_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_22_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_22_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_22_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_22_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_22_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_22_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_22_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_22_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_22_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_22_io_in_7; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_22_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_23_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_23_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_23_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_23_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_23_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_23_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_23_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_23_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_23_io_in_1; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_23_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_23_io_in_3; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_23_io_in_7; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_23_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire  pes_24_clock; // @[MultiTileCGRA.scala 306:22]
  wire  pes_24_reset; // @[MultiTileCGRA.scala 306:22]
  wire  pes_24_io_cfg_en; // @[MultiTileCGRA.scala 306:22]
  wire [11:0] pes_24_io_cfg_addr; // @[MultiTileCGRA.scala 306:22]
  wire [31:0] pes_24_io_cfg_data; // @[MultiTileCGRA.scala 306:22]
  wire  pes_24_io_start; // @[MultiTileCGRA.scala 306:22]
  wire  pes_24_io_en; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_24_io_in_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_24_io_in_2; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_24_io_in_7; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] pes_24_io_out_0; // @[MultiTileCGRA.scala 306:22]
  wire [15:0] gibs_0_io_opinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_0_io_ipinSE_1; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_0_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_0_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_0_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_0_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_1_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_1_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_1_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_1_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_1_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_opinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_ipinSE_1; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_1_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_2_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_2_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_2_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_2_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_2_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_opinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_ipinSE_1; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_2_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_3_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_3_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_3_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_3_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_3_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_opinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_ipinSE_1; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_3_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_4_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_4_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_4_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_4_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_4_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_opinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_ipinSE_1; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_4_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_5_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_5_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_5_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_5_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_5_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_5_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_5_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_5_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_5_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_5_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_5_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_6_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_6_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_6_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_6_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_6_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_6_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_7_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_7_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_7_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_7_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_7_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_7_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_8_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_8_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_8_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_8_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_8_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_8_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_9_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_9_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_9_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_9_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_9_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_9_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_10_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_10_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_10_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_10_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_10_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_10_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_10_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_10_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_10_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_10_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_10_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_11_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_11_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_11_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_11_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_11_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_11_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_12_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_12_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_12_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_12_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_12_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_12_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_13_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_13_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_13_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_13_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_13_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_13_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_14_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_14_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_14_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_14_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_14_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_14_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_15_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_15_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_15_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_15_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_15_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_15_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_15_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_15_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_15_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_15_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_15_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_16_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_16_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_16_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_16_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_16_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_16_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_17_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_17_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_17_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_17_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_17_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_17_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_18_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_18_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_18_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_18_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_18_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_18_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_19_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_19_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_19_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_19_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_19_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_19_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_20_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_20_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_20_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_20_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_20_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_20_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_20_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_20_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_20_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_20_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_20_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_21_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_21_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_21_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_21_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_21_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_21_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_22_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_22_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_22_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_22_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_22_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_22_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_23_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_23_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_23_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_23_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_23_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_23_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_24_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_24_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_24_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_24_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_24_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_itrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_24_io_otrackS_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_25_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_25_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_25_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_25_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_26_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_26_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_26_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_26_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_26_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_ipinNW_1; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_opinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_26_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_27_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_27_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_27_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_27_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_27_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_ipinNW_1; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_opinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_27_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_28_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_28_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_28_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_28_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_28_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_ipinNW_1; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_opinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_28_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_29_clock; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_29_reset; // @[MultiTileCGRA.scala 394:23]
  wire  gibs_29_io_cfg_en; // @[MultiTileCGRA.scala 394:23]
  wire [11:0] gibs_29_io_cfg_addr; // @[MultiTileCGRA.scala 394:23]
  wire [31:0] gibs_29_io_cfg_data; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_ipinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_ipinNW_1; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_opinNW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_ipinNE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_ipinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_opinSE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_ipinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_opinSW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_itrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_otrackW_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_itrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_otrackN_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_itrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_29_io_otrackE_0; // @[MultiTileCGRA.scala 394:23]
  wire [15:0] gibs_30_io_itrackW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_30_io_otrackW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_30_io_itrackS_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_30_io_otrackS_0; // @[MultiTileCGRA.scala 836:23]
  wire  gibs_31_clock; // @[MultiTileCGRA.scala 836:23]
  wire  gibs_31_reset; // @[MultiTileCGRA.scala 836:23]
  wire  gibs_31_io_cfg_en; // @[MultiTileCGRA.scala 836:23]
  wire [11:0] gibs_31_io_cfg_addr; // @[MultiTileCGRA.scala 836:23]
  wire [31:0] gibs_31_io_cfg_data; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_31_io_itrackW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_31_io_otrackW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_31_io_itrackN_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_31_io_otrackN_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_31_io_itrackS_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_31_io_otrackS_0; // @[MultiTileCGRA.scala 836:23]
  wire  gibs_32_clock; // @[MultiTileCGRA.scala 836:23]
  wire  gibs_32_reset; // @[MultiTileCGRA.scala 836:23]
  wire  gibs_32_io_cfg_en; // @[MultiTileCGRA.scala 836:23]
  wire [11:0] gibs_32_io_cfg_addr; // @[MultiTileCGRA.scala 836:23]
  wire [31:0] gibs_32_io_cfg_data; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_32_io_itrackW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_32_io_otrackW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_32_io_itrackN_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_32_io_otrackN_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_32_io_itrackS_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_32_io_otrackS_0; // @[MultiTileCGRA.scala 836:23]
  wire  gibs_33_clock; // @[MultiTileCGRA.scala 836:23]
  wire  gibs_33_reset; // @[MultiTileCGRA.scala 836:23]
  wire  gibs_33_io_cfg_en; // @[MultiTileCGRA.scala 836:23]
  wire [11:0] gibs_33_io_cfg_addr; // @[MultiTileCGRA.scala 836:23]
  wire [31:0] gibs_33_io_cfg_data; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_33_io_itrackW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_33_io_otrackW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_33_io_itrackN_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_33_io_otrackN_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_33_io_itrackS_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_33_io_otrackS_0; // @[MultiTileCGRA.scala 836:23]
  wire  gibs_34_clock; // @[MultiTileCGRA.scala 836:23]
  wire  gibs_34_reset; // @[MultiTileCGRA.scala 836:23]
  wire  gibs_34_io_cfg_en; // @[MultiTileCGRA.scala 836:23]
  wire [11:0] gibs_34_io_cfg_addr; // @[MultiTileCGRA.scala 836:23]
  wire [31:0] gibs_34_io_cfg_data; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_34_io_itrackW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_34_io_otrackW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_34_io_itrackN_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_34_io_otrackN_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_34_io_itrackS_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_34_io_otrackS_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_35_io_ipinNW_1; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_35_io_opinSW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_35_io_itrackW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_35_io_otrackW_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_35_io_itrackN_0; // @[MultiTileCGRA.scala 836:23]
  wire [15:0] gibs_35_io_otrackN_0; // @[MultiTileCGRA.scala 836:23]
  reg  io_done_0_REG; // @[MultiTileCGRA.scala 529:29]
  IOB iobs_0 ( // @[MultiTileCGRA.scala 231:25]
    .clock(iobs_0_clock),
    .reset(iobs_0_reset),
    .io_cfg_en(iobs_0_io_cfg_en),
    .io_cfg_addr(iobs_0_io_cfg_addr),
    .io_cfg_data(iobs_0_io_cfg_data),
    .io_start(iobs_0_io_start),
    .io_done(iobs_0_io_done),
    .io_en(iobs_0_io_en),
    .io_in_1(iobs_0_io_in_1),
    .io_out_0(iobs_0_io_out_0),
    .io_sram_en(iobs_0_io_sram_en),
    .io_sram_we(iobs_0_io_sram_we),
    .io_sram_addr(iobs_0_io_sram_addr),
    .io_sram_din(iobs_0_io_sram_din),
    .io_sram_dout(iobs_0_io_sram_dout)
  );
  IOB_1 iobs_1 ( // @[MultiTileCGRA.scala 231:25]
    .clock(iobs_1_clock),
    .reset(iobs_1_reset),
    .io_cfg_en(iobs_1_io_cfg_en),
    .io_cfg_addr(iobs_1_io_cfg_addr),
    .io_cfg_data(iobs_1_io_cfg_data),
    .io_start(iobs_1_io_start),
    .io_done(iobs_1_io_done),
    .io_en(iobs_1_io_en),
    .io_in_0(iobs_1_io_in_0),
    .io_in_1(iobs_1_io_in_1),
    .io_out_0(iobs_1_io_out_0),
    .io_sram_en(iobs_1_io_sram_en),
    .io_sram_we(iobs_1_io_sram_we),
    .io_sram_addr(iobs_1_io_sram_addr),
    .io_sram_din(iobs_1_io_sram_din),
    .io_sram_dout(iobs_1_io_sram_dout)
  );
  IOB_2 iobs_2 ( // @[MultiTileCGRA.scala 231:25]
    .clock(iobs_2_clock),
    .reset(iobs_2_reset),
    .io_cfg_en(iobs_2_io_cfg_en),
    .io_cfg_addr(iobs_2_io_cfg_addr),
    .io_cfg_data(iobs_2_io_cfg_data),
    .io_start(iobs_2_io_start),
    .io_done(iobs_2_io_done),
    .io_en(iobs_2_io_en),
    .io_in_0(iobs_2_io_in_0),
    .io_in_1(iobs_2_io_in_1),
    .io_out_0(iobs_2_io_out_0),
    .io_sram_en(iobs_2_io_sram_en),
    .io_sram_we(iobs_2_io_sram_we),
    .io_sram_addr(iobs_2_io_sram_addr),
    .io_sram_din(iobs_2_io_sram_din),
    .io_sram_dout(iobs_2_io_sram_dout)
  );
  IOB_3 iobs_3 ( // @[MultiTileCGRA.scala 231:25]
    .clock(iobs_3_clock),
    .reset(iobs_3_reset),
    .io_cfg_en(iobs_3_io_cfg_en),
    .io_cfg_addr(iobs_3_io_cfg_addr),
    .io_cfg_data(iobs_3_io_cfg_data),
    .io_start(iobs_3_io_start),
    .io_done(iobs_3_io_done),
    .io_en(iobs_3_io_en),
    .io_in_0(iobs_3_io_in_0),
    .io_in_1(iobs_3_io_in_1),
    .io_out_0(iobs_3_io_out_0),
    .io_sram_en(iobs_3_io_sram_en),
    .io_sram_we(iobs_3_io_sram_we),
    .io_sram_addr(iobs_3_io_sram_addr),
    .io_sram_din(iobs_3_io_sram_din),
    .io_sram_dout(iobs_3_io_sram_dout)
  );
  IOB_4 iobs_4 ( // @[MultiTileCGRA.scala 231:25]
    .clock(iobs_4_clock),
    .reset(iobs_4_reset),
    .io_cfg_en(iobs_4_io_cfg_en),
    .io_cfg_addr(iobs_4_io_cfg_addr),
    .io_cfg_data(iobs_4_io_cfg_data),
    .io_start(iobs_4_io_start),
    .io_done(iobs_4_io_done),
    .io_en(iobs_4_io_en),
    .io_in_0(iobs_4_io_in_0),
    .io_out_0(iobs_4_io_out_0),
    .io_sram_en(iobs_4_io_sram_en),
    .io_sram_we(iobs_4_io_sram_we),
    .io_sram_addr(iobs_4_io_sram_addr),
    .io_sram_din(iobs_4_io_sram_din),
    .io_sram_dout(iobs_4_io_sram_dout)
  );
  IOB_5 iobs_5 ( // @[MultiTileCGRA.scala 231:25]
    .clock(iobs_5_clock),
    .reset(iobs_5_reset),
    .io_cfg_en(iobs_5_io_cfg_en),
    .io_cfg_addr(iobs_5_io_cfg_addr),
    .io_cfg_data(iobs_5_io_cfg_data),
    .io_start(iobs_5_io_start),
    .io_done(iobs_5_io_done),
    .io_en(iobs_5_io_en),
    .io_in_1(iobs_5_io_in_1),
    .io_out_0(iobs_5_io_out_0),
    .io_sram_en(iobs_5_io_sram_en),
    .io_sram_we(iobs_5_io_sram_we),
    .io_sram_addr(iobs_5_io_sram_addr),
    .io_sram_din(iobs_5_io_sram_din),
    .io_sram_dout(iobs_5_io_sram_dout)
  );
  IOB_6 iobs_6 ( // @[MultiTileCGRA.scala 231:25]
    .clock(iobs_6_clock),
    .reset(iobs_6_reset),
    .io_cfg_en(iobs_6_io_cfg_en),
    .io_cfg_addr(iobs_6_io_cfg_addr),
    .io_cfg_data(iobs_6_io_cfg_data),
    .io_start(iobs_6_io_start),
    .io_done(iobs_6_io_done),
    .io_en(iobs_6_io_en),
    .io_in_0(iobs_6_io_in_0),
    .io_in_1(iobs_6_io_in_1),
    .io_out_0(iobs_6_io_out_0),
    .io_sram_en(iobs_6_io_sram_en),
    .io_sram_we(iobs_6_io_sram_we),
    .io_sram_addr(iobs_6_io_sram_addr),
    .io_sram_din(iobs_6_io_sram_din),
    .io_sram_dout(iobs_6_io_sram_dout)
  );
  IOB_7 iobs_7 ( // @[MultiTileCGRA.scala 231:25]
    .clock(iobs_7_clock),
    .reset(iobs_7_reset),
    .io_cfg_en(iobs_7_io_cfg_en),
    .io_cfg_addr(iobs_7_io_cfg_addr),
    .io_cfg_data(iobs_7_io_cfg_data),
    .io_start(iobs_7_io_start),
    .io_done(iobs_7_io_done),
    .io_en(iobs_7_io_en),
    .io_in_0(iobs_7_io_in_0),
    .io_in_1(iobs_7_io_in_1),
    .io_out_0(iobs_7_io_out_0),
    .io_sram_en(iobs_7_io_sram_en),
    .io_sram_we(iobs_7_io_sram_we),
    .io_sram_addr(iobs_7_io_sram_addr),
    .io_sram_din(iobs_7_io_sram_din),
    .io_sram_dout(iobs_7_io_sram_dout)
  );
  IOB_8 iobs_8 ( // @[MultiTileCGRA.scala 231:25]
    .clock(iobs_8_clock),
    .reset(iobs_8_reset),
    .io_cfg_en(iobs_8_io_cfg_en),
    .io_cfg_addr(iobs_8_io_cfg_addr),
    .io_cfg_data(iobs_8_io_cfg_data),
    .io_start(iobs_8_io_start),
    .io_done(iobs_8_io_done),
    .io_en(iobs_8_io_en),
    .io_in_0(iobs_8_io_in_0),
    .io_in_1(iobs_8_io_in_1),
    .io_out_0(iobs_8_io_out_0),
    .io_sram_en(iobs_8_io_sram_en),
    .io_sram_we(iobs_8_io_sram_we),
    .io_sram_addr(iobs_8_io_sram_addr),
    .io_sram_din(iobs_8_io_sram_din),
    .io_sram_dout(iobs_8_io_sram_dout)
  );
  IOB_9 iobs_9 ( // @[MultiTileCGRA.scala 231:25]
    .clock(iobs_9_clock),
    .reset(iobs_9_reset),
    .io_cfg_en(iobs_9_io_cfg_en),
    .io_cfg_addr(iobs_9_io_cfg_addr),
    .io_cfg_data(iobs_9_io_cfg_data),
    .io_start(iobs_9_io_start),
    .io_done(iobs_9_io_done),
    .io_en(iobs_9_io_en),
    .io_in_0(iobs_9_io_in_0),
    .io_out_0(iobs_9_io_out_0),
    .io_sram_en(iobs_9_io_sram_en),
    .io_sram_we(iobs_9_io_sram_we),
    .io_sram_addr(iobs_9_io_sram_addr),
    .io_sram_din(iobs_9_io_sram_din),
    .io_sram_dout(iobs_9_io_sram_dout)
  );
  GPE pes_0 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_0_clock),
    .reset(pes_0_reset),
    .io_cfg_en(pes_0_io_cfg_en),
    .io_cfg_addr(pes_0_io_cfg_addr),
    .io_cfg_data(pes_0_io_cfg_data),
    .io_start(pes_0_io_start),
    .io_en(pes_0_io_en),
    .io_in_1(pes_0_io_in_1),
    .io_in_3(pes_0_io_in_3),
    .io_in_4(pes_0_io_in_4),
    .io_out_0(pes_0_io_out_0)
  );
  GPE_1 pes_1 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_1_clock),
    .reset(pes_1_reset),
    .io_cfg_en(pes_1_io_cfg_en),
    .io_cfg_addr(pes_1_io_cfg_addr),
    .io_cfg_data(pes_1_io_cfg_data),
    .io_start(pes_1_io_start),
    .io_en(pes_1_io_en),
    .io_in_0(pes_1_io_in_0),
    .io_in_1(pes_1_io_in_1),
    .io_in_2(pes_1_io_in_2),
    .io_in_3(pes_1_io_in_3),
    .io_in_4(pes_1_io_in_4),
    .io_out_0(pes_1_io_out_0)
  );
  GPE_2 pes_2 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_2_clock),
    .reset(pes_2_reset),
    .io_cfg_en(pes_2_io_cfg_en),
    .io_cfg_addr(pes_2_io_cfg_addr),
    .io_cfg_data(pes_2_io_cfg_data),
    .io_start(pes_2_io_start),
    .io_en(pes_2_io_en),
    .io_in_0(pes_2_io_in_0),
    .io_in_1(pes_2_io_in_1),
    .io_in_2(pes_2_io_in_2),
    .io_in_3(pes_2_io_in_3),
    .io_in_4(pes_2_io_in_4),
    .io_out_0(pes_2_io_out_0)
  );
  GPE_3 pes_3 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_3_clock),
    .reset(pes_3_reset),
    .io_cfg_en(pes_3_io_cfg_en),
    .io_cfg_addr(pes_3_io_cfg_addr),
    .io_cfg_data(pes_3_io_cfg_data),
    .io_start(pes_3_io_start),
    .io_en(pes_3_io_en),
    .io_in_0(pes_3_io_in_0),
    .io_in_1(pes_3_io_in_1),
    .io_in_2(pes_3_io_in_2),
    .io_in_3(pes_3_io_in_3),
    .io_in_4(pes_3_io_in_4),
    .io_out_0(pes_3_io_out_0)
  );
  GPE_4 pes_4 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_4_clock),
    .reset(pes_4_reset),
    .io_cfg_en(pes_4_io_cfg_en),
    .io_cfg_addr(pes_4_io_cfg_addr),
    .io_cfg_data(pes_4_io_cfg_data),
    .io_start(pes_4_io_start),
    .io_en(pes_4_io_en),
    .io_in_0(pes_4_io_in_0),
    .io_in_2(pes_4_io_in_2),
    .io_in_4(pes_4_io_in_4),
    .io_out_0(pes_4_io_out_0)
  );
  GPE_5 pes_5 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_5_clock),
    .reset(pes_5_reset),
    .io_cfg_en(pes_5_io_cfg_en),
    .io_cfg_addr(pes_5_io_cfg_addr),
    .io_cfg_data(pes_5_io_cfg_data),
    .io_start(pes_5_io_start),
    .io_en(pes_5_io_en),
    .io_in_1(pes_5_io_in_1),
    .io_in_3(pes_5_io_in_3),
    .io_out_0(pes_5_io_out_0)
  );
  GPE_6 pes_6 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_6_clock),
    .reset(pes_6_reset),
    .io_cfg_en(pes_6_io_cfg_en),
    .io_cfg_addr(pes_6_io_cfg_addr),
    .io_cfg_data(pes_6_io_cfg_data),
    .io_start(pes_6_io_start),
    .io_en(pes_6_io_en),
    .io_in_0(pes_6_io_in_0),
    .io_in_1(pes_6_io_in_1),
    .io_in_2(pes_6_io_in_2),
    .io_in_3(pes_6_io_in_3),
    .io_out_0(pes_6_io_out_0)
  );
  GPE_7 pes_7 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_7_clock),
    .reset(pes_7_reset),
    .io_cfg_en(pes_7_io_cfg_en),
    .io_cfg_addr(pes_7_io_cfg_addr),
    .io_cfg_data(pes_7_io_cfg_data),
    .io_start(pes_7_io_start),
    .io_en(pes_7_io_en),
    .io_in_0(pes_7_io_in_0),
    .io_in_1(pes_7_io_in_1),
    .io_in_2(pes_7_io_in_2),
    .io_in_3(pes_7_io_in_3),
    .io_out_0(pes_7_io_out_0)
  );
  GPE_8 pes_8 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_8_clock),
    .reset(pes_8_reset),
    .io_cfg_en(pes_8_io_cfg_en),
    .io_cfg_addr(pes_8_io_cfg_addr),
    .io_cfg_data(pes_8_io_cfg_data),
    .io_start(pes_8_io_start),
    .io_en(pes_8_io_en),
    .io_in_0(pes_8_io_in_0),
    .io_in_1(pes_8_io_in_1),
    .io_in_2(pes_8_io_in_2),
    .io_in_3(pes_8_io_in_3),
    .io_out_0(pes_8_io_out_0)
  );
  GPE_9 pes_9 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_9_clock),
    .reset(pes_9_reset),
    .io_cfg_en(pes_9_io_cfg_en),
    .io_cfg_addr(pes_9_io_cfg_addr),
    .io_cfg_data(pes_9_io_cfg_data),
    .io_start(pes_9_io_start),
    .io_en(pes_9_io_en),
    .io_in_0(pes_9_io_in_0),
    .io_in_2(pes_9_io_in_2),
    .io_out_0(pes_9_io_out_0)
  );
  GPE_10 pes_10 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_10_clock),
    .reset(pes_10_reset),
    .io_cfg_en(pes_10_io_cfg_en),
    .io_cfg_addr(pes_10_io_cfg_addr),
    .io_cfg_data(pes_10_io_cfg_data),
    .io_start(pes_10_io_start),
    .io_en(pes_10_io_en),
    .io_in_1(pes_10_io_in_1),
    .io_in_3(pes_10_io_in_3),
    .io_out_0(pes_10_io_out_0)
  );
  GPE_11 pes_11 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_11_clock),
    .reset(pes_11_reset),
    .io_cfg_en(pes_11_io_cfg_en),
    .io_cfg_addr(pes_11_io_cfg_addr),
    .io_cfg_data(pes_11_io_cfg_data),
    .io_start(pes_11_io_start),
    .io_en(pes_11_io_en),
    .io_in_0(pes_11_io_in_0),
    .io_in_1(pes_11_io_in_1),
    .io_in_2(pes_11_io_in_2),
    .io_in_3(pes_11_io_in_3),
    .io_out_0(pes_11_io_out_0)
  );
  GPE_12 pes_12 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_12_clock),
    .reset(pes_12_reset),
    .io_cfg_en(pes_12_io_cfg_en),
    .io_cfg_addr(pes_12_io_cfg_addr),
    .io_cfg_data(pes_12_io_cfg_data),
    .io_start(pes_12_io_start),
    .io_en(pes_12_io_en),
    .io_in_0(pes_12_io_in_0),
    .io_in_1(pes_12_io_in_1),
    .io_in_2(pes_12_io_in_2),
    .io_in_3(pes_12_io_in_3),
    .io_out_0(pes_12_io_out_0)
  );
  GPE_13 pes_13 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_13_clock),
    .reset(pes_13_reset),
    .io_cfg_en(pes_13_io_cfg_en),
    .io_cfg_addr(pes_13_io_cfg_addr),
    .io_cfg_data(pes_13_io_cfg_data),
    .io_start(pes_13_io_start),
    .io_en(pes_13_io_en),
    .io_in_0(pes_13_io_in_0),
    .io_in_1(pes_13_io_in_1),
    .io_in_2(pes_13_io_in_2),
    .io_in_3(pes_13_io_in_3),
    .io_out_0(pes_13_io_out_0)
  );
  GPE_14 pes_14 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_14_clock),
    .reset(pes_14_reset),
    .io_cfg_en(pes_14_io_cfg_en),
    .io_cfg_addr(pes_14_io_cfg_addr),
    .io_cfg_data(pes_14_io_cfg_data),
    .io_start(pes_14_io_start),
    .io_en(pes_14_io_en),
    .io_in_0(pes_14_io_in_0),
    .io_in_2(pes_14_io_in_2),
    .io_out_0(pes_14_io_out_0)
  );
  GPE_15 pes_15 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_15_clock),
    .reset(pes_15_reset),
    .io_cfg_en(pes_15_io_cfg_en),
    .io_cfg_addr(pes_15_io_cfg_addr),
    .io_cfg_data(pes_15_io_cfg_data),
    .io_start(pes_15_io_start),
    .io_en(pes_15_io_en),
    .io_in_1(pes_15_io_in_1),
    .io_in_3(pes_15_io_in_3),
    .io_out_0(pes_15_io_out_0)
  );
  GPE_16 pes_16 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_16_clock),
    .reset(pes_16_reset),
    .io_cfg_en(pes_16_io_cfg_en),
    .io_cfg_addr(pes_16_io_cfg_addr),
    .io_cfg_data(pes_16_io_cfg_data),
    .io_start(pes_16_io_start),
    .io_en(pes_16_io_en),
    .io_in_0(pes_16_io_in_0),
    .io_in_1(pes_16_io_in_1),
    .io_in_2(pes_16_io_in_2),
    .io_in_3(pes_16_io_in_3),
    .io_out_0(pes_16_io_out_0)
  );
  GPE_17 pes_17 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_17_clock),
    .reset(pes_17_reset),
    .io_cfg_en(pes_17_io_cfg_en),
    .io_cfg_addr(pes_17_io_cfg_addr),
    .io_cfg_data(pes_17_io_cfg_data),
    .io_start(pes_17_io_start),
    .io_en(pes_17_io_en),
    .io_in_0(pes_17_io_in_0),
    .io_in_1(pes_17_io_in_1),
    .io_in_2(pes_17_io_in_2),
    .io_in_3(pes_17_io_in_3),
    .io_out_0(pes_17_io_out_0)
  );
  GPE_18 pes_18 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_18_clock),
    .reset(pes_18_reset),
    .io_cfg_en(pes_18_io_cfg_en),
    .io_cfg_addr(pes_18_io_cfg_addr),
    .io_cfg_data(pes_18_io_cfg_data),
    .io_start(pes_18_io_start),
    .io_en(pes_18_io_en),
    .io_in_0(pes_18_io_in_0),
    .io_in_1(pes_18_io_in_1),
    .io_in_2(pes_18_io_in_2),
    .io_in_3(pes_18_io_in_3),
    .io_out_0(pes_18_io_out_0)
  );
  GPE_19 pes_19 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_19_clock),
    .reset(pes_19_reset),
    .io_cfg_en(pes_19_io_cfg_en),
    .io_cfg_addr(pes_19_io_cfg_addr),
    .io_cfg_data(pes_19_io_cfg_data),
    .io_start(pes_19_io_start),
    .io_en(pes_19_io_en),
    .io_in_0(pes_19_io_in_0),
    .io_in_2(pes_19_io_in_2),
    .io_out_0(pes_19_io_out_0)
  );
  GPE_20 pes_20 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_20_clock),
    .reset(pes_20_reset),
    .io_cfg_en(pes_20_io_cfg_en),
    .io_cfg_addr(pes_20_io_cfg_addr),
    .io_cfg_data(pes_20_io_cfg_data),
    .io_start(pes_20_io_start),
    .io_en(pes_20_io_en),
    .io_in_1(pes_20_io_in_1),
    .io_in_3(pes_20_io_in_3),
    .io_in_7(pes_20_io_in_7),
    .io_out_0(pes_20_io_out_0)
  );
  GPE_21 pes_21 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_21_clock),
    .reset(pes_21_reset),
    .io_cfg_en(pes_21_io_cfg_en),
    .io_cfg_addr(pes_21_io_cfg_addr),
    .io_cfg_data(pes_21_io_cfg_data),
    .io_start(pes_21_io_start),
    .io_en(pes_21_io_en),
    .io_in_0(pes_21_io_in_0),
    .io_in_1(pes_21_io_in_1),
    .io_in_2(pes_21_io_in_2),
    .io_in_3(pes_21_io_in_3),
    .io_in_7(pes_21_io_in_7),
    .io_out_0(pes_21_io_out_0)
  );
  GPE_22 pes_22 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_22_clock),
    .reset(pes_22_reset),
    .io_cfg_en(pes_22_io_cfg_en),
    .io_cfg_addr(pes_22_io_cfg_addr),
    .io_cfg_data(pes_22_io_cfg_data),
    .io_start(pes_22_io_start),
    .io_en(pes_22_io_en),
    .io_in_0(pes_22_io_in_0),
    .io_in_1(pes_22_io_in_1),
    .io_in_2(pes_22_io_in_2),
    .io_in_3(pes_22_io_in_3),
    .io_in_7(pes_22_io_in_7),
    .io_out_0(pes_22_io_out_0)
  );
  GPE_23 pes_23 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_23_clock),
    .reset(pes_23_reset),
    .io_cfg_en(pes_23_io_cfg_en),
    .io_cfg_addr(pes_23_io_cfg_addr),
    .io_cfg_data(pes_23_io_cfg_data),
    .io_start(pes_23_io_start),
    .io_en(pes_23_io_en),
    .io_in_0(pes_23_io_in_0),
    .io_in_1(pes_23_io_in_1),
    .io_in_2(pes_23_io_in_2),
    .io_in_3(pes_23_io_in_3),
    .io_in_7(pes_23_io_in_7),
    .io_out_0(pes_23_io_out_0)
  );
  GPE_24 pes_24 ( // @[MultiTileCGRA.scala 306:22]
    .clock(pes_24_clock),
    .reset(pes_24_reset),
    .io_cfg_en(pes_24_io_cfg_en),
    .io_cfg_addr(pes_24_io_cfg_addr),
    .io_cfg_data(pes_24_io_cfg_data),
    .io_start(pes_24_io_start),
    .io_en(pes_24_io_en),
    .io_in_0(pes_24_io_in_0),
    .io_in_2(pes_24_io_in_2),
    .io_in_7(pes_24_io_in_7),
    .io_out_0(pes_24_io_out_0)
  );
  GIB gibs_0 ( // @[MultiTileCGRA.scala 394:23]
    .io_opinNE_0(gibs_0_io_opinNE_0),
    .io_ipinSE_1(gibs_0_io_ipinSE_1),
    .io_itrackE_0(gibs_0_io_itrackE_0),
    .io_otrackE_0(gibs_0_io_otrackE_0),
    .io_itrackS_0(gibs_0_io_itrackS_0),
    .io_otrackS_0(gibs_0_io_otrackS_0)
  );
  GIB_1 gibs_1 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_1_clock),
    .reset(gibs_1_reset),
    .io_cfg_en(gibs_1_io_cfg_en),
    .io_cfg_addr(gibs_1_io_cfg_addr),
    .io_cfg_data(gibs_1_io_cfg_data),
    .io_ipinNW_0(gibs_1_io_ipinNW_0),
    .io_opinNW_0(gibs_1_io_opinNW_0),
    .io_ipinNE_0(gibs_1_io_ipinNE_0),
    .io_opinNE_0(gibs_1_io_opinNE_0),
    .io_ipinSE_0(gibs_1_io_ipinSE_0),
    .io_ipinSE_1(gibs_1_io_ipinSE_1),
    .io_opinSE_0(gibs_1_io_opinSE_0),
    .io_ipinSW_0(gibs_1_io_ipinSW_0),
    .io_itrackW_0(gibs_1_io_itrackW_0),
    .io_otrackW_0(gibs_1_io_otrackW_0),
    .io_itrackE_0(gibs_1_io_itrackE_0),
    .io_otrackE_0(gibs_1_io_otrackE_0),
    .io_itrackS_0(gibs_1_io_itrackS_0),
    .io_otrackS_0(gibs_1_io_otrackS_0)
  );
  GIB_2 gibs_2 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_2_clock),
    .reset(gibs_2_reset),
    .io_cfg_en(gibs_2_io_cfg_en),
    .io_cfg_addr(gibs_2_io_cfg_addr),
    .io_cfg_data(gibs_2_io_cfg_data),
    .io_ipinNW_0(gibs_2_io_ipinNW_0),
    .io_opinNW_0(gibs_2_io_opinNW_0),
    .io_ipinNE_0(gibs_2_io_ipinNE_0),
    .io_opinNE_0(gibs_2_io_opinNE_0),
    .io_ipinSE_0(gibs_2_io_ipinSE_0),
    .io_ipinSE_1(gibs_2_io_ipinSE_1),
    .io_opinSE_0(gibs_2_io_opinSE_0),
    .io_ipinSW_0(gibs_2_io_ipinSW_0),
    .io_itrackW_0(gibs_2_io_itrackW_0),
    .io_otrackW_0(gibs_2_io_otrackW_0),
    .io_itrackE_0(gibs_2_io_itrackE_0),
    .io_otrackE_0(gibs_2_io_otrackE_0),
    .io_itrackS_0(gibs_2_io_itrackS_0),
    .io_otrackS_0(gibs_2_io_otrackS_0)
  );
  GIB_3 gibs_3 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_3_clock),
    .reset(gibs_3_reset),
    .io_cfg_en(gibs_3_io_cfg_en),
    .io_cfg_addr(gibs_3_io_cfg_addr),
    .io_cfg_data(gibs_3_io_cfg_data),
    .io_ipinNW_0(gibs_3_io_ipinNW_0),
    .io_opinNW_0(gibs_3_io_opinNW_0),
    .io_ipinNE_0(gibs_3_io_ipinNE_0),
    .io_opinNE_0(gibs_3_io_opinNE_0),
    .io_ipinSE_0(gibs_3_io_ipinSE_0),
    .io_ipinSE_1(gibs_3_io_ipinSE_1),
    .io_opinSE_0(gibs_3_io_opinSE_0),
    .io_ipinSW_0(gibs_3_io_ipinSW_0),
    .io_itrackW_0(gibs_3_io_itrackW_0),
    .io_otrackW_0(gibs_3_io_otrackW_0),
    .io_itrackE_0(gibs_3_io_itrackE_0),
    .io_otrackE_0(gibs_3_io_otrackE_0),
    .io_itrackS_0(gibs_3_io_itrackS_0),
    .io_otrackS_0(gibs_3_io_otrackS_0)
  );
  GIB_4 gibs_4 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_4_clock),
    .reset(gibs_4_reset),
    .io_cfg_en(gibs_4_io_cfg_en),
    .io_cfg_addr(gibs_4_io_cfg_addr),
    .io_cfg_data(gibs_4_io_cfg_data),
    .io_ipinNW_0(gibs_4_io_ipinNW_0),
    .io_opinNW_0(gibs_4_io_opinNW_0),
    .io_ipinNE_0(gibs_4_io_ipinNE_0),
    .io_opinNE_0(gibs_4_io_opinNE_0),
    .io_ipinSE_0(gibs_4_io_ipinSE_0),
    .io_ipinSE_1(gibs_4_io_ipinSE_1),
    .io_opinSE_0(gibs_4_io_opinSE_0),
    .io_ipinSW_0(gibs_4_io_ipinSW_0),
    .io_itrackW_0(gibs_4_io_itrackW_0),
    .io_otrackW_0(gibs_4_io_otrackW_0),
    .io_itrackE_0(gibs_4_io_itrackE_0),
    .io_otrackE_0(gibs_4_io_otrackE_0),
    .io_itrackS_0(gibs_4_io_itrackS_0),
    .io_otrackS_0(gibs_4_io_otrackS_0)
  );
  GIB_5 gibs_5 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_5_clock),
    .reset(gibs_5_reset),
    .io_cfg_en(gibs_5_io_cfg_en),
    .io_cfg_addr(gibs_5_io_cfg_addr),
    .io_cfg_data(gibs_5_io_cfg_data),
    .io_itrackN_0(gibs_5_io_itrackN_0),
    .io_otrackN_0(gibs_5_io_otrackN_0),
    .io_itrackE_0(gibs_5_io_itrackE_0),
    .io_otrackE_0(gibs_5_io_otrackE_0),
    .io_itrackS_0(gibs_5_io_itrackS_0),
    .io_otrackS_0(gibs_5_io_otrackS_0)
  );
  GIB_6 gibs_6 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_6_clock),
    .reset(gibs_6_reset),
    .io_cfg_en(gibs_6_io_cfg_en),
    .io_cfg_addr(gibs_6_io_cfg_addr),
    .io_cfg_data(gibs_6_io_cfg_data),
    .io_ipinNW_0(gibs_6_io_ipinNW_0),
    .io_opinNW_0(gibs_6_io_opinNW_0),
    .io_ipinNE_0(gibs_6_io_ipinNE_0),
    .io_ipinSE_0(gibs_6_io_ipinSE_0),
    .io_opinSE_0(gibs_6_io_opinSE_0),
    .io_ipinSW_0(gibs_6_io_ipinSW_0),
    .io_itrackW_0(gibs_6_io_itrackW_0),
    .io_otrackW_0(gibs_6_io_otrackW_0),
    .io_itrackN_0(gibs_6_io_itrackN_0),
    .io_otrackN_0(gibs_6_io_otrackN_0),
    .io_itrackE_0(gibs_6_io_itrackE_0),
    .io_otrackE_0(gibs_6_io_otrackE_0),
    .io_itrackS_0(gibs_6_io_itrackS_0),
    .io_otrackS_0(gibs_6_io_otrackS_0)
  );
  GIB_7 gibs_7 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_7_clock),
    .reset(gibs_7_reset),
    .io_cfg_en(gibs_7_io_cfg_en),
    .io_cfg_addr(gibs_7_io_cfg_addr),
    .io_cfg_data(gibs_7_io_cfg_data),
    .io_ipinNW_0(gibs_7_io_ipinNW_0),
    .io_opinNW_0(gibs_7_io_opinNW_0),
    .io_ipinNE_0(gibs_7_io_ipinNE_0),
    .io_ipinSE_0(gibs_7_io_ipinSE_0),
    .io_opinSE_0(gibs_7_io_opinSE_0),
    .io_ipinSW_0(gibs_7_io_ipinSW_0),
    .io_itrackW_0(gibs_7_io_itrackW_0),
    .io_otrackW_0(gibs_7_io_otrackW_0),
    .io_itrackN_0(gibs_7_io_itrackN_0),
    .io_otrackN_0(gibs_7_io_otrackN_0),
    .io_itrackE_0(gibs_7_io_itrackE_0),
    .io_otrackE_0(gibs_7_io_otrackE_0),
    .io_itrackS_0(gibs_7_io_itrackS_0),
    .io_otrackS_0(gibs_7_io_otrackS_0)
  );
  GIB_8 gibs_8 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_8_clock),
    .reset(gibs_8_reset),
    .io_cfg_en(gibs_8_io_cfg_en),
    .io_cfg_addr(gibs_8_io_cfg_addr),
    .io_cfg_data(gibs_8_io_cfg_data),
    .io_ipinNW_0(gibs_8_io_ipinNW_0),
    .io_opinNW_0(gibs_8_io_opinNW_0),
    .io_ipinNE_0(gibs_8_io_ipinNE_0),
    .io_ipinSE_0(gibs_8_io_ipinSE_0),
    .io_opinSE_0(gibs_8_io_opinSE_0),
    .io_ipinSW_0(gibs_8_io_ipinSW_0),
    .io_itrackW_0(gibs_8_io_itrackW_0),
    .io_otrackW_0(gibs_8_io_otrackW_0),
    .io_itrackN_0(gibs_8_io_itrackN_0),
    .io_otrackN_0(gibs_8_io_otrackN_0),
    .io_itrackE_0(gibs_8_io_itrackE_0),
    .io_otrackE_0(gibs_8_io_otrackE_0),
    .io_itrackS_0(gibs_8_io_itrackS_0),
    .io_otrackS_0(gibs_8_io_otrackS_0)
  );
  GIB_9 gibs_9 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_9_clock),
    .reset(gibs_9_reset),
    .io_cfg_en(gibs_9_io_cfg_en),
    .io_cfg_addr(gibs_9_io_cfg_addr),
    .io_cfg_data(gibs_9_io_cfg_data),
    .io_ipinNW_0(gibs_9_io_ipinNW_0),
    .io_opinNW_0(gibs_9_io_opinNW_0),
    .io_ipinNE_0(gibs_9_io_ipinNE_0),
    .io_ipinSE_0(gibs_9_io_ipinSE_0),
    .io_opinSE_0(gibs_9_io_opinSE_0),
    .io_ipinSW_0(gibs_9_io_ipinSW_0),
    .io_itrackW_0(gibs_9_io_itrackW_0),
    .io_otrackW_0(gibs_9_io_otrackW_0),
    .io_itrackN_0(gibs_9_io_itrackN_0),
    .io_otrackN_0(gibs_9_io_otrackN_0),
    .io_itrackE_0(gibs_9_io_itrackE_0),
    .io_otrackE_0(gibs_9_io_otrackE_0),
    .io_itrackS_0(gibs_9_io_itrackS_0),
    .io_otrackS_0(gibs_9_io_otrackS_0)
  );
  GIB_10 gibs_10 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_10_clock),
    .reset(gibs_10_reset),
    .io_cfg_en(gibs_10_io_cfg_en),
    .io_cfg_addr(gibs_10_io_cfg_addr),
    .io_cfg_data(gibs_10_io_cfg_data),
    .io_itrackN_0(gibs_10_io_itrackN_0),
    .io_otrackN_0(gibs_10_io_otrackN_0),
    .io_itrackE_0(gibs_10_io_itrackE_0),
    .io_otrackE_0(gibs_10_io_otrackE_0),
    .io_itrackS_0(gibs_10_io_itrackS_0),
    .io_otrackS_0(gibs_10_io_otrackS_0)
  );
  GIB_11 gibs_11 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_11_clock),
    .reset(gibs_11_reset),
    .io_cfg_en(gibs_11_io_cfg_en),
    .io_cfg_addr(gibs_11_io_cfg_addr),
    .io_cfg_data(gibs_11_io_cfg_data),
    .io_ipinNW_0(gibs_11_io_ipinNW_0),
    .io_opinNW_0(gibs_11_io_opinNW_0),
    .io_ipinNE_0(gibs_11_io_ipinNE_0),
    .io_ipinSE_0(gibs_11_io_ipinSE_0),
    .io_opinSE_0(gibs_11_io_opinSE_0),
    .io_ipinSW_0(gibs_11_io_ipinSW_0),
    .io_itrackW_0(gibs_11_io_itrackW_0),
    .io_otrackW_0(gibs_11_io_otrackW_0),
    .io_itrackN_0(gibs_11_io_itrackN_0),
    .io_otrackN_0(gibs_11_io_otrackN_0),
    .io_itrackE_0(gibs_11_io_itrackE_0),
    .io_otrackE_0(gibs_11_io_otrackE_0),
    .io_itrackS_0(gibs_11_io_itrackS_0),
    .io_otrackS_0(gibs_11_io_otrackS_0)
  );
  GIB_12 gibs_12 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_12_clock),
    .reset(gibs_12_reset),
    .io_cfg_en(gibs_12_io_cfg_en),
    .io_cfg_addr(gibs_12_io_cfg_addr),
    .io_cfg_data(gibs_12_io_cfg_data),
    .io_ipinNW_0(gibs_12_io_ipinNW_0),
    .io_opinNW_0(gibs_12_io_opinNW_0),
    .io_ipinNE_0(gibs_12_io_ipinNE_0),
    .io_ipinSE_0(gibs_12_io_ipinSE_0),
    .io_opinSE_0(gibs_12_io_opinSE_0),
    .io_ipinSW_0(gibs_12_io_ipinSW_0),
    .io_itrackW_0(gibs_12_io_itrackW_0),
    .io_otrackW_0(gibs_12_io_otrackW_0),
    .io_itrackN_0(gibs_12_io_itrackN_0),
    .io_otrackN_0(gibs_12_io_otrackN_0),
    .io_itrackE_0(gibs_12_io_itrackE_0),
    .io_otrackE_0(gibs_12_io_otrackE_0),
    .io_itrackS_0(gibs_12_io_itrackS_0),
    .io_otrackS_0(gibs_12_io_otrackS_0)
  );
  GIB_13 gibs_13 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_13_clock),
    .reset(gibs_13_reset),
    .io_cfg_en(gibs_13_io_cfg_en),
    .io_cfg_addr(gibs_13_io_cfg_addr),
    .io_cfg_data(gibs_13_io_cfg_data),
    .io_ipinNW_0(gibs_13_io_ipinNW_0),
    .io_opinNW_0(gibs_13_io_opinNW_0),
    .io_ipinNE_0(gibs_13_io_ipinNE_0),
    .io_ipinSE_0(gibs_13_io_ipinSE_0),
    .io_opinSE_0(gibs_13_io_opinSE_0),
    .io_ipinSW_0(gibs_13_io_ipinSW_0),
    .io_itrackW_0(gibs_13_io_itrackW_0),
    .io_otrackW_0(gibs_13_io_otrackW_0),
    .io_itrackN_0(gibs_13_io_itrackN_0),
    .io_otrackN_0(gibs_13_io_otrackN_0),
    .io_itrackE_0(gibs_13_io_itrackE_0),
    .io_otrackE_0(gibs_13_io_otrackE_0),
    .io_itrackS_0(gibs_13_io_itrackS_0),
    .io_otrackS_0(gibs_13_io_otrackS_0)
  );
  GIB_14 gibs_14 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_14_clock),
    .reset(gibs_14_reset),
    .io_cfg_en(gibs_14_io_cfg_en),
    .io_cfg_addr(gibs_14_io_cfg_addr),
    .io_cfg_data(gibs_14_io_cfg_data),
    .io_ipinNW_0(gibs_14_io_ipinNW_0),
    .io_opinNW_0(gibs_14_io_opinNW_0),
    .io_ipinNE_0(gibs_14_io_ipinNE_0),
    .io_ipinSE_0(gibs_14_io_ipinSE_0),
    .io_opinSE_0(gibs_14_io_opinSE_0),
    .io_ipinSW_0(gibs_14_io_ipinSW_0),
    .io_itrackW_0(gibs_14_io_itrackW_0),
    .io_otrackW_0(gibs_14_io_otrackW_0),
    .io_itrackN_0(gibs_14_io_itrackN_0),
    .io_otrackN_0(gibs_14_io_otrackN_0),
    .io_itrackE_0(gibs_14_io_itrackE_0),
    .io_otrackE_0(gibs_14_io_otrackE_0),
    .io_itrackS_0(gibs_14_io_itrackS_0),
    .io_otrackS_0(gibs_14_io_otrackS_0)
  );
  GIB_15 gibs_15 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_15_clock),
    .reset(gibs_15_reset),
    .io_cfg_en(gibs_15_io_cfg_en),
    .io_cfg_addr(gibs_15_io_cfg_addr),
    .io_cfg_data(gibs_15_io_cfg_data),
    .io_itrackN_0(gibs_15_io_itrackN_0),
    .io_otrackN_0(gibs_15_io_otrackN_0),
    .io_itrackE_0(gibs_15_io_itrackE_0),
    .io_otrackE_0(gibs_15_io_otrackE_0),
    .io_itrackS_0(gibs_15_io_itrackS_0),
    .io_otrackS_0(gibs_15_io_otrackS_0)
  );
  GIB_16 gibs_16 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_16_clock),
    .reset(gibs_16_reset),
    .io_cfg_en(gibs_16_io_cfg_en),
    .io_cfg_addr(gibs_16_io_cfg_addr),
    .io_cfg_data(gibs_16_io_cfg_data),
    .io_ipinNW_0(gibs_16_io_ipinNW_0),
    .io_opinNW_0(gibs_16_io_opinNW_0),
    .io_ipinNE_0(gibs_16_io_ipinNE_0),
    .io_ipinSE_0(gibs_16_io_ipinSE_0),
    .io_opinSE_0(gibs_16_io_opinSE_0),
    .io_ipinSW_0(gibs_16_io_ipinSW_0),
    .io_itrackW_0(gibs_16_io_itrackW_0),
    .io_otrackW_0(gibs_16_io_otrackW_0),
    .io_itrackN_0(gibs_16_io_itrackN_0),
    .io_otrackN_0(gibs_16_io_otrackN_0),
    .io_itrackE_0(gibs_16_io_itrackE_0),
    .io_otrackE_0(gibs_16_io_otrackE_0),
    .io_itrackS_0(gibs_16_io_itrackS_0),
    .io_otrackS_0(gibs_16_io_otrackS_0)
  );
  GIB_17 gibs_17 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_17_clock),
    .reset(gibs_17_reset),
    .io_cfg_en(gibs_17_io_cfg_en),
    .io_cfg_addr(gibs_17_io_cfg_addr),
    .io_cfg_data(gibs_17_io_cfg_data),
    .io_ipinNW_0(gibs_17_io_ipinNW_0),
    .io_opinNW_0(gibs_17_io_opinNW_0),
    .io_ipinNE_0(gibs_17_io_ipinNE_0),
    .io_ipinSE_0(gibs_17_io_ipinSE_0),
    .io_opinSE_0(gibs_17_io_opinSE_0),
    .io_ipinSW_0(gibs_17_io_ipinSW_0),
    .io_itrackW_0(gibs_17_io_itrackW_0),
    .io_otrackW_0(gibs_17_io_otrackW_0),
    .io_itrackN_0(gibs_17_io_itrackN_0),
    .io_otrackN_0(gibs_17_io_otrackN_0),
    .io_itrackE_0(gibs_17_io_itrackE_0),
    .io_otrackE_0(gibs_17_io_otrackE_0),
    .io_itrackS_0(gibs_17_io_itrackS_0),
    .io_otrackS_0(gibs_17_io_otrackS_0)
  );
  GIB_18 gibs_18 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_18_clock),
    .reset(gibs_18_reset),
    .io_cfg_en(gibs_18_io_cfg_en),
    .io_cfg_addr(gibs_18_io_cfg_addr),
    .io_cfg_data(gibs_18_io_cfg_data),
    .io_ipinNW_0(gibs_18_io_ipinNW_0),
    .io_opinNW_0(gibs_18_io_opinNW_0),
    .io_ipinNE_0(gibs_18_io_ipinNE_0),
    .io_ipinSE_0(gibs_18_io_ipinSE_0),
    .io_opinSE_0(gibs_18_io_opinSE_0),
    .io_ipinSW_0(gibs_18_io_ipinSW_0),
    .io_itrackW_0(gibs_18_io_itrackW_0),
    .io_otrackW_0(gibs_18_io_otrackW_0),
    .io_itrackN_0(gibs_18_io_itrackN_0),
    .io_otrackN_0(gibs_18_io_otrackN_0),
    .io_itrackE_0(gibs_18_io_itrackE_0),
    .io_otrackE_0(gibs_18_io_otrackE_0),
    .io_itrackS_0(gibs_18_io_itrackS_0),
    .io_otrackS_0(gibs_18_io_otrackS_0)
  );
  GIB_19 gibs_19 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_19_clock),
    .reset(gibs_19_reset),
    .io_cfg_en(gibs_19_io_cfg_en),
    .io_cfg_addr(gibs_19_io_cfg_addr),
    .io_cfg_data(gibs_19_io_cfg_data),
    .io_ipinNW_0(gibs_19_io_ipinNW_0),
    .io_opinNW_0(gibs_19_io_opinNW_0),
    .io_ipinNE_0(gibs_19_io_ipinNE_0),
    .io_ipinSE_0(gibs_19_io_ipinSE_0),
    .io_opinSE_0(gibs_19_io_opinSE_0),
    .io_ipinSW_0(gibs_19_io_ipinSW_0),
    .io_itrackW_0(gibs_19_io_itrackW_0),
    .io_otrackW_0(gibs_19_io_otrackW_0),
    .io_itrackN_0(gibs_19_io_itrackN_0),
    .io_otrackN_0(gibs_19_io_otrackN_0),
    .io_itrackE_0(gibs_19_io_itrackE_0),
    .io_otrackE_0(gibs_19_io_otrackE_0),
    .io_itrackS_0(gibs_19_io_itrackS_0),
    .io_otrackS_0(gibs_19_io_otrackS_0)
  );
  GIB_20 gibs_20 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_20_clock),
    .reset(gibs_20_reset),
    .io_cfg_en(gibs_20_io_cfg_en),
    .io_cfg_addr(gibs_20_io_cfg_addr),
    .io_cfg_data(gibs_20_io_cfg_data),
    .io_itrackN_0(gibs_20_io_itrackN_0),
    .io_otrackN_0(gibs_20_io_otrackN_0),
    .io_itrackE_0(gibs_20_io_itrackE_0),
    .io_otrackE_0(gibs_20_io_otrackE_0),
    .io_itrackS_0(gibs_20_io_itrackS_0),
    .io_otrackS_0(gibs_20_io_otrackS_0)
  );
  GIB_21 gibs_21 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_21_clock),
    .reset(gibs_21_reset),
    .io_cfg_en(gibs_21_io_cfg_en),
    .io_cfg_addr(gibs_21_io_cfg_addr),
    .io_cfg_data(gibs_21_io_cfg_data),
    .io_ipinNW_0(gibs_21_io_ipinNW_0),
    .io_opinNW_0(gibs_21_io_opinNW_0),
    .io_ipinNE_0(gibs_21_io_ipinNE_0),
    .io_ipinSE_0(gibs_21_io_ipinSE_0),
    .io_opinSE_0(gibs_21_io_opinSE_0),
    .io_ipinSW_0(gibs_21_io_ipinSW_0),
    .io_itrackW_0(gibs_21_io_itrackW_0),
    .io_otrackW_0(gibs_21_io_otrackW_0),
    .io_itrackN_0(gibs_21_io_itrackN_0),
    .io_otrackN_0(gibs_21_io_otrackN_0),
    .io_itrackE_0(gibs_21_io_itrackE_0),
    .io_otrackE_0(gibs_21_io_otrackE_0),
    .io_itrackS_0(gibs_21_io_itrackS_0),
    .io_otrackS_0(gibs_21_io_otrackS_0)
  );
  GIB_22 gibs_22 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_22_clock),
    .reset(gibs_22_reset),
    .io_cfg_en(gibs_22_io_cfg_en),
    .io_cfg_addr(gibs_22_io_cfg_addr),
    .io_cfg_data(gibs_22_io_cfg_data),
    .io_ipinNW_0(gibs_22_io_ipinNW_0),
    .io_opinNW_0(gibs_22_io_opinNW_0),
    .io_ipinNE_0(gibs_22_io_ipinNE_0),
    .io_ipinSE_0(gibs_22_io_ipinSE_0),
    .io_opinSE_0(gibs_22_io_opinSE_0),
    .io_ipinSW_0(gibs_22_io_ipinSW_0),
    .io_itrackW_0(gibs_22_io_itrackW_0),
    .io_otrackW_0(gibs_22_io_otrackW_0),
    .io_itrackN_0(gibs_22_io_itrackN_0),
    .io_otrackN_0(gibs_22_io_otrackN_0),
    .io_itrackE_0(gibs_22_io_itrackE_0),
    .io_otrackE_0(gibs_22_io_otrackE_0),
    .io_itrackS_0(gibs_22_io_itrackS_0),
    .io_otrackS_0(gibs_22_io_otrackS_0)
  );
  GIB_23 gibs_23 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_23_clock),
    .reset(gibs_23_reset),
    .io_cfg_en(gibs_23_io_cfg_en),
    .io_cfg_addr(gibs_23_io_cfg_addr),
    .io_cfg_data(gibs_23_io_cfg_data),
    .io_ipinNW_0(gibs_23_io_ipinNW_0),
    .io_opinNW_0(gibs_23_io_opinNW_0),
    .io_ipinNE_0(gibs_23_io_ipinNE_0),
    .io_ipinSE_0(gibs_23_io_ipinSE_0),
    .io_opinSE_0(gibs_23_io_opinSE_0),
    .io_ipinSW_0(gibs_23_io_ipinSW_0),
    .io_itrackW_0(gibs_23_io_itrackW_0),
    .io_otrackW_0(gibs_23_io_otrackW_0),
    .io_itrackN_0(gibs_23_io_itrackN_0),
    .io_otrackN_0(gibs_23_io_otrackN_0),
    .io_itrackE_0(gibs_23_io_itrackE_0),
    .io_otrackE_0(gibs_23_io_otrackE_0),
    .io_itrackS_0(gibs_23_io_itrackS_0),
    .io_otrackS_0(gibs_23_io_otrackS_0)
  );
  GIB_24 gibs_24 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_24_clock),
    .reset(gibs_24_reset),
    .io_cfg_en(gibs_24_io_cfg_en),
    .io_cfg_addr(gibs_24_io_cfg_addr),
    .io_cfg_data(gibs_24_io_cfg_data),
    .io_ipinNW_0(gibs_24_io_ipinNW_0),
    .io_opinNW_0(gibs_24_io_opinNW_0),
    .io_ipinNE_0(gibs_24_io_ipinNE_0),
    .io_ipinSE_0(gibs_24_io_ipinSE_0),
    .io_opinSE_0(gibs_24_io_opinSE_0),
    .io_ipinSW_0(gibs_24_io_ipinSW_0),
    .io_itrackW_0(gibs_24_io_itrackW_0),
    .io_otrackW_0(gibs_24_io_otrackW_0),
    .io_itrackN_0(gibs_24_io_itrackN_0),
    .io_otrackN_0(gibs_24_io_otrackN_0),
    .io_itrackE_0(gibs_24_io_itrackE_0),
    .io_otrackE_0(gibs_24_io_otrackE_0),
    .io_itrackS_0(gibs_24_io_itrackS_0),
    .io_otrackS_0(gibs_24_io_otrackS_0)
  );
  GIB_25 gibs_25 ( // @[MultiTileCGRA.scala 394:23]
    .io_itrackN_0(gibs_25_io_itrackN_0),
    .io_otrackN_0(gibs_25_io_otrackN_0),
    .io_itrackE_0(gibs_25_io_itrackE_0),
    .io_otrackE_0(gibs_25_io_otrackE_0)
  );
  GIB_26 gibs_26 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_26_clock),
    .reset(gibs_26_reset),
    .io_cfg_en(gibs_26_io_cfg_en),
    .io_cfg_addr(gibs_26_io_cfg_addr),
    .io_cfg_data(gibs_26_io_cfg_data),
    .io_ipinNW_0(gibs_26_io_ipinNW_0),
    .io_ipinNW_1(gibs_26_io_ipinNW_1),
    .io_opinNW_0(gibs_26_io_opinNW_0),
    .io_ipinNE_0(gibs_26_io_ipinNE_0),
    .io_ipinSE_0(gibs_26_io_ipinSE_0),
    .io_opinSE_0(gibs_26_io_opinSE_0),
    .io_ipinSW_0(gibs_26_io_ipinSW_0),
    .io_opinSW_0(gibs_26_io_opinSW_0),
    .io_itrackW_0(gibs_26_io_itrackW_0),
    .io_otrackW_0(gibs_26_io_otrackW_0),
    .io_itrackN_0(gibs_26_io_itrackN_0),
    .io_otrackN_0(gibs_26_io_otrackN_0),
    .io_itrackE_0(gibs_26_io_itrackE_0),
    .io_otrackE_0(gibs_26_io_otrackE_0)
  );
  GIB_27 gibs_27 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_27_clock),
    .reset(gibs_27_reset),
    .io_cfg_en(gibs_27_io_cfg_en),
    .io_cfg_addr(gibs_27_io_cfg_addr),
    .io_cfg_data(gibs_27_io_cfg_data),
    .io_ipinNW_0(gibs_27_io_ipinNW_0),
    .io_ipinNW_1(gibs_27_io_ipinNW_1),
    .io_opinNW_0(gibs_27_io_opinNW_0),
    .io_ipinNE_0(gibs_27_io_ipinNE_0),
    .io_ipinSE_0(gibs_27_io_ipinSE_0),
    .io_opinSE_0(gibs_27_io_opinSE_0),
    .io_ipinSW_0(gibs_27_io_ipinSW_0),
    .io_opinSW_0(gibs_27_io_opinSW_0),
    .io_itrackW_0(gibs_27_io_itrackW_0),
    .io_otrackW_0(gibs_27_io_otrackW_0),
    .io_itrackN_0(gibs_27_io_itrackN_0),
    .io_otrackN_0(gibs_27_io_otrackN_0),
    .io_itrackE_0(gibs_27_io_itrackE_0),
    .io_otrackE_0(gibs_27_io_otrackE_0)
  );
  GIB_28 gibs_28 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_28_clock),
    .reset(gibs_28_reset),
    .io_cfg_en(gibs_28_io_cfg_en),
    .io_cfg_addr(gibs_28_io_cfg_addr),
    .io_cfg_data(gibs_28_io_cfg_data),
    .io_ipinNW_0(gibs_28_io_ipinNW_0),
    .io_ipinNW_1(gibs_28_io_ipinNW_1),
    .io_opinNW_0(gibs_28_io_opinNW_0),
    .io_ipinNE_0(gibs_28_io_ipinNE_0),
    .io_ipinSE_0(gibs_28_io_ipinSE_0),
    .io_opinSE_0(gibs_28_io_opinSE_0),
    .io_ipinSW_0(gibs_28_io_ipinSW_0),
    .io_opinSW_0(gibs_28_io_opinSW_0),
    .io_itrackW_0(gibs_28_io_itrackW_0),
    .io_otrackW_0(gibs_28_io_otrackW_0),
    .io_itrackN_0(gibs_28_io_itrackN_0),
    .io_otrackN_0(gibs_28_io_otrackN_0),
    .io_itrackE_0(gibs_28_io_itrackE_0),
    .io_otrackE_0(gibs_28_io_otrackE_0)
  );
  GIB_29 gibs_29 ( // @[MultiTileCGRA.scala 394:23]
    .clock(gibs_29_clock),
    .reset(gibs_29_reset),
    .io_cfg_en(gibs_29_io_cfg_en),
    .io_cfg_addr(gibs_29_io_cfg_addr),
    .io_cfg_data(gibs_29_io_cfg_data),
    .io_ipinNW_0(gibs_29_io_ipinNW_0),
    .io_ipinNW_1(gibs_29_io_ipinNW_1),
    .io_opinNW_0(gibs_29_io_opinNW_0),
    .io_ipinNE_0(gibs_29_io_ipinNE_0),
    .io_ipinSE_0(gibs_29_io_ipinSE_0),
    .io_opinSE_0(gibs_29_io_opinSE_0),
    .io_ipinSW_0(gibs_29_io_ipinSW_0),
    .io_opinSW_0(gibs_29_io_opinSW_0),
    .io_itrackW_0(gibs_29_io_itrackW_0),
    .io_otrackW_0(gibs_29_io_otrackW_0),
    .io_itrackN_0(gibs_29_io_itrackN_0),
    .io_otrackN_0(gibs_29_io_otrackN_0),
    .io_itrackE_0(gibs_29_io_itrackE_0),
    .io_otrackE_0(gibs_29_io_otrackE_0)
  );
  GIB_30 gibs_30 ( // @[MultiTileCGRA.scala 836:23]
    .io_itrackW_0(gibs_30_io_itrackW_0),
    .io_otrackW_0(gibs_30_io_otrackW_0),
    .io_itrackS_0(gibs_30_io_itrackS_0),
    .io_otrackS_0(gibs_30_io_otrackS_0)
  );
  GIB_31 gibs_31 ( // @[MultiTileCGRA.scala 836:23]
    .clock(gibs_31_clock),
    .reset(gibs_31_reset),
    .io_cfg_en(gibs_31_io_cfg_en),
    .io_cfg_addr(gibs_31_io_cfg_addr),
    .io_cfg_data(gibs_31_io_cfg_data),
    .io_itrackW_0(gibs_31_io_itrackW_0),
    .io_otrackW_0(gibs_31_io_otrackW_0),
    .io_itrackN_0(gibs_31_io_itrackN_0),
    .io_otrackN_0(gibs_31_io_otrackN_0),
    .io_itrackS_0(gibs_31_io_itrackS_0),
    .io_otrackS_0(gibs_31_io_otrackS_0)
  );
  GIB_32 gibs_32 ( // @[MultiTileCGRA.scala 836:23]
    .clock(gibs_32_clock),
    .reset(gibs_32_reset),
    .io_cfg_en(gibs_32_io_cfg_en),
    .io_cfg_addr(gibs_32_io_cfg_addr),
    .io_cfg_data(gibs_32_io_cfg_data),
    .io_itrackW_0(gibs_32_io_itrackW_0),
    .io_otrackW_0(gibs_32_io_otrackW_0),
    .io_itrackN_0(gibs_32_io_itrackN_0),
    .io_otrackN_0(gibs_32_io_otrackN_0),
    .io_itrackS_0(gibs_32_io_itrackS_0),
    .io_otrackS_0(gibs_32_io_otrackS_0)
  );
  GIB_33 gibs_33 ( // @[MultiTileCGRA.scala 836:23]
    .clock(gibs_33_clock),
    .reset(gibs_33_reset),
    .io_cfg_en(gibs_33_io_cfg_en),
    .io_cfg_addr(gibs_33_io_cfg_addr),
    .io_cfg_data(gibs_33_io_cfg_data),
    .io_itrackW_0(gibs_33_io_itrackW_0),
    .io_otrackW_0(gibs_33_io_otrackW_0),
    .io_itrackN_0(gibs_33_io_itrackN_0),
    .io_otrackN_0(gibs_33_io_otrackN_0),
    .io_itrackS_0(gibs_33_io_itrackS_0),
    .io_otrackS_0(gibs_33_io_otrackS_0)
  );
  GIB_34 gibs_34 ( // @[MultiTileCGRA.scala 836:23]
    .clock(gibs_34_clock),
    .reset(gibs_34_reset),
    .io_cfg_en(gibs_34_io_cfg_en),
    .io_cfg_addr(gibs_34_io_cfg_addr),
    .io_cfg_data(gibs_34_io_cfg_data),
    .io_itrackW_0(gibs_34_io_itrackW_0),
    .io_otrackW_0(gibs_34_io_otrackW_0),
    .io_itrackN_0(gibs_34_io_itrackN_0),
    .io_otrackN_0(gibs_34_io_otrackN_0),
    .io_itrackS_0(gibs_34_io_itrackS_0),
    .io_otrackS_0(gibs_34_io_otrackS_0)
  );
  GIB_35 gibs_35 ( // @[MultiTileCGRA.scala 836:23]
    .io_ipinNW_1(gibs_35_io_ipinNW_1),
    .io_opinSW_0(gibs_35_io_opinSW_0),
    .io_itrackW_0(gibs_35_io_itrackW_0),
    .io_otrackW_0(gibs_35_io_otrackW_0),
    .io_itrackN_0(gibs_35_io_itrackN_0),
    .io_otrackN_0(gibs_35_io_otrackN_0)
  );
  assign io_done_0 = io_done_0_REG; // @[MultiTileCGRA.scala 529:19]
  assign io_srams_0_0_en = iobs_0_io_sram_en; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_0_we = iobs_0_io_sram_we; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_0_addr = iobs_0_io_sram_addr; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_0_din = iobs_0_io_sram_din; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_1_en = iobs_1_io_sram_en; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_1_we = iobs_1_io_sram_we; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_1_addr = iobs_1_io_sram_addr; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_1_din = iobs_1_io_sram_din; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_2_en = iobs_2_io_sram_en; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_2_we = iobs_2_io_sram_we; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_2_addr = iobs_2_io_sram_addr; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_2_din = iobs_2_io_sram_din; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_3_en = iobs_3_io_sram_en; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_3_we = iobs_3_io_sram_we; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_3_addr = iobs_3_io_sram_addr; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_3_din = iobs_3_io_sram_din; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_4_en = iobs_4_io_sram_en; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_4_we = iobs_4_io_sram_we; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_4_addr = iobs_4_io_sram_addr; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_4_din = iobs_4_io_sram_din; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_5_en = iobs_5_io_sram_en; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_5_we = iobs_5_io_sram_we; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_5_addr = iobs_5_io_sram_addr; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_5_din = iobs_5_io_sram_din; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_6_en = iobs_6_io_sram_en; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_6_we = iobs_6_io_sram_we; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_6_addr = iobs_6_io_sram_addr; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_6_din = iobs_6_io_sram_din; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_7_en = iobs_7_io_sram_en; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_7_we = iobs_7_io_sram_we; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_7_addr = iobs_7_io_sram_addr; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_7_din = iobs_7_io_sram_din; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_8_en = iobs_8_io_sram_en; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_8_we = iobs_8_io_sram_we; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_8_addr = iobs_8_io_sram_addr; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_8_din = iobs_8_io_sram_din; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_9_en = iobs_9_io_sram_en; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_9_we = iobs_9_io_sram_we; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_9_addr = iobs_9_io_sram_addr; // @[MultiTileCGRA.scala 429:19]
  assign io_srams_0_9_din = iobs_9_io_sram_din; // @[MultiTileCGRA.scala 429:19]
  assign iobs_0_clock = clock;
  assign iobs_0_reset = reset;
  assign iobs_0_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1020:25]
  assign iobs_0_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1022:25]
  assign iobs_0_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1023:25]
  assign iobs_0_io_start = io_start_0 & io_iob_ens_0[0]; // @[MultiTileCGRA.scala 427:38]
  assign iobs_0_io_en = io_en_0 & io_iob_ens_0[0]; // @[MultiTileCGRA.scala 428:32]
  assign iobs_0_io_in_1 = gibs_1_io_ipinNW_0; // @[MultiTileCGRA.scala 439:16]
  assign iobs_0_io_sram_dout = io_srams_0_0_dout; // @[MultiTileCGRA.scala 429:19]
  assign iobs_1_clock = clock;
  assign iobs_1_reset = reset;
  assign iobs_1_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1020:25]
  assign iobs_1_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1022:25]
  assign iobs_1_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1023:25]
  assign iobs_1_io_start = io_start_0 & io_iob_ens_0[1]; // @[MultiTileCGRA.scala 427:38]
  assign iobs_1_io_en = io_en_0 & io_iob_ens_0[1]; // @[MultiTileCGRA.scala 428:32]
  assign iobs_1_io_in_0 = gibs_1_io_ipinNE_0; // @[MultiTileCGRA.scala 435:16]
  assign iobs_1_io_in_1 = gibs_2_io_ipinNW_0; // @[MultiTileCGRA.scala 439:16]
  assign iobs_1_io_sram_dout = io_srams_0_1_dout; // @[MultiTileCGRA.scala 429:19]
  assign iobs_2_clock = clock;
  assign iobs_2_reset = reset;
  assign iobs_2_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1020:25]
  assign iobs_2_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1022:25]
  assign iobs_2_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1023:25]
  assign iobs_2_io_start = io_start_0 & io_iob_ens_0[2]; // @[MultiTileCGRA.scala 427:38]
  assign iobs_2_io_en = io_en_0 & io_iob_ens_0[2]; // @[MultiTileCGRA.scala 428:32]
  assign iobs_2_io_in_0 = gibs_2_io_ipinNE_0; // @[MultiTileCGRA.scala 435:16]
  assign iobs_2_io_in_1 = gibs_3_io_ipinNW_0; // @[MultiTileCGRA.scala 439:16]
  assign iobs_2_io_sram_dout = io_srams_0_2_dout; // @[MultiTileCGRA.scala 429:19]
  assign iobs_3_clock = clock;
  assign iobs_3_reset = reset;
  assign iobs_3_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1020:25]
  assign iobs_3_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1022:25]
  assign iobs_3_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1023:25]
  assign iobs_3_io_start = io_start_0 & io_iob_ens_0[3]; // @[MultiTileCGRA.scala 427:38]
  assign iobs_3_io_en = io_en_0 & io_iob_ens_0[3]; // @[MultiTileCGRA.scala 428:32]
  assign iobs_3_io_in_0 = gibs_3_io_ipinNE_0; // @[MultiTileCGRA.scala 435:16]
  assign iobs_3_io_in_1 = gibs_4_io_ipinNW_0; // @[MultiTileCGRA.scala 439:16]
  assign iobs_3_io_sram_dout = io_srams_0_3_dout; // @[MultiTileCGRA.scala 429:19]
  assign iobs_4_clock = clock;
  assign iobs_4_reset = reset;
  assign iobs_4_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1020:25]
  assign iobs_4_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1022:25]
  assign iobs_4_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1023:25]
  assign iobs_4_io_start = io_start_0 & io_iob_ens_0[4]; // @[MultiTileCGRA.scala 427:38]
  assign iobs_4_io_en = io_en_0 & io_iob_ens_0[4]; // @[MultiTileCGRA.scala 428:32]
  assign iobs_4_io_in_0 = gibs_4_io_ipinNE_0; // @[MultiTileCGRA.scala 457:16]
  assign iobs_4_io_sram_dout = io_srams_0_4_dout; // @[MultiTileCGRA.scala 429:19]
  assign iobs_5_clock = clock;
  assign iobs_5_reset = reset;
  assign iobs_5_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1020:25]
  assign iobs_5_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1022:25]
  assign iobs_5_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1023:25]
  assign iobs_5_io_start = io_start_0 & io_iob_ens_0[5]; // @[MultiTileCGRA.scala 427:38]
  assign iobs_5_io_en = io_en_0 & io_iob_ens_0[5]; // @[MultiTileCGRA.scala 428:32]
  assign iobs_5_io_in_1 = gibs_26_io_ipinSW_0; // @[MultiTileCGRA.scala 482:16]
  assign iobs_5_io_sram_dout = io_srams_0_5_dout; // @[MultiTileCGRA.scala 429:19]
  assign iobs_6_clock = clock;
  assign iobs_6_reset = reset;
  assign iobs_6_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1020:25]
  assign iobs_6_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1022:25]
  assign iobs_6_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1023:25]
  assign iobs_6_io_start = io_start_0 & io_iob_ens_0[6]; // @[MultiTileCGRA.scala 427:38]
  assign iobs_6_io_en = io_en_0 & io_iob_ens_0[6]; // @[MultiTileCGRA.scala 428:32]
  assign iobs_6_io_in_0 = gibs_26_io_ipinSE_0; // @[MultiTileCGRA.scala 478:16]
  assign iobs_6_io_in_1 = gibs_27_io_ipinSW_0; // @[MultiTileCGRA.scala 482:16]
  assign iobs_6_io_sram_dout = io_srams_0_6_dout; // @[MultiTileCGRA.scala 429:19]
  assign iobs_7_clock = clock;
  assign iobs_7_reset = reset;
  assign iobs_7_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1020:25]
  assign iobs_7_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1022:25]
  assign iobs_7_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1023:25]
  assign iobs_7_io_start = io_start_0 & io_iob_ens_0[7]; // @[MultiTileCGRA.scala 427:38]
  assign iobs_7_io_en = io_en_0 & io_iob_ens_0[7]; // @[MultiTileCGRA.scala 428:32]
  assign iobs_7_io_in_0 = gibs_27_io_ipinSE_0; // @[MultiTileCGRA.scala 478:16]
  assign iobs_7_io_in_1 = gibs_28_io_ipinSW_0; // @[MultiTileCGRA.scala 482:16]
  assign iobs_7_io_sram_dout = io_srams_0_7_dout; // @[MultiTileCGRA.scala 429:19]
  assign iobs_8_clock = clock;
  assign iobs_8_reset = reset;
  assign iobs_8_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1020:25]
  assign iobs_8_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1022:25]
  assign iobs_8_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1023:25]
  assign iobs_8_io_start = io_start_0 & io_iob_ens_0[8]; // @[MultiTileCGRA.scala 427:38]
  assign iobs_8_io_en = io_en_0 & io_iob_ens_0[8]; // @[MultiTileCGRA.scala 428:32]
  assign iobs_8_io_in_0 = gibs_28_io_ipinSE_0; // @[MultiTileCGRA.scala 478:16]
  assign iobs_8_io_in_1 = gibs_29_io_ipinSW_0; // @[MultiTileCGRA.scala 482:16]
  assign iobs_8_io_sram_dout = io_srams_0_8_dout; // @[MultiTileCGRA.scala 429:19]
  assign iobs_9_clock = clock;
  assign iobs_9_reset = reset;
  assign iobs_9_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1020:25]
  assign iobs_9_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1022:25]
  assign iobs_9_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1023:25]
  assign iobs_9_io_start = io_start_0 & io_iob_ens_0[9]; // @[MultiTileCGRA.scala 427:38]
  assign iobs_9_io_en = io_en_0 & io_iob_ens_0[9]; // @[MultiTileCGRA.scala 428:32]
  assign iobs_9_io_in_0 = gibs_29_io_ipinSE_0; // @[MultiTileCGRA.scala 502:16]
  assign iobs_9_io_sram_dout = io_srams_0_9_dout; // @[MultiTileCGRA.scala 429:19]
  assign pes_0_clock = clock;
  assign pes_0_reset = reset;
  assign pes_0_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_0_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_0_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_0_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_0_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_0_io_in_1 = gibs_1_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_0_io_in_3 = gibs_6_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_0_io_in_4 = gibs_0_io_ipinSE_1; // @[MultiTileCGRA.scala 551:40]
  assign pes_1_clock = clock;
  assign pes_1_reset = reset;
  assign pes_1_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_1_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_1_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_1_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_1_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_1_io_in_0 = gibs_1_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_1_io_in_1 = gibs_2_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_1_io_in_2 = gibs_6_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_1_io_in_3 = gibs_7_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_1_io_in_4 = gibs_1_io_ipinSE_1; // @[MultiTileCGRA.scala 551:40]
  assign pes_2_clock = clock;
  assign pes_2_reset = reset;
  assign pes_2_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_2_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_2_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_2_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_2_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_2_io_in_0 = gibs_2_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_2_io_in_1 = gibs_3_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_2_io_in_2 = gibs_7_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_2_io_in_3 = gibs_8_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_2_io_in_4 = gibs_2_io_ipinSE_1; // @[MultiTileCGRA.scala 551:40]
  assign pes_3_clock = clock;
  assign pes_3_reset = reset;
  assign pes_3_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_3_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_3_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_3_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_3_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_3_io_in_0 = gibs_3_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_3_io_in_1 = gibs_4_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_3_io_in_2 = gibs_8_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_3_io_in_3 = gibs_9_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_3_io_in_4 = gibs_3_io_ipinSE_1; // @[MultiTileCGRA.scala 551:40]
  assign pes_4_clock = clock;
  assign pes_4_reset = reset;
  assign pes_4_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_4_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_4_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_4_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_4_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_4_io_in_0 = gibs_4_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_4_io_in_2 = gibs_9_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_4_io_in_4 = gibs_4_io_ipinSE_1; // @[MultiTileCGRA.scala 551:40]
  assign pes_5_clock = clock;
  assign pes_5_reset = reset;
  assign pes_5_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_5_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_5_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_5_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_5_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_5_io_in_1 = gibs_6_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_5_io_in_3 = gibs_11_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_6_clock = clock;
  assign pes_6_reset = reset;
  assign pes_6_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_6_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_6_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_6_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_6_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_6_io_in_0 = gibs_6_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_6_io_in_1 = gibs_7_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_6_io_in_2 = gibs_11_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_6_io_in_3 = gibs_12_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_7_clock = clock;
  assign pes_7_reset = reset;
  assign pes_7_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_7_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_7_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_7_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_7_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_7_io_in_0 = gibs_7_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_7_io_in_1 = gibs_8_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_7_io_in_2 = gibs_12_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_7_io_in_3 = gibs_13_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_8_clock = clock;
  assign pes_8_reset = reset;
  assign pes_8_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_8_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_8_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_8_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_8_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_8_io_in_0 = gibs_8_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_8_io_in_1 = gibs_9_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_8_io_in_2 = gibs_13_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_8_io_in_3 = gibs_14_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_9_clock = clock;
  assign pes_9_reset = reset;
  assign pes_9_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_9_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_9_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_9_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_9_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_9_io_in_0 = gibs_9_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_9_io_in_2 = gibs_14_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_10_clock = clock;
  assign pes_10_reset = reset;
  assign pes_10_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_10_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_10_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_10_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_10_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_10_io_in_1 = gibs_11_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_10_io_in_3 = gibs_16_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_11_clock = clock;
  assign pes_11_reset = reset;
  assign pes_11_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_11_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_11_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_11_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_11_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_11_io_in_0 = gibs_11_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_11_io_in_1 = gibs_12_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_11_io_in_2 = gibs_16_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_11_io_in_3 = gibs_17_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_12_clock = clock;
  assign pes_12_reset = reset;
  assign pes_12_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_12_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_12_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_12_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_12_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_12_io_in_0 = gibs_12_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_12_io_in_1 = gibs_13_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_12_io_in_2 = gibs_17_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_12_io_in_3 = gibs_18_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_13_clock = clock;
  assign pes_13_reset = reset;
  assign pes_13_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_13_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_13_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_13_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_13_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_13_io_in_0 = gibs_13_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_13_io_in_1 = gibs_14_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_13_io_in_2 = gibs_18_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_13_io_in_3 = gibs_19_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_14_clock = clock;
  assign pes_14_reset = reset;
  assign pes_14_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_14_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_14_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_14_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_14_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_14_io_in_0 = gibs_14_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_14_io_in_2 = gibs_19_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_15_clock = clock;
  assign pes_15_reset = reset;
  assign pes_15_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_15_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_15_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_15_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_15_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_15_io_in_1 = gibs_16_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_15_io_in_3 = gibs_21_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_16_clock = clock;
  assign pes_16_reset = reset;
  assign pes_16_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_16_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_16_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_16_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_16_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_16_io_in_0 = gibs_16_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_16_io_in_1 = gibs_17_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_16_io_in_2 = gibs_21_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_16_io_in_3 = gibs_22_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_17_clock = clock;
  assign pes_17_reset = reset;
  assign pes_17_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_17_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_17_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_17_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_17_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_17_io_in_0 = gibs_17_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_17_io_in_1 = gibs_18_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_17_io_in_2 = gibs_22_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_17_io_in_3 = gibs_23_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_18_clock = clock;
  assign pes_18_reset = reset;
  assign pes_18_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_18_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_18_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_18_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_18_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_18_io_in_0 = gibs_18_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_18_io_in_1 = gibs_19_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_18_io_in_2 = gibs_23_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_18_io_in_3 = gibs_24_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_19_clock = clock;
  assign pes_19_reset = reset;
  assign pes_19_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_19_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_19_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_19_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_19_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_19_io_in_0 = gibs_19_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_19_io_in_2 = gibs_24_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_20_clock = clock;
  assign pes_20_reset = reset;
  assign pes_20_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_20_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_20_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_20_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_20_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_20_io_in_1 = gibs_21_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_20_io_in_3 = gibs_26_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_20_io_in_7 = gibs_26_io_ipinNW_1; // @[MultiTileCGRA.scala 579:40]
  assign pes_21_clock = clock;
  assign pes_21_reset = reset;
  assign pes_21_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_21_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_21_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_21_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_21_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_21_io_in_0 = gibs_21_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_21_io_in_1 = gibs_22_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_21_io_in_2 = gibs_26_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_21_io_in_3 = gibs_27_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_21_io_in_7 = gibs_27_io_ipinNW_1; // @[MultiTileCGRA.scala 579:40]
  assign pes_22_clock = clock;
  assign pes_22_reset = reset;
  assign pes_22_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_22_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_22_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_22_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_22_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_22_io_in_0 = gibs_22_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_22_io_in_1 = gibs_23_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_22_io_in_2 = gibs_27_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_22_io_in_3 = gibs_28_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_22_io_in_7 = gibs_28_io_ipinNW_1; // @[MultiTileCGRA.scala 579:40]
  assign pes_23_clock = clock;
  assign pes_23_reset = reset;
  assign pes_23_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_23_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_23_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_23_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_23_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_23_io_in_0 = gibs_23_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_23_io_in_1 = gibs_24_io_ipinSW_0; // @[MultiTileCGRA.scala 560:40]
  assign pes_23_io_in_2 = gibs_28_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_23_io_in_3 = gibs_29_io_ipinNW_0; // @[MultiTileCGRA.scala 579:40]
  assign pes_23_io_in_7 = gibs_29_io_ipinNW_1; // @[MultiTileCGRA.scala 579:40]
  assign pes_24_clock = clock;
  assign pes_24_reset = reset;
  assign pes_24_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1035:42]
  assign pes_24_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1037:42]
  assign pes_24_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1038:42]
  assign pes_24_io_start = io_start_0; // @[MultiTileCGRA.scala 540:29]
  assign pes_24_io_en = io_en_0; // @[MultiTileCGRA.scala 541:26]
  assign pes_24_io_in_0 = gibs_24_io_ipinSE_0; // @[MultiTileCGRA.scala 551:40]
  assign pes_24_io_in_2 = gibs_29_io_ipinNE_0; // @[MultiTileCGRA.scala 570:59]
  assign pes_24_io_in_7 = gibs_35_io_ipinNW_1; // @[MultiTileCGRA.scala 927:33]
  assign gibs_0_io_opinNE_0 = iobs_0_io_out_0; // @[MultiTileCGRA.scala 445:37]
  assign gibs_0_io_itrackE_0 = gibs_1_io_otrackW_0; // @[MultiTileCGRA.scala 666:18]
  assign gibs_0_io_itrackS_0 = gibs_5_io_otrackN_0; // @[MultiTileCGRA.scala 631:18]
  assign gibs_1_clock = clock;
  assign gibs_1_reset = reset;
  assign gibs_1_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_1_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_1_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_1_io_opinNW_0 = iobs_0_io_out_0; // @[MultiTileCGRA.scala 446:39]
  assign gibs_1_io_opinNE_0 = iobs_1_io_out_0; // @[MultiTileCGRA.scala 445:37]
  assign gibs_1_io_opinSE_0 = pes_1_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_1_io_itrackW_0 = gibs_0_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_1_io_itrackE_0 = gibs_2_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_1_io_itrackS_0 = gibs_6_io_otrackN_0; // @[MultiTileCGRA.scala 631:18]
  assign gibs_2_clock = clock;
  assign gibs_2_reset = reset;
  assign gibs_2_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_2_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_2_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_2_io_opinNW_0 = iobs_1_io_out_0; // @[MultiTileCGRA.scala 446:39]
  assign gibs_2_io_opinNE_0 = iobs_2_io_out_0; // @[MultiTileCGRA.scala 445:37]
  assign gibs_2_io_opinSE_0 = pes_2_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_2_io_itrackW_0 = gibs_1_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_2_io_itrackE_0 = gibs_3_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_2_io_itrackS_0 = gibs_7_io_otrackN_0; // @[MultiTileCGRA.scala 631:18]
  assign gibs_3_clock = clock;
  assign gibs_3_reset = reset;
  assign gibs_3_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_3_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_3_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_3_io_opinNW_0 = iobs_2_io_out_0; // @[MultiTileCGRA.scala 446:39]
  assign gibs_3_io_opinNE_0 = iobs_3_io_out_0; // @[MultiTileCGRA.scala 445:37]
  assign gibs_3_io_opinSE_0 = pes_3_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_3_io_itrackW_0 = gibs_2_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_3_io_itrackE_0 = gibs_4_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_3_io_itrackS_0 = gibs_8_io_otrackN_0; // @[MultiTileCGRA.scala 631:18]
  assign gibs_4_clock = clock;
  assign gibs_4_reset = reset;
  assign gibs_4_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_4_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_4_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_4_io_opinNW_0 = iobs_3_io_out_0; // @[MultiTileCGRA.scala 446:39]
  assign gibs_4_io_opinNE_0 = iobs_4_io_out_0; // @[MultiTileCGRA.scala 463:37]
  assign gibs_4_io_opinSE_0 = pes_4_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_4_io_itrackW_0 = gibs_3_io_otrackE_0; // @[MultiTileCGRA.scala 674:18]
  assign gibs_4_io_itrackE_0 = gibs_30_io_otrackW_0; // @[MultiTileCGRA.scala 963:16]
  assign gibs_4_io_itrackS_0 = gibs_9_io_otrackN_0; // @[MultiTileCGRA.scala 631:18]
  assign gibs_5_clock = clock;
  assign gibs_5_reset = reset;
  assign gibs_5_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_5_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_5_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_5_io_itrackN_0 = gibs_0_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_5_io_itrackE_0 = gibs_6_io_otrackW_0; // @[MultiTileCGRA.scala 666:18]
  assign gibs_5_io_itrackS_0 = gibs_10_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_6_clock = clock;
  assign gibs_6_reset = reset;
  assign gibs_6_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_6_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_6_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_6_io_opinNW_0 = pes_0_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_6_io_opinSE_0 = pes_6_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_6_io_itrackW_0 = gibs_5_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_6_io_itrackN_0 = gibs_1_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_6_io_itrackE_0 = gibs_7_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_6_io_itrackS_0 = gibs_11_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_7_clock = clock;
  assign gibs_7_reset = reset;
  assign gibs_7_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_7_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_7_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_7_io_opinNW_0 = pes_1_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_7_io_opinSE_0 = pes_7_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_7_io_itrackW_0 = gibs_6_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_7_io_itrackN_0 = gibs_2_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_7_io_itrackE_0 = gibs_8_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_7_io_itrackS_0 = gibs_12_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_8_clock = clock;
  assign gibs_8_reset = reset;
  assign gibs_8_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_8_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_8_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_8_io_opinNW_0 = pes_2_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_8_io_opinSE_0 = pes_8_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_8_io_itrackW_0 = gibs_7_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_8_io_itrackN_0 = gibs_3_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_8_io_itrackE_0 = gibs_9_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_8_io_itrackS_0 = gibs_13_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_9_clock = clock;
  assign gibs_9_reset = reset;
  assign gibs_9_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_9_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_9_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_9_io_opinNW_0 = pes_3_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_9_io_opinSE_0 = pes_9_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_9_io_itrackW_0 = gibs_8_io_otrackE_0; // @[MultiTileCGRA.scala 674:18]
  assign gibs_9_io_itrackN_0 = gibs_4_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_9_io_itrackE_0 = gibs_31_io_otrackW_0; // @[MultiTileCGRA.scala 963:16]
  assign gibs_9_io_itrackS_0 = gibs_14_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_10_clock = clock;
  assign gibs_10_reset = reset;
  assign gibs_10_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_10_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_10_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_10_io_itrackN_0 = gibs_5_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_10_io_itrackE_0 = gibs_11_io_otrackW_0; // @[MultiTileCGRA.scala 666:18]
  assign gibs_10_io_itrackS_0 = gibs_15_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_11_clock = clock;
  assign gibs_11_reset = reset;
  assign gibs_11_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_11_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_11_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_11_io_opinNW_0 = pes_5_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_11_io_opinSE_0 = pes_11_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_11_io_itrackW_0 = gibs_10_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_11_io_itrackN_0 = gibs_6_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_11_io_itrackE_0 = gibs_12_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_11_io_itrackS_0 = gibs_16_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_12_clock = clock;
  assign gibs_12_reset = reset;
  assign gibs_12_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_12_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_12_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_12_io_opinNW_0 = pes_6_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_12_io_opinSE_0 = pes_12_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_12_io_itrackW_0 = gibs_11_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_12_io_itrackN_0 = gibs_7_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_12_io_itrackE_0 = gibs_13_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_12_io_itrackS_0 = gibs_17_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_13_clock = clock;
  assign gibs_13_reset = reset;
  assign gibs_13_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_13_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_13_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_13_io_opinNW_0 = pes_7_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_13_io_opinSE_0 = pes_13_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_13_io_itrackW_0 = gibs_12_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_13_io_itrackN_0 = gibs_8_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_13_io_itrackE_0 = gibs_14_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_13_io_itrackS_0 = gibs_18_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_14_clock = clock;
  assign gibs_14_reset = reset;
  assign gibs_14_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_14_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_14_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_14_io_opinNW_0 = pes_8_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_14_io_opinSE_0 = pes_14_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_14_io_itrackW_0 = gibs_13_io_otrackE_0; // @[MultiTileCGRA.scala 674:18]
  assign gibs_14_io_itrackN_0 = gibs_9_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_14_io_itrackE_0 = gibs_32_io_otrackW_0; // @[MultiTileCGRA.scala 963:16]
  assign gibs_14_io_itrackS_0 = gibs_19_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_15_clock = clock;
  assign gibs_15_reset = reset;
  assign gibs_15_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_15_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_15_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_15_io_itrackN_0 = gibs_10_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_15_io_itrackE_0 = gibs_16_io_otrackW_0; // @[MultiTileCGRA.scala 666:18]
  assign gibs_15_io_itrackS_0 = gibs_20_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_16_clock = clock;
  assign gibs_16_reset = reset;
  assign gibs_16_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_16_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_16_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_16_io_opinNW_0 = pes_10_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_16_io_opinSE_0 = pes_16_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_16_io_itrackW_0 = gibs_15_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_16_io_itrackN_0 = gibs_11_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_16_io_itrackE_0 = gibs_17_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_16_io_itrackS_0 = gibs_21_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_17_clock = clock;
  assign gibs_17_reset = reset;
  assign gibs_17_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_17_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_17_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_17_io_opinNW_0 = pes_11_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_17_io_opinSE_0 = pes_17_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_17_io_itrackW_0 = gibs_16_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_17_io_itrackN_0 = gibs_12_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_17_io_itrackE_0 = gibs_18_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_17_io_itrackS_0 = gibs_22_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_18_clock = clock;
  assign gibs_18_reset = reset;
  assign gibs_18_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_18_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_18_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_18_io_opinNW_0 = pes_12_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_18_io_opinSE_0 = pes_18_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_18_io_itrackW_0 = gibs_17_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_18_io_itrackN_0 = gibs_13_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_18_io_itrackE_0 = gibs_19_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_18_io_itrackS_0 = gibs_23_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_19_clock = clock;
  assign gibs_19_reset = reset;
  assign gibs_19_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_19_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_19_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_19_io_opinNW_0 = pes_13_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_19_io_opinSE_0 = pes_19_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_19_io_itrackW_0 = gibs_18_io_otrackE_0; // @[MultiTileCGRA.scala 674:18]
  assign gibs_19_io_itrackN_0 = gibs_14_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_19_io_itrackE_0 = gibs_33_io_otrackW_0; // @[MultiTileCGRA.scala 963:16]
  assign gibs_19_io_itrackS_0 = gibs_24_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_20_clock = clock;
  assign gibs_20_reset = reset;
  assign gibs_20_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_20_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_20_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_20_io_itrackN_0 = gibs_15_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_20_io_itrackE_0 = gibs_21_io_otrackW_0; // @[MultiTileCGRA.scala 666:18]
  assign gibs_20_io_itrackS_0 = gibs_25_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_21_clock = clock;
  assign gibs_21_reset = reset;
  assign gibs_21_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_21_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_21_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_21_io_opinNW_0 = pes_15_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_21_io_opinSE_0 = pes_21_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_21_io_itrackW_0 = gibs_20_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_21_io_itrackN_0 = gibs_16_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_21_io_itrackE_0 = gibs_22_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_21_io_itrackS_0 = gibs_26_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_22_clock = clock;
  assign gibs_22_reset = reset;
  assign gibs_22_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_22_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_22_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_22_io_opinNW_0 = pes_16_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_22_io_opinSE_0 = pes_22_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_22_io_itrackW_0 = gibs_21_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_22_io_itrackN_0 = gibs_17_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_22_io_itrackE_0 = gibs_23_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_22_io_itrackS_0 = gibs_27_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_23_clock = clock;
  assign gibs_23_reset = reset;
  assign gibs_23_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_23_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_23_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_23_io_opinNW_0 = pes_17_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_23_io_opinSE_0 = pes_23_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_23_io_itrackW_0 = gibs_22_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_23_io_itrackN_0 = gibs_18_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_23_io_itrackE_0 = gibs_24_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_23_io_itrackS_0 = gibs_28_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_24_clock = clock;
  assign gibs_24_reset = reset;
  assign gibs_24_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_24_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_24_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_24_io_opinNW_0 = pes_18_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_24_io_opinSE_0 = pes_24_io_out_0; // @[MultiTileCGRA.scala 589:39]
  assign gibs_24_io_itrackW_0 = gibs_23_io_otrackE_0; // @[MultiTileCGRA.scala 674:18]
  assign gibs_24_io_itrackN_0 = gibs_19_io_otrackS_0; // @[MultiTileCGRA.scala 646:18]
  assign gibs_24_io_itrackE_0 = gibs_34_io_otrackW_0; // @[MultiTileCGRA.scala 963:16]
  assign gibs_24_io_itrackS_0 = gibs_29_io_otrackN_0; // @[MultiTileCGRA.scala 652:18]
  assign gibs_25_io_itrackN_0 = gibs_20_io_otrackS_0; // @[MultiTileCGRA.scala 639:18]
  assign gibs_25_io_itrackE_0 = gibs_26_io_otrackW_0; // @[MultiTileCGRA.scala 666:18]
  assign gibs_26_clock = clock;
  assign gibs_26_reset = reset;
  assign gibs_26_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_26_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_26_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_26_io_opinNW_0 = pes_20_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_26_io_opinSE_0 = iobs_6_io_out_0; // @[MultiTileCGRA.scala 488:37]
  assign gibs_26_io_opinSW_0 = iobs_5_io_out_0; // @[MultiTileCGRA.scala 489:41]
  assign gibs_26_io_itrackW_0 = gibs_25_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_26_io_itrackN_0 = gibs_21_io_otrackS_0; // @[MultiTileCGRA.scala 639:18]
  assign gibs_26_io_itrackE_0 = gibs_27_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_27_clock = clock;
  assign gibs_27_reset = reset;
  assign gibs_27_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_27_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_27_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_27_io_opinNW_0 = pes_21_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_27_io_opinSE_0 = iobs_7_io_out_0; // @[MultiTileCGRA.scala 488:37]
  assign gibs_27_io_opinSW_0 = iobs_6_io_out_0; // @[MultiTileCGRA.scala 489:41]
  assign gibs_27_io_itrackW_0 = gibs_26_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_27_io_itrackN_0 = gibs_22_io_otrackS_0; // @[MultiTileCGRA.scala 639:18]
  assign gibs_27_io_itrackE_0 = gibs_28_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_28_clock = clock;
  assign gibs_28_reset = reset;
  assign gibs_28_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_28_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_28_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_28_io_opinNW_0 = pes_22_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_28_io_opinSE_0 = iobs_8_io_out_0; // @[MultiTileCGRA.scala 488:37]
  assign gibs_28_io_opinSW_0 = iobs_7_io_out_0; // @[MultiTileCGRA.scala 489:41]
  assign gibs_28_io_itrackW_0 = gibs_27_io_otrackE_0; // @[MultiTileCGRA.scala 682:18]
  assign gibs_28_io_itrackN_0 = gibs_23_io_otrackS_0; // @[MultiTileCGRA.scala 639:18]
  assign gibs_28_io_itrackE_0 = gibs_29_io_otrackW_0; // @[MultiTileCGRA.scala 688:18]
  assign gibs_29_clock = clock;
  assign gibs_29_reset = reset;
  assign gibs_29_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1030:43]
  assign gibs_29_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1032:43]
  assign gibs_29_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1033:43]
  assign gibs_29_io_opinNW_0 = pes_23_io_out_0; // @[MultiTileCGRA.scala 604:39]
  assign gibs_29_io_opinSE_0 = iobs_9_io_out_0; // @[MultiTileCGRA.scala 513:37]
  assign gibs_29_io_opinSW_0 = iobs_8_io_out_0; // @[MultiTileCGRA.scala 489:41]
  assign gibs_29_io_itrackW_0 = gibs_28_io_otrackE_0; // @[MultiTileCGRA.scala 674:18]
  assign gibs_29_io_itrackN_0 = gibs_24_io_otrackS_0; // @[MultiTileCGRA.scala 639:18]
  assign gibs_29_io_itrackE_0 = gibs_35_io_otrackW_0; // @[MultiTileCGRA.scala 963:16]
  assign gibs_30_io_itrackW_0 = gibs_4_io_otrackE_0; // @[MultiTileCGRA.scala 956:16]
  assign gibs_30_io_itrackS_0 = gibs_31_io_otrackN_0; // @[MultiTileCGRA.scala 980:18]
  assign gibs_31_clock = clock;
  assign gibs_31_reset = reset;
  assign gibs_31_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1043:59]
  assign gibs_31_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1044:59]
  assign gibs_31_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1045:59]
  assign gibs_31_io_itrackW_0 = gibs_9_io_otrackE_0; // @[MultiTileCGRA.scala 956:16]
  assign gibs_31_io_itrackN_0 = gibs_30_io_otrackS_0; // @[MultiTileCGRA.scala 995:18]
  assign gibs_31_io_itrackS_0 = gibs_32_io_otrackN_0; // @[MultiTileCGRA.scala 1001:18]
  assign gibs_32_clock = clock;
  assign gibs_32_reset = reset;
  assign gibs_32_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1043:59]
  assign gibs_32_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1044:59]
  assign gibs_32_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1045:59]
  assign gibs_32_io_itrackW_0 = gibs_14_io_otrackE_0; // @[MultiTileCGRA.scala 956:16]
  assign gibs_32_io_itrackN_0 = gibs_31_io_otrackS_0; // @[MultiTileCGRA.scala 995:18]
  assign gibs_32_io_itrackS_0 = gibs_33_io_otrackN_0; // @[MultiTileCGRA.scala 1001:18]
  assign gibs_33_clock = clock;
  assign gibs_33_reset = reset;
  assign gibs_33_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1043:59]
  assign gibs_33_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1044:59]
  assign gibs_33_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1045:59]
  assign gibs_33_io_itrackW_0 = gibs_19_io_otrackE_0; // @[MultiTileCGRA.scala 956:16]
  assign gibs_33_io_itrackN_0 = gibs_32_io_otrackS_0; // @[MultiTileCGRA.scala 995:18]
  assign gibs_33_io_itrackS_0 = gibs_34_io_otrackN_0; // @[MultiTileCGRA.scala 1001:18]
  assign gibs_34_clock = clock;
  assign gibs_34_reset = reset;
  assign gibs_34_io_cfg_en = io_cfg_en_0; // @[MultiTileCGRA.scala 1043:59]
  assign gibs_34_io_cfg_addr = io_cfg_addr; // @[MultiTileCGRA.scala 1044:59]
  assign gibs_34_io_cfg_data = io_cfg_data; // @[MultiTileCGRA.scala 1045:59]
  assign gibs_34_io_itrackW_0 = gibs_24_io_otrackE_0; // @[MultiTileCGRA.scala 956:16]
  assign gibs_34_io_itrackN_0 = gibs_33_io_otrackS_0; // @[MultiTileCGRA.scala 995:18]
  assign gibs_34_io_itrackS_0 = gibs_35_io_otrackN_0; // @[MultiTileCGRA.scala 1001:18]
  assign gibs_35_io_opinSW_0 = iobs_9_io_out_0; // @[MultiTileCGRA.scala 892:40]
  assign gibs_35_io_itrackW_0 = gibs_29_io_otrackE_0; // @[MultiTileCGRA.scala 956:16]
  assign gibs_35_io_itrackN_0 = gibs_34_io_otrackS_0; // @[MultiTileCGRA.scala 988:18]
  always @(posedge clock) begin
    io_done_0_REG <= (iobs_0_io_done | ~io_iob_ens_0[0]) & (iobs_1_io_done | ~io_iob_ens_0[1]) & (iobs_2_io_done | ~
      io_iob_ens_0[2]) & (iobs_3_io_done | ~io_iob_ens_0[3]) & (iobs_4_io_done | ~io_iob_ens_0[4]) & (iobs_5_io_done | ~
      io_iob_ens_0[5]) & (iobs_6_io_done | ~io_iob_ens_0[6]) & (iobs_7_io_done | ~io_iob_ens_0[7]) & (iobs_8_io_done | ~
      io_iob_ens_0[8]) & (iobs_9_io_done | ~io_iob_ens_0[9]); // @[MultiTileCGRA.scala 528:112]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_done_0_REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ConfigController(
  input         clock,
  input         reset,
  input         io_start,
  output        io_done,
  input  [8:0]  io_base_addr,
  input  [11:0] io_cfg_num,
  output        io_sram_en,
  output [8:0]  io_sram_addr,
  input  [63:0] io_sram_dout,
  output        io_cfg_en,
  output [11:0] io_cfg_addr,
  output [31:0] io_cfg_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [191:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[ConfigController.scala 35:22]
  reg [11:0] cnt; // @[ConfigController.scala 36:20]
  reg [191:0] dataReg; // @[ConfigController.scala 38:24]
  reg [7:0] wOffset; // @[ConfigController.scala 39:24]
  reg [7:0] availOffset; // @[ConfigController.scala 40:28]
  wire  sramRen = availOffset <= 8'h80 & state == 2'h1; // @[ConfigController.scala 41:63]
  reg  wen; // @[Reg.scala 19:16]
  wire  ren = wOffset >= 8'h30 & cnt < io_cfg_num; // @[ConfigController.scala 43:37]
  reg [3:0] waitCnt; // @[ConfigController.scala 44:24]
  reg  done; // @[ConfigController.scala 45:21]
  wire [1:0] _GEN_4 = waitCnt >= 4'hc ? 2'h0 : state; // @[ConfigController.scala 61:35 62:15 35:22]
  wire  _GEN_5 = waitCnt >= 4'hc | done; // @[ConfigController.scala 61:35 63:14 45:21]
  wire  _T_5 = state == 2'h0; // @[ConfigController.scala 68:14]
  wire [11:0] _cnt_T_1 = cnt + 12'h1; // @[ConfigController.scala 71:16]
  wire [3:0] _waitCnt_T_1 = waitCnt + 4'h1; // @[ConfigController.scala 77:24]
  wire [7:0] _availOffset_T_1 = availOffset + 8'h40; // @[ConfigController.scala 83:32]
  wire [7:0] _availOffset_T_3 = _availOffset_T_1 - 8'h30; // @[ConfigController.scala 83:50]
  wire [7:0] _availOffset_T_7 = availOffset - 8'h30; // @[ConfigController.scala 87:32]
  wire [7:0] _GEN_16 = ren ? _availOffset_T_7 : availOffset; // @[ConfigController.scala 86:18 87:17 40:28]
  wire [7:0] _wOffset_T_1 = wOffset + 8'h40; // @[ConfigController.scala 94:24]
  wire [7:0] _wOffset_T_3 = _wOffset_T_1 - 8'h30; // @[ConfigController.scala 94:42]
  wire [7:0] _dataReg_T_1 = 8'hc0 - wOffset; // @[ConfigController.scala 95:41]
  wire [446:0] _GEN_0 = {{255'd0}, dataReg}; // @[ConfigController.scala 95:26]
  wire [446:0] _dataReg_T_2 = _GEN_0 << _dataReg_T_1; // @[ConfigController.scala 95:26]
  wire [7:0] _dataReg_T_6 = 8'hf0 - wOffset; // @[ConfigController.scala 95:81]
  wire [446:0] _dataReg_T_7 = _dataReg_T_2 >> _dataReg_T_6; // @[ConfigController.scala 95:53]
  wire [7:0] _dataReg_T_9 = wOffset - 8'h30; // @[ConfigController.scala 96:43]
  wire [318:0] _GEN_34 = {{255'd0}, io_sram_dout}; // @[ConfigController.scala 96:31]
  wire [318:0] _dataReg_T_10 = _GEN_34 << _dataReg_T_9; // @[ConfigController.scala 96:31]
  wire [446:0] _GEN_30 = {{128'd0}, _dataReg_T_10}; // @[ConfigController.scala 95:100]
  wire [446:0] _dataReg_T_11 = _dataReg_T_7 | _GEN_30; // @[ConfigController.scala 95:100]
  wire [446:0] _dataReg_T_17 = _dataReg_T_2 >> _dataReg_T_1; // @[ConfigController.scala 99:53]
  wire [318:0] _GEN_35 = {{255'd0}, io_sram_dout}; // @[ConfigController.scala 100:21]
  wire [318:0] _dataReg_T_18 = _GEN_35 << wOffset; // @[ConfigController.scala 100:21]
  wire [446:0] _GEN_31 = {{128'd0}, _dataReg_T_18}; // @[ConfigController.scala 99:87]
  wire [446:0] _dataReg_T_19 = _dataReg_T_17 | _GEN_31; // @[ConfigController.scala 99:87]
  wire [191:0] _dataReg_T_20 = {{48'd0}, dataReg[191:48]}; // @[ConfigController.scala 103:25]
  wire [7:0] _GEN_20 = ren ? _dataReg_T_9 : wOffset; // @[ConfigController.scala 101:18 102:13 39:24]
  wire [191:0] _GEN_21 = ren ? _dataReg_T_20 : dataReg; // @[ConfigController.scala 101:18 103:13 38:24]
  wire [446:0] _GEN_23 = wen ? _dataReg_T_19 : {{255'd0}, _GEN_21}; // @[ConfigController.scala 97:18 99:13]
  wire [446:0] _GEN_25 = wen & ren ? _dataReg_T_11 : _GEN_23; // @[ConfigController.scala 93:25 95:13]
  wire [446:0] _GEN_27 = _T_5 ? 447'h0 : _GEN_25; // @[ConfigController.scala 90:25 92:13]
  reg [8:0] addrSram; // @[ConfigController.scala 106:25]
  wire [8:0] _addrSram_T_1 = addrSram + 9'h1; // @[ConfigController.scala 110:26]
  wire [446:0] _GEN_33 = reset ? 447'h0 : _GEN_27; // @[ConfigController.scala 38:{24,24}]
  assign io_done = done; // @[ConfigController.scala 46:11]
  assign io_sram_en = availOffset <= 8'h80 & state == 2'h1; // @[ConfigController.scala 41:63]
  assign io_sram_addr = addrSram; // @[ConfigController.scala 114:16]
  assign io_cfg_en = wOffset >= 8'h30 & cnt < io_cfg_num; // @[ConfigController.scala 43:37]
  assign io_cfg_addr = dataReg[43:32]; // @[ConfigController.scala 117:15]
  assign io_cfg_data = dataReg[31:0]; // @[ConfigController.scala 118:25]
  always @(posedge clock) begin
    if (reset) begin // @[ConfigController.scala 35:22]
      state <= 2'h0; // @[ConfigController.scala 35:22]
    end else if (2'h0 == state) begin // @[ConfigController.scala 48:16]
      if (io_start) begin // @[ConfigController.scala 50:21]
        state <= 2'h1; // @[ConfigController.scala 51:15]
      end
    end else if (2'h1 == state) begin // @[ConfigController.scala 48:16]
      if (cnt >= io_cfg_num) begin // @[ConfigController.scala 56:30]
        state <= 2'h2; // @[ConfigController.scala 57:15]
      end
    end else if (2'h2 == state) begin // @[ConfigController.scala 48:16]
      state <= _GEN_4;
    end
    if (reset) begin // @[ConfigController.scala 36:20]
      cnt <= 12'h0; // @[ConfigController.scala 36:20]
    end else if (state == 2'h0) begin // @[ConfigController.scala 68:25]
      cnt <= 12'h0; // @[ConfigController.scala 69:9]
    end else if (ren) begin // @[ConfigController.scala 70:18]
      cnt <= _cnt_T_1; // @[ConfigController.scala 71:9]
    end
    dataReg <= _GEN_33[191:0]; // @[ConfigController.scala 38:{24,24}]
    if (reset) begin // @[ConfigController.scala 39:24]
      wOffset <= 8'h0; // @[ConfigController.scala 39:24]
    end else if (_T_5) begin // @[ConfigController.scala 90:25]
      wOffset <= 8'h0; // @[ConfigController.scala 91:13]
    end else if (wen & ren) begin // @[ConfigController.scala 93:25]
      wOffset <= _wOffset_T_3; // @[ConfigController.scala 94:13]
    end else if (wen) begin // @[ConfigController.scala 97:18]
      wOffset <= _wOffset_T_1; // @[ConfigController.scala 98:13]
    end else begin
      wOffset <= _GEN_20;
    end
    if (reset) begin // @[ConfigController.scala 40:28]
      availOffset <= 8'h0; // @[ConfigController.scala 40:28]
    end else if (_T_5) begin // @[ConfigController.scala 80:25]
      availOffset <= 8'h0; // @[ConfigController.scala 81:17]
    end else if (sramRen & ren) begin // @[ConfigController.scala 82:29]
      availOffset <= _availOffset_T_3; // @[ConfigController.scala 83:17]
    end else if (sramRen) begin // @[ConfigController.scala 84:22]
      availOffset <= _availOffset_T_1; // @[ConfigController.scala 85:17]
    end else begin
      availOffset <= _GEN_16;
    end
    wen <= availOffset <= 8'h80 & state == 2'h1; // @[ConfigController.scala 41:63]
    if (reset) begin // @[ConfigController.scala 44:24]
      waitCnt <= 4'h0; // @[ConfigController.scala 44:24]
    end else if (_T_5) begin // @[ConfigController.scala 74:25]
      waitCnt <= 4'h0; // @[ConfigController.scala 75:13]
    end else if (state == 2'h2) begin // @[ConfigController.scala 76:31]
      waitCnt <= _waitCnt_T_1; // @[ConfigController.scala 77:13]
    end
    if (reset) begin // @[ConfigController.scala 45:21]
      done <= 1'h0; // @[ConfigController.scala 45:21]
    end else if (2'h0 == state) begin // @[ConfigController.scala 48:16]
      if (io_start) begin // @[ConfigController.scala 50:21]
        done <= 1'h0; // @[ConfigController.scala 52:14]
      end
    end else if (!(2'h1 == state)) begin // @[ConfigController.scala 48:16]
      if (2'h2 == state) begin // @[ConfigController.scala 48:16]
        done <= _GEN_5;
      end
    end
    if (reset) begin // @[ConfigController.scala 106:25]
      addrSram <= 9'h0; // @[ConfigController.scala 106:25]
    end else if (_T_5) begin // @[ConfigController.scala 107:25]
      addrSram <= io_base_addr; // @[ConfigController.scala 108:14]
    end else if (sramRen) begin // @[ConfigController.scala 109:22]
      addrSram <= _addrSram_T_1; // @[ConfigController.scala 110:14]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  cnt = _RAND_1[11:0];
  _RAND_2 = {6{`RANDOM}};
  dataReg = _RAND_2[191:0];
  _RAND_3 = {1{`RANDOM}};
  wOffset = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  availOffset = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  wen = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  waitCnt = _RAND_6[3:0];
  _RAND_7 = {1{`RANDOM}};
  done = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  addrSram = _RAND_8[8:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SRAMBanksCoalesce(
  input         clock,
  output        io_orig_0_en,
  output        io_orig_0_we,
  output [11:0] io_orig_0_addr,
  output [15:0] io_orig_0_din,
  input  [15:0] io_orig_0_dout,
  output        io_orig_1_en,
  output        io_orig_1_we,
  output [11:0] io_orig_1_addr,
  output [15:0] io_orig_1_din,
  input  [15:0] io_orig_1_dout,
  output        io_orig_2_en,
  output        io_orig_2_we,
  output [11:0] io_orig_2_addr,
  output [15:0] io_orig_2_din,
  input  [15:0] io_orig_2_dout,
  output        io_orig_3_en,
  output        io_orig_3_we,
  output [11:0] io_orig_3_addr,
  output [15:0] io_orig_3_din,
  input  [15:0] io_orig_3_dout,
  output        io_orig_4_en,
  output        io_orig_4_we,
  output [11:0] io_orig_4_addr,
  output [15:0] io_orig_4_din,
  input  [15:0] io_orig_4_dout,
  output        io_orig_5_en,
  output        io_orig_5_we,
  output [11:0] io_orig_5_addr,
  output [15:0] io_orig_5_din,
  input  [15:0] io_orig_5_dout,
  output        io_orig_6_en,
  output        io_orig_6_we,
  output [11:0] io_orig_6_addr,
  output [15:0] io_orig_6_din,
  input  [15:0] io_orig_6_dout,
  output        io_orig_7_en,
  output        io_orig_7_we,
  output [11:0] io_orig_7_addr,
  output [15:0] io_orig_7_din,
  input  [15:0] io_orig_7_dout,
  output        io_orig_8_en,
  output        io_orig_8_we,
  output [11:0] io_orig_8_addr,
  output [15:0] io_orig_8_din,
  input  [15:0] io_orig_8_dout,
  output        io_orig_9_en,
  output        io_orig_9_we,
  output [11:0] io_orig_9_addr,
  output [15:0] io_orig_9_din,
  input  [15:0] io_orig_9_dout,
  input         io_coal_0_en,
  input         io_coal_0_we,
  input  [15:0] io_coal_0_addr,
  input  [15:0] io_coal_0_din,
  output [15:0] io_coal_0_dout,
  input         io_coal_1_en,
  input         io_coal_1_we,
  input  [15:0] io_coal_1_addr,
  input  [15:0] io_coal_1_din,
  output [15:0] io_coal_1_dout,
  input         io_coal_2_en,
  input         io_coal_2_we,
  input  [15:0] io_coal_2_addr,
  input  [15:0] io_coal_2_din,
  output [15:0] io_coal_2_dout,
  input         io_coal_3_en,
  input         io_coal_3_we,
  input  [15:0] io_coal_3_addr,
  input  [15:0] io_coal_3_din,
  output [15:0] io_coal_3_dout,
  input         io_coal_4_en,
  input         io_coal_4_we,
  input  [15:0] io_coal_4_addr,
  input  [15:0] io_coal_4_din,
  output [15:0] io_coal_4_dout,
  input         io_coal_5_en,
  input         io_coal_5_we,
  input  [15:0] io_coal_5_addr,
  input  [15:0] io_coal_5_din,
  output [15:0] io_coal_5_dout,
  input         io_coal_6_en,
  input         io_coal_6_we,
  input  [15:0] io_coal_6_addr,
  input  [15:0] io_coal_6_din,
  output [15:0] io_coal_6_dout,
  input         io_coal_7_en,
  input         io_coal_7_we,
  input  [15:0] io_coal_7_addr,
  input  [15:0] io_coal_7_din,
  output [15:0] io_coal_7_dout,
  input         io_coal_8_en,
  input         io_coal_8_we,
  input  [15:0] io_coal_8_addr,
  input  [15:0] io_coal_8_din,
  output [15:0] io_coal_8_dout,
  input         io_coal_9_en,
  input         io_coal_9_we,
  input  [15:0] io_coal_9_addr,
  input  [15:0] io_coal_9_din,
  output [15:0] io_coal_9_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
`endif // RANDOMIZE_REG_INIT
  wire  _inSel_T_1 = io_coal_0_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_0 = io_coal_0_en & io_coal_0_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_3 = io_coal_1_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_1 = io_coal_1_en & io_coal_1_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_5 = io_coal_2_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_2 = io_coal_2_en & io_coal_2_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_7 = io_coal_3_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_3 = io_coal_3_en & io_coal_3_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_9 = io_coal_4_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_4 = io_coal_4_en & io_coal_4_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_11 = io_coal_5_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_5 = io_coal_5_en & io_coal_5_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_13 = io_coal_6_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_6 = io_coal_6_en & io_coal_6_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_15 = io_coal_7_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_7 = io_coal_7_en & io_coal_7_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_17 = io_coal_8_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_8 = io_coal_8_en & io_coal_8_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_19 = io_coal_9_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_9 = io_coal_9_en & io_coal_9_addr[15:12] == 4'h0; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _io_orig_0_en_T_1 = inSel_8 ? io_coal_8_en : inSel_9 & io_coal_9_en; // @[Mux.scala 101:16]
  wire  _io_orig_0_en_T_2 = inSel_7 ? io_coal_7_en : _io_orig_0_en_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_0_en_T_3 = inSel_6 ? io_coal_6_en : _io_orig_0_en_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_0_en_T_4 = inSel_5 ? io_coal_5_en : _io_orig_0_en_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_0_en_T_5 = inSel_4 ? io_coal_4_en : _io_orig_0_en_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_0_en_T_6 = inSel_3 ? io_coal_3_en : _io_orig_0_en_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_0_en_T_7 = inSel_2 ? io_coal_2_en : _io_orig_0_en_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_0_en_T_8 = inSel_1 ? io_coal_1_en : _io_orig_0_en_T_7; // @[Mux.scala 101:16]
  wire  _io_orig_0_we_T_1 = inSel_8 ? io_coal_8_we : inSel_9 & io_coal_9_we; // @[Mux.scala 101:16]
  wire  _io_orig_0_we_T_2 = inSel_7 ? io_coal_7_we : _io_orig_0_we_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_0_we_T_3 = inSel_6 ? io_coal_6_we : _io_orig_0_we_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_0_we_T_4 = inSel_5 ? io_coal_5_we : _io_orig_0_we_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_0_we_T_5 = inSel_4 ? io_coal_4_we : _io_orig_0_we_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_0_we_T_6 = inSel_3 ? io_coal_3_we : _io_orig_0_we_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_0_we_T_7 = inSel_2 ? io_coal_2_we : _io_orig_0_we_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_0_we_T_8 = inSel_1 ? io_coal_1_we : _io_orig_0_we_T_7; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_0_addr_T_10 = inSel_9 ? io_coal_9_addr[11:0] : 12'h0; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_0_addr_T_11 = inSel_8 ? io_coal_8_addr[11:0] : _io_orig_0_addr_T_10; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_0_addr_T_12 = inSel_7 ? io_coal_7_addr[11:0] : _io_orig_0_addr_T_11; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_0_addr_T_13 = inSel_6 ? io_coal_6_addr[11:0] : _io_orig_0_addr_T_12; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_0_addr_T_14 = inSel_5 ? io_coal_5_addr[11:0] : _io_orig_0_addr_T_13; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_0_addr_T_15 = inSel_4 ? io_coal_4_addr[11:0] : _io_orig_0_addr_T_14; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_0_addr_T_16 = inSel_3 ? io_coal_3_addr[11:0] : _io_orig_0_addr_T_15; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_0_addr_T_17 = inSel_2 ? io_coal_2_addr[11:0] : _io_orig_0_addr_T_16; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_0_addr_T_18 = inSel_1 ? io_coal_1_addr[11:0] : _io_orig_0_addr_T_17; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_0_din_T = inSel_9 ? io_coal_9_din : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_0_din_T_1 = inSel_8 ? io_coal_8_din : _io_orig_0_din_T; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_0_din_T_2 = inSel_7 ? io_coal_7_din : _io_orig_0_din_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_0_din_T_3 = inSel_6 ? io_coal_6_din : _io_orig_0_din_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_0_din_T_4 = inSel_5 ? io_coal_5_din : _io_orig_0_din_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_0_din_T_5 = inSel_4 ? io_coal_4_din : _io_orig_0_din_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_0_din_T_6 = inSel_3 ? io_coal_3_din : _io_orig_0_din_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_0_din_T_7 = inSel_2 ? io_coal_2_din : _io_orig_0_din_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_0_din_T_8 = inSel_1 ? io_coal_1_din : _io_orig_0_din_T_7; // @[Mux.scala 101:16]
  reg  outSel_0; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_5 = io_coal_0_en & io_coal_0_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_1; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_8 = io_coal_0_en & io_coal_0_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_2; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_11 = io_coal_0_en & io_coal_0_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_3; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_14 = io_coal_0_en & io_coal_0_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_4; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_17 = io_coal_0_en & io_coal_0_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_5; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_20 = io_coal_0_en & io_coal_0_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_6; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_23 = io_coal_0_en & io_coal_0_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_7; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_26 = io_coal_0_en & io_coal_0_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_8; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_29 = io_coal_0_en & io_coal_0_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_9; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire [15:0] _io_coal_0_dout_T = outSel_9 ? io_orig_9_dout : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_0_dout_T_1 = outSel_8 ? io_orig_8_dout : _io_coal_0_dout_T; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_0_dout_T_2 = outSel_7 ? io_orig_7_dout : _io_coal_0_dout_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_0_dout_T_3 = outSel_6 ? io_orig_6_dout : _io_coal_0_dout_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_0_dout_T_4 = outSel_5 ? io_orig_5_dout : _io_coal_0_dout_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_0_dout_T_5 = outSel_4 ? io_orig_4_dout : _io_coal_0_dout_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_0_dout_T_6 = outSel_3 ? io_orig_3_dout : _io_coal_0_dout_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_0_dout_T_7 = outSel_2 ? io_orig_2_dout : _io_coal_0_dout_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_0_dout_T_8 = outSel_1 ? io_orig_1_dout : _io_coal_0_dout_T_7; // @[Mux.scala 101:16]
  wire  _inSel_T_23 = io_coal_1_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_1_1 = io_coal_1_en & io_coal_1_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_25 = io_coal_2_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_2_1 = io_coal_2_en & io_coal_2_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_27 = io_coal_3_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_3_1 = io_coal_3_en & io_coal_3_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_29 = io_coal_4_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_4_1 = io_coal_4_en & io_coal_4_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_31 = io_coal_5_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_5_1 = io_coal_5_en & io_coal_5_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_33 = io_coal_6_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_6_1 = io_coal_6_en & io_coal_6_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_35 = io_coal_7_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_7_1 = io_coal_7_en & io_coal_7_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_37 = io_coal_8_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_8_1 = io_coal_8_en & io_coal_8_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_39 = io_coal_9_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_9_1 = io_coal_9_en & io_coal_9_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _io_orig_1_en_T_1 = inSel_8_1 ? io_coal_8_en : inSel_9_1 & io_coal_9_en; // @[Mux.scala 101:16]
  wire  _io_orig_1_en_T_2 = inSel_7_1 ? io_coal_7_en : _io_orig_1_en_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_1_en_T_3 = inSel_6_1 ? io_coal_6_en : _io_orig_1_en_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_1_en_T_4 = inSel_5_1 ? io_coal_5_en : _io_orig_1_en_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_1_en_T_5 = inSel_4_1 ? io_coal_4_en : _io_orig_1_en_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_1_en_T_6 = inSel_3_1 ? io_coal_3_en : _io_orig_1_en_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_1_en_T_7 = inSel_2_1 ? io_coal_2_en : _io_orig_1_en_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_1_en_T_8 = inSel_1_1 ? io_coal_1_en : _io_orig_1_en_T_7; // @[Mux.scala 101:16]
  wire  _io_orig_1_we_T_1 = inSel_8_1 ? io_coal_8_we : inSel_9_1 & io_coal_9_we; // @[Mux.scala 101:16]
  wire  _io_orig_1_we_T_2 = inSel_7_1 ? io_coal_7_we : _io_orig_1_we_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_1_we_T_3 = inSel_6_1 ? io_coal_6_we : _io_orig_1_we_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_1_we_T_4 = inSel_5_1 ? io_coal_5_we : _io_orig_1_we_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_1_we_T_5 = inSel_4_1 ? io_coal_4_we : _io_orig_1_we_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_1_we_T_6 = inSel_3_1 ? io_coal_3_we : _io_orig_1_we_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_1_we_T_7 = inSel_2_1 ? io_coal_2_we : _io_orig_1_we_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_1_we_T_8 = inSel_1_1 ? io_coal_1_we : _io_orig_1_we_T_7; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_1_addr_T_10 = inSel_9_1 ? io_coal_9_addr[11:0] : 12'h0; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_1_addr_T_11 = inSel_8_1 ? io_coal_8_addr[11:0] : _io_orig_1_addr_T_10; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_1_addr_T_12 = inSel_7_1 ? io_coal_7_addr[11:0] : _io_orig_1_addr_T_11; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_1_addr_T_13 = inSel_6_1 ? io_coal_6_addr[11:0] : _io_orig_1_addr_T_12; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_1_addr_T_14 = inSel_5_1 ? io_coal_5_addr[11:0] : _io_orig_1_addr_T_13; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_1_addr_T_15 = inSel_4_1 ? io_coal_4_addr[11:0] : _io_orig_1_addr_T_14; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_1_addr_T_16 = inSel_3_1 ? io_coal_3_addr[11:0] : _io_orig_1_addr_T_15; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_1_addr_T_17 = inSel_2_1 ? io_coal_2_addr[11:0] : _io_orig_1_addr_T_16; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_1_addr_T_18 = inSel_1_1 ? io_coal_1_addr[11:0] : _io_orig_1_addr_T_17; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_1_din_T = inSel_9_1 ? io_coal_9_din : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_1_din_T_1 = inSel_8_1 ? io_coal_8_din : _io_orig_1_din_T; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_1_din_T_2 = inSel_7_1 ? io_coal_7_din : _io_orig_1_din_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_1_din_T_3 = inSel_6_1 ? io_coal_6_din : _io_orig_1_din_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_1_din_T_4 = inSel_5_1 ? io_coal_5_din : _io_orig_1_din_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_1_din_T_5 = inSel_4_1 ? io_coal_4_din : _io_orig_1_din_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_1_din_T_6 = inSel_3_1 ? io_coal_3_din : _io_orig_1_din_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_1_din_T_7 = inSel_2_1 ? io_coal_2_din : _io_orig_1_din_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_1_din_T_8 = inSel_1_1 ? io_coal_1_din : _io_orig_1_din_T_7; // @[Mux.scala 101:16]
  reg  outSel_0_1; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_1_1; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_38 = io_coal_1_en & io_coal_1_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_2_1; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_41 = io_coal_1_en & io_coal_1_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_3_1; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_44 = io_coal_1_en & io_coal_1_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_4_1; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_47 = io_coal_1_en & io_coal_1_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_5_1; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_50 = io_coal_1_en & io_coal_1_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_6_1; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_53 = io_coal_1_en & io_coal_1_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_7_1; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_56 = io_coal_1_en & io_coal_1_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_8_1; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_59 = io_coal_1_en & io_coal_1_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_9_1; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire [15:0] _io_coal_1_dout_T = outSel_9_1 ? io_orig_9_dout : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_1_dout_T_1 = outSel_8_1 ? io_orig_8_dout : _io_coal_1_dout_T; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_1_dout_T_2 = outSel_7_1 ? io_orig_7_dout : _io_coal_1_dout_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_1_dout_T_3 = outSel_6_1 ? io_orig_6_dout : _io_coal_1_dout_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_1_dout_T_4 = outSel_5_1 ? io_orig_5_dout : _io_coal_1_dout_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_1_dout_T_5 = outSel_4_1 ? io_orig_4_dout : _io_coal_1_dout_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_1_dout_T_6 = outSel_3_1 ? io_orig_3_dout : _io_coal_1_dout_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_1_dout_T_7 = outSel_2_1 ? io_orig_2_dout : _io_coal_1_dout_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_1_dout_T_8 = outSel_1_1 ? io_orig_1_dout : _io_coal_1_dout_T_7; // @[Mux.scala 101:16]
  wire  _inSel_T_45 = io_coal_2_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_2_2 = io_coal_2_en & io_coal_2_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_47 = io_coal_3_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_3_2 = io_coal_3_en & io_coal_3_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_49 = io_coal_4_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_4_2 = io_coal_4_en & io_coal_4_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_51 = io_coal_5_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_5_2 = io_coal_5_en & io_coal_5_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_53 = io_coal_6_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_6_2 = io_coal_6_en & io_coal_6_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_55 = io_coal_7_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_7_2 = io_coal_7_en & io_coal_7_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_57 = io_coal_8_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_8_2 = io_coal_8_en & io_coal_8_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_59 = io_coal_9_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_9_2 = io_coal_9_en & io_coal_9_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _io_orig_2_en_T_1 = inSel_8_2 ? io_coal_8_en : inSel_9_2 & io_coal_9_en; // @[Mux.scala 101:16]
  wire  _io_orig_2_en_T_2 = inSel_7_2 ? io_coal_7_en : _io_orig_2_en_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_2_en_T_3 = inSel_6_2 ? io_coal_6_en : _io_orig_2_en_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_2_en_T_4 = inSel_5_2 ? io_coal_5_en : _io_orig_2_en_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_2_en_T_5 = inSel_4_2 ? io_coal_4_en : _io_orig_2_en_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_2_en_T_6 = inSel_3_2 ? io_coal_3_en : _io_orig_2_en_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_2_en_T_7 = inSel_2_2 ? io_coal_2_en : _io_orig_2_en_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_2_en_T_8 = _outSel_T_38 ? io_coal_1_en : _io_orig_2_en_T_7; // @[Mux.scala 101:16]
  wire  _io_orig_2_we_T_1 = inSel_8_2 ? io_coal_8_we : inSel_9_2 & io_coal_9_we; // @[Mux.scala 101:16]
  wire  _io_orig_2_we_T_2 = inSel_7_2 ? io_coal_7_we : _io_orig_2_we_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_2_we_T_3 = inSel_6_2 ? io_coal_6_we : _io_orig_2_we_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_2_we_T_4 = inSel_5_2 ? io_coal_5_we : _io_orig_2_we_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_2_we_T_5 = inSel_4_2 ? io_coal_4_we : _io_orig_2_we_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_2_we_T_6 = inSel_3_2 ? io_coal_3_we : _io_orig_2_we_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_2_we_T_7 = inSel_2_2 ? io_coal_2_we : _io_orig_2_we_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_2_we_T_8 = _outSel_T_38 ? io_coal_1_we : _io_orig_2_we_T_7; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_2_addr_T_10 = inSel_9_2 ? io_coal_9_addr[11:0] : 12'h0; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_2_addr_T_11 = inSel_8_2 ? io_coal_8_addr[11:0] : _io_orig_2_addr_T_10; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_2_addr_T_12 = inSel_7_2 ? io_coal_7_addr[11:0] : _io_orig_2_addr_T_11; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_2_addr_T_13 = inSel_6_2 ? io_coal_6_addr[11:0] : _io_orig_2_addr_T_12; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_2_addr_T_14 = inSel_5_2 ? io_coal_5_addr[11:0] : _io_orig_2_addr_T_13; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_2_addr_T_15 = inSel_4_2 ? io_coal_4_addr[11:0] : _io_orig_2_addr_T_14; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_2_addr_T_16 = inSel_3_2 ? io_coal_3_addr[11:0] : _io_orig_2_addr_T_15; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_2_addr_T_17 = inSel_2_2 ? io_coal_2_addr[11:0] : _io_orig_2_addr_T_16; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_2_addr_T_18 = _outSel_T_38 ? io_coal_1_addr[11:0] : _io_orig_2_addr_T_17; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_2_din_T = inSel_9_2 ? io_coal_9_din : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_2_din_T_1 = inSel_8_2 ? io_coal_8_din : _io_orig_2_din_T; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_2_din_T_2 = inSel_7_2 ? io_coal_7_din : _io_orig_2_din_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_2_din_T_3 = inSel_6_2 ? io_coal_6_din : _io_orig_2_din_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_2_din_T_4 = inSel_5_2 ? io_coal_5_din : _io_orig_2_din_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_2_din_T_5 = inSel_4_2 ? io_coal_4_din : _io_orig_2_din_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_2_din_T_6 = inSel_3_2 ? io_coal_3_din : _io_orig_2_din_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_2_din_T_7 = inSel_2_2 ? io_coal_2_din : _io_orig_2_din_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_2_din_T_8 = _outSel_T_38 ? io_coal_1_din : _io_orig_2_din_T_7; // @[Mux.scala 101:16]
  reg  outSel_0_2; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_1_2; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_2_2; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_71 = io_coal_2_en & io_coal_2_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_3_2; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_74 = io_coal_2_en & io_coal_2_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_4_2; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_77 = io_coal_2_en & io_coal_2_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_5_2; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_80 = io_coal_2_en & io_coal_2_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_6_2; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_83 = io_coal_2_en & io_coal_2_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_7_2; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_86 = io_coal_2_en & io_coal_2_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_8_2; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_89 = io_coal_2_en & io_coal_2_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_9_2; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire [15:0] _io_coal_2_dout_T = outSel_9_2 ? io_orig_9_dout : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_2_dout_T_1 = outSel_8_2 ? io_orig_8_dout : _io_coal_2_dout_T; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_2_dout_T_2 = outSel_7_2 ? io_orig_7_dout : _io_coal_2_dout_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_2_dout_T_3 = outSel_6_2 ? io_orig_6_dout : _io_coal_2_dout_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_2_dout_T_4 = outSel_5_2 ? io_orig_5_dout : _io_coal_2_dout_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_2_dout_T_5 = outSel_4_2 ? io_orig_4_dout : _io_coal_2_dout_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_2_dout_T_6 = outSel_3_2 ? io_orig_3_dout : _io_coal_2_dout_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_2_dout_T_7 = outSel_2_2 ? io_orig_2_dout : _io_coal_2_dout_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_2_dout_T_8 = outSel_1_2 ? io_orig_1_dout : _io_coal_2_dout_T_7; // @[Mux.scala 101:16]
  wire  _inSel_T_67 = io_coal_3_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_3_3 = io_coal_3_en & io_coal_3_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_69 = io_coal_4_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_4_3 = io_coal_4_en & io_coal_4_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_71 = io_coal_5_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_5_3 = io_coal_5_en & io_coal_5_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_73 = io_coal_6_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_6_3 = io_coal_6_en & io_coal_6_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_75 = io_coal_7_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_7_3 = io_coal_7_en & io_coal_7_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_77 = io_coal_8_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_8_3 = io_coal_8_en & io_coal_8_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_79 = io_coal_9_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_9_3 = io_coal_9_en & io_coal_9_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _io_orig_3_en_T_1 = inSel_8_3 ? io_coal_8_en : inSel_9_3 & io_coal_9_en; // @[Mux.scala 101:16]
  wire  _io_orig_3_en_T_2 = inSel_7_3 ? io_coal_7_en : _io_orig_3_en_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_3_en_T_3 = inSel_6_3 ? io_coal_6_en : _io_orig_3_en_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_3_en_T_4 = inSel_5_3 ? io_coal_5_en : _io_orig_3_en_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_3_en_T_5 = inSel_4_3 ? io_coal_4_en : _io_orig_3_en_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_3_en_T_6 = inSel_3_3 ? io_coal_3_en : _io_orig_3_en_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_3_en_T_7 = _outSel_T_71 ? io_coal_2_en : _io_orig_3_en_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_3_en_T_8 = _outSel_T_41 ? io_coal_1_en : _io_orig_3_en_T_7; // @[Mux.scala 101:16]
  wire  _io_orig_3_we_T_1 = inSel_8_3 ? io_coal_8_we : inSel_9_3 & io_coal_9_we; // @[Mux.scala 101:16]
  wire  _io_orig_3_we_T_2 = inSel_7_3 ? io_coal_7_we : _io_orig_3_we_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_3_we_T_3 = inSel_6_3 ? io_coal_6_we : _io_orig_3_we_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_3_we_T_4 = inSel_5_3 ? io_coal_5_we : _io_orig_3_we_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_3_we_T_5 = inSel_4_3 ? io_coal_4_we : _io_orig_3_we_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_3_we_T_6 = inSel_3_3 ? io_coal_3_we : _io_orig_3_we_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_3_we_T_7 = _outSel_T_71 ? io_coal_2_we : _io_orig_3_we_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_3_we_T_8 = _outSel_T_41 ? io_coal_1_we : _io_orig_3_we_T_7; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_3_addr_T_10 = inSel_9_3 ? io_coal_9_addr[11:0] : 12'h0; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_3_addr_T_11 = inSel_8_3 ? io_coal_8_addr[11:0] : _io_orig_3_addr_T_10; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_3_addr_T_12 = inSel_7_3 ? io_coal_7_addr[11:0] : _io_orig_3_addr_T_11; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_3_addr_T_13 = inSel_6_3 ? io_coal_6_addr[11:0] : _io_orig_3_addr_T_12; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_3_addr_T_14 = inSel_5_3 ? io_coal_5_addr[11:0] : _io_orig_3_addr_T_13; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_3_addr_T_15 = inSel_4_3 ? io_coal_4_addr[11:0] : _io_orig_3_addr_T_14; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_3_addr_T_16 = inSel_3_3 ? io_coal_3_addr[11:0] : _io_orig_3_addr_T_15; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_3_addr_T_17 = _outSel_T_71 ? io_coal_2_addr[11:0] : _io_orig_3_addr_T_16; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_3_addr_T_18 = _outSel_T_41 ? io_coal_1_addr[11:0] : _io_orig_3_addr_T_17; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_3_din_T = inSel_9_3 ? io_coal_9_din : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_3_din_T_1 = inSel_8_3 ? io_coal_8_din : _io_orig_3_din_T; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_3_din_T_2 = inSel_7_3 ? io_coal_7_din : _io_orig_3_din_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_3_din_T_3 = inSel_6_3 ? io_coal_6_din : _io_orig_3_din_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_3_din_T_4 = inSel_5_3 ? io_coal_5_din : _io_orig_3_din_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_3_din_T_5 = inSel_4_3 ? io_coal_4_din : _io_orig_3_din_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_3_din_T_6 = inSel_3_3 ? io_coal_3_din : _io_orig_3_din_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_3_din_T_7 = _outSel_T_71 ? io_coal_2_din : _io_orig_3_din_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_3_din_T_8 = _outSel_T_41 ? io_coal_1_din : _io_orig_3_din_T_7; // @[Mux.scala 101:16]
  reg  outSel_0_3; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_1_3; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_2_3; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_3_3; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_104 = io_coal_3_en & io_coal_3_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_4_3; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_107 = io_coal_3_en & io_coal_3_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_5_3; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_110 = io_coal_3_en & io_coal_3_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_6_3; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_113 = io_coal_3_en & io_coal_3_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_7_3; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_116 = io_coal_3_en & io_coal_3_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_8_3; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_119 = io_coal_3_en & io_coal_3_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_9_3; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire [15:0] _io_coal_3_dout_T = outSel_9_3 ? io_orig_9_dout : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_3_dout_T_1 = outSel_8_3 ? io_orig_8_dout : _io_coal_3_dout_T; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_3_dout_T_2 = outSel_7_3 ? io_orig_7_dout : _io_coal_3_dout_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_3_dout_T_3 = outSel_6_3 ? io_orig_6_dout : _io_coal_3_dout_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_3_dout_T_4 = outSel_5_3 ? io_orig_5_dout : _io_coal_3_dout_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_3_dout_T_5 = outSel_4_3 ? io_orig_4_dout : _io_coal_3_dout_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_3_dout_T_6 = outSel_3_3 ? io_orig_3_dout : _io_coal_3_dout_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_3_dout_T_7 = outSel_2_3 ? io_orig_2_dout : _io_coal_3_dout_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_3_dout_T_8 = outSel_1_3 ? io_orig_1_dout : _io_coal_3_dout_T_7; // @[Mux.scala 101:16]
  wire  _inSel_T_89 = io_coal_4_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_4_4 = io_coal_4_en & io_coal_4_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_91 = io_coal_5_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_5_4 = io_coal_5_en & io_coal_5_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_93 = io_coal_6_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_6_4 = io_coal_6_en & io_coal_6_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_95 = io_coal_7_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_7_4 = io_coal_7_en & io_coal_7_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_97 = io_coal_8_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_8_4 = io_coal_8_en & io_coal_8_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_99 = io_coal_9_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_9_4 = io_coal_9_en & io_coal_9_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _io_orig_4_en_T_1 = inSel_8_4 ? io_coal_8_en : inSel_9_4 & io_coal_9_en; // @[Mux.scala 101:16]
  wire  _io_orig_4_en_T_2 = inSel_7_4 ? io_coal_7_en : _io_orig_4_en_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_4_en_T_3 = inSel_6_4 ? io_coal_6_en : _io_orig_4_en_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_4_en_T_4 = inSel_5_4 ? io_coal_5_en : _io_orig_4_en_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_4_en_T_5 = inSel_4_4 ? io_coal_4_en : _io_orig_4_en_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_4_en_T_6 = _outSel_T_104 ? io_coal_3_en : _io_orig_4_en_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_4_en_T_7 = _outSel_T_74 ? io_coal_2_en : _io_orig_4_en_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_4_en_T_8 = _outSel_T_44 ? io_coal_1_en : _io_orig_4_en_T_7; // @[Mux.scala 101:16]
  wire  _io_orig_4_we_T_1 = inSel_8_4 ? io_coal_8_we : inSel_9_4 & io_coal_9_we; // @[Mux.scala 101:16]
  wire  _io_orig_4_we_T_2 = inSel_7_4 ? io_coal_7_we : _io_orig_4_we_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_4_we_T_3 = inSel_6_4 ? io_coal_6_we : _io_orig_4_we_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_4_we_T_4 = inSel_5_4 ? io_coal_5_we : _io_orig_4_we_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_4_we_T_5 = inSel_4_4 ? io_coal_4_we : _io_orig_4_we_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_4_we_T_6 = _outSel_T_104 ? io_coal_3_we : _io_orig_4_we_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_4_we_T_7 = _outSel_T_74 ? io_coal_2_we : _io_orig_4_we_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_4_we_T_8 = _outSel_T_44 ? io_coal_1_we : _io_orig_4_we_T_7; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_4_addr_T_10 = inSel_9_4 ? io_coal_9_addr[11:0] : 12'h0; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_4_addr_T_11 = inSel_8_4 ? io_coal_8_addr[11:0] : _io_orig_4_addr_T_10; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_4_addr_T_12 = inSel_7_4 ? io_coal_7_addr[11:0] : _io_orig_4_addr_T_11; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_4_addr_T_13 = inSel_6_4 ? io_coal_6_addr[11:0] : _io_orig_4_addr_T_12; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_4_addr_T_14 = inSel_5_4 ? io_coal_5_addr[11:0] : _io_orig_4_addr_T_13; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_4_addr_T_15 = inSel_4_4 ? io_coal_4_addr[11:0] : _io_orig_4_addr_T_14; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_4_addr_T_16 = _outSel_T_104 ? io_coal_3_addr[11:0] : _io_orig_4_addr_T_15; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_4_addr_T_17 = _outSel_T_74 ? io_coal_2_addr[11:0] : _io_orig_4_addr_T_16; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_4_addr_T_18 = _outSel_T_44 ? io_coal_1_addr[11:0] : _io_orig_4_addr_T_17; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_4_din_T = inSel_9_4 ? io_coal_9_din : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_4_din_T_1 = inSel_8_4 ? io_coal_8_din : _io_orig_4_din_T; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_4_din_T_2 = inSel_7_4 ? io_coal_7_din : _io_orig_4_din_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_4_din_T_3 = inSel_6_4 ? io_coal_6_din : _io_orig_4_din_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_4_din_T_4 = inSel_5_4 ? io_coal_5_din : _io_orig_4_din_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_4_din_T_5 = inSel_4_4 ? io_coal_4_din : _io_orig_4_din_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_4_din_T_6 = _outSel_T_104 ? io_coal_3_din : _io_orig_4_din_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_4_din_T_7 = _outSel_T_74 ? io_coal_2_din : _io_orig_4_din_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_4_din_T_8 = _outSel_T_44 ? io_coal_1_din : _io_orig_4_din_T_7; // @[Mux.scala 101:16]
  reg  outSel_0_4; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_1_4; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_2_4; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_3_4; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_4_4; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_137 = io_coal_4_en & io_coal_4_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_5_4; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_140 = io_coal_4_en & io_coal_4_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_6_4; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_143 = io_coal_4_en & io_coal_4_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_7_4; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_146 = io_coal_4_en & io_coal_4_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_8_4; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_149 = io_coal_4_en & io_coal_4_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_9_4; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire [15:0] _io_coal_4_dout_T = outSel_9_4 ? io_orig_9_dout : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_4_dout_T_1 = outSel_8_4 ? io_orig_8_dout : _io_coal_4_dout_T; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_4_dout_T_2 = outSel_7_4 ? io_orig_7_dout : _io_coal_4_dout_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_4_dout_T_3 = outSel_6_4 ? io_orig_6_dout : _io_coal_4_dout_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_4_dout_T_4 = outSel_5_4 ? io_orig_5_dout : _io_coal_4_dout_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_4_dout_T_5 = outSel_4_4 ? io_orig_4_dout : _io_coal_4_dout_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_4_dout_T_6 = outSel_3_4 ? io_orig_3_dout : _io_coal_4_dout_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_4_dout_T_7 = outSel_2_4 ? io_orig_2_dout : _io_coal_4_dout_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_4_dout_T_8 = outSel_1_4 ? io_orig_1_dout : _io_coal_4_dout_T_7; // @[Mux.scala 101:16]
  wire  _inSel_T_111 = io_coal_5_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_5_5 = io_coal_5_en & io_coal_5_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_113 = io_coal_6_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_6_5 = io_coal_6_en & io_coal_6_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_115 = io_coal_7_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_7_5 = io_coal_7_en & io_coal_7_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_117 = io_coal_8_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_8_5 = io_coal_8_en & io_coal_8_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_119 = io_coal_9_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_9_5 = io_coal_9_en & io_coal_9_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _io_orig_5_en_T_1 = inSel_8_5 ? io_coal_8_en : inSel_9_5 & io_coal_9_en; // @[Mux.scala 101:16]
  wire  _io_orig_5_en_T_2 = inSel_7_5 ? io_coal_7_en : _io_orig_5_en_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_5_en_T_3 = inSel_6_5 ? io_coal_6_en : _io_orig_5_en_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_5_en_T_4 = inSel_5_5 ? io_coal_5_en : _io_orig_5_en_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_5_en_T_5 = _outSel_T_137 ? io_coal_4_en : _io_orig_5_en_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_5_en_T_6 = _outSel_T_107 ? io_coal_3_en : _io_orig_5_en_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_5_en_T_7 = _outSel_T_77 ? io_coal_2_en : _io_orig_5_en_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_5_en_T_8 = _outSel_T_47 ? io_coal_1_en : _io_orig_5_en_T_7; // @[Mux.scala 101:16]
  wire  _io_orig_5_we_T_1 = inSel_8_5 ? io_coal_8_we : inSel_9_5 & io_coal_9_we; // @[Mux.scala 101:16]
  wire  _io_orig_5_we_T_2 = inSel_7_5 ? io_coal_7_we : _io_orig_5_we_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_5_we_T_3 = inSel_6_5 ? io_coal_6_we : _io_orig_5_we_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_5_we_T_4 = inSel_5_5 ? io_coal_5_we : _io_orig_5_we_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_5_we_T_5 = _outSel_T_137 ? io_coal_4_we : _io_orig_5_we_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_5_we_T_6 = _outSel_T_107 ? io_coal_3_we : _io_orig_5_we_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_5_we_T_7 = _outSel_T_77 ? io_coal_2_we : _io_orig_5_we_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_5_we_T_8 = _outSel_T_47 ? io_coal_1_we : _io_orig_5_we_T_7; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_5_addr_T_10 = inSel_9_5 ? io_coal_9_addr[11:0] : 12'h0; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_5_addr_T_11 = inSel_8_5 ? io_coal_8_addr[11:0] : _io_orig_5_addr_T_10; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_5_addr_T_12 = inSel_7_5 ? io_coal_7_addr[11:0] : _io_orig_5_addr_T_11; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_5_addr_T_13 = inSel_6_5 ? io_coal_6_addr[11:0] : _io_orig_5_addr_T_12; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_5_addr_T_14 = inSel_5_5 ? io_coal_5_addr[11:0] : _io_orig_5_addr_T_13; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_5_addr_T_15 = _outSel_T_137 ? io_coal_4_addr[11:0] : _io_orig_5_addr_T_14; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_5_addr_T_16 = _outSel_T_107 ? io_coal_3_addr[11:0] : _io_orig_5_addr_T_15; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_5_addr_T_17 = _outSel_T_77 ? io_coal_2_addr[11:0] : _io_orig_5_addr_T_16; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_5_addr_T_18 = _outSel_T_47 ? io_coal_1_addr[11:0] : _io_orig_5_addr_T_17; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_5_din_T = inSel_9_5 ? io_coal_9_din : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_5_din_T_1 = inSel_8_5 ? io_coal_8_din : _io_orig_5_din_T; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_5_din_T_2 = inSel_7_5 ? io_coal_7_din : _io_orig_5_din_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_5_din_T_3 = inSel_6_5 ? io_coal_6_din : _io_orig_5_din_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_5_din_T_4 = inSel_5_5 ? io_coal_5_din : _io_orig_5_din_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_5_din_T_5 = _outSel_T_137 ? io_coal_4_din : _io_orig_5_din_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_5_din_T_6 = _outSel_T_107 ? io_coal_3_din : _io_orig_5_din_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_5_din_T_7 = _outSel_T_77 ? io_coal_2_din : _io_orig_5_din_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_5_din_T_8 = _outSel_T_47 ? io_coal_1_din : _io_orig_5_din_T_7; // @[Mux.scala 101:16]
  reg  outSel_0_5; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_1_5; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_2_5; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_3_5; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_4_5; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_5_5; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_170 = io_coal_5_en & io_coal_5_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_6_5; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_173 = io_coal_5_en & io_coal_5_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_7_5; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_176 = io_coal_5_en & io_coal_5_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_8_5; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_179 = io_coal_5_en & io_coal_5_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_9_5; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire [15:0] _io_coal_5_dout_T = outSel_9_5 ? io_orig_9_dout : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_5_dout_T_1 = outSel_8_5 ? io_orig_8_dout : _io_coal_5_dout_T; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_5_dout_T_2 = outSel_7_5 ? io_orig_7_dout : _io_coal_5_dout_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_5_dout_T_3 = outSel_6_5 ? io_orig_6_dout : _io_coal_5_dout_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_5_dout_T_4 = outSel_5_5 ? io_orig_5_dout : _io_coal_5_dout_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_5_dout_T_5 = outSel_4_5 ? io_orig_4_dout : _io_coal_5_dout_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_5_dout_T_6 = outSel_3_5 ? io_orig_3_dout : _io_coal_5_dout_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_5_dout_T_7 = outSel_2_5 ? io_orig_2_dout : _io_coal_5_dout_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_5_dout_T_8 = outSel_1_5 ? io_orig_1_dout : _io_coal_5_dout_T_7; // @[Mux.scala 101:16]
  wire  _inSel_T_133 = io_coal_6_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_6_6 = io_coal_6_en & io_coal_6_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_135 = io_coal_7_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_7_6 = io_coal_7_en & io_coal_7_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_137 = io_coal_8_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_8_6 = io_coal_8_en & io_coal_8_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_139 = io_coal_9_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_9_6 = io_coal_9_en & io_coal_9_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _io_orig_6_en_T_1 = inSel_8_6 ? io_coal_8_en : inSel_9_6 & io_coal_9_en; // @[Mux.scala 101:16]
  wire  _io_orig_6_en_T_2 = inSel_7_6 ? io_coal_7_en : _io_orig_6_en_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_6_en_T_3 = inSel_6_6 ? io_coal_6_en : _io_orig_6_en_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_6_en_T_4 = _outSel_T_170 ? io_coal_5_en : _io_orig_6_en_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_6_en_T_5 = _outSel_T_140 ? io_coal_4_en : _io_orig_6_en_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_6_en_T_6 = _outSel_T_110 ? io_coal_3_en : _io_orig_6_en_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_6_en_T_7 = _outSel_T_80 ? io_coal_2_en : _io_orig_6_en_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_6_en_T_8 = _outSel_T_50 ? io_coal_1_en : _io_orig_6_en_T_7; // @[Mux.scala 101:16]
  wire  _io_orig_6_we_T_1 = inSel_8_6 ? io_coal_8_we : inSel_9_6 & io_coal_9_we; // @[Mux.scala 101:16]
  wire  _io_orig_6_we_T_2 = inSel_7_6 ? io_coal_7_we : _io_orig_6_we_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_6_we_T_3 = inSel_6_6 ? io_coal_6_we : _io_orig_6_we_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_6_we_T_4 = _outSel_T_170 ? io_coal_5_we : _io_orig_6_we_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_6_we_T_5 = _outSel_T_140 ? io_coal_4_we : _io_orig_6_we_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_6_we_T_6 = _outSel_T_110 ? io_coal_3_we : _io_orig_6_we_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_6_we_T_7 = _outSel_T_80 ? io_coal_2_we : _io_orig_6_we_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_6_we_T_8 = _outSel_T_50 ? io_coal_1_we : _io_orig_6_we_T_7; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_6_addr_T_10 = inSel_9_6 ? io_coal_9_addr[11:0] : 12'h0; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_6_addr_T_11 = inSel_8_6 ? io_coal_8_addr[11:0] : _io_orig_6_addr_T_10; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_6_addr_T_12 = inSel_7_6 ? io_coal_7_addr[11:0] : _io_orig_6_addr_T_11; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_6_addr_T_13 = inSel_6_6 ? io_coal_6_addr[11:0] : _io_orig_6_addr_T_12; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_6_addr_T_14 = _outSel_T_170 ? io_coal_5_addr[11:0] : _io_orig_6_addr_T_13; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_6_addr_T_15 = _outSel_T_140 ? io_coal_4_addr[11:0] : _io_orig_6_addr_T_14; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_6_addr_T_16 = _outSel_T_110 ? io_coal_3_addr[11:0] : _io_orig_6_addr_T_15; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_6_addr_T_17 = _outSel_T_80 ? io_coal_2_addr[11:0] : _io_orig_6_addr_T_16; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_6_addr_T_18 = _outSel_T_50 ? io_coal_1_addr[11:0] : _io_orig_6_addr_T_17; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_6_din_T = inSel_9_6 ? io_coal_9_din : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_6_din_T_1 = inSel_8_6 ? io_coal_8_din : _io_orig_6_din_T; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_6_din_T_2 = inSel_7_6 ? io_coal_7_din : _io_orig_6_din_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_6_din_T_3 = inSel_6_6 ? io_coal_6_din : _io_orig_6_din_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_6_din_T_4 = _outSel_T_170 ? io_coal_5_din : _io_orig_6_din_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_6_din_T_5 = _outSel_T_140 ? io_coal_4_din : _io_orig_6_din_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_6_din_T_6 = _outSel_T_110 ? io_coal_3_din : _io_orig_6_din_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_6_din_T_7 = _outSel_T_80 ? io_coal_2_din : _io_orig_6_din_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_6_din_T_8 = _outSel_T_50 ? io_coal_1_din : _io_orig_6_din_T_7; // @[Mux.scala 101:16]
  reg  outSel_0_6; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_1_6; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_2_6; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_3_6; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_4_6; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_5_6; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_6_6; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_203 = io_coal_6_en & io_coal_6_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_7_6; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_206 = io_coal_6_en & io_coal_6_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_8_6; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_209 = io_coal_6_en & io_coal_6_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_9_6; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire [15:0] _io_coal_6_dout_T = outSel_9_6 ? io_orig_9_dout : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_6_dout_T_1 = outSel_8_6 ? io_orig_8_dout : _io_coal_6_dout_T; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_6_dout_T_2 = outSel_7_6 ? io_orig_7_dout : _io_coal_6_dout_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_6_dout_T_3 = outSel_6_6 ? io_orig_6_dout : _io_coal_6_dout_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_6_dout_T_4 = outSel_5_6 ? io_orig_5_dout : _io_coal_6_dout_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_6_dout_T_5 = outSel_4_6 ? io_orig_4_dout : _io_coal_6_dout_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_6_dout_T_6 = outSel_3_6 ? io_orig_3_dout : _io_coal_6_dout_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_6_dout_T_7 = outSel_2_6 ? io_orig_2_dout : _io_coal_6_dout_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_6_dout_T_8 = outSel_1_6 ? io_orig_1_dout : _io_coal_6_dout_T_7; // @[Mux.scala 101:16]
  wire  _inSel_T_155 = io_coal_7_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_7_7 = io_coal_7_en & io_coal_7_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_157 = io_coal_8_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_8_7 = io_coal_8_en & io_coal_8_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_159 = io_coal_9_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_9_7 = io_coal_9_en & io_coal_9_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _io_orig_7_en_T_1 = inSel_8_7 ? io_coal_8_en : inSel_9_7 & io_coal_9_en; // @[Mux.scala 101:16]
  wire  _io_orig_7_en_T_2 = inSel_7_7 ? io_coal_7_en : _io_orig_7_en_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_7_en_T_3 = _outSel_T_203 ? io_coal_6_en : _io_orig_7_en_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_7_en_T_4 = _outSel_T_173 ? io_coal_5_en : _io_orig_7_en_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_7_en_T_5 = _outSel_T_143 ? io_coal_4_en : _io_orig_7_en_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_7_en_T_6 = _outSel_T_113 ? io_coal_3_en : _io_orig_7_en_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_7_en_T_7 = _outSel_T_83 ? io_coal_2_en : _io_orig_7_en_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_7_en_T_8 = _outSel_T_53 ? io_coal_1_en : _io_orig_7_en_T_7; // @[Mux.scala 101:16]
  wire  _io_orig_7_we_T_1 = inSel_8_7 ? io_coal_8_we : inSel_9_7 & io_coal_9_we; // @[Mux.scala 101:16]
  wire  _io_orig_7_we_T_2 = inSel_7_7 ? io_coal_7_we : _io_orig_7_we_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_7_we_T_3 = _outSel_T_203 ? io_coal_6_we : _io_orig_7_we_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_7_we_T_4 = _outSel_T_173 ? io_coal_5_we : _io_orig_7_we_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_7_we_T_5 = _outSel_T_143 ? io_coal_4_we : _io_orig_7_we_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_7_we_T_6 = _outSel_T_113 ? io_coal_3_we : _io_orig_7_we_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_7_we_T_7 = _outSel_T_83 ? io_coal_2_we : _io_orig_7_we_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_7_we_T_8 = _outSel_T_53 ? io_coal_1_we : _io_orig_7_we_T_7; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_7_addr_T_10 = inSel_9_7 ? io_coal_9_addr[11:0] : 12'h0; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_7_addr_T_11 = inSel_8_7 ? io_coal_8_addr[11:0] : _io_orig_7_addr_T_10; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_7_addr_T_12 = inSel_7_7 ? io_coal_7_addr[11:0] : _io_orig_7_addr_T_11; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_7_addr_T_13 = _outSel_T_203 ? io_coal_6_addr[11:0] : _io_orig_7_addr_T_12; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_7_addr_T_14 = _outSel_T_173 ? io_coal_5_addr[11:0] : _io_orig_7_addr_T_13; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_7_addr_T_15 = _outSel_T_143 ? io_coal_4_addr[11:0] : _io_orig_7_addr_T_14; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_7_addr_T_16 = _outSel_T_113 ? io_coal_3_addr[11:0] : _io_orig_7_addr_T_15; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_7_addr_T_17 = _outSel_T_83 ? io_coal_2_addr[11:0] : _io_orig_7_addr_T_16; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_7_addr_T_18 = _outSel_T_53 ? io_coal_1_addr[11:0] : _io_orig_7_addr_T_17; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_7_din_T = inSel_9_7 ? io_coal_9_din : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_7_din_T_1 = inSel_8_7 ? io_coal_8_din : _io_orig_7_din_T; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_7_din_T_2 = inSel_7_7 ? io_coal_7_din : _io_orig_7_din_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_7_din_T_3 = _outSel_T_203 ? io_coal_6_din : _io_orig_7_din_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_7_din_T_4 = _outSel_T_173 ? io_coal_5_din : _io_orig_7_din_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_7_din_T_5 = _outSel_T_143 ? io_coal_4_din : _io_orig_7_din_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_7_din_T_6 = _outSel_T_113 ? io_coal_3_din : _io_orig_7_din_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_7_din_T_7 = _outSel_T_83 ? io_coal_2_din : _io_orig_7_din_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_7_din_T_8 = _outSel_T_53 ? io_coal_1_din : _io_orig_7_din_T_7; // @[Mux.scala 101:16]
  reg  outSel_0_7; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_1_7; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_2_7; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_3_7; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_4_7; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_5_7; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_6_7; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_7_7; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_236 = io_coal_7_en & io_coal_7_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_8_7; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_239 = io_coal_7_en & io_coal_7_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_9_7; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire [15:0] _io_coal_7_dout_T = outSel_9_7 ? io_orig_9_dout : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_7_dout_T_1 = outSel_8_7 ? io_orig_8_dout : _io_coal_7_dout_T; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_7_dout_T_2 = outSel_7_7 ? io_orig_7_dout : _io_coal_7_dout_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_7_dout_T_3 = outSel_6_7 ? io_orig_6_dout : _io_coal_7_dout_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_7_dout_T_4 = outSel_5_7 ? io_orig_5_dout : _io_coal_7_dout_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_7_dout_T_5 = outSel_4_7 ? io_orig_4_dout : _io_coal_7_dout_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_7_dout_T_6 = outSel_3_7 ? io_orig_3_dout : _io_coal_7_dout_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_7_dout_T_7 = outSel_2_7 ? io_orig_2_dout : _io_coal_7_dout_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_7_dout_T_8 = outSel_1_7 ? io_orig_1_dout : _io_coal_7_dout_T_7; // @[Mux.scala 101:16]
  wire  _inSel_T_177 = io_coal_8_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_8_8 = io_coal_8_en & io_coal_8_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _inSel_T_179 = io_coal_9_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_9_8 = io_coal_9_en & io_coal_9_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _io_orig_8_en_T_1 = inSel_8_8 ? io_coal_8_en : inSel_9_8 & io_coal_9_en; // @[Mux.scala 101:16]
  wire  _io_orig_8_en_T_2 = _outSel_T_236 ? io_coal_7_en : _io_orig_8_en_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_8_en_T_3 = _outSel_T_206 ? io_coal_6_en : _io_orig_8_en_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_8_en_T_4 = _outSel_T_176 ? io_coal_5_en : _io_orig_8_en_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_8_en_T_5 = _outSel_T_146 ? io_coal_4_en : _io_orig_8_en_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_8_en_T_6 = _outSel_T_116 ? io_coal_3_en : _io_orig_8_en_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_8_en_T_7 = _outSel_T_86 ? io_coal_2_en : _io_orig_8_en_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_8_en_T_8 = _outSel_T_56 ? io_coal_1_en : _io_orig_8_en_T_7; // @[Mux.scala 101:16]
  wire  _io_orig_8_we_T_1 = inSel_8_8 ? io_coal_8_we : inSel_9_8 & io_coal_9_we; // @[Mux.scala 101:16]
  wire  _io_orig_8_we_T_2 = _outSel_T_236 ? io_coal_7_we : _io_orig_8_we_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_8_we_T_3 = _outSel_T_206 ? io_coal_6_we : _io_orig_8_we_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_8_we_T_4 = _outSel_T_176 ? io_coal_5_we : _io_orig_8_we_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_8_we_T_5 = _outSel_T_146 ? io_coal_4_we : _io_orig_8_we_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_8_we_T_6 = _outSel_T_116 ? io_coal_3_we : _io_orig_8_we_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_8_we_T_7 = _outSel_T_86 ? io_coal_2_we : _io_orig_8_we_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_8_we_T_8 = _outSel_T_56 ? io_coal_1_we : _io_orig_8_we_T_7; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_8_addr_T_10 = inSel_9_8 ? io_coal_9_addr[11:0] : 12'h0; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_8_addr_T_11 = inSel_8_8 ? io_coal_8_addr[11:0] : _io_orig_8_addr_T_10; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_8_addr_T_12 = _outSel_T_236 ? io_coal_7_addr[11:0] : _io_orig_8_addr_T_11; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_8_addr_T_13 = _outSel_T_206 ? io_coal_6_addr[11:0] : _io_orig_8_addr_T_12; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_8_addr_T_14 = _outSel_T_176 ? io_coal_5_addr[11:0] : _io_orig_8_addr_T_13; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_8_addr_T_15 = _outSel_T_146 ? io_coal_4_addr[11:0] : _io_orig_8_addr_T_14; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_8_addr_T_16 = _outSel_T_116 ? io_coal_3_addr[11:0] : _io_orig_8_addr_T_15; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_8_addr_T_17 = _outSel_T_86 ? io_coal_2_addr[11:0] : _io_orig_8_addr_T_16; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_8_addr_T_18 = _outSel_T_56 ? io_coal_1_addr[11:0] : _io_orig_8_addr_T_17; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_8_din_T = inSel_9_8 ? io_coal_9_din : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_8_din_T_1 = inSel_8_8 ? io_coal_8_din : _io_orig_8_din_T; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_8_din_T_2 = _outSel_T_236 ? io_coal_7_din : _io_orig_8_din_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_8_din_T_3 = _outSel_T_206 ? io_coal_6_din : _io_orig_8_din_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_8_din_T_4 = _outSel_T_176 ? io_coal_5_din : _io_orig_8_din_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_8_din_T_5 = _outSel_T_146 ? io_coal_4_din : _io_orig_8_din_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_8_din_T_6 = _outSel_T_116 ? io_coal_3_din : _io_orig_8_din_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_8_din_T_7 = _outSel_T_86 ? io_coal_2_din : _io_orig_8_din_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_8_din_T_8 = _outSel_T_56 ? io_coal_1_din : _io_orig_8_din_T_7; // @[Mux.scala 101:16]
  reg  outSel_0_8; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_1_8; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_2_8; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_3_8; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_4_8; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_5_8; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_6_8; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_7_8; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_8_8; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire  _outSel_T_269 = io_coal_8_en & io_coal_8_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
  reg  outSel_9_8; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire [15:0] _io_coal_8_dout_T = outSel_9_8 ? io_orig_9_dout : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_8_dout_T_1 = outSel_8_8 ? io_orig_8_dout : _io_coal_8_dout_T; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_8_dout_T_2 = outSel_7_8 ? io_orig_7_dout : _io_coal_8_dout_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_8_dout_T_3 = outSel_6_8 ? io_orig_6_dout : _io_coal_8_dout_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_8_dout_T_4 = outSel_5_8 ? io_orig_5_dout : _io_coal_8_dout_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_8_dout_T_5 = outSel_4_8 ? io_orig_4_dout : _io_coal_8_dout_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_8_dout_T_6 = outSel_3_8 ? io_orig_3_dout : _io_coal_8_dout_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_8_dout_T_7 = outSel_2_8 ? io_orig_2_dout : _io_coal_8_dout_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_8_dout_T_8 = outSel_1_8 ? io_orig_1_dout : _io_coal_8_dout_T_7; // @[Mux.scala 101:16]
  wire  _inSel_T_199 = io_coal_9_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 46:76]
  wire  inSel_9_9 = io_coal_9_en & io_coal_9_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 46:40]
  wire  _io_orig_9_en_T_1 = _outSel_T_269 ? io_coal_8_en : inSel_9_9 & io_coal_9_en; // @[Mux.scala 101:16]
  wire  _io_orig_9_en_T_2 = _outSel_T_239 ? io_coal_7_en : _io_orig_9_en_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_9_en_T_3 = _outSel_T_209 ? io_coal_6_en : _io_orig_9_en_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_9_en_T_4 = _outSel_T_179 ? io_coal_5_en : _io_orig_9_en_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_9_en_T_5 = _outSel_T_149 ? io_coal_4_en : _io_orig_9_en_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_9_en_T_6 = _outSel_T_119 ? io_coal_3_en : _io_orig_9_en_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_9_en_T_7 = _outSel_T_89 ? io_coal_2_en : _io_orig_9_en_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_9_en_T_8 = _outSel_T_59 ? io_coal_1_en : _io_orig_9_en_T_7; // @[Mux.scala 101:16]
  wire  _io_orig_9_we_T_1 = _outSel_T_269 ? io_coal_8_we : inSel_9_9 & io_coal_9_we; // @[Mux.scala 101:16]
  wire  _io_orig_9_we_T_2 = _outSel_T_239 ? io_coal_7_we : _io_orig_9_we_T_1; // @[Mux.scala 101:16]
  wire  _io_orig_9_we_T_3 = _outSel_T_209 ? io_coal_6_we : _io_orig_9_we_T_2; // @[Mux.scala 101:16]
  wire  _io_orig_9_we_T_4 = _outSel_T_179 ? io_coal_5_we : _io_orig_9_we_T_3; // @[Mux.scala 101:16]
  wire  _io_orig_9_we_T_5 = _outSel_T_149 ? io_coal_4_we : _io_orig_9_we_T_4; // @[Mux.scala 101:16]
  wire  _io_orig_9_we_T_6 = _outSel_T_119 ? io_coal_3_we : _io_orig_9_we_T_5; // @[Mux.scala 101:16]
  wire  _io_orig_9_we_T_7 = _outSel_T_89 ? io_coal_2_we : _io_orig_9_we_T_6; // @[Mux.scala 101:16]
  wire  _io_orig_9_we_T_8 = _outSel_T_59 ? io_coal_1_we : _io_orig_9_we_T_7; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_9_addr_T_10 = inSel_9_9 ? io_coal_9_addr[11:0] : 12'h0; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_9_addr_T_11 = _outSel_T_269 ? io_coal_8_addr[11:0] : _io_orig_9_addr_T_10; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_9_addr_T_12 = _outSel_T_239 ? io_coal_7_addr[11:0] : _io_orig_9_addr_T_11; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_9_addr_T_13 = _outSel_T_209 ? io_coal_6_addr[11:0] : _io_orig_9_addr_T_12; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_9_addr_T_14 = _outSel_T_179 ? io_coal_5_addr[11:0] : _io_orig_9_addr_T_13; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_9_addr_T_15 = _outSel_T_149 ? io_coal_4_addr[11:0] : _io_orig_9_addr_T_14; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_9_addr_T_16 = _outSel_T_119 ? io_coal_3_addr[11:0] : _io_orig_9_addr_T_15; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_9_addr_T_17 = _outSel_T_89 ? io_coal_2_addr[11:0] : _io_orig_9_addr_T_16; // @[Mux.scala 101:16]
  wire [11:0] _io_orig_9_addr_T_18 = _outSel_T_59 ? io_coal_1_addr[11:0] : _io_orig_9_addr_T_17; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_9_din_T = inSel_9_9 ? io_coal_9_din : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_9_din_T_1 = _outSel_T_269 ? io_coal_8_din : _io_orig_9_din_T; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_9_din_T_2 = _outSel_T_239 ? io_coal_7_din : _io_orig_9_din_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_9_din_T_3 = _outSel_T_209 ? io_coal_6_din : _io_orig_9_din_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_9_din_T_4 = _outSel_T_179 ? io_coal_5_din : _io_orig_9_din_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_9_din_T_5 = _outSel_T_149 ? io_coal_4_din : _io_orig_9_din_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_9_din_T_6 = _outSel_T_119 ? io_coal_3_din : _io_orig_9_din_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_9_din_T_7 = _outSel_T_89 ? io_coal_2_din : _io_orig_9_din_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_orig_9_din_T_8 = _outSel_T_59 ? io_coal_1_din : _io_orig_9_din_T_7; // @[Mux.scala 101:16]
  reg  outSel_0_9; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_1_9; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_2_9; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_3_9; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_4_9; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_5_9; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_6_9; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_7_9; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_8_9; // @[MultiTileSRAMCoalesce.scala 52:14]
  reg  outSel_9_9; // @[MultiTileSRAMCoalesce.scala 52:14]
  wire [15:0] _io_coal_9_dout_T = outSel_9_9 ? io_orig_9_dout : 16'h0; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_9_dout_T_1 = outSel_8_9 ? io_orig_8_dout : _io_coal_9_dout_T; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_9_dout_T_2 = outSel_7_9 ? io_orig_7_dout : _io_coal_9_dout_T_1; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_9_dout_T_3 = outSel_6_9 ? io_orig_6_dout : _io_coal_9_dout_T_2; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_9_dout_T_4 = outSel_5_9 ? io_orig_5_dout : _io_coal_9_dout_T_3; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_9_dout_T_5 = outSel_4_9 ? io_orig_4_dout : _io_coal_9_dout_T_4; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_9_dout_T_6 = outSel_3_9 ? io_orig_3_dout : _io_coal_9_dout_T_5; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_9_dout_T_7 = outSel_2_9 ? io_orig_2_dout : _io_coal_9_dout_T_6; // @[Mux.scala 101:16]
  wire [15:0] _io_coal_9_dout_T_8 = outSel_1_9 ? io_orig_1_dout : _io_coal_9_dout_T_7; // @[Mux.scala 101:16]
  assign io_orig_0_en = inSel_0 ? io_coal_0_en : _io_orig_0_en_T_8; // @[Mux.scala 101:16]
  assign io_orig_0_we = inSel_0 ? io_coal_0_we : _io_orig_0_we_T_8; // @[Mux.scala 101:16]
  assign io_orig_0_addr = inSel_0 ? io_coal_0_addr[11:0] : _io_orig_0_addr_T_18; // @[Mux.scala 101:16]
  assign io_orig_0_din = inSel_0 ? io_coal_0_din : _io_orig_0_din_T_8; // @[Mux.scala 101:16]
  assign io_orig_1_en = _outSel_T_5 ? io_coal_0_en : _io_orig_1_en_T_8; // @[Mux.scala 101:16]
  assign io_orig_1_we = _outSel_T_5 ? io_coal_0_we : _io_orig_1_we_T_8; // @[Mux.scala 101:16]
  assign io_orig_1_addr = _outSel_T_5 ? io_coal_0_addr[11:0] : _io_orig_1_addr_T_18; // @[Mux.scala 101:16]
  assign io_orig_1_din = _outSel_T_5 ? io_coal_0_din : _io_orig_1_din_T_8; // @[Mux.scala 101:16]
  assign io_orig_2_en = _outSel_T_8 ? io_coal_0_en : _io_orig_2_en_T_8; // @[Mux.scala 101:16]
  assign io_orig_2_we = _outSel_T_8 ? io_coal_0_we : _io_orig_2_we_T_8; // @[Mux.scala 101:16]
  assign io_orig_2_addr = _outSel_T_8 ? io_coal_0_addr[11:0] : _io_orig_2_addr_T_18; // @[Mux.scala 101:16]
  assign io_orig_2_din = _outSel_T_8 ? io_coal_0_din : _io_orig_2_din_T_8; // @[Mux.scala 101:16]
  assign io_orig_3_en = _outSel_T_11 ? io_coal_0_en : _io_orig_3_en_T_8; // @[Mux.scala 101:16]
  assign io_orig_3_we = _outSel_T_11 ? io_coal_0_we : _io_orig_3_we_T_8; // @[Mux.scala 101:16]
  assign io_orig_3_addr = _outSel_T_11 ? io_coal_0_addr[11:0] : _io_orig_3_addr_T_18; // @[Mux.scala 101:16]
  assign io_orig_3_din = _outSel_T_11 ? io_coal_0_din : _io_orig_3_din_T_8; // @[Mux.scala 101:16]
  assign io_orig_4_en = _outSel_T_14 ? io_coal_0_en : _io_orig_4_en_T_8; // @[Mux.scala 101:16]
  assign io_orig_4_we = _outSel_T_14 ? io_coal_0_we : _io_orig_4_we_T_8; // @[Mux.scala 101:16]
  assign io_orig_4_addr = _outSel_T_14 ? io_coal_0_addr[11:0] : _io_orig_4_addr_T_18; // @[Mux.scala 101:16]
  assign io_orig_4_din = _outSel_T_14 ? io_coal_0_din : _io_orig_4_din_T_8; // @[Mux.scala 101:16]
  assign io_orig_5_en = _outSel_T_17 ? io_coal_0_en : _io_orig_5_en_T_8; // @[Mux.scala 101:16]
  assign io_orig_5_we = _outSel_T_17 ? io_coal_0_we : _io_orig_5_we_T_8; // @[Mux.scala 101:16]
  assign io_orig_5_addr = _outSel_T_17 ? io_coal_0_addr[11:0] : _io_orig_5_addr_T_18; // @[Mux.scala 101:16]
  assign io_orig_5_din = _outSel_T_17 ? io_coal_0_din : _io_orig_5_din_T_8; // @[Mux.scala 101:16]
  assign io_orig_6_en = _outSel_T_20 ? io_coal_0_en : _io_orig_6_en_T_8; // @[Mux.scala 101:16]
  assign io_orig_6_we = _outSel_T_20 ? io_coal_0_we : _io_orig_6_we_T_8; // @[Mux.scala 101:16]
  assign io_orig_6_addr = _outSel_T_20 ? io_coal_0_addr[11:0] : _io_orig_6_addr_T_18; // @[Mux.scala 101:16]
  assign io_orig_6_din = _outSel_T_20 ? io_coal_0_din : _io_orig_6_din_T_8; // @[Mux.scala 101:16]
  assign io_orig_7_en = _outSel_T_23 ? io_coal_0_en : _io_orig_7_en_T_8; // @[Mux.scala 101:16]
  assign io_orig_7_we = _outSel_T_23 ? io_coal_0_we : _io_orig_7_we_T_8; // @[Mux.scala 101:16]
  assign io_orig_7_addr = _outSel_T_23 ? io_coal_0_addr[11:0] : _io_orig_7_addr_T_18; // @[Mux.scala 101:16]
  assign io_orig_7_din = _outSel_T_23 ? io_coal_0_din : _io_orig_7_din_T_8; // @[Mux.scala 101:16]
  assign io_orig_8_en = _outSel_T_26 ? io_coal_0_en : _io_orig_8_en_T_8; // @[Mux.scala 101:16]
  assign io_orig_8_we = _outSel_T_26 ? io_coal_0_we : _io_orig_8_we_T_8; // @[Mux.scala 101:16]
  assign io_orig_8_addr = _outSel_T_26 ? io_coal_0_addr[11:0] : _io_orig_8_addr_T_18; // @[Mux.scala 101:16]
  assign io_orig_8_din = _outSel_T_26 ? io_coal_0_din : _io_orig_8_din_T_8; // @[Mux.scala 101:16]
  assign io_orig_9_en = _outSel_T_29 ? io_coal_0_en : _io_orig_9_en_T_8; // @[Mux.scala 101:16]
  assign io_orig_9_we = _outSel_T_29 ? io_coal_0_we : _io_orig_9_we_T_8; // @[Mux.scala 101:16]
  assign io_orig_9_addr = _outSel_T_29 ? io_coal_0_addr[11:0] : _io_orig_9_addr_T_18; // @[Mux.scala 101:16]
  assign io_orig_9_din = _outSel_T_29 ? io_coal_0_din : _io_orig_9_din_T_8; // @[Mux.scala 101:16]
  assign io_coal_0_dout = outSel_0 ? io_orig_0_dout : _io_coal_0_dout_T_8; // @[Mux.scala 101:16]
  assign io_coal_1_dout = outSel_0_1 ? io_orig_0_dout : _io_coal_1_dout_T_8; // @[Mux.scala 101:16]
  assign io_coal_2_dout = outSel_0_2 ? io_orig_0_dout : _io_coal_2_dout_T_8; // @[Mux.scala 101:16]
  assign io_coal_3_dout = outSel_0_3 ? io_orig_0_dout : _io_coal_3_dout_T_8; // @[Mux.scala 101:16]
  assign io_coal_4_dout = outSel_0_4 ? io_orig_0_dout : _io_coal_4_dout_T_8; // @[Mux.scala 101:16]
  assign io_coal_5_dout = outSel_0_5 ? io_orig_0_dout : _io_coal_5_dout_T_8; // @[Mux.scala 101:16]
  assign io_coal_6_dout = outSel_0_6 ? io_orig_0_dout : _io_coal_6_dout_T_8; // @[Mux.scala 101:16]
  assign io_coal_7_dout = outSel_0_7 ? io_orig_0_dout : _io_coal_7_dout_T_8; // @[Mux.scala 101:16]
  assign io_coal_8_dout = outSel_0_8 ? io_orig_0_dout : _io_coal_8_dout_T_8; // @[Mux.scala 101:16]
  assign io_coal_9_dout = outSel_0_9 ? io_orig_0_dout : _io_coal_9_dout_T_8; // @[Mux.scala 101:16]
  always @(posedge clock) begin
    outSel_0 <= io_coal_0_en & _inSel_T_1; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_1 <= io_coal_0_en & io_coal_0_addr[15:12] == 4'h1; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_2 <= io_coal_0_en & io_coal_0_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_3 <= io_coal_0_en & io_coal_0_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_4 <= io_coal_0_en & io_coal_0_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_5 <= io_coal_0_en & io_coal_0_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_6 <= io_coal_0_en & io_coal_0_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_7 <= io_coal_0_en & io_coal_0_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_8 <= io_coal_0_en & io_coal_0_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_9 <= io_coal_0_en & io_coal_0_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_0_1 <= io_coal_1_en & _inSel_T_3; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_1_1 <= io_coal_1_en & _inSel_T_23; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_2_1 <= io_coal_1_en & io_coal_1_addr[15:12] == 4'h2; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_3_1 <= io_coal_1_en & io_coal_1_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_4_1 <= io_coal_1_en & io_coal_1_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_5_1 <= io_coal_1_en & io_coal_1_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_6_1 <= io_coal_1_en & io_coal_1_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_7_1 <= io_coal_1_en & io_coal_1_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_8_1 <= io_coal_1_en & io_coal_1_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_9_1 <= io_coal_1_en & io_coal_1_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_0_2 <= io_coal_2_en & _inSel_T_5; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_1_2 <= io_coal_2_en & _inSel_T_25; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_2_2 <= io_coal_2_en & _inSel_T_45; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_3_2 <= io_coal_2_en & io_coal_2_addr[15:12] == 4'h3; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_4_2 <= io_coal_2_en & io_coal_2_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_5_2 <= io_coal_2_en & io_coal_2_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_6_2 <= io_coal_2_en & io_coal_2_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_7_2 <= io_coal_2_en & io_coal_2_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_8_2 <= io_coal_2_en & io_coal_2_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_9_2 <= io_coal_2_en & io_coal_2_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_0_3 <= io_coal_3_en & _inSel_T_7; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_1_3 <= io_coal_3_en & _inSel_T_27; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_2_3 <= io_coal_3_en & _inSel_T_47; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_3_3 <= io_coal_3_en & _inSel_T_67; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_4_3 <= io_coal_3_en & io_coal_3_addr[15:12] == 4'h4; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_5_3 <= io_coal_3_en & io_coal_3_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_6_3 <= io_coal_3_en & io_coal_3_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_7_3 <= io_coal_3_en & io_coal_3_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_8_3 <= io_coal_3_en & io_coal_3_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_9_3 <= io_coal_3_en & io_coal_3_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_0_4 <= io_coal_4_en & _inSel_T_9; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_1_4 <= io_coal_4_en & _inSel_T_29; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_2_4 <= io_coal_4_en & _inSel_T_49; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_3_4 <= io_coal_4_en & _inSel_T_69; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_4_4 <= io_coal_4_en & _inSel_T_89; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_5_4 <= io_coal_4_en & io_coal_4_addr[15:12] == 4'h5; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_6_4 <= io_coal_4_en & io_coal_4_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_7_4 <= io_coal_4_en & io_coal_4_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_8_4 <= io_coal_4_en & io_coal_4_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_9_4 <= io_coal_4_en & io_coal_4_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_0_5 <= io_coal_5_en & _inSel_T_11; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_1_5 <= io_coal_5_en & _inSel_T_31; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_2_5 <= io_coal_5_en & _inSel_T_51; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_3_5 <= io_coal_5_en & _inSel_T_71; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_4_5 <= io_coal_5_en & _inSel_T_91; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_5_5 <= io_coal_5_en & _inSel_T_111; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_6_5 <= io_coal_5_en & io_coal_5_addr[15:12] == 4'h6; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_7_5 <= io_coal_5_en & io_coal_5_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_8_5 <= io_coal_5_en & io_coal_5_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_9_5 <= io_coal_5_en & io_coal_5_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_0_6 <= io_coal_6_en & _inSel_T_13; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_1_6 <= io_coal_6_en & _inSel_T_33; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_2_6 <= io_coal_6_en & _inSel_T_53; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_3_6 <= io_coal_6_en & _inSel_T_73; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_4_6 <= io_coal_6_en & _inSel_T_93; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_5_6 <= io_coal_6_en & _inSel_T_113; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_6_6 <= io_coal_6_en & _inSel_T_133; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_7_6 <= io_coal_6_en & io_coal_6_addr[15:12] == 4'h7; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_8_6 <= io_coal_6_en & io_coal_6_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_9_6 <= io_coal_6_en & io_coal_6_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_0_7 <= io_coal_7_en & _inSel_T_15; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_1_7 <= io_coal_7_en & _inSel_T_35; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_2_7 <= io_coal_7_en & _inSel_T_55; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_3_7 <= io_coal_7_en & _inSel_T_75; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_4_7 <= io_coal_7_en & _inSel_T_95; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_5_7 <= io_coal_7_en & _inSel_T_115; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_6_7 <= io_coal_7_en & _inSel_T_135; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_7_7 <= io_coal_7_en & _inSel_T_155; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_8_7 <= io_coal_7_en & io_coal_7_addr[15:12] == 4'h8; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_9_7 <= io_coal_7_en & io_coal_7_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_0_8 <= io_coal_8_en & _inSel_T_17; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_1_8 <= io_coal_8_en & _inSel_T_37; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_2_8 <= io_coal_8_en & _inSel_T_57; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_3_8 <= io_coal_8_en & _inSel_T_77; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_4_8 <= io_coal_8_en & _inSel_T_97; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_5_8 <= io_coal_8_en & _inSel_T_117; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_6_8 <= io_coal_8_en & _inSel_T_137; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_7_8 <= io_coal_8_en & _inSel_T_157; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_8_8 <= io_coal_8_en & _inSel_T_177; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_9_8 <= io_coal_8_en & io_coal_8_addr[15:12] == 4'h9; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_0_9 <= io_coal_9_en & _inSel_T_19; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_1_9 <= io_coal_9_en & _inSel_T_39; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_2_9 <= io_coal_9_en & _inSel_T_59; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_3_9 <= io_coal_9_en & _inSel_T_79; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_4_9 <= io_coal_9_en & _inSel_T_99; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_5_9 <= io_coal_9_en & _inSel_T_119; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_6_9 <= io_coal_9_en & _inSel_T_139; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_7_9 <= io_coal_9_en & _inSel_T_159; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_8_9 <= io_coal_9_en & _inSel_T_179; // @[MultiTileSRAMCoalesce.scala 52:29]
    outSel_9_9 <= io_coal_9_en & _inSel_T_199; // @[MultiTileSRAMCoalesce.scala 52:29]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  outSel_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  outSel_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  outSel_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  outSel_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  outSel_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  outSel_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  outSel_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  outSel_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  outSel_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  outSel_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  outSel_0_1 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  outSel_1_1 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  outSel_2_1 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  outSel_3_1 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  outSel_4_1 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  outSel_5_1 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  outSel_6_1 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  outSel_7_1 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  outSel_8_1 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  outSel_9_1 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  outSel_0_2 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  outSel_1_2 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  outSel_2_2 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  outSel_3_2 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  outSel_4_2 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  outSel_5_2 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  outSel_6_2 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  outSel_7_2 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  outSel_8_2 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  outSel_9_2 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  outSel_0_3 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  outSel_1_3 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  outSel_2_3 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  outSel_3_3 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  outSel_4_3 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  outSel_5_3 = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  outSel_6_3 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  outSel_7_3 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  outSel_8_3 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  outSel_9_3 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  outSel_0_4 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  outSel_1_4 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  outSel_2_4 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  outSel_3_4 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  outSel_4_4 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  outSel_5_4 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  outSel_6_4 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  outSel_7_4 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  outSel_8_4 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  outSel_9_4 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  outSel_0_5 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  outSel_1_5 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  outSel_2_5 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  outSel_3_5 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  outSel_4_5 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  outSel_5_5 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  outSel_6_5 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  outSel_7_5 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  outSel_8_5 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  outSel_9_5 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  outSel_0_6 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  outSel_1_6 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  outSel_2_6 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  outSel_3_6 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  outSel_4_6 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  outSel_5_6 = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  outSel_6_6 = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  outSel_7_6 = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  outSel_8_6 = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  outSel_9_6 = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  outSel_0_7 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  outSel_1_7 = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  outSel_2_7 = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  outSel_3_7 = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  outSel_4_7 = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  outSel_5_7 = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  outSel_6_7 = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  outSel_7_7 = _RAND_77[0:0];
  _RAND_78 = {1{`RANDOM}};
  outSel_8_7 = _RAND_78[0:0];
  _RAND_79 = {1{`RANDOM}};
  outSel_9_7 = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  outSel_0_8 = _RAND_80[0:0];
  _RAND_81 = {1{`RANDOM}};
  outSel_1_8 = _RAND_81[0:0];
  _RAND_82 = {1{`RANDOM}};
  outSel_2_8 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  outSel_3_8 = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  outSel_4_8 = _RAND_84[0:0];
  _RAND_85 = {1{`RANDOM}};
  outSel_5_8 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  outSel_6_8 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  outSel_7_8 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  outSel_8_8 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  outSel_9_8 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  outSel_0_9 = _RAND_90[0:0];
  _RAND_91 = {1{`RANDOM}};
  outSel_1_9 = _RAND_91[0:0];
  _RAND_92 = {1{`RANDOM}};
  outSel_2_9 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  outSel_3_9 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  outSel_4_9 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  outSel_5_9 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  outSel_6_9 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  outSel_7_9 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  outSel_8_9 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  outSel_9_9 = _RAND_99[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MultiTileSRAMCoalesce(
  input         clock,
  output        io_orig_0_en,
  output        io_orig_0_we,
  output [11:0] io_orig_0_addr,
  output [15:0] io_orig_0_din,
  input  [15:0] io_orig_0_dout,
  output        io_orig_1_en,
  output        io_orig_1_we,
  output [11:0] io_orig_1_addr,
  output [15:0] io_orig_1_din,
  input  [15:0] io_orig_1_dout,
  output        io_orig_2_en,
  output        io_orig_2_we,
  output [11:0] io_orig_2_addr,
  output [15:0] io_orig_2_din,
  input  [15:0] io_orig_2_dout,
  output        io_orig_3_en,
  output        io_orig_3_we,
  output [11:0] io_orig_3_addr,
  output [15:0] io_orig_3_din,
  input  [15:0] io_orig_3_dout,
  output        io_orig_4_en,
  output        io_orig_4_we,
  output [11:0] io_orig_4_addr,
  output [15:0] io_orig_4_din,
  input  [15:0] io_orig_4_dout,
  output        io_orig_5_en,
  output        io_orig_5_we,
  output [11:0] io_orig_5_addr,
  output [15:0] io_orig_5_din,
  input  [15:0] io_orig_5_dout,
  output        io_orig_6_en,
  output        io_orig_6_we,
  output [11:0] io_orig_6_addr,
  output [15:0] io_orig_6_din,
  input  [15:0] io_orig_6_dout,
  output        io_orig_7_en,
  output        io_orig_7_we,
  output [11:0] io_orig_7_addr,
  output [15:0] io_orig_7_din,
  input  [15:0] io_orig_7_dout,
  output        io_orig_8_en,
  output        io_orig_8_we,
  output [11:0] io_orig_8_addr,
  output [15:0] io_orig_8_din,
  input  [15:0] io_orig_8_dout,
  output        io_orig_9_en,
  output        io_orig_9_we,
  output [11:0] io_orig_9_addr,
  output [15:0] io_orig_9_din,
  input  [15:0] io_orig_9_dout,
  input         io_coal_0_0_en,
  input         io_coal_0_0_we,
  input  [14:0] io_coal_0_0_addr,
  input  [15:0] io_coal_0_0_din,
  output [15:0] io_coal_0_0_dout,
  input         io_coal_0_1_en,
  input         io_coal_0_1_we,
  input  [14:0] io_coal_0_1_addr,
  input  [15:0] io_coal_0_1_din,
  output [15:0] io_coal_0_1_dout,
  input         io_coal_0_2_en,
  input         io_coal_0_2_we,
  input  [14:0] io_coal_0_2_addr,
  input  [15:0] io_coal_0_2_din,
  output [15:0] io_coal_0_2_dout,
  input         io_coal_0_3_en,
  input         io_coal_0_3_we,
  input  [14:0] io_coal_0_3_addr,
  input  [15:0] io_coal_0_3_din,
  output [15:0] io_coal_0_3_dout,
  input         io_coal_0_4_en,
  input         io_coal_0_4_we,
  input  [14:0] io_coal_0_4_addr,
  input  [15:0] io_coal_0_4_din,
  output [15:0] io_coal_0_4_dout,
  input         io_coal_0_5_en,
  input         io_coal_0_5_we,
  input  [14:0] io_coal_0_5_addr,
  input  [15:0] io_coal_0_5_din,
  output [15:0] io_coal_0_5_dout,
  input         io_coal_0_6_en,
  input         io_coal_0_6_we,
  input  [14:0] io_coal_0_6_addr,
  input  [15:0] io_coal_0_6_din,
  output [15:0] io_coal_0_6_dout,
  input         io_coal_0_7_en,
  input         io_coal_0_7_we,
  input  [14:0] io_coal_0_7_addr,
  input  [15:0] io_coal_0_7_din,
  output [15:0] io_coal_0_7_dout,
  input         io_coal_0_8_en,
  input         io_coal_0_8_we,
  input  [14:0] io_coal_0_8_addr,
  input  [15:0] io_coal_0_8_din,
  output [15:0] io_coal_0_8_dout,
  input         io_coal_0_9_en,
  input         io_coal_0_9_we,
  input  [14:0] io_coal_0_9_addr,
  input  [15:0] io_coal_0_9_din,
  output [15:0] io_coal_0_9_dout
);
  wire  group_clock; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_0_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_0_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [11:0] group_io_orig_0_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_0_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_0_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_1_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_1_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [11:0] group_io_orig_1_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_1_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_1_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_2_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_2_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [11:0] group_io_orig_2_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_2_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_2_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_3_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_3_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [11:0] group_io_orig_3_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_3_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_3_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_4_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_4_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [11:0] group_io_orig_4_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_4_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_4_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_5_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_5_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [11:0] group_io_orig_5_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_5_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_5_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_6_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_6_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [11:0] group_io_orig_6_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_6_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_6_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_7_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_7_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [11:0] group_io_orig_7_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_7_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_7_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_8_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_8_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [11:0] group_io_orig_8_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_8_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_8_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_9_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_orig_9_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [11:0] group_io_orig_9_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_9_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_orig_9_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_0_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_0_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_0_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_0_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_0_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_1_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_1_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_1_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_1_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_1_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_2_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_2_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_2_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_2_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_2_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_3_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_3_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_3_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_3_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_3_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_4_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_4_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_4_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_4_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_4_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_5_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_5_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_5_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_5_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_5_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_6_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_6_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_6_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_6_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_6_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_7_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_7_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_7_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_7_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_7_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_8_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_8_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_8_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_8_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_8_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_9_en; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire  group_io_coal_9_we; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_9_addr; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_9_din; // @[MultiTileSRAMCoalesce.scala 94:23]
  wire [15:0] group_io_coal_9_dout; // @[MultiTileSRAMCoalesce.scala 94:23]
  SRAMBanksCoalesce group ( // @[MultiTileSRAMCoalesce.scala 94:23]
    .clock(group_clock),
    .io_orig_0_en(group_io_orig_0_en),
    .io_orig_0_we(group_io_orig_0_we),
    .io_orig_0_addr(group_io_orig_0_addr),
    .io_orig_0_din(group_io_orig_0_din),
    .io_orig_0_dout(group_io_orig_0_dout),
    .io_orig_1_en(group_io_orig_1_en),
    .io_orig_1_we(group_io_orig_1_we),
    .io_orig_1_addr(group_io_orig_1_addr),
    .io_orig_1_din(group_io_orig_1_din),
    .io_orig_1_dout(group_io_orig_1_dout),
    .io_orig_2_en(group_io_orig_2_en),
    .io_orig_2_we(group_io_orig_2_we),
    .io_orig_2_addr(group_io_orig_2_addr),
    .io_orig_2_din(group_io_orig_2_din),
    .io_orig_2_dout(group_io_orig_2_dout),
    .io_orig_3_en(group_io_orig_3_en),
    .io_orig_3_we(group_io_orig_3_we),
    .io_orig_3_addr(group_io_orig_3_addr),
    .io_orig_3_din(group_io_orig_3_din),
    .io_orig_3_dout(group_io_orig_3_dout),
    .io_orig_4_en(group_io_orig_4_en),
    .io_orig_4_we(group_io_orig_4_we),
    .io_orig_4_addr(group_io_orig_4_addr),
    .io_orig_4_din(group_io_orig_4_din),
    .io_orig_4_dout(group_io_orig_4_dout),
    .io_orig_5_en(group_io_orig_5_en),
    .io_orig_5_we(group_io_orig_5_we),
    .io_orig_5_addr(group_io_orig_5_addr),
    .io_orig_5_din(group_io_orig_5_din),
    .io_orig_5_dout(group_io_orig_5_dout),
    .io_orig_6_en(group_io_orig_6_en),
    .io_orig_6_we(group_io_orig_6_we),
    .io_orig_6_addr(group_io_orig_6_addr),
    .io_orig_6_din(group_io_orig_6_din),
    .io_orig_6_dout(group_io_orig_6_dout),
    .io_orig_7_en(group_io_orig_7_en),
    .io_orig_7_we(group_io_orig_7_we),
    .io_orig_7_addr(group_io_orig_7_addr),
    .io_orig_7_din(group_io_orig_7_din),
    .io_orig_7_dout(group_io_orig_7_dout),
    .io_orig_8_en(group_io_orig_8_en),
    .io_orig_8_we(group_io_orig_8_we),
    .io_orig_8_addr(group_io_orig_8_addr),
    .io_orig_8_din(group_io_orig_8_din),
    .io_orig_8_dout(group_io_orig_8_dout),
    .io_orig_9_en(group_io_orig_9_en),
    .io_orig_9_we(group_io_orig_9_we),
    .io_orig_9_addr(group_io_orig_9_addr),
    .io_orig_9_din(group_io_orig_9_din),
    .io_orig_9_dout(group_io_orig_9_dout),
    .io_coal_0_en(group_io_coal_0_en),
    .io_coal_0_we(group_io_coal_0_we),
    .io_coal_0_addr(group_io_coal_0_addr),
    .io_coal_0_din(group_io_coal_0_din),
    .io_coal_0_dout(group_io_coal_0_dout),
    .io_coal_1_en(group_io_coal_1_en),
    .io_coal_1_we(group_io_coal_1_we),
    .io_coal_1_addr(group_io_coal_1_addr),
    .io_coal_1_din(group_io_coal_1_din),
    .io_coal_1_dout(group_io_coal_1_dout),
    .io_coal_2_en(group_io_coal_2_en),
    .io_coal_2_we(group_io_coal_2_we),
    .io_coal_2_addr(group_io_coal_2_addr),
    .io_coal_2_din(group_io_coal_2_din),
    .io_coal_2_dout(group_io_coal_2_dout),
    .io_coal_3_en(group_io_coal_3_en),
    .io_coal_3_we(group_io_coal_3_we),
    .io_coal_3_addr(group_io_coal_3_addr),
    .io_coal_3_din(group_io_coal_3_din),
    .io_coal_3_dout(group_io_coal_3_dout),
    .io_coal_4_en(group_io_coal_4_en),
    .io_coal_4_we(group_io_coal_4_we),
    .io_coal_4_addr(group_io_coal_4_addr),
    .io_coal_4_din(group_io_coal_4_din),
    .io_coal_4_dout(group_io_coal_4_dout),
    .io_coal_5_en(group_io_coal_5_en),
    .io_coal_5_we(group_io_coal_5_we),
    .io_coal_5_addr(group_io_coal_5_addr),
    .io_coal_5_din(group_io_coal_5_din),
    .io_coal_5_dout(group_io_coal_5_dout),
    .io_coal_6_en(group_io_coal_6_en),
    .io_coal_6_we(group_io_coal_6_we),
    .io_coal_6_addr(group_io_coal_6_addr),
    .io_coal_6_din(group_io_coal_6_din),
    .io_coal_6_dout(group_io_coal_6_dout),
    .io_coal_7_en(group_io_coal_7_en),
    .io_coal_7_we(group_io_coal_7_we),
    .io_coal_7_addr(group_io_coal_7_addr),
    .io_coal_7_din(group_io_coal_7_din),
    .io_coal_7_dout(group_io_coal_7_dout),
    .io_coal_8_en(group_io_coal_8_en),
    .io_coal_8_we(group_io_coal_8_we),
    .io_coal_8_addr(group_io_coal_8_addr),
    .io_coal_8_din(group_io_coal_8_din),
    .io_coal_8_dout(group_io_coal_8_dout),
    .io_coal_9_en(group_io_coal_9_en),
    .io_coal_9_we(group_io_coal_9_we),
    .io_coal_9_addr(group_io_coal_9_addr),
    .io_coal_9_din(group_io_coal_9_din),
    .io_coal_9_dout(group_io_coal_9_dout)
  );
  assign io_orig_0_en = group_io_orig_0_en; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_0_we = group_io_orig_0_we; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_0_addr = group_io_orig_0_addr; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_0_din = group_io_orig_0_din; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_1_en = group_io_orig_1_en; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_1_we = group_io_orig_1_we; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_1_addr = group_io_orig_1_addr; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_1_din = group_io_orig_1_din; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_2_en = group_io_orig_2_en; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_2_we = group_io_orig_2_we; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_2_addr = group_io_orig_2_addr; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_2_din = group_io_orig_2_din; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_3_en = group_io_orig_3_en; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_3_we = group_io_orig_3_we; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_3_addr = group_io_orig_3_addr; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_3_din = group_io_orig_3_din; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_4_en = group_io_orig_4_en; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_4_we = group_io_orig_4_we; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_4_addr = group_io_orig_4_addr; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_4_din = group_io_orig_4_din; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_5_en = group_io_orig_5_en; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_5_we = group_io_orig_5_we; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_5_addr = group_io_orig_5_addr; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_5_din = group_io_orig_5_din; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_6_en = group_io_orig_6_en; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_6_we = group_io_orig_6_we; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_6_addr = group_io_orig_6_addr; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_6_din = group_io_orig_6_din; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_7_en = group_io_orig_7_en; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_7_we = group_io_orig_7_we; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_7_addr = group_io_orig_7_addr; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_7_din = group_io_orig_7_din; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_8_en = group_io_orig_8_en; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_8_we = group_io_orig_8_we; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_8_addr = group_io_orig_8_addr; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_8_din = group_io_orig_8_din; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_9_en = group_io_orig_9_en; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_9_we = group_io_orig_9_we; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_9_addr = group_io_orig_9_addr; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_orig_9_din = group_io_orig_9_din; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign io_coal_0_0_dout = group_io_coal_0_dout; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign io_coal_0_1_dout = group_io_coal_1_dout; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign io_coal_0_2_dout = group_io_coal_2_dout; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign io_coal_0_3_dout = group_io_coal_3_dout; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign io_coal_0_4_dout = group_io_coal_4_dout; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign io_coal_0_5_dout = group_io_coal_5_dout; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign io_coal_0_6_dout = group_io_coal_6_dout; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign io_coal_0_7_dout = group_io_coal_7_dout; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign io_coal_0_8_dout = group_io_coal_8_dout; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign io_coal_0_9_dout = group_io_coal_9_dout; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_clock = clock;
  assign group_io_orig_0_dout = io_orig_0_dout; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign group_io_orig_1_dout = io_orig_1_dout; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign group_io_orig_2_dout = io_orig_2_dout; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign group_io_orig_3_dout = io_orig_3_dout; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign group_io_orig_4_dout = io_orig_4_dout; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign group_io_orig_5_dout = io_orig_5_dout; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign group_io_orig_6_dout = io_orig_6_dout; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign group_io_orig_7_dout = io_orig_7_dout; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign group_io_orig_8_dout = io_orig_8_dout; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign group_io_orig_9_dout = io_orig_9_dout; // @[MultiTileSRAMCoalesce.scala 96:24]
  assign group_io_coal_0_en = io_coal_0_0_en; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_0_we = io_coal_0_0_we; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_0_addr = {{1'd0}, io_coal_0_0_addr}; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_0_din = io_coal_0_0_din; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_1_en = io_coal_0_1_en; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_1_we = io_coal_0_1_we; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_1_addr = {{1'd0}, io_coal_0_1_addr}; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_1_din = io_coal_0_1_din; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_2_en = io_coal_0_2_en; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_2_we = io_coal_0_2_we; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_2_addr = {{1'd0}, io_coal_0_2_addr}; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_2_din = io_coal_0_2_din; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_3_en = io_coal_0_3_en; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_3_we = io_coal_0_3_we; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_3_addr = {{1'd0}, io_coal_0_3_addr}; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_3_din = io_coal_0_3_din; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_4_en = io_coal_0_4_en; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_4_we = io_coal_0_4_we; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_4_addr = {{1'd0}, io_coal_0_4_addr}; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_4_din = io_coal_0_4_din; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_5_en = io_coal_0_5_en; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_5_we = io_coal_0_5_we; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_5_addr = {{1'd0}, io_coal_0_5_addr}; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_5_din = io_coal_0_5_din; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_6_en = io_coal_0_6_en; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_6_we = io_coal_0_6_we; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_6_addr = {{1'd0}, io_coal_0_6_addr}; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_6_din = io_coal_0_6_din; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_7_en = io_coal_0_7_en; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_7_we = io_coal_0_7_we; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_7_addr = {{1'd0}, io_coal_0_7_addr}; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_7_din = io_coal_0_7_din; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_8_en = io_coal_0_8_en; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_8_we = io_coal_0_8_we; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_8_addr = {{1'd0}, io_coal_0_8_addr}; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_8_din = io_coal_0_8_din; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_9_en = io_coal_0_9_en; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_9_we = io_coal_0_9_we; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_9_addr = {{1'd0}, io_coal_0_9_addr}; // @[MultiTileSRAMCoalesce.scala 97:24]
  assign group_io_coal_9_din = io_coal_0_9_din; // @[MultiTileSRAMCoalesce.scala 97:24]
endmodule
module TileStateCtrl(
  input        clock,
  input        reset,
  input        io_cfgStartReq,
  input        io_cfgDoneIn,
  input        io_exeStartReq,
  input  [9:0] io_exeIobEnReq,
  input        io_exeDoneIn,
  output       io_cfgDone,
  output       io_exeDone,
  output       io_exeStartP,
  output [9:0] io_exeIobEn,
  output       io_exeEn
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] exeIobEnReg; // @[VitraCGRAController.scala 44:28]
  reg [2:0] tile_state; // @[VitraCGRAController.scala 49:27]
  wire [9:0] _GEN_1 = io_exeStartReq ? io_exeIobEnReq : exeIobEnReg; // @[VitraCGRAController.scala 56:32 58:21 44:28]
  wire [2:0] _GEN_4 = io_exeStartReq ? 3'h3 : tile_state; // @[VitraCGRAController.scala 69:32 71:20 49:27]
  wire [2:0] _GEN_5 = io_cfgDoneIn ? 3'h0 : _GEN_4; // @[VitraCGRAController.scala 66:25 67:20]
  wire [9:0] _GEN_6 = io_cfgDoneIn ? exeIobEnReg : _GEN_1; // @[VitraCGRAController.scala 66:25 44:28]
  wire [2:0] _GEN_7 = io_cfgDoneIn ? 3'h4 : tile_state; // @[VitraCGRAController.scala 76:25 77:19 49:27]
  wire [2:0] _GEN_8 = io_exeDoneIn ? 3'h0 : tile_state; // @[VitraCGRAController.scala 85:25 86:20 49:27]
  wire [2:0] _GEN_9 = 3'h5 == tile_state ? _GEN_8 : tile_state; // @[VitraCGRAController.scala 51:21 49:27]
  wire [2:0] _GEN_10 = 3'h4 == tile_state ? 3'h5 : _GEN_9; // @[VitraCGRAController.scala 51:21 82:18]
  wire [2:0] _GEN_11 = 3'h3 == tile_state ? _GEN_7 : _GEN_10; // @[VitraCGRAController.scala 51:21]
  assign io_cfgDone = tile_state != 3'h1 & tile_state != 3'h2; // @[VitraCGRAController.scala 96:44]
  assign io_exeDone = tile_state != 3'h3 & tile_state != 3'h4 & tile_state != 3'h5; // @[VitraCGRAController.scala 97:72]
  assign io_exeStartP = tile_state == 3'h4; // @[VitraCGRAController.scala 99:30]
  assign io_exeIobEn = exeIobEnReg; // @[VitraCGRAController.scala 101:17]
  assign io_exeEn = tile_state == 3'h5; // @[VitraCGRAController.scala 100:30]
  always @(posedge clock) begin
    if (reset) begin // @[VitraCGRAController.scala 44:28]
      exeIobEnReg <= 10'h0; // @[VitraCGRAController.scala 44:28]
    end else if (3'h0 == tile_state) begin // @[VitraCGRAController.scala 51:21]
      if (!(io_cfgStartReq)) begin // @[VitraCGRAController.scala 53:27]
        if (io_exeStartReq) begin // @[VitraCGRAController.scala 56:32]
          exeIobEnReg <= io_exeIobEnReq; // @[VitraCGRAController.scala 58:21]
        end
      end
    end else if (!(3'h1 == tile_state)) begin // @[VitraCGRAController.scala 51:21]
      if (3'h2 == tile_state) begin // @[VitraCGRAController.scala 51:21]
        exeIobEnReg <= _GEN_6;
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 49:27]
      tile_state <= 3'h0; // @[VitraCGRAController.scala 49:27]
    end else if (3'h0 == tile_state) begin // @[VitraCGRAController.scala 51:21]
      if (io_cfgStartReq) begin // @[VitraCGRAController.scala 53:27]
        tile_state <= 3'h1; // @[VitraCGRAController.scala 54:23]
      end else if (io_exeStartReq) begin // @[VitraCGRAController.scala 56:32]
        tile_state <= 3'h4; // @[VitraCGRAController.scala 57:21]
      end
    end else if (3'h1 == tile_state) begin // @[VitraCGRAController.scala 51:21]
      tile_state <= 3'h2; // @[VitraCGRAController.scala 63:18]
    end else if (3'h2 == tile_state) begin // @[VitraCGRAController.scala 51:21]
      tile_state <= _GEN_5;
    end else begin
      tile_state <= _GEN_11;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  exeIobEnReg = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  tile_state = _RAND_1[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module VitraCGRAController(
  input         clock,
  input         reset,
  output        io_s_axilite_aw_ready,
  input         io_s_axilite_aw_valid,
  input  [7:0]  io_s_axilite_aw_bits_addr,
  output        io_s_axilite_w_ready,
  input         io_s_axilite_w_valid,
  input  [7:0]  io_s_axilite_w_bits_data,
  input         io_s_axilite_b_ready,
  output        io_s_axilite_b_valid,
  output        io_s_axilite_ar_ready,
  input         io_s_axilite_ar_valid,
  input  [7:0]  io_s_axilite_ar_bits_addr,
  input         io_s_axilite_r_ready,
  output        io_s_axilite_r_valid,
  output [7:0]  io_s_axilite_r_bits_data,
  output        io_srams_iob_0_en,
  output        io_srams_iob_0_we,
  output [11:0] io_srams_iob_0_addr,
  output [15:0] io_srams_iob_0_din,
  input  [15:0] io_srams_iob_0_dout,
  output        io_srams_iob_1_en,
  output        io_srams_iob_1_we,
  output [11:0] io_srams_iob_1_addr,
  output [15:0] io_srams_iob_1_din,
  input  [15:0] io_srams_iob_1_dout,
  output        io_srams_iob_2_en,
  output        io_srams_iob_2_we,
  output [11:0] io_srams_iob_2_addr,
  output [15:0] io_srams_iob_2_din,
  input  [15:0] io_srams_iob_2_dout,
  output        io_srams_iob_3_en,
  output        io_srams_iob_3_we,
  output [11:0] io_srams_iob_3_addr,
  output [15:0] io_srams_iob_3_din,
  input  [15:0] io_srams_iob_3_dout,
  output        io_srams_iob_4_en,
  output        io_srams_iob_4_we,
  output [11:0] io_srams_iob_4_addr,
  output [15:0] io_srams_iob_4_din,
  input  [15:0] io_srams_iob_4_dout,
  output        io_srams_iob_5_en,
  output        io_srams_iob_5_we,
  output [11:0] io_srams_iob_5_addr,
  output [15:0] io_srams_iob_5_din,
  input  [15:0] io_srams_iob_5_dout,
  output        io_srams_iob_6_en,
  output        io_srams_iob_6_we,
  output [11:0] io_srams_iob_6_addr,
  output [15:0] io_srams_iob_6_din,
  input  [15:0] io_srams_iob_6_dout,
  output        io_srams_iob_7_en,
  output        io_srams_iob_7_we,
  output [11:0] io_srams_iob_7_addr,
  output [15:0] io_srams_iob_7_din,
  input  [15:0] io_srams_iob_7_dout,
  output        io_srams_iob_8_en,
  output        io_srams_iob_8_we,
  output [11:0] io_srams_iob_8_addr,
  output [15:0] io_srams_iob_8_din,
  input  [15:0] io_srams_iob_8_dout,
  output        io_srams_iob_9_en,
  output        io_srams_iob_9_we,
  output [11:0] io_srams_iob_9_addr,
  output [15:0] io_srams_iob_9_din,
  input  [15:0] io_srams_iob_9_dout,
  output        io_sram_cfg_en,
  output [8:0]  io_sram_cfg_addr,
  input  [63:0] io_sram_cfg_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  wire  cgra_clock; // @[VitraCGRAController.scala 239:20]
  wire  cgra_reset; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_cfg_en_0; // @[VitraCGRAController.scala 239:20]
  wire [11:0] cgra_io_cfg_addr; // @[VitraCGRAController.scala 239:20]
  wire [31:0] cgra_io_cfg_data; // @[VitraCGRAController.scala 239:20]
  wire [9:0] cgra_io_iob_ens_0; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_en_0; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_start_0; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_done_0; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_srams_0_0_en; // @[VitraCGRAController.scala 239:20]
  wire [1:0] cgra_io_srams_0_0_we; // @[VitraCGRAController.scala 239:20]
  wire [14:0] cgra_io_srams_0_0_addr; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_0_din; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_0_dout; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_srams_0_1_en; // @[VitraCGRAController.scala 239:20]
  wire [1:0] cgra_io_srams_0_1_we; // @[VitraCGRAController.scala 239:20]
  wire [14:0] cgra_io_srams_0_1_addr; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_1_din; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_1_dout; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_srams_0_2_en; // @[VitraCGRAController.scala 239:20]
  wire [1:0] cgra_io_srams_0_2_we; // @[VitraCGRAController.scala 239:20]
  wire [14:0] cgra_io_srams_0_2_addr; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_2_din; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_2_dout; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_srams_0_3_en; // @[VitraCGRAController.scala 239:20]
  wire [1:0] cgra_io_srams_0_3_we; // @[VitraCGRAController.scala 239:20]
  wire [14:0] cgra_io_srams_0_3_addr; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_3_din; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_3_dout; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_srams_0_4_en; // @[VitraCGRAController.scala 239:20]
  wire [1:0] cgra_io_srams_0_4_we; // @[VitraCGRAController.scala 239:20]
  wire [14:0] cgra_io_srams_0_4_addr; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_4_din; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_4_dout; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_srams_0_5_en; // @[VitraCGRAController.scala 239:20]
  wire [1:0] cgra_io_srams_0_5_we; // @[VitraCGRAController.scala 239:20]
  wire [14:0] cgra_io_srams_0_5_addr; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_5_din; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_5_dout; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_srams_0_6_en; // @[VitraCGRAController.scala 239:20]
  wire [1:0] cgra_io_srams_0_6_we; // @[VitraCGRAController.scala 239:20]
  wire [14:0] cgra_io_srams_0_6_addr; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_6_din; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_6_dout; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_srams_0_7_en; // @[VitraCGRAController.scala 239:20]
  wire [1:0] cgra_io_srams_0_7_we; // @[VitraCGRAController.scala 239:20]
  wire [14:0] cgra_io_srams_0_7_addr; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_7_din; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_7_dout; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_srams_0_8_en; // @[VitraCGRAController.scala 239:20]
  wire [1:0] cgra_io_srams_0_8_we; // @[VitraCGRAController.scala 239:20]
  wire [14:0] cgra_io_srams_0_8_addr; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_8_din; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_8_dout; // @[VitraCGRAController.scala 239:20]
  wire  cgra_io_srams_0_9_en; // @[VitraCGRAController.scala 239:20]
  wire [1:0] cgra_io_srams_0_9_we; // @[VitraCGRAController.scala 239:20]
  wire [14:0] cgra_io_srams_0_9_addr; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_9_din; // @[VitraCGRAController.scala 239:20]
  wire [15:0] cgra_io_srams_0_9_dout; // @[VitraCGRAController.scala 239:20]
  wire  cfgCtrl_clock; // @[VitraCGRAController.scala 243:23]
  wire  cfgCtrl_reset; // @[VitraCGRAController.scala 243:23]
  wire  cfgCtrl_io_start; // @[VitraCGRAController.scala 243:23]
  wire  cfgCtrl_io_done; // @[VitraCGRAController.scala 243:23]
  wire [8:0] cfgCtrl_io_base_addr; // @[VitraCGRAController.scala 243:23]
  wire [11:0] cfgCtrl_io_cfg_num; // @[VitraCGRAController.scala 243:23]
  wire  cfgCtrl_io_sram_en; // @[VitraCGRAController.scala 243:23]
  wire [8:0] cfgCtrl_io_sram_addr; // @[VitraCGRAController.scala 243:23]
  wire [63:0] cfgCtrl_io_sram_dout; // @[VitraCGRAController.scala 243:23]
  wire  cfgCtrl_io_cfg_en; // @[VitraCGRAController.scala 243:23]
  wire [11:0] cfgCtrl_io_cfg_addr; // @[VitraCGRAController.scala 243:23]
  wire [31:0] cfgCtrl_io_cfg_data; // @[VitraCGRAController.scala 243:23]
  wire  sram_coalesce_iob_clock; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_0_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_0_we; // @[VitraCGRAController.scala 246:33]
  wire [11:0] sram_coalesce_iob_io_orig_0_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_0_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_0_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_1_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_1_we; // @[VitraCGRAController.scala 246:33]
  wire [11:0] sram_coalesce_iob_io_orig_1_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_1_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_1_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_2_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_2_we; // @[VitraCGRAController.scala 246:33]
  wire [11:0] sram_coalesce_iob_io_orig_2_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_2_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_2_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_3_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_3_we; // @[VitraCGRAController.scala 246:33]
  wire [11:0] sram_coalesce_iob_io_orig_3_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_3_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_3_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_4_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_4_we; // @[VitraCGRAController.scala 246:33]
  wire [11:0] sram_coalesce_iob_io_orig_4_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_4_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_4_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_5_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_5_we; // @[VitraCGRAController.scala 246:33]
  wire [11:0] sram_coalesce_iob_io_orig_5_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_5_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_5_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_6_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_6_we; // @[VitraCGRAController.scala 246:33]
  wire [11:0] sram_coalesce_iob_io_orig_6_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_6_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_6_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_7_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_7_we; // @[VitraCGRAController.scala 246:33]
  wire [11:0] sram_coalesce_iob_io_orig_7_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_7_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_7_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_8_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_8_we; // @[VitraCGRAController.scala 246:33]
  wire [11:0] sram_coalesce_iob_io_orig_8_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_8_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_8_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_9_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_orig_9_we; // @[VitraCGRAController.scala 246:33]
  wire [11:0] sram_coalesce_iob_io_orig_9_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_9_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_orig_9_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_0_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_0_we; // @[VitraCGRAController.scala 246:33]
  wire [14:0] sram_coalesce_iob_io_coal_0_0_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_0_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_0_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_1_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_1_we; // @[VitraCGRAController.scala 246:33]
  wire [14:0] sram_coalesce_iob_io_coal_0_1_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_1_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_1_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_2_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_2_we; // @[VitraCGRAController.scala 246:33]
  wire [14:0] sram_coalesce_iob_io_coal_0_2_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_2_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_2_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_3_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_3_we; // @[VitraCGRAController.scala 246:33]
  wire [14:0] sram_coalesce_iob_io_coal_0_3_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_3_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_3_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_4_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_4_we; // @[VitraCGRAController.scala 246:33]
  wire [14:0] sram_coalesce_iob_io_coal_0_4_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_4_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_4_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_5_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_5_we; // @[VitraCGRAController.scala 246:33]
  wire [14:0] sram_coalesce_iob_io_coal_0_5_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_5_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_5_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_6_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_6_we; // @[VitraCGRAController.scala 246:33]
  wire [14:0] sram_coalesce_iob_io_coal_0_6_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_6_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_6_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_7_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_7_we; // @[VitraCGRAController.scala 246:33]
  wire [14:0] sram_coalesce_iob_io_coal_0_7_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_7_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_7_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_8_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_8_we; // @[VitraCGRAController.scala 246:33]
  wire [14:0] sram_coalesce_iob_io_coal_0_8_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_8_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_8_dout; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_9_en; // @[VitraCGRAController.scala 246:33]
  wire  sram_coalesce_iob_io_coal_0_9_we; // @[VitraCGRAController.scala 246:33]
  wire [14:0] sram_coalesce_iob_io_coal_0_9_addr; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_9_din; // @[VitraCGRAController.scala 246:33]
  wire [15:0] sram_coalesce_iob_io_coal_0_9_dout; // @[VitraCGRAController.scala 246:33]
  wire  tileStates_0_clock; // @[VitraCGRAController.scala 340:43]
  wire  tileStates_0_reset; // @[VitraCGRAController.scala 340:43]
  wire  tileStates_0_io_cfgStartReq; // @[VitraCGRAController.scala 340:43]
  wire  tileStates_0_io_cfgDoneIn; // @[VitraCGRAController.scala 340:43]
  wire  tileStates_0_io_exeStartReq; // @[VitraCGRAController.scala 340:43]
  wire [9:0] tileStates_0_io_exeIobEnReq; // @[VitraCGRAController.scala 340:43]
  wire  tileStates_0_io_exeDoneIn; // @[VitraCGRAController.scala 340:43]
  wire  tileStates_0_io_cfgDone; // @[VitraCGRAController.scala 340:43]
  wire  tileStates_0_io_exeDone; // @[VitraCGRAController.scala 340:43]
  wire  tileStates_0_io_exeStartP; // @[VitraCGRAController.scala 340:43]
  wire [9:0] tileStates_0_io_exeIobEn; // @[VitraCGRAController.scala 340:43]
  wire  tileStates_0_io_exeEn; // @[VitraCGRAController.scala 340:43]
  reg [7:0] reg_cfg_base_addr_0; // @[VitraCGRAController.scala 159:67]
  reg [7:0] reg_cfg_base_addr_1; // @[VitraCGRAController.scala 159:67]
  reg [7:0] reg_cfg_num_0; // @[VitraCGRAController.scala 160:61]
  reg [7:0] reg_cfg_num_1; // @[VitraCGRAController.scala 160:61]
  reg [7:0] reg_cfg_en_tile_0; // @[VitraCGRAController.scala 161:64]
  reg  reg_cfg_en; // @[VitraCGRAController.scala 163:34]
  reg [7:0] reg_exe_iob_ens_0; // @[VitraCGRAController.scala 166:61]
  reg [7:0] reg_exe_iob_ens_1; // @[VitraCGRAController.scala 166:61]
  reg  reg_exe_start; // @[VitraCGRAController.scala 167:34]
  reg [8:0] cfg_base_addr; // @[VitraCGRAController.scala 257:30]
  reg [11:0] cfg_num; // @[VitraCGRAController.scala 258:30]
  reg  cfg_en_tiles; // @[VitraCGRAController.scala 259:30]
  reg [9:0] iob_ens; // @[VitraCGRAController.scala 260:30]
  reg  cfg_start; // @[VitraCGRAController.scala 261:30]
  reg  exe_start; // @[VitraCGRAController.scala 262:30]
  wire  _exe_en_tiles_T_1 = |iob_ens; // @[VitraCGRAController.scala 267:21]
  reg [2:0] cgra_state; // @[VitraCGRAController.scala 282:27]
  wire [15:0] _cfg_base_addr_T = {reg_cfg_base_addr_1,reg_cfg_base_addr_0}; // @[Cat.scala 33:92]
  wire [15:0] _cfg_num_T = {reg_cfg_num_1,reg_cfg_num_0}; // @[Cat.scala 33:92]
  wire [15:0] _iob_ens_T = {reg_exe_iob_ens_1,reg_exe_iob_ens_0}; // @[Cat.scala 33:92]
  wire [2:0] _GEN_0 = reg_exe_start ? 3'h4 : cgra_state; // @[VitraCGRAController.scala 293:31 294:21 282:27]
  wire [9:0] _GEN_1 = reg_exe_start ? _iob_ens_T[9:0] : iob_ens; // @[VitraCGRAController.scala 293:31 295:17 260:30]
  wire [15:0] _GEN_3 = reg_cfg_en ? _cfg_base_addr_T : {{7'd0}, cfg_base_addr}; // @[VitraCGRAController.scala 287:23 289:23 257:30]
  wire [15:0] _GEN_4 = reg_cfg_en ? _cfg_num_T : {{4'd0}, cfg_num}; // @[VitraCGRAController.scala 287:23 290:23 258:30]
  wire [7:0] _GEN_5 = reg_cfg_en ? reg_cfg_en_tile_0 : {{7'd0}, cfg_en_tiles}; // @[VitraCGRAController.scala 287:23 291:23 259:30]
  wire  _cfg_avail_T = cgra_state == 3'h0; // @[VitraCGRAController.scala 364:29]
  wire  _cfg_avail_T_1 = cgra_state == 3'h1; // @[VitraCGRAController.scala 364:58]
  wire  _cfg_avail_T_2 = cgra_state == 3'h0 | cgra_state == 3'h1; // @[VitraCGRAController.scala 364:45]
  wire  tile_cfg_done_0 = tileStates_0_io_cfgDone; // @[VitraCGRAController.scala 273:27 351:31]
  wire  _cfg_avail_T_3 = ~tile_cfg_done_0; // @[VitraCGRAController.scala 365:37]
  wire  _cfg_avail_T_7 = _cfg_avail_T_2 & ~(|(cfg_en_tiles & ~tile_cfg_done_0)); // @[VitraCGRAController.scala 365:17]
  wire  tile_exe_run_0 = tileStates_0_io_exeEn | tileStates_0_io_exeStartP; // @[VitraCGRAController.scala 355:53]
  wire  cfg_avail = _cfg_avail_T_7 & ~(|(cfg_en_tiles & tile_exe_run_0)); // @[VitraCGRAController.scala 366:17]
  wire  _GEN_8 = cfg_avail | cfg_start; // @[VitraCGRAController.scala 300:22 302:20 261:30]
  wire [2:0] _GEN_10 = cfgCtrl_io_done ? 3'h0 : _GEN_0; // @[VitraCGRAController.scala 308:28 309:20]
  wire [9:0] _GEN_11 = cfgCtrl_io_done ? iob_ens : _GEN_1; // @[VitraCGRAController.scala 308:28 260:30]
  wire  _exe_avail_T = cgra_state != 3'h5; // @[VitraCGRAController.scala 368:28]
  wire  _exe_avail_T_5 = _exe_avail_T & ~(|(_exe_en_tiles_T_1 & _cfg_avail_T_3)); // @[VitraCGRAController.scala 369:17]
  wire  exe_avail = _exe_avail_T_5 & ~(|(_exe_en_tiles_T_1 & tile_exe_run_0)); // @[VitraCGRAController.scala 370:17]
  wire [2:0] _GEN_12 = exe_avail ? 3'h5 : cgra_state; // @[VitraCGRAController.scala 318:22 319:19 282:27]
  wire  _GEN_13 = exe_avail | exe_start; // @[VitraCGRAController.scala 318:22 320:19 262:30]
  wire [2:0] _GEN_14 = cfgCtrl_io_done ? 3'h0 : 3'h3; // @[VitraCGRAController.scala 327:28 328:20 331:20]
  wire  _GEN_15 = 3'h5 == cgra_state ? 1'h0 : exe_start; // @[VitraCGRAController.scala 284:21 326:17 262:30]
  wire [2:0] _GEN_16 = 3'h5 == cgra_state ? _GEN_14 : cgra_state; // @[VitraCGRAController.scala 284:21 282:27]
  wire [2:0] _GEN_17 = 3'h4 == cgra_state ? _GEN_12 : _GEN_16; // @[VitraCGRAController.scala 284:21]
  wire  _GEN_18 = 3'h4 == cgra_state ? _GEN_13 : _GEN_15; // @[VitraCGRAController.scala 284:21]
  wire [15:0] _GEN_28 = 3'h0 == cgra_state ? _GEN_3 : {{7'd0}, cfg_base_addr}; // @[VitraCGRAController.scala 284:21 257:30]
  wire [15:0] _GEN_29 = 3'h0 == cgra_state ? _GEN_4 : {{4'd0}, cfg_num}; // @[VitraCGRAController.scala 284:21 258:30]
  wire [7:0] _GEN_30 = 3'h0 == cgra_state ? _GEN_5 : {{7'd0}, cfg_en_tiles}; // @[VitraCGRAController.scala 284:21 259:30]
  reg [7:0] w_reg_addr; // @[VitraCGRAController.scala 380:27]
  reg [2:0] w_state; // @[VitraCGRAController.scala 384:24]
  wire  _T_6 = io_s_axilite_aw_ready & io_s_axilite_aw_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _w_state_T_2 = io_s_axilite_aw_bits_addr == 8'h8 ? 3'h2 : 3'h3; // @[VitraCGRAController.scala 392:30]
  wire  _T_8 = io_s_axilite_w_ready & io_s_axilite_w_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _GEN_36 = _T_8 ? 3'h4 : w_state; // @[VitraCGRAController.scala 401:33 403:17 384:24]
  wire [7:0] _reg_cfg_base_addr_0_T_1 = w_reg_addr == 8'h0 ? io_s_axilite_w_bits_data : reg_cfg_base_addr_0; // @[VitraCGRAController.scala 416:38]
  wire [7:0] _reg_cfg_base_addr_1_T_1 = w_reg_addr == 8'h1 ? io_s_axilite_w_bits_data : reg_cfg_base_addr_1; // @[VitraCGRAController.scala 416:38]
  wire [7:0] _reg_cfg_num_0_T_1 = w_reg_addr == 8'h2 ? io_s_axilite_w_bits_data : reg_cfg_num_0; // @[VitraCGRAController.scala 422:32]
  wire [7:0] _reg_cfg_num_1_T_1 = w_reg_addr == 8'h3 ? io_s_axilite_w_bits_data : reg_cfg_num_1; // @[VitraCGRAController.scala 422:32]
  wire [7:0] _reg_cfg_en_tile_0_T_1 = w_reg_addr == 8'h4 ? io_s_axilite_w_bits_data : reg_cfg_en_tile_0; // @[VitraCGRAController.scala 428:36]
  wire [7:0] _reg_exe_iob_ens_0_T_1 = w_reg_addr == 8'h6 ? io_s_axilite_w_bits_data : reg_exe_iob_ens_0; // @[VitraCGRAController.scala 437:36]
  wire [7:0] _reg_exe_iob_ens_1_T_1 = w_reg_addr == 8'h7 ? io_s_axilite_w_bits_data : reg_exe_iob_ens_1; // @[VitraCGRAController.scala 437:36]
  wire [7:0] _GEN_38 = _T_8 ? _reg_cfg_base_addr_0_T_1 : reg_cfg_base_addr_0; // @[VitraCGRAController.scala 413:33 416:32 159:67]
  wire [7:0] _GEN_39 = _T_8 ? _reg_cfg_base_addr_1_T_1 : reg_cfg_base_addr_1; // @[VitraCGRAController.scala 413:33 416:32 159:67]
  wire [7:0] _GEN_40 = _T_8 ? _reg_cfg_num_0_T_1 : reg_cfg_num_0; // @[VitraCGRAController.scala 413:33 422:26 160:61]
  wire [7:0] _GEN_41 = _T_8 ? _reg_cfg_num_1_T_1 : reg_cfg_num_1; // @[VitraCGRAController.scala 413:33 422:26 160:61]
  wire [7:0] _GEN_42 = _T_8 ? _reg_cfg_en_tile_0_T_1 : reg_cfg_en_tile_0; // @[VitraCGRAController.scala 413:33 428:30 161:64]
  wire [7:0] _GEN_43 = _T_8 ? _reg_exe_iob_ens_0_T_1 : reg_exe_iob_ens_0; // @[VitraCGRAController.scala 413:33 437:30 166:61]
  wire [7:0] _GEN_44 = _T_8 ? _reg_exe_iob_ens_1_T_1 : reg_exe_iob_ens_1; // @[VitraCGRAController.scala 413:33 437:30 166:61]
  wire  _T_14 = io_s_axilite_b_ready & io_s_axilite_b_valid; // @[Decoupled.scala 51:35]
  wire [2:0] _GEN_46 = _T_14 ? 3'h0 : w_state; // @[VitraCGRAController.scala 450:32 451:17 384:24]
  wire [2:0] _GEN_47 = 3'h4 == w_state ? _GEN_46 : w_state; // @[VitraCGRAController.scala 386:18 384:24]
  wire [7:0] _GEN_48 = 3'h3 == w_state ? _GEN_38 : reg_cfg_base_addr_0; // @[VitraCGRAController.scala 386:18 159:67]
  wire [7:0] _GEN_49 = 3'h3 == w_state ? _GEN_39 : reg_cfg_base_addr_1; // @[VitraCGRAController.scala 386:18 159:67]
  wire [7:0] _GEN_50 = 3'h3 == w_state ? _GEN_40 : reg_cfg_num_0; // @[VitraCGRAController.scala 386:18 160:61]
  wire [7:0] _GEN_51 = 3'h3 == w_state ? _GEN_41 : reg_cfg_num_1; // @[VitraCGRAController.scala 386:18 160:61]
  wire [7:0] _GEN_52 = 3'h3 == w_state ? _GEN_42 : reg_cfg_en_tile_0; // @[VitraCGRAController.scala 386:18 161:64]
  wire [7:0] _GEN_53 = 3'h3 == w_state ? _GEN_43 : reg_exe_iob_ens_0; // @[VitraCGRAController.scala 386:18 166:61]
  wire [7:0] _GEN_54 = 3'h3 == w_state ? _GEN_44 : reg_exe_iob_ens_1; // @[VitraCGRAController.scala 386:18 166:61]
  wire [2:0] _GEN_55 = 3'h3 == w_state ? _GEN_36 : _GEN_47; // @[VitraCGRAController.scala 386:18]
  wire  _T_15 = w_state == 3'h1; // @[VitraCGRAController.scala 459:16]
  wire  _T_18 = w_state == 3'h2; // @[VitraCGRAController.scala 462:21]
  wire  _T_20 = cgra_state == 3'h3; // @[VitraCGRAController.scala 463:54]
  wire  _T_23 = w_state == 3'h3; // @[VitraCGRAController.scala 466:21]
  wire  _GEN_82 = _T_18 & (_cfg_avail_T | cgra_state == 3'h3) | _T_23; // @[VitraCGRAController.scala 463:74 464:26]
  reg [7:0] r_reg_addr; // @[VitraCGRAController.scala 481:27]
  reg  r_state; // @[VitraCGRAController.scala 485:24]
  wire  _T_25 = io_s_axilite_ar_ready & io_s_axilite_ar_valid; // @[Decoupled.scala 51:35]
  wire  _GEN_84 = _T_25 | r_state; // @[VitraCGRAController.scala 489:33 490:17 485:24]
  wire  _T_27 = io_s_axilite_r_ready & io_s_axilite_r_valid; // @[Decoupled.scala 51:35]
  wire [7:0] _r_data_T_1 = 8'h2 == r_reg_addr ? reg_cfg_num_0 : 8'h0; // @[Mux.scala 81:58]
  wire [7:0] _r_data_T_3 = 8'h3 == r_reg_addr ? reg_cfg_num_1 : _r_data_T_1; // @[Mux.scala 81:58]
  wire [7:0] _r_data_T_5 = 8'h6 == r_reg_addr ? reg_exe_iob_ens_0 : _r_data_T_3; // @[Mux.scala 81:58]
  wire [7:0] _r_data_T_7 = 8'h0 == r_reg_addr ? reg_cfg_base_addr_0 : _r_data_T_5; // @[Mux.scala 81:58]
  wire [7:0] _r_data_T_9 = 8'h5 == r_reg_addr ? {{7'd0}, reg_cfg_en} : _r_data_T_7; // @[Mux.scala 81:58]
  wire [7:0] reg_exe_done_0 = {{7'd0}, tileStates_0_io_exeDone}; // @[VitraCGRAController.scala 171:55 352:40]
  wire [7:0] _r_data_T_11 = 8'h9 == r_reg_addr ? reg_exe_done_0 : _r_data_T_9; // @[Mux.scala 81:58]
  wire [7:0] _r_data_T_13 = 8'h1 == r_reg_addr ? reg_cfg_base_addr_1 : _r_data_T_11; // @[Mux.scala 81:58]
  wire [7:0] _r_data_T_15 = 8'h4 == r_reg_addr ? reg_cfg_en_tile_0 : _r_data_T_13; // @[Mux.scala 81:58]
  wire [7:0] _r_data_T_17 = 8'h8 == r_reg_addr ? {{7'd0}, reg_exe_start} : _r_data_T_15; // @[Mux.scala 81:58]
  wire  _reg_exe_start_next_T_6 = _cfg_avail_T_1 | cgra_state == 3'h4 | cgra_state == 3'h5; // @[VitraCGRAController.scala 522:62]
  wire [15:0] _GEN_90 = reset ? 16'h0 : _GEN_28; // @[VitraCGRAController.scala 257:{30,30}]
  wire [15:0] _GEN_91 = reset ? 16'h0 : _GEN_29; // @[VitraCGRAController.scala 258:{30,30}]
  wire [7:0] _GEN_92 = reset ? 8'h0 : _GEN_30; // @[VitraCGRAController.scala 259:{30,30}]
  CGRA cgra ( // @[VitraCGRAController.scala 239:20]
    .clock(cgra_clock),
    .reset(cgra_reset),
    .io_cfg_en_0(cgra_io_cfg_en_0),
    .io_cfg_addr(cgra_io_cfg_addr),
    .io_cfg_data(cgra_io_cfg_data),
    .io_iob_ens_0(cgra_io_iob_ens_0),
    .io_en_0(cgra_io_en_0),
    .io_start_0(cgra_io_start_0),
    .io_done_0(cgra_io_done_0),
    .io_srams_0_0_en(cgra_io_srams_0_0_en),
    .io_srams_0_0_we(cgra_io_srams_0_0_we),
    .io_srams_0_0_addr(cgra_io_srams_0_0_addr),
    .io_srams_0_0_din(cgra_io_srams_0_0_din),
    .io_srams_0_0_dout(cgra_io_srams_0_0_dout),
    .io_srams_0_1_en(cgra_io_srams_0_1_en),
    .io_srams_0_1_we(cgra_io_srams_0_1_we),
    .io_srams_0_1_addr(cgra_io_srams_0_1_addr),
    .io_srams_0_1_din(cgra_io_srams_0_1_din),
    .io_srams_0_1_dout(cgra_io_srams_0_1_dout),
    .io_srams_0_2_en(cgra_io_srams_0_2_en),
    .io_srams_0_2_we(cgra_io_srams_0_2_we),
    .io_srams_0_2_addr(cgra_io_srams_0_2_addr),
    .io_srams_0_2_din(cgra_io_srams_0_2_din),
    .io_srams_0_2_dout(cgra_io_srams_0_2_dout),
    .io_srams_0_3_en(cgra_io_srams_0_3_en),
    .io_srams_0_3_we(cgra_io_srams_0_3_we),
    .io_srams_0_3_addr(cgra_io_srams_0_3_addr),
    .io_srams_0_3_din(cgra_io_srams_0_3_din),
    .io_srams_0_3_dout(cgra_io_srams_0_3_dout),
    .io_srams_0_4_en(cgra_io_srams_0_4_en),
    .io_srams_0_4_we(cgra_io_srams_0_4_we),
    .io_srams_0_4_addr(cgra_io_srams_0_4_addr),
    .io_srams_0_4_din(cgra_io_srams_0_4_din),
    .io_srams_0_4_dout(cgra_io_srams_0_4_dout),
    .io_srams_0_5_en(cgra_io_srams_0_5_en),
    .io_srams_0_5_we(cgra_io_srams_0_5_we),
    .io_srams_0_5_addr(cgra_io_srams_0_5_addr),
    .io_srams_0_5_din(cgra_io_srams_0_5_din),
    .io_srams_0_5_dout(cgra_io_srams_0_5_dout),
    .io_srams_0_6_en(cgra_io_srams_0_6_en),
    .io_srams_0_6_we(cgra_io_srams_0_6_we),
    .io_srams_0_6_addr(cgra_io_srams_0_6_addr),
    .io_srams_0_6_din(cgra_io_srams_0_6_din),
    .io_srams_0_6_dout(cgra_io_srams_0_6_dout),
    .io_srams_0_7_en(cgra_io_srams_0_7_en),
    .io_srams_0_7_we(cgra_io_srams_0_7_we),
    .io_srams_0_7_addr(cgra_io_srams_0_7_addr),
    .io_srams_0_7_din(cgra_io_srams_0_7_din),
    .io_srams_0_7_dout(cgra_io_srams_0_7_dout),
    .io_srams_0_8_en(cgra_io_srams_0_8_en),
    .io_srams_0_8_we(cgra_io_srams_0_8_we),
    .io_srams_0_8_addr(cgra_io_srams_0_8_addr),
    .io_srams_0_8_din(cgra_io_srams_0_8_din),
    .io_srams_0_8_dout(cgra_io_srams_0_8_dout),
    .io_srams_0_9_en(cgra_io_srams_0_9_en),
    .io_srams_0_9_we(cgra_io_srams_0_9_we),
    .io_srams_0_9_addr(cgra_io_srams_0_9_addr),
    .io_srams_0_9_din(cgra_io_srams_0_9_din),
    .io_srams_0_9_dout(cgra_io_srams_0_9_dout)
  );
  ConfigController cfgCtrl ( // @[VitraCGRAController.scala 243:23]
    .clock(cfgCtrl_clock),
    .reset(cfgCtrl_reset),
    .io_start(cfgCtrl_io_start),
    .io_done(cfgCtrl_io_done),
    .io_base_addr(cfgCtrl_io_base_addr),
    .io_cfg_num(cfgCtrl_io_cfg_num),
    .io_sram_en(cfgCtrl_io_sram_en),
    .io_sram_addr(cfgCtrl_io_sram_addr),
    .io_sram_dout(cfgCtrl_io_sram_dout),
    .io_cfg_en(cfgCtrl_io_cfg_en),
    .io_cfg_addr(cfgCtrl_io_cfg_addr),
    .io_cfg_data(cfgCtrl_io_cfg_data)
  );
  MultiTileSRAMCoalesce sram_coalesce_iob ( // @[VitraCGRAController.scala 246:33]
    .clock(sram_coalesce_iob_clock),
    .io_orig_0_en(sram_coalesce_iob_io_orig_0_en),
    .io_orig_0_we(sram_coalesce_iob_io_orig_0_we),
    .io_orig_0_addr(sram_coalesce_iob_io_orig_0_addr),
    .io_orig_0_din(sram_coalesce_iob_io_orig_0_din),
    .io_orig_0_dout(sram_coalesce_iob_io_orig_0_dout),
    .io_orig_1_en(sram_coalesce_iob_io_orig_1_en),
    .io_orig_1_we(sram_coalesce_iob_io_orig_1_we),
    .io_orig_1_addr(sram_coalesce_iob_io_orig_1_addr),
    .io_orig_1_din(sram_coalesce_iob_io_orig_1_din),
    .io_orig_1_dout(sram_coalesce_iob_io_orig_1_dout),
    .io_orig_2_en(sram_coalesce_iob_io_orig_2_en),
    .io_orig_2_we(sram_coalesce_iob_io_orig_2_we),
    .io_orig_2_addr(sram_coalesce_iob_io_orig_2_addr),
    .io_orig_2_din(sram_coalesce_iob_io_orig_2_din),
    .io_orig_2_dout(sram_coalesce_iob_io_orig_2_dout),
    .io_orig_3_en(sram_coalesce_iob_io_orig_3_en),
    .io_orig_3_we(sram_coalesce_iob_io_orig_3_we),
    .io_orig_3_addr(sram_coalesce_iob_io_orig_3_addr),
    .io_orig_3_din(sram_coalesce_iob_io_orig_3_din),
    .io_orig_3_dout(sram_coalesce_iob_io_orig_3_dout),
    .io_orig_4_en(sram_coalesce_iob_io_orig_4_en),
    .io_orig_4_we(sram_coalesce_iob_io_orig_4_we),
    .io_orig_4_addr(sram_coalesce_iob_io_orig_4_addr),
    .io_orig_4_din(sram_coalesce_iob_io_orig_4_din),
    .io_orig_4_dout(sram_coalesce_iob_io_orig_4_dout),
    .io_orig_5_en(sram_coalesce_iob_io_orig_5_en),
    .io_orig_5_we(sram_coalesce_iob_io_orig_5_we),
    .io_orig_5_addr(sram_coalesce_iob_io_orig_5_addr),
    .io_orig_5_din(sram_coalesce_iob_io_orig_5_din),
    .io_orig_5_dout(sram_coalesce_iob_io_orig_5_dout),
    .io_orig_6_en(sram_coalesce_iob_io_orig_6_en),
    .io_orig_6_we(sram_coalesce_iob_io_orig_6_we),
    .io_orig_6_addr(sram_coalesce_iob_io_orig_6_addr),
    .io_orig_6_din(sram_coalesce_iob_io_orig_6_din),
    .io_orig_6_dout(sram_coalesce_iob_io_orig_6_dout),
    .io_orig_7_en(sram_coalesce_iob_io_orig_7_en),
    .io_orig_7_we(sram_coalesce_iob_io_orig_7_we),
    .io_orig_7_addr(sram_coalesce_iob_io_orig_7_addr),
    .io_orig_7_din(sram_coalesce_iob_io_orig_7_din),
    .io_orig_7_dout(sram_coalesce_iob_io_orig_7_dout),
    .io_orig_8_en(sram_coalesce_iob_io_orig_8_en),
    .io_orig_8_we(sram_coalesce_iob_io_orig_8_we),
    .io_orig_8_addr(sram_coalesce_iob_io_orig_8_addr),
    .io_orig_8_din(sram_coalesce_iob_io_orig_8_din),
    .io_orig_8_dout(sram_coalesce_iob_io_orig_8_dout),
    .io_orig_9_en(sram_coalesce_iob_io_orig_9_en),
    .io_orig_9_we(sram_coalesce_iob_io_orig_9_we),
    .io_orig_9_addr(sram_coalesce_iob_io_orig_9_addr),
    .io_orig_9_din(sram_coalesce_iob_io_orig_9_din),
    .io_orig_9_dout(sram_coalesce_iob_io_orig_9_dout),
    .io_coal_0_0_en(sram_coalesce_iob_io_coal_0_0_en),
    .io_coal_0_0_we(sram_coalesce_iob_io_coal_0_0_we),
    .io_coal_0_0_addr(sram_coalesce_iob_io_coal_0_0_addr),
    .io_coal_0_0_din(sram_coalesce_iob_io_coal_0_0_din),
    .io_coal_0_0_dout(sram_coalesce_iob_io_coal_0_0_dout),
    .io_coal_0_1_en(sram_coalesce_iob_io_coal_0_1_en),
    .io_coal_0_1_we(sram_coalesce_iob_io_coal_0_1_we),
    .io_coal_0_1_addr(sram_coalesce_iob_io_coal_0_1_addr),
    .io_coal_0_1_din(sram_coalesce_iob_io_coal_0_1_din),
    .io_coal_0_1_dout(sram_coalesce_iob_io_coal_0_1_dout),
    .io_coal_0_2_en(sram_coalesce_iob_io_coal_0_2_en),
    .io_coal_0_2_we(sram_coalesce_iob_io_coal_0_2_we),
    .io_coal_0_2_addr(sram_coalesce_iob_io_coal_0_2_addr),
    .io_coal_0_2_din(sram_coalesce_iob_io_coal_0_2_din),
    .io_coal_0_2_dout(sram_coalesce_iob_io_coal_0_2_dout),
    .io_coal_0_3_en(sram_coalesce_iob_io_coal_0_3_en),
    .io_coal_0_3_we(sram_coalesce_iob_io_coal_0_3_we),
    .io_coal_0_3_addr(sram_coalesce_iob_io_coal_0_3_addr),
    .io_coal_0_3_din(sram_coalesce_iob_io_coal_0_3_din),
    .io_coal_0_3_dout(sram_coalesce_iob_io_coal_0_3_dout),
    .io_coal_0_4_en(sram_coalesce_iob_io_coal_0_4_en),
    .io_coal_0_4_we(sram_coalesce_iob_io_coal_0_4_we),
    .io_coal_0_4_addr(sram_coalesce_iob_io_coal_0_4_addr),
    .io_coal_0_4_din(sram_coalesce_iob_io_coal_0_4_din),
    .io_coal_0_4_dout(sram_coalesce_iob_io_coal_0_4_dout),
    .io_coal_0_5_en(sram_coalesce_iob_io_coal_0_5_en),
    .io_coal_0_5_we(sram_coalesce_iob_io_coal_0_5_we),
    .io_coal_0_5_addr(sram_coalesce_iob_io_coal_0_5_addr),
    .io_coal_0_5_din(sram_coalesce_iob_io_coal_0_5_din),
    .io_coal_0_5_dout(sram_coalesce_iob_io_coal_0_5_dout),
    .io_coal_0_6_en(sram_coalesce_iob_io_coal_0_6_en),
    .io_coal_0_6_we(sram_coalesce_iob_io_coal_0_6_we),
    .io_coal_0_6_addr(sram_coalesce_iob_io_coal_0_6_addr),
    .io_coal_0_6_din(sram_coalesce_iob_io_coal_0_6_din),
    .io_coal_0_6_dout(sram_coalesce_iob_io_coal_0_6_dout),
    .io_coal_0_7_en(sram_coalesce_iob_io_coal_0_7_en),
    .io_coal_0_7_we(sram_coalesce_iob_io_coal_0_7_we),
    .io_coal_0_7_addr(sram_coalesce_iob_io_coal_0_7_addr),
    .io_coal_0_7_din(sram_coalesce_iob_io_coal_0_7_din),
    .io_coal_0_7_dout(sram_coalesce_iob_io_coal_0_7_dout),
    .io_coal_0_8_en(sram_coalesce_iob_io_coal_0_8_en),
    .io_coal_0_8_we(sram_coalesce_iob_io_coal_0_8_we),
    .io_coal_0_8_addr(sram_coalesce_iob_io_coal_0_8_addr),
    .io_coal_0_8_din(sram_coalesce_iob_io_coal_0_8_din),
    .io_coal_0_8_dout(sram_coalesce_iob_io_coal_0_8_dout),
    .io_coal_0_9_en(sram_coalesce_iob_io_coal_0_9_en),
    .io_coal_0_9_we(sram_coalesce_iob_io_coal_0_9_we),
    .io_coal_0_9_addr(sram_coalesce_iob_io_coal_0_9_addr),
    .io_coal_0_9_din(sram_coalesce_iob_io_coal_0_9_din),
    .io_coal_0_9_dout(sram_coalesce_iob_io_coal_0_9_dout)
  );
  TileStateCtrl tileStates_0 ( // @[VitraCGRAController.scala 340:43]
    .clock(tileStates_0_clock),
    .reset(tileStates_0_reset),
    .io_cfgStartReq(tileStates_0_io_cfgStartReq),
    .io_cfgDoneIn(tileStates_0_io_cfgDoneIn),
    .io_exeStartReq(tileStates_0_io_exeStartReq),
    .io_exeIobEnReq(tileStates_0_io_exeIobEnReq),
    .io_exeDoneIn(tileStates_0_io_exeDoneIn),
    .io_cfgDone(tileStates_0_io_cfgDone),
    .io_exeDone(tileStates_0_io_exeDone),
    .io_exeStartP(tileStates_0_io_exeStartP),
    .io_exeIobEn(tileStates_0_io_exeIobEn),
    .io_exeEn(tileStates_0_io_exeEn)
  );
  assign io_s_axilite_aw_ready = w_state == 3'h0; // @[VitraCGRAController.scala 457:38]
  assign io_s_axilite_w_ready = w_state == 3'h1 & _cfg_avail_T | _GEN_82; // @[VitraCGRAController.scala 459:66 460:26]
  assign io_s_axilite_b_valid = w_state == 3'h4; // @[VitraCGRAController.scala 474:41]
  assign io_s_axilite_ar_ready = ~r_state; // @[VitraCGRAController.scala 531:41]
  assign io_s_axilite_r_valid = r_state; // @[VitraCGRAController.scala 533:41]
  assign io_s_axilite_r_bits_data = 8'h7 == r_reg_addr ? reg_exe_iob_ens_1 : _r_data_T_17; // @[Mux.scala 81:58]
  assign io_srams_iob_0_en = sram_coalesce_iob_io_orig_0_en; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_0_we = sram_coalesce_iob_io_orig_0_we; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_0_addr = sram_coalesce_iob_io_orig_0_addr; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_0_din = sram_coalesce_iob_io_orig_0_din; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_1_en = sram_coalesce_iob_io_orig_1_en; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_1_we = sram_coalesce_iob_io_orig_1_we; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_1_addr = sram_coalesce_iob_io_orig_1_addr; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_1_din = sram_coalesce_iob_io_orig_1_din; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_2_en = sram_coalesce_iob_io_orig_2_en; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_2_we = sram_coalesce_iob_io_orig_2_we; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_2_addr = sram_coalesce_iob_io_orig_2_addr; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_2_din = sram_coalesce_iob_io_orig_2_din; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_3_en = sram_coalesce_iob_io_orig_3_en; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_3_we = sram_coalesce_iob_io_orig_3_we; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_3_addr = sram_coalesce_iob_io_orig_3_addr; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_3_din = sram_coalesce_iob_io_orig_3_din; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_4_en = sram_coalesce_iob_io_orig_4_en; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_4_we = sram_coalesce_iob_io_orig_4_we; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_4_addr = sram_coalesce_iob_io_orig_4_addr; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_4_din = sram_coalesce_iob_io_orig_4_din; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_5_en = sram_coalesce_iob_io_orig_5_en; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_5_we = sram_coalesce_iob_io_orig_5_we; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_5_addr = sram_coalesce_iob_io_orig_5_addr; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_5_din = sram_coalesce_iob_io_orig_5_din; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_6_en = sram_coalesce_iob_io_orig_6_en; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_6_we = sram_coalesce_iob_io_orig_6_we; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_6_addr = sram_coalesce_iob_io_orig_6_addr; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_6_din = sram_coalesce_iob_io_orig_6_din; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_7_en = sram_coalesce_iob_io_orig_7_en; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_7_we = sram_coalesce_iob_io_orig_7_we; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_7_addr = sram_coalesce_iob_io_orig_7_addr; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_7_din = sram_coalesce_iob_io_orig_7_din; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_8_en = sram_coalesce_iob_io_orig_8_en; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_8_we = sram_coalesce_iob_io_orig_8_we; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_8_addr = sram_coalesce_iob_io_orig_8_addr; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_8_din = sram_coalesce_iob_io_orig_8_din; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_9_en = sram_coalesce_iob_io_orig_9_en; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_9_we = sram_coalesce_iob_io_orig_9_we; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_9_addr = sram_coalesce_iob_io_orig_9_addr; // @[VitraCGRAController.scala 249:21]
  assign io_srams_iob_9_din = sram_coalesce_iob_io_orig_9_din; // @[VitraCGRAController.scala 249:21]
  assign io_sram_cfg_en = cfgCtrl_io_sram_en; // @[VitraCGRAController.scala 250:21]
  assign io_sram_cfg_addr = cfgCtrl_io_sram_addr; // @[VitraCGRAController.scala 250:21]
  assign cgra_clock = clock;
  assign cgra_reset = reset;
  assign cgra_io_cfg_en_0 = cfg_en_tiles & cfgCtrl_io_cfg_en; // @[VitraCGRAController.scala 354:52]
  assign cgra_io_cfg_addr = cfgCtrl_io_cfg_addr; // @[VitraCGRAController.scala 253:21]
  assign cgra_io_cfg_data = cfgCtrl_io_cfg_data; // @[VitraCGRAController.scala 254:21]
  assign cgra_io_iob_ens_0 = tileStates_0_io_exeIobEn; // @[VitraCGRAController.scala 350:31]
  assign cgra_io_en_0 = tileStates_0_io_exeEn; // @[VitraCGRAController.scala 349:31]
  assign cgra_io_start_0 = tileStates_0_io_exeStartP; // @[VitraCGRAController.scala 348:31]
  assign cgra_io_srams_0_0_dout = sram_coalesce_iob_io_coal_0_0_dout; // @[VitraCGRAController.scala 248:21]
  assign cgra_io_srams_0_1_dout = sram_coalesce_iob_io_coal_0_1_dout; // @[VitraCGRAController.scala 248:21]
  assign cgra_io_srams_0_2_dout = sram_coalesce_iob_io_coal_0_2_dout; // @[VitraCGRAController.scala 248:21]
  assign cgra_io_srams_0_3_dout = sram_coalesce_iob_io_coal_0_3_dout; // @[VitraCGRAController.scala 248:21]
  assign cgra_io_srams_0_4_dout = sram_coalesce_iob_io_coal_0_4_dout; // @[VitraCGRAController.scala 248:21]
  assign cgra_io_srams_0_5_dout = sram_coalesce_iob_io_coal_0_5_dout; // @[VitraCGRAController.scala 248:21]
  assign cgra_io_srams_0_6_dout = sram_coalesce_iob_io_coal_0_6_dout; // @[VitraCGRAController.scala 248:21]
  assign cgra_io_srams_0_7_dout = sram_coalesce_iob_io_coal_0_7_dout; // @[VitraCGRAController.scala 248:21]
  assign cgra_io_srams_0_8_dout = sram_coalesce_iob_io_coal_0_8_dout; // @[VitraCGRAController.scala 248:21]
  assign cgra_io_srams_0_9_dout = sram_coalesce_iob_io_coal_0_9_dout; // @[VitraCGRAController.scala 248:21]
  assign cfgCtrl_clock = clock;
  assign cfgCtrl_reset = reset;
  assign cfgCtrl_io_start = cfg_start; // @[VitraCGRAController.scala 360:25]
  assign cfgCtrl_io_base_addr = cfg_base_addr; // @[VitraCGRAController.scala 361:25]
  assign cfgCtrl_io_cfg_num = cfg_num; // @[VitraCGRAController.scala 362:25]
  assign cfgCtrl_io_sram_dout = io_sram_cfg_dout; // @[VitraCGRAController.scala 250:21]
  assign sram_coalesce_iob_clock = clock;
  assign sram_coalesce_iob_io_orig_0_dout = io_srams_iob_0_dout; // @[VitraCGRAController.scala 249:21]
  assign sram_coalesce_iob_io_orig_1_dout = io_srams_iob_1_dout; // @[VitraCGRAController.scala 249:21]
  assign sram_coalesce_iob_io_orig_2_dout = io_srams_iob_2_dout; // @[VitraCGRAController.scala 249:21]
  assign sram_coalesce_iob_io_orig_3_dout = io_srams_iob_3_dout; // @[VitraCGRAController.scala 249:21]
  assign sram_coalesce_iob_io_orig_4_dout = io_srams_iob_4_dout; // @[VitraCGRAController.scala 249:21]
  assign sram_coalesce_iob_io_orig_5_dout = io_srams_iob_5_dout; // @[VitraCGRAController.scala 249:21]
  assign sram_coalesce_iob_io_orig_6_dout = io_srams_iob_6_dout; // @[VitraCGRAController.scala 249:21]
  assign sram_coalesce_iob_io_orig_7_dout = io_srams_iob_7_dout; // @[VitraCGRAController.scala 249:21]
  assign sram_coalesce_iob_io_orig_8_dout = io_srams_iob_8_dout; // @[VitraCGRAController.scala 249:21]
  assign sram_coalesce_iob_io_orig_9_dout = io_srams_iob_9_dout; // @[VitraCGRAController.scala 249:21]
  assign sram_coalesce_iob_io_coal_0_0_en = cgra_io_srams_0_0_en; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_0_we = cgra_io_srams_0_0_we[0]; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_0_addr = cgra_io_srams_0_0_addr; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_0_din = cgra_io_srams_0_0_din; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_1_en = cgra_io_srams_0_1_en; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_1_we = cgra_io_srams_0_1_we[0]; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_1_addr = cgra_io_srams_0_1_addr; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_1_din = cgra_io_srams_0_1_din; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_2_en = cgra_io_srams_0_2_en; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_2_we = cgra_io_srams_0_2_we[0]; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_2_addr = cgra_io_srams_0_2_addr; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_2_din = cgra_io_srams_0_2_din; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_3_en = cgra_io_srams_0_3_en; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_3_we = cgra_io_srams_0_3_we[0]; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_3_addr = cgra_io_srams_0_3_addr; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_3_din = cgra_io_srams_0_3_din; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_4_en = cgra_io_srams_0_4_en; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_4_we = cgra_io_srams_0_4_we[0]; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_4_addr = cgra_io_srams_0_4_addr; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_4_din = cgra_io_srams_0_4_din; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_5_en = cgra_io_srams_0_5_en; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_5_we = cgra_io_srams_0_5_we[0]; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_5_addr = cgra_io_srams_0_5_addr; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_5_din = cgra_io_srams_0_5_din; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_6_en = cgra_io_srams_0_6_en; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_6_we = cgra_io_srams_0_6_we[0]; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_6_addr = cgra_io_srams_0_6_addr; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_6_din = cgra_io_srams_0_6_din; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_7_en = cgra_io_srams_0_7_en; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_7_we = cgra_io_srams_0_7_we[0]; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_7_addr = cgra_io_srams_0_7_addr; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_7_din = cgra_io_srams_0_7_din; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_8_en = cgra_io_srams_0_8_en; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_8_we = cgra_io_srams_0_8_we[0]; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_8_addr = cgra_io_srams_0_8_addr; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_8_din = cgra_io_srams_0_8_din; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_9_en = cgra_io_srams_0_9_en; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_9_we = cgra_io_srams_0_9_we[0]; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_9_addr = cgra_io_srams_0_9_addr; // @[VitraCGRAController.scala 248:21]
  assign sram_coalesce_iob_io_coal_0_9_din = cgra_io_srams_0_9_din; // @[VitraCGRAController.scala 248:21]
  assign tileStates_0_clock = clock;
  assign tileStates_0_reset = reset;
  assign tileStates_0_io_cfgStartReq = cfg_start & cfg_en_tiles; // @[VitraCGRAController.scala 342:44]
  assign tileStates_0_io_cfgDoneIn = cfgCtrl_io_done; // @[VitraCGRAController.scala 343:31]
  assign tileStates_0_io_exeStartReq = exe_start & _exe_en_tiles_T_1; // @[VitraCGRAController.scala 344:44]
  assign tileStates_0_io_exeIobEnReq = iob_ens; // @[VitraCGRAController.scala 345:41]
  assign tileStates_0_io_exeDoneIn = cgra_io_done_0; // @[VitraCGRAController.scala 346:31]
  always @(posedge clock) begin
    if (reset) begin // @[VitraCGRAController.scala 159:67]
      reg_cfg_base_addr_0 <= 8'h0; // @[VitraCGRAController.scala 159:67]
    end else if (!(3'h0 == w_state)) begin // @[VitraCGRAController.scala 386:18]
      if (!(3'h1 == w_state)) begin // @[VitraCGRAController.scala 386:18]
        if (!(3'h2 == w_state)) begin // @[VitraCGRAController.scala 386:18]
          reg_cfg_base_addr_0 <= _GEN_48;
        end
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 159:67]
      reg_cfg_base_addr_1 <= 8'h0; // @[VitraCGRAController.scala 159:67]
    end else if (!(3'h0 == w_state)) begin // @[VitraCGRAController.scala 386:18]
      if (!(3'h1 == w_state)) begin // @[VitraCGRAController.scala 386:18]
        if (!(3'h2 == w_state)) begin // @[VitraCGRAController.scala 386:18]
          reg_cfg_base_addr_1 <= _GEN_49;
        end
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 160:61]
      reg_cfg_num_0 <= 8'h0; // @[VitraCGRAController.scala 160:61]
    end else if (!(3'h0 == w_state)) begin // @[VitraCGRAController.scala 386:18]
      if (!(3'h1 == w_state)) begin // @[VitraCGRAController.scala 386:18]
        if (!(3'h2 == w_state)) begin // @[VitraCGRAController.scala 386:18]
          reg_cfg_num_0 <= _GEN_50;
        end
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 160:61]
      reg_cfg_num_1 <= 8'h0; // @[VitraCGRAController.scala 160:61]
    end else if (!(3'h0 == w_state)) begin // @[VitraCGRAController.scala 386:18]
      if (!(3'h1 == w_state)) begin // @[VitraCGRAController.scala 386:18]
        if (!(3'h2 == w_state)) begin // @[VitraCGRAController.scala 386:18]
          reg_cfg_num_1 <= _GEN_51;
        end
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 161:64]
      reg_cfg_en_tile_0 <= 8'h0; // @[VitraCGRAController.scala 161:64]
    end else if (!(3'h0 == w_state)) begin // @[VitraCGRAController.scala 386:18]
      if (!(3'h1 == w_state)) begin // @[VitraCGRAController.scala 386:18]
        if (!(3'h2 == w_state)) begin // @[VitraCGRAController.scala 386:18]
          reg_cfg_en_tile_0 <= _GEN_52;
        end
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 163:34]
      reg_cfg_en <= 1'h0; // @[VitraCGRAController.scala 163:34]
    end else if (_T_15) begin // @[VitraCGRAController.scala 509:25]
      reg_cfg_en <= io_s_axilite_w_bits_data[0];
    end else if (_T_20 | _T_20) begin // @[VitraCGRAController.scala 511:30]
      reg_cfg_en <= 1'h0;
    end
    if (reset) begin // @[VitraCGRAController.scala 166:61]
      reg_exe_iob_ens_0 <= 8'h0; // @[VitraCGRAController.scala 166:61]
    end else if (!(3'h0 == w_state)) begin // @[VitraCGRAController.scala 386:18]
      if (!(3'h1 == w_state)) begin // @[VitraCGRAController.scala 386:18]
        if (!(3'h2 == w_state)) begin // @[VitraCGRAController.scala 386:18]
          reg_exe_iob_ens_0 <= _GEN_53;
        end
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 166:61]
      reg_exe_iob_ens_1 <= 8'h0; // @[VitraCGRAController.scala 166:61]
    end else if (!(3'h0 == w_state)) begin // @[VitraCGRAController.scala 386:18]
      if (!(3'h1 == w_state)) begin // @[VitraCGRAController.scala 386:18]
        if (!(3'h2 == w_state)) begin // @[VitraCGRAController.scala 386:18]
          reg_exe_iob_ens_1 <= _GEN_54;
        end
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 167:34]
      reg_exe_start <= 1'h0; // @[VitraCGRAController.scala 167:34]
    end else if (_T_18) begin // @[VitraCGRAController.scala 519:28]
      reg_exe_start <= io_s_axilite_w_bits_data[0];
    end else if (_reg_exe_start_next_T_6) begin // @[VitraCGRAController.scala 521:30]
      reg_exe_start <= 1'h0;
    end
    cfg_base_addr <= _GEN_90[8:0]; // @[VitraCGRAController.scala 257:{30,30}]
    cfg_num <= _GEN_91[11:0]; // @[VitraCGRAController.scala 258:{30,30}]
    cfg_en_tiles <= _GEN_92[0]; // @[VitraCGRAController.scala 259:{30,30}]
    if (reset) begin // @[VitraCGRAController.scala 260:30]
      iob_ens <= 10'h0; // @[VitraCGRAController.scala 260:30]
    end else if (3'h0 == cgra_state) begin // @[VitraCGRAController.scala 284:21]
      if (!(reg_cfg_en)) begin // @[VitraCGRAController.scala 287:23]
        if (reg_exe_start) begin // @[VitraCGRAController.scala 293:31]
          iob_ens <= _iob_ens_T[9:0]; // @[VitraCGRAController.scala 295:17]
        end
      end
    end else if (!(3'h1 == cgra_state)) begin // @[VitraCGRAController.scala 284:21]
      if (3'h3 == cgra_state) begin // @[VitraCGRAController.scala 284:21]
        iob_ens <= _GEN_11;
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 261:30]
      cfg_start <= 1'h0; // @[VitraCGRAController.scala 261:30]
    end else if (!(3'h0 == cgra_state)) begin // @[VitraCGRAController.scala 284:21]
      if (3'h1 == cgra_state) begin // @[VitraCGRAController.scala 284:21]
        cfg_start <= _GEN_8;
      end else if (3'h3 == cgra_state) begin // @[VitraCGRAController.scala 284:21]
        cfg_start <= 1'h0; // @[VitraCGRAController.scala 307:18]
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 262:30]
      exe_start <= 1'h0; // @[VitraCGRAController.scala 262:30]
    end else if (!(3'h0 == cgra_state)) begin // @[VitraCGRAController.scala 284:21]
      if (!(3'h1 == cgra_state)) begin // @[VitraCGRAController.scala 284:21]
        if (!(3'h3 == cgra_state)) begin // @[VitraCGRAController.scala 284:21]
          exe_start <= _GEN_18;
        end
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 282:27]
      cgra_state <= 3'h0; // @[VitraCGRAController.scala 282:27]
    end else if (3'h0 == cgra_state) begin // @[VitraCGRAController.scala 284:21]
      if (reg_cfg_en) begin // @[VitraCGRAController.scala 287:23]
        cgra_state <= 3'h1; // @[VitraCGRAController.scala 288:23]
      end else if (reg_exe_start) begin // @[VitraCGRAController.scala 293:31]
        cgra_state <= 3'h4; // @[VitraCGRAController.scala 294:21]
      end
    end else if (3'h1 == cgra_state) begin // @[VitraCGRAController.scala 284:21]
      if (cfg_avail) begin // @[VitraCGRAController.scala 300:22]
        cgra_state <= 3'h3; // @[VitraCGRAController.scala 301:20]
      end
    end else if (3'h3 == cgra_state) begin // @[VitraCGRAController.scala 284:21]
      cgra_state <= _GEN_10;
    end else begin
      cgra_state <= _GEN_17;
    end
    if (reset) begin // @[VitraCGRAController.scala 380:27]
      w_reg_addr <= 8'h0; // @[VitraCGRAController.scala 380:27]
    end else if (3'h0 == w_state) begin // @[VitraCGRAController.scala 386:18]
      if (_T_6) begin // @[VitraCGRAController.scala 388:33]
        w_reg_addr <= io_s_axilite_aw_bits_addr; // @[VitraCGRAController.scala 395:22]
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 384:24]
      w_state <= 3'h0; // @[VitraCGRAController.scala 384:24]
    end else if (3'h0 == w_state) begin // @[VitraCGRAController.scala 386:18]
      if (_T_6) begin // @[VitraCGRAController.scala 388:33]
        if (io_s_axilite_aw_bits_addr == 8'h5) begin // @[VitraCGRAController.scala 390:25]
          w_state <= 3'h1;
        end else begin
          w_state <= _w_state_T_2;
        end
      end
    end else if (3'h1 == w_state) begin // @[VitraCGRAController.scala 386:18]
      w_state <= _GEN_36;
    end else if (3'h2 == w_state) begin // @[VitraCGRAController.scala 386:18]
      w_state <= _GEN_36;
    end else begin
      w_state <= _GEN_55;
    end
    if (reset) begin // @[VitraCGRAController.scala 481:27]
      r_reg_addr <= 8'h0; // @[VitraCGRAController.scala 481:27]
    end else if (~r_state) begin // @[VitraCGRAController.scala 487:18]
      if (_T_25) begin // @[VitraCGRAController.scala 489:33]
        r_reg_addr <= io_s_axilite_ar_bits_addr; // @[VitraCGRAController.scala 491:20]
      end
    end
    if (reset) begin // @[VitraCGRAController.scala 485:24]
      r_state <= 1'h0; // @[VitraCGRAController.scala 485:24]
    end else if (~r_state) begin // @[VitraCGRAController.scala 487:18]
      r_state <= _GEN_84;
    end else if (r_state) begin // @[VitraCGRAController.scala 487:18]
      if (_T_27) begin // @[VitraCGRAController.scala 496:33]
        r_state <= 1'h0; // @[VitraCGRAController.scala 497:17]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_cfg_base_addr_0 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  reg_cfg_base_addr_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  reg_cfg_num_0 = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  reg_cfg_num_1 = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  reg_cfg_en_tile_0 = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  reg_cfg_en = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  reg_exe_iob_ens_0 = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  reg_exe_iob_ens_1 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  reg_exe_start = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  cfg_base_addr = _RAND_9[8:0];
  _RAND_10 = {1{`RANDOM}};
  cfg_num = _RAND_10[11:0];
  _RAND_11 = {1{`RANDOM}};
  cfg_en_tiles = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  iob_ens = _RAND_12[9:0];
  _RAND_13 = {1{`RANDOM}};
  cfg_start = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  exe_start = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  cgra_state = _RAND_15[2:0];
  _RAND_16 = {1{`RANDOM}};
  w_reg_addr = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  w_state = _RAND_17[2:0];
  _RAND_18 = {1{`RANDOM}};
  r_reg_addr = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  r_state = _RAND_19[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module vitra(
  input         clock,
  input         reset,
  output        io_s_axi_aw_ready,
  input         io_s_axi_aw_valid,
  input  [5:0]  io_s_axi_aw_bits_id,
  input  [16:0] io_s_axi_aw_bits_addr,
  input  [7:0]  io_s_axi_aw_bits_len,
  input  [2:0]  io_s_axi_aw_bits_size,
  input  [1:0]  io_s_axi_aw_bits_burst,
  input         io_s_axi_aw_bits_lock,
  input  [3:0]  io_s_axi_aw_bits_cache,
  input  [2:0]  io_s_axi_aw_bits_prot,
  input  [3:0]  io_s_axi_aw_bits_qos,
  output        io_s_axi_w_ready,
  input         io_s_axi_w_valid,
  input  [63:0] io_s_axi_w_bits_data,
  input  [7:0]  io_s_axi_w_bits_strb,
  input         io_s_axi_w_bits_last,
  input         io_s_axi_b_ready,
  output        io_s_axi_b_valid,
  output [5:0]  io_s_axi_b_bits_id,
  output [1:0]  io_s_axi_b_bits_resp,
  output        io_s_axi_ar_ready,
  input         io_s_axi_ar_valid,
  input  [5:0]  io_s_axi_ar_bits_id,
  input  [16:0] io_s_axi_ar_bits_addr,
  input  [7:0]  io_s_axi_ar_bits_len,
  input  [2:0]  io_s_axi_ar_bits_size,
  input  [1:0]  io_s_axi_ar_bits_burst,
  input         io_s_axi_ar_bits_lock,
  input  [3:0]  io_s_axi_ar_bits_cache,
  input  [2:0]  io_s_axi_ar_bits_prot,
  input  [3:0]  io_s_axi_ar_bits_qos,
  input         io_s_axi_r_ready,
  output        io_s_axi_r_valid,
  output [5:0]  io_s_axi_r_bits_id,
  output [63:0] io_s_axi_r_bits_data,
  output [1:0]  io_s_axi_r_bits_resp,
  output        io_s_axi_r_bits_last,
  output        io_s_axilite_aw_ready,
  input         io_s_axilite_aw_valid,
  input  [7:0]  io_s_axilite_aw_bits_addr,
  input  [2:0]  io_s_axilite_aw_bits_prot,
  output        io_s_axilite_w_ready,
  input         io_s_axilite_w_valid,
  input  [7:0]  io_s_axilite_w_bits_data,
  input         io_s_axilite_w_bits_strb,
  input         io_s_axilite_b_ready,
  output        io_s_axilite_b_valid,
  output [1:0]  io_s_axilite_b_bits_resp,
  output        io_s_axilite_ar_ready,
  input         io_s_axilite_ar_valid,
  input  [7:0]  io_s_axilite_ar_bits_addr,
  input  [2:0]  io_s_axilite_ar_bits_prot,
  input         io_s_axilite_r_ready,
  output        io_s_axilite_r_valid,
  output [7:0]  io_s_axilite_r_bits_data,
  output [1:0]  io_s_axilite_r_bits_resp
);
  wire  spad_clock; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_aclk; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_aresetn; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_s_axi_aw_ready; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_s_axi_aw_valid; // @[VitraWithAxi.scala 131:20]
  wire [5:0] spad_io_s_axi_aw_bits_id; // @[VitraWithAxi.scala 131:20]
  wire [16:0] spad_io_s_axi_aw_bits_addr; // @[VitraWithAxi.scala 131:20]
  wire [7:0] spad_io_s_axi_aw_bits_len; // @[VitraWithAxi.scala 131:20]
  wire [2:0] spad_io_s_axi_aw_bits_size; // @[VitraWithAxi.scala 131:20]
  wire [1:0] spad_io_s_axi_aw_bits_burst; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_s_axi_w_ready; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_s_axi_w_valid; // @[VitraWithAxi.scala 131:20]
  wire [63:0] spad_io_s_axi_w_bits_data; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_s_axi_w_bits_last; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_s_axi_b_ready; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_s_axi_b_valid; // @[VitraWithAxi.scala 131:20]
  wire [5:0] spad_io_s_axi_b_bits_id; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_s_axi_ar_ready; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_s_axi_ar_valid; // @[VitraWithAxi.scala 131:20]
  wire [5:0] spad_io_s_axi_ar_bits_id; // @[VitraWithAxi.scala 131:20]
  wire [16:0] spad_io_s_axi_ar_bits_addr; // @[VitraWithAxi.scala 131:20]
  wire [7:0] spad_io_s_axi_ar_bits_len; // @[VitraWithAxi.scala 131:20]
  wire [2:0] spad_io_s_axi_ar_bits_size; // @[VitraWithAxi.scala 131:20]
  wire [1:0] spad_io_s_axi_ar_bits_burst; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_s_axi_r_ready; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_s_axi_r_valid; // @[VitraWithAxi.scala 131:20]
  wire [5:0] spad_io_s_axi_r_bits_id; // @[VitraWithAxi.scala 131:20]
  wire [63:0] spad_io_s_axi_r_bits_data; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_s_axi_r_bits_last; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_0_en; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_0_we; // @[VitraWithAxi.scala 131:20]
  wire [11:0] spad_io_srams_0_addr; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_0_din; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_0_dout; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_1_en; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_1_we; // @[VitraWithAxi.scala 131:20]
  wire [11:0] spad_io_srams_1_addr; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_1_din; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_1_dout; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_2_en; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_2_we; // @[VitraWithAxi.scala 131:20]
  wire [11:0] spad_io_srams_2_addr; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_2_din; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_2_dout; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_3_en; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_3_we; // @[VitraWithAxi.scala 131:20]
  wire [11:0] spad_io_srams_3_addr; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_3_din; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_3_dout; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_4_en; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_4_we; // @[VitraWithAxi.scala 131:20]
  wire [11:0] spad_io_srams_4_addr; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_4_din; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_4_dout; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_5_en; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_5_we; // @[VitraWithAxi.scala 131:20]
  wire [11:0] spad_io_srams_5_addr; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_5_din; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_5_dout; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_6_en; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_6_we; // @[VitraWithAxi.scala 131:20]
  wire [11:0] spad_io_srams_6_addr; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_6_din; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_6_dout; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_7_en; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_7_we; // @[VitraWithAxi.scala 131:20]
  wire [11:0] spad_io_srams_7_addr; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_7_din; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_7_dout; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_8_en; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_8_we; // @[VitraWithAxi.scala 131:20]
  wire [11:0] spad_io_srams_8_addr; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_8_din; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_8_dout; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_9_en; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_srams_9_we; // @[VitraWithAxi.scala 131:20]
  wire [11:0] spad_io_srams_9_addr; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_9_din; // @[VitraWithAxi.scala 131:20]
  wire [15:0] spad_io_srams_9_dout; // @[VitraWithAxi.scala 131:20]
  wire  spad_io_sram_last_en; // @[VitraWithAxi.scala 131:20]
  wire [8:0] spad_io_sram_last_addr; // @[VitraWithAxi.scala 131:20]
  wire [63:0] spad_io_sram_last_dout; // @[VitraWithAxi.scala 131:20]
  wire  cgra_clock; // @[VitraWithAxi.scala 143:20]
  wire  cgra_reset; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_s_axilite_aw_ready; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_s_axilite_aw_valid; // @[VitraWithAxi.scala 143:20]
  wire [7:0] cgra_io_s_axilite_aw_bits_addr; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_s_axilite_w_ready; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_s_axilite_w_valid; // @[VitraWithAxi.scala 143:20]
  wire [7:0] cgra_io_s_axilite_w_bits_data; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_s_axilite_b_ready; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_s_axilite_b_valid; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_s_axilite_ar_ready; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_s_axilite_ar_valid; // @[VitraWithAxi.scala 143:20]
  wire [7:0] cgra_io_s_axilite_ar_bits_addr; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_s_axilite_r_ready; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_s_axilite_r_valid; // @[VitraWithAxi.scala 143:20]
  wire [7:0] cgra_io_s_axilite_r_bits_data; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_0_en; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_0_we; // @[VitraWithAxi.scala 143:20]
  wire [11:0] cgra_io_srams_iob_0_addr; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_0_din; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_0_dout; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_1_en; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_1_we; // @[VitraWithAxi.scala 143:20]
  wire [11:0] cgra_io_srams_iob_1_addr; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_1_din; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_1_dout; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_2_en; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_2_we; // @[VitraWithAxi.scala 143:20]
  wire [11:0] cgra_io_srams_iob_2_addr; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_2_din; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_2_dout; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_3_en; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_3_we; // @[VitraWithAxi.scala 143:20]
  wire [11:0] cgra_io_srams_iob_3_addr; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_3_din; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_3_dout; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_4_en; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_4_we; // @[VitraWithAxi.scala 143:20]
  wire [11:0] cgra_io_srams_iob_4_addr; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_4_din; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_4_dout; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_5_en; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_5_we; // @[VitraWithAxi.scala 143:20]
  wire [11:0] cgra_io_srams_iob_5_addr; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_5_din; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_5_dout; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_6_en; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_6_we; // @[VitraWithAxi.scala 143:20]
  wire [11:0] cgra_io_srams_iob_6_addr; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_6_din; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_6_dout; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_7_en; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_7_we; // @[VitraWithAxi.scala 143:20]
  wire [11:0] cgra_io_srams_iob_7_addr; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_7_din; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_7_dout; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_8_en; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_8_we; // @[VitraWithAxi.scala 143:20]
  wire [11:0] cgra_io_srams_iob_8_addr; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_8_din; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_8_dout; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_9_en; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_srams_iob_9_we; // @[VitraWithAxi.scala 143:20]
  wire [11:0] cgra_io_srams_iob_9_addr; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_9_din; // @[VitraWithAxi.scala 143:20]
  wire [15:0] cgra_io_srams_iob_9_dout; // @[VitraWithAxi.scala 143:20]
  wire  cgra_io_sram_cfg_en; // @[VitraWithAxi.scala 143:20]
  wire [8:0] cgra_io_sram_cfg_addr; // @[VitraWithAxi.scala 143:20]
  wire [63:0] cgra_io_sram_cfg_dout; // @[VitraWithAxi.scala 143:20]
  AXI4Scratchpad spad ( // @[VitraWithAxi.scala 131:20]
    .clock(spad_clock),
    .io_aclk(spad_io_aclk),
    .io_aresetn(spad_io_aresetn),
    .io_s_axi_aw_ready(spad_io_s_axi_aw_ready),
    .io_s_axi_aw_valid(spad_io_s_axi_aw_valid),
    .io_s_axi_aw_bits_id(spad_io_s_axi_aw_bits_id),
    .io_s_axi_aw_bits_addr(spad_io_s_axi_aw_bits_addr),
    .io_s_axi_aw_bits_len(spad_io_s_axi_aw_bits_len),
    .io_s_axi_aw_bits_size(spad_io_s_axi_aw_bits_size),
    .io_s_axi_aw_bits_burst(spad_io_s_axi_aw_bits_burst),
    .io_s_axi_w_ready(spad_io_s_axi_w_ready),
    .io_s_axi_w_valid(spad_io_s_axi_w_valid),
    .io_s_axi_w_bits_data(spad_io_s_axi_w_bits_data),
    .io_s_axi_w_bits_last(spad_io_s_axi_w_bits_last),
    .io_s_axi_b_ready(spad_io_s_axi_b_ready),
    .io_s_axi_b_valid(spad_io_s_axi_b_valid),
    .io_s_axi_b_bits_id(spad_io_s_axi_b_bits_id),
    .io_s_axi_ar_ready(spad_io_s_axi_ar_ready),
    .io_s_axi_ar_valid(spad_io_s_axi_ar_valid),
    .io_s_axi_ar_bits_id(spad_io_s_axi_ar_bits_id),
    .io_s_axi_ar_bits_addr(spad_io_s_axi_ar_bits_addr),
    .io_s_axi_ar_bits_len(spad_io_s_axi_ar_bits_len),
    .io_s_axi_ar_bits_size(spad_io_s_axi_ar_bits_size),
    .io_s_axi_ar_bits_burst(spad_io_s_axi_ar_bits_burst),
    .io_s_axi_r_ready(spad_io_s_axi_r_ready),
    .io_s_axi_r_valid(spad_io_s_axi_r_valid),
    .io_s_axi_r_bits_id(spad_io_s_axi_r_bits_id),
    .io_s_axi_r_bits_data(spad_io_s_axi_r_bits_data),
    .io_s_axi_r_bits_last(spad_io_s_axi_r_bits_last),
    .io_srams_0_en(spad_io_srams_0_en),
    .io_srams_0_we(spad_io_srams_0_we),
    .io_srams_0_addr(spad_io_srams_0_addr),
    .io_srams_0_din(spad_io_srams_0_din),
    .io_srams_0_dout(spad_io_srams_0_dout),
    .io_srams_1_en(spad_io_srams_1_en),
    .io_srams_1_we(spad_io_srams_1_we),
    .io_srams_1_addr(spad_io_srams_1_addr),
    .io_srams_1_din(spad_io_srams_1_din),
    .io_srams_1_dout(spad_io_srams_1_dout),
    .io_srams_2_en(spad_io_srams_2_en),
    .io_srams_2_we(spad_io_srams_2_we),
    .io_srams_2_addr(spad_io_srams_2_addr),
    .io_srams_2_din(spad_io_srams_2_din),
    .io_srams_2_dout(spad_io_srams_2_dout),
    .io_srams_3_en(spad_io_srams_3_en),
    .io_srams_3_we(spad_io_srams_3_we),
    .io_srams_3_addr(spad_io_srams_3_addr),
    .io_srams_3_din(spad_io_srams_3_din),
    .io_srams_3_dout(spad_io_srams_3_dout),
    .io_srams_4_en(spad_io_srams_4_en),
    .io_srams_4_we(spad_io_srams_4_we),
    .io_srams_4_addr(spad_io_srams_4_addr),
    .io_srams_4_din(spad_io_srams_4_din),
    .io_srams_4_dout(spad_io_srams_4_dout),
    .io_srams_5_en(spad_io_srams_5_en),
    .io_srams_5_we(spad_io_srams_5_we),
    .io_srams_5_addr(spad_io_srams_5_addr),
    .io_srams_5_din(spad_io_srams_5_din),
    .io_srams_5_dout(spad_io_srams_5_dout),
    .io_srams_6_en(spad_io_srams_6_en),
    .io_srams_6_we(spad_io_srams_6_we),
    .io_srams_6_addr(spad_io_srams_6_addr),
    .io_srams_6_din(spad_io_srams_6_din),
    .io_srams_6_dout(spad_io_srams_6_dout),
    .io_srams_7_en(spad_io_srams_7_en),
    .io_srams_7_we(spad_io_srams_7_we),
    .io_srams_7_addr(spad_io_srams_7_addr),
    .io_srams_7_din(spad_io_srams_7_din),
    .io_srams_7_dout(spad_io_srams_7_dout),
    .io_srams_8_en(spad_io_srams_8_en),
    .io_srams_8_we(spad_io_srams_8_we),
    .io_srams_8_addr(spad_io_srams_8_addr),
    .io_srams_8_din(spad_io_srams_8_din),
    .io_srams_8_dout(spad_io_srams_8_dout),
    .io_srams_9_en(spad_io_srams_9_en),
    .io_srams_9_we(spad_io_srams_9_we),
    .io_srams_9_addr(spad_io_srams_9_addr),
    .io_srams_9_din(spad_io_srams_9_din),
    .io_srams_9_dout(spad_io_srams_9_dout),
    .io_sram_last_en(spad_io_sram_last_en),
    .io_sram_last_addr(spad_io_sram_last_addr),
    .io_sram_last_dout(spad_io_sram_last_dout)
  );
  VitraCGRAController cgra ( // @[VitraWithAxi.scala 143:20]
    .clock(cgra_clock),
    .reset(cgra_reset),
    .io_s_axilite_aw_ready(cgra_io_s_axilite_aw_ready),
    .io_s_axilite_aw_valid(cgra_io_s_axilite_aw_valid),
    .io_s_axilite_aw_bits_addr(cgra_io_s_axilite_aw_bits_addr),
    .io_s_axilite_w_ready(cgra_io_s_axilite_w_ready),
    .io_s_axilite_w_valid(cgra_io_s_axilite_w_valid),
    .io_s_axilite_w_bits_data(cgra_io_s_axilite_w_bits_data),
    .io_s_axilite_b_ready(cgra_io_s_axilite_b_ready),
    .io_s_axilite_b_valid(cgra_io_s_axilite_b_valid),
    .io_s_axilite_ar_ready(cgra_io_s_axilite_ar_ready),
    .io_s_axilite_ar_valid(cgra_io_s_axilite_ar_valid),
    .io_s_axilite_ar_bits_addr(cgra_io_s_axilite_ar_bits_addr),
    .io_s_axilite_r_ready(cgra_io_s_axilite_r_ready),
    .io_s_axilite_r_valid(cgra_io_s_axilite_r_valid),
    .io_s_axilite_r_bits_data(cgra_io_s_axilite_r_bits_data),
    .io_srams_iob_0_en(cgra_io_srams_iob_0_en),
    .io_srams_iob_0_we(cgra_io_srams_iob_0_we),
    .io_srams_iob_0_addr(cgra_io_srams_iob_0_addr),
    .io_srams_iob_0_din(cgra_io_srams_iob_0_din),
    .io_srams_iob_0_dout(cgra_io_srams_iob_0_dout),
    .io_srams_iob_1_en(cgra_io_srams_iob_1_en),
    .io_srams_iob_1_we(cgra_io_srams_iob_1_we),
    .io_srams_iob_1_addr(cgra_io_srams_iob_1_addr),
    .io_srams_iob_1_din(cgra_io_srams_iob_1_din),
    .io_srams_iob_1_dout(cgra_io_srams_iob_1_dout),
    .io_srams_iob_2_en(cgra_io_srams_iob_2_en),
    .io_srams_iob_2_we(cgra_io_srams_iob_2_we),
    .io_srams_iob_2_addr(cgra_io_srams_iob_2_addr),
    .io_srams_iob_2_din(cgra_io_srams_iob_2_din),
    .io_srams_iob_2_dout(cgra_io_srams_iob_2_dout),
    .io_srams_iob_3_en(cgra_io_srams_iob_3_en),
    .io_srams_iob_3_we(cgra_io_srams_iob_3_we),
    .io_srams_iob_3_addr(cgra_io_srams_iob_3_addr),
    .io_srams_iob_3_din(cgra_io_srams_iob_3_din),
    .io_srams_iob_3_dout(cgra_io_srams_iob_3_dout),
    .io_srams_iob_4_en(cgra_io_srams_iob_4_en),
    .io_srams_iob_4_we(cgra_io_srams_iob_4_we),
    .io_srams_iob_4_addr(cgra_io_srams_iob_4_addr),
    .io_srams_iob_4_din(cgra_io_srams_iob_4_din),
    .io_srams_iob_4_dout(cgra_io_srams_iob_4_dout),
    .io_srams_iob_5_en(cgra_io_srams_iob_5_en),
    .io_srams_iob_5_we(cgra_io_srams_iob_5_we),
    .io_srams_iob_5_addr(cgra_io_srams_iob_5_addr),
    .io_srams_iob_5_din(cgra_io_srams_iob_5_din),
    .io_srams_iob_5_dout(cgra_io_srams_iob_5_dout),
    .io_srams_iob_6_en(cgra_io_srams_iob_6_en),
    .io_srams_iob_6_we(cgra_io_srams_iob_6_we),
    .io_srams_iob_6_addr(cgra_io_srams_iob_6_addr),
    .io_srams_iob_6_din(cgra_io_srams_iob_6_din),
    .io_srams_iob_6_dout(cgra_io_srams_iob_6_dout),
    .io_srams_iob_7_en(cgra_io_srams_iob_7_en),
    .io_srams_iob_7_we(cgra_io_srams_iob_7_we),
    .io_srams_iob_7_addr(cgra_io_srams_iob_7_addr),
    .io_srams_iob_7_din(cgra_io_srams_iob_7_din),
    .io_srams_iob_7_dout(cgra_io_srams_iob_7_dout),
    .io_srams_iob_8_en(cgra_io_srams_iob_8_en),
    .io_srams_iob_8_we(cgra_io_srams_iob_8_we),
    .io_srams_iob_8_addr(cgra_io_srams_iob_8_addr),
    .io_srams_iob_8_din(cgra_io_srams_iob_8_din),
    .io_srams_iob_8_dout(cgra_io_srams_iob_8_dout),
    .io_srams_iob_9_en(cgra_io_srams_iob_9_en),
    .io_srams_iob_9_we(cgra_io_srams_iob_9_we),
    .io_srams_iob_9_addr(cgra_io_srams_iob_9_addr),
    .io_srams_iob_9_din(cgra_io_srams_iob_9_din),
    .io_srams_iob_9_dout(cgra_io_srams_iob_9_dout),
    .io_sram_cfg_en(cgra_io_sram_cfg_en),
    .io_sram_cfg_addr(cgra_io_sram_cfg_addr),
    .io_sram_cfg_dout(cgra_io_sram_cfg_dout)
  );
  assign io_s_axi_aw_ready = spad_io_s_axi_aw_ready; // @[VitraWithAxi.scala 145:21]
  assign io_s_axi_w_ready = spad_io_s_axi_w_ready; // @[VitraWithAxi.scala 145:21]
  assign io_s_axi_b_valid = spad_io_s_axi_b_valid; // @[VitraWithAxi.scala 145:21]
  assign io_s_axi_b_bits_id = spad_io_s_axi_b_bits_id; // @[VitraWithAxi.scala 145:21]
  assign io_s_axi_b_bits_resp = 2'h0; // @[VitraWithAxi.scala 145:21]
  assign io_s_axi_ar_ready = spad_io_s_axi_ar_ready; // @[VitraWithAxi.scala 145:21]
  assign io_s_axi_r_valid = spad_io_s_axi_r_valid; // @[VitraWithAxi.scala 145:21]
  assign io_s_axi_r_bits_id = spad_io_s_axi_r_bits_id; // @[VitraWithAxi.scala 145:21]
  assign io_s_axi_r_bits_data = spad_io_s_axi_r_bits_data; // @[VitraWithAxi.scala 145:21]
  assign io_s_axi_r_bits_resp = 2'h0; // @[VitraWithAxi.scala 145:21]
  assign io_s_axi_r_bits_last = spad_io_s_axi_r_bits_last; // @[VitraWithAxi.scala 145:21]
  assign io_s_axilite_aw_ready = cgra_io_s_axilite_aw_ready; // @[VitraWithAxi.scala 146:21]
  assign io_s_axilite_w_ready = cgra_io_s_axilite_w_ready; // @[VitraWithAxi.scala 146:21]
  assign io_s_axilite_b_valid = cgra_io_s_axilite_b_valid; // @[VitraWithAxi.scala 146:21]
  assign io_s_axilite_b_bits_resp = 2'h0; // @[VitraWithAxi.scala 146:21]
  assign io_s_axilite_ar_ready = cgra_io_s_axilite_ar_ready; // @[VitraWithAxi.scala 146:21]
  assign io_s_axilite_r_valid = cgra_io_s_axilite_r_valid; // @[VitraWithAxi.scala 146:21]
  assign io_s_axilite_r_bits_data = cgra_io_s_axilite_r_bits_data; // @[VitraWithAxi.scala 146:21]
  assign io_s_axilite_r_bits_resp = 2'h0; // @[VitraWithAxi.scala 146:21]
  assign spad_clock = clock;
  assign spad_io_aclk = clock; // @[VitraWithAxi.scala 148:21]
  assign spad_io_aresetn = ~reset; // @[VitraWithAxi.scala 149:24]
  assign spad_io_s_axi_aw_valid = io_s_axi_aw_valid; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_aw_bits_id = io_s_axi_aw_bits_id; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_aw_bits_addr = io_s_axi_aw_bits_addr; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_aw_bits_len = io_s_axi_aw_bits_len; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_aw_bits_size = io_s_axi_aw_bits_size; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_aw_bits_burst = io_s_axi_aw_bits_burst; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_w_valid = io_s_axi_w_valid; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_w_bits_data = io_s_axi_w_bits_data; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_w_bits_last = io_s_axi_w_bits_last; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_b_ready = io_s_axi_b_ready; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_ar_valid = io_s_axi_ar_valid; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_ar_bits_id = io_s_axi_ar_bits_id; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_ar_bits_addr = io_s_axi_ar_bits_addr; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_ar_bits_len = io_s_axi_ar_bits_len; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_ar_bits_size = io_s_axi_ar_bits_size; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_ar_bits_burst = io_s_axi_ar_bits_burst; // @[VitraWithAxi.scala 145:21]
  assign spad_io_s_axi_r_ready = io_s_axi_r_ready; // @[VitraWithAxi.scala 145:21]
  assign spad_io_srams_0_en = cgra_io_srams_iob_0_en; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_0_we = cgra_io_srams_iob_0_we; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_0_addr = cgra_io_srams_iob_0_addr; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_0_din = cgra_io_srams_iob_0_din; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_1_en = cgra_io_srams_iob_1_en; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_1_we = cgra_io_srams_iob_1_we; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_1_addr = cgra_io_srams_iob_1_addr; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_1_din = cgra_io_srams_iob_1_din; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_2_en = cgra_io_srams_iob_2_en; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_2_we = cgra_io_srams_iob_2_we; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_2_addr = cgra_io_srams_iob_2_addr; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_2_din = cgra_io_srams_iob_2_din; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_3_en = cgra_io_srams_iob_3_en; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_3_we = cgra_io_srams_iob_3_we; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_3_addr = cgra_io_srams_iob_3_addr; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_3_din = cgra_io_srams_iob_3_din; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_4_en = cgra_io_srams_iob_4_en; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_4_we = cgra_io_srams_iob_4_we; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_4_addr = cgra_io_srams_iob_4_addr; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_4_din = cgra_io_srams_iob_4_din; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_5_en = cgra_io_srams_iob_5_en; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_5_we = cgra_io_srams_iob_5_we; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_5_addr = cgra_io_srams_iob_5_addr; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_5_din = cgra_io_srams_iob_5_din; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_6_en = cgra_io_srams_iob_6_en; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_6_we = cgra_io_srams_iob_6_we; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_6_addr = cgra_io_srams_iob_6_addr; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_6_din = cgra_io_srams_iob_6_din; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_7_en = cgra_io_srams_iob_7_en; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_7_we = cgra_io_srams_iob_7_we; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_7_addr = cgra_io_srams_iob_7_addr; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_7_din = cgra_io_srams_iob_7_din; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_8_en = cgra_io_srams_iob_8_en; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_8_we = cgra_io_srams_iob_8_we; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_8_addr = cgra_io_srams_iob_8_addr; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_8_din = cgra_io_srams_iob_8_din; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_9_en = cgra_io_srams_iob_9_en; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_9_we = cgra_io_srams_iob_9_we; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_9_addr = cgra_io_srams_iob_9_addr; // @[VitraWithAxi.scala 150:21]
  assign spad_io_srams_9_din = cgra_io_srams_iob_9_din; // @[VitraWithAxi.scala 150:21]
  assign spad_io_sram_last_en = cgra_io_sram_cfg_en; // @[VitraWithAxi.scala 151:21]
  assign spad_io_sram_last_addr = cgra_io_sram_cfg_addr; // @[VitraWithAxi.scala 151:21]
  assign cgra_clock = clock;
  assign cgra_reset = reset;
  assign cgra_io_s_axilite_aw_valid = io_s_axilite_aw_valid; // @[VitraWithAxi.scala 146:21]
  assign cgra_io_s_axilite_aw_bits_addr = io_s_axilite_aw_bits_addr; // @[VitraWithAxi.scala 146:21]
  assign cgra_io_s_axilite_w_valid = io_s_axilite_w_valid; // @[VitraWithAxi.scala 146:21]
  assign cgra_io_s_axilite_w_bits_data = io_s_axilite_w_bits_data; // @[VitraWithAxi.scala 146:21]
  assign cgra_io_s_axilite_b_ready = io_s_axilite_b_ready; // @[VitraWithAxi.scala 146:21]
  assign cgra_io_s_axilite_ar_valid = io_s_axilite_ar_valid; // @[VitraWithAxi.scala 146:21]
  assign cgra_io_s_axilite_ar_bits_addr = io_s_axilite_ar_bits_addr; // @[VitraWithAxi.scala 146:21]
  assign cgra_io_s_axilite_r_ready = io_s_axilite_r_ready; // @[VitraWithAxi.scala 146:21]
  assign cgra_io_srams_iob_0_dout = spad_io_srams_0_dout; // @[VitraWithAxi.scala 150:21]
  assign cgra_io_srams_iob_1_dout = spad_io_srams_1_dout; // @[VitraWithAxi.scala 150:21]
  assign cgra_io_srams_iob_2_dout = spad_io_srams_2_dout; // @[VitraWithAxi.scala 150:21]
  assign cgra_io_srams_iob_3_dout = spad_io_srams_3_dout; // @[VitraWithAxi.scala 150:21]
  assign cgra_io_srams_iob_4_dout = spad_io_srams_4_dout; // @[VitraWithAxi.scala 150:21]
  assign cgra_io_srams_iob_5_dout = spad_io_srams_5_dout; // @[VitraWithAxi.scala 150:21]
  assign cgra_io_srams_iob_6_dout = spad_io_srams_6_dout; // @[VitraWithAxi.scala 150:21]
  assign cgra_io_srams_iob_7_dout = spad_io_srams_7_dout; // @[VitraWithAxi.scala 150:21]
  assign cgra_io_srams_iob_8_dout = spad_io_srams_8_dout; // @[VitraWithAxi.scala 150:21]
  assign cgra_io_srams_iob_9_dout = spad_io_srams_9_dout; // @[VitraWithAxi.scala 150:21]
  assign cgra_io_sram_cfg_dout = spad_io_sram_last_dout; // @[VitraWithAxi.scala 151:21]
endmodule
