// Simple parameterized FIFO (behavioral) for simulation/demo purposes
// clk, rst (active high), wr_en, rd_en, din -> dout, full, empty

 `include "fifo_structs.svh"

module FIFO_demo #(
    parameter WIDTH = 8,
    parameter DEPTH = 16,
    parameter PTR_WIDTH = $clog2(DEPTH)
)(
    input  logic clk,
    input  logic rst,
    input  logic rd_en,
    input  wire control_t cntrl_in [0:3],
    output logic [31:0] dout,
    output logic [3:0] full,
    output logic empty,
    output logic [$clog2(DEPTH):0] count
);
 
  
   logic [3:0] empty_w;
   logic [3:0] full_w;
   logic [3:0][31:0] dout_w;
   logic [3:0] rd_en_w;
   logic [1:0] pri_select;
   logic [3:0][3:0] usedw_sig;
        
   // Make 4 instances of this FIFO to demonstrate the use of structs
   generate 
    genvar i;
  
       for (i = 0; i < 4; i = i + 1) begin : fifo_inst

   fifo_33x16	fifo_35x16_inst0 (
	.clock ( clk ),
    .aclr ( rst ),
	.data ( cntrl_in[i].pkt ),
	.rdreq ( rd_en_w[i] ),
	.wrreq ( cntrl_in[i].we  ),
	.empty ( empty_w[i] ),
	.full ( full_w[i] ),
	.q ( dout_w[i] ),
	.usedw ( usedw_sig[i] )
    
	);
       end

   endgenerate

   assign full = full_w;

   always @ (*)
   begin
    empty = &empty_w;
    pri_select = empty_w[0] ? 2'b00 :
                 empty_w[1] ? 2'b01 :
                 empty_w[2] ? 2'b10 : 2'b11;

    rd_en_w = 4'b0000 | ({3'b000, rd_en} << pri_select);

    case (pri_select)
        2'b00: dout = dout_w[0];
        2'b01: dout = dout_w[1];
        2'b10: dout = dout_w[2];
        2'b11: dout = dout_w[3];
   endcase
   end



endmodule
