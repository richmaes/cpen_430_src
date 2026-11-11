module coffee_top (
    input wire CLOCK_50,
    input wire [17:0] SW,
    input wire [3:0] KEY,
    output wire [8:0]LEDG,
    output wire [17:0] LEDR
);

wire sw_clean;
wire rst_sync;
wire sw_sync;

sync_2ff s_rst (
	.clk(CLOCK_50), 
	.async_in(SW[17]), 
	.sync_out(rst_sync)
);

sync_2ff s_sw (
	.clk(CLOCK_50),
	.async_in(SW[0]),
	.sync_out(sw_sync)
);

// sync, then debounce
debouncer db_sw (
	 .clk       (CLOCK_50),
    .rst       (rst_sync),
    .noisy_in  (sw_sync),
    .clean_out (sw_clean)
);	 

coffee_fsm fsm (
    .clk       (CLOCK_50),
    .rst       (rst_sync),
    .key       (KEY),
    .switch    (sw_clean),
	 .ledg		(LEDG),
	 .ledr		(LEDR)

);

endmodule