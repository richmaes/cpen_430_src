module coffee_top (
    input CLOCK_50,
    input RST,
    input [17:0] SW,
    input [3:0] KEY,
    output [8:0]LEDG,
    output [17:0] LEDR
);

assign LEDG = 9'h0;
assign LEDR = SW;
assign RST = SW[17];

endmodule

//FPGA top level	coffee_top.sv
