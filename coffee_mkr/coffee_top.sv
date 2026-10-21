
module coffee_top #(
    	parameter DEBOUNCE_LIMIT = (500000), // 50MHz Clock 
    	parameter ENABLE_PERIOD  = (8750000)
)( 
// clock, input switches and keys
	input CLOCK_50,
    	input  [8:0] SW,
    	input  [3:0] KEY,
    	output [17:0] LEDR,
	output [9:0] LCD_out

);
    // Internal signals
    	wire rst_n;
    	wire enable_pulse;

    // could add debouncing for each switch
    	wire [2:0] csize;
    	wire [3:0] cflavor;
	wire [1:0] ctype;
    	wire [7:0] error;
	wire [8:0] LCD_msg; // which preset message to send ( errors, warnings, settings, 
	wire [8:0] LED_errors;
	wire [15:0][7:0] LCD_msg_line;
    // Reset is SW[8]
    	assign rst_n = SW[8];
    counter #(
	.COUNTER_MAX(ENABLE_PERIOD)
    ) timing_gen (
        .clk(CLOCK_50),
        .rst_n(rst_n),
        .enable(enable_pulse)
    );
    coffee_ui keys/* #(
	.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)
)*/(
	.clk(CLOCK_50),
        .rst_n(rst_n),
	.KEY(KEY),
	.csize(csize),
	.cflavor(cflavor),
  	.ctype(ctype)
    );

    coffee_sensor sensors/* #( // if switches need debouncing
	.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)
)*/(
	.clk(CLOCK_50),
        .rst_n(rst_n),
	.SW(SW),
	.error(error)
    );

    coffee_fsm fsm(
	.clk(CLOCK_50),
        .rst_n(rst_n),
	.csize(csize),
	.cflavor(cflavor),
 	.ctype(ctype),
	.error(error),
	.LED_errors(LED_errors),
	.LCD_msg(LCD_msg)


    );
    
    coffee_actuator LEDS(
	.clk(CLOCK_50),
        .rst_n(rst_n),
	.LED_errors(LED_errors),
	.LED_out(LEDR)
	

);

    coffee_LCDmsg LCD_msg_converter(
	.clk(CLOCK_50),
        .rst_n(rst_n),
	.LCD_msg(LCD_msg),
	.LCD_msg_line(LCD_msg_line)
	
);

    LCD_2x16_driver LCD_driver(
	.clk(CLOCK_50),
        .rst_n(rst_n),
	.LCD_msg_line(LCD_msg_line),
	.LCD_out(LCD_out)
);




endmodule 