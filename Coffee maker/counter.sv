// Free-running tick generator: `enable` is high for one clk every COUNTER_MAX cycles.
// Skip this file if your course already provides a `counter` with the same ports.
module counter #(
    parameter int COUNTER_MAX = 5000000   // 100 ms at 50 MHz = 1 decisecond
)(
    input  logic clk,
    input  logic rst_n,
    output logic enable
);
    logic [31:0] cnt;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt    <= '0;
            enable <= 1'b0;
        end else if (cnt >= COUNTER_MAX - 1) begin
            cnt    <= '0;
            enable <= 1'b1;
        end else begin
            cnt    <= cnt + 1'b1;
            enable <= 1'b0;
        end
    end
endmodule
