module lcd_ip_tb #(

);
	

	logic clk;
	logic rst;
	logic pulse;
	logic [15:0] counter;
	logic rs;       // Register Select
	logic rw;       // Read/Writen
	logic e;        // enable
	logic [7:0] db; // LCD Data bus

   // 20ns is a 50 Mhz clk
    iclk #(10, 10) u_iclk (
        .clk(clk)
    );

    irst #(15) u_irst (
        .rst(rst),
        .clk(clk)
    );
    
    lcd_slow_cntr u_lcd_slow_cntr
    (
	    .rst(rst),
	    .clk(clk),
	    .pulse(pulse)
    );

    lcd_ip u_lcd_ip(
       .clk(clk),
	   .rst(rst),
	   .pulse(pulse),
	   .rs(),
	   .rw(),
	   .e(),
	   .db(),
	   .debug_out()
	);

    initial 
	begin
	repeat (10) @ (posedge clk);
    
    // Enough for two pulses to be observed
	repeat (5000000) @ (posedge clk);


	repeat (10) @ (posedge clk);
    $finish();
	end


endmodule
