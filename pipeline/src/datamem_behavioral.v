
// Placeholder for data memory module

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
