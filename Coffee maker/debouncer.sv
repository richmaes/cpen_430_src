// Two-flop synchronizer + stable-for-N-cycles debouncer.
// sw_out keeps the polarity of sw_in. Skip this file if your course already
// provides a `debouncer` with the same ports.
module debouncer #(
    parameter int DEBOUNCE_LIMIT = 500000   // 10 ms at 50 MHz
)(
    input  logic clk,
    input  logic rst_n,
    input  logic sw_in,
    output logic sw_out
);
    logic sync1, sync2;
    logic [31:0] cnt;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            sync1  <= sw_in;
            sync2  <= sw_in;
            sw_out <= sw_in;
            cnt    <= '0;
        end else begin
            sync1 <= sw_in;
            sync2 <= sync1;
            if (sync2 == sw_out) begin
                cnt <= '0;
            end else if (cnt >= DEBOUNCE_LIMIT - 1) begin
                sw_out <= sync2;
                cnt    <= '0;
            end else begin
                cnt <= cnt + 1'b1;
            end
        end
    end
endmodule
