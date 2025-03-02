/*
pipeline.v
5-stage pipeline for ARMv8-M architecture
Engineer: Alexander Yazdani
*/


module pipeline (
    input wire clk,
    input wire reset,
    input wire pipe_en,

    input wire [31:0] imem_data,
    input wire [8:0] imem_addr,
    input wire imem_we,
    input wire imem_re,

    input wire [63:0] dmem_data,
    input wire [7:0] dmem_addr,
    input wire dmem_we,
    input wire dmem_re,

    input wire reg_re,
    input wire [3:0] reg_addr,

    output [31:0] imem_out,
    output [63:0] dmem_out,
    output [63:0] reg_out,
    output reg N, Z, C, V,
    output [8:0] PC
);


// Stage Registers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

reg [31:0] IF_ID_reg;       // Instruction Fetch/Decode
reg [140:0] ID_EX_reg;      // Instruction Decode/Execute
reg [80:0] EX_MEM_reg;      // Execute/Memory
reg [68:0] MEM_WB_reg;      // Memory/Writeback


// IF Stage ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

reg [8:0] PC_in;
wire branch_sel_ID;
wire [23:0] branch_offset;

always @(posedge clk) begin
    if (reset) PC_in <= 9'd0;
    else if (pipe_en) PC_in <= PC + 9'd1;
end

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
    else if (pipe_en)
        IF_ID_reg <= imem_out;
end


// ID Stage ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

wire [3:0] cond;            // IF/ID[31:28]
wire [1:0] instr_type_ID;   // IF/ID[27:26]
wire I_ID;                  // IF/ID[25]
wire [3:0] opcode_ID;       // IF/ID[24:21]
wire S_ID;                  // IF/ID[20]
wire [3:0] r0addr_ID;       // IF/ID[19:16]
wire [3:0] Rd_ID;           // IF/ID[15:12]
wire [7:0] shift;           // IF/ID[11:4]
wire [11:0] Imm;            // IF/ID[11:0]
wire [3:0] r1addr_ID;       // IF/ID[3:0]

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

// Control Logic
wire data_process_ID;
wire data_transfer_ID;
wire NOP_ID;
wire branch_instr;
assign branch_instr = (instr_type_ID[1]&&~instr_type_ID[0]);
assign branch_sel_ID = branch_instr && cond_pass;
assign data_process_ID = (~instr_type_ID[1]&&~instr_type_ID[0]);
assign data_transfer_ID = (~instr_type_ID[1]&&instr_type_ID[0]);
assign NOP_ID = (instr_type_ID[1]&&instr_type_ID[0]);

wire bubble_ID;
assign bubble_ID = (branch_sel_ID || ~cond_pass || NOP_ID);

// WB/ID Wires
wire wEn_WB;
wire [63:0] wData_WB;
wire [3:0] Rd_WB;

// Register Outputs
wire [63:0] Rn;
wire [63:0] Rm;

