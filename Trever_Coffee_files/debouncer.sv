module debouncer #(parameter integer COUNT = 50000)(
    input logic clk, noisy,
    output logic clean = 0
);
    // 1. Synchronize the button and count stable clock cycles
    logic [$clog2(COUNT+1)-1:0] count = 0;
    
	 logic sync1 = 0, sync2 = 0;

    always_ff @(posedge clk) begin
        sync1 <= noisy;
        sync2 <= sync1;
        if (sync2 == clean) count <= 0;
        else if (count == COUNT-1) begin
            clean <= sync2;
            count <= 0;
        end else count <= count + 1'b1;
    end
endmodule
