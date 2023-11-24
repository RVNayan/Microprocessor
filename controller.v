`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:03:19 11/23/2023 
// Design Name: 
// Module Name:    controller 
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
module controller(
    input clk,
    output reg PC_in,
    output reg PC_out,
    output reg IR_in,
    output reg IR_out,
    output reg data_in,
    output reg data_out,
    output reg MAR_in,
    output reg MAR_mramout,
    output reg dram_in,
    output reg dram_out,
    output reg Y_in,
	 output reg inc_PC,
    output reg en,
    input reset
    );

  reg [3:0] state;
  reg [3:0] nextstate;

  parameter GET = 4'b0001, FETCH = 4'b0010, LOAD = 4'b0100, EXECUTE = 4'b1000;

  always @(posedge clk) begin
    if (reset) begin
      // Reset all control signals to 0
      nextstate = GET;
		end 
	 else
      state = nextstate;
	end
	always @*
		begin
		if (reset == 0)
		begin
      // State machine logic
      case (state)
        GET: begin
          //#100;
          // Set signals for the GET state
          PC_in = 0; PC_out = 1;
          MAR_in = 1; MAR_mramout = 0;
          data_in = 1; data_out = 0;
          dram_in = 0; dram_out = 1;
          IR_in = 0; IR_out = 0;
			 en = 1;
         // MBR_in = 0; // Added MBR_in
          Y_in = 0;
          nextstate = FETCH;
        end

        FETCH: begin
         // #100;
          // Set signals for the FETCH state
          PC_in = 0; PC_out = 0;
          MAR_in = 0; MAR_mramout = 1;
          data_in = 0; data_out = 1;
          dram_in = 1; dram_out = 0;
          IR_in = 1; IR_out = 0;
			 en = 0;
         // MBR_in = 1;
          Y_in = 0;
          nextstate = LOAD;
        end

        LOAD: begin
         // #100;
          // Set signals for the LOAD state
          PC_in = 0; PC_out = 0;
          MAR_in = 0; MAR_mramout = 0;
          data_in = 1; data_out = 0;
          dram_in = 0; dram_out = 1;
          IR_in = 0; IR_out = 1;
         // MBR_in = 0;
          Y_in = 1;
			 en = 1;
         // nextstate = EXECUTE;
        end

       // EXECUTE: begin
          // Your execute state logic here
          // ...
          // Set nextstate accordingly
         // nextstate = GET;
       // end
      endcase
    end
 end
endmodule

module tb_controller;

  reg clk;
  reg reset;
  wire PC_in, PC_out, IR_in, IR_out, data_in, data_out, MAR_in, MAR_mramout, dram_in, dram_out, Y_in, inc_PC, en;
 controller uut (
    .clk(clk),
    .PC_in(PC_in),
    .PC_out(PC_out),
    .IR_in(IR_in),
    .IR_out(IR_out),
    .data_in(data_in),
    .data_out(data_out),
    .MAR_in(MAR_in),
    .MAR_mramout(MAR_mramout),
    .dram_in(dram_in),
    .dram_out(dram_out),
    .Y_in(Y_in),
    .inc_PC(inc_PC),
    .en(en),
    .reset(reset)
  );

  // Clock generation
  initial begin
    clk = 0;
	 reset = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
	#10 reset = 1;
	#50 reset = 0;
	end
  
endmodule

//wea must be initailized - done
//MBR is working properly, try working with the complete one (error in assignment)
//databus added must be tinkered