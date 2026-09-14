// Simple parameterized FIFO (behavioral) for simulation/demo purposes
// clk, rst (active high), wr_en, rd_en, din -> dout, full, empty

 `include "fifo_structs.svh"

module FIFO_demo #(
    parameter WIDTH = 33,
    parameter DEPTH = 16,
    parameter PTR_WIDTH = $clog2(DEPTH)
)(
    input  logic clk,
    input  logic rst,
    input  logic [3:0]wr_en,
    input  logic rd_en,
    input  logic [WIDTH-1:0] din ,
    output logic [WIDTH-1:0] dout,
    output logic full,
    output logic empty,
    output logic [$clog2(DEPTH):0] count
);
 
   logic [3:0] empty_w;
   logic [3:0] full_w;
   logic [3:0][WIDTH-1:0] dout_w;
   logic [3:0][3:0] usedw_w;
   logic [3:0] rd_en_w;
   logic [1:0] pri_select;
    logic [1:0] next_pri_select;
   logic [1:0] fifo_select;
   logic [3:0] pkt_ip; // Packet in progress
    logic [3:0] next_empty_w;
   logic fifo_available;
    logic next_fifo_available;

        
   // Make 4 instances of this FIFO to demonstrate the use of structs
   generate 
    genvar i;
  
       for (i = 0; i < 4; i = i + 1) begin : fifo_inst

   fifo_33x16	fifo_33x16_inst0 (
    .clock ( clk ),
    .data ( din ),
	.rdreq ( rd_en_w[i] ),
	.wrreq (wr_en[i] ),
	.empty ( empty_w[i] ),
	.full ( full_w[i] ),
	.q ( dout_w[i] ),
    .usedw ( usedw_w[i] )
	);
       end

   endgenerate

  
  always_ff @(posedge clk)
  begin
    if (rst) begin
       pkt_ip <= 4'b0000;
    end
    else if (rd_en && fifo_available) begin
        if (dout[32]) begin
            pkt_ip <= next_fifo_available ? (4'b0001 << next_pri_select) : 4'b0000;
        end
        else begin
            pkt_ip <= 4'b0001 << fifo_select;
        end
    end
  end

   always @ (*)
   begin
    pri_select = !empty_w[0] ? 2'b00 :
                 !empty_w[1] ? 2'b01 :
                 !empty_w[2] ? 2'b10 : 2'b11;

    fifo_select = pkt_ip[0] ? 2'b00 :
                  pkt_ip[1] ? 2'b01 :
                  pkt_ip[2] ? 2'b10 :
                  pkt_ip[3] ? 2'b11 : pri_select;

    fifo_available = |pkt_ip ? !empty_w[fifo_select] : !(&empty_w);

    next_empty_w = empty_w;
    if (rd_en && fifo_available && dout[32] && (usedw_w[fifo_select] == 4'd1)) begin
        next_empty_w[fifo_select] = 1'b1;
    end

    next_pri_select = !next_empty_w[0] ? 2'b00 :
                      !next_empty_w[1] ? 2'b01 :
                      !next_empty_w[2] ? 2'b10 : 2'b11;
    next_fifo_available = !(&next_empty_w);

    rd_en_w = fifo_available ? ({3'b000, rd_en} << fifo_select) : 4'b0000;

    case (fifo_select)
        2'b00: dout = dout_w[0];
        2'b01: dout = dout_w[1];
        2'b10: dout = dout_w[2];
        2'b11: dout = dout_w[3];
   endcase

    full = |full_w;
    empty = &empty_w;
    count = usedw_w[fifo_select];
   end



endmodule
