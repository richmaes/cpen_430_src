//Trever's Top file
import coffee_recipes_pkg::*;

module Coffee (
	input logic CLOCK_50, 
	input logic [17:0] SW, 
	input logic [3:0] KEY,
	output logic [8:0] LEDG,
	output logic LCD_RS,LCD_RW,LCD_E, 
	output logic [7:0] LCD_DB, 
	output logic LCD_ON
);


 
 // Board inputs and signals
 logic reset,tick,error,warning,busy,done,start,flavor;
 logic [3:0] ec,wc,brew_state;
 logic [5:0] warnings;
 logic [1:0] page;
 coffee_drink_t drink;
 coffee_size_t size;
 logic [3:0] btn;
 logic [8:0] enables;
 logic [7:0] lcd_data;
 logic lcd_valid,lcd_rdy,lcd_clear,lcd_on;
 logic [1:0] lcd_sol;
 assign reset=SW[17];
 assign LCD_ON = 1'b1;
 
 
//for hardcode coffee drink
assign flavor = 1'b0;          // Coffee A
assign drink = DRINK_MOCHA;
assign size = SIZE_16_OZ;

// Debounced start button
debouncer #(.COUNT(250000)) db_start ( // 5 ms
    .clk(CLOCK_50),
    .noisy(~KEY[1]),
    .clean(start)
);
 
 
 
 
 
 // Buttons
debouncer #(.COUNT(50000)) db0 (
    .clk(CLOCK_50),
    .noisy(~KEY[0]),
    .clean(btn[0])
);

/*
debouncer #(.COUNT(50000)) db1 (
    .clk(CLOCK_50),
    .noisy(~KEY[1]),
    .clean(btn[1])
);

*/

debouncer #(.COUNT(50000)) db2 (
    .clk(CLOCK_50),
    .noisy(~KEY[2]),
    .clean(btn[2])
);

debouncer #(.COUNT(50000)) db3 (
    .clk(CLOCK_50),
    .noisy(~KEY[3]),
    .clean(btn[3])
);

/* // Menu
 menu_controller u_menu(
	.clk(CLOCK_50),
	.reset(reset),
	.up(btn[3]),
	.down(btn[2]),
   .select_btn(btn[1]),
	.back_btn(btn[0]),
	.busy(busy || done || error),
   .drink(drink),
	.size(size),
	.flavor(flavor),
	.start(start),
	.page(page)
);
*/
	//Sensors
 sensor_monitor u_sensors(
	.paper_level(SW[1:0]),
	.bin0_low(SW[2]),
	.bin1_low(SW[3]),
   .nd_low(SW[4]),
	.ch_low(SW[5]),
	.water_pressure(SW[7:6]),
   .status_ok(SW[9]),
	.error(error),
	.warning(warning),
   .error_code(ec),
	.warning_code(wc),
	.warnings(warnings)
);
 
 // Timer
 deci_timer #(.PERIOD(5000000)) u_timer(
	.clk(CLOCK_50),
	.reset(reset),
	.tick(tick)
);
 
 //FSM
 brewing_fsm u_brew(
	.clk(CLOCK_50),
	.reset(reset),
	.start(start),
	.flavor(flavor),
   .tick(tick),
	.error(error),
	.water_hot(SW[8]),
	.drink(drink),
	.size(size),
   .busy(busy),
	.done(done),
	.state(brew_state),
	.enables(enables)
);
 
 /*
 display_message_controller u_message(
	.clk(CLOCK_50),
	.reset(reset),
   .drink(drink),
	.size(size),
	.flavor(flavor),
	.page(page),
	.brew_state(brew_state),
   .warning(warning),
	.error(error),
	.warning_code(wc),
	.error_code(ec),
	.warnings(warnings),
   .data_rdy(lcd_rdy),
	.data(lcd_data),
	.data_valid(lcd_valid),
   .data_sol(lcd_sol),
	.display_clear(lcd_clear),
	.display_on(lcd_on)
);
*/
 
 //put LCD IP stuff Here
 
 // 6. LED outputs
 assign LEDG=enables;
endmodule
