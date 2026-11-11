// coffee_top.sv 
// helper to set the logic flow and data paths

module coffee_top
		import coffee_recipes_pkg::*;
#(
    	parameter DEBOUNCE_LIMIT = (500000), // 50MHz Clock
    	parameter ENABLE_PERIOD  = (5000000),  // clocks per decisecond (tick)

    	parameter LCD_US_CYC       = 50,
    	parameter MSG_TICKS 			= 20,
    	parameter DONE_TICKS       = 30
)(
		input CLOCK_50,
    	input  [17:0] SW,
    	input  [3:0] KEY,
    	output [17:0] LEDR,
	   output [7:0] LCD_out,
		output LCD_RW,
		output LCD_ON,
		output LCD_EN,
		output LCD_RS
	//	output reg [2:0][6:0] hex_out

);
    // Internal signals
    	wire rst_n;
    	wire enable_pulse;
		
    	wire [2:0] csize;
    	wire [3:0] cflavor;
		wire [2:0] ctype;

    	wire [11:0] error;

		wire [8:0] LCD_msg;
		wire [8:0] LED_errors;

		wire [1:0][15:0][7:0] LCD_msg_line;

		wire [8:0] actuator_en;
		wire             busy;
		wire             start;

    	assign rst_n = !SW[17];
		assign LCD_ON = 1'b1;
		assign LCD_RW = 1'b0;
		
    counter #(
	.COUNTER_MAX(ENABLE_PERIOD)
    ) timing_gen (
        .clk(CLOCK_50),
        .rst_n(rst_n),
        .enable(enable_pulse)
    );


    coffee_ui #(
	.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)
    ) keys (
	.clk(CLOCK_50),
   .rst_n(rst_n),
	.KEY(KEY),
	.busy(busy),
	.csize(csize),
	.cflavor(cflavor),
  	.ctype(ctype),
	.start(start)
    );

    coffee_sensor sensors (
	.clk(CLOCK_50),
   .rst_n(rst_n),
	.SW(SW[9:0]),
	.error(error)
    );

    coffee_fsm #(
	.MSG_TICKS(MSG_TICKS),
	.DONE_TICKS(DONE_TICKS)
    ) fsm (
	.clk(CLOCK_50),
   .rst_n(rst_n),
	.tick(enable_pulse),
	.start(start),
	.csize(csize),
	.cflavor(cflavor),
 	.ctype(ctype),
	.error(error),
	.busy(busy),
	.actuator_en(actuator_en),
	.LED_errors(LED_errors),
	.LCD_msg(LCD_msg)
    );

    coffee_actuator LEDS(
	.clk(CLOCK_50),
   .rst_n(rst_n),
	.actuator_en(actuator_en),
	.LED_errors(LED_errors),
	.LED_out(LEDR)
    );

/*
    coffee_LCDmsg LCD_msg_converter(
	.clk(CLOCK_50),
   .rst_n(rst_n),
	.LCD_msg(LCD_msg),
	.LCD_msg_line(LCD_msg_line)

);


    LCD_2x16_driver #(
	.US_CYC(LCD_US_CYC)
    ) LCD_driver (
	.clk(CLOCK_50),
   .rst_n(rst_n),
	.LCD_msg_line(LCD_msg_line),
	.LCD_out(LCD_out),
	.LCD_EN(LCD_EN),
	.LCD_RS(LCD_RS)
    );
	*/
endmodule
