`timescale 1ns / 1ps

module TrafficLight(
    input Sensor,
    input Clk,
    input WalkButton,
    output reg MainGreen,
    output reg MainYellow,
    output reg MainRed,
    output reg SideGreen,
    output reg SideYellow,
    output reg SideRed,
    output reg WalkLight
    );

reg period = 0;
reg WalkButton3;
reg [27:0] divider = 0;
reg [2:0] state = 0;
reg [3:0] seconds = 0;
reg [3:0] maxTime = 12;
reg [3:0] maxTime2 = 6;
always@(posedge Clk) begin

	if (WalkButton == 1) begin
		WalkButton3 = 1;
	end
	if (state == 3'b100) begin
		WalkButton3 = 0;
	end
	if (divider == 100000000) begin   // Changed for debug
		period = 0;
		divider = 0;
	end else if(divider == 50000000) begin
		period = 1;
		divider = divider + 1;
	end else begin
		divider = divider + 1;
	end
end

always@(posedge period) begin



case(state)
   //Main: Green, Side: Red, Walk signal: Off
	3'b000: begin
				 MainGreen = 1;
				 MainYellow = 0;
				 MainRed = 0;
				 SideGreen = 0;
				 SideYellow = 0;
				 SideRed = 1;
				 WalkLight = 0;
				 if(seconds == 6 && Sensor == 1) begin
						maxTime = 9;
				 end 
				 if(seconds == maxTime) begin
					state = 3'b001;
					maxTime = 12;
					seconds = 0;
				 end			 
			 end
   //Main: Yellow, Side: Red, Walk signal:Off
	3'b001: begin
				 MainGreen = 0;
				 MainYellow = 1;
				 MainRed = 0;
				 SideGreen = 0;
				 SideYellow = 0;
				 SideRed = 1;
				 WalkLight = 0;
				if(seconds == 2) begin
					if(WalkButton3 == 1) begin
					state = 3'b100;
					seconds = 0;
					end else begin
					state = 3'b010;
					seconds = 0;
					end
				end
			 end
   //Main: Red, Side: Green, Walk signal: Off
	3'b010: begin
				 MainGreen = 0;
				 MainYellow = 0;
				 MainRed = 1;
				 SideGreen = 1;
				 SideYellow = 0;
				 SideRed = 0;
				 WalkLight = 0;
				if(seconds == 6 && Sensor == 1) begin
				maxTime2 = 9;
				end
				if(seconds == maxTime2) begin
				state = 3'b011;
				seconds = 0;
				maxTime2 = 6;
				end
			 end			 
   //Main: Red, Side: Yellow, Walk signal: Off
	3'b011: begin
				 MainGreen = 0;
				 MainYellow = 0;
				 MainRed = 1;
				 SideGreen = 0;
				 SideYellow = 1;
				 SideRed = 0;
				 WalkLight = 0;
				if(seconds == 2) begin
				state = 3'b000;
				seconds = 0;
				end
			 end	
   //Main: Red, Side: Red, Walk signal: On
	3'b100: begin
				 MainGreen = 0;
				 MainYellow = 0;
				 MainRed = 1;
				 SideGreen = 0;
				 SideYellow = 0;
				 SideRed = 1;
				 WalkLight = 1;
				if(seconds == 3) begin
					state = 3'b010;
					seconds = 0;
				end
			 end
	endcase
seconds = seconds + 1;
end


endmodule
