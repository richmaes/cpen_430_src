module lcd_slow_cntr
(
input clk,
input rst,
output logic pulse
);

logic [15:0] counter;

 always @ (posedge clk)
	begin
	if(rst)
	    counter <= 16'h0000;
	else
	    counter <= counter < 16'd50000 ? counter + 16'h0001 : 16'h0000;
    end

	always @ (posedge clk)
	begin
	pulse <= ~|counter;  // trigger when counter is 0
    end

endmodule