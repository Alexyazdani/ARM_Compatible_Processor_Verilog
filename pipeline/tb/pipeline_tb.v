/*
iverilog -o proc32/build/pipeline_tb proc32/tb/pipeline_tb.v proc32/src/pipeline_stall.v proc32/src/imem_behavioral.v proc32/src/datamem_behavioral.v proc32/src/add32b.v proc32/src/alu32b.v proc32/src/cond.v proc32/src/regfile_behavioral.v proc32/src/counter.v

vvp proc32/build/pipeline_tb
*/

`timescale 1ns / 1ps

module pipeline_tb;
    reg clk;
    reg reset;
    reg pipe_en;

    reg [31:0] imem_data;
    reg [8:0] imem_addr;
    reg imem_we;
    reg imem_re;

    reg [31:0] dmem_data;
    reg [7:0] dmem_addr;
    reg dmem_we_external;
    reg dmem_re_external;

    reg [3:0] reg_addr;
    reg reg_re;

    wire [31:0] imem_out;
    wire [31:0] dmem_out;
    wire [31:0] reg_out;
    wire N, Z, C, V;
    // wire [8:0] PC;

    // Instantiate Pipeline
    pipeline dut (
        .clk(clk),
        .reset(reset),
        .pipe_en(pipe_en),
        .imem_data(imem_data),
        .imem_addr(imem_addr),
        .imem_we(imem_we),
        .imem_re(imem_re),
        .dmem_data(dmem_data),
        .dmem_addr(dmem_addr),
        .reg_addr(reg_addr),
        .dmem_we_external(dmem_we_external),
        .dmem_re_external(dmem_re_external),
        .reg_re(reg_re),
        .imem_out(imem_out),
        .dmem_out(dmem_out),
        .reg_out(reg_out),
        .N(N),
        .Z(Z),
        .C(C),
        .V(V)
        // .PC(PC)
    );

    // Clock Generation
    always #5 clk = ~clk;  // 10ns clock period

    task load_imem(input reg [127:0] filename);
        integer file, status;
        reg [31:0] instr;
        reg [8:0] addr;
        begin
            file = $fopen(filename, "r");
            if (file == 0) begin
                $display("ERROR: Could not open %s", filename);
                $finish;
            end
            $display("Loading IMEM from %s...", filename);
            @(negedge clk);
            imem_we = 1;
            addr = 0;  // Start at address 0
            while (!$feof(file)) begin
                status = $fscanf(file, "%b\n", instr);
                imem_addr = addr;
                imem_data = instr;
                @(negedge clk);  // Wait for clock edge before next write
                addr = addr + 1;  // Increment address
            end
            imem_we = 0;
            $fclose(file);
        end
    endtask

    task load_dmem(input reg [127:0] filename);
        integer file, status;
        reg [31:0] data;
        reg [7:0] addr;
        begin
            file = $fopen(filename, "r");
            if (file == 0) begin
                $display("ERROR: Could not open %s", filename);
                $finish;
            end
            $display("Loading DMEM from %s...", filename);
            @(negedge clk);
            dmem_we_external = 1;
            addr = 0;  // Start at address 0
            while (!$feof(file)) begin
                status = $fscanf(file, "%b\n", data);
                dmem_addr = addr;
                dmem_data = data;
                @(negedge clk);  // Wait for clock edge before next write
                addr = addr + 1;  // Increment address
            end
            dmem_we_external = 0;
            $fclose(file);
        end
    endtask

    // ==== TASK: Dump IMEM ====
    task dump_imem();
        integer i;
        begin
            $display("\nDumping IMEM contents...");
            @(negedge clk);
            imem_re = 1;
            for (i = 0; i < 512; i = i + 1) begin
                imem_addr = i;
                @(negedge clk);  // Wait for clock edge before reading
                $display("IMEM[%0d] = %b", i, imem_out);
            end
            imem_re = 0;
        end
    endtask

    // ==== TASK: Dump DMEM ====
    task dump_dmem();
        integer i;
        begin
            $display("\nDumping DMEM contents...");
            @(negedge clk);
            dmem_re_external = 1;
            for (i = 0; i < 256; i = i + 1) begin
                dmem_addr = i;
                @(negedge clk);  // Wait for clock edge before reading
                $display("DMEM[%0d] = %b", i, dmem_out);
            end
            dmem_re_external = 0;
        end
    endtask

    // ==== TASK: Dump Register File ====
    task dump_regfile();
        integer i;
        begin
            $display("\nDumping Register File contents...");
            @(negedge clk);
            reg_re = 1;
            for (i = 0; i < 16; i = i + 1) begin
                reg_addr = i;  // Set register address
                @(negedge clk);  // Wait for clock edge before reading
                $display("REG[%0d] = %h", i, reg_out);
            end
            reg_re = 0;
        end
    endtask

    task dump_cspr();
        begin
            $display("\nDumping CSPR contents...");
            $display("N=%b \nZ=%b \nC=%b \nV=%b\n", N, Z, C, V);
        end
    endtask

    // ==== TEST SEQUENCE ====
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        pipe_en = 0;  // Disable pipeline execution

        imem_we = 0;
        imem_re = 0;
        imem_addr = 0;
        imem_data = 0;

        dmem_we_external = 0;
        dmem_re_external = 0;
        dmem_addr = 0;
        dmem_data = 0;

        reg_re = 0;
        reg_addr = 0;

        #10 reset = 0;  // Deassert reset
        #5;

        // Load memory contents from files
        load_imem("instr.txt");
        // load_imem("instrnops.txt");
        // load_imem("debug1.bin");
        load_dmem("data.txt");
        // load_imem("debug1.bin");
        @(negedge clk);
        pipe_en = 1;

        // Dump memory contents for verification
        // #100000;
        wait(dut.PC >= 9'd48); //42, 96  (44 for sort)
        pipe_en = 0;
        dump_imem();
        dump_dmem();
        dump_regfile();
        dump_cspr();
        $display("PC = %d", dut.PC);

        // End Simulation
        $finish;
    end

// initial begin
//     $monitor("PC = %d", dut.PC); 
// end

// initial begin
//     $monitor("waddr_in = %d", dut.dmem_waddr_in); 
// end


// initial begin
//     forever begin
//         @(negedge clk);
//         $display("PC = %d", dut.PC); 
//         // #10;
//     end
// end
endmodule
