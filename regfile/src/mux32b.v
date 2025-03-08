////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1
//  \   \         Application : sch2verilog
//  /   /         Filename : mux32b.vf
// /___/   /\     Timestamp : 03/06/2025 17:51:02
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family virtex2p -w "C:/Documents and Settings/student/register_files/mux32b.sch" mux32b.vf
//Design Name: mux32b
//Device: virtex2p
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module mux32b(A, 
              B, 
              sel, 
              dout);

    input [31:0] A;
    input [31:0] B;
    input sel;
   output [31:0] dout;
   
   
   mux8bit XLXI_1 (.A(A[7:0]), 
                   .B(B[7:0]), 
                   .sel(sel), 
                   .dout(dout[7:0]));
   mux8bit XLXI_2 (.A(A[15:8]), 
                   .B(B[15:8]), 
                   .sel(sel), 
                   .dout(dout[15:8]));
   mux8bit XLXI_3 (.A(A[23:16]), 
                   .B(B[23:16]), 
                   .sel(sel), 
                   .dout(dout[23:16]));
   mux8bit XLXI_4 (.A(A[31:24]), 
                   .B(B[31:24]), 
                   .sel(sel), 
                   .dout(dout[31:24]));
endmodule
