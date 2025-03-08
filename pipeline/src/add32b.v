

module pfa(input A, B, Cin, output result, output P, output G);
    assign G = A & B;
    assign P = A ^ B;
    assign result = Cin ^ P;
endmodule

module cla_4bit(input [3:0] A, B, input Cin, output [3:0] result, output P0, G0);
    wire [3:0] P, G, C;
    
    pfa PFA0 (A[0], B[0], Cin, result[0], P[0], G[0]);
    pfa PFA1 (A[1], B[1], C[0], result[1], P[1], G[1]);
    pfa PFA2 (A[2], B[2], C[1], result[2], P[2], G[2]);
    pfa PFA3 (A[3], B[3], C[2], result[3], P[3], G[3]);

    assign C[0] = G[0] | (P[0] & Cin);
    assign C[1] = G[1] | (P[1] & G[0]) | (P[0] & P[1] & Cin);
    assign C[2] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Cin);
    assign C[3] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin);

    assign G0 = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
    assign P0 = P[3] & P[2] & P[1] & P[0];
endmodule

module cla_16bit(input [15:0] A, B, input Cin, output [15:0] result, output P0, G0);
    wire [3:0] P, G, C;

    cla_4bit CLA0 (A[3:0], B[3:0], Cin, result[3:0], P[0], G[0]);
    cla_4bit CLA1 (A[7:4], B[7:4], C[0], result[7:4], P[1], G[1]);
    cla_4bit CLA2 (A[11:8], B[11:8], C[1], result[11:8], P[2], G[2]);
    cla_4bit CLA3 (A[15:12], B[15:12], C[2], result[15:12], P[3], G[3]);

    assign C[0] = G[0] | (P[0] & Cin);
    assign C[1] = G[1] | (P[1] & G[0]) | (P[0] & P[1] & Cin);
    assign C[2] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Cin);
    assign C[3] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin);

    assign G0 = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
    assign P0 = P[3] & P[2] & P[1] & P[0];
endmodule

// module add64b(input [63:0] A, B, input Cin, output [63:0] result, output Cout);
//     wire [3:0] P, G, C;

//     cla_16bit CLA0 (A[15:0], B[15:0], Cin, result[15:0], P[0], G[0]);
//     cla_16bit CLA1 (A[31:16], B[31:16], C[0], result[31:16], P[1], G[1]);
//     cla_16bit CLA2 (A[47:32], B[47:32], C[1], result[47:32], P[2], G[2]);
//     cla_16bit CLA3 (A[63:48], B[63:48], C[2], result[63:48], P[3], G[3]);

//     assign C[0] = G[0] | (P[0] & Cin);
//     assign C[1] = G[1] | (P[1] & G[0]) | (P[0] & P[1] & Cin);
//     assign C[2] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Cin);
//     assign C[3] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin);

//     assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin);
// endmodule

module add32b(input [31:0] A, B, input Cin, output [31:0] result, output Cout);
    wire [1:0] P, G, C;

    cla_16bit CLA0 (A[15:0], B[15:0], Cin, result[15:0], P[0], G[0]);
    cla_16bit CLA1 (A[31:16], B[31:16], C[0], result[31:16], P[1], G[1]);

    assign C[0] = G[0] | (P[0] & Cin);
    assign Cout = G[1] | (P[1] & G[0]) | (P[0] & P[1] & Cin);
endmodule

