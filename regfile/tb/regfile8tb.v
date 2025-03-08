`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:38:19 01/29/2025
// Design Name:   detect7B
// Module Name:   C:/Documents and Settings/student/verilog_ids/detect7Btb.v
// Project Name:  verilog_ids
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: detect7B
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module regfiletb;

	// Inputs
	reg clk,reset;
	reg [31:0] wdata;
	reg [2:0] r0addr,r1addr,waddr;
	reg wena;
	
	// Output
	wire [31:0] r0data,r1data;


	// Instantiate the Unit Under Test (UUT)
	regfile8 uut (
		.clk(clk), 
		.reset(reset), 
		.r0addr(r0addr), 
		.r1addr(r1addr),
		.wea(wena), 
		.wdata(wdata), 
		.waddr(waddr), 
		.r0data(r0data), 
		.r1data(r1data)
	);

	initial begin
		clk = 1;
			while(1) begin
				#20;
				clk = ~clk;
			end
	end
	
	initial begin
		// Initialize Inputs
		wena = 1'b0;
		reset = 1'b1;
		r0addr = 3'b000;
		r1addr = 3'b001;
		waddr = 3'b010;
		wdata = 31'hABCDABCD;
		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b1;
		reset = 1'b0;
		r0addr = 3'b000;
		r1addr = 3'b001;
		waddr = 3'b000;
		wdata = 31'hAAAABBBB;

		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b1;
		reset = 1'b0;
		r0addr = 3'b000;
		r1addr = 3'b001;
		waddr = 3'b001;
		wdata = 31'hBBBBCCCC;
		
		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b1;
		reset = 1'b0;
		r0addr = 3'b000;
		r1addr = 3'b001;
		waddr = 3'b010;
		wdata = 31'hCCCCDDDD;
		
		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b1;
		reset = 1'b0;
		r0addr = 3'b010;
		r1addr = 3'b010;
		waddr = 3'b011;
		wdata = 31'hDDDDAAAA;

		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b1;
		reset = 1'b0;
		r0addr = 3'b011;
		r1addr = 3'b001;
		waddr = 3'b100;
		wdata = 31'hEEEEFFFF;
		
		
		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b0;
		reset = 1'b0;
		r0addr = 3'b000;
		r1addr = 3'b100;
		waddr = 3'b011;
		wdata = 31'hFFFFFBBBB;		


		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b0;
		reset = 1'b0;
		r0addr = 3'b011;
		r1addr = 3'b100;
		waddr = 3'b011;
		wdata = 31'hDDDDAAAA;	



	#11200 $finish;
	end
      
endmodule

