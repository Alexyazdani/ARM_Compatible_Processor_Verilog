
module alu (
    input  [31:0] op1,
    input  [31:0] op2,
    input  [3:0]  opcode,
    input  set_cond,
    output reg [31:0] result,
    output cspr_N,
    output cspr_Z,
    output cspr_C,
    output cspr_V
);
    wire [31:0] add_result, sub_result, mov_result, cmp_result;
    wire add_overflow, add_carry, sub_carry, cmp_overflow;

    // CMP uses set_cond = 1, which is the only time these flags are updated
    wire cspr_cond_EQ, cspr_cond_NE, cspr_cond_HI, cspr_cond_LT;

    // Adder inputs
    reg [31:0] add_in;
    reg add_sel;
    
    // ADD Instruction (Rd: = Op1 + Op2)
    add32b add_inst (.A(op1), .B(add_in), .Cin(add_sel), .result(add_result), .Cout(add_carry));
    assign add_overflow = (op1[31] == op2[31]) && (add_result[31] != op1[31]);

	// SUB Instruction (Rd: Op1 - Op2)
    assign sub_carry = add_carry;
    assign sub_result = add_result;
    assign sub_overflow = (op1[31] != op2[31]) && (sub_result[31] != op1[31]);

    // MOV Instruction (Rd: = Op2)
    assign mov_result = op2;
	 
    // CMP Instruction (Set condition codes on Op1 - Op2)
    assign cmp_result = add_result;
    assign cmp_overflow = (op1[31] != op2[31]) && (cmp_result[31] != op1[31]);
	 
    // Equal Condition
    assign cspr_cond_EQ = (cspr_Z == 1);
    
    // Not Equal Condition
    assign cspr_cond_NE = (cspr_Z == 0);

    // Unsigned Higher Condtion
    assign cspr_cond_HI = (cspr_C == 1) && (cspr_Z == 0);

    // Less Than Condition
    assign cspr_cond_LT = (cspr_N != cspr_V);

    always @(*) begin
        case (opcode)
            4'b0100: result = add_result;       // ADD
            4'b1101: result = mov_result;       // MOV
            4'b1010: result = cmp_result;       // CMP
            4'b0010: result = sub_result;       // SUB
            default: result = add_result;       // Default to ADD
        endcase
        case (opcode)
            4'b0010: add_in = ~op2;  // SUB
            4'b1010: add_in = ~op2;  // CMP
            default: add_in = op2;   // Default to Op2
        endcase
        case (opcode)
            4'b0010: add_sel = 1'b1;  // SUB
            4'b1010: add_sel = 1'b1;  // CMP
            default: add_sel = 1'b0;  // Default to ADD
        endcase
    end

    // Set Negative (N) flag based on result, only when Set_cond = 1
    assign cspr_N = set_cond && result[31];
	
    // Set Zero (Z) flag based on result, only when Set_cond = 1
    assign cspr_Z = set_cond && (result==32'b0);
	 
    // Set Carry (C) flag based on result, only when Set_cond = 1
    assign cspr_C = set_cond && add_carry; 
		 
    // Set Overflow (V) flag, only when Set_cond = 1
    assign cspr_V = set_cond && cmp_overflow;


endmodule
