// LCD_2x16_driver.sv
// LCD driver setting up lcd ip

module LCD_2x16_driver #(
    parameter int US_CYC = 50
)(
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic [1:0][15:0][7:0] LCD_msg_line,
    output logic [7:0]            LCD_out,
	 output logic LCD_EN,
	 output logic LCD_RS
);

    logic       DISPLAY_CLEAR;
    logic       DISPLAY_ON;
    logic [7:0] DATA;
    logic       DATA_VALID;
    logic [1:0] DATA_SOL;
    logic       DATA_RDY;
    logic       lcd_rs, lcd_e;
    logic [7:0] lcd_db;

    LCD_IP #(.US_CYC(US_CYC)) u_lcd_ip (
        .CLK           (clk),
        .RST           (~rst_n),
        .DISPLAY_CLEAR (DISPLAY_CLEAR),
        .DISPLAY_ON    (DISPLAY_ON),
        .DATA          (DATA),
        .DATA_VALID    (DATA_VALID),
        .DATA_SOL      (DATA_SOL),
        .DATA_RDY      (DATA_RDY),
        .LCD_RS        (LCD_RS),
        .LCD_E         (LCD_EN),
        .LCD_DB        (LCD_out)
    );

endmodule
