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

module rf16tb;

	// Inputs
	reg clk,reset;
	reg [31:0] wdata;
	reg [3:0] r0addr,r1addr,waddr;
	reg wena;
	
	// Output
	wire [31:0] r0data,r1data;


	// Instantiate the Unit Under Test (UUT)
	rf16 uut (
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
		r0addr = 4'b0000;
		r1addr = 4'b0001;
		waddr = 4'b0100;
		wdata = 32'hABCDABCD;
		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b1;
		reset = 1'b0;
		r0addr = 4'b0000;
		r1addr = 4'b0001;
		waddr = 4'b1100;
		wdata = 32'hFFFFEEEE;

		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b1;
		reset = 1'b0;
		r0addr = 4'b0000;
		r1addr = 4'b0001;
		waddr = 4'b1001;
		wdata = 32'h9999EEEE;
		
		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b1;
		reset = 1'b0;
		r0addr = 4'b0000;
		r1addr = 4'b0001;
		waddr = 4'b0100;
		wdata = 32'hABCDABCD;
		
		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b1;
		reset = 1'b0;
		r0addr = 4'b0000;
		r1addr = 4'b0001;
		waddr = 4'b0101;
		wdata = 32'hABCDABCD;
		
		
		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b0;
		reset = 1'b0;
		r0addr = 4'b0101;
		r1addr = 4'b1001;
		waddr = 4'b0100;
		wdata = 32'hABCDABCD;

		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b0;
		reset = 1'b0;
		r0addr = 4'b0100;
		r1addr = 4'b1100;
		waddr = 4'b0100;
		wdata = 32'hABCDABCD;

		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b1;
		reset = 1'b0;
		r0addr = 4'b0101;
		r1addr = 4'b0000;
		waddr = 4'b1001;
		wdata = 32'h88887777;

		// Wait 100 ns for global reset to finish
		#100;
		wena = 1'b0;
		reset = 1'b0;
		r0addr = 4'b0101;
		r1addr = 4'b1001;
		waddr = 4'b1001;
		wdata = 32'h12341234;



	#11200 $finish;
	end
      
endmodule

