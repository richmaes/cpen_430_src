module coffee_top (
    input CLOCK_50,
    input [17:0] SW,
    input [3:0] KEY,
    output [8:0]LEDG,
    output [17:0] LEDR
);

assign LEDG = 9'h0;
assign LEDR = 18'h00000;
endmodule