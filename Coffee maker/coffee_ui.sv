// coffee_ui.sv 
// User interface debounce keys -> set the logic


module coffee_ui
    import coffee_recipes_pkg::*;
#(
    parameter int DEBOUNCE_LIMIT = 500000,   // 50 MHz clock: 10 ms
    parameter bit KEY_ACTIVE_LOW = 1'b1
)(
    input  logic       clk,
    input  logic       rst_n,
    input  logic [3:0] KEY,
    input  logic       busy,        // 1 while a drink is being made: selection locked
    output logic [2:0] csize,       // 0=10oz 1=16oz 2=20oz
    output logic [3:0] cflavor,     // 0=Coffee 1, 1=Coffee 2 (other values unused)
    output logic [2:0] ctype,       // drink_type_t (widened from [1:0])
    output logic       start        // start making the selected drink
);

		logic [3:0] key_db;
 	    // Debounce the switch inputs
     debouncer #(.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)) key0_debounced (
         .clk(clk),
         .rst_n(rst_n),
         .sw_in(KEY[0]),
         .sw_out(key_db[0])
     );

     debouncer #(.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)) key1_debounced (
         .clk(clk),
         .rst_n(rst_n),
         .sw_in(KEY[1]),
         .sw_out(key_db[1])
     );

     debouncer #(.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)) key2_debounced (
         .clk(clk),
         .rst_n(rst_n),
        .sw_in(KEY[2]),
         .sw_out(key_db[2])
     );

     debouncer #(.DEBOUNCE_LIMIT(DEBOUNCE_LIMIT)) key3_debounced (
        .clk(clk),
        .rst_n(rst_n),
        .sw_in(KEY[3]),
         .sw_out(key_db[3])
     );


    logic [3:0] pressed;       // debounced
    logic [3:0] pressed_d;     // edge detection
    logic [3:0] press_pulse;   // 1-clock pulse on each new press

    assign pressed     = KEY_ACTIVE_LOW ? ~key_db : key_db;
    assign press_pulse = pressed & ~pressed_d;

    always @(posedge clk) begin
        if (!rst_n) begin
            pressed_d <= '0;
            csize     <= 3'd0;
            cflavor   <= 4'd0;
            ctype     <= 3'(DRIP);
            start     <= 1'b0;
        end else begin
            pressed_d <= pressed;
            start     <= 1'b0;

            if (!busy) begin
                if (press_pulse[0])
                    cflavor <= {3'b000, ~cflavor[0]};
                if (press_pulse[1])
                    ctype <= (ctype == 3'(ESPRESSO)) ? 3'(DRIP) : ctype + 3'd1;
                if (press_pulse[2])
                    csize <= (csize == 3'd2) ? 3'd0 : csize + 3'd1;
                if (press_pulse[3])
                    start <= 1'b1;
            end
        end
    end

endmodule
