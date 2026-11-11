//Trevers FSM

import coffee_recipes_pkg::*;

module brewing_fsm (
    input logic clk, reset, start, flavor, tick, error, water_hot,
    input coffee_drink_t drink,
    input coffee_size_t size,
    output logic busy, done,
    output logic [3:0] state, //this is for the message controller to display the 
    output logic [8:0] enables   //these are the LED's
);



	// State names and assignemtns
    localparam IDLE=0, HEATING=1, PAPER=2, GRIND=3, POUR=4,
               PRESS=5, WATER=6, CHOC=7, ND=8, FINISH=9;

    coffee_recipe_t recipe; //from pckage file
    logic selected_flavor; //a or b
    logic [15:0] elapsed, duration;   //elapsed = time that has finished, duration = target time

    // 1. Recipe timing from the package file
    always_comb begin
        duration = 0;

        case (state)
            PAPER: duration = recipe.paper_ds;  //these are numbers from package file
            GRIND: duration = recipe.grinder_ds;
            POUR:  duration = recipe.pourover_ds;
            PRESS: duration = recipe.pressure_ds;
            WATER: duration = recipe.water_ds;
            CHOC:  duration = recipe.chocolate_ds;
            ND:    duration = recipe.non_dairy_ds;
            default: ;
        endcase
    end
	 
	 

    // 2. Brewing FSM
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            elapsed <= 0;
            recipe <= '0;
            selected_flavor <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    elapsed <= 0;

                    if (start) begin
                        recipe <= get_coffee_recipe(drink, size);
                        selected_flavor <= flavor;
                        state <= HEATING;
                    end
                end

                HEATING: begin //since this has no time, just go to next state once water is hot
                    if (water_hot) begin
                        state <= PAPER;
                        elapsed <= 0;
                    end
                end
					
                FINISH: begin
                    if (tick) begin
                        if (elapsed == 19) begin
                            state <= IDLE;
                            elapsed <= 0;
                        end
                        else
                            elapsed <= elapsed + 1; 
                    end
                end
 
                default: begin  
                    if (duration == 0 || (tick && elapsed + 1 >= duration)) begin
                        state <= state + 1;   //move to next state
                        elapsed <= 0; //time reset
                    end
                    else if (tick)  //increment time once we get a 0.1 sec tick
                        elapsed <= elapsed + 1;
                end
            endcase
        end
    end

	 
    // 3. Deciding the motor outputs with the LEDS
    always_comb begin
        busy = (state != IDLE && state != FINISH);
        done = (state == FINISH);
        enables = 0;

        if (busy) begin 
            if (!water_hot)
                enables[8] = 1;  //heat water LED

            case (state)
                PAPER: enables[2] = 1; //paper lED
                GRIND: begin
                    if (selected_flavor)
                        enables[3] = 1; //coffee b
                    else
                        enables[4] = 1; //coffee A
                end
                POUR:  enables[7] = 1;  //self explanatory LED's
                PRESS: enables[6] = 1;
                WATER: enables[5] = 1;
                CHOC:  enables[1] = 1;
                ND:    enables[0] = 1;
                default: ;
            endcase
        end

        if (state == HEATING)  //waiting for water to heat, so turn off all LED's
            enables[7:0] = 0;
    end

endmodule
