
        module rr8x8__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x4__nr4x4__nr4x4__B__(
            input [7:0] A, 
            input [7:0] B, 
            output [15:0] P
        );
            // _AH__   _____AL___________ 
            // _BH__   _____BL___________ 
            // Lower bits are given to Higher part of bits, the other orientation is not considered
            wire [3:0] A_H, B_H;
            wire [3:0] A_L, B_L;
            
            assign A_H = A[7:4];
            assign B_H = B[7:4];
            assign A_L = A[3:0];
            assign B_L = B[3:0];
            
            
            wire [7:0] P1;
            wire [7:0] P2, P3;
            wire [7:0] P4;
            
            rr_4x4_1 M1(.A(A_H), .B(B_H), .P(P1));
            nr_4x4 M2(.A(A_H), .B(B_L), .P(P2));
            nr_4x4 M3(.A(A_L), .B(B_H), .P(P3));
            nr_4x4 M4(.A(A_L), .B(B_L), .P(P4));
            
            assign P = (P1 << 8) + (P3 << 4) + (P2 << 4) + P4;
        endmodule
        
        module rr_4x4_1(
            input [3:0] A, 
            input [3:0] B, 
            output [7:0] P
        );
            // _AH__   _____AL___________ 
            // _BH__   _____BL___________ 
            // Lower bits are given to Higher part of bits, the other orientation is not considered
            wire [2:0] A_H, B_H;
            wire [0:0] A_L, B_L;
            
            assign A_H = A[3:1];
            assign B_H = B[3:1];
            assign A_L = A[0:0];
            assign B_L = B[0:0];
            
            wire [5:0] P1;
            wire [2:0] P2, P3;
            wire [0:0] P4;
            
            nr_3x3 M1(.A(A_H), .B(B_H), .P(P1));
            nr_3x1 M2(.A(A_H), .B(B_L), .P(P2));
            nr_1x3 M3(.A(A_L), .B(B_H), .P(P3));
            nr_1x1 M4(.A(A_L), .B(B_L), .P(P4));
            
            assign P = (P1 << 2) + (P3 << 1) + (P2 << 1) + P4;
        endmodule
        
