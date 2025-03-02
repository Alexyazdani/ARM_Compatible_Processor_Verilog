/*
imem_behavioral.v
Instruction Memory for 5-stage Pipeline for ARMv8-M Architecture
Engineer: Alexander Yazdani
Spring 2025
*/

module imem (
    input  [8:0]  addr,
    input  [31:0] din,
    input         clk,
    input         wea,
    output [31:0] dout
);
    reg [31:0] mem [511:0];

    assign dout = mem[addr];

    always @(posedge clk) begin
        if (wea)
            mem[addr] <= din;
    end
endmodule
