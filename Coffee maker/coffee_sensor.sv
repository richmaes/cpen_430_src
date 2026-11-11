// coffee_sensor.sv 
// Sensor interface & status classification


module coffee_sensor
    import coffee_recipes_pkg::*;
(
    input  logic                clk,
    input  logic                rst_n,
    input  logic [9:0]          SW,       // sensor switches
    output logic [11:0]   		  error     // errors, warnings
);

    localparam logic [9:0] SENSOR_CLEAN = {1'b1, 1'b1, 2'b01, 1'b0, 1'b0, 1'b0, 1'b0, 2'b11};

    logic [9:0] sw_s0, sw_s1;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sw_s0 <= SENSOR_CLEAN;
            sw_s1 <= SENSOR_CLEAN;
        end else begin
            sw_s0 <= SW;
            sw_s1 <= sw_s0;
        end
    end

    wire [1:0] paper_level = sw_s1[1:0];
    wire       bin0_ampty  = sw_s1[2];
    wire       bin1_ampty  = sw_s1[3];
    wire       nd_ampty    = sw_s1[4];
    wire       ch_ampty    = sw_s1[5];
    wire [1:0] w_pressure  = sw_s1[7:6];
    wire       w_temp      = sw_s1[8];
    wire       hw_status   = sw_s1[9];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            error <= '0;
        end else begin
            error[ERR_PAPER_EMPTY] <= (paper_level == 2'b01);
            error[ERR_PAPER_NONE]  <= (paper_level == 2'b00);
            error[WRN_PAPER]       <= (paper_level == 2'b10);
            error[WRN_BIN0]        <= bin0_ampty;
            error[WRN_BIN1]        <= bin1_ampty;
            error[WRN_ND]          <= nd_ampty;
            error[WRN_CH]          <= ch_ampty;
            error[ERR_WP_FAULT]    <= (w_pressure == 2'b11);
            error[ERR_WP_HIGH]     <= (w_pressure == 2'b10);
            error[WRN_WP_LOW]      <= (w_pressure == 2'b00);
            error[INF_COLD]        <= ~w_temp;
            error[ERR_STATUS]      <= ~hw_status;
        end
    end
	 
endmodule
