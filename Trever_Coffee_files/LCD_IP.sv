module LCD_IP (
	//same ones from the top file
	input logic CLK,RST,
	input logic [7:0] DATA,
	input logic DATA_VALID,
	input logic [1:0] DATA_SOL,
	input logic DISPLAY_CLEAR,
	input logic DISPLAY_ON,
	output logic DATA_RDY,
	output logic LCD
	//maybe more?
	
);

endmodule