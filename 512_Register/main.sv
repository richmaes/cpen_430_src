
module main(
	input 				clk,
	input logic [511:0] 		mask,
	input logic [511:0] 		key,
	input logic [7:0][511:0] 	mem,
	
	output reg 		match = 0,
	output reg 		no_match = 0,
	output reg [3:0] 	addr = 4'd9
);
	
	

	reg [3:0] counter = 0;
	logic [511:0] mem_out;

	always @(*) 
	begin
		if(counter == 4'd8) begin
			counter = 4'd0;
		end else begin
			counter <= counter +1;
		end
	end 

	always @(posedge clk)
	begin
		mem_out <= mem[counter];
	end

	always @(*) 
	begin
		mem_out = mem_out | mask;
		if(key == mem_out) begin
			match <= 1;
			no_match <= 0;
			if(counter < addr) begin
				addr <= counter;
			end
		end else begin
			match <= 0;
			no_match <= 1;
		end
	end

	always @(posedge clk)
	begin
		if(no_match == 1) begin
			addr <= 4'd9;
		end
	end
	/* 
	reg [2:0] temp;

	always @(*) 
	begin
		temp = mem[counter] | mask;
		if(key == temp) begin
			match <= 1;
			no_match <= 0;
			if(counter < addr) begin
				addr <= counter;
			end
		end else begin
			match <= 0;
			no_match <= 1;
		end
	end
	*/
endmodule

