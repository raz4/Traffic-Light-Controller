`timescale 1ns / 1ps

module TrafficLight_tb;

	// Inputs
	reg Sensor;
	reg Clk;
	reg WalkButton;

	// Outputs
	wire MainGreen;
	wire MainYellow;
	wire MainRed;
	wire SideGreen;
	wire SideYellow;
	wire SideRed;
	wire WalkLight;

	// Instantiate the Unit Under Test (UUT)
	TrafficLight uut (
		.Sensor(Sensor), 
		.Clk(Clk), 
		.WalkButton(WalkButton), 
		.MainGreen(MainGreen), 
		.MainYellow(MainYellow), 
		.MainRed(MainRed), 
		.SideGreen(SideGreen), 
		.SideYellow(SideYellow), 
		.SideRed(SideRed), 
		.WalkLight(WalkLight)
	);

	initial begin
		// Initialize Inputs
		Sensor = 0;
		Clk = 0;
		WalkButton = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		WalkButton = 1;
		#10
		WalkButton = 0;
		Sensor = 1;

	end
	
	
	
	
	always begin
		#1 Clk = ~Clk;
	end
      
endmodule

