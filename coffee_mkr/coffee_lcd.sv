
//Block 1, LCD translator	coffee_lcd.sv
module coffee_lcd (
    input         clk,
    input         rst,
    // board side
    input  [16:0] SW,
    input  [3:0]  KEY,
    output 	  LCD,
    // logic side
    input	  lcd,
);

assign lcd = LCD;