module nr_4x4
(
  input [3:0] A,
  input [3:0] B,
  output [7:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign PP_10 = A[1] & B[0];
  assign sum1_0 = PP_01 ^ PP_10;
  assign carry1_0 = PP_01 & PP_10;
  assign P[1] = sum1_0;
  assign PP_02 = A[0] & B[2];
  assign PP_11 = A[1] & B[1];
  assign PP_20 = A[2] & B[0];
  assign sum2_0 = PP_02 ^ PP_11;
  assign carry2_0 = PP_02 & PP_11;
  assign sum2_1 = PP_20 ^ sum2_0;
  assign carry2_1 = PP_20 & sum2_0;
  assign sum2_2 = carry1_0 ^ sum2_1;
  assign carry2_2 = carry1_0 & sum2_1;
  assign P[2] = sum2_2;
  assign PP_03 = A[0] & B[3];
  assign PP_12 = A[1] & B[2];
  assign PP_21 = A[2] & B[1];
  assign PP_30 = A[3] & B[0];
  assign sum3_0 = PP_03 ^ PP_12;
  assign carry3_0 = PP_03 & PP_12;
  assign sum3_1 = PP_21 ^ sum3_0;
  assign carry3_1 = PP_21 & sum3_0;
  assign sum3_2 = PP_30 ^ sum3_1;
  assign carry3_2 = PP_30 & sum3_1;
  assign sum3_3 = carry2_0 ^ sum3_2;
  assign carry3_3 = carry2_0 & sum3_2;
  assign sum3_4 = carry2_1 ^ sum3_3;
  assign carry3_4 = carry2_1 & sum3_3;
  assign sum3_5 = carry2_2 ^ sum3_4;
  assign carry3_5 = carry2_2 & sum3_4;
  assign P[3] = sum3_5;
  assign PP_13 = A[1] & B[3];
  assign PP_22 = A[2] & B[2];
  assign PP_31 = A[3] & B[1];
  assign sum4_0 = PP_13 ^ PP_22;
  assign carry4_0 = PP_13 & PP_22;
  assign sum4_1 = PP_31 ^ sum4_0;
  assign carry4_1 = PP_31 & sum4_0;
  assign sum4_2 = carry3_0 ^ sum4_1;
  assign carry4_2 = carry3_0 & sum4_1;
  assign sum4_3 = carry3_1 ^ sum4_2;
  assign carry4_3 = carry3_1 & sum4_2;
  assign sum4_4 = carry3_2 ^ sum4_3;
  assign carry4_4 = carry3_2 & sum4_3;
  assign sum4_5 = carry3_3 ^ sum4_4;
  assign carry4_5 = carry3_3 & sum4_4;
  assign sum4_6 = carry3_4 ^ sum4_5;
  assign carry4_6 = carry3_4 & sum4_5;
  assign sum4_7 = carry3_5 ^ sum4_6;
  assign carry4_7 = carry3_5 & sum4_6;
  assign P[4] = sum4_7;
  assign PP_23 = A[2] & B[3];
  assign PP_32 = A[3] & B[2];
  assign sum5_0 = PP_23 ^ PP_32;
  assign carry5_0 = PP_23 & PP_32;
  assign sum5_1 = carry4_0 ^ sum5_0;
  assign carry5_1 = carry4_0 & sum5_0;
  assign sum5_2 = carry4_1 ^ sum5_1;
  assign carry5_2 = carry4_1 & sum5_1;
  assign sum5_3 = carry4_2 ^ sum5_2;
  assign carry5_3 = carry4_2 & sum5_2;
  assign sum5_4 = carry4_3 ^ sum5_3;
  assign carry5_4 = carry4_3 & sum5_3;
  assign sum5_5 = carry4_4 ^ sum5_4;
  assign carry5_5 = carry4_4 & sum5_4;
  assign sum5_6 = carry4_5 ^ sum5_5;
  assign carry5_6 = carry4_5 & sum5_5;
  assign sum5_7 = carry4_6 ^ sum5_6;
  assign carry5_7 = carry4_6 & sum5_6;
  assign sum5_8 = carry4_7 ^ sum5_7;
  assign carry5_8 = carry4_7 & sum5_7;
  assign P[5] = sum5_8;
  assign PP_33 = A[3] & B[3];
  assign sum6_0 = PP_33 ^ carry5_0;
  assign carry6_0 = PP_33 & carry5_0;
  assign sum6_1 = sum6_0 ^ carry5_1;
  assign carry6_1 = sum6_0 & carry5_1;
  assign sum6_2 = sum6_1 ^ carry5_2;
  assign carry6_2 = sum6_1 & carry5_2;
  assign sum6_3 = sum6_2 ^ carry5_3;
  assign carry6_3 = sum6_2 & carry5_3;
  assign sum6_4 = sum6_3 ^ carry5_4;
  assign carry6_4 = sum6_3 & carry5_4;
  assign sum6_5 = sum6_4 ^ carry5_5;
  assign carry6_5 = sum6_4 & carry5_5;
  assign sum6_6 = sum6_5 ^ carry5_6;
  assign carry6_6 = sum6_5 & carry5_6;
  assign sum6_7 = sum6_6 ^ carry5_7;
  assign carry6_7 = sum6_6 & carry5_7;
  assign sum6_8 = sum6_7 ^ carry5_8;
  assign carry6_8 = sum6_7 & carry5_8;
  assign P[6] = sum6_8;
  assign P[7] = carry6_0 | carry6_1 | carry6_2 | carry6_3 | carry6_4 | carry6_5 | carry6_6 | carry6_7 | carry6_8;

endmodule

module nr_2x4
(
  input [1:0] A,
  input [3:0] B,
  output [5:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign PP_10 = A[1] & B[0];
  assign sum1_0 = PP_01 ^ PP_10;
  assign carry1_0 = PP_01 & PP_10;
  assign P[1] = sum1_0;
  assign PP_02 = A[0] & B[2];
  assign PP_11 = A[1] & B[1];
  assign sum2_0 = PP_02 ^ PP_11;
  assign carry2_0 = PP_02 & PP_11;
  assign sum2_1 = carry1_0 ^ sum2_0;
  assign carry2_1 = carry1_0 & sum2_0;
  assign P[2] = sum2_1;
  assign PP_03 = A[0] & B[3];
  assign PP_12 = A[1] & B[2];
  assign sum3_0 = PP_03 ^ PP_12;
  assign carry3_0 = PP_03 & PP_12;
  assign sum3_1 = carry2_0 ^ sum3_0;
  assign carry3_1 = carry2_0 & sum3_0;
  assign sum3_2 = carry2_1 ^ sum3_1;
  assign carry3_2 = carry2_1 & sum3_1;
  assign P[3] = sum3_2;
  assign PP_13 = A[1] & B[3];
  assign sum4_0 = PP_13 ^ carry3_0;
  assign carry4_0 = PP_13 & carry3_0;
  assign sum4_1 = sum4_0 ^ carry3_1;
  assign carry4_1 = sum4_0 & carry3_1;
  assign sum4_2 = sum4_1 ^ carry3_2;
  assign carry4_2 = sum4_1 & carry3_2;
  assign P[4] = sum4_2;
  assign P[5] = carry4_0 | carry4_1 | carry4_2;

endmodule

module nr_1x2
(
  input [0:0] A,
  input [1:0] B,
  output [1:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign P[1] = PP_01;

endmodule

module nr_6x2
(
  input [5:0] A,
  input [1:0] B,
  output [7:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign PP_10 = A[1] & B[0];
  assign sum1_0 = PP_01 ^ PP_10;
  assign carry1_0 = PP_01 & PP_10;
  assign P[1] = sum1_0;
  assign PP_11 = A[1] & B[1];
  assign PP_20 = A[2] & B[0];
  assign sum2_0 = PP_11 ^ PP_20;
  assign carry2_0 = PP_11 & PP_20;
  assign sum2_1 = carry1_0 ^ sum2_0;
  assign carry2_1 = carry1_0 & sum2_0;
  assign P[2] = sum2_1;
  assign PP_21 = A[2] & B[1];
  assign PP_30 = A[3] & B[0];
  assign sum3_0 = PP_21 ^ PP_30;
  assign carry3_0 = PP_21 & PP_30;
  assign sum3_1 = carry2_0 ^ sum3_0;
  assign carry3_1 = carry2_0 & sum3_0;
  assign sum3_2 = carry2_1 ^ sum3_1;
  assign carry3_2 = carry2_1 & sum3_1;
  assign P[3] = sum3_2;
  assign PP_31 = A[3] & B[1];
  assign PP_40 = A[4] & B[0];
  assign sum4_0 = PP_31 ^ PP_40;
  assign carry4_0 = PP_31 & PP_40;
  assign sum4_1 = carry3_0 ^ sum4_0;
  assign carry4_1 = carry3_0 & sum4_0;
  assign sum4_2 = carry3_1 ^ sum4_1;
  assign carry4_2 = carry3_1 & sum4_1;
  assign sum4_3 = carry3_2 ^ sum4_2;
  assign carry4_3 = carry3_2 & sum4_2;
  assign P[4] = sum4_3;
  assign PP_41 = A[4] & B[1];
  assign PP_50 = A[5] & B[0];
  assign sum5_0 = PP_41 ^ PP_50;
  assign carry5_0 = PP_41 & PP_50;
  assign sum5_1 = carry4_0 ^ sum5_0;
  assign carry5_1 = carry4_0 & sum5_0;
  assign sum5_2 = carry4_1 ^ sum5_1;
  assign carry5_2 = carry4_1 & sum5_1;
  assign sum5_3 = carry4_2 ^ sum5_2;
  assign carry5_3 = carry4_2 & sum5_2;
  assign sum5_4 = carry4_3 ^ sum5_3;
  assign carry5_4 = carry4_3 & sum5_3;
  assign P[5] = sum5_4;
  assign PP_51 = A[5] & B[1];
  assign sum6_0 = PP_51 ^ carry5_0;
  assign carry6_0 = PP_51 & carry5_0;
  assign sum6_1 = sum6_0 ^ carry5_1;
  assign carry6_1 = sum6_0 & carry5_1;
  assign sum6_2 = sum6_1 ^ carry5_2;
  assign carry6_2 = sum6_1 & carry5_2;
  assign sum6_3 = sum6_2 ^ carry5_3;
  assign carry6_3 = sum6_2 & carry5_3;
  assign sum6_4 = sum6_3 ^ carry5_4;
  assign carry6_4 = sum6_3 & carry5_4;
  assign P[6] = sum6_4;
  assign P[7] = carry6_0 | carry6_1 | carry6_2 | carry6_3 | carry6_4;

endmodule

module nr_2x1
(
  input [1:0] A,
  input [0:0] B,
  output [1:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_10 = A[1] & B[0];
  assign P[1] = PP_10;

endmodule

module nr_3x1
(
  input [2:0] A,
  input [0:0] B,
  output [2:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_10 = A[1] & B[0];
  assign P[1] = PP_10;
  assign PP_20 = A[2] & B[0];
  assign P[2] = PP_20;

endmodule

module nr_1x1
(
  input [0:0] A,
  input [0:0] B,
  output [0:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;

endmodule

module nr_4x2
(
  input [3:0] A,
  input [1:0] B,
  output [5:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign PP_10 = A[1] & B[0];
  assign sum1_0 = PP_01 ^ PP_10;
  assign carry1_0 = PP_01 & PP_10;
  assign P[1] = sum1_0;
  assign PP_11 = A[1] & B[1];
  assign PP_20 = A[2] & B[0];
  assign sum2_0 = PP_11 ^ PP_20;
  assign carry2_0 = PP_11 & PP_20;
  assign sum2_1 = carry1_0 ^ sum2_0;
  assign carry2_1 = carry1_0 & sum2_0;
  assign P[2] = sum2_1;
  assign PP_21 = A[2] & B[1];
  assign PP_30 = A[3] & B[0];
  assign sum3_0 = PP_21 ^ PP_30;
  assign carry3_0 = PP_21 & PP_30;
  assign sum3_1 = carry2_0 ^ sum3_0;
  assign carry3_1 = carry2_0 & sum3_0;
  assign sum3_2 = carry2_1 ^ sum3_1;
  assign carry3_2 = carry2_1 & sum3_1;
  assign P[3] = sum3_2;
  assign PP_31 = A[3] & B[1];
  assign sum4_0 = PP_31 ^ carry3_0;
  assign carry4_0 = PP_31 & carry3_0;
  assign sum4_1 = sum4_0 ^ carry3_1;
  assign carry4_1 = sum4_0 & carry3_1;
  assign sum4_2 = sum4_1 ^ carry3_2;
  assign carry4_2 = sum4_1 & carry3_2;
  assign P[4] = sum4_2;
  assign P[5] = carry4_0 | carry4_1 | carry4_2;

endmodule

module nr_2x3
(
  input [1:0] A,
  input [2:0] B,
  output [4:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign PP_10 = A[1] & B[0];
  assign sum1_0 = PP_01 ^ PP_10;
  assign carry1_0 = PP_01 & PP_10;
  assign P[1] = sum1_0;
  assign PP_02 = A[0] & B[2];
  assign PP_11 = A[1] & B[1];
  assign sum2_0 = PP_02 ^ PP_11;
  assign carry2_0 = PP_02 & PP_11;
  assign sum2_1 = carry1_0 ^ sum2_0;
  assign carry2_1 = carry1_0 & sum2_0;
  assign P[2] = sum2_1;
  assign PP_12 = A[1] & B[2];
  assign sum3_0 = PP_12 ^ carry2_0;
  assign carry3_0 = PP_12 & carry2_0;
  assign sum3_1 = sum3_0 ^ carry2_1;
  assign carry3_1 = sum3_0 & carry2_1;
  assign P[3] = sum3_1;
  assign P[4] = carry3_0 | carry3_1;

endmodule

module nr_3x3
(
  input [2:0] A,
  input [2:0] B,
  output [5:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign PP_10 = A[1] & B[0];
  assign sum1_0 = PP_01 ^ PP_10;
  assign carry1_0 = PP_01 & PP_10;
  assign P[1] = sum1_0;
  assign PP_02 = A[0] & B[2];
  assign PP_11 = A[1] & B[1];
  assign PP_20 = A[2] & B[0];
  assign sum2_0 = PP_02 ^ PP_11;
  assign carry2_0 = PP_02 & PP_11;
  assign sum2_1 = PP_20 ^ sum2_0;
  assign carry2_1 = PP_20 & sum2_0;
  assign sum2_2 = carry1_0 ^ sum2_1;
  assign carry2_2 = carry1_0 & sum2_1;
  assign P[2] = sum2_2;
  assign PP_12 = A[1] & B[2];
  assign PP_21 = A[2] & B[1];
  assign sum3_0 = PP_12 ^ PP_21;
  assign carry3_0 = PP_12 & PP_21;
  assign sum3_1 = carry2_0 ^ sum3_0;
  assign carry3_1 = carry2_0 & sum3_0;
  assign sum3_2 = carry2_1 ^ sum3_1;
  assign carry3_2 = carry2_1 & sum3_1;
  assign sum3_3 = carry2_2 ^ sum3_2;
  assign carry3_3 = carry2_2 & sum3_2;
  assign P[3] = sum3_3;
  assign PP_22 = A[2] & B[2];
  assign sum4_0 = PP_22 ^ carry3_0;
  assign carry4_0 = PP_22 & carry3_0;
  assign sum4_1 = sum4_0 ^ carry3_1;
  assign carry4_1 = sum4_0 & carry3_1;
  assign sum4_2 = sum4_1 ^ carry3_2;
  assign carry4_2 = sum4_1 & carry3_2;
  assign sum4_3 = sum4_2 ^ carry3_3;
  assign carry4_3 = sum4_2 & carry3_3;
  assign P[4] = sum4_3;
  assign P[5] = carry4_0 | carry4_1 | carry4_2 | carry4_3;

endmodule

module nr_2x6
(
  input [1:0] A,
  input [5:0] B,
  output [7:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign PP_10 = A[1] & B[0];
  assign sum1_0 = PP_01 ^ PP_10;
  assign carry1_0 = PP_01 & PP_10;
  assign P[1] = sum1_0;
  assign PP_02 = A[0] & B[2];
  assign PP_11 = A[1] & B[1];
  assign sum2_0 = PP_02 ^ PP_11;
  assign carry2_0 = PP_02 & PP_11;
  assign sum2_1 = carry1_0 ^ sum2_0;
  assign carry2_1 = carry1_0 & sum2_0;
  assign P[2] = sum2_1;
  assign PP_03 = A[0] & B[3];
  assign PP_12 = A[1] & B[2];
  assign sum3_0 = PP_03 ^ PP_12;
  assign carry3_0 = PP_03 & PP_12;
  assign sum3_1 = carry2_0 ^ sum3_0;
  assign carry3_1 = carry2_0 & sum3_0;
  assign sum3_2 = carry2_1 ^ sum3_1;
  assign carry3_2 = carry2_1 & sum3_1;
  assign P[3] = sum3_2;
  assign PP_04 = A[0] & B[4];
  assign PP_13 = A[1] & B[3];
  assign sum4_0 = PP_04 ^ PP_13;
  assign carry4_0 = PP_04 & PP_13;
  assign sum4_1 = carry3_0 ^ sum4_0;
  assign carry4_1 = carry3_0 & sum4_0;
  assign sum4_2 = carry3_1 ^ sum4_1;
  assign carry4_2 = carry3_1 & sum4_1;
  assign sum4_3 = carry3_2 ^ sum4_2;
  assign carry4_3 = carry3_2 & sum4_2;
  assign P[4] = sum4_3;
  assign PP_05 = A[0] & B[5];
  assign PP_14 = A[1] & B[4];
  assign sum5_0 = PP_05 ^ PP_14;
  assign carry5_0 = PP_05 & PP_14;
  assign sum5_1 = carry4_0 ^ sum5_0;
  assign carry5_1 = carry4_0 & sum5_0;
  assign sum5_2 = carry4_1 ^ sum5_1;
  assign carry5_2 = carry4_1 & sum5_1;
  assign sum5_3 = carry4_2 ^ sum5_2;
  assign carry5_3 = carry4_2 & sum5_2;
  assign sum5_4 = carry4_3 ^ sum5_3;
  assign carry5_4 = carry4_3 & sum5_3;
  assign P[5] = sum5_4;
  assign PP_15 = A[1] & B[5];
  assign sum6_0 = PP_15 ^ carry5_0;
  assign carry6_0 = PP_15 & carry5_0;
  assign sum6_1 = sum6_0 ^ carry5_1;
  assign carry6_1 = sum6_0 & carry5_1;
  assign sum6_2 = sum6_1 ^ carry5_2;
  assign carry6_2 = sum6_1 & carry5_2;
  assign sum6_3 = sum6_2 ^ carry5_3;
  assign carry6_3 = sum6_2 & carry5_3;
  assign sum6_4 = sum6_3 ^ carry5_4;
  assign carry6_4 = sum6_3 & carry5_4;
  assign P[6] = sum6_4;
  assign P[7] = carry6_0 | carry6_1 | carry6_2 | carry6_3 | carry6_4;

endmodule

module nr_2x2
(
  input [1:0] A,
  input [1:0] B,
  output [3:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign PP_10 = A[1] & B[0];
  assign sum1_0 = PP_01 ^ PP_10;
  assign carry1_0 = PP_01 & PP_10;
  assign P[1] = sum1_0;
  assign PP_11 = A[1] & B[1];
  assign sum2_0 = PP_11 ^ carry1_0;
  assign carry2_0 = PP_11 & carry1_0;
  assign P[2] = sum2_0;
  assign P[3] = carry2_0;

endmodule

module nr_5x3
(
  input [4:0] A,
  input [2:0] B,
  output [7:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign PP_10 = A[1] & B[0];
  assign sum1_0 = PP_01 ^ PP_10;
  assign carry1_0 = PP_01 & PP_10;
  assign P[1] = sum1_0;
  assign PP_02 = A[0] & B[2];
  assign PP_11 = A[1] & B[1];
  assign PP_20 = A[2] & B[0];
  assign sum2_0 = PP_02 ^ PP_11;
  assign carry2_0 = PP_02 & PP_11;
  assign sum2_1 = PP_20 ^ sum2_0;
  assign carry2_1 = PP_20 & sum2_0;
  assign sum2_2 = carry1_0 ^ sum2_1;
  assign carry2_2 = carry1_0 & sum2_1;
  assign P[2] = sum2_2;
  assign PP_12 = A[1] & B[2];
  assign PP_21 = A[2] & B[1];
  assign PP_30 = A[3] & B[0];
  assign sum3_0 = PP_12 ^ PP_21;
  assign carry3_0 = PP_12 & PP_21;
  assign sum3_1 = PP_30 ^ sum3_0;
  assign carry3_1 = PP_30 & sum3_0;
  assign sum3_2 = carry2_0 ^ sum3_1;
  assign carry3_2 = carry2_0 & sum3_1;
  assign sum3_3 = carry2_1 ^ sum3_2;
  assign carry3_3 = carry2_1 & sum3_2;
  assign sum3_4 = carry2_2 ^ sum3_3;
  assign carry3_4 = carry2_2 & sum3_3;
  assign P[3] = sum3_4;
  assign PP_22 = A[2] & B[2];
  assign PP_31 = A[3] & B[1];
  assign PP_40 = A[4] & B[0];
  assign sum4_0 = PP_22 ^ PP_31;
  assign carry4_0 = PP_22 & PP_31;
  assign sum4_1 = PP_40 ^ sum4_0;
  assign carry4_1 = PP_40 & sum4_0;
  assign sum4_2 = carry3_0 ^ sum4_1;
  assign carry4_2 = carry3_0 & sum4_1;
  assign sum4_3 = carry3_1 ^ sum4_2;
  assign carry4_3 = carry3_1 & sum4_2;
  assign sum4_4 = carry3_2 ^ sum4_3;
  assign carry4_4 = carry3_2 & sum4_3;
  assign sum4_5 = carry3_3 ^ sum4_4;
  assign carry4_5 = carry3_3 & sum4_4;
  assign sum4_6 = carry3_4 ^ sum4_5;
  assign carry4_6 = carry3_4 & sum4_5;
  assign P[4] = sum4_6;
  assign PP_32 = A[3] & B[2];
  assign PP_41 = A[4] & B[1];
  assign sum5_0 = PP_32 ^ PP_41;
  assign carry5_0 = PP_32 & PP_41;
  assign sum5_1 = carry4_0 ^ sum5_0;
  assign carry5_1 = carry4_0 & sum5_0;
  assign sum5_2 = carry4_1 ^ sum5_1;
  assign carry5_2 = carry4_1 & sum5_1;
  assign sum5_3 = carry4_2 ^ sum5_2;
  assign carry5_3 = carry4_2 & sum5_2;
  assign sum5_4 = carry4_3 ^ sum5_3;
  assign carry5_4 = carry4_3 & sum5_3;
  assign sum5_5 = carry4_4 ^ sum5_4;
  assign carry5_5 = carry4_4 & sum5_4;
  assign sum5_6 = carry4_5 ^ sum5_5;
  assign carry5_6 = carry4_5 & sum5_5;
  assign sum5_7 = carry4_6 ^ sum5_6;
  assign carry5_7 = carry4_6 & sum5_6;
  assign P[5] = sum5_7;
  assign PP_42 = A[4] & B[2];
  assign sum6_0 = PP_42 ^ carry5_0;
  assign carry6_0 = PP_42 & carry5_0;
  assign sum6_1 = sum6_0 ^ carry5_1;
  assign carry6_1 = sum6_0 & carry5_1;
  assign sum6_2 = sum6_1 ^ carry5_2;
  assign carry6_2 = sum6_1 & carry5_2;
  assign sum6_3 = sum6_2 ^ carry5_3;
  assign carry6_3 = sum6_2 & carry5_3;
  assign sum6_4 = sum6_3 ^ carry5_4;
  assign carry6_4 = sum6_3 & carry5_4;
  assign sum6_5 = sum6_4 ^ carry5_5;
  assign carry6_5 = sum6_4 & carry5_5;
  assign sum6_6 = sum6_5 ^ carry5_6;
  assign carry6_6 = sum6_5 & carry5_6;
  assign sum6_7 = sum6_6 ^ carry5_7;
  assign carry6_7 = sum6_6 & carry5_7;
  assign P[6] = sum6_7;
  assign P[7] = carry6_0 | carry6_1 | carry6_2 | carry6_3 | carry6_4 | carry6_5 | carry6_6 | carry6_7;

endmodule

module nr_3x2
(
  input [2:0] A,
  input [1:0] B,
  output [4:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign PP_10 = A[1] & B[0];
  assign sum1_0 = PP_01 ^ PP_10;
  assign carry1_0 = PP_01 & PP_10;
  assign P[1] = sum1_0;
  assign PP_11 = A[1] & B[1];
  assign PP_20 = A[2] & B[0];
  assign sum2_0 = PP_11 ^ PP_20;
  assign carry2_0 = PP_11 & PP_20;
  assign sum2_1 = carry1_0 ^ sum2_0;
  assign carry2_1 = carry1_0 & sum2_0;
  assign P[2] = sum2_1;
  assign PP_21 = A[2] & B[1];
  assign sum3_0 = PP_21 ^ carry2_0;
  assign carry3_0 = PP_21 & carry2_0;
  assign sum3_1 = sum3_0 ^ carry2_1;
  assign carry3_1 = sum3_0 & carry2_1;
  assign P[3] = sum3_1;
  assign P[4] = carry3_0 | carry3_1;

endmodule

module nr_1x3
(
  input [0:0] A,
  input [2:0] B,
  output [2:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign P[1] = PP_01;
  assign PP_02 = A[0] & B[2];
  assign P[2] = PP_02;

endmodule

module nr_3x5
(
  input [2:0] A,
  input [4:0] B,
  output [7:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign PP_10 = A[1] & B[0];
  assign sum1_0 = PP_01 ^ PP_10;
  assign carry1_0 = PP_01 & PP_10;
  assign P[1] = sum1_0;
  assign PP_02 = A[0] & B[2];
  assign PP_11 = A[1] & B[1];
  assign PP_20 = A[2] & B[0];
  assign sum2_0 = PP_02 ^ PP_11;
  assign carry2_0 = PP_02 & PP_11;
  assign sum2_1 = PP_20 ^ sum2_0;
  assign carry2_1 = PP_20 & sum2_0;
  assign sum2_2 = carry1_0 ^ sum2_1;
  assign carry2_2 = carry1_0 & sum2_1;
  assign P[2] = sum2_2;
  assign PP_03 = A[0] & B[3];
  assign PP_12 = A[1] & B[2];
  assign PP_21 = A[2] & B[1];
  assign sum3_0 = PP_03 ^ PP_12;
  assign carry3_0 = PP_03 & PP_12;
  assign sum3_1 = PP_21 ^ sum3_0;
  assign carry3_1 = PP_21 & sum3_0;
  assign sum3_2 = carry2_0 ^ sum3_1;
  assign carry3_2 = carry2_0 & sum3_1;
  assign sum3_3 = carry2_1 ^ sum3_2;
  assign carry3_3 = carry2_1 & sum3_2;
  assign sum3_4 = carry2_2 ^ sum3_3;
  assign carry3_4 = carry2_2 & sum3_3;
  assign P[3] = sum3_4;
  assign PP_04 = A[0] & B[4];
  assign PP_13 = A[1] & B[3];
  assign PP_22 = A[2] & B[2];
  assign sum4_0 = PP_04 ^ PP_13;
  assign carry4_0 = PP_04 & PP_13;
  assign sum4_1 = PP_22 ^ sum4_0;
  assign carry4_1 = PP_22 & sum4_0;
  assign sum4_2 = carry3_0 ^ sum4_1;
  assign carry4_2 = carry3_0 & sum4_1;
  assign sum4_3 = carry3_1 ^ sum4_2;
  assign carry4_3 = carry3_1 & sum4_2;
  assign sum4_4 = carry3_2 ^ sum4_3;
  assign carry4_4 = carry3_2 & sum4_3;
  assign sum4_5 = carry3_3 ^ sum4_4;
  assign carry4_5 = carry3_3 & sum4_4;
  assign sum4_6 = carry3_4 ^ sum4_5;
  assign carry4_6 = carry3_4 & sum4_5;
  assign P[4] = sum4_6;
  assign PP_14 = A[1] & B[4];
  assign PP_23 = A[2] & B[3];
  assign sum5_0 = PP_14 ^ PP_23;
  assign carry5_0 = PP_14 & PP_23;
  assign sum5_1 = carry4_0 ^ sum5_0;
  assign carry5_1 = carry4_0 & sum5_0;
  assign sum5_2 = carry4_1 ^ sum5_1;
  assign carry5_2 = carry4_1 & sum5_1;
  assign sum5_3 = carry4_2 ^ sum5_2;
  assign carry5_3 = carry4_2 & sum5_2;
  assign sum5_4 = carry4_3 ^ sum5_3;
  assign carry5_4 = carry4_3 & sum5_3;
  assign sum5_5 = carry4_4 ^ sum5_4;
  assign carry5_5 = carry4_4 & sum5_4;
  assign sum5_6 = carry4_5 ^ sum5_5;
  assign carry5_6 = carry4_5 & sum5_5;
  assign sum5_7 = carry4_6 ^ sum5_6;
  assign carry5_7 = carry4_6 & sum5_6;
  assign P[5] = sum5_7;
  assign PP_24 = A[2] & B[4];
  assign sum6_0 = PP_24 ^ carry5_0;
  assign carry6_0 = PP_24 & carry5_0;
  assign sum6_1 = sum6_0 ^ carry5_1;
  assign carry6_1 = sum6_0 & carry5_1;
  assign sum6_2 = sum6_1 ^ carry5_2;
  assign carry6_2 = sum6_1 & carry5_2;
  assign sum6_3 = sum6_2 ^ carry5_3;
  assign carry6_3 = sum6_2 & carry5_3;
  assign sum6_4 = sum6_3 ^ carry5_4;
  assign carry6_4 = sum6_3 & carry5_4;
  assign sum6_5 = sum6_4 ^ carry5_5;
  assign carry6_5 = sum6_4 & carry5_5;
  assign sum6_6 = sum6_5 ^ carry5_6;
  assign carry6_6 = sum6_5 & carry5_6;
  assign sum6_7 = sum6_6 ^ carry5_7;
  assign carry6_7 = sum6_6 & carry5_7;
  assign P[6] = sum6_7;
  assign P[7] = carry6_0 | carry6_1 | carry6_2 | carry6_3 | carry6_4 | carry6_5 | carry6_6 | carry6_7;

endmodule
