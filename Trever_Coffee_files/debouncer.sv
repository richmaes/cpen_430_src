// switch debouncer
module debouncer (
    input  logic clk,
    input  logic noisy,
    output logic  clean
);

    reg sync1, sync2;
    integer count;

    always @(posedge clk) begin
        begin
            // Synchronize the switch
            sync1 <= noisy;
            sync2 <= sync1;

            // Debounce the switch
            if (sync2 == clean)
                count <= 0;
            else if (count == 6000000 - 1) begin //fix limit thing later
                clean <= sync2;
                count <= 0;
            end
            else
                count <= count + 1;
        end
    end

endmodule
