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
	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk(clk), 
		.reset(reset), 
		.inst(inst), 
		.Y(Y), 
		.PC(PC), 
		.MAR(MAR), 
		.MBR(MBR),
		.signal(signal)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		#10 inst = 0;
	end
		

	
	
always #10 clk = ~clk;

	initial begin
	inst = 8'b1;
	#15 reset = 1;
   #15 reset = 0;
	#15 inst = 8'b1111_0000;
	end

endmodule

