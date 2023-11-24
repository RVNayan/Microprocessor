`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:55:01 11/23/2023 
// Design Name: 
// Module Name:    IR 
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
module IR(
    input clk,
    input IR_out,
    input IR_in,
    input [7:0] data_in,
    output reg [7:0] data_out
    );

reg [7:0] temp;
reg [3:0] opcode;
reg [3:0] address;

always @(posedge clk) begin
    if (IR_in) temp = data_in;
    if (IR_out) begin
      opcode = temp[7:4];
      address = temp[3:0];
    end
    data_out = {opcode[3:0], 4'b0000} + address;
  end
endmodule
