/*
pipeline.v
5-stage pipeline for ARMv8-M architecture

Engineer: Alexander Yazdani
Engineer: Szymon Gorski
Engineer: Tim Lu

University of Southern California (USC)
EE533 - Spring 2025
Professor Young Cho
25 February 2025
*/


module pipeline (
    input wire clk,
    input wire reset,
    input wire pipe_en,

    input wire [31:0] imem_data,
    input wire [8:0] imem_addr,
    input wire imem_we,
    input wire imem_re,

    input wire [31:0] dmem_data,
    input wire [7:0] dmem_addr,
    input wire dmem_we_external,
    input wire dmem_re_external,

    input wire reg_re,
    input wire [3:0] reg_addr,
	
	input wire [8:0] ilaaddr,ila2addr,
	input wire ilawea,ila2wea,

    output [31:0] imem_out,
    output [31:0] dmem_out,
    output [31:0] reg_out,
	output [31:0] ila_out,ila2_out,
    output reg N, Z, C, V
);


// Stage Registers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

reg [41:0] IF_ID_reg;       // Instruction Fetch/Decode
reg [85:0] ID_EX_reg;      // Instruction Decode/Execute
reg [61:0] EX_MEM_reg;      // Execute/Memory
reg [36:0] MEM_WB_reg;      // Memory/Writeback


// IF Stage ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// wire stall;
wire [8:0] PC_in;
wire [8:0] PC;
wire branch_sel_ID;
wire [23:0] branch_offset;
wire stall;

counter PC_counter (
    .clk(clk),
    .reset(reset),
    .pipe_en(pipe_en&&(~stall)),
    .in(PC),
    .out(PC_in)
);

assign PC = branch_sel_ID ? branch_offset : PC_in;

wire [8:0] waddr_imem;
assign waddr_imem = (imem_we||imem_re) ? imem_addr : PC;

imem instr_mem (
    .addr(waddr_imem),
    .din(imem_data),
    .clk(clk),
    .wea(imem_we),
    .dout(imem_out)
);

always @(posedge clk) begin
    if (reset)
        IF_ID_reg[31:0] <= 32'hEC000000;  // Reset to NOOP
    else if (pipe_en&&(~stall)) begin
        IF_ID_reg <= imem_out;
        IF_ID_reg[40:32] <= PC;
        IF_ID_reg[41] <= branch_sel_ID;     // Add a bubble if taken branch
    end
end


// ID Stage ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

wire [3:0] cond;            // IF/ID[31:28]
wire [1:0] instr_type_ID;   // IF/ID[27:26]
wire I_ID;                  // IF/ID[25]        // Immediate Flag
wire [3:0] opcode_ID;       // IF/ID[24:21]
wire S_ID;                  // IF/ID[20]        // Set Condition Flag + Load/Store Flag
wire [3:0] r0addr_ID;       // IF/ID[19:16]
wire [3:0] Rd_ID;           // IF/ID[15:12]
wire [7:0] shift;           // IF/ID[11:4]
wire [11:0] Imm;            // IF/ID[11:0]
wire [3:0] r1addr_ID;       // IF/ID[3:0]
wire [8:0] PC_ID;

assign PC_ID = IF_ID_reg[40:32];
assign cond = IF_ID_reg[31:28];
assign instr_type_ID = IF_ID_reg[27:26];
assign I_ID = IF_ID_reg[25];
assign opcode_ID = IF_ID_reg[24:21];
assign branch_offset = IF_ID_reg[23:0];
assign S_ID = IF_ID_reg[20];
assign r0addr_ID = IF_ID_reg[19:16];
assign Rd_ID = IF_ID_reg[15:12];
assign shift = IF_ID_reg[11:4];
assign Imm = IF_ID_reg[11:0];
assign r1addr_ID = IF_ID_reg[3:0];


// Cond Logic
wire cond_pass;
cond cond_engine(
    .cond(cond),
    .N(N),
    .Z(Z),
    .C(C),
    .V(V),
    .pass(cond_pass)
);

wire bubble_ID;

// Control Logic
wire data_process_ID;
wire data_transfer_ID;
wire NOP_ID;
wire branch_instr;
assign branch_instr = (instr_type_ID[1]&&~instr_type_ID[0]);
assign branch_sel_ID = branch_instr && cond_pass && ~bubble_ID;
assign data_process_ID = (~instr_type_ID[1]&&~instr_type_ID[0]);
assign data_transfer_ID = (~instr_type_ID[1]&&instr_type_ID[0]);
assign NOP_ID = (instr_type_ID[1]&&instr_type_ID[0]);

assign bubble_ID =  (~cond_pass || NOP_ID || IF_ID_reg[41]);

