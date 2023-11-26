`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:19:13 11/23/2023 
// Design Name: 
// Module Name:    CPU 
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
module CPU(
    input clk,
	 input reset,
    input [7:0] inst,
    output [0:0] Y,
    output [3:0] PC,
    output [3:0] MAR,
    output [7:0] MBR,
	 output [7:0] IR,
	 output [7:0] signal, //all the signals
    output [7:0] bus
	 );
 // reg [4:0] counter = 0;
  reg [7:0] databus_in;
  wire [7:0] databus_out;
  wire [3:0] pointer;
  wire en; //initializes the MBR
  wire PC_in;
  wire PC_out;
  wire inc_PC;
  wire MAR_in;
  wire MAR_mramout;
  wire MBR_in; //data_in is MBR_in
  wire MBR_out; 
  wire dram_in; 
  wire dram_out; 
  wire IR_in;
  wire IR_out;
  //wire [7:0] IR;
	
  controller ctlr (.clk(clk), .reset(reset), .PC_in(PC_in), .PC_out(PC_out), .inc_PC(inc_PC),
                  .MAR_in(MAR_in), .MAR_mramout(MAR_mramout),
                  .data_in(MBR_in), .data_out(MBR_out), .dram_in(dram_in), .dram_out(dram_out),
                  .IR_in(IR_in), .IR_out(IR_out), .Y_in(Y), .en(en));

  MBR mbr_inst (.clk(clk), .data_in(databus_in), .data_out(MBR), .dram_in(dram_in), .dram_out(dram_out),
                .MBR_in(MBR_in), .MBR_out(MBR_out), .pointer(pointer), .en(en));

  PC pc_inst (.clk(clk), .PC_in(PC_in), .PC_out(PC_out), .PC_inc(inc_PC), .data_in(databus_in[3:0]),
		.data_out(PC));

  MAR mar_inst (.clk(clk), .MAR_in(MAR_in), .MAR_mramout(MAR_mramout), .data_in(databus_in[3:0]),
		.data_out(MAR));

  IR ir_inst (.clk(clk), .data_in(databus_in), .IR_in(IR_in), .IR_out(IR_out), .data_out(IR));
  

//only change databus_in
reg [7:0] temp;
always @(clk) begin
//counter = counter + 1;
if (PC_out && MAR_in) begin databus_in = {PC,8'b0}; temp = inst; end
if (MBR_out && IR_in) databus_in = temp; //memory data reading
if (IR_out && MBR_in) databus_in = {pointer,8'b1000_0000}; //added 1 to differentiate
//if (MBR_in && PC_out) databus_in = inst; //instruction is loaded after PC gives the mem address
end
assign bus = databus_in;
assign signal = {PC_in,PC_out,MAR_in,MAR_mramout,IR_in,IR_out,MBR_in,MBR_out};
endmodule
//everything is fine except MBR! problem with the timings of the controller