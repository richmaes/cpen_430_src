// coffee_fsm.sv 
// Coffee production controller using a finite state maching
// recipe look up -> recipe timings -> actuators -> LCD message


module coffee_fsm
    import coffee_recipes_pkg::*;
#(
    parameter int MSG_TICKS 		  = 20,
    parameter int DONE_TICKS       = 30
)(
    input  logic                clk,
    input  logic                rst_n,
    input  logic                tick,        // 1-clock pulse every decisecond
    input  logic                start,       // coffee_ui start
    input  logic [2:0]          csize,
    input  logic [3:0]          cflavor,
    input  logic [2:0]          ctype,
    input  logic [11:0]   		  error,       // status from coffee_sensor

    output logic                busy,        // drink in progress
    output logic [8:0]    		  actuator_en, // HEAT/POUROVER/PRESSURE/WATER/GRINDER0/GRINDER1/PAPER/CH/ND
    output logic [8:0]          LED_errors,
    output logic [8:0]          LCD_msg
);


    coffee_recipe_t selected_recipe;

    // Recipe lookup function
    always @(*) begin
        selected_recipe = get_recipe(drink_type_t'(ctype), size_code_to_oz(csize));
    end
	// enum for the switches
    typedef enum logic [3:0] {
        S_IDLE     = 4'd0,
        S_PAPER    = 4'd1,     // S1
        S_GRIND    = 4'd2,     // S2
        S_POUROVER = 4'd3,     // S3
        S_PRESSURE = 4'd4,     // S4
        S_WATER    = 4'd5,     // S5
        S_CH       = 4'd6,     // S6
        S_ND       = 4'd7,     // S7
        S_DONE     = 4'd8,
        S_ERROR    = 4'd9,
        S_ARM      = 4'd10     // start
    } state_t;

    state_t         state_sw, next_state_sw;
    coffee_recipe_t active_recipe;
    logic           flavor_l;
    logic [2:0]     type_l;
    logic [1:0]     size_l;
    logic [15:0]    step_left;

    // Individual state timings for active recipe
    logic [15:0] PAPER_EN; // S1
    logic [15:0] GRINDER_EN;
    logic [15:0] POUROVER_EN;
    logic [15:0] PRESSURE_EN;
    logic [15:0] WATER_EN;
    logic [15:0] CH_EN;
    logic [15:0] ND_EN; // S7


    assign PAPER_EN    = active_recipe.PAPER_EN;
    assign GRINDER_EN  = active_recipe.GRINDER_EN;
    assign POUROVER_EN = active_recipe.POUROVER_EN;
    assign PRESSURE_EN = active_recipe.PRESSURE_EN;
    assign WATER_EN    = active_recipe.WATER_EN;
    assign CH_EN       = active_recipe.CH_EN;
    assign ND_EN       = active_recipe.ND_EN;

    wire any_error    = |error[ERR_STATUS:ERR_PAPER_EMPTY];
    wire recipe_valid = (selected_recipe.size_oz != 8'd0);


    logic [15:0] dur [0:7];
    always @(*) begin
        dur[0] = 16'd0;
        dur[1] = PAPER_EN;
        dur[2] = GRINDER_EN;
        dur[3] = POUROVER_EN;
        dur[4] = PRESSURE_EN;
        dur[5] = WATER_EN;
        dur[6] = CH_EN;
        dur[7] = ND_EN;
    end

    int     cur_index;
    state_t nxt_brew;
    always @(*) begin
        cur_index  = (state_sw == S_ARM) ? 0 : int'(state_sw);
        nxt_brew = S_DONE;
        for (int i = 7; i >= 1; i--)
            if (i > cur_index && dur[i] != 16'd0) nxt_brew = state_t'(4'(i));
    end

    always @(*) begin
        next_state_sw = state_sw;
        case (state_sw)
            S_IDLE:  if (any_error)                    	 next_state_sw = S_ERROR;
                     else if (start && recipe_valid)   next_state_sw = S_ARM;
            S_ARM:   if (any_error)                    	 next_state_sw = S_ERROR;
                     else if (tick)                    	 next_state_sw = nxt_brew;
            S_PAPER, S_GRIND, S_POUROVER, S_PRESSURE, S_WATER, S_CH, S_ND:
                     if (any_error)                    	 next_state_sw = S_ERROR;     // force idle
                     else if (tick && step_left <= 16'd1) next_state_sw = nxt_brew;
            S_DONE:  if (any_error)                    	 next_state_sw = S_ERROR;
                     else if (tick && step_left <= 16'd1) next_state_sw = S_IDLE;
            S_ERROR: if (!any_error)                   	 next_state_sw = S_IDLE;
            default:                                   	 next_state_sw = S_IDLE;
        endcase
    end

    // duration to load when entering next_state
    logic [15:0] dur_next;
    always @(*) begin
        case (next_state_sw)
            S_PAPER:    dur_next = PAPER_EN;
            S_GRIND:    dur_next = GRINDER_EN;
            S_POUROVER: dur_next = POUROVER_EN;
            S_PRESSURE: dur_next = PRESSURE_EN;
            S_WATER:    dur_next = WATER_EN;
            S_CH:       dur_next = CH_EN;
            S_ND:       dur_next = ND_EN;
            S_DONE:     dur_next = 16'(DONE_TICKS);
            default:    dur_next = 16'd0;
        endcase
    end

    // state register
    always @(posedge clk) begin
        if (!rst_n) state_sw <= S_IDLE;
        else        state_sw <= next_state_sw;
    end

    // datapath registers
    always @(posedge clk) begin
        if (!rst_n) begin
            active_recipe <= '0;
            flavor_l      <= 1'b0;
            type_l        <= 3'd0;
            size_l        <= 2'd0;
            step_left     <= 16'd0;
        end else begin
            if (state_sw == S_IDLE && next_state_sw == S_ARM) begin       // start accepted: latch the order
                active_recipe <= selected_recipe;
                flavor_l      <= cflavor[0];
                type_l        <= ctype;
                size_l        <= csize[1:0];
            end
            if (state_sw != next_state_sw)
                step_left <= dur_next;
            else if (tick && step_left != 16'd0)
                step_left <= step_left - 16'd1;
        end
    end

    // busy selection locked
    assign busy = (state_sw == S_ARM) || (state_sw >= S_PAPER && state_sw <= S_ND);

    // actuators
    always @(*) begin
        actuator_en = '0;
        case (state_sw)
            S_PAPER:    actuator_en[ACT_PAPER]    = 1'b1;
            S_GRIND:    if (flavor_l) actuator_en[ACT_GRINDER1] = 1'b1;
                        else          actuator_en[ACT_GRINDER0] = 1'b1;
            S_POUROVER: actuator_en[ACT_POUROVER] = 1'b1;
            S_PRESSURE: actuator_en[ACT_PRESSURE] = 1'b1;
            S_WATER:    actuator_en[ACT_WATER]    = 1'b1;
            S_CH:       actuator_en[ACT_CH]       = 1'b1;
            S_ND:       actuator_en[ACT_ND]       = 1'b1;
            default:    ;
        endcase
        // heater only while the water is cold; never into a hardware / water-pressure fault
        actuator_en[ACT_HEAT] = error[INF_COLD] & ~error[ERR_STATUS] & ~error[ERR_WP_HIGH] & ~error[ERR_WP_FAULT];
    end

    // LED indicators: {low pressure, CH, ND, bin1, bin0, paper low | status err, water-pressure err, paper err}
    assign LED_errors = { error[WRN_WP_LOW], error[WRN_CH], error[WRN_ND], error[WRN_BIN1],
                          error[WRN_BIN0],   error[WRN_PAPER],
                          error[ERR_STATUS],
                          error[ERR_WP_FAULT] | error[ERR_WP_HIGH],
                          error[ERR_PAPER_NONE] | error[ERR_PAPER_EMPTY] };

endmodule
