//Block 5, coffee logic	coffee_fsm.sv

module coffee_fsm(
	//input 	    TYPE,
	input [0:4] DRINK,
	input [0:2] SIZE,
	
	output reg PAPER,
	output reg GRINDER,
	output reg POUROVER,
	output reg PRESSURE,
	output reg WATER,
	output reg CH,
	output reg ND
);

reg [0:7] drink = DRINK + SIZE;

assign PAPER = 1;
/*
case(drink)
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;
	8'b10000,100: GRINDER = , POUROVER = , PRESSURE = , WATER = , CH = , ND = ;

*/
endmodule
