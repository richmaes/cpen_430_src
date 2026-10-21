

module coffee_ui /*#(
	parameter DEBOUNCE_LIMIT = (500000)


)*/(
	input clk,
        input rst_n,
	input [3:0] KEY,
    	output [2:0] csize,
    	output [3:0] cflavor,
	output [1:0] ctype

);
/*    	wire key0_debounced;
    	wire key1_debounced;
    	wire key2_debounced;
    	wire key3_debounced;
	    // Debounce the switch inputs
    debouncer #(.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)) key0_debounced (
        .clk(CLOCK_50),
        .rst_n(rst_n),
        .sw_in(KEY[0]),
        .sw_out(key0_debounced)
    );

    debouncer #(.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)) key1_debounced (
        .clk(CLOCK_50),
        .rst_n(rst_n),
        .sw_in(KEY[1]),
        .sw_out(key1_debounced)
    );

    debouncer #(.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)) key2_debounced (
        .clk(CLOCK_50),
        .rst_n(rst_n),
        .sw_in(KEY[2]),
        .sw_out(key2_debounced)
    );

    debouncer #(.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)) key3_debounced (
        .clk(CLOCK_50),
        .rst_n(rst_n),
        .sw_in(KEY[3]),
        .sw_out(key3_debounced)
    );

*/
endmodule 
