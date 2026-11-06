
module main(
	input 			clk,
	input			rst,
	input logic [511:0] 	key,
	input logic [511:0] 	mask,
	input 			valid,
	output reg 		match,
	output reg 		no_match,
	output reg [2:0] 	addr = 7
);
	
	//
	logic [7:0][511:0] 	mem;
	reg   [2:0] 		counter = 0;
	logic [511:0] 		mem_out;
	logic [511:0] 		maskLock, keyLock;
	reg			busy;

	always @(posedge clk) 
	begin
		match    <= 1'b0;
		no_match <= 1'b0;

		if (rst) begin
			busy    <= 1'b0;
			counter <= 3'd0;
			addr    <= 3'd7;
		end
		else if (!busy) begin
			if (valid) begin
				keyLock  <= key;
				maskLock <= mask;
				counter  <= 3'd0;
				busy     <= 1'b1;
			end
		end
		else begin
			if ((mem[counter] | maskLock) == (keyLock | maskLock)) begin
				match <= 1'b1;
				addr  <= counter; 
				busy  <= 1'b0;
			end
			else if (counter == 3'd7) begin
				no_match <= 1'b1;
				addr     <= 3'd7;
				busy     <= 1'b0;
			end
			else begin
				counter <= counter + 3'd1;
			end
		end
	end
endmodule

