//Block 1, LCD translator	coffee_lcd.sv
module coffee_lcd_driver (

    input  logic       clk,
    input  logic       rst,

    // logic
    input  logic       req_valid,   
    input  logic       req_rs,     
    input  logic [7:0] req_data,
    output logic       req_ready,   
    output logic       init_done,   

    // board
    output logic [7:0] LCD_DATA,
    output logic       LCD_RS,
    output logic       LCD_RW,
    output logic       LCD_EN,
    output logic       LCD_ON,
    output logic       LCD_BLON
);

    
    localparam int CPUS  = 50_000_000 / 1_000_000;   // cycles per microsecond
    localparam int SCALE = 1;

    function automatic int us_to_cyc(input int us);
        int c;
        c = (CPUS * us) / SCALE;
        return (c < 2) ? 2 : c;
    endfunction

    function automatic int ns_to_cyc(input int ns);   
        int c;
        c = (CPUS * ns + 999) / 1000;
        return (c < 1) ? 1 : c;
    endfunction

    localparam int T_PWRUP = us_to_cyc(50_000);  
    localparam int T_5MS   = us_to_cyc(5_000);   
    localparam int T_150US = us_to_cyc(150);     
    localparam int T_50US  = us_to_cyc(50);      
    localparam int T_2MS   = us_to_cyc(2_000);   
    localparam int T_SETUP = ns_to_cyc(100);
    localparam int T_EHIGH = ns_to_cyc(500);
    localparam int T_HOLD  = ns_to_cyc(100);
    
    // Init 
    localparam int N_INIT = 8;

    logic [3:0] idx;
    logic [7:0] init_data;
    int         init_dly;

    always_comb begin
        case (idx)
            4'd0:    begin init_data = 8'h30; init_dly = T_5MS;   end // function set (8-bit)
            4'd1:    begin init_data = 8'h30; init_dly = T_150US; end // function set (8-bit)
            4'd2:    begin init_data = 8'h30; init_dly = T_150US; end // function set (8-bit)
            4'd3:    begin init_data = 8'h38; init_dly = T_50US;  end // 8-bit, 2 lines, 5x8 font
            4'd4:    begin init_data = 8'h08; init_dly = T_50US;  end // display off
            4'd5:    begin init_data = 8'h01; init_dly = T_2MS;   end // display clear
            4'd6:    begin init_data = 8'h06; init_dly = T_50US;  end // entry mode: increment, no shift
            4'd7:    begin init_data = 8'h0C; init_dly = T_50US;  end // display on, cursor off, blink off
            default: begin init_data = 8'h0C; init_dly = T_50US;  end
        endcase
    end

    // Write FSM
    typedef enum logic [2:0] {
        ST_PWRUP,   // wait after power/reset
        ST_LOAD,    // fetch next instruction
        ST_IDLE,    // ready for byte
        ST_SETUP,   // RS/data stable 
        ST_EHIGH,   // E = 1
        ST_HOLD,    // hold RS/data
        ST_WAIT     // instruction execution
    } state_t;

    state_t      state;
    logic [31:0] cnt;
    int          cur_dly;

    assign LCD_RW    = 1'b0;     
    assign LCD_ON    = 1'b1;     
    assign LCD_BLON  = 1'b1;    
    assign req_ready = (state == ST_IDLE);

    always_ff @(posedge clk) begin
        if (rst) begin
            state     <= ST_PWRUP;
            cnt       <= 32'(T_PWRUP - 1);
            idx       <= 4'd0;
            init_done <= 1'b0;
            cur_dly   <= T_50US;
            LCD_EN    <= 1'b0;
            LCD_RS    <= 1'b0;
            LCD_DATA  <= 8'h00;
        end else begin
            case (state)
                ST_PWRUP: begin
                    if (cnt == 0) state <= ST_LOAD;
                    else          cnt   <= cnt - 1;
                end

                ST_LOAD: begin
                    LCD_RS   <= 1'b0;
                    LCD_DATA <= init_data;
                    cur_dly  <= init_dly;
                    cnt      <= 32'(T_SETUP - 1);
                    state    <= ST_SETUP;
                end

                ST_IDLE: begin
                    if (req_valid) begin
                        LCD_RS   <= req_rs;
                        LCD_DATA <= req_data;
                        cur_dly  <= (!req_rs && req_data[7:2] == 6'b0) ? T_2MS : T_50US;
                        cnt      <= 32'(T_SETUP - 1);
                        state    <= ST_SETUP;
                    end
                end

                ST_SETUP: begin
                    if (cnt == 0) begin
                        LCD_EN <= 1'b1;
                        cnt    <= 32'(T_EHIGH - 1);
                        state  <= ST_EHIGH;
                    end else cnt <= cnt - 1;
                end

                ST_EHIGH: begin
                    if (cnt == 0) begin        
                        LCD_EN <= 1'b0;
                        cnt    <= 32'(T_HOLD - 1);
                        state  <= ST_HOLD;
                    end else cnt <= cnt - 1;
                end

                ST_HOLD: begin
                    if (cnt == 0) begin
                        cnt   <= 32'(cur_dly - 1);
                        state <= ST_WAIT;
                    end else cnt <= cnt - 1;
                end

                ST_WAIT: begin
                    if (cnt == 0) begin
                        if (!init_done) begin
                            if (idx == N_INIT - 1) begin
                                init_done <= 1'b1;
                                state     <= ST_IDLE;
                            end else begin
                                idx   <= idx + 4'd1;
                                state <= ST_LOAD;
                            end
                        end else begin
                            state <= ST_IDLE;
                        end
                    end else cnt <= cnt - 1;
                end

                default: state <= ST_PWRUP;
            endcase
        end
    end

endmodule


module coffee_lcd (

    input  logic              clk,
    input  logic              rst,

    // logic 
    input  logic [8*20-1:0]   top,
    input  logic [8*20-1:0]   bottom,
    
    input  logic              nextPg,        // not used yet
    input  logic              backPg,        // not used yet
    input  logic              cursorRight,   // not used yet
    input  logic              cursorLeft,    // not used yet
    input  logic              ready,         // not used yet (order confirm comes from coffee_io) MIGHT NEED CONFORMATION PAGE

    // board 
    output logic [7:0]        LCD_DATA,
    output logic              LCD_RS,
    output logic              LCD_RW,
    output logic              LCD_EN,
    output logic              LCD_ON,
    output logic              LCD_BLON
);


    logic       req_valid, req_rs, req_ready, init_done;
    logic [7:0] req_data;
    logic [5:0] step;               

    always_comb begin
        req_valid = 1'b1;           
        req_rs    = 1'b1;
        req_data  = 8'h20;
        if (step == 0) begin
            req_rs   = 1'b0;
            req_data = 8'h80;                               // DDRAM 0x00 (line 1)
        end else if (step <= 16) begin
            req_data = top[(16 - int'(step)) * 8 +: 8];
        end else if (step == 17) begin
            req_rs   = 1'b0;
            req_data = 8'hC0;                               // DDRAM 0x40 (line 2)
        end else begin
            req_data = bottom[(33 - int'(step)) * 8 +: 8]; 
        end
    end

    always_ff @(posedge clk) begin
        if (rst)                         step <= 6'd0;
        else if (req_valid && req_ready) step <= (step == 6'd33) ? 6'd0 : step + 6'd1;
    end

    coffee_lcd_driver(
        .clk(clk), .rst(rst),
        .req_valid, .req_rs, .req_data, .req_ready, .init_done,
        .LCD_DATA, .LCD_RS, .LCD_RW, .LCD_EN, .LCD_ON, .LCD_BLON
    );

endmodule