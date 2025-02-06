module ArrayRow(
	input [7:0] A,
	input B,
	input [6:0] C,
	output [6:0] sum,
	output sum_real,
	output c_out
);
	wire w1;
	wire [6:0] w2;
	and(w1, A[0], B);
	HalfBitAdder adder(w1, C[0], sum_real, w2[0]);
	
	ArrayCell Cell1(A[1], B, C[1], w2[0], w2[1], sum[0]);	
	ArrayCell Cell2(A[2], B, C[2], w2[1], w2[2], sum[1]);	
	ArrayCell Cell3(A[3], B, C[3], w2[2], w2[3], sum[2]);
	ArrayCell Cell4(A[4], B, C[4], w2[3], w2[4], sum[3]);	
	ArrayCell Cell5(A[5], B, C[5], w2[4], w2[5], sum[4]);	
	ArrayCell Cell6(A[6], B, C[6], w2[5], w2[6], sum[5]);	
	
	wire w3;
	and(w3, A[7], B);
	HalfBitAdder adder2(w3, w2[6], sum[6], c_out);	
	
endmodule

module FullBitAdder(
	input A,
	input B,
	input c_in,
	
	output sum,
	output c_out
);

	wire w1;
	wire w2;
	wire w3;
	
	xor(w1, A, B);
	xor(sum, w1, c_in);
	and(w2, A, B);
	and(w3, c_in, w1);
	or(c_out, w2, w3);
	
endmodule

module ArrayCell(
	input A,
	input B,
	input c,
	input c_in,
	
	output c_out,
	output sum
);


	wire PPX;
	and (PPX, A, B);
	FullBitAdder adder(
		PPX,
		c,
		c_in,
		sum,
		c_out
	);
	
endmodule

module HalfBitAdder(
	input A,
	input B,
	
	output sum,
	output c_out
);

	xor(sum, A, B);
	and(c_out, A, B);
	
endmodule

module ArrayRow_type2(
	input [7:0] A,
	input B,
	input [6:0] C,
	input c_in,
	output [6:0] sum,
	output sum_real,
	output c_out
);
	wire w1;
	wire [6:0] w2;
	and(w1, A[0], B);
	HalfBitAdder adder(w1, C[0], sum_real, w2[0]);
	
	ArrayCell Cell1(A[1], B, C[1], w2[0], w2[1], sum[0]);	
	ArrayCell Cell2(A[2], B, C[2], w2[1], w2[2], sum[1]);	
	ArrayCell Cell3(A[3], B, C[3], w2[2], w2[3], sum[2]);
	ArrayCell Cell4(A[4], B, C[4], w2[3], w2[4], sum[3]);	
	ArrayCell Cell5(A[5], B, C[5], w2[4], w2[5], sum[4]);	
	ArrayCell Cell6(A[6], B, C[6], w2[5], w2[6], sum[5]);	
	ArrayCell Cel7(A[7], B, c_in, w2[6], c_out, sum[6]);	
endmodule

module array_8(
	input [7:0] A,
	input [7:0] B,
	output [15:0] P
);
	and(P[0], A[0], B[0]);
	wire [6:0] w0;
	and(w0[0], A[1], B[0]);
	and(w0[1], A[2], B[0]);
	and(w0[2], A[3], B[0]);
	and(w0[3], A[4], B[0]);
	and(w0[4], A[5], B[0]);
	and(w0[5], A[6], B[0]);
	and(w0[6], A[7], B[0]);

	wire [6:0] w1;
	wire wc1;
		
	ArrayRow row1(A[7:0], B[1], w0[6:0], w1[6:0], P[1], wc1);
	
	wire [6:0] w2;
	wire wc2;
	ArrayRow_type2 row2(A[7:0], B[2], w1[6:0], wc1, w2[6:0], P[2], wc2);
	
	wire [6:0] w3;
	wire wc3;
	ArrayRow_type2 row3(A[7:0], B[3], w2[6:0], wc2, w3[6:0], P[3], wc3);
	
	wire [6:0] w4;
	wire wc4;
	ArrayRow_type2 row4(A[7:0], B[4], w3[6:0], wc3, w4[6:0], P[4], wc4);
	
	wire [6:0] w5;
	wire wc5;
	ArrayRow_type2 row5(A[7:0], B[5], w4[6:0], wc4, w5[6:0], P[5], wc5);
	
	wire [6:0] w6;
	wire wc6;
	ArrayRow_type2 row6(A[7:0], B[6], w5[6:0], wc5, w6[6:0], P[6], wc6);

	ArrayRow_type2 row7(A[7:0], B[7], w6[6:0], wc6, P[14:8], P[7], P[15]);
