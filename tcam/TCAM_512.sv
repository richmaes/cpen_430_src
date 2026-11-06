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
logic [511:0] key_q;
logic [511:0] mask_q;

logic [7:0][511:0] mem;
logic [511:0] mem_out;
logic         busy;
logic [2:0]   address;
logic [511:0] diff;
logic         hit;

always @(*) 
begin
    hit = &(~(mem[address] ^ key_q) | mask_q);
end
always @(posedge clk)
    begin
	if (rst) begin
    	    busy       <= 1'b0;
	    address    <= 3'd0;
	    key_q      <= '0;
	    mask_q     <= '0;
	    match      <= 1'b0;
	    no_match   <= 1'b0;
	    match_addr <= 3'd0;
	end
	else begin
	    match    <= 1'b0;
	    no_match <= 1'b0;
	    if (busy) begin
		if (hit) begin
		    match      <= 1'b1;
	  	    match_addr <= address;
		    busy       <= 1'b0;
		end
		else if (address == 7) begin
		    no_match <= 1'b1;
		    busy     <= 1'b0;
		end
		else begin
		    address <= address + 3'd1;
		end
	    	end
	    	else if (valid) begin
		key_q  <= data;
		mask_q <= tcam;
		address <= 3'd0;
		busy   <= 1'b1;
	 	end
	    end
	end
endmodule


