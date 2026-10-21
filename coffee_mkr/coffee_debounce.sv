//Debouncer

module coffee_debounce #(parameter WIDTH = 1) (
    input              clk,
    input              rst,
    input  [WIDTH-1:0] noisy,
    output [WIDTH-1:0] clean
);
    assign clean = noisy;   
endmodule
