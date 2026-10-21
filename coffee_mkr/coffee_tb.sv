
module coffee_tb;

    wire clk;
    wire rst;

    iclk #(5,5) u_iclk (.clk(clk));
    irst #(15)  u_irst (.rst(rst), .clk(clk));

    reg  [8:0] SW;
//    wire [8:0] LEDG;
    wire [17:0] LEDR;
    wire [9:0] LCD_data;
    reg  [3:0] KEY;

always @(*) 
	begin
    		SW[8]   = rst; // switch 8 as reset 
	end

initial
begin

	SW[7:0] = 8'h00000000;
	KEY = 4'b0000;
  	repeat(3) @(posedge clk);
   	while(rst) begin
      		repeat(1) @(posedge clk);
   	end
end
    coffee_top #(
        .DEBOUNCE_LIMIT (5),
	.ENABLE_PERIOD (5)
    ) dut (
    	.CLOCK_50(clk),
    	.SW(SW),
    	.KEY(KEY),
//    	.LEDG(LEDG),
    	.LEDR(LEDR),
	.LCD_out(LCD_data)
    );

endmodule 