// coffee_recipes_pkg.sv
// Recipe table & lookup function
// Also included helper variables to unify

package coffee_recipes_pkg;
 
typedef enum logic [2:0] {
    DRIP      = 3'd0,
    AMERICANO = 3'd1,
    LATTE     = 3'd2,
    MOCHA     = 3'd3,
    ESPRESSO  = 3'd4
} drink_type_t;
 
typedef struct packed {
    drink_type_t drink_type;
    logic [7:0]  size_oz;
    logic [15:0] PAPER_EN;
    logic [15:0] GRINDER_EN;
    logic [15:0] POUROVER_EN;
    logic [15:0] PRESSURE_EN;
    logic [15:0] WATER_EN;
    logic [15:0] CH_EN;
    logic [15:0] ND_EN;
} coffee_recipe_t;
 
// Timing values are stored in deciseconds
localparam coffee_recipe_t COFFEE_RECIPES [15] = '{
 
    // Drip coffee
    '{DRIP,      8'd10, 16'd10, 16'd30, 16'd100, 16'd0,   16'd0,   16'd0,  16'd0},
    '{DRIP,      8'd16, 16'd10, 16'd48, 16'd160, 16'd0,   16'd0,   16'd0,  16'd0},
    '{DRIP,      8'd20, 16'd10, 16'd60, 16'd200, 16'd0,   16'd0,   16'd0,  16'd0},
 
    // Americano
    '{AMERICANO, 8'd10, 16'd10, 16'd6,  16'd0,   16'd40,  16'd80,  16'd0,  16'd0},
    '{AMERICANO, 8'd16, 16'd10, 16'd6,  16'd0,   16'd40,  16'd140, 16'd0,  16'd0},
    '{AMERICANO, 8'd20, 16'd10, 16'd6,  16'd0,   16'd40,  16'd180, 16'd0,  16'd0},
 
    // Latte
    '{LATTE,     8'd10, 16'd10, 16'd6,  16'd0,   16'd40,  16'd0,   16'd0,  16'd80},
    '{LATTE,     8'd16, 16'd10, 16'd6,  16'd0,   16'd40,  16'd0,   16'd0,  16'd140},
    '{LATTE,     8'd20, 16'd10, 16'd6,  16'd0,   16'd40,  16'd0,   16'd0,  16'd180},
 
    // Mocha
    '{MOCHA,     8'd10, 16'd10, 16'd6,  16'd0,   16'd40,  16'd0,   16'd30, 16'd70},
    '{MOCHA,     8'd16, 16'd10, 16'd6,  16'd0,   16'd40,  16'd0,   16'd30, 16'd130},
    '{MOCHA,     8'd20, 16'd10, 16'd6,  16'd0,   16'd40,  16'd0,   16'd30, 16'd170},
 
    // Espresso
    '{ESPRESSO,  8'd10, 16'd10, 16'd30, 16'd0,   16'd200, 16'd0,   16'd0,  16'd0},
    '{ESPRESSO,  8'd16, 16'd10, 16'd48, 16'd0,   16'd320, 16'd0,   16'd0,  16'd0},
    '{ESPRESSO,  8'd20, 16'd10, 16'd60, 16'd0,   16'd400, 16'd0,   16'd0,  16'd0}
 
};
 
     // Sensor status logic
    //   Errors   : machine must go idle      (bits 0 - 4)
    //   Warnings : machine keeps working		 (bits 5 - 10)
    localparam int ERR_PAPER_EMPTY = 0;   // PAPER_LEVEL = 2'b01
    localparam int ERR_PAPER_NONE  = 1;   // PAPER_LEVEL = 2'b00
    localparam int ERR_WP_HIGH     = 2;   // W_PRESSURE  = 2'b10
    localparam int ERR_WP_FAULT    = 3;   // W_PRESSURE  = 2'b11
    localparam int ERR_STATUS      = 4;   // STATUS      = 1'b0
    localparam int WRN_PAPER       = 5;   // PAPER_LEVEL = 2'b10
    localparam int WRN_BIN0        = 6;   // BIN_0_AMPTY = 1
    localparam int WRN_BIN1        = 7;   // BIN_1_AMPTY = 1
    localparam int WRN_ND          = 8;   // ND_AMPTY    = 1
    localparam int WRN_CH          = 9;   // CH_AMPTY    = 1
    localparam int WRN_WP_LOW      = 10;  // W_PRESSURE  = 2'b00
    localparam int INF_COLD        = 11;  // W_TEMP      = 1'b0

    // Actuator logic
    localparam int ACT_HEAT     = 0;   // HEAT_EN
    localparam int ACT_POUROVER = 1;   // POUROVER_EN
    localparam int ACT_PRESSURE = 2;   // PRESSURE_EN
    localparam int ACT_WATER    = 3;   // WATER_EN
    localparam int ACT_GRINDER0 = 4;   // GRINDER_0_EN
    localparam int ACT_GRINDER1 = 5;   // GRINDER_1_EN
    localparam int ACT_PAPER    = 6;   // PAPER_EN
    localparam int ACT_CH       = 7;   // CH_EN
    localparam int ACT_ND       = 8;   // ND_EN

    typedef enum logic [2:0] {
        M_SELECT = 3'd0,
        M_BREW   = 3'd1,
        M_DONE   = 3'd2,
        M_WARN   = 3'd3,
        M_ERROR  = 3'd4
    } msg_mode_t;

	 
// 3 bit input -> size value
function automatic logic [7:0] size_code_to_oz(input logic [2:0] size);
    case (size)
        3'd0:    return 8'd10;
        3'd1:    return 8'd16;
        3'd2:    return 8'd20;
        default: return 8'd0;
    endcase
endfunction
 
// recipe lookup logic
function automatic coffee_recipe_t get_recipe(input drink_type_t drink, input logic [7:0]  size_oz);
    coffee_recipe_t recipe;
    recipe = '0;
    for (int i = 0; i < 15; i++) begin
        if (COFFEE_RECIPES[i].drink_type == drink && COFFEE_RECIPES[i].size_oz == size_oz) begin
            recipe = COFFEE_RECIPES[i];
        end
    end
    return recipe;
endfunction
 
endpackage 