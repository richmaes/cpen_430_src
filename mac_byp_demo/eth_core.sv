`include "structures.vh"

module eth_core (
	input  logic       clk,
	input  logic       rdclk,
	input  logic       rst,

	// Avalon-ST sink: receive data coming from the MAC (eth_tse)
	input  avalon_st_t asi_rx,
	output logic       asi_rx_ready,

	// Avalon-ST source: transmit data going to the MAC (eth_tse)
	output avalon_st_t aso_tx,
	input  logic       aso_tx_ready
);

	// rx->tx path is buffered through a dual-clock FIFO: write side on clk, read side on rdclk.
	localparam FIFO_DATA_WIDTH = 32 + 1 + 1 + 2 + 6; // data + sop + eop + empty + error (valid is the write enable)

	logic [FIFO_DATA_WIDTH-1:0] fifo_wrdata;
	logic [FIFO_DATA_WIDTH-1:0] fifo_q;
	logic                       fifo_wrfull;
	logic                       fifo_rdempty;
	logic                       fifo_wrreq;
	logic                       fifo_rdreq;

	assign fifo_wrdata = {asi_rx.data, asi_rx.sop, asi_rx.eop, asi_rx.empty, asi_rx.error};
	assign fifo_wrreq  = asi_rx.valid & ~fifo_wrfull;
	assign asi_rx_ready = ~fifo_wrfull;

	assign fifo_rdreq  = aso_tx_ready & ~fifo_rdempty;
	assign aso_tx.data  = fifo_q[41:10];
	assign aso_tx.sop   = fifo_q[9];
	assign aso_tx.eop   = fifo_q[8];
	assign aso_tx.empty = fifo_q[7:6];
	assign aso_tx.error = fifo_q[5:0];
	assign aso_tx.valid = ~fifo_rdempty;

	cpen430_dcfifo #(
		.WIDTH     (FIFO_DATA_WIDTH),
		.DEPTH     (256),
		.SHOWAHEAD ("ON")
	) cpen430_dcfifo_inst (
		.aclr    (rst),
		.data    (fifo_wrdata),
		.wrclk   (clk),
		.wrreq   (fifo_wrreq),
		.rdclk   (rdclk),
		.rdreq   (fifo_rdreq),
		.q       (fifo_q),
		.rdempty (fifo_rdempty),
		.wrfull  (fifo_wrfull)
	);

endmodule
