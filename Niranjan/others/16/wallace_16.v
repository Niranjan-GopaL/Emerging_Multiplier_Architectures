module carryOut(
    output cout,
    input A,
    input B,
    input cin
);
    assign cout = (A & B) | (A & cin) | (B & cin);
endmodule

module sumOut(
    output sum,
    input A,
    input B,
    input cin
);
    assign sum = A ^ B ^ cin;
endmodule

module outSum(
    output sum,
    input A,
    input B
);
    assign sum = A ^ B;
endmodule


// primitive carryOut (output cout, input A, input B, input cin);

//     // Truth Table for carry out
//     table
//       // A B Cin    Cout
//         1 1  ?   :  1  ;
//         1 ?  1   :  1  ;
//         ? 1  1   :  1  ;
//         0 0  ?   :  0  ;
//         0 ?  0   :  0  ;
//         ? 0  0   :  0  ;
//     endtable
// endprimitive

// primitive sumOut (output sum, input A, input B, input cin);

//     // Truth Table for sum
//     table
//       // A B Cin    sum
//         1 1  1   :  1  ;
//         1 0  0   :  1  ;
//         0 1  0   :  1  ;
//         0 0  1   :  1  ;
//         0 0  0   :  0  ;
//         0 1  1   :  0  ;
//         1 0  1   :  0  ;
//         1 1  0   :  0  ;
//     endtable
// endprimitive

// primitive outSum(output sum, input A, input B);

//     // Truth Table for sum
//     table
//       // A B   sum
//         0 0 :  0  ;
//         0 1 :  1  ;
//         1 0 :  1  ;
//         1 1 :  0  ;
//     endtable
// endprimitive

// primitive outCarry(output carry, input A, input B);

//     // Truth Table for carry out
//     table
//       // A B  carry
//         0 0 :  0  ;
//         0 1 :  0  ;
//         1 0 :  0  ;
//         1 1 :  1  ;
//     endtable
// endprimitive


module FA(output cout, output sum, input A, input B, input cin);

    // instantiating sum and carry primitives
    sumOut s(sum, A, B, cin);
    carryOut co(cout, A, B, cin);
endmodule

module HA (output carry, output sum, input A, input B);

    // instantiating sum and carry primitives
    outSum s(sum, A, B);
    outCarry c(carry, A, B);
endmodule

module outCarry(
    output carry,
    input A,
    input B
);
    assign carry = A & B;
endmodule

