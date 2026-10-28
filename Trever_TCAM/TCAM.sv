//final inputs/outputs of file, I think, currently clk and reset
module TCAM (
	input logic CLK,
	input logic reset
);

//memmory stuff
logic [7:0] [14:0] mem;
logic [14:0] mem_out;

always @ (posedge clk)

begin
	if ()  
		mem_out <= mem[count[2:0]];   //maybe
end


//change TCAM logic later to adapt
module TCAM #(
	parameter N = 8
)(

	input wire [N-1:0] data,
	input wire [N-1:0] pattern,
	input wire [N-1:0] mask,
	output wire match
);

assign match = &(mask | ~ (pattern ^ data));

//counter stuff
logic [2:0] count;

always @(posedge clk)

begin
	if (reset)
		count <= 0;
	else if (count == 7)
		count <= 0;
	else
		count <= count + 1;
end

endmodule