module tb_pattern #(
    parameter integer PATTERN_WIDTH = 7,
    parameter [PATTERN_WIDTH-1:0] TARGET_PATTERN = 7'b1101101,
    parameter [39:0] TEST_STREAM = 40'b11011011101101001001101011101101101100,
    parameter integer TEST_CONFIGURED = 1
);

    wire clk;
    wire rst;
    reg data_in;
    wire match_one_out;
    wire match_many_out;

    reg [PATTERN_WIDTH-1:0] history;
    integer history_count;
    integer one_progress;
    integer stream_index;
    integer last_many_end;
    integer one_matches;
    integer many_matches;
    integer overlapping_matches;
    integer i;

    reg expected_one;
    reg expected_many;

    iclk #(5, 5) u_iclk (
        .clk(clk)
    );

    irst #(15) u_irst (
        .rst(rst),
        .clk(clk)
    );

    match_one dut_one (
        .CLK(clk),
        .RST(rst),
        .data_in(data_in),
        .match_out(match_one_out)
    );

    match_many dut_many (
        .CLK(clk),
        .RST(rst),
        .data_in(data_in),
        .match_out(match_many_out)
    );

    task automatic send_and_check(input reg serial_bit);
        begin
            @(negedge clk);
            data_in = serial_bit;

            history = {serial_bit, history[PATTERN_WIDTH-1:1]};
            if (history_count < PATTERN_WIDTH)
                history_count = history_count + 1;

            expected_many = 1'b0;
            if ((history_count == PATTERN_WIDTH) && (history == TARGET_PATTERN)) begin
                expected_many = 1'b1;
                many_matches = many_matches + 1;
                if ((stream_index - PATTERN_WIDTH + 1) <= last_many_end)
                    overlapping_matches = overlapping_matches + 1;
                last_many_end = stream_index;
            end

            expected_one = 1'b0;
            if (serial_bit == TARGET_PATTERN[one_progress]) begin
                if (one_progress == PATTERN_WIDTH-1) begin
                    expected_one = 1'b1;
                    one_matches = one_matches + 1;
                    one_progress = 0;
                end
                else begin
                    one_progress = one_progress + 1;
                end
            end
            else begin
                one_progress = 0;
                if (serial_bit == TARGET_PATTERN[0])
                    one_progress = 1;
            end

            @(posedge clk);
            #1;
            if (match_one_out !== expected_one)
                $fatal(1, "match_one mismatch at stream bit %0d: expected %b got %b",
                    stream_index, expected_one, match_one_out);
            if (match_many_out !== expected_many)
                $fatal(1, "match_many mismatch at stream bit %0d: expected %b got %b",
                    stream_index, expected_many, match_many_out);

            stream_index = stream_index + 1;
        end
    endtask

    initial begin
        data_in = 1'b0;
        history = {PATTERN_WIDTH{1'b0}};
        history_count = 0;
        one_progress = 0;
        stream_index = 0;
        last_many_end = -1;
        one_matches = 0;
        many_matches = 0;
        overlapping_matches = 0;
        expected_one = 1'b0;
        expected_many = 1'b0;

        if (PATTERN_WIDTH != 7)
            $fatal(1, "PATTERN_WIDTH must be 7");
        if (TEST_CONFIGURED != 1)
            $fatal(1, "Set TARGET_PATTERN, TEST_STREAM, and TEST_CONFIGURED=1 before simulation");

        wait (rst === 1'b0);
        @(posedge clk);
        #1;
        if ((match_one_out !== 1'b0) || (match_many_out !== 1'b0))
            $fatal(1, "Both match outputs must be low after reset");

        for (i = 0; i < 40; i = i + 1)
            send_and_check(TEST_STREAM[i]);

        if (many_matches == 0)
            $fatal(1, "TEST_STREAM did not contain TARGET_PATTERN");
        if (overlapping_matches == 0)
            $fatal(1, "TEST_STREAM did not contain overlapping TARGET_PATTERN occurrences");

        $display("PASS: match_one=%0d, match_many=%0d, overlapping=%0d",
            one_matches, many_matches, overlapping_matches);
        $finish;
    end

endmodule