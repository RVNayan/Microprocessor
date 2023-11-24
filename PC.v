`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:38:21 11/23/2023 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input clk,
    input PC_in,
    input PC_out,
    input PC_inc,
    input [3:0] data_in,
    output reg [3:0] data_out
    );
	 
reg [3:0] temp = 8'b00000000;

always @(posedge clk) begin
    if (PC_in) temp = data_in;
    if (PC_out) data_out = temp;
end

endmodule
