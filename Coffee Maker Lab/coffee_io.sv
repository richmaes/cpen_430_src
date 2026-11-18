
//Blocks 2-4, LED, switch and button translators	coffee_io.sv
// this might not be necessarry unless we need to figure out how to understand our given inputs.

module coffee_io(
	input clk,
	input [17:0] SW,
   input [3:0] KEY,
   output reg [17:0] LEDR = 17'd0,
	output reg [8*20-1:0] top,
	output reg [8*20-1:0] bottom,
	output reg errorCode,
	output reg warningCode,
	output reg nextPg,
	output reg backPg,
	output reg cursorRight,
	output reg cursorLeft,
	input             rst,            
   output reg        rst_req = 0,
	output reg confirm = 0 //Temporary oder confirm value
);

initial begin
	top = "";
	bottom = "";
	errorCode = 0;
	warningCode = 0;
end

reg [3:0] debouncedKey = 4'b0000;
reg debounce = 0;

always @(posedge clk) begin
	if(rst || errorCode) begin
		rst_req <= 0;
		debouncedKey <= 4'b0000;
		debounce <= 0;
		errorCode <= 0;
		warningCode <= 0;
		confirm <= 0;
	end else begin
		case(1'b1) //THESE WILL REPRESENT ERRORS OR WARNING'S WHICH WILL DO DIFFERENT THINGS 
			SW[0] : begin LEDR[0] <= 1; rst_req <= 1; 	end //RST
			SW[1] : begin LEDR[1] <= 1; confirm <= 1;	end //Temporary order confirm value
			SW[2] : begin LEDR[2] <= 1;	end //TBD
			SW[3] : begin LEDR[3] <= 1; 	end //TBD
			SW[4] : begin LEDR[4] <= 1; 	end //TBD
			SW[5] : begin LEDR[5] <= 1; 	end //TBD
			SW[6] : begin LEDR[6] <= 1; 	end //TBD
			SW[7] : begin LEDR[7] <= 1; 	errorCode <= 1;   	top <= "  Status Error  "; 	end //coffee machine hardware status error
			SW[8] : begin LEDR[8] <= 1; 	warningCode <= 1; 	top <= " Water Pressure "; 	bottom <= "  Low Warning   "; 	end //water pressure too low warning
			SW[9] : begin LEDR[9] <= 1;	errorCode <= 1;   	top <= " Water Pressure ";		bottom <= "   High Error   "; 	end //water pressure too high error
			SW[10] : begin LEDR[10] <= 1; 	errorCode <= 1;   top <= " Water Pressure ";		bottom <= "  Error Status  "; 	end //water pressure error condition
			SW[11] : begin LEDR[11] <= 1; 	warningCode <= 1; top <= " Chocolate Low  "; 	bottom <= "    Warning     "; 		end //chocolate almost empty warning
			SW[12] : begin LEDR[12] <= 1;	warningCode <= 1; 	top <= "NonDairy Creamer"; 	bottom <= "  Low Warning   "; 	end //Non Dairy creamer almost empty warning
			SW[13] : begin LEDR[13] <= 1; 	warningCode <= 1; top <= "  Coffee B Low  "; 	bottom <= "    Warning     "; 		end //coffee B almost empty warning
			SW[14] : begin LEDR[14] <= 1; 	warningCode <= 1; top <= "  Coffee A Low  "; 	bottom <= "    Warning     "; 		end //coffee A almost empty warning
			SW[15] : begin LEDR[15] <= 1; 	warningCode <= 1; top <= "   Paper Low    "; 	bottom <= "    Warning     "; 		end //paper almost empty warning
			SW[16] : begin LEDR[16] <= 1; 	errorCode <= 1;   top <= "  Paper Empty   "; 	bottom <= "     Error      "; 		end //paper empty error
			SW[17] : begin LEDR[17] <= 1; 	errorCode <= 1;   top <= "   Paper Not    "; 	bottom <= "   Installed    "; 		end //paper not installed error
			default : begin LEDR <= 0; errorCode <= 0; warningCode <= 0;  end
		endcase
		
		if(debounce) begin
			case(debouncedKey)
				4'b0001 : nextPg <= 1;
				4'b0010 : backPg <= 1;
				4'b0100 : cursorRight <= 1;
				4'b1000 : cursorLeft <= 1;
			endcase
		end
		//Debouncer
		if(debouncedKey == KEY) begin
			debounce <= 1;
		end else begin
			debounce <= 0;
		end
		
		debouncedKey <= KEY;
		
	end
end

endmodule
