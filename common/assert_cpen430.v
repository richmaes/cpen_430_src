module assert_cpen430 (
    input wire clk,           // Clock signal
    input wire reset,         // Reset signal
    input wire test_expr,     // Expression to test
    input [128*8-1:0] message     // Message to display (128 characters)
);

    // Simulation-only code
    initial begin
        if ($test$plusargs("ASSERT_ON")) begin
            $display("Assertions enabled");
        end
    end

    // Check assertion on positive clock edge
    always @(posedge clk) begin
        if (!reset) begin  // Active low reset
            if (test_expr) begin
                $display("Assertion Failed at time %0t", $time);
                $display("Message: %0s", message);
                $fatal(1, "Assertion failure detected");
            end
        end
    end

endmodule

// Example usage:
/*
wire [127:0] msg = "Counter overflow detected";
assert_cpen430 my_assert(
    .clk(clk),
    .reset(reset_n),
    .test_expr(counter_overflow),
    .message(msg)
);
*/
