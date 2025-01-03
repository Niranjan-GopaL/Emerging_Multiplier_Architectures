
module exact_nr_3x1
(
  input [2:0] A,
  input [0:0] B,
  output [3:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_10 = A[1] & B[0];
  assign P[1] = PP_10;
  assign PP_20 = A[2] & B[0];
  assign P[2] = PP_20;

endmodule

module exact_nr_1x1
(
  input [0:0] A,
  input [0:0] B,
  output [1:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;

endmodule

module exact_nr_3x3
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

module exact_nr_2x2
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

module exact_nr_1x3
(
  input [0:0] A,
  input [2:0] B,
  output [3:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign P[1] = PP_01;
  assign PP_02 = A[0] & B[2];
  assign P[2] = PP_02;

endmodule

        module exact_rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__(
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
            wire [3:0] P2, P3;
            wire [1:0] P4;
            
            exact_nr_3x3 M1(.A(A_H), .B(B_H), .P(P1));
            exact_nr_3x1 M2(.A(A_H), .B(B_L), .P(P2));
            exact_nr_1x3 M3(.A(A_L), .B(B_H), .P(P3));
            exact_nr_1x1 M4(.A(A_L), .B(B_L), .P(P4));
            
            assign P = (P1 << 2) + (P3 << 1) + (P2 << 1) + P4;
        endmodule
        