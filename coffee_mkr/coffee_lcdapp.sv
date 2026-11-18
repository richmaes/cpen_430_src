module coffee_lcdapp (
    input  wire       clk,
    input  wire       rst,
    input  wire       data_rdy,
    output reg        display_clear,
    output wire       display_on,
    output reg  [7:0] data,
    output wire       data_valid,
    output wire [1:0] data_sol
);
    localparam N = 11;                 // message length
    localparam S_CLEAR = 2'd0, S_SEND = 2'd1, S_DONE = 2'd2;

    reg [1:0] state;
    reg [4:0] idx;

    assign display_on = 1'b1;
    assign data_valid = (state == S_SEND);
    assign data_sol   = (data_valid && idx == 0) ? 2'b01 : 2'b00;
    // later: (idx == LINE2_START) ? 2'b10 for a second line

    // message "HELLO WORLD"
    always @(*) begin
        case (idx)
            0:  data = "H";  1: data = "E";  2:  data = "L";
            3:  data = "L";  4: data = "O";  5:  data = " ";
            6:  data = "W";  7: data = "O";  8:  data = "R";
            9:  data = "L";  10: data = "D";
            default: data = " ";
        endcase
    end

    always @(posedge clk) begin
        if (rst) begin
            state <= S_CLEAR;
            idx <= 0;
            display_clear <= 1'b0;
        end else begin
            display_clear <= 1'b0;
            case (state)
                S_CLEAR: begin
                    display_clear <= 1'b1;   // one-cycle pulse
                    state <= S_SEND;
                end
                S_SEND: if (data_rdy) begin  // data_valid is high in this state
                    if (idx == N-1) state <= S_DONE;
                    else            idx <= idx + 1;
                end
                S_DONE: ;                    // stay put until reset
            endcase
        end
    end
endmodule