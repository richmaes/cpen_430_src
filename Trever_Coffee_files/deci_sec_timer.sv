
// same as one in thunderbird file, but it is for 0.1 second, so use 5 million as the period
module deci_sec_timer #(parameter PERIOD = 5_000_000) (
    input wire CLK,
    input wire RST,
    input wire enable,
    output wire step
);

    integer count;

    assign step = enable && (count == PERIOD - 1);

    always @(posedge CLK or posedge RST) begin
        if (RST)
            count <= 0;
        else if (!enable)
            count <= 0;
        else if (step)
            count <= 0;
        else
            count <= count + 1;
    end

endmodule

