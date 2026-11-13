module lcd_ip
(
    input clk,
    input rst,
    input pulse,
    output rs,
    output rw,
    output e,
    inout  [7:0] db,
    output [7:0] debug_out,
    
    // We write commands to the LCD.
    input [2:0] lcd_cmd,
    input [7:0] lcd_char,
    input       lcd_valid,
    output      lcd_ready
);

logic w_cmd;
logic is_done;

typedef enum logic [2:0] {
    IDLE,
    ADDR,
    ADDR_DROP,
    CHK_BUSY,
    CHK_BUSY_DROP,
    ERR_STATE
} state_t;

typedef enum logic [3:0] {
  INIT,
  WAIT_15_MS,
  FS_0, 
  WAIT_5_MS,
  FS_1,
  WAIT_1_MS_0,
  FS_2,
  WAIT_1_MS_1,
  DISPLAY_OFF,
  WAIT_1_MS_2,
  DISPLAY_CLEAR,
  WAIT_1_MS_3,
  ENTRY_MODE_SET,
  LCD_READY,
  ERR_CONDITION
} ltssm_t;

state_t txfer, nxt_txfer;
ltssm_t ltssm, nxt_ltssm;
logic timer_1ms;
logic timer_5ms;
logic timer_15ms;
logic clear;


assign rs = 1'b0;
assign rw = 1'b0;
assign db = 8'hZZ;
assign debug_out = {6'h00,clk, rst};

// Txfer statemachine
always @ (posedge clk)
begin
if (rst)
   txfer <= IDLE;
else 
   txfer <= nxt_txfer;
end

always @ (*)
begin
   case (txfer)
   IDLE: nxt_txfer = (w_cmd) ? ADDR : IDLE;
   ADDR: nxt_txfer = ADDR_DROP;
   ADDR_DROP: nxt_txfer = CHK_BUSY;
   CHK_BUSY : nxt_txfer = CHK_BUSY_DROP;
   CHK_BUSY_DROP : nxt_txfer = is_done ? IDLE : CHK_BUSY;
   default: nxt_txfer = ERR_STATE;
   endcase
end


always @ (posedge clk)
begin
if(rst)
    begin
    ltssm <= INIT;
    clear <= 1'b0;
    end
else
    begin
    ltssm <= nxt_ltssm;
    clear <= nxt_ltssm != ltssm       &&   // This is a kind of edge detector
             (                             // Use entry into the following state to know when to clear, 
             nxt_ltssm == WAIT_15_MS  ||   // We know that it is the entry because we are checking that
             nxt_ltssm == WAIT_5_MS   ||   // ltssm != nxt_ltssm
             nxt_ltssm == WAIT_1_MS_0 ||
             nxt_ltssm == WAIT_1_MS_1 ||
             nxt_ltssm == WAIT_1_MS_2 ||
             nxt_ltssm == WAIT_1_MS_3 );
    end
end

always @ (*)
begin
   case (ltssm)
   INIT: nxt_ltssm = WAIT_15_MS;
   WAIT_15_MS: nxt_ltssm = timer_15ms ? FS_0 : WAIT_15_MS;
   FS_0: nxt_ltssm = WAIT_5_MS;
   WAIT_5_MS: nxt_ltssm = timer_5ms ? FS_1 : WAIT_5_MS;
   FS_1: nxt_ltssm = WAIT_1_MS_0;
   WAIT_1_MS_0: nxt_ltssm = timer_1ms ? FS_2 : WAIT_1_MS_0;
   FS_2: nxt_ltssm = WAIT_1_MS_1;
   WAIT_1_MS_1: nxt_ltssm = timer_1ms ? DISPLAY_OFF : WAIT_1_MS_1;
   DISPLAY_OFF: nxt_ltssm = WAIT_1_MS_2;
   WAIT_1_MS_2: nxt_ltssm = timer_1ms ? DISPLAY_CLEAR : WAIT_1_MS_2;
   DISPLAY_CLEAR: nxt_ltssm = WAIT_1_MS_3;
   WAIT_1_MS_3: nxt_ltssm = timer_1ms ? ENTRY_MODE_SET : WAIT_1_MS_3; 
   ENTRY_MODE_SET: nxt_ltssm = LCD_READY;
   LCD_READY: nxt_ltssm = LCD_READY;
   default: nxt_ltssm = ERR_CONDITION;
   endcase
end

// This is a timer block that can be restarted.  It has multiple timer outs 
// that can be used to drive the statemachine up above.  there is no
// transmission logic yet but I have started to rough it in above.
lcd_timer u_lcd_timer
(
    .clk(clk),
    .rst(rst),
    .clear(clear),
    .timer_1ms(timer_1ms),
    .timer_5ms(timer_5ms),
    .timer_15ms(timer_15ms)
);

endmodule