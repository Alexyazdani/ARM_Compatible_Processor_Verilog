// Placeholder for instruction memory module



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




// module imem (
//     input  [7:0]  rAddr,   // Read Address
//     output [31:0] rData,   // Read Data
//     input  [7:0]  wAddr,   // Write Address
//     input  [31:0] wData,   // Write Data
//     input         clk,     // Clock for synchronous write
//     input         we       // Write Enable
// );
//     reg [31:0] mem [255:0]; // 256 x 32-bit memory storage

//     // Read operation (asynchronous)
//     assign rData = mem[rAddr];

//     // Write operation (synchronous)
//     always @(posedge clk) begin
//         if (we)
//             mem[wAddr] <= wData;
//     end

// endmodule
