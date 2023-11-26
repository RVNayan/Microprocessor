`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:40:16 11/23/2023
// Design Name:   CPU
// Module Name:   /home/ise/coa/mcp3/cputest1.v
// Project Name:  mcp3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cputest1;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] inst;

	// Outputs
	wire [0:0] Y;
	wire [3:0] PC;
	wire [3:0] MAR;
	wire [7:0] MBR;
	wire [7:0] signal;
	wire [7:0] bus; 
	wire [7:0] IR;
	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk(clk), 
		.reset(reset), 
		.inst(inst), 
		.Y(Y), 
		.PC(PC), 
		.MAR(MAR), 
		.MBR(MBR),
		.signal(signal),
		.bus(bus),.IR(IR)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		inst = 0;
	end
		

	
	
always #25 clk = ~clk;

	initial begin
	inst = 8'b1;
	#50 reset = 1; #150;
   reset = 0; #250;
	reset = 1; #50;
	reset = 0;
	//#10 reset = 1;
	end

endmodule

//inncreasing the clk is not helping!