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
   logic [3:0] rd_en_w, rd_en_d;
   logic [1:0] pri_select, nxt_pri_select;
   logic [3:0][3:0] usedw_sig;
   logic arb;
   packet_t pkt_w [0:3];

   packet_t pkt_w_0, pkt_w_1, pkt_w_2, pkt_w_3;
        
    assign pkt_w_0 = pkt_w[0];
    assign pkt_w_1 = pkt_w[1];
    assign pkt_w_2 = pkt_w[2];
    assign pkt_w_3 = pkt_w[3];
    


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
	.q ( pkt_w[i] ),
	.usedw ( usedw_sig[i] )
    
	);
       end

   endgenerate

   assign full = full_w;

   always @ (*)
   begin
    empty = &empty_w;
    // This is a priority selector that only changes on assertion of arb.
    nxt_pri_select = arb & !empty_w[0] ? 2'b00 :
                     arb & !empty_w[1] ? 2'b01 :
                     arb & !empty_w[2] ? 2'b10 : 
                     arb & !empty_w[3] ? 2'b11 : pri_select;

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

   always @ (posedge clk)
   begin
      rd_en_d <= rd_en_w;
   end

   always @ (posedge clk)
   begin
    if (rst)
    begin
        pri_select <= 2'b00;
        arb <= 1'b1;
    end
    else
    begin
        pri_select <= nxt_pri_select;
        arb <= rd_en_d[0] && pri_select == 2'b00 && pkt_w[0].eop ? 1'b1 :
               rd_en_d[0] && pri_select == 2'b00 && pkt_w[0].sop ? 1'b0 :
               rd_en_d[1] && pri_select == 2'b01 && pkt_w[1].eop ? 1'b1 :
               rd_en_d[1] && pri_select == 2'b01 && pkt_w[1].sop ? 1'b0 :
               rd_en_d[2] && pri_select == 2'b10 && pkt_w[2].eop ? 1'b1 :
               rd_en_d[2] && pri_select == 2'b10 && pkt_w[2].sop ? 1'b0 :
               rd_en_d[3] && pri_select == 2'b11 && pkt_w[3].eop ? 1'b1 :
               rd_en_d[3] && pri_select == 2'b11 && pkt_w[3].sop ? 1'b0 : arb;
    end
   end



endmodule
