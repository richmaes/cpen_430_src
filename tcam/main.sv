
module main(
	input 			clk,
	input			rst,
	input logic [511:0] 	key,
	input logic [511:0] 	mask,
	input 			valid,
	output reg 		match,
	output reg 		no_match,
	output reg [2:0] 	addr = 3'b111
);
	
	
	logic [7:0][511:0] mem;
	reg [2:0] counter = 0;
	logic [511:0] mem_out;
	logic [511:0] maskLock, keyLock;

	always @(posedge clk) 
	begin
		if(counter == 3'b111 || rst) begin
			counter = 3'd0;
		end else begin
			counter <= counter +1;
		end
	end 

	always @(posedge clk)
	begin
		mem_out <= mem[counter];
	end

	always @(posedge clk) 
	begin
		mem_out = mem_out | maskLock;
		if(key == mem_out) begin
			match = 1;
			no_match = 0;
			if(counter < addr) begin
				addr <= counter;
			end
		end else begin
			match = 0;
			no_match = 1;
		end
	end

	always @(posedge clk)
	begin
		if(no_match == 1) begin
			addr <= 3'b111;
		end

		if(counter >= 8) begin
			counter = 0;
			if(valid) begin
				maskLock = mask;
				keyLock = key;
			end
		end
	end
endmodule

