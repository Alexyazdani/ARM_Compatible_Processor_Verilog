/*
datamem_behavioral.v
Data Memory for 5-stage Pipeline for ARMv8-M Architecture
Engineer: Alexander Yazdani
Spring 2025
*/

module datamem (
    input         clk,
    input  [7:0]  raddr,
    input  [7:0]  waddr,
    input  [63:0] wdata,
    input         wea,
    output [63:0] dout
);
    reg [63:0] mem [255:0];

    assign dout = mem[raddr];

    always @(posedge clk) begin
        if (wea)
            mem[waddr] <= wdata;
    end
endmodule
