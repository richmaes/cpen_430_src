module mux (
  input  wire a,
  input  wire b,
  input  wire c,
  input  wire d,
  input  wire s0,
  input  wire s1,
  output wire y
);

  // 4-to-1 multiplexer using select lines s1:s0
  assign y = (a & ~s1 & ~s0) |
             (b & ~s1 &  s0) |
             (c &  s1 & ~s0) |
             (d &  s1 &  s0);

endmodule
