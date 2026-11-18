module lcd_wr (
    input             clk,
    input             rst,
    input             start,        // one-cycle pulse, only when !busy
    input             rs,
    input      [7:0]  data,
    input      [19:0] delay,        // cycles to wait after E falls
    output reg        busy,
    output reg        LCD_RS,
    output            LCD_RW,
    output reg        LCD_EN,
    output reg [7:0]  LCD_DATA
);
    localparam IDLE = 2'd0, SETUP = 2'd1, EHIGH = 2'd2, WAITD = 2'd3;
    reg [1:0]  st;
    reg [19:0] cnt, dly_r;

    assign LCD_RW = 1'b0;               // write only

    always @(posedge clk) begin
        if (rst) begin
            st <= IDLE; busy <= 1'b0; LCD_EN <= 1'b0;
            LCD_RS <= 1'b0; LCD_DATA <= 8'h00; cnt <= 0; dly_r <= 0;
        end else begin
            case (st)
            IDLE: begin
                LCD_EN <= 1'b0;
                if (start) begin
                    LCD_RS <= rs; LCD_DATA <= data; dly_r <= delay;
                    busy <= 1'b1; cnt <= 0; st <= SETUP;
                end
            end
            SETUP: begin                // RS/data stable ~80 ns before E rises
                if (cnt == 3) begin cnt <= 0; LCD_EN <= 1'b1; st <= EHIGH; end
                else cnt <= cnt + 1'b1;
            end
            EHIGH: begin                // E high ~320 ns (min is 230 ns)
                if (cnt == 15) begin cnt <= 0; LCD_EN <= 1'b0; st <= WAITD; end
                else cnt <= cnt + 1'b1;
            end
            WAITD: begin                // instruction execution time
                if (cnt >= dly_r) begin busy <= 1'b0; st <= IDLE; end
                else cnt <= cnt + 1'b1;
            end
            endcase
        end
    end
endmodule