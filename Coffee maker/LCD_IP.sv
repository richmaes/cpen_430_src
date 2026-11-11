// LCD_IP.sv
// HD44780U (LCD-II) controller 
// timing module for LCD_2x16_driver

module LCD_IP #(
    parameter int US_CYC = 50
)(
    input  logic       CLK,
    input  logic       RST,             // active high
    input  logic       DISPLAY_CLEAR,
    input  logic       DISPLAY_ON,
    input  logic [7:0] DATA,
    input  logic       DATA_VALID,
    input  logic [1:0] DATA_SOL,
    output logic       DATA_RDY,
    // LCD interface
    output logic       LCD_RS,
    output logic       LCD_E,
    output logic [7:0] LCD_DB
);

endmodule
