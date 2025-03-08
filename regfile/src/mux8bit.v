////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1
//  \   \         Application : sch2verilog
//  /   /         Filename : mux8bit.vf
// /___/   /\     Timestamp : 02/19/2025 17:26:13
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family virtex2p -w "C:/Documents and Settings/student/register_files/mux8bit.sch" mux8bit.vf
//Design Name: mux8bit
//Device: virtex2p
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module M2_1_MXILINX_mux8bit(D0, 
                            D1, 
                            S0, 
                            O);

    input D0;
    input D1;
    input S0;
   output O;
   
   wire M0;
   wire M1;
   
   AND2B1 I_36_7 (.I0(S0), 
                  .I1(D0), 
                  .O(M0));
   OR2 I_36_8 (.I0(M1), 
               .I1(M0), 
               .O(O));
   AND2 I_36_9 (.I0(D1), 
                .I1(S0), 
                .O(M1));
endmodule
`timescale 1ns / 1ps

module mux8bit(A, 
               B, 
               sel, 
               dout);

    input [7:0] A;
    input [7:0] B;
    input sel;
   output [7:0] dout;
   
   
   M2_1_MXILINX_mux8bit XLXI_1 (.D0(A[0]), 
                                .D1(B[0]), 
                                .S0(sel), 
                                .O(dout[0]));
   // synthesis attribute HU_SET of XLXI_1 is "XLXI_1_0"
   M2_1_MXILINX_mux8bit XLXI_2 (.D0(A[1]), 
                                .D1(B[1]), 
                                .S0(sel), 
                                .O(dout[1]));
   // synthesis attribute HU_SET of XLXI_2 is "XLXI_2_1"
   M2_1_MXILINX_mux8bit XLXI_3 (.D0(A[2]), 
                                .D1(B[2]), 
                                .S0(sel), 
                                .O(dout[2]));
   // synthesis attribute HU_SET of XLXI_3 is "XLXI_3_2"
   M2_1_MXILINX_mux8bit XLXI_4 (.D0(A[3]), 
                                .D1(B[3]), 
                                .S0(sel), 
                                .O(dout[3]));
   // synthesis attribute HU_SET of XLXI_4 is "XLXI_4_3"
   M2_1_MXILINX_mux8bit XLXI_5 (.D0(A[4]), 
                                .D1(B[4]), 
                                .S0(sel), 
                                .O(dout[4]));
   // synthesis attribute HU_SET of XLXI_5 is "XLXI_5_4"
   M2_1_MXILINX_mux8bit XLXI_6 (.D0(A[5]), 
                                .D1(B[5]), 
                                .S0(sel), 
                                .O(dout[5]));
   // synthesis attribute HU_SET of XLXI_6 is "XLXI_6_5"
   M2_1_MXILINX_mux8bit XLXI_7 (.D0(A[6]), 
                                .D1(B[6]), 
                                .S0(sel), 
                                .O(dout[6]));
   // synthesis attribute HU_SET of XLXI_7 is "XLXI_7_6"
   M2_1_MXILINX_mux8bit XLXI_8 (.D0(A[7]), 
                                .D1(B[7]), 
                                .S0(sel), 
                                .O(dout[7]));
   // synthesis attribute HU_SET of XLXI_8 is "XLXI_8_7"
endmodule
