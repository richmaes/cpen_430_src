`timescale 1ns / 1ps

module mux_tb;

  reg a, b, c, d;
  reg [1:0] sel;

  wire y_dut;
  wire y_golden;

  integer i;
  integer errors;

  mux u_dut (
    .a   (a),
    .b   (b),
    .c   (c),
    .d   (d),
    .sel (sel),
    .y   (y_dut)
  );

  mux_golden u_golden (
    .a  (a),
    .b  (b),
    .c  (c),
    .d  (d),
    .s0 (sel[0]),
    .s1 (sel[1]),
    .y  (y_golden)
  );

  initial begin
    errors = 0;

    // exhaustively drive all combinations of a,b,c,d,sel
    for (i = 0; i < 64; i = i + 1) begin
      {a, b, c, d, sel} = i[5:0];
      #1;
      if (y_dut !== y_golden) begin
        errors = errors + 1;
        $display("MISMATCH: a=%b b=%b c=%b d=%b sel=%b | expected(golden)=%b actual(dut)=%b",
                  a, b, c, d, sel, y_golden, y_dut);
      end
    end

    if (errors == 0)
      $display("PASS: all %0d states matched", 64);
    else
      $display("FAIL: %0d of %0d states mismatched", errors, 64);

    $finish;
  end

endmodule
