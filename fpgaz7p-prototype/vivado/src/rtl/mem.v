module TrueDualPortSRAM_16_10(
  input         clock,
  input         io_a_en,
  input  [1:0]  io_a_we,
  input  [9:0]  io_a_addr,
  input  [15:0] io_a_din,
  output [15:0] io_a_dout,
  input         io_b_en,
  input         io_b_we,
  input  [9:0]  io_b_addr,
  input  [15:0] io_b_din,
  output [15:0] io_b_dout
);
DualPortRAM16_10 DualPortRAM16_10_instance (
  .clka(clock),    // input wire clka
  .ena(io_a_en),      // input wire ena
  .wea(io_a_we),      // input wire [0 : 0] wea
  .addra(io_a_addr),  // input wire [9 : 0] addra
  .dina(io_a_din),    // input wire [15 : 0] dina
  .douta(io_a_dout),  // output wire [15 : 0] douta
  .clkb(clock),    // input wire clkb
  .enb(io_b_en),      // input wire enb
  .web(io_b_we),      // input wire [0 : 0] web
  .addrb(io_b_addr),  // input wire [9 : 0] addrb
  .dinb(io_b_din),    // input wire [15 : 0] dinb
  .doutb(io_b_dout)  // output wire [15 : 0] doutb
);
endmodule

module TrueDualPortSRAM_16_9(
  input         clock,
  input         io_a_en,
  input  [1:0]  io_a_we,
  input  [8:0]  io_a_addr,
  input  [15:0] io_a_din,
  output [15:0] io_a_dout,
  input         io_b_en,
  input  [1:0]  io_b_we,
  input  [8:0]  io_b_addr,
  input  [15:0] io_b_din,
  output [15:0] io_b_dout
);

DualPortSRAM_16_9 DualPortSRAM16_9_instance (
  .clka(clock),    // input wire clka
  .ena(io_a_en),      // input wire ena
  .wea(io_a_we),      // input wire [0 : 0] wea
  .addra(io_a_addr),  // input wire [9 : 0] addra
  .dina(io_a_din),    // input wire [15 : 0] dina
  .douta(io_a_dout),  // output wire [15 : 0] douta
  .clkb(clock),    // input wire clkb
  .enb(io_b_en),      // input wire enb
  .web(io_b_we),      // input wire [0 : 0] web
  .addrb(io_b_addr),  // input wire [9 : 0] addrb
  .dinb(io_b_din),    // input wire [15 : 0] dinb
  .doutb(io_b_dout)  // output wire [15 : 0] doutb
);

endmodule 


module TrueDualPortSRAM_128_8(
  input          clock,
  input          io_a_en,
  input  [15:0]  io_a_we,
  input  [7:0]   io_a_addr,
  input  [127:0] io_a_din,
  output [127:0] io_a_dout,
  input          io_b_en,
  input  [7:0]   io_b_addr,
  output [127:0] io_b_dout
);
 DualPortSRAM_128_8 DualPortSRAM_128_8_instance (
  .clka(clock),    // input wire clka
  .ena(io_a_en),      // input wire ena
  .wea(io_a_we),      // input wire [0 : 0] wea
  .addra(io_a_addr),  // input wire [8 : 0] addra
  .dina(io_a_din),    // input wire [63 : 0] dina
  .douta(io_a_dout),  // output wire [63 : 0] douta
  .clkb(clock),    // input wire clkb
  .enb(io_b_en),      // input wire enb
  .web(1'h0),      // input wire [0 : 0] web
  .addrb(io_b_addr),  // input wire [8 : 0] addrb
  .dinb(128'h0),    // input wire [63 : 0] dinb
  .doutb(io_b_dout)  // output wire [63 : 0] doutb
);
endmodule

module TrueDualPortSRAM_64_9(
  input         clock,
  input         io_a_en,
  input  [7:0]  io_a_we,
  input  [8:0]  io_a_addr,
  input  [63:0] io_a_din,
  output [63:0] io_a_dout,
  input         io_b_en,
  input  [8:0]  io_b_addr,
  output [63:0] io_b_dout
);
  DualPortRAM64_9 DualPortRAM64_9_instance (
  .clka(clock),    // input wire clka
  .ena(io_a_en),      // input wire ena
  .wea(io_a_we),      // input wire [0 : 0] wea
  .addra(io_a_addr),  // input wire [8 : 0] addra
  .dina(io_a_din),    // input wire [63 : 0] dina
  .douta(io_a_dout),  // output wire [63 : 0] douta
  .clkb(clock),    // input wire clkb
  .enb(io_b_en),      // input wire enb
  .web(1'h0),      // input wire [0 : 0] web
  .addrb(io_b_addr),  // input wire [8 : 0] addrb
  .dinb(64'h0),    // input wire [63 : 0] dinb
  .doutb(io_b_dout)  // output wire [63 : 0] doutb
);
endmodule