//Connects all the parts together
module Coffee (
	//basic things
	input logic CLK,
	input logic RST,
	//inputs for the coffee machine
	input logic [3:0] BTN,	//4 button interface
	input logic [1:0] PAPER_LEVEL,
	input logic BIN_0_AMPTY,
	input logic BIN_1_AMPTY,
	input logic ND_AMPTY,
	input logic CH_AMPTy,
	input logic [1:0] W_PRESSURE,
	input logic W_TEMP,
	input logic STATUS,
	//There are 9 simulated outputs
	output logic HEAT_EN,
	output logic POUROVER_EN,
	output logic PRESSURE_EN,
	output logic WATER_EN,
	output logic GRINDER_0_EN,
	output logic GRINDER_1_EN,
	output logic PAPER_EN,
	output logic CH_EN,
	output logic ND_EN,
	// LCD connetions, don't know if they are right direction in this case
	//nevermind they are in this case because we are sending these signals to the lcd and the lcd sends the data rdy signal to this code
	output logic [7:0] DATA,
	output logic DATA_VALID,
	output logic [1:0] DATA_SOL,
	output logic DISPLAY_CLEAR,
	output logic DISPLAY_ON,
	input logic DATA_RDY
);

//instantiate all modules in project

deci_sec_timer timer1 (
	.CLK(CLK),
	.RST(RST),
	.enable( ),
	.step( ) 
);

debouncer up (
	.clk(CLK),
	.noisy(BTN[0]), 
	.clean()
);

debouncer down (
	.clk(CLK),
	.noisy(BTN[1]), 
	.clean()
);

debouncer select (
	.clk(CLK),
	.noisy(BTN[2]), 
	.clean()
);

debouncer back (
	.clk(CLK),
	.noisy(BTN[3]), 
	.clean()
);


endmodule