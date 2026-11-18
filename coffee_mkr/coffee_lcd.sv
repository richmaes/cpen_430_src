module coffee_lcd (
    input clk, 
	 input rst,
    input display_clear,      // pulse
    input display_on,         // level
    input [7:0] data,
    input data_valid,
    input [1:0] data_sol,           // [0]=start line 1, [1]=start line 2
    output reg data_rdy,
    output LCD_RS,
	 output LCD_RW,
	 output LCD_EN,
    output [7:0] LCD_DATA
);
    parameter PWR_CYC = 800_000;     // >15 ms at 50 MHz; shrink in simulation
	 // byte writer
    reg        wr_start;
	 reg			wr_rs;
    reg  [7:0] wr_data;
    reg [19:0] wr_delay;
    wire       wr_busy;
	 
    lcd_wr u_wr (.clk(clk), .rst(rst), .start(wr_start), .rs(wr_rs), .data(wr_data),
                 .delay(wr_delay), .busy(wr_busy),
                 .LCD_RS(LCD_RS), .LCD_RW(LCD_RW), .LCD_EN(LCD_EN), .LCD_DATA(LCD_DATA));

    localparam S_PWR=0, S_INIT=1, S_IDLE=2, S_ISSUE=3, S_LAUNCH=4, S_WAITB=5, S_NEXT=6;
    reg [2:0]  state, after;         // 'after' = where to go when the write finishes
    reg [19:0] pwr_cnt;
    reg [3:0]  step;                 // init step
    reg        clr_pend, char_pend, on_applied, line;
    reg  [7:0] char_r;
    reg  [1:0] sol_r;
    reg  [4:0] col;
    reg        did_addr;             // address command for this char already sent

    always @(posedge clk) begin
        if (rst) begin
            state <= S_PWR; pwr_cnt <= 0; step <= 0; data_rdy <= 0;
            wr_start <= 0; clr_pend <= 0; char_pend <= 0;
            on_applied <= 0; col <= 0; line <= 0; did_addr <= 0;
        end else begin
            wr_start <= 0;
            if (display_clear) clr_pend <= 1;       // latch the pulse from any state

            case (state)
            S_PWR: begin                            // >15 ms after power up
                if (pwr_cnt == PWR_CYC) state <= S_INIT;
                else pwr_cnt <= pwr_cnt + 1'b1;
            end

            S_INIT: begin                           // Figure 23 sequence
                wr_rs <= 0;
                case (step)
                  0: begin wr_data <= 8'b0011_0000; wr_delay <= 205_000; end  // >4.1 ms
                  1: begin wr_data <= 8'b0011_0000; wr_delay <= 5_000;   end  // >100 us
                  2: begin wr_data <= 8'b0011_0000; wr_delay <= 2_000;   end
                  3: begin wr_data <= 8'b0011_1000; wr_delay <= 2_000;   end  // 8-bit, 2-line, 5x8
                  4: begin wr_data <= 8'b0000_1000; wr_delay <= 2_000;   end  // display off
                  5: begin wr_data <= 8'b0000_0001; wr_delay <= 80_000;  end  // clear
                  6: begin wr_data <= 8'b0000_0110; wr_delay <= 2_000;   end  // entry mode
                  default: begin wr_data <= 8'b0000_1100; wr_delay <= 2_000; end // display on
                endcase
                after <= (step == 7) ? S_IDLE : S_INIT;
                if (step == 7) on_applied <= 1;
                step  <= step + 1'b1;
                state <= S_ISSUE;
            end

            S_IDLE: begin
                data_rdy <= ~clr_pend & ~char_pend & (display_on == on_applied);
                if (data_rdy && data_valid) begin 
                    char_r <= data; sol_r <= data_sol;
                    char_pend <= 1; did_addr <= 0; data_rdy <= 0;
						  
                end else if (clr_pend) begin
                    wr_rs<=0; wr_data<=8'h01; wr_delay<=80_000;
                    clr_pend<=0; col<=0; line<=0;
                    after<=S_IDLE; state<=S_ISSUE; data_rdy<=0;
						  
                end else if (display_on != on_applied) begin
                    wr_rs<=0; wr_data<= display_on ? 8'h0C : 8'h08; wr_delay<=2_000;
                    on_applied<=display_on; after<=S_IDLE; state<=S_ISSUE; data_rdy<=0;
						  
                end else if (char_pend) begin
                    if (!did_addr && (sol_r[0] || sol_r[1] || col == 16)) begin
                        wr_rs<=0; wr_delay<=2_000; did_addr<=1;
                        if (sol_r[0] || (sol_r[1]==0 && line==1)) begin wr_data<=8'h80; line<=0; end
                        else                                       begin wr_data<=8'hC0; line<=1; end
                        col<=0; after<=S_IDLE; state<=S_ISSUE;
								
                    end else begin
                        wr_rs<=1; wr_data<=char_r; wr_delay<=2_000;
                        col<=col+1'b1; char_pend<=0; after<=S_IDLE; state<=S_ISSUE;
                    end
                end
            end

            S_ISSUE:  if (!wr_busy) begin wr_start<=1; state<=S_LAUNCH; end
            S_LAUNCH: state <= S_WAITB;                         // start is high this cycle
            S_WAITB:  if (!wr_busy) state <= after;
            default:  state <= S_PWR;
            endcase
        end
    end
endmodule