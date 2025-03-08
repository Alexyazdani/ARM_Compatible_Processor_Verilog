/*
counter.v
Program Counter for 5-stage pipeline for ARMv8-M architecture

Engineer: Alexander Yazdani
Engineer: Szymon Gorski
Engineer: Tim Lu

University of Southern California (USC)
EE533 - Spring 2025
Professor Young Cho
25 February 2025
*/

module counter (
    input wire clk,
    input wire reset,
    input wire pipe_en,
    input wire [8:0] in,
    output reg [8:0] out
);
    wire [8:0] sum;
    wire [8:0] carry;

    half_adder ha0 (.a(in[0]), .b(1'b1),     .sum(sum[0]), .cout(carry[0]));
    half_adder ha1 (.a(in[1]), .b(carry[0]), .sum(sum[1]), .cout(carry[1]));
    half_adder ha2 (.a(in[2]), .b(carry[1]), .sum(sum[2]), .cout(carry[2]));
    half_adder ha3 (.a(in[3]), .b(carry[2]), .sum(sum[3]), .cout(carry[3]));
    half_adder ha4 (.a(in[4]), .b(carry[3]), .sum(sum[4]), .cout(carry[4]));
    half_adder ha5 (.a(in[5]), .b(carry[4]), .sum(sum[5]), .cout(carry[5]));
    half_adder ha6 (.a(in[6]), .b(carry[5]), .sum(sum[6]), .cout(carry[6]));
    half_adder ha7 (.a(in[7]), .b(carry[6]), .sum(sum[7]), .cout(carry[7]));
    half_adder ha8 (.a(in[8]), .b(carry[7]), .sum(sum[8]), .cout());

    always @(posedge clk) begin
        if (reset) out <= 9'd0;
        else if (pipe_en) out <= sum;
    end
endmodule

module half_adder (
    input wire a,    
    input wire b,    
    output wire sum,  
    output wire cout  
);
    assign sum = a ^ b;
    assign cout = a & b;
endmodule