endmodule


module array_16(
    input [15:0]A,
    input [15:0]B,
    output [31:0]P
);

    wire [15:0]aL_bL;
    wire [15:0]aH_bL;
    wire [15:0]aL_bH;
    wire [15:0]aH_bH;

    // exact_4x4 e0(.A(A[3:0]), .B(B[3:0]), .P(aL_bL));
    array_8 lsb_1(.A(A[7:0]), .B(B[7:0]), .P(aL_bL));
    array_8 mid_1(.A(A[15:8]), .B(B[7:0]), .P(aH_bL));
    array_8 mid_2(.A(A[7:0]), .B(B[15:8]), .P(aL_bH));
    array_8 msb_1(.A(A[15:8]), .B(B[15:8]), .P(aH_bH));

    // Adding the partial products
    wire [31:0]padded_aL_bL;
    wire [31:0]padded_aH_bL;
    wire [31:0]padded_aL_bH;
    wire [31:0]padded_aH_bH;

    //  padding them according to the pattern mentioned in Figure - 7 
    assign padded_aL_bL = {16'b0, aL_bL};       
    assign padded_aH_bL = {8'b0, aH_bL, 8'b0};
    assign padded_aL_bH = {8'b0, aL_bH, 8'b0};
    assign padded_aH_bH = {aH_bH, 16'b0};     

    assign P = padded_aL_bL + padded_aH_bL + padded_aL_bH + padded_aH_bH;

endmodule




module array_32(
    input  [31:0]A,
    input  [31:0]B,
    output [63:0]P
);

    wire [31:0]aL_bL;
    wire [31:0]aH_bL;
    wire [31:0]aL_bH;
    wire [31:0]aH_bH;

    // exact_4x4 e0(.A(A[3:0]), .B(B[3:0]), .P(aL_bL));
    array_16 lsb_1(.A(A[15:0]), .B(B[15:0]), .P(aL_bL));
    array_16 mid_1(.A(A[31:16]), .B(B[15:0]), .P(aH_bL));
    array_16 mid_2(.A(A[15:0]), .B(B[31:16]), .P(aL_bH));
    array_16 msb_1(.A(A[31:16]), .B(B[31:16]), .P(aH_bH));

    // Adding the partial products
    wire [31:0]padded_aL_bL;
    wire [31:0]padded_aH_bL;
    wire [31:0]padded_aL_bH;
    wire [31:0]padded_aH_bH;

    //  padding them according to the pattern mentioned in Figure - 7 
    assign padded_aL_bL = {32'b0, aL_bL};       
    assign padded_aH_bL = {16'b0, aH_bL, 16'b0};
    assign padded_aL_bH = {16'b0, aL_bH, 16'b0};
    assign padded_aH_bH = {aH_bH, 32'b0};     

    assign P = padded_aL_bL + padded_aH_bL + padded_aL_bH + padded_aH_bH;

endmodule



// module tb_multiplier;

//     parameter M = 16;
//     parameter N = 16;

//     reg [M-1:0] A;
//     reg [N-1:0] B;

//     wire [M+N-1:0] P;
//     reg [M+N-1:0] correct;

//     array_16 uut (
//         .A(A),
//         .B(B),
//         .P(P)
//     );

//     integer i, j;
//     integer total_tests = 0;
//     integer mismatches = 0;

//     initial begin
//         for (i = 0; i < (1 << M); i = i + 1) begin
//             for (j = 0; j < (1 << N); j = j + 1) begin
//                 A = i;
//                 B = j;
//                 correct = A * B;
//                 #2; // Wait for the result to propagate
//                 if (P !== (A * B)) begin
//                     mismatches = mismatches + 1;
//                     $display("Mismatch: A=%d, B=%d, Expected=%d, Got=%d", A, B, correct, P);
//                 end
//                 total_tests = total_tests + 1;
//             end
//         end

//         $display("Total tests: %d", total_tests);
//         $display("Mismatches: %d", mismatches);
//         $display("Accuracy: %f%%", 100.0 * (total_tests - mismatches) / total_tests);

//         $finish;
//     end

//     initial begin
//         $monitor("At time %t, A = %d, B = %d, P = %d, correct = %d", $time, A, B, P, correct );
//     end

// endmodule