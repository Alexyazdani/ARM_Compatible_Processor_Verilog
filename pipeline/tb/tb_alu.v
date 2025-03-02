/*
tb_alu.v
Testbed for ALU for 5-stage Pipeline for ARMv8-M Architecture
Engineer: Alexander Yazdani
Spring 2025

iverilog -o pipeline/build/tb_alu pipeline/tb/tb_alu.v pipeline/src/alu64b.v pipeline/src/add64b.v

vvp pipeline/build/tb_alu
*/

`timescale 1ns / 1ps

module tb_alu;
    reg [63:0] op1, op2;
    reg [3:0] opcode;
    reg set_cond;
    wire [63:0] result;
    wire cspr_N, cspr_Z, cspr_C, cspr_V;
    
    reg [63:0] expected_result;
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
        input [63:0] test_op1, test_op2;
        input [3:0] test_opcode;
        input test_set_cond;
        input [63:0] exp_result;
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
        run_test(64'h0000000000000001, 64'h0000000000000001, 4'b0100, 0, 64'h0000000000000002, 0, 0, 0, 0); // 1 + 1 = 2
        run_test(64'h7FFFFFFFFFFFFFFF, 64'h0000000000000001, 4'b0100, 0, 64'h8000000000000000, 0, 0, 0, 0); // Overflow case
        run_test(64'h8000000000000000, 64'hFFFFFFFFFFFFFFFF, 4'b0100, 0, 64'h7FFFFFFFFFFFFFFF, 0, 0, 0, 0); // Min + (-1)
        run_test(64'h0000123456789ABC, 64'h000087654321FFFF, 4'b0100, 0, 64'h00009999999a9abb, 0, 0, 0, 0); // Random addition
        run_test(64'h0000000000000000, 64'h0000000000000000, 4'b0100, 0, 64'h0000000000000000, 0, 0, 0, 0); // Zero case

        // SUB Tests (Opcode: 4'b0010)
        run_test(64'h0000000000000002, 64'h0000000000000001, 4'b0010, 0, 64'h0000000000000001, 0, 0, 0, 0); // 2 - 1 = 1
        run_test(64'h8000000000000000, 64'h0000000000000001, 4'b0010, 0, 64'h7FFFFFFFFFFFFFFF, 0, 0, 0, 0); // Min - 1
        run_test(64'h7FFFFFFFFFFFFFFF, 64'hFFFFFFFFFFFFFFFF, 4'b0010, 0, 64'h8000000000000000, 0, 0, 0, 0); // Max - (-1)
        run_test(64'hFFFFFFFFFFFFFFFF, 64'h0000000000000001, 4'b0010, 0, 64'hFFFFFFFFFFFFFFFE, 0, 0, 0, 0); // -1 - 1
        run_test(64'h1234567890ABCDEF, 64'h1234567890ABCDEF, 4'b0010, 0, 64'h0000000000000000, 0, 0, 0, 0); // Same value subtraction

        // MOV Tests (Opcode: 4'b1101)
        run_test(64'h0000000000000000, 64'h0000000000000001, 4'b1101, 0, 64'h0000000000000001, 0, 0, 0, 0); // MOV 1
        run_test(64'hFFFFFFFFFFFFFFFF, 64'h8000000000000000, 4'b1101, 0, 64'h8000000000000000, 0, 0, 0, 0); // MOV min value
        run_test(64'h7FFFFFFFFFFFFFFF, 64'h1234567890ABCDEF, 4'b1101, 0, 64'h1234567890ABCDEF, 0, 0, 0, 0); // MOV random value
        run_test(64'h0000000000000000, 64'h0000000000000000, 4'b1101, 0, 64'h0000000000000000, 0, 0, 0, 0); // MOV zero
        run_test(64'hFFFFFFFFFFFFFFFF, 64'hFFFFFFFFFFFFFFFF, 4'b1101, 0, 64'hFFFFFFFFFFFFFFFF, 0, 0, 0, 0); // MOV -1

        // CMP Tests (Opcode: 4'b1010, set_cond = 1)
        run_test(64'h0000000000000001, 64'h0000000000000001, 4'b1010, 1, 64'h0000000000000000, 0, 1, 1, 0); // Equal
        run_test(64'h0000000000000002, 64'h0000000000000001, 4'b1010, 1, 64'h0000000000000001, 0, 0, 1, 0); // Greater than
        run_test(64'h0000000000000001, 64'h0000000000000002, 4'b1010, 1, 64'hFFFFFFFFFFFFFFFF, 1, 0, 0, 0); // Less than
        run_test(64'h7FFFFFFFFFFFFFFF, 64'hFFFFFFFFFFFFFFFF, 4'b1010, 1, 64'h8000000000000000, 1, 0, 0, 1); // Max vs negative
        run_test(64'hFFFFFFFFFFFFFFFF, 64'h0000000000000001, 4'b1010, 1, 64'hFFFFFFFFFFFFFFFE, 1, 0, 1, 0); // Negative vs positive

        $display("ALU test completed.");
        $finish;
    end

    // initial begin
    //     $dumpfile("alu_wave.vcd"); // Specify the VCD output file
    //     $dumpvars(0, tb_alu);      // Dump all variables in testbench scope
    // end
endmodule
