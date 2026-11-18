module sync_2ff (
    input  wire clk,
    input  wire async_in,
    output wire sync_out
);
    reg [1:0] ff;
    always @(posedge clk) ff <= {ff[0], async_in};
    assign sync_out = ff[1];
endmodule