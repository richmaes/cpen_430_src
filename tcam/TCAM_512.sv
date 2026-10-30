module TCAM_512(
input logic clk,
input logic [511:0] data,
input logic [511:0] tcam,
input logic valid,
input logic rst,

output logic no_match,
output logic match,
output logic [2:0] match_addr
);

logic [7:0][511:0] mem;
logic [511:0] mem_out;
logic [2:0] count;
/*
		.clk(clk),
		.rst(rst),
		.data(data),
		.tcam(tcam),
		.valid(valid),
		.match(match),
		.no_match(no_match),
		.match_addr(match_addr)
*/

always @(posedge clk) // search
	begin
		if(rst)begin
			count <= 0;
		end else begin
		
			count <= count + 3'b001;
		end

	end

always @(posedge clk)
begin
	mem_out <= mem[count];
end


always @(posedge clk)
begin
	match <= (valid &( &(tcam |~(data^mem[count]))));
	no_match <= !(valid &( &(tcam |~(data^mem[count]))));
	match_addr <= mem[count];

end

endmodule 

