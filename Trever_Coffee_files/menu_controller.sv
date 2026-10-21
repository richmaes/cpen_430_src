//controls the menu with buttons to control 
//and outputs the drink parameters to seperate modules
module menu_controller(
	input logic CLK,RST,
	input logic UP,DOWN,SELECT,BACK,
	input logic FLAVOR,	//2 flavors, so 1 bit
	output logic [2:0] DRINK,   //since like 5 drinks, so 3 bits
	output logic [1:0] SIZE,	//since 3 sizes, 2 bits needed
	output logic START   //indicate drink making process, maybe

);

endmodule