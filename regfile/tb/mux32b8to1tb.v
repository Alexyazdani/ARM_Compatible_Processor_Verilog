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

module mux64b8to1tb;

	// Inputs
	reg clk;
	reg [31:0] A,B,C,D,E,F,G,H;
	reg [2:0] sel;
	
	// Output
	wire [31:0] dout;


	// Instantiate the Unit Under Test (UUT)
	mux32b8to1 uut (
		.A(A), 
		.B(B), 
		.C(C), 
		.D(D), 
		.E(E), 
		.F(F), 
		.G(G), 
		.H(H), 
		.sel(sel),
		.dout(dout)
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
		A = 32'hAAAABBBB;
		B = 32'hBBBBCCCC;
		C = 32'hCCCCCCCC;
		D = 32'hDDDDCCCC;
		E = 32'hEEEEBBBB;
		F = 32'hFFFFCCCC;
		G = 32'h2222CCCC;
		H = 32'h1111CCCC;		
		sel = 3'b000;
		// Wait 100 ns for global reset to finish
		#100;
		A = 32'hAAAABBBB;
		B = 32'hBBBBCCCC;
		C = 32'hCCCCCCCC;
		D = 32'hDDDDCCCC;
		E = 32'hEEEEBBBB;
		F = 32'hFFFFCCCC;
		G = 32'h2222CCCC;
		H = 32'h1111CCCC;	
		sel = 3'b001;

		// Wait 100 ns for global reset to finish
		#100;
		A = 32'hAAAABBBB;
		B = 32'hBBBBCCCC;
		C = 32'hCCCCCCCC;
		D = 32'hDDDDCCCC;
		E = 32'hEEEEBBBB;
		F = 32'hFFFFCCCC;
		G = 32'h2222CCCC;
		H = 32'h1111CCCC;	
		sel = 3'b010;
		// Wait 100 ns for global reset to finish
		#100;
		A = 32'hAAAABBBB;
		B = 32'hBBBBCCCC;
		C = 32'hCCCCCCCC;
		D = 32'hDDDDCCCC;
		E = 32'hEEEEBBBB;
		F = 32'hFFFFCCCC;
		G = 32'h2222CCCC;
		H = 32'h1111CCCC;	
		sel = 3'b011;
		
		// Wait 100 ns for global reset to finish
		#100;
		A = 32'hAAAABBBB;
		B = 32'hBBBBCCCC;
		C = 32'hCCCCCCCC;
		D = 32'hDDDDCCCC;
		E = 32'hEEEEBBBB;
		F = 32'hFFFFCCCC;
		G = 32'h2222CCCC;
		H = 32'h1111CCCC;		
		sel = 3'b100;
		
		// Wait 100 ns for global reset to finish
		#100;
		A = 32'hAAAABBBB;
		B = 32'hBBBBCCCC;
		C = 32'hCCCCCCCC;
		D = 32'hDDDDCCCC;
		E = 32'hEEEEBBBB;
		F = 32'hFFFFCCCC;
		G = 32'h2222CCCC;
		H = 32'h1111CCCC;		
		sel = 3'b101;
		
		// Wait 100 ns for global reset to finish
		#100;
		A = 32'hAAAABBBB;
		B = 32'hBBBBCCCC;
		C = 32'hCCCCCCCC;
		D = 32'hDDDDCCCC;
		E = 32'hEEEEBBBB;
		F = 32'hFFFFCCCC;
		G = 32'h2222CCCC;
		H = 32'h1111CCCC;		
		sel = 3'b110;

		// Wait 100 ns for global reset to finish
		#100;
		A = 32'hAAAABBBB;
		B = 32'hBBBBCCCC;
		C = 32'hCCCCCCCC;
		D = 32'hDDDDCCCC;
		E = 32'hEEEEBBBB;
		F = 32'hFFFFCCCC;
		G = 32'h2222CCCC;
		H = 32'h1111CCCC;	
		sel = 3'b111;	

	#11200 $finish;
	end
      
endmodule

