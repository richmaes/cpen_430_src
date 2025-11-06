module irst # (
    parameter RST_DLY = 10
)
(
    input clk,
    output rst
);

reg [7:0] rstdly;
reg       rst_d;   // A sim-only assignment

initial begin
    rstdly = 8'h00; // You can only assign like this in simulation
    rst_d = 1'b1;   // A sim-only assignment
end

always @ (posedge clk)
begin
    rstdly <= (RST_DLY === rstdly) ? RST_DLY : rstdly + 8'h01;
    rst_d <= rst;
    if (rst_d & (RST_DLY === rstdly)) begin
        $display("%0t, Deasserting reset", $time);
    end
end

assign rst = rstdly !== RST_DLY;

endmodule
