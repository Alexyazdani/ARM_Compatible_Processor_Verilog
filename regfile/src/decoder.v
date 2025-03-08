`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:53:05 02/19/2025 
// Design Name: 
// Module Name:    decoder 
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
module decoder(
input [2:0]waddr,
output en0,
output en1, 
output en2,
output en3,
output en4,
output en5,
output en6,
output en7);
assign en0 = (waddr == 3'b000)?1'b1:1'b0;
assign en1 = (waddr == 3'b001)?1'b1:1'b0;
assign en2 = (waddr == 3'b010)?1'b1:1'b0;
assign en3 = (waddr == 3'b011)?1'b1:1'b0;
assign en4 = (waddr == 3'b100)?1'b1:1'b0;
assign en5 = (waddr == 3'b101)?1'b1:1'b0;
assign en6 = (waddr == 3'b110)?1'b1:1'b0;
assign en7 = (waddr == 3'b111)?1'b1:1'b0;

endmodule
