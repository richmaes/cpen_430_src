module debouncer (
    input wire clk,
    input wire rst,         
    input wire noisy_in,    // switch input
    output reg clean_out    // debounced output
);

reg [19:0] count;
parameter MAX = 1_000_000; // 20ms at 50MHz

always @(posedge clk) begin
    if (rst) begin
        count <= 0;
        clean_out <= 0;
    end else if (noisy_in == clean_out) begin
			count <= 0;
    end else if (count == MAX - 1) begin
			clean_out <= noisy_in;
			count <= 0;
	end else begin  
		count <= count + 1;
    end
end

endmodule