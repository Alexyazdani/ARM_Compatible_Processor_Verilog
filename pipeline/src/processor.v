///////////////////////////////////////////////////////////////////////////////
// vim:set shiftwidth=3 softtabstop=3 expandtab:
// $Id: module_template 2008-03-13 gac1 $
//
// Module: ids.v
// Project: NF2.1
// Description: Defines a simple ids module for the user data path.  The
// modules reads a 64-bit register that contains a pattern to match and
// counts how many packets match.  The register contents are 7 bytes of
// pattern and one byte of mask.  The mask bits are set to one for each
// byte of the pattern that should be included in the mask -- zero bits
// mean "don't care".
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps

module processor 
   #(
      parameter DATA_WIDTH = 64,
      parameter CTRL_WIDTH = DATA_WIDTH/8,
      parameter UDP_REG_SRC_WIDTH = 2
   )
   (
      input  [DATA_WIDTH-1:0]             in_data,
      input  [CTRL_WIDTH-1:0]             in_ctrl,
      input                               in_wr,
      output                              in_rdy,

      output [DATA_WIDTH-1:0]             out_data,
      output [CTRL_WIDTH-1:0]             out_ctrl,
      output                              out_wr,
      input                               out_rdy,
      
      // --- Register interface
      input                               reg_req_in,
      input                               reg_ack_in,
      input                               reg_rd_wr_L_in,
      input  [`UDP_REG_ADDR_WIDTH-1:0]    reg_addr_in,
      input  [`CPCI_NF2_DATA_WIDTH-1:0]   reg_data_in,
      input  [UDP_REG_SRC_WIDTH-1:0]      reg_src_in,

      output                              reg_req_out,
      output                              reg_ack_out,
      output                              reg_rd_wr_L_out,
      output  [`UDP_REG_ADDR_WIDTH-1:0]   reg_addr_out,
      output  [`CPCI_NF2_DATA_WIDTH-1:0]  reg_data_out,
      output  [UDP_REG_SRC_WIDTH-1:0]     reg_src_out,

      // misc
      input                                reset,
      input                                clk
   );

   // Define the log2 function
   // `LOG2_FUNC

   //------------------------- Signals-------------------------------

   // software registers 
   wire [31:0]                   ila_raddr;
   wire [31:0]                   ila2_raddr;
   wire [31:0]                   imem_data;
   wire [31:0]                   imem_addr;
   wire [31:0]                   dmem_data;
   wire [31:0]                   dmem_addr;
   wire [31:0]                   reg_addr;
   wire [31:0]                   cmd;
   // hardware registers
   reg [31:0]                    imem_out,dmem_out,reg_out,flag,ila_out,ila2_out;
   
      // internal siganls
   wire [31:0] dm_out,rf_out;
   wire [31:0] im_out,fl,ilaout,ila2out;
   reg ilawea,ila2wea;
   reg [8:0] ilaaddr,ila2addr;
   reg [31:0] counter,counter_next;
   reg [1:0] state, next_state;
   


   //------------------------- Modules-------------------------------

	pipeline pipe(
			 .clk(clk),
			 .reset(reset||cmd[0]),
			 .pipe_en(cmd[1]),
			 .imem_data(imem_data),
			 .imem_addr(imem_addr[8:0]),
			 .imem_we(cmd[2]),
			 .imem_re(cmd[3]),
			 .dmem_data({dmem_data}),
			 .dmem_addr(dmem_addr[7:0]),
			 .dmem_we_external(cmd[4]),
			 .dmem_re_external(cmd[5]),
			 .reg_re(cmd[6]),
			 .reg_addr(reg_addr[3:0]),
			 .ilaaddr(ilaaddr),
			 .ila2addr(ila2addr),
			 .ilawea(ilawea),
			 .ila2wea(ila2wea),
			 .imem_out(im_out),
			 .dmem_out(dm_out),
			 .reg_out(rf_out),
			 .ila_out(ilaout),
			 .ila2_out(ila2out),
			 .N(fl[0]),
			 .Z(fl[1]),
			 .C(fl[2]),
			 .V(fl[3])
			 );
			 



   generic_regs #( 
      .UDP_REG_SRC_WIDTH   (UDP_REG_SRC_WIDTH),
      .TAG                 (`PROC_BLOCK_ADDR),          // Tag -- eg. MODULE_TAG
      .REG_ADDR_WIDTH      (`PROC_REG_ADDR_WIDTH),     // Width of block addresses -- eg. MODULE_REG_ADDR_WIDTH
      .NUM_COUNTERS        (0),                 // Number of counters
      .NUM_SOFTWARE_REGS   (8),                 // Number of sw regs
      .NUM_HARDWARE_REGS   (7)                  // Number of hw regs
   ) module_regs (
      .reg_req_in       (reg_req_in),
      .reg_ack_in       (reg_ack_in),
      .reg_rd_wr_L_in   (reg_rd_wr_L_in),
      .reg_addr_in      (reg_addr_in),
      .reg_data_in      (reg_data_in),
      .reg_src_in       (reg_src_in),

      .reg_req_out      (reg_req_out),
      .reg_ack_out      (reg_ack_out),
      .reg_rd_wr_L_out  (reg_rd_wr_L_out),
      .reg_addr_out     (reg_addr_out),
      .reg_data_out     (reg_data_out),
      .reg_src_out      (reg_src_out),

      // --- counters interface
      .counter_updates  (),
      .counter_decrement(),

      // --- SW regs interface
      .software_regs    ({cmd,imem_data,imem_addr,dmem_data,dmem_addr,reg_addr,ila_raddr,ila2_raddr}),

      // --- HW regs interface
      .hardware_regs    ({imem_out,dmem_out,reg_out,flag,ila_out,counter,ila2_out}),

      .clk              (clk),
      .reset            (reset)
    );

   //------------------------- Logic-------------------------------
   
    assign out_data  = in_data;
    assign out_ctrl  = in_ctrl;
    assign out_wr    = in_wr;
    assign in_rdy    = out_rdy;  // Passes back the ready signal
   
    always @(*) begin
    ilawea = 1'b0;
    ila2wea = 1'b0;
    counter_next = counter;
    next_state = state;
    ilaaddr = counter[8:0];
    ila2addr = counter[8:0];
    case (state) 
        2'b00: begin
            ilaaddr = counter[8:0];
            ila2addr = counter[8:0]; 
            if(cmd[1])begin
                counter_next = counter + 1;
                next_state = 2'b01;
                ilawea = 1'b1;
                ila2wea = 1'b1;
            end
            else begin
                counter_next = counter;
                next_state = 2'b00;
                ilawea = 1'b0;
                ila2wea = 1'b0;
            end
        end
        2'b01: begin
            ilawea = 1'b1;
            ila2wea = 1'b1;
            if(counter != 32'd512) begin
                counter_next = counter + 1;
                next_state = 2'b01;
                ilaaddr = counter[8:0];
                ila2addr = counter[8:0]; 
            end
            else begin
                next_state = 2'b10;
                counter_next = counter;
                ilaaddr = counter[8:0];
                ila2addr = counter[8:0]; 
            end
        end
        2'b10: begin 
            ilawea = 1'b0;
            ila2wea = 1'b0;
            counter_next = counter;
            next_state = 2'b10;
            ilaaddr = ila_raddr;
            ila2addr = ila2_raddr;
        end
        2'b11: begin
            ilawea = 1'b0;
            ila2wea = 1'b0;   
            counter_next = counter;
            next_state = 2'b00;
            ilaaddr = ila_raddr;
            ila2addr = ila2_raddr;
        end
    endcase
    end
   
   
   

   
    always @(posedge clk) begin
        if (reset)begin
            imem_out <= 32'd0;
            dmem_out <= 32'd0;
            reg_out <= 32'd0;
            ila_out<=32'd0;
            ila2_out<=32'd0;
            flag <= 32'd0;
            state<= 2'b00;
            counter <= 32'd0;
        end
        if(cmd[0])begin
            imem_out <= 32'd0;
            dmem_out <= 32'd0;
            reg_out <= 32'd0;
            ila_out<=32'd0;
            ila2_out<=32'd0;
            flag <= 32'd0;
            state<= 2'b00;
            counter <= 32'd0;
        end else begin
            imem_out <= im_out;
            dmem_out <= dm_out;
            reg_out <= rf_out;
            flag <= fl;
            state<= next_state;
            counter <= counter_next;
            ila_out<=ilaout;
            ila2_out<=ila2out;
        end
    end

   
   
endmodule 
