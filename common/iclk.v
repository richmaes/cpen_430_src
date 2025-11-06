module iclk # (
    parameter tH = 5,
    parameter tL = 5
)
(
    output clk
);

reg clk_w;
    initial begin
        clk_w = 1'b0;
        forever begin
            #tH clk_w = 1'b1;
            #tL clk_w = 1'b0;
        end
    end

assign clk = clk_w;
endmodule