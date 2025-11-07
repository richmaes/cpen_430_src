`timescale 1ns/1ps
`include "fifo_structs.svh"
module tb_FIFO_demo;
    parameter WIDTH = 8;
    parameter DEPTH = 16;

    logic [31:0] ii, jj, kk, ll;
    logic [31:0] ii_seed, jj_seed, kk_seed, ll_seed;

    logic clk;
    // rst is driven by the instantiated reset generator (irst). Declare as a net
    // so the continuous assignment inside irst updates this signal reliably.
    wire rst;
    logic [31:0] timeout;
    logic wr_en;
    logic rd_en;
    logic rd_en_d;
    logic [WIDTH-1:0] din;
    logic [WIDTH-1:0] dout;
    logic [3:0]full;
    logic empty;
    logic [$clog2(DEPTH):0] count;

    control_t cntrl_in [0:3];

    // Instantiate FIFO
    FIFO_demo #(.WIDTH(WIDTH), .DEPTH(DEPTH)) fifo (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .cntrl_in(cntrl_in),
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
        for (int k = 0; k < 4; k = k + 1)
        begin
           cntrl_in[k] = 'h0000_0000;
        end
        


        #20;
        while (rst) 
        begin 
            repeat(1) @(posedge clk);
            $display("rst = %d, ckpt2",rst);
        end


        $display("Starting FIFO test: depth=%0d width=%0d", DEPTH, WIDTH);

        fork
            for(ii = 0; ii < 10; ii = ii + 1) begin
                load_packet_0(ii,$urandom_range(1,15));
            end
            for(jj = 0; jj < 10; jj = jj + 1) begin
                load_packet_1(jj,$urandom_range(1,15));
              
            end
            for(kk = 0; kk < 10; kk = kk + 1) begin
                load_packet_2(kk,$urandom_range(1,15));
              
            end
            for(ll = 0; ll < 10; ll = ll + 1) begin
                load_packet_3(ll,$urandom_range(1,15));    
            end

        join

        repeat(1000) @(posedge clk);

        $display("Finished FIFO demo. Final count=%0d full=%0b empty=%0b", count, full, empty);
        $finish;
    end

    task load_packet_0(input [31:0] idx, input int size);
        // Implement packet loading logic for FIFO 0
        // size: number of 32-bit data words to send
        // This task drives cntrl_in[0] with control_t words, asserting
        // sop on the first word, eop on the last word, and we=1 for each
        // word. pri is left as 0 (not used yet).
        automatic control_t ctrl;
        int i;
        begin
            // Guard: if size <= 0 do nothing
            if (size <= 0) begin
                $display("%0t: load_packet_0 called with non-positive size=%0d", $time, size);
                return;
            end
            $display("%0t: load_packet_0 idx = %d called with size=%0d", $time, idx, size);
            for (i = 0; i < size; i++) begin
                // Fill data with a simple pattern (can be replaced by caller)
                ctrl.pkt.data = 32'hDEAD_0000 + i;
                ctrl.pkt.err  = 1'b0; // pri interface ignored for now
                ctrl.pkt.sop  = (i == 0) ? 1'b1 : 1'b0;
                ctrl.pkt.eop  = (i == size-1) ? 1'b1 : 1'b0;
                ctrl.we = 1'b0;
                cntrl_in[0] = ctrl;
                while (full[0]) begin 
                    repeat(1) @(posedge clk); // wait if FIFO 3 is full
                    timeout = timeout + 1;
                    if (timeout > 1000) begin
                        $display("%0t: ERROR: Timeout waiting to write to FIFO 0", $time);
                        $finish;
                    end
                end
                ctrl.we   = 1'b1; // enable write for this dataword

                // Drive the control port for FIFO 1
                cntrl_in[0] = ctrl;

                // Wait one clock so the FIFO sees the write
                @(posedge clk);
            end

            // Deassert write after packet
            ctrl.we = 1'b0;
            ctrl.pkt.sop = 1'b0;
            ctrl.pkt.eop = 1'b0;
            cntrl_in[0] = ctrl;
            @(posedge clk);
        end
    endtask

    task load_packet_1(input [31:0] idx, input int size);
        // Implement packet loading logic for FIFO 0
        // size: number of 32-bit data words to send
        // This task drives cntrl_in[0] with control_t words, asserting
        // sop on the first word, eop on the last word, and we=1 for each
        // word. pri is left as 0 (not used yet).
        automatic control_t ctrl;
        logic [31:0] timeout;
        int i;
        begin
            timeout = 0;
            // Guard: if size <= 0 do nothing
            if (size <= 0) begin
                $display("%0t: load_packet_1 called with non-positive size=%0d", $time, size);
                return;
            end
            $display("%0t: load_packet_1 idx = %d called with size=%0d", $time, idx, size);

            for (i = 0; i < size; i++) begin
                // Fill data with a simple pattern (can be replaced by caller)
                ctrl.pkt.data = 32'hDEAD_0000 + i;
                ctrl.pkt.err  = 1'b0; // pri interface ignored for now
                ctrl.pkt.sop  = (i == 0) ? 1'b1 : 1'b0;
                ctrl.pkt.eop  = (i == size-1) ? 1'b1 : 1'b0;
                ctrl.we = 1'b0;
                 cntrl_in[1] = ctrl;
                while (full[1]) begin 
                    repeat(1) @(posedge clk); // wait if FIFO 3 is full
                    timeout = timeout + 1;
                    if (timeout > 1000) begin
                        $display("%0t: ERROR: Timeout waiting to write to FIFO 1", $time);
                        $finish;
                    end
                end
                ctrl.we   = 1'b1; // enable write for this dataword

                // Drive the control port for FIFO 2
                cntrl_in[1] = ctrl;

                // Wait one clock so the FIFO sees the write
                @(posedge clk);
            end

            // Deassert write after packet
            ctrl.we = 1'b0;
            ctrl.pkt.sop = 1'b0;
            ctrl.pkt.eop = 1'b0;
            cntrl_in[1] = ctrl;
            @(posedge clk);
        end
    endtask

    task load_packet_2(input [31:0] idx, input int size);
        // Implement packet loading logic for FIFO 0
        // size: number of 32-bit data words to send
        // This task drives cntrl_in[0] with control_t words, asserting
        // sop on the first word, eop on the last word, and we=1 for each
        // word. pri is left as 0 (not used yet).
        automatic control_t ctrl;
        int i;
        begin
            // Guard: if size <= 0 do nothing
            if (size <= 0) begin
                $display("%0t: load_packet_2 called with non-positive size=%0d", $time, size);
                return;
            end
            $display("%0t: load_packet_2 idx = %d called with size=%0d", $time, idx, size);

            for (i = 0; i < size; i++) begin
                // Fill data with a simple pattern (can be replaced by caller)
                ctrl.pkt.data = 32'hDEAD_0000 + i;
                ctrl.pkt.err  = 1'b0; // pri interface ignored for now
                ctrl.pkt.sop  = (i == 0) ? 1'b1 : 1'b0;
                ctrl.pkt.eop  = (i == size-1) ? 1'b1 : 1'b0;
                ctrl.we = 1'b0;
                 cntrl_in[2] = ctrl;
                while (full[2]) begin 
                    repeat(1) @(posedge clk); // wait if FIFO 3 is full
                    timeout = timeout + 1;
                    if (timeout > 1000) begin
                        $display("%0t: ERROR: Timeout waiting to write to FIFO 2", $time);
                        $finish;
                    end
                end
                ctrl.we   = 1'b1; // enable write for this dataword

                // Drive the control port for FIFO 3
                cntrl_in[2] = ctrl;

                // Wait one clock so the FIFO sees the write
                @(posedge clk);
            end

            // Deassert write after packet
            ctrl.we = 1'b0;
            ctrl.pkt.sop = 1'b0;
            ctrl.pkt.eop = 1'b0;
            cntrl_in[2] = ctrl;
            @(posedge clk);
        end
    endtask

    task load_packet_3(input [31:0] idx, input int size);
        // Implement packet loading logic for FIFO 0
        // size: number of 32-bit data words to send
        // This task drives cntrl_in[0] with control_t words, asserting
        // sop on the first word, eop on the last word, and we=1 for each
        // word. pri is left as 0 (not used yet).
        automatic control_t ctrl;
        int i;
        begin
            // Guard: if size <= 0 do nothing
            if (size <= 0) begin
                $display("%0t: load_packet_3 called with non-positive size=%0d", $time, size);
                return;
            end
            $display("%0t: load_packet_3 idx = %d called with size=%0d", $time, idx, size);

            for (i = 0; i < size; i++) begin
                // Fill data with a simple pattern (can be replaced by caller)
                ctrl.pkt.data = 32'hDEAD_0000 + i;
                ctrl.pkt.err  = 2'b00; // pri interface ignored for now
                ctrl.pkt.sop  = (i == 0) ? 1'b1 : 1'b0;
                ctrl.pkt.eop  = (i == size-1) ? 1'b1 : 1'b0;
                ctrl.we = 1'b0;
                cntrl_in[3] = ctrl;
                 while (full[3]) begin 
                    repeat(1) @(posedge clk); // wait if FIFO 3 is full
                    timeout = timeout + 1;
                    if (timeout > 1000) begin
                        $display("%0t: ERROR: Timeout waiting to write to FIFO 3", $time);
                        $finish;
                    end
                end
                ctrl.we   = 1'b1; // enable write for this dataword

                // Drive the control port for FIFO 0
                cntrl_in[3] = ctrl;

                // Wait one clock so the FIFO sees the write
                @(posedge clk);
            end

            // Deassert write after packet
            ctrl.we = 1'b0;
            ctrl.pkt.sop = 1'b0;
            ctrl.pkt.eop = 1'b0;
            cntrl_in[3] = ctrl;
            @(posedge clk);
        end
    endtask

    assign rd_en = !empty && rd_en_d; 

    always @ (posedge clk) begin
        // Read full packets
        rd_en_d <= !empty; 
    end

endmodule
