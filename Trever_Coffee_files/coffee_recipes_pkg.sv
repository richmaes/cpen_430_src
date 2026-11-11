package coffee_recipes_pkg;
  // 1. Drink and size choices
  typedef enum logic [2:0] {DRINK_DRIP, DRINK_AMERICANO, DRINK_LATTE, DRINK_MOCHA, DRINK_ESPRESSO} coffee_drink_t;
  typedef enum logic [1:0] {SIZE_10_OZ, SIZE_16_OZ, SIZE_20_OZ} coffee_size_t;
  // 2. Recipe durations in tenths of a second
  typedef struct packed {
    logic [15:0] paper_ds, grinder_ds, pourover_ds, pressure_ds;
    logic [15:0] water_ds, chocolate_ds, non_dairy_ds, total_ds;
  } coffee_recipe_t;
  // 3. Look up the selected recipe
  function automatic coffee_recipe_t get_coffee_recipe(input coffee_drink_t drink, input coffee_size_t size);
    case (({1'b0,drink} * 4'd3) + {2'b0,size})
      4'd0: get_coffee_recipe = {16'd10, 16'd30, 16'd100, 16'd0, 16'd0, 16'd0, 16'd0, 16'd140}; // Drip 10oz
      4'd1: get_coffee_recipe = {16'd10, 16'd48, 16'd160, 16'd0, 16'd0, 16'd0, 16'd0, 16'd218}; // Drip 16oz
      4'd2: get_coffee_recipe = {16'd10, 16'd60, 16'd200, 16'd0, 16'd0, 16'd0, 16'd0, 16'd270}; // Drip 20oz
      4'd3: get_coffee_recipe = {16'd10, 16'd6, 16'd0, 16'd40, 16'd80, 16'd0, 16'd0, 16'd136}; // Americano 10oz
      4'd4: get_coffee_recipe = {16'd10, 16'd6, 16'd0, 16'd40, 16'd140, 16'd0, 16'd0, 16'd196}; // Americano 16oz
      4'd5: get_coffee_recipe = {16'd10, 16'd6, 16'd0, 16'd40, 16'd180, 16'd0, 16'd0, 16'd236}; // Americano 20oz
      4'd6: get_coffee_recipe = {16'd10, 16'd6, 16'd0, 16'd40, 16'd0, 16'd0, 16'd80, 16'd136}; // Latte 10oz
      4'd7: get_coffee_recipe = {16'd10, 16'd6, 16'd0, 16'd40, 16'd0, 16'd0, 16'd140, 16'd196}; // Latte 16oz
      4'd8: get_coffee_recipe = {16'd10, 16'd6, 16'd0, 16'd40, 16'd0, 16'd0, 16'd180, 16'd236}; // Latte 20oz
      4'd9: get_coffee_recipe = {16'd10, 16'd6, 16'd0, 16'd40, 16'd0, 16'd30, 16'd70, 16'd156}; // Mocha 10oz
      4'd10: get_coffee_recipe = {16'd10, 16'd6, 16'd0, 16'd40, 16'd0, 16'd30, 16'd130, 16'd216}; // Mocha 16oz
      4'd11: get_coffee_recipe = {16'd10, 16'd6, 16'd0, 16'd40, 16'd0, 16'd30, 16'd170, 16'd256}; // Mocha 20oz
      4'd12: get_coffee_recipe = {16'd10, 16'd30, 16'd0, 16'd200, 16'd0, 16'd0, 16'd0, 16'd240}; // Espresso 10oz
      4'd13: get_coffee_recipe = {16'd10, 16'd48, 16'd0, 16'd320, 16'd0, 16'd0, 16'd0, 16'd378}; // Espresso 16oz
      4'd14: get_coffee_recipe = {16'd10, 16'd60, 16'd0, 16'd400, 16'd0, 16'd0, 16'd0, 16'd470}; // Espresso 20oz
      default: get_coffee_recipe = '0;
    endcase
  endfunction
endpackage
