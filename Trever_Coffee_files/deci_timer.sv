module deci_timer #(parameter integer PERIOD=5000000)(input logic clk, reset, output logic tick);
  // Count clock cycles and produce one tick every 0.1 seconds
  
  logic [31:0] count;
  
  always_ff @(posedge clk) 
    
	 begin
    
	 if(reset) 
		begin 
			count<=0; 
			tick<=0; 
		end
    
	 else if(count==PERIOD-1) begin count<=0; tick<=1; end
    
	 else 
		begin 
			count<=count+1'b1; tick<=0; 
		end
  end
  
endmodule
