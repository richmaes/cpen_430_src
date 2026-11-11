
// coffee_actuator.sv
// Actuators / LED outputs logic

module coffee_actuator(
    input  logic        clk,
    input  logic        rst_n,
    input  logic [8:0]  actuator_en,   // HEAT/POUROVER/PRESSURE/WATER/GRINDER0/GRINDER1/PAPER/CH/ND
    input  logic [8:0]  LED_errors,    // warning / error indicators
    output logic [17:0] LED_out
);

    always @(posedge clk) begin
        if (!rst_n) LED_out <= '0;
        else        LED_out <= {LED_errors, actuator_en};
    end

endmodule
