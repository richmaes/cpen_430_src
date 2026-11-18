// This is intended to model the behavior of the HD44780 for simulation purposes only

/*
 * HD44780 instruction reference (fosc = 270 kHz)
 *
 * Command bits are shown as RS, R/W, DB7...DB0.
 * I/D: address increment/decrement; S: shift display; D: display on;
 * C: cursor on; B: cursor blink; S/C: display/cursor shift select;
 * R/L: shift right/left; DL: 8-/4-bit interface; N: 2-/1-line display;
 * F: 5x10/5x8 font; ACG: CGRAM address; ADD: DDRAM address;
 * BF: busy flag; AC: address counter; x: don't care.
 *
 * Instruction              RS  R/W  DB7 DB6 DB5 DB4 DB3 DB2 DB1 DB0  Time
 * Clear display             0   0    0   0   0   0   0   0   0   1   1.52 ms
 * Return home               0   0    0   0   0   0   0   0   1   x   1.52 ms
 * Entry mode set            0   0    0   0   0   0   0   1  I/D  S   37 us
 * Display on/off control    0   0    0   0   0   0   1   D   C   B   37 us
 * Cursor/display shift      0   0    0   0   0   1  S/C R/L  x   x   37 us
 * Function set              0   0    0   0   1  DL   N   F   x   x   37 us
 * Set CGRAM address         0   0    0   1  ACG ACG ACG ACG ACG ACG  37 us
 * Set DDRAM address         0   0    1 ADD ADD ADD ADD ADD ADD ADD   37 us
 * Read busy flag/address    0   1   BF  AC  AC  AC  AC  AC  AC  AC   0 us
 *
 * Clear display clears the display and sets the DDRAM address to 0.
 * Return home sets the DDRAM address to 0 and restores the original display
 * position if it was shifted; DDRAM contents are unchanged.
 * Entry mode sets cursor direction and optional display shift after reads
 * and writes. Display control sets display, cursor, and blink state.
 * Cursor/display shift moves the cursor or display without changing DDRAM.
 * Function set selects interface width, number of display lines, and font.
 * CGRAM/DDRAM address commands set the corresponding address counter.
 * A busy-flag read returns BF and the address counter; when BF is clear,
 * the controller is ready for its next instruction.
 */

module lcd_ip_model (

input clk,
input rst,
input e,
input rs,
input rw,
inout [7:0] db
);

parameter TERM_CNT = 16'd40000;

logic FUNCTIONING;  // Mimics the interal function bit of the device.
logic [15:0] counter;
logic e_d;
logic e_fe;
logic command_valid;

task automatic decode_command(
  input logic command_valid_in,
  input logic rs_in,
  input logic rw_in,
  input logic [7:0] db_in
);
begin
  if (command_valid_in) begin
    if ($isunknown(db_in)) begin
      $display("%0t LCD transaction has unknown DB bus: RS=%b R/W=%b DB=%b",
               $time, rs_in, rw_in, db_in);
    end else if (rs_in) begin
      if (rw_in)
        $display("%0t LCD data read: DB=%02h", $time, db_in);
      else
        $display("%0t LCD data write: DB=%02h", $time, db_in);
    end else if (rw_in) begin
      $display("%0t LCD read busy flag/address: DB=%02h (execution time 0 us)",
               $time, db_in);
    end else begin
      casez (db_in)
        8'b00000001:
          $display("%0t LCD command: Clear display (execution time 1.52 ms)", $time);
        8'b0000001?:
          $display("%0t LCD command: Return home (execution time 1.52 ms)", $time);
        8'b000001??:
          $display("%0t LCD command: Entry mode set, I/D=%b S=%b (execution time 37 us)",
                   $time, db_in[1], db_in[0]);
        8'b00001???:
          $display("%0t LCD command: Display on/off control, D=%b C=%b B=%b (execution time 37 us)",
                   $time, db_in[2], db_in[1], db_in[0]);
        8'b0001????:
          $display("%0t LCD command: Cursor/display shift, S/C=%b R/L=%b (execution time 37 us)",
                   $time, db_in[3], db_in[2]);
        8'b001?????:
          $display("%0t LCD command: Function set, DL=%b N=%b F=%b (execution time 37 us)",
                   $time, db_in[4], db_in[3], db_in[2]);
        8'b01??????:
          $display("%0t LCD command: Set CGRAM address %02h (execution time 37 us)",
                   $time, db_in[5:0]);
        8'b1???????:
          $display("%0t LCD command: Set DDRAM address %02h (execution time 37 us)",
                   $time, db_in[6:0]);
        default:
          $display("%0t LCD command: Unknown instruction DB=%02h", $time, db_in);
      endcase
    end
  end
end
endtask

assign command_valid = !rst && e_fe && !FUNCTIONING;

assert_cpen430 u_functioning_violation (.clk(clk), .reset(rst), .test_expr(e_fe & FUNCTIONING), .message("Command attempted while device was in FUNCTIONING busy state."))

// A faling edge detector for the E signal
always @ (posedge clk)
begin
  e_d <= e;
end
assign e_fe =  e_d == 1 && e == 0;

// A counter that will reset every time E falls.
always @ (posedge clk)
begin
  if (rst) begin
    counter <= TERM_CNT;
  end else begin
    counter <= e_fe                ? 16'h0000 :
               counter == TERM_CNT ? TERM_CNT : counter + 16'h0001;
  end

  if (command_valid)
    decode_command(command_valid, rs, rw, db);
end
assign FUNCTIONING = counter < TERM_CNT; // if the counter in in progress, assert functioning



endmodule