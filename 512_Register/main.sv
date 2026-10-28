
model main();
	
	logic [7:0][511:0] mem;
	logic [511:0] mem_out

	always @(*) 
	begin
		if(mem[0] == 7) begin
			mem[0] == 0;
		end else
			mem[0] >> 1;
		end
	end 

	always @(posedge clk)
	begin
		mem_out <= mem[1];
	end

