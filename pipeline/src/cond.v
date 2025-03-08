`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:49:26 02/24/2025 
// Design Name: 
// Module Name:    cond 
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
module cond(
    input [3:0] cond,
    input N,
    input Z,
    input C,
    input V,
    output reg pass
);

wire n_eq_v;
wire n_ne_v;

assign n_ne_v = (N ^ V);
assign n_eq_v = ~n_ne_v;

    always @(*) begin
        case (cond)
            4'b0000:    pass = Z;               // EQ
            4'b0001:    pass = ~Z;              // NE
            4'b0010:    pass = C;               // CS
            4'b0011:    pass = ~C;              // CC
            4'b0100:    pass = N;               // MI
            4'b0101:    pass = ~N;              // PL
            4'b0110:    pass = V;               // VS
            4'b0111:    pass = ~V;              // VC
            4'b1000:    pass = C & ~Z;          // HI
            4'b1001:    pass = ~C | Z;          // LS
            4'b1010:    pass = n_eq_v;          // GE
            4'b1011:    pass = n_ne_v;          // LT
            4'b1100:    pass = ~Z & n_eq_v;     // GT
            4'b1101:    pass = Z | n_ne_v;      // LE
            4'b1110:    pass = 1;               // AL
            4'b1111:    pass = 0;               // NV
            default:    pass = 0;               // NV
        endcase
    end

endmodule
