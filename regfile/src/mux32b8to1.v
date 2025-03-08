////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1
//  \   \         Application : sch2verilog
//  /   /         Filename : mux32b8to1.vf
// /___/   /\     Timestamp : 03/06/2025 17:51:52
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family virtex2p -w "C:/Documents and Settings/student/register_files/mux32b8to1.sch" mux32b8to1.vf
//Design Name: mux32b8to1
//Device: virtex2p
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module mux32b8to1(A, 
                  B, 
                  C, 
                  D, 
                  E, 
                  F, 
                  G, 
                  H, 
                  sel, 
                  dout);

    input [31:0] A;
    input [31:0] B;
    input [31:0] C;
    input [31:0] D;
    input [31:0] E;
    input [31:0] F;
    input [31:0] G;
    input [31:0] H;
    input [2:0] sel;
   output [31:0] dout;
   
   wire [31:0] XLXN_14;
   wire [31:0] XLXN_16;
   wire [31:0] XLXN_18;
   wire [31:0] XLXN_19;
   wire [31:0] XLXN_20;
   wire [31:0] XLXN_21;
   
   mux32b XLXI_1 (.A(A[31:0]), 
                  .B(B[31:0]), 
                  .sel(sel[0]), 
                  .dout(XLXN_18[31:0]));
   mux32b XLXI_2 (.A(C[31:0]), 
                  .B(D[31:0]), 
                  .sel(sel[0]), 
                  .dout(XLXN_19[31:0]));
   mux32b XLXI_3 (.A(E[31:0]), 
                  .B(F[31:0]), 
                  .sel(sel[0]), 
                  .dout(XLXN_20[31:0]));
   mux32b XLXI_4 (.A(G[31:0]), 
                  .B(H[31:0]), 
                  .sel(sel[0]), 
                  .dout(XLXN_21[31:0]));
   mux32b XLXI_5 (.A(XLXN_18[31:0]), 
                  .B(XLXN_19[31:0]), 
                  .sel(sel[1]), 
                  .dout(XLXN_14[31:0]));
   mux32b XLXI_6 (.A(XLXN_20[31:0]), 
                  .B(XLXN_21[31:0]), 
                  .sel(sel[1]), 
                  .dout(XLXN_16[31:0]));
   mux32b XLXI_7 (.A(XLXN_14[31:0]), 
                  .B(XLXN_16[31:0]), 
                  .sel(sel[2]), 
                  .dout(dout[31:0]));
endmodule
