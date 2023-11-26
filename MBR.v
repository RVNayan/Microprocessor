`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:44:37 11/23/2023 
// Design Name: 
// Module Name:    MBR 
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
module MBR(
    input clk,
    input MBR_in,
    input MBR_out,
    input dram_in,
    input dram_out,
    input [7:0] data_in,
    output reg [7:0] data_out,
	 input en,
	 input [3:0] pointer
    );
reg [7:0] temp;   //stores the value inside the memory
wire [7:0] membus; //only gives the output from memory
reg wea;
always @(posedge clk) begin
if (en) begin
    if (dram_out && MBR_in)  temp = data_in;
	 if (dram_in && MBR_out)  data_out = membus;
//    if (MBR_out == 1)  data_out = temp;

if (dram_in == 1 && dram_out == 0)	wea = 0;
else if (dram_in == 0 && dram_out == 1)  wea = 1; 
end
end
  // Correct instantiation of MEMORY module
Memory mem (.clka(clk), .dina(temp), .douta(membus), .addra(pointer) ,.wea(wea));
assign en = wea;
endmodule

module tb_MBR;

  reg clk;
  reg MBR_in, MBR_out, dram_in, dram_out;
  reg en;
  reg [7:0] data_in;
  reg [3:0] pointer;
  wire [7:0] data_out;

  // Instantiate the MBR module
  MBR uut (
    .clk(clk),
    .MBR_in(MBR_in),
    .MBR_out(MBR_out),
    .dram_in(dram_in),
    .dram_out(dram_out),
    .data_in(data_in),
    .data_out(data_out),
    .en(en),
    .pointer(pointer)
  );
  
 initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test scenario
  initial begin
    // Initialize inputs
    MBR_in = 0;
	 en = 0;
    MBR_out = 0;
    dram_in = 0;
    dram_out = 0;
    //en = 0;
	 	 #10;
    end

	initial begin
		en = 0;
	 #100 //write
	 MBR_in = 1; MBR_out = 0;
    dram_in = 0; dram_out = 1;
	 data_in = 8'b10000000;
    pointer = 4'b0000;
	 
	
	#100 //read another
	 MBR_in = 0; MBR_out = 1;
	 dram_in = 1; dram_out = 0;
	 data_in = 8'b00000000;
    pointer = 4'b0001;
	 
	

  end

endmodule