module coffee_top (
    input        CLOCK_50,
    input [17:0] SW,
    input [3:0]  KEY,
    output [8:0] LEDG,
    output [17:0] LEDR,
    output [7:0] LCD_DATA,
    output       LCD_RS, LCD_RW, LCD_EN, LCD_ON, LCD_BLON
);

	 wire RST;                
    wire rst_req;                           
    wire fsm_rst = RST | rst_req | Error;


	 logic req_valid, req_rs, req_ready, init_done, splash_done;
    logic [7:0] req_data;

wire orderConfirm;
reg coffee_type;
reg [0:7] coffee_order;
reg drinkRDY = 0;
reg drinkDone;
reg [3:0] UI_controls;
reg Error;
reg Warning;

reg [8*20-1:0] topLine;
reg [8*20-1:0] bottomLine;

assign RST = SW[0];

always @(posedge CLOCK_50) begin
	//check if drink is ready to be made
	if(RST) 
		drinkRDY <= 1'b0;
	else
		drinkRDY <= SW[1] ? 1'b1 :
						drinkDone ? 1'b0 :
						drinkRDY;

end

//FSM
coffee_fsm u_coffee_fsm(
	.rst(RST),
	.clk(CLOCK_50),
	.errorCode(Error),
	//.order(coffee_order),
	.order(8'b00001100), //temp for 16oz mocha
	//.coffeeType(coffee_type),
	.coffeeType(1), //temp for 16oz mocha
	.RDY(drinkRDY),
	.top(topLine),
	.bottom(bottomLine),
	.done(drinkDone),
	.led_green(LEDG)
);

//LCD
coffee_lcd u_coffee_lcd (
    .rst(RST),
    .clk(CLOCK_50),
    //.top(topLine),
	 .top("   COFFEE BOT   "),
    //.bottom(bottomLine),
	 .bottom("  Hello World!  "),
    .nextPg(UI_controls[0]),
    .backPg(UI_controls[1]),
    .cursorRight(UI_controls[2]),
    .cursorLeft(UI_controls[3]),
    .ready(orderConfirm),
    .LCD_DATA(LCD_DATA), .LCD_RS(LCD_RS), .LCD_RW(LCD_RW),
    .LCD_EN(LCD_EN), .LCD_ON(LCD_ON), .LCD_BLON(LCD_BLON)
);

coffee_io u_coffee_io(
	
	.clk(CLOCK_50),
	.SW(SW),
	.KEY(KEY),
	.LEDR(LEDR),
	.top(topLine),
	.bottom(bottomLine),
	.errorCode(Error),
	.warningCode(Warning),
	.nextPg(UI_controls[0]),
	.backPg(UI_controls[1]),
	.cursorRight(UI_controls[2]),
	.cursorLeft(UI_controls[3]),
	.rst(RST),
	.rst_req(rst_req),
	.confirm(orderConfirm) //Temporary order confirm value
);

endmodule

//FPGA top level	coffee_top.sv
