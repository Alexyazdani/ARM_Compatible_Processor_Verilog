////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1
//  \   \         Application : sch2verilog
//  /   /         Filename : rf16.vf
// /___/   /\     Timestamp : 03/06/2025 19:04:05
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family virtex2p -w "C:/Documents and Settings/student/register_files/rf16.sch" rf16.vf
//Design Name: rf16
//Device: virtex2p
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module rf16(clk, 
            reset, 
            r0addr, 
            r1addr, 
            waddr, 
            wdata, 
            wea, 
            r0data, 
            r1data);

    input clk;
    input reset;
    input [3:0] r0addr;
    input [3:0] r1addr;
    input [3:0] waddr;
    input [31:0] wdata;
    input wea;
   output [31:0] r0data;
   output [31:0] r1data;
   
   wire [31:0] XLXN_22;
   wire [31:0] XLXN_23;
   wire [31:0] XLXN_24;
   wire [31:0] XLXN_25;
   wire XLXN_33;
   wire XLXN_35;
   
   regfile8 XLXI_1 (.clk(clk), 
                    .reset(reset), 
                    .r0addr(r0addr[2:0]), 
                    .r1addr(r1addr[2:0]), 
                    .waddr(waddr[2:0]), 
                    .wdata(wdata[31:0]), 
                    .wea(XLXN_35), 
                    .r0data(XLXN_22[31:0]), 
                    .r1data(XLXN_24[31:0]));
   regfile8 XLXI_2 (.clk(clk), 
                    .reset(reset), 
                    .r0addr(r0addr[2:0]), 
                    .r1addr(r1addr[2:0]), 
                    .waddr(waddr[2:0]), 
                    .wdata(wdata[31:0]), 
                    .wea(XLXN_33), 
                    .r0data(XLXN_23[31:0]), 
                    .r1data(XLXN_25[31:0]));
   mux32b XLXI_3 (.A(XLXN_22[31:0]), 
                  .B(XLXN_23[31:0]), 
                  .sel(r0addr[3]), 
                  .dout(r0data[31:0]));
   mux32b XLXI_4 (.A(XLXN_24[31:0]), 
                  .B(XLXN_25[31:0]), 
                  .sel(r1addr[3]), 
                  .dout(r1data[31:0]));
   AND2 XLXI_5 (.I0(waddr[3]), 
                .I1(wea), 
                .O(XLXN_33));
   AND2B1 XLXI_6 (.I0(waddr[3]), 
                  .I1(wea), 
                  .O(XLXN_35));
endmodule
