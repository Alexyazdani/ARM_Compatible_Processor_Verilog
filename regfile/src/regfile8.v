////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 10.1
//  \   \         Application : sch2verilog
//  /   /         Filename : regfile8.vf
// /___/   /\     Timestamp : 03/06/2025 18:37:44
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: C:\Xilinx\10.1\ISE\bin\nt\unwrapped\sch2verilog.exe -intstyle ise -family virtex2p -w "C:/Documents and Settings/student/register_files/regfile8.sch" regfile8.vf
//Design Name: regfile8
//Device: virtex2p
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module regfile8(clk, 
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
    input [2:0] r0addr;
    input [2:0] r1addr;
    input [2:0] waddr;
    input [31:0] wdata;
    input wea;
   output [31:0] r0data;
   output [31:0] r1data;
   
   wire XLXN_31;
   wire XLXN_32;
   wire XLXN_34;
   wire XLXN_35;
   wire XLXN_36;
   wire XLXN_37;
   wire XLXN_38;
   wire XLXN_43;
   wire XLXN_44;
   wire XLXN_45;
   wire XLXN_47;
   wire XLXN_48;
   wire XLXN_49;
   wire XLXN_51;
   wire XLXN_52;
   wire XLXN_53;
   wire [31:0] XLXN_61;
   wire [31:0] XLXN_62;
   wire [31:0] XLXN_63;
   wire [31:0] XLXN_64;
   wire [31:0] XLXN_65;
   wire [31:0] XLXN_66;
   wire [31:0] XLXN_67;
   wire [31:0] XLXN_68;
   
   decoder XLXI_1 (.waddr(waddr[2:0]), 
                   .en0(XLXN_31), 
                   .en1(XLXN_32), 
                   .en2(XLXN_45), 
                   .en3(XLXN_34), 
                   .en4(XLXN_35), 
                   .en5(XLXN_36), 
                   .en6(XLXN_37), 
                   .en7(XLXN_38));
   reg32b XLXI_5 (.clk(clk), 
                  .din(wdata[31:0]), 
                  .en(XLXN_43), 
                  .reset(reset), 
                  .dout(XLXN_61[31:0]));
   reg32b XLXI_6 (.clk(clk), 
                  .din(wdata[31:0]), 
                  .en(XLXN_44), 
                  .reset(reset), 
                  .dout(XLXN_62[31:0]));
   reg32b XLXI_7 (.clk(clk), 
                  .din(wdata[31:0]), 
                  .en(XLXN_47), 
                  .reset(reset), 
                  .dout(XLXN_63[31:0]));
   reg32b XLXI_8 (.clk(clk), 
                  .din(wdata[31:0]), 
                  .en(XLXN_48), 
                  .reset(reset), 
                  .dout(XLXN_64[31:0]));
   reg32b XLXI_9 (.clk(clk), 
                  .din(wdata[31:0]), 
                  .en(XLXN_49), 
                  .reset(reset), 
                  .dout(XLXN_65[31:0]));
   reg32b XLXI_10 (.clk(clk), 
                   .din(wdata[31:0]), 
                   .en(XLXN_51), 
                   .reset(reset), 
                   .dout(XLXN_66[31:0]));
   reg32b XLXI_12 (.clk(clk), 
                   .din(wdata[31:0]), 
                   .en(XLXN_52), 
                   .reset(reset), 
                   .dout(XLXN_67[31:0]));
   reg32b XLXI_13 (.clk(clk), 
                   .din(wdata[31:0]), 
                   .en(XLXN_53), 
                   .reset(reset), 
                   .dout(XLXN_68[31:0]));
   AND2 XLXI_14 (.I0(wea), 
                 .I1(XLXN_31), 
                 .O(XLXN_43));
   AND2 XLXI_15 (.I0(wea), 
                 .I1(XLXN_32), 
                 .O(XLXN_44));
   AND2 XLXI_17 (.I0(wea), 
                 .I1(XLXN_34), 
                 .O(XLXN_48));
   AND2 XLXI_18 (.I0(wea), 
                 .I1(XLXN_35), 
                 .O(XLXN_49));
   AND2 XLXI_19 (.I0(wea), 
                 .I1(XLXN_36), 
                 .O(XLXN_51));
   AND2 XLXI_20 (.I0(wea), 
                 .I1(XLXN_37), 
                 .O(XLXN_52));
   AND2 XLXI_21 (.I0(wea), 
                 .I1(XLXN_38), 
                 .O(XLXN_53));
   AND2 XLXI_23 (.I0(wea), 
                 .I1(XLXN_45), 
                 .O(XLXN_47));
   mux32b8to1 XLXI_24 (.A(XLXN_61[31:0]), 
                       .B(XLXN_62[31:0]), 
                       .C(XLXN_63[31:0]), 
                       .D(XLXN_64[31:0]), 
                       .E(XLXN_65[31:0]), 
                       .F(XLXN_66[31:0]), 
                       .G(XLXN_67[31:0]), 
                       .H(XLXN_68[31:0]), 
                       .sel(r0addr[2:0]), 
                       .dout(r0data[31:0]));
   mux32b8to1 XLXI_25 (.A(XLXN_61[31:0]), 
                       .B(XLXN_62[31:0]), 
                       .C(XLXN_63[31:0]), 
                       .D(XLXN_64[31:0]), 
                       .E(XLXN_65[31:0]), 
                       .F(XLXN_66[31:0]), 
                       .G(XLXN_67[31:0]), 
                       .H(XLXN_68[31:0]), 
                       .sel(r1addr[2:0]), 
                       .dout(r1data[31:0]));
endmodule
