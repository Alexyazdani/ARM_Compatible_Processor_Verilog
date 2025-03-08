/*
iverilog -o proc32/build/tb_alu proc32/tb/tb_alu.v proc32/src/alu32b.v proc32/src/add32b.v

vvp proc32/build/tb_alu
*/

`timescale 1ns / 1ps

module tb_alu;
    reg [31:0] op1, op2;
    reg [3:0] opcode;
    reg set_cond;
    wire [31:0] result;
    wire cspr_N, cspr_Z, cspr_C, cspr_V;
    
    reg [31:0] expected_result;
    reg expected_N, expected_Z, expected_C, expected_V;
    
    // Instantiate ALU
    alu uut (
        .op1(op1),
        .op2(op2),
        .opcode(opcode),
        .set_cond(set_cond),
        .result(result),
        .cspr_N(cspr_N),
        .cspr_Z(cspr_Z),
        .cspr_C(cspr_C),
        .cspr_V(cspr_V)
    );

    task run_test;
        input [31:0] test_op1, test_op2;
        input [3:0] test_opcode;
        input test_set_cond;
        input [31:0] exp_result;
        input exp_N, exp_Z, exp_C, exp_V;
        
        begin
            op1 = test_op1;
            op2 = test_op2;
            opcode = test_opcode;
            set_cond = test_set_cond;
            expected_result = exp_result;
            expected_N = exp_N;
            expected_Z = exp_Z;
            expected_C = exp_C;
            expected_V = exp_V;
            #10; // Wait for ALU operation

            // Check results
            if ((result === expected_result) &&
                (cspr_N === expected_N) &&
                (cspr_Z === expected_Z) &&
                (cspr_C === expected_C) &&
                (cspr_V === expected_V))
                $display("PASS: Opcode=%b | op1=%h | op2=%h | Result=%h | Expected=%h", opcode, op1, op2, result, expected_result);
            else
                $display("FAIL: Opcode=%b | op1=%h | op2=%h | Result=%h | Expected=%h | Flags (N,Z,C,V)=%b%b%b%b Expected=%b%b%b%b", 
                         opcode, op1, op2, result, expected_result, cspr_N, cspr_Z, cspr_C, cspr_V, expected_N, expected_Z, expected_C, expected_V);
        end
    endtask

    initial begin
        $display("Starting ALU test...");

        // ADD Tests (Opcode: 4'b0100)
        run_test(32'h00000001, 32'h00000001, 4'b0100, 0, 32'h00000002, 0, 0, 0, 0); // 1 + 1 = 2
        run_test(32'h7FFFFFFF, 32'h00000001, 4'b0100, 0, 32'h80000000, 0, 0, 0, 0); // Overflow case
        run_test(32'h80000000, 32'hFFFFFFFF, 4'b0100, 0, 32'h7FFFFFFF, 0, 0, 0, 0); // Min + (-1)
        run_test(32'h12345678, 32'h87654321, 4'b0100, 0, 32'h99999999, 0, 0, 0, 0); // Random addition
        run_test(32'h00000000, 32'h00000000, 4'b0100, 0, 32'h00000000, 0, 0, 0, 0); // Zero case

        // SUB Tests (Opcode: 4'b0010)
        run_test(32'h00000002, 32'h00000001, 4'b0010, 0, 32'h00000001, 0, 0, 0, 0); // 2 - 1 = 1
        run_test(32'h80000000, 32'h00000001, 4'b0010, 0, 32'h7FFFFFFF, 0, 0, 0, 0); // Min - 1
        run_test(32'h7FFFFFFF, 32'hFFFFFFFF, 4'b0010, 0, 32'h80000000, 0, 0, 0, 0); // Max - (-1)
        run_test(32'hFFFFFFFF, 32'h00000001, 4'b0010, 0, 32'hFFFFFFFE, 0, 0, 0, 0); // -1 - 1
        run_test(32'h90ABCDEF, 32'h90ABCDEF, 4'b0010, 0, 32'h00000000, 0, 0, 0, 0); // Same value subtraction

        // MOV Tests (Opcode: 4'b1101)
        run_test(32'h00000000, 32'h00000001, 4'b1101, 0, 32'h00000001, 0, 0, 0, 0); // MOV 1
        run_test(32'hFFFFFFFF, 32'h80000000, 4'b1101, 0, 32'h80000000, 0, 0, 0, 0); // MOV min value
        run_test(32'h7FFFFFFF, 32'h12345678, 4'b1101, 0, 32'h12345678, 0, 0, 0, 0); // MOV random value
        run_test(32'h00000000, 32'h00000000, 4'b1101, 0, 32'h00000000, 0, 0, 0, 0); // MOV zero
        run_test(32'hFFFFFFFF, 32'hFFFFFFFF, 4'b1101, 0, 32'hFFFFFFFF, 0, 0, 0, 0); // MOV -1

        // CMP Tests (Opcode: 4'b1010, set_cond = 1)
        run_test(32'h00000001, 32'h00000001, 4'b1010, 1, 32'h00000000, 0, 1, 1, 0); // Equal
        run_test(32'h00000002, 32'h00000001, 4'b1010, 1, 32'h00000001, 0, 0, 1, 0); // Greater than
        run_test(32'h00000001, 32'h00000002, 4'b1010, 1, 32'hFFFFFFFF, 1, 0, 0, 0); // Less than
        run_test(32'h7FFFFFFF, 32'hFFFFFFFF, 4'b1010, 1, 32'h80000000, 1, 0, 0, 1); // Max vs negative
        run_test(32'hFFFFFFFF, 32'h00000001, 4'b1010, 1, 32'hFFFFFFFE, 1, 0, 1, 0); // Negative vs positive

        $display("ALU test completed.");
        $finish;
    end

endmodule
