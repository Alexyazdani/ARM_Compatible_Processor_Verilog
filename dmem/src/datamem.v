////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1
//  \   \         Application : sch2verilog
//  /   /         Filename : datamem.vf
// /___/   /\     Timestamp : 03/06/2025 19:26:52
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family virtex2p -w "C:/Documents and Settings/student/dmemory/datamem.sch" datamem.vf
//Design Name: datamem
//Device: virtex2p
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module datamem(clk, 
               raddr, 
               waddr, 
               wdata, 
               wea, 
               dout);

    input clk;
    input [7:0] raddr;
    input [7:0] waddr;
    input [31:0] wdata;
    input wea;
   output [31:0] dout;
   
   
   dmem XLXI_1 (.addra(waddr[7:0]), 
                .addrb(raddr[7:0]), 
                .clka(clk), 
                .clkb(clk), 
                .dina(wdata[31:0]), 
                .wea(wea), 
                .doutb(dout[31:0]));
endmodule
