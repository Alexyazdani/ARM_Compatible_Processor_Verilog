
module rf16(
    input clk,
    input reset,
    input [3:0] r0addr,
    input [3:0] r1addr,
    input [3:0] waddr,
    input [31:0] wdata,
    input wea,
    output [31:0] r0data,
    output [31:0] r1data
);

    // 16-entry register file
    reg [31:0] regfile [15:0];

    // Declare loop variable **outside** always block
    integer i;

    // Write logic
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 16; i = i + 1)
                regfile[i] <= 32'd0; 
        end else if (wea) begin
            regfile[waddr] <= wdata;
        end
    end

    // Read logic
    assign r0data = regfile[r0addr];
    assign r1data = regfile[r1addr];

endmodule
