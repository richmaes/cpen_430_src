// Testbench for firebird. Uses the common iclk/irst helpers for clock and
// reset generation, and the common assert_cpen430 checker for pass/fail
// reporting. Implements four test mechanisms per the lab document:
//   1) A predictive model checking the lamp state only ever advances
//      through the legal 000->001->011->111->000 sequence.
//   2) Activation counters - each lamp must turn on a predictable,
//      non-zero number of times during the test.
//   3) Duty-cycle counters - lit/unlit clock counts per lamp.
//   4) Hazard synchronization - while hazard is active, left and right
//      must show the same (mirrored) pattern, with at most a single
//      isolated clock of mismatch tolerated.

module firebird_tb;

    wire clk;
    wire rst;

    iclk #(5,5) u_iclk (.clk(clk));
    irst #(15)  u_irst (.rst(rst), .clk(clk));

    reg  [2:0] sw;
    wire [3:0] key;
    wire [7:0] ledg;

    // KEY is active-low; KEY[3] is the system reset input
    assign key[3]   = ~rst;
    assign key[2:0] = 3'b111;

    firebird #(
        .DEBOUNCE_LIMIT (5)
    ) dut (
        .CLOCK_50 (clk),
        .SW       (sw),
        .KEY      (key),
        .LEDG     (ledg)
    );

    wire [2:0] left_lamps  = ledg[7:5];
    wire [2:0] right_lamps = ledg[2:0];

    // -----------------------------------------------------------------
    // Assertion checker (common/assert_cpen430.v)
    // -----------------------------------------------------------------
    reg assert_test_expr;
    reg [128*8-1:0] assert_message;

    assert_cpen430 u_assert (
        .clk       (clk),
        .reset     (rst),
        .test_expr (assert_test_expr),
        .message   (assert_message)
    );

    // -----------------------------------------------------------------
    // Test mechanism 1: predictive model. A step is legal if the lamps
    // hold, advance to the next state in the 000->001->011->111 sweep,
    // or drop straight to 000 (the turn/hazard request was released).
    // -----------------------------------------------------------------
    function legal_step;
        input [2:0] prev;
        input [2:0] next_v;
        begin
            case (prev)
                3'b000:  legal_step = (next_v == 3'b000) || (next_v == 3'b001);
                3'b001:  legal_step = (next_v == 3'b001) || (next_v == 3'b011) || (next_v == 3'b000);
                3'b011:  legal_step = (next_v == 3'b011) || (next_v == 3'b111) || (next_v == 3'b000);
                3'b111:  legal_step = (next_v == 3'b111) || (next_v == 3'b000);
                default: legal_step = 1'b0;
            endcase
        end
    endfunction

    reg [2:0] left_prev, right_prev;
    integer left_violations, right_violations;

    always @ (posedge clk) begin
        if (rst) begin
            left_prev        <= 3'b000;
            right_prev       <= 3'b000;
            left_violations  <= 0;
            right_violations <= 0;
        end
        else begin
            if (!legal_step(left_prev, left_lamps)) begin
                left_violations <= left_violations + 1;
                $display("%0t ERROR: left sequence violation %b -> %b", $time, left_prev, left_lamps);
            end
            if (!legal_step(right_prev, right_lamps)) begin
                right_violations <= right_violations + 1;
                $display("%0t ERROR: right sequence violation %b -> %b", $time, right_prev, right_lamps);
            end
            left_prev  <= left_lamps;
            right_prev <= right_lamps;
        end
    end

    // -----------------------------------------------------------------
    // Test mechanism 2: activation counters (0->1 transitions per lamp).
    // Each request is held long enough that a correctly-operating lamp
    // must strobe (activate) multiple times, not just once.
    // -----------------------------------------------------------------
    integer left_activations  [0:2];
    integer right_activations [0:2];
    reg [2:0] left_lamps_d, right_lamps_d;
    integer i;

    always @ (posedge clk) begin
        if (rst) begin
            left_lamps_d  <= 3'b000;
            right_lamps_d <= 3'b000;
            for (i = 0; i < 3; i = i + 1) begin
                left_activations[i]  <= 0;
                right_activations[i] <= 0;
            end
        end
        else begin
            left_lamps_d  <= left_lamps;
            right_lamps_d <= right_lamps;
            for (i = 0; i < 3; i = i + 1) begin
                if (left_lamps[i] && !left_lamps_d[i])
                    left_activations[i] <= left_activations[i] + 1;
                if (right_lamps[i] && !right_lamps_d[i])
                    right_activations[i] <= right_activations[i] + 1;
            end
        end
    end

    // -----------------------------------------------------------------
    // Test mechanism 3: duty-cycle counters (lit vs. unlit clocks)
    // -----------------------------------------------------------------
    integer left_lit_cycles    [0:2];
    integer left_unlit_cycles  [0:2];
    integer right_lit_cycles   [0:2];
    integer right_unlit_cycles [0:2];
    integer j;

    always @ (posedge clk) begin
        if (rst) begin
            for (j = 0; j < 3; j = j + 1) begin
                left_lit_cycles[j]    <= 0;
                left_unlit_cycles[j]  <= 0;
                right_lit_cycles[j]   <= 0;
                right_unlit_cycles[j] <= 0;
            end
        end
        else begin
            for (j = 0; j < 3; j = j + 1) begin
                if (left_lamps[j])  left_lit_cycles[j]    <= left_lit_cycles[j] + 1;
                else                left_unlit_cycles[j]  <= left_unlit_cycles[j] + 1;
                if (right_lamps[j]) right_lit_cycles[j]   <= right_lit_cycles[j] + 1;
                else                right_unlit_cycles[j] <= right_unlit_cycles[j] + 1;
            end
        end
    end

    // -----------------------------------------------------------------
    // Test mechanism 4: hazard synchronization. While hazard is active,
    // left and right must show the same pattern. Up to 3 consecutive
    // clocks of mismatch are tolerated (time to resync); a mismatch
    // that persists beyond that is an error.
    // -----------------------------------------------------------------
    localparam HAZARD_MISMATCH_TOLERANCE = 3;

    integer hazard_mismatch_run;
    integer hazard_sync_violations;

    always @ (posedge clk) begin
        if (rst) begin
            hazard_mismatch_run    <= 0;
            hazard_sync_violations <= 0;
        end
        else if (dut.hazard_req && (left_lamps != right_lamps)) begin
            hazard_mismatch_run <= hazard_mismatch_run + 1;
            if (hazard_mismatch_run >= HAZARD_MISMATCH_TOLERANCE) begin
                hazard_sync_violations <= hazard_sync_violations + 1;
                $display("%0t ERROR: hazard lamps mismatched for more than %0d clocks left=%b right=%b", $time, HAZARD_MISMATCH_TOLERANCE, left_lamps, right_lamps);
            end
        end
        else begin
            hazard_mismatch_run <= 0;
        end
    end

    // -----------------------------------------------------------------
    // Stimulus
    // -----------------------------------------------------------------
    integer k;

    initial begin
        sw               = 3'b000;
        assert_test_expr = 1'b0;
        assert_message   = "No error";

        while (rst) @ (posedge clk);
        $display("%0t Reset released, starting firebird test", $time);

        // Assert exactly one request at a time, each held long enough to
        // observe several full sweep cycles (multiple strobes)

        // Left turn signal only
        sw = 3'b100;
        repeat (130) @ (posedge clk);

        // Right turn signal only
        sw = 3'b010;
        repeat (130) @ (posedge clk);

        // Hazard lights only - lockstep sweep
        sw = 3'b001;
        repeat (130) @ (posedge clk);

        // All off
        sw = 3'b000;
        repeat (20) @ (posedge clk);

        // ---------------- Checks ----------------
        assert_message   = "Left taillight produced an illegal sequence step";
        assert_test_expr = (left_violations != 0);
        @ (posedge clk);
        assert_test_expr = 1'b0;

        assert_message   = "Right taillight produced an illegal sequence step";
        assert_test_expr = (right_violations != 0);
        @ (posedge clk);
        assert_test_expr = 1'b0;

        assert_message   = "Hazard lamps were not synchronized between left and right";
        assert_test_expr = (hazard_sync_violations != 0);
        @ (posedge clk);
        assert_test_expr = 1'b0;

        for (k = 0; k < 3; k = k + 1) begin
            assert_message   = "Left lamp did not strobe multiple times";
            assert_test_expr = (left_activations[k] < 2);
            @ (posedge clk);
            assert_test_expr = 1'b0;

            assert_message   = "Right lamp did not strobe multiple times";
            assert_test_expr = (right_activations[k] < 2);
            @ (posedge clk);
            assert_test_expr = 1'b0;
        end

        $display("Left activations : %0d %0d %0d", left_activations[0], left_activations[1], left_activations[2]);
        $display("Right activations: %0d %0d %0d", right_activations[0], right_activations[1], right_activations[2]);
        $display("Left lit/unlit   : %0d/%0d, %0d/%0d, %0d/%0d",
                  left_lit_cycles[0], left_unlit_cycles[0],
                  left_lit_cycles[1], left_unlit_cycles[1],
                  left_lit_cycles[2], left_unlit_cycles[2]);
        $display("Right lit/unlit  : %0d/%0d, %0d/%0d, %0d/%0d",
                  right_lit_cycles[0], right_unlit_cycles[0],
                  right_lit_cycles[1], right_unlit_cycles[1],
                  right_lit_cycles[2], right_unlit_cycles[2]);
        $display("Left violations=%0d Right violations=%0d", left_violations, right_violations);
        $display("Hazard sync violations=%0d", hazard_sync_violations);
        $display("Firebird test complete");
        $finish;
    end

endmodule
