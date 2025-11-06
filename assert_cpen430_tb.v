`timescale 1ns/1ps

module assert_cpen430_tb();
    // Test bench signals
    reg clk;
    reg reset;
    reg test_expr;
    reg [128*8-1:0] message;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz clock
    end

    // Instance of assertion module
    assert_cpen430 uut (
        .clk(clk),
        .reset(reset),
        .test_expr(test_expr),
        .message(message)
    );

    // Test stimulus
    initial begin
        // Initialize test bench signals
        reset = 0;      // Active low reset
        test_expr = 0;
        message = "Test message for assertion";
        
        // Apply reset
        #10 reset = 1;
        // release reset
        #10 reset = 0;
        

        // Test 1: Normal operation (no assertion)
        #20 test_expr = 0;
        
        // Test 2: Trigger assertion
        #20;
        message = "Intentionally triggering assertion for testing";
        test_expr = 1;
        
        // Wait some time for the assertion to trigger
        #20;
        
        // Test should have ended due to $fatal
        $display("If you see this, the assertion did not trigger properly");
        $finish;
    end

    // Optional: Add timeout in case assertion doesn't trigger
    initial begin
        #200;  // Timeout after 200ns
        $display("Timeout occurred - test failed");
        $finish;
    end

endmodule
