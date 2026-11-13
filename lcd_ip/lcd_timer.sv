module lcd_timer (
input clk,
input rst,
input clear,
output logic timer_1ms,
output logic timer_5ms,
output logic timer_15ms
);

localparam TIMER_1MS_COUNT = 50000;
localparam CNTR_WIDTH = $clog2(15*TIMER_1MS_COUNT);

logic [CNTR_WIDTH-1:0] counter;

always @ (posedge clk)
begin
if (rst)
    counter <= {CNTR_WIDTH{1'b0}};
else
    // On Clear, set to 0, else count until terminal count and hold
    counter <= clear    ? {CNTR_WIDTH{1'b0}} :              // Use of the multiple CONCAT statment
               &counter ? {CNTR_WIDTH{1'b1}} : counter + 1; // Use of bitwise AND to stop counting
end

// Clear also forces the timers signals to clear
always @ (posedge clk)
begin
timer_1ms  <= clear ? 1'b0 : counter >= TIMER_1MS_COUNT;
timer_5ms  <= clear ? 1'b0 : counter >= 5*TIMER_1MS_COUNT;
timer_15ms <= clear ? 1'b0 : counter >= 15*TIMER_1MS_COUNT;
end

endmodule