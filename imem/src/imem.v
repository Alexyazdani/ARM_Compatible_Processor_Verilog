////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1
//  \   \         Application : sch2verilog
//  /   /         Filename : imem.vf
// /___/   /\     Timestamp : 02/21/2025 18:17:52
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family virtex2p -w "C:/Documents and Settings/student/imem/imem.sch" imem.vf
//Design Name: imem
//Device: virtex2p
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module imem(addr, 
            clk, 
            din, 
            wea, 
            dout);

    input [8:0] addr;
    input clk;
    input [31:0] din;
    input wea;
   output [31:0] dout;
   
   
   imemory XLXI_1 (.addr(addr[8:0]), 
                   .clk(clk), 
                   .din(din[31:0]), 
                   .we(wea), 
                   .dout(dout[31:0]));
endmodule
