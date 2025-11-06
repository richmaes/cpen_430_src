`timescale 1ns/1ps
`include "fifo_structs.svh"
module tb_FIFO_demo;
    parameter WIDTH = 8;
    parameter DEPTH = 16;

    logic clk;
    logic rst;
    logic wr_en;
    logic rd_en;
    logic [WIDTH-1:0] din;
    logic [WIDTH-1:0] dout;
    logic full;
    logic empty;
    logic [$clog2(DEPTH):0] count;

    // Instantiate FIFO
    FIFO_demo #(.WIDTH(WIDTH), .DEPTH(DEPTH)) fifo (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty),
        .count(count)
    );

    // Clock: 10ns period
     iclk #(5,5) u_iclk(.clk(clk));
     irst #(15) u_irst(.rst(rst), .clk(clk));

    // Test stimulus
    initial begin

        #20;
        while (!rst) @(posedge clk);

        $display("Starting FIFO test: depth=%0d width=%0d", DEPTH, WIDTH);

        

        $display("Finished FIFO demo. Final count=%0d full=%0b empty=%0b", count, full, empty);
        $finish;
    end

endmodule