// WB/ID Wires
wire wEn_WB;
wire [31:0] wData_WB;
wire [3:0] Rd_WB;

// Register Outputs
wire [31:0] Rn;
wire [31:0] Rm;

// Register File
rf16 registerfile (
    .clk(clk),
    .reset(reset),
    .wea(wEn_WB),
    .wdata(wData_WB),
    .waddr(Rd_WB),
    .r0addr(reg_re ? reg_addr : r0addr_ID),
    .r1addr(r1addr_ID),
    .r0data(Rn),
    .r1data(Rm)
);

assign reg_out = Rn;

// Address calculation

wire [31:0] Op1_ID;
wire [31:0] Op2_ID;

assign Op1_ID = Rn;
assign Op2_ID = I_ID ? {20'b0, Imm} : Rm;       // Need to check if Data Transfer


always @(posedge clk) begin
    if (reset) begin
        ID_EX_reg[73:0] <= 138'b0;
        ID_EX_reg[75:74] <= 2'b11;        // Default to NOP
        ID_EX_reg[76] <= 1'b1;
        ID_EX_reg[85:77] <= 9'b0;
    end else if (pipe_en&&(~stall)) begin
        ID_EX_reg[31:0] <= Op1_ID;
        ID_EX_reg[63:32] <= Op2_ID;
        ID_EX_reg[64] <= I_ID;
        ID_EX_reg[65] <= S_ID;
        ID_EX_reg[69:66] <= opcode_ID;
        ID_EX_reg[73:70] <= Rd_ID;
        ID_EX_reg[75:74] <= instr_type_ID;
        ID_EX_reg[76] <= bubble_ID || branch_sel_ID;    // Inject bubble in EX if branch taken
		ID_EX_reg[85:77] <= PC_ID;
    end
end


// EX Stage ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Instruction Type
wire [1:0] instr_type_EX;
wire data_process_EX;
wire data_transfer_EX;
assign data_process_EX = (~instr_type_EX[1]&&~instr_type_EX[0]);
assign data_transfer_EX = (~instr_type_EX[1]&&instr_type_EX[0]);
wire bubble_EX;

// ALU Inputs
wire [31:0] Op1_EX;
wire [31:0] Op2_EX;
wire I_EX;
wire S_EX;
wire [3:0] opcode_EX;
wire [3:0] Rd_EX;
wire [8:0] PC_EX;

wire L_EX;              // Load Flag
assign L_EX = S_EX;

assign Op1_EX = ID_EX_reg[31:0];
assign Op2_EX = ID_EX_reg[63:32];
assign I_EX = ID_EX_reg[64];
assign S_EX = ID_EX_reg[65];
assign opcode_EX = ID_EX_reg[69:66];
assign Rd_EX = ID_EX_reg[73:70];
assign instr_type_EX = ID_EX_reg[75:74];
assign bubble_EX = ID_EX_reg[76];
assign PC_EX = ID_EX_reg[85:77];

// ALU Outputs
wire [31:0] alu_result_EX;
wire N_EX, C_EX, Z_EX, V_EX;

alu alu_inst (
    .op1(Op1_EX),
    .op2(Op2_EX),
    .opcode(opcode_EX),
    .set_cond(S_EX),
    .result(alu_result_EX),
    .cspr_N(N_EX),
    .cspr_C(C_EX),
    .cspr_Z(Z_EX),
    .cspr_V(V_EX)
);

wire [31:0] EX_out;
assign EX_out = (data_transfer_EX && (~L_EX)) ? Op1_EX : alu_result_EX;     // Bypass the ALU for store instructions

// Update Condition Flags for CMP
always @(posedge clk) begin
    if (reset) begin
        N <= 1'b0;
        C <= 1'b0;
        Z <= 1'b0;
        V <= 1'b0;
    end else if (pipe_en&&(~stall)&& S_EX) begin
        N <= N_EX;
        C <= C_EX;
        Z <= Z_EX;
        V <= V_EX;
    end
end

always @(posedge clk) begin
    if (reset) begin
        EX_MEM_reg[37:0] <= 38'b0;
        EX_MEM_reg[38:37] <= 2'b11;        // Default to NOP
        EX_MEM_reg[39] <= 1'b1;            // Default to bubble
        EX_MEM_reg[57:40] <= 9'b0;
    end else if (pipe_en&&(~stall)) begin
        EX_MEM_reg[31:0] <= EX_out;
        EX_MEM_reg[32] <= I_EX;
        EX_MEM_reg[36:33] <= Rd_EX;
        EX_MEM_reg[38:37] <= instr_type_EX;
        EX_MEM_reg[39] <= bubble_EX;
        EX_MEM_reg[40] <= S_EX;
        EX_MEM_reg[48:41] <= Op2_EX[7:0];
		EX_MEM_reg[57:49] <= PC_EX;
        EX_MEM_reg[61:58] <= opcode_EX;
    end
end


// MEM Stage ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Instruction Type
wire [1:0] instr_type_MEM;
// wire branch_sel_MEM;
wire data_process_MEM;
wire data_transfer_MEM;
// assign branch_sel_MEM = (instr_type_MEM[1]&&~instr_type_MEM[0]);
assign data_process_MEM = (~instr_type_MEM[1]&&~instr_type_MEM[0]);
assign data_transfer_MEM = (~instr_type_MEM[1]&&instr_type_MEM[0]);
wire S_MEM;

wire bubble_MEM;
wire [7:0] Op2_MEM;
wire [3:0] Rd_MEM;
wire I_MEM;
wire [31:0] alu_result_MEM;
wire [8:0] PC_MEM;
wire [3:0] opcode_MEM;

assign alu_result_MEM = EX_MEM_reg[31:0];
assign I_MEM = EX_MEM_reg[32];
assign Rd_MEM = EX_MEM_reg[36:33];
assign instr_type_MEM = EX_MEM_reg[38:37];
assign bubble_MEM = EX_MEM_reg[39];
assign S_MEM = EX_MEM_reg[40];
assign Op2_MEM = EX_MEM_reg[48:41];
assign PC_MEM = EX_MEM_reg[57:49];
assign opcode_MEM = EX_MEM_reg[61:58];

// Load Flag
wire L_MEM;
assign L_MEM = S_MEM;



// Read/Write enable for data memory
wire dmem_we_internal;
wire dmem_re_internal;
assign dmem_we_internal = (data_transfer_MEM) && (~bubble_MEM) && (~S_MEM);     // Store instruction
assign dmem_re_internal = (L_MEM && data_transfer_MEM);                                   // Load instruction

// Write enable for WB register file - Do not write back for STR, CMP, and NOP/bubble
wire WB_en_MEM;
assign WB_en_MEM = (dmem_re_internal || (data_process_MEM && ~(S_MEM))) && (~bubble_MEM);

// wire [31:0] dmem_re_external;
wire [31:0] mem_out;

// Mux for passing ALU data or data memory data
wire mem_sel;
assign mem_sel = (~dmem_re_internal);                        // Only pass data memory for a load instruction
assign mem_out = mem_sel ? alu_result_MEM : dmem_out;
// assign dmem_out = dmem_re_external;
wire [31:0] dmem_data_in;
wire [7:0] dmem_waddr_in;
wire [7:0] dmem_raddr_in;
wire [7:0] dmem_addr_in;
assign dmem_data_in = dmem_we_external ? dmem_data : alu_result_MEM;
assign dmem_waddr_in = dmem_we_external ? dmem_addr : Op2_MEM;
assign dmem_raddr_in = dmem_re_external ? dmem_addr : alu_result_MEM[7:0];


imemory ILA (
		.addr (ilaaddr),
		.clk  (clk),
		.din  ({dmem_raddr_in,dmem_waddr_in,(dmem_we_internal|dmem_we_external),(dmem_re_internal|dmem_re_external),dmem_data_in[6:0],dmem_out[6:0]}),
		.dout(ila_out),
		.we  (ilawea)
		);

imemory ILA2 (
		.addr (ila2addr),
		.clk  (clk),
		.din  ({instr_type_MEM,bubble_MEM,opcode_MEM,L_MEM,Rd_MEM,PC_MEM[8:0],mem_out[10:0]}),
		.dout(ila2_out),
		.we  (ila2wea)
		);

datamem data_mem (
    .clk(clk),
    .raddr(dmem_raddr_in),
    .waddr(dmem_waddr_in),
    .wdata(dmem_data_in),
    .wea((dmem_we_internal || dmem_we_external)),
    .dout(dmem_out)
);

reg latched_stall;
always @(posedge clk) begin
    if (reset) begin
        latched_stall <= 1'b0;
    end else begin
        latched_stall <= stall;
    end
end
assign stall = dmem_re_internal&&(~(latched_stall));

always @(posedge clk) begin
    if (reset)
        MEM_WB_reg <= 37'b0;
    else if (pipe_en&&(~stall)) begin
        MEM_WB_reg[31:0] <= mem_out;
        MEM_WB_reg[32] <= WB_en_MEM;
        MEM_WB_reg[36:33] <= Rd_MEM;
    end
end


// WB Stage ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assign wData_WB = MEM_WB_reg[31:0];
assign wEn_WB = MEM_WB_reg[32];
assign Rd_WB = MEM_WB_reg[36:33];

endmodule