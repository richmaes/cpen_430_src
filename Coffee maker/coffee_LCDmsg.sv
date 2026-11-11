// coffee_LCDmsg.sv
// Message code is 2 lines of 16 ASCII characters 
// All output strings on LCD are set here


module coffee_LCDmsg
    import coffee_recipes_pkg::*;
(
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic [8:0]            LCD_msg,
    output logic [1:0][15:0][7:0] LCD_msg_line     // 0 = top line 1 = bottom line
);
	// setting each rule
    wire [2:0] mode   = LCD_msg[8:6];
    wire       flavor = LCD_msg[5];
    wire [2:0] dtype  = LCD_msg[4:2];
    wire [1:0] dsize  = LCD_msg[1:0];
    wire [2:0] index    = LCD_msg[2:0];

    logic [71:0]  type_txt;     // 9 characters
    logic [63:0]  flavor_txt;   // 8 characters
    logic [39:0]  size_txt;     // 5 characters
    logic [127:0] l1, l2;       // 16 characters each, leftmost character in [127:120]

    always @(*) begin
        flavor_txt = flavor ? "COFFEE 2" : "COFFEE 1";
        case (dtype)
            3'd0:    type_txt = "DRIP     ";
            3'd1:    type_txt = "AMERICANO";
            3'd2:    type_txt = "LATTE    ";
            3'd3:    type_txt = "MOCHA    ";
            3'd4:    type_txt = "ESPRESSO ";
            default: type_txt = "?????????";
        endcase
        case (dsize)
            2'd0:    size_txt = "10 OZ";
            2'd1:    size_txt = "16 OZ";
            2'd2:    size_txt = "20 OZ";
            default: size_txt = "?? OZ";
        endcase

        l1 = "                ";
        l2 = "                ";
        case (mode)
            M_SELECT: begin
                l1 = {flavor_txt, " ", "SELECT "};
                l2 = {type_txt, "  ", size_txt};
            end
            M_BREW: begin
                l1 = {flavor_txt, " ", "BREWING"};
                l2 = {type_txt, "  ", size_txt};
            end
            M_DONE: begin
                l1 = "ENJOY YOUR DRINK";
                l2 = {type_txt, "  ", size_txt};
            end
            M_WARN: begin
                l1 = "WARNING!        ";
                case (index)
                    3'd0:    l2 = "PAPER LOW       ";
                    3'd1:    l2 = "COFFEE 1 LOW    ";
                    3'd2:    l2 = "COFFEE 2 LOW    ";
                    3'd3:    l2 = "CREAMER LOW     ";
                    3'd4:    l2 = "CHOCOLATE LOW   ";
                    3'd5:    l2 = "LOW WATER PRESS.";
                    default: l2 = "                ";
                endcase
            end
            M_ERROR: begin
                l1 = "ERROR           ";
                case (index)
                    3'd0:    l2 = "PAPER EMPTY     ";
                    3'd1:    l2 = "PAPER MISSING   ";
                    3'd2:    l2 = "WATER PRESS HIGH";
                    3'd3:    l2 = "WATER PRESS ERR ";
                    3'd4:    l2 = "HARDWARE FAULT  ";
                    default: l2 = "                ";
                endcase
            end
            default: begin
                l1 = "????????????????";
                l2 = "????????????????";
            end
        endcase
    end

    // Registered output
    always @(posedge clk) begin
        if (!rst_n) begin
            for (int c = 0; c < 16; c++) begin
                LCD_msg_line[0][c] <= 8'h20;
                LCD_msg_line[1][c] <= 8'h20;
            end
        end else begin
            for (int c = 0; c < 16; c++) begin
                LCD_msg_line[0][c] <= l1[127 - 8*c -: 8];
                LCD_msg_line[1][c] <= l2[127 - 8*c -: 8];
            end
        end
    end

endmodule