// Register File
regfile16 registerfile (
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
wire [63:0] Op1_ID;
wire [63:0] Op2_ID;

assign Op1_ID = Rn;
assign Op2_ID = I_ID ? {52'b0, Imm} : Rm;       // Need to check if Data Transfer


always @(posedge clk) begin
    if (reset) begin
        ID_EX_reg[137:0] <= 138'b0;
        ID_EX_reg[139:138] <= 2'b11;        // Default to NOP
        ID_EX_reg[140] <= 1'b1;
    end else if (pipe_en) begin
        ID_EX_reg[63:0] <= Op1_ID;
        ID_EX_reg[127:64] <= Op2_ID;
        ID_EX_reg[128] <= I_ID;
        ID_EX_reg[129] <= S_ID;
        ID_EX_reg[133:130] <= opcode_ID;
        ID_EX_reg[137:134] <= Rd_ID;
        ID_EX_reg[139:138] <= instr_type_ID;
        ID_EX_reg[140] <= bubble_ID;
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
wire [63:0] Op1_EX;
wire [63:0] Op2_EX;
wire I_EX;
wire S_EX;
wire [3:0] opcode_EX;
wire [3:0] Rd_EX;

wire L_EX;              // Load Flag
assign L_EX = S_EX;

assign Op1_EX = ID_EX_reg[63:0];
assign Op2_EX = ID_EX_reg[127:64];
assign I_EX = ID_EX_reg[128];
assign S_EX = ID_EX_reg[129];
assign opcode_EX = ID_EX_reg[133:130];
assign Rd_EX = ID_EX_reg[137:134];
assign instr_type_EX = ID_EX_reg[139:138];
assign bubble_EX = ID_EX_reg[140];

// ALU Outputs
wire [63:0] alu_result_EX;
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

wire [63:0] EX_out;
assign EX_out = (data_transfer_EX && (~L_EX)) ? Op1_EX : alu_result_EX;

// Update Condition Flags for CMP
always @(posedge clk) begin
    if (reset) begin
        N <= 1'b0;
        C <= 1'b0;
        Z <= 1'b0;
        V <= 1'b0;
    end else if (pipe_en && S_EX) begin
        N <= N_EX;
        C <= C_EX;
        Z <= Z_EX;
        V <= V_EX;
    end
end

always @(posedge clk) begin
    if (reset) begin
        EX_MEM_reg[68:0] <= 69'b0;
        EX_MEM_reg[70:69] <= 2'b11;        // Default to NOP
        EX_MEM_reg[71] <= 1'b1;            // Default to bubble
        EX_MEM_reg[80:72] <= 20'b0;
    end else if (pipe_en) begin
        EX_MEM_reg[63:0] <= EX_out;
        EX_MEM_reg[64] <= I_EX;
        EX_MEM_reg[68:65] <= Rd_EX;
        EX_MEM_reg[70:69] <= instr_type_EX;
        EX_MEM_reg[71] <= bubble_EX;
        EX_MEM_reg[72] <= S_EX;
        EX_MEM_reg[80:73] <= Op2_EX[7:0];
    end
end


// MEM Stage ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Instruction Type
wire [1:0] instr_type_MEM;
assign instr_type_MEM = EX_MEM_reg[70:69];
// wire branch_sel_MEM;
wire data_process_MEM;
wire data_transfer_MEM;
// assign branch_sel_MEM = (instr_type_MEM[1]&&~instr_type_MEM[0]);
assign data_process_MEM = (~instr_type_MEM[1]&&~instr_type_MEM[0]);
assign data_transfer_MEM = (~instr_type_MEM[1]&&instr_type_MEM[0]);
wire S_MEM;
assign S_MEM = EX_MEM_reg[72];

wire [7:0] Op2_MEM;
assign Op2_MEM = EX_MEM_reg[80:73];

// Immediate Flag
wire I_MEM;
assign I_MEM = EX_MEM_reg[64];

// Load Flag
wire L_MEM;
assign L_MEM = S_MEM;

wire [63:0] alu_result_MEM;
assign alu_result_MEM = EX_MEM_reg[63:0];

wire [3:0] Rd_MEM;
assign Rd_MEM = EX_MEM_reg[68:65];

wire bubble_MEM;
assign bubble_MEM = EX_MEM_reg[71];

// Read/Write enable for data memory
wire wEn_MEM;
wire rEn_MEM;
assign wEn_MEM = (~L_MEM && data_transfer_MEM) && (~bubble_MEM) && (~S_MEM);     // Store instruction
assign rEn_MEM = (L_MEM && data_transfer_MEM);                                   // Load instruction

// Write enable for WB register file - Do not write back for STR, CMP, and NOP/bubble
wire WB_en_MEM;
assign WB_en_MEM = (rEn_MEM || (data_process_MEM && ~(S_MEM))) && (~bubble_MEM);

// wire [63:0] dmem_out;
wire [63:0] mem_out;

// Mux for passing ALU data or data memory data
wire mem_sel;
assign mem_sel = (~rEn_MEM);                        // Only pass data memory for a load instruction
assign mem_out = mem_sel ? alu_result_MEM : dmem_out;

wire [63:0] dmem_data_in;
wire [7:0] dmem_waddr_in;
wire [7:0] dmem_raddr_in;
assign dmem_data_in = dmem_we ? dmem_data : alu_result_MEM;
assign dmem_waddr_in = dmem_we ? dmem_addr : Op2_MEM;
assign dmem_raddr_in = dmem_re ? dmem_addr : alu_result_MEM[7:0];

datamem data_mem (
    .clk(clk),
    .raddr(dmem_raddr_in),
    .waddr(dmem_waddr_in),
    .wdata(dmem_data_in),
    .wea((wEn_MEM || dmem_we)),
    .dout(dmem_out)
);

always @(posedge clk) begin
    if (reset)
        MEM_WB_reg <= 69'b0;
    else if (pipe_en) begin
        MEM_WB_reg[63:0] <= mem_out;
        MEM_WB_reg[64] <= WB_en_MEM;
        MEM_WB_reg[68:65] <= Rd_MEM;
    end
end


// WB Stage ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

assign wData_WB = MEM_WB_reg[63:0];
assign wEn_WB = MEM_WB_reg[64];
assign Rd_WB = MEM_WB_reg[68:65];

endmodule