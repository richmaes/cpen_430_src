//Block 5, coffee logic	coffee_fsm.sv

module coffee_fsm(
	input reg [7:0] order,
	input clk,
	input rst,
	input errorCode,
	input reg coffeeType,
	input reg RDY,
	output reg [8*20-1:0] top,    
	output reg [8*20-1:0] bottom,
	output reg done = 0,
	output reg [8:0]led_green
);

assign done = (spot == 4'b1000);

initial begin
	top = "";
	bottom = "";
	done = 0;
end

reg [18:0] PAPER = 1000;
reg [18:0] GRINDER;
reg [18:0] POUROVER;
reg [18:0] PRESSURE;
reg [18:0] WATER;
reg [18:0] CH;
reg [18:0] ND;
reg [3:0] spot = 0;
reg [18:0] timer;
reg [18:0] counter = 0;
reg [15:0] clk_divider = 0;
reg        clk_1ms_tick = 0; 


always_comb begin
	case(order)//NOTE in ms
		8'b00001001 : begin GRINDER = 3000; POUROVER = 10000; PRESSURE = 0;  WATER = 0;  CH = 0; ND = 0; end
		8'b00010001 : begin GRINDER = 4800; POUROVER = 16000; PRESSURE = 0;  WATER = 0;  CH = 0; ND = 0; end
		8'b00100001 : begin GRINDER = 6000; POUROVER = 20000; PRESSURE = 0;  WATER = 0;  CH = 0; ND = 0; end
		8'b01000001 : begin GRINDER = 600; POUROVER = 0;  PRESSURE = 4000;  WATER = 80000;  CH = 0; ND = 0; end
		8'b10000001 : begin GRINDER = 600; POUROVER = 0;  PRESSURE = 4000;  WATER = 140000; CH = 0; ND = 0; end
		8'b00001010 : begin GRINDER = 600; POUROVER = 0;  PRESSURE = 4000;  WATER = 180000; CH = 0; ND = 0; end
		8'b00010010 : begin GRINDER = 600; POUROVER = 0;  PRESSURE = 4000;  WATER = 0;  CH = 0; ND = 8000; end
		8'b00100010 : begin GRINDER = 600; POUROVER = 0;  PRESSURE = 4000;  WATER = 0;  CH = 0; ND = 14000;end
		8'b01000010 : begin GRINDER = 600; POUROVER = 0;  PRESSURE = 4000;  WATER = 0;  CH = 0; ND = 18000;end
		8'b10000010 : begin GRINDER = 600; POUROVER = 0;  PRESSURE = 4000;  WATER = 0;  CH = 3000; ND = 7000; end
		8'b00001100 : begin GRINDER = 600; POUROVER = 0;  PRESSURE = 4000;  WATER = 0;  CH = 3000; ND = 13000;end
		8'b00010100 : begin GRINDER = 600; POUROVER = 0;  PRESSURE = 4000;  WATER = 0;  CH = 3000; ND = 17000;end
		8'b00100100 : begin GRINDER = 3000; POUROVER = 0;  PRESSURE = 20000; WATER = 0;  CH = 0; ND = 0; end
		8'b01000100 : begin GRINDER = 4800; POUROVER = 0;  PRESSURE = 32000; WATER = 0;  CH = 0; ND = 0; end
		8'b10000100 : begin GRINDER = 6000; POUROVER = 0;  PRESSURE = 40000; WATER = 0;  CH = 0; ND = 0; end
		default     : begin GRINDER = 0;  POUROVER = 0;   PRESSURE = 0;   WATER = 0;   CH = 0;  ND = 0;  end
	endcase
end
 
//this is assuming a 1 ms clock rn
always @(posedge clk) begin
	if (rst || errorCode) begin
		spot    <= 0;
		counter <= 0;
	end else if (RDY && clk_1ms_tick) begin
		if(!done) begin
			if(counter < timer) begin
				counter <= counter + 1;
			end else begin
				spot    <= spot + 1;
				counter <= 0;
			end
		end else begin
			spot    <= 0;
			counter <= 0;
		end
	end
end

always @(*) begin
	if (rst || errorCode) begin
		timer   <= 0;
		top     <= "";
		bottom  <= "";
		led_green <= 9'd0;
	end else begin
		case(spot)
			4'b0000 : begin
				timer 	<= 0;
				top 		<= "";
				bottom 	<= "";
				led_green <= 9'b000000000;
			end
			4'b0001 : begin 
				timer  <= PAPER; 
				top    <= " Setting Paper  "; 
				bottom <= ""; 
				led_green <= 9'b000000001;
			end
			4'b0010 : begin 
				timer  <= GRINDER; 
				top    <= "    Grinding    "; 
				if (coffeeType) begin
					bottom <= "     Type A     ";
				end else begin
					bottom <= "     Type B     ";
				end
				led_green <= 9'b000000010;
			end
			4'b0011 : begin 
				timer  <= POUROVER; 
				top    <= "  Pouring Over  "; 
				bottom <= ""; 
				led_green <= 9'b000000100;
			end
			4'b0100 : begin 
				timer  <= PRESSURE; 
				top    <= "    Applying    "; 
				bottom <= "    Pressure    "; 
				led_green <= 9'b000001000;
			end
			4'b0101 : begin		
				timer  <= WATER; 
				top    <= "     Adding     "; 
				bottom <= "     Water      ";  
				led_green <= 9'b000010000;
			end
			4'b0110 : begin 
				timer  <= CH; 
				top    <= "     Adding     "; 
				bottom <= "   Chocolate    ";
				led_green <= 9'b000100000;
			end
			4'b0111 : begin  
				timer  <= ND; 
				top    <= "     Adding     "; 
				bottom <= " Non-dairy Milk "; 
				led_green <= 9'b001000000;
			end
			4'b1000 : begin  
				timer  <= 0; 
				top    <= "      Done      "; 
				bottom <= ""; 
				led_green <= 9'b000000000;
			end
			default : begin
				timer  <= 0;
				top    <= "";
				bottom <= "";
				led_green <= 9'b000000000;
			end
		endcase
	end
end


always_ff @(posedge clk) begin
    if (rst) begin
        clk_divider  <= 0;
        clk_1ms_tick <= 0;
    end else begin
        if (clk_divider == 50000 - 1) begin
            clk_divider  <= 0;
            clk_1ms_tick <= 1'b1; 
        end else begin
            clk_divider  <= clk_divider + 1'b1;
            clk_1ms_tick <= 1'b0;
        end
    end
end


endmodule


		