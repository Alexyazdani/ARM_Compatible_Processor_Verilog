// Placeholder for instruction memory module



module imem (
    input  [8:0]  addr,
    input  [31:0] din,
    input         clk,
    input         wea,
    output reg [31:0] dout
);
    reg [31:0] mem [511:0];

    // assign dout = mem[addr];

    always @(posedge clk) begin
        if (wea)
            mem[addr] <= din;
        dout <= mem[addr];
    end
endmodule




// module imem (
//     input  [8:0]  addr,
//     input  [31:0] din,
//     input         clk,
//     input         wea,
//     output [31:0] dout
// );
//     reg [31:0] mem [511:0];

//     assign dout = mem[addr];

//     always @(posedge clk) begin
//         if (wea)
//             mem[addr] <= din;
//     end
// endmodule


