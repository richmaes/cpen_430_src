
//Blocks 2-4, LED, switch and button translators	coffee_io.sv

module coffee_io (
    input         clk,
    input         rst,
    // board side
    input  [16:0] SW,
    input  [3:0]  KEY,
    output [8:0]  LEDG,
    output [17:0] LEDR,
    // logic side
    output [16:0] sw_out,
    output [3:0]  btn_out,
    input  [8:0]  led_g_in,
    input  [17:0] led_r_in
);
    coffee_debounce #(.WIDTH(4)) u_deb_btn (
        .clk(clk), 
	.rst(rst), 
	.noisy(KEY), 
	.clean(btn_out)
    );

    assign sw_out = SW;
    assign LEDG   = led_g_in;
    assign LEDR   = led_r_in;
endmodule

