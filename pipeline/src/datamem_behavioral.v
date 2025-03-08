
// Placeholder for data memory module

module datamem (
    input         clk,
    input  [7:0]  raddr,
    input  [7:0]  waddr,
    input  [31:0] wdata,
    input         wea,
    output reg [31:0] dout
);
    reg [31:0] mem [255:0];

    // assign dout = mem[raddr];

    always @(posedge clk) begin
        if (wea)
            mem[waddr] <= wdata;
        dout <= mem[raddr];
    end
endmodule


// module datamem (
//     input         clk,
//     input  [7:0]  raddr,
//     input  [7:0]  waddr,
//     input  [31:0] wdata,
//     input         wea,
//     output [31:0] dout
// );
//     reg [31:0] mem [255:0];

//     assign dout = mem[raddr];

//     always @(posedge clk) begin
//         if (wea)
//             mem[waddr] <= wdata;
//     end
// endmodule
