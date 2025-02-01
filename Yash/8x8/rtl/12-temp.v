
        module rr8x8__B__nr3x3__nr3x5__nr5x3__nr5x5__B__(
            input [7:0] A, 
            input [7:0] B, 
            output [15:0] P
        );
            // _AH__   _____AL___________ 
            // _BH__   _____BL___________ 
            // Lower bits are given to Higher part of bits, the other orientation is not considered
            wire [2:0] A_H, B_H;
            wire [4:0] A_L, B_L;
            
            assign A_H = A[7:5];
            assign B_H = B[7:5];
            assign A_L = A[4:0];
            assign B_L = B[4:0];
            
            
            wire [5:0] P1;
            wire [7:0] P2, P3;
            wire [9:0] P4;
            
            nr_3x3 M1(.A(A_H), .B(B_H), .P(P1));
            nr_3x5 M2(.A(A_H), .B(B_L), .P(P2));
            nr_5x3 M3(.A(A_L), .B(B_H), .P(P3));
            nr_5x5 M4(.A(A_L), .B(B_L), .P(P4));
            
            assign P = (P1 << 10) + (P3 << 5) + (P2 << 5) + P4;
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

module nr_5x5
(
  input [4:0] A,
  input [4:0] B,
  output [9:0] P
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
  assign PP_04 = A[0] & B[4];
  assign PP_13 = A[1] & B[3];
  assign PP_22 = A[2] & B[2];
  assign PP_31 = A[3] & B[1];
  assign PP_40 = A[4] & B[0];
  assign sum4_0 = PP_04 ^ PP_13;
  assign carry4_0 = PP_04 & PP_13;
  assign sum4_1 = PP_22 ^ sum4_0;
  assign carry4_1 = PP_22 & sum4_0;
  assign sum4_2 = PP_31 ^ sum4_1;
  assign carry4_2 = PP_31 & sum4_1;
  assign sum4_3 = PP_40 ^ sum4_2;
  assign carry4_3 = PP_40 & sum4_2;
  assign sum4_4 = carry3_0 ^ sum4_3;
  assign carry4_4 = carry3_0 & sum4_3;
  assign sum4_5 = carry3_1 ^ sum4_4;
  assign carry4_5 = carry3_1 & sum4_4;
  assign sum4_6 = carry3_2 ^ sum4_5;
  assign carry4_6 = carry3_2 & sum4_5;
  assign sum4_7 = carry3_3 ^ sum4_6;
  assign carry4_7 = carry3_3 & sum4_6;
  assign sum4_8 = carry3_4 ^ sum4_7;
  assign carry4_8 = carry3_4 & sum4_7;
  assign sum4_9 = carry3_5 ^ sum4_8;
  assign carry4_9 = carry3_5 & sum4_8;
  assign P[4] = sum4_9;
  assign PP_14 = A[1] & B[4];
  assign PP_23 = A[2] & B[3];
  assign PP_32 = A[3] & B[2];
  assign PP_41 = A[4] & B[1];
  assign sum5_0 = PP_14 ^ PP_23;
  assign carry5_0 = PP_14 & PP_23;
  assign sum5_1 = PP_32 ^ sum5_0;
  assign carry5_1 = PP_32 & sum5_0;
  assign sum5_2 = PP_41 ^ sum5_1;
  assign carry5_2 = PP_41 & sum5_1;
  assign sum5_3 = carry4_0 ^ sum5_2;
  assign carry5_3 = carry4_0 & sum5_2;
  assign sum5_4 = carry4_1 ^ sum5_3;
  assign carry5_4 = carry4_1 & sum5_3;
  assign sum5_5 = carry4_2 ^ sum5_4;
  assign carry5_5 = carry4_2 & sum5_4;
  assign sum5_6 = carry4_3 ^ sum5_5;
  assign carry5_6 = carry4_3 & sum5_5;
  assign sum5_7 = carry4_4 ^ sum5_6;
  assign carry5_7 = carry4_4 & sum5_6;
  assign sum5_8 = carry4_5 ^ sum5_7;
  assign carry5_8 = carry4_5 & sum5_7;
  assign sum5_9 = carry4_6 ^ sum5_8;
  assign carry5_9 = carry4_6 & sum5_8;
  assign sum5_10 = carry4_7 ^ sum5_9;
  assign carry5_10 = carry4_7 & sum5_9;
  assign sum5_11 = carry4_8 ^ sum5_10;
  assign carry5_11 = carry4_8 & sum5_10;
  assign sum5_12 = carry4_9 ^ sum5_11;
  assign carry5_12 = carry4_9 & sum5_11;
  assign P[5] = sum5_12;
  assign PP_24 = A[2] & B[4];
  assign PP_33 = A[3] & B[3];
  assign PP_42 = A[4] & B[2];
  assign sum6_0 = PP_24 ^ PP_33;
  assign carry6_0 = PP_24 & PP_33;
  assign sum6_1 = PP_42 ^ sum6_0;
  assign carry6_1 = PP_42 & sum6_0;
  assign sum6_2 = carry5_0 ^ sum6_1;
  assign carry6_2 = carry5_0 & sum6_1;
  assign sum6_3 = carry5_1 ^ sum6_2;
  assign carry6_3 = carry5_1 & sum6_2;
  assign sum6_4 = carry5_2 ^ sum6_3;
  assign carry6_4 = carry5_2 & sum6_3;
  assign sum6_5 = carry5_3 ^ sum6_4;
  assign carry6_5 = carry5_3 & sum6_4;
  assign sum6_6 = carry5_4 ^ sum6_5;
  assign carry6_6 = carry5_4 & sum6_5;
  assign sum6_7 = carry5_5 ^ sum6_6;
  assign carry6_7 = carry5_5 & sum6_6;
  assign sum6_8 = carry5_6 ^ sum6_7;
  assign carry6_8 = carry5_6 & sum6_7;
  assign sum6_9 = carry5_7 ^ sum6_8;
  assign carry6_9 = carry5_7 & sum6_8;
  assign sum6_10 = carry5_8 ^ sum6_9;
  assign carry6_10 = carry5_8 & sum6_9;
  assign sum6_11 = carry5_9 ^ sum6_10;
  assign carry6_11 = carry5_9 & sum6_10;
  assign sum6_12 = carry5_10 ^ sum6_11;
  assign carry6_12 = carry5_10 & sum6_11;
  assign sum6_13 = carry5_11 ^ sum6_12;
  assign carry6_13 = carry5_11 & sum6_12;
  assign sum6_14 = carry5_12 ^ sum6_13;
  assign carry6_14 = carry5_12 & sum6_13;
  assign P[6] = sum6_14;
  assign PP_34 = A[3] & B[4];
  assign PP_43 = A[4] & B[3];
  assign sum7_0 = PP_34 ^ PP_43;
  assign carry7_0 = PP_34 & PP_43;
  assign sum7_1 = carry6_0 ^ sum7_0;
  assign carry7_1 = carry6_0 & sum7_0;
  assign sum7_2 = carry6_1 ^ sum7_1;
  assign carry7_2 = carry6_1 & sum7_1;
  assign sum7_3 = carry6_2 ^ sum7_2;
  assign carry7_3 = carry6_2 & sum7_2;
  assign sum7_4 = carry6_3 ^ sum7_3;
  assign carry7_4 = carry6_3 & sum7_3;
  assign sum7_5 = carry6_4 ^ sum7_4;
  assign carry7_5 = carry6_4 & sum7_4;
  assign sum7_6 = carry6_5 ^ sum7_5;
  assign carry7_6 = carry6_5 & sum7_5;
  assign sum7_7 = carry6_6 ^ sum7_6;
  assign carry7_7 = carry6_6 & sum7_6;
  assign sum7_8 = carry6_7 ^ sum7_7;
  assign carry7_8 = carry6_7 & sum7_7;
  assign sum7_9 = carry6_8 ^ sum7_8;
  assign carry7_9 = carry6_8 & sum7_8;
  assign sum7_10 = carry6_9 ^ sum7_9;
  assign carry7_10 = carry6_9 & sum7_9;
  assign sum7_11 = carry6_10 ^ sum7_10;
  assign carry7_11 = carry6_10 & sum7_10;
  assign sum7_12 = carry6_11 ^ sum7_11;
  assign carry7_12 = carry6_11 & sum7_11;
  assign sum7_13 = carry6_12 ^ sum7_12;
  assign carry7_13 = carry6_12 & sum7_12;
  assign sum7_14 = carry6_13 ^ sum7_13;
  assign carry7_14 = carry6_13 & sum7_13;
  assign sum7_15 = carry6_14 ^ sum7_14;
  assign carry7_15 = carry6_14 & sum7_14;
  assign P[7] = sum7_15;
  assign PP_44 = A[4] & B[4];
  assign sum8_0 = PP_44 ^ carry7_0;
  assign carry8_0 = PP_44 & carry7_0;
  assign sum8_1 = sum8_0 ^ carry7_1;
  assign carry8_1 = sum8_0 & carry7_1;
  assign sum8_2 = sum8_1 ^ carry7_2;
  assign carry8_2 = sum8_1 & carry7_2;
  assign sum8_3 = sum8_2 ^ carry7_3;
  assign carry8_3 = sum8_2 & carry7_3;
  assign sum8_4 = sum8_3 ^ carry7_4;
  assign carry8_4 = sum8_3 & carry7_4;
  assign sum8_5 = sum8_4 ^ carry7_5;
  assign carry8_5 = sum8_4 & carry7_5;
  assign sum8_6 = sum8_5 ^ carry7_6;
  assign carry8_6 = sum8_5 & carry7_6;
  assign sum8_7 = sum8_6 ^ carry7_7;
  assign carry8_7 = sum8_6 & carry7_7;
  assign sum8_8 = sum8_7 ^ carry7_8;
  assign carry8_8 = sum8_7 & carry7_8;
  assign sum8_9 = sum8_8 ^ carry7_9;
  assign carry8_9 = sum8_8 & carry7_9;
  assign sum8_10 = sum8_9 ^ carry7_10;
  assign carry8_10 = sum8_9 & carry7_10;
  assign sum8_11 = sum8_10 ^ carry7_11;
  assign carry8_11 = sum8_10 & carry7_11;
  assign sum8_12 = sum8_11 ^ carry7_12;
  assign carry8_12 = sum8_11 & carry7_12;
  assign sum8_13 = sum8_12 ^ carry7_13;
  assign carry8_13 = sum8_12 & carry7_13;
  assign sum8_14 = sum8_13 ^ carry7_14;
  assign carry8_14 = sum8_13 & carry7_14;
  assign sum8_15 = sum8_14 ^ carry7_15;
  assign carry8_15 = sum8_14 & carry7_15;
  assign P[8] = sum8_15;
  assign P[9] = carry8_0 | carry8_1 | carry8_2 | carry8_3 | carry8_4 | carry8_5 | carry8_6 | carry8_7 | carry8_8 | carry8_9 | carry8_10 | carry8_11 | carry8_12 | carry8_13 | carry8_14 | carry8_15;

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