module wallace_8 (output[15:0] P, input[7:0] A, input[7:0] B);

    reg[7:0] wallaceTree[7:0];
    integer i, j;

    always @(A, B) begin
        for(i = 0;i < 8;i = i+1)
            for(j = 0;j < 8;j = j+1)
                wallaceTree[i][j] = A[i] & B[j];
    end
    // P[0]
    assign P[0] = wallaceTree[0][0];

    // P[1]
    wire P1_c;
    HA P1_HA_1(P1_c, P[1], wallaceTree[0][1], wallaceTree[1][0]);

    // P[2]
    wire P2_c_temp_1, P2_c, P2_temp_1;
    FA P2_FA_1(P2_c_temp_1, P2_temp_1, wallaceTree[0][2], wallaceTree[1][1], P1_c);
    HA P2_HA_1(P2_c, P[2], wallaceTree[2][0], P2_temp_1);

    // P[3]
    wire P3_c_temp_1, P3_c_temp_2, P3_c, P3_temp_1, P3_temp_2;
    FA P3_FA_1(P3_c_temp_1, P3_temp_1, wallaceTree[0][3], wallaceTree[1][2], P2_c);
    FA P3_FA_2(P3_c_temp_2, P3_temp_2, wallaceTree[2][1], P3_temp_1, P2_c_temp_1);
    HA P3_HA_1(P3_c, P[3], wallaceTree[3][0], P3_temp_2);

    // P[4]
    wire P4_c_temp_1, P4_c_temp_2, P4_c_temp_3, P4_c, P4_temp_1, P4_temp_2, P4_temp_3;
    FA P4_FA_1(P4_c_temp_1, P4_temp_1, wallaceTree[0][4], wallaceTree[1][3], P3_c);
    FA P4_FA_2(P4_c_temp_2, P4_temp_2, wallaceTree[2][2], P4_temp_1, P3_c_temp_1);
    FA P4_FA_3(P4_c_temp_3, P4_temp_3, wallaceTree[3][1], P4_temp_2, P3_c_temp_2);
    HA P4_HA_1(P4_c, P[4], wallaceTree[4][0], P4_temp_3);

    // P[5]
    wire P5_c_temp_1, P5_c_temp_2, P5_c_temp_3, P5_c_temp_4, P5_c, P5_temp_1, P5_temp_2, P5_temp_3, P5_temp_4;
    FA P5_FA_1(P5_c_temp_1, P5_temp_1, wallaceTree[0][5], wallaceTree[1][4], P4_c);
    FA P5_FA_2(P5_c_temp_2, P5_temp_2, wallaceTree[2][3], P5_temp_1, P4_c_temp_1);
    FA P5_FA_3(P5_c_temp_3, P5_temp_3, wallaceTree[3][2], P5_temp_2, P4_c_temp_2);
    FA P5_FA_4(P5_c_temp_4, P5_temp_4, wallaceTree[4][1], P5_temp_3, P4_c_temp_3);
    HA P5_HA_1(P5_c, P[5], wallaceTree[5][0], P5_temp_4);

    // P[6]
    wire P6_c_temp_1, P6_c_temp_2, P6_c_temp_3, P6_c_temp_4, P6_c_temp_5, P6_c, P6_temp_1, P6_temp_2, P6_temp_3, P6_temp_4, P6_temp_5;
    FA P6_FA_1(P6_c_temp_1, P6_temp_1, wallaceTree[0][6], wallaceTree[1][5], P5_c);
    FA P6_FA_2(P6_c_temp_2, P6_temp_2, wallaceTree[2][4], P6_temp_1, P5_c_temp_1);
    FA P6_FA_3(P6_c_temp_3, P6_temp_3, wallaceTree[3][3], P6_temp_2, P5_c_temp_2);
    FA P6_FA_4(P6_c_temp_4, P6_temp_4, wallaceTree[4][2], P6_temp_3, P5_c_temp_3);
    FA P6_FA_5(P6_c_temp_5, P6_temp_5, wallaceTree[5][1], P6_temp_4, P5_c_temp_4);
    HA P6_HA_1(P6_c, P[6], wallaceTree[6][0], P6_temp_5);

    // P[7]
    wire P7_c_temp_1, P7_c_temp_2, P7_c_temp_3, P7_c_temp_4, P7_c_temp_5, P7_c_temp_6, P7_c, P7_temp_1, P7_temp_2, P7_temp_3, P7_temp_4, P7_temp_5, P7_temp_6;
    FA P7_FA_1(P7_c_temp_1, P7_temp_1, wallaceTree[0][7], wallaceTree[1][6], P6_c);
    FA P7_FA_2(P7_c_temp_2, P7_temp_2, wallaceTree[2][5], P7_temp_1, P6_c_temp_1);
    FA P7_FA_3(P7_c_temp_3, P7_temp_3, wallaceTree[3][4], P7_temp_2, P6_c_temp_2);
    FA P7_FA_4(P7_c_temp_4, P7_temp_4, wallaceTree[4][3], P7_temp_3, P6_c_temp_3);
    FA P7_FA_5(P7_c_temp_5, P7_temp_5, wallaceTree[5][2], P7_temp_4, P6_c_temp_4);
    FA P7_FA_6(P7_c_temp_6, P7_temp_6, wallaceTree[6][1], P7_temp_5, P6_c_temp_5);
    HA P7_HA_1(P7_c, P[7], wallaceTree[7][0], P7_temp_6);

    // P[8]
    wire P8_c_temp_1, P8_c_temp_2, P8_c_temp_3, P8_c_temp_4, P8_c_temp_5, P8_c_temp_6, P8_c, P8_temp_1, P8_temp_2, P8_temp_3, P8_temp_4, P8_temp_5, P8_temp_6;
    FA P8_FA_1(P8_c_temp_1, P8_temp_1, wallaceTree[1][7], wallaceTree[2][6], P7_c);
    FA P8_FA_2(P8_c_temp_2, P8_temp_2, wallaceTree[3][5], P8_temp_1, P7_c_temp_1);
    FA P8_FA_3(P8_c_temp_3, P8_temp_3, wallaceTree[4][4], P8_temp_2, P7_c_temp_2);
    FA P8_FA_4(P8_c_temp_4, P8_temp_4, wallaceTree[5][3], P8_temp_3, P7_c_temp_3);
    FA P8_FA_5(P8_c_temp_5, P8_temp_5, wallaceTree[6][2], P8_temp_4, P7_c_temp_4);
    FA P8_FA_6(P8_c_temp_6, P8_temp_6, wallaceTree[7][1], P8_temp_5, P7_c_temp_5);
    HA P8_HA_1(P8_c, P[8], P8_temp_6, P7_c_temp_6);

    // P[9]
    wire P9_c_temp_1, P9_c_temp_2, P9_c_temp_3, P9_c_temp_4, P9_c, P9_temp_1, P9_temp_2, P9_temp_3, P9_temp_4;
    FA P9_FA_1(P9_c_temp_1, P9_temp_1, wallaceTree[2][7], wallaceTree[3][6], P8_c);
    FA P9_FA_2(P9_c_temp_2, P9_temp_2, wallaceTree[4][5], P9_temp_1, P8_c_temp_1);
    FA P9_FA_3(P9_c_temp_3, P9_temp_3, wallaceTree[5][4], P9_temp_2, P8_c_temp_2);
    FA P9_FA_4(P9_c_temp_4, P9_temp_4, wallaceTree[6][3], P9_temp_3, P8_c_temp_3);
    FA P9_FA_5(P9_c_temp_5, P9_temp_5, wallaceTree[7][2], P9_temp_4, P8_c_temp_4);
    FA P9_FA_6(P9_c, P[9], P9_temp_5, P8_c_temp_5, P8_c_temp_6);

    // P[10]
    wire P10_c_temp_1, P10_c_temp_2, P10_c_temp_3, P10_c, P10_temp_1, P10_temp_2, P10_temp_3;
    FA P10_FA_1(P10_c_temp_1, P10_temp_1, wallaceTree[3][7], wallaceTree[4][6], P9_c);
    FA P10_FA_2(P10_c_temp_2, P10_temp_2, wallaceTree[5][5], P10_temp_1, P9_c_temp_1);
    FA P10_FA_3(P10_c_temp_3, P10_temp_3, wallaceTree[6][4], P10_temp_2, P9_c_temp_2);
    FA P10_FA_4(P10_c_temp_4, P10_temp_4, wallaceTree[7][3], P10_temp_3, P9_c_temp_3);
    FA P10_FA_5(P10_c, P[10], P10_temp_4, P9_c_temp_4, P9_c_temp_5);

    // P[11]
    wire P11_c_temp_1, P11_c_temp_2, P11_c, P11_temp_1, P11_temp_2;
    FA P11_FA_1(P11_c_temp_1, P11_temp_1, wallaceTree[4][7], wallaceTree[5][6], P10_c);
    FA P11_FA_2(P11_c_temp_2, P11_temp_2, wallaceTree[6][5], P11_temp_1, P10_c_temp_1);
    FA P11_FA_3(P11_c_temp_3, P11_temp_3, wallaceTree[7][4], P11_temp_2, P10_c_temp_2);
    FA P11_FA_4(P11_c, P[11], P11_temp_3, P10_c_temp_3, P10_c_temp_4);

    // P[12]
    wire P12_c_temp_1, P12_c, P12_temp_1;
    FA P12_FA_1(P12_c_temp_1, P12_temp_1, wallaceTree[5][7], wallaceTree[6][6], P11_c);
    FA P12_FA_2(P12_c_temp_2, P12_temp_2, wallaceTree[7][5], P12_temp_1, P11_c_temp_1);
    FA P12_FA_3(P12_c, P[12], P12_temp_2, P11_c_temp_2, P11_c_temp_3);

    // P[13]
    wire P13_c;
    FA P13_FA_1(P13_c_temp_1, P13_temp_1, wallaceTree[6][7], wallaceTree[7][6], P12_c);
    FA P13_FA_2(P13_c, P[13], P13_temp_1, P12_c_temp_2, P12_c_temp_1);

    // P[14]
    FA P14_FA_1(P14_c, P[14], wallaceTree[7][7], P13_c, P13_c_temp_1);

    // P[15]
    assign P[15] = P14_c;
endmodule


module wallace_16(
    input [15:0]A,
    input [15:0]B,
    output [31:0]P
);

    wire [15:0]aL_bL;
    wire [15:0]aH_bL;
    wire [15:0]aL_bH;
    wire [15:0]aH_bH;

    // exact_4x4 e0(.A(A[3:0]), .B(B[3:0]), .P(aL_bL));
    wallace_8 lsb_1(.A(A[7:0]), .B(B[7:0]), .P(aL_bL));
    wallace_8 mid_1(.A(A[15:8]), .B(B[7:0]), .P(aH_bL));
    wallace_8 mid_2(.A(A[7:0]), .B(B[15:8]), .P(aL_bH));
    wallace_8 msb_1(.A(A[15:8]), .B(B[15:8]), .P(aH_bH));

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



// module tb_multiplier;

//     parameter M = 16;
//     parameter N = 16;

//     reg [M-1:0] A;
//     reg [N-1:0] B;

//     wire [M+N-1:0] P;
//     reg [M+N-1:0] correct;

//     wallace_16 uut (
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