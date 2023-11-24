`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:41:30 11/23/2023 
// Design Name: 
// Module Name:    MAR 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MAR(
    input MAR_in,
    input MAR_mramout,
    input clk,
    input [3:0] data_in,
    output reg [3:0] data_out
    );

reg [7:0] temp;

 always@(posedge clk) begin
if (MAR_in) temp = data_in;
if (MAR_mramout) data_out = temp; //pointer
end
endmodule


module tb_MAR;

  reg clk;
  reg MAR_in, MAR_mramout;
  reg [3:0] data_in;
  wire [3:0] data_out;

  // Instantiate the MAR module
  MAR uut (
    .MAR_in(MAR_in),
    .MAR_mramout(MAR_mramout),
    .clk(clk),
    .data_in(data_in),
    .data_out(data_out)
  );
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test scenario
  initial begin
    // Initialize inputs
    MAR_in = 0;
    MAR_mramout = 0;
    data_in = 4'b0000;
	
    // Apply some test vectors
    #10 data_in = 4'b1010;	
    #10 MAR_in = 1;
	 
	 #10 MAR_in = 0;
	 #10 data_in = 4'b1000;
    #10 MAR_mramout = 1; // Simulate reading from memory

  end

endmodule