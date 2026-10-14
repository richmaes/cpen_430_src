module coffee_tb;

    wire clk;
    wire rst;
    reg  [17:0] SW;
    wire [8:0] LEDG;
    wire [17:0] LEDR;
    reg  [3:0] KEY;

    iclk #(5,5) u_iclk (.clk(clk));
    irst #(15)  u_irst (.rst(rst), .clk(clk));

// Using switch 17 as RST
always @(*)
begin
   SW[17] = rst;
end

initial
begin
   // You will need to reassign these as needed for your test.
   SW[16:0] = 17'h00000;
   KEY = 4'b0000;
   repeat(3) @(posedge clk);
   while(rst) begin
      repeat(1) @(posedge clk);
   end
end

// Instance your coffee module here
coffee_top u_coffee_top
(
    .CLOCK_50(clk),
    .SW(SW),
    .KEY(KEY),
    .LEDG(LEDG),
    .LEDR(LEDR)
);

endmodule