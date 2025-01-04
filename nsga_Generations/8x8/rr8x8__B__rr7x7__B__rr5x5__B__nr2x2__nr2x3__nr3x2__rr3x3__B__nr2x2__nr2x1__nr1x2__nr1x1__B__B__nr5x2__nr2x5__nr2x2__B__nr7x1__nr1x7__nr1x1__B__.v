
module exact_nr_3x4
(
  input [2:0] A,
  input [3:0] B,
  output [6:0] P
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
  assign PP_13 = A[1] & B[3];
  assign PP_22 = A[2] & B[2];
  assign sum4_0 = PP_13 ^ PP_22;
  assign carry4_0 = PP_13 & PP_22;
  assign sum4_1 = carry3_0 ^ sum4_0;
  assign carry4_1 = carry3_0 & sum4_0;
  assign sum4_2 = carry3_1 ^ sum4_1;
  assign carry4_2 = carry3_1 & sum4_1;
  assign sum4_3 = carry3_2 ^ sum4_2;
  assign carry4_3 = carry3_2 & sum4_2;
  assign sum4_4 = carry3_3 ^ sum4_3;
  assign carry4_4 = carry3_3 & sum4_3;
  assign sum4_5 = carry3_4 ^ sum4_4;
  assign carry4_5 = carry3_4 & sum4_4;
  assign P[4] = sum4_5;
  assign PP_23 = A[2] & B[3];
  assign sum5_0 = PP_23 ^ carry4_0;
  assign carry5_0 = PP_23 & carry4_0;
  assign sum5_1 = sum5_0 ^ carry4_1;
  assign carry5_1 = sum5_0 & carry4_1;
  assign sum5_2 = sum5_1 ^ carry4_2;
  assign carry5_2 = sum5_1 & carry4_2;
  assign sum5_3 = sum5_2 ^ carry4_3;
  assign carry5_3 = sum5_2 & carry4_3;
  assign sum5_4 = sum5_3 ^ carry4_4;
  assign carry5_4 = sum5_3 & carry4_4;
  assign sum5_5 = sum5_4 ^ carry4_5;
  assign carry5_5 = sum5_4 & carry4_5;
  assign P[5] = sum5_5;
  assign P[6] = carry5_0 | carry5_1 | carry5_2 | carry5_3 | carry5_4 | carry5_5;

endmodule

module exact_nr_4x3
(
  input [3:0] A,
  input [2:0] B,
  output [6:0] P
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
  assign sum4_0 = PP_22 ^ PP_31;
  assign carry4_0 = PP_22 & PP_31;
  assign sum4_1 = carry3_0 ^ sum4_0;
  assign carry4_1 = carry3_0 & sum4_0;
  assign sum4_2 = carry3_1 ^ sum4_1;
  assign carry4_2 = carry3_1 & sum4_1;
  assign sum4_3 = carry3_2 ^ sum4_2;
  assign carry4_3 = carry3_2 & sum4_2;
  assign sum4_4 = carry3_3 ^ sum4_3;
  assign carry4_4 = carry3_3 & sum4_3;
  assign sum4_5 = carry3_4 ^ sum4_4;
  assign carry4_5 = carry3_4 & sum4_4;
  assign P[4] = sum4_5;
  assign PP_32 = A[3] & B[2];
  assign sum5_0 = PP_32 ^ carry4_0;
  assign carry5_0 = PP_32 & carry4_0;
  assign sum5_1 = sum5_0 ^ carry4_1;
  assign carry5_1 = sum5_0 & carry4_1;
  assign sum5_2 = sum5_1 ^ carry4_2;
  assign carry5_2 = sum5_1 & carry4_2;
  assign sum5_3 = sum5_2 ^ carry4_3;
  assign carry5_3 = sum5_2 & carry4_3;
  assign sum5_4 = sum5_3 ^ carry4_4;
  assign carry5_4 = sum5_3 & carry4_4;
  assign sum5_5 = sum5_4 ^ carry4_5;
  assign carry5_5 = sum5_4 & carry4_5;
  assign P[5] = sum5_5;
  assign P[6] = carry5_0 | carry5_1 | carry5_2 | carry5_3 | carry5_4 | carry5_5;

endmodule

module exact_nr_3x1
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

module exact_nr_5x1
(
  input [4:0] A,
  input [0:0] B,
  output [4:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_10 = A[1] & B[0];
  assign P[1] = PP_10;
  assign PP_20 = A[2] & B[0];
  assign P[2] = PP_20;
  assign PP_30 = A[3] & B[0];
  assign P[3] = PP_30;
  assign PP_40 = A[4] & B[0];
  assign P[4] = PP_40;

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

module exact_nr_1x6
(
  input [0:0] A,
  input [5:0] B,
  output [5:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign P[1] = PP_01;
  assign PP_02 = A[0] & B[2];
  assign P[2] = PP_02;
  assign PP_03 = A[0] & B[3];
  assign P[3] = PP_03;
  assign PP_04 = A[0] & B[4];
  assign P[4] = PP_04;
  assign PP_05 = A[0] & B[5];
  assign P[5] = PP_05;

endmodule

module exact_nr_2x5
(
  input [1:0] A,
  input [4:0] B,
  output [6:0] P
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
  assign PP_14 = A[1] & B[4];
  assign sum5_0 = PP_14 ^ carry4_0;
  assign carry5_0 = PP_14 & carry4_0;
  assign sum5_1 = sum5_0 ^ carry4_1;
  assign carry5_1 = sum5_0 & carry4_1;
  assign sum5_2 = sum5_1 ^ carry4_2;
  assign carry5_2 = sum5_1 & carry4_2;
  assign sum5_3 = sum5_2 ^ carry4_3;
  assign carry5_3 = sum5_2 & carry4_3;
  assign P[5] = sum5_3;
  assign P[6] = carry5_0 | carry5_1 | carry5_2 | carry5_3;

endmodule

module exact_nr_1x3
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

module exact_nr_6x2
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

module exact_nr_7x1
(
  input [6:0] A,
  input [0:0] B,
  output [6:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_10 = A[1] & B[0];
  assign P[1] = PP_10;
  assign PP_20 = A[2] & B[0];
  assign P[2] = PP_20;
  assign PP_30 = A[3] & B[0];
  assign P[3] = PP_30;
  assign PP_40 = A[4] & B[0];
  assign P[4] = PP_40;
  assign PP_50 = A[5] & B[0];
  assign P[5] = PP_50;
  assign PP_60 = A[6] & B[0];
  assign P[6] = PP_60;

endmodule

module exact_nr_7x7
(
  input [6:0] A,
  input [6:0] B,
  output [13:0] P
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
  assign PP_05 = A[0] & B[5];
  assign PP_14 = A[1] & B[4];
  assign PP_23 = A[2] & B[3];
  assign PP_32 = A[3] & B[2];
  assign PP_41 = A[4] & B[1];
  assign PP_50 = A[5] & B[0];
  assign sum5_0 = PP_05 ^ PP_14;
  assign carry5_0 = PP_05 & PP_14;
  assign sum5_1 = PP_23 ^ sum5_0;
  assign carry5_1 = PP_23 & sum5_0;
  assign sum5_2 = PP_32 ^ sum5_1;
  assign carry5_2 = PP_32 & sum5_1;
  assign sum5_3 = PP_41 ^ sum5_2;
  assign carry5_3 = PP_41 & sum5_2;
  assign sum5_4 = PP_50 ^ sum5_3;
  assign carry5_4 = PP_50 & sum5_3;
  assign sum5_5 = carry4_0 ^ sum5_4;
  assign carry5_5 = carry4_0 & sum5_4;
  assign sum5_6 = carry4_1 ^ sum5_5;
  assign carry5_6 = carry4_1 & sum5_5;
  assign sum5_7 = carry4_2 ^ sum5_6;
  assign carry5_7 = carry4_2 & sum5_6;
  assign sum5_8 = carry4_3 ^ sum5_7;
  assign carry5_8 = carry4_3 & sum5_7;
  assign sum5_9 = carry4_4 ^ sum5_8;
  assign carry5_9 = carry4_4 & sum5_8;
  assign sum5_10 = carry4_5 ^ sum5_9;
  assign carry5_10 = carry4_5 & sum5_9;
  assign sum5_11 = carry4_6 ^ sum5_10;
  assign carry5_11 = carry4_6 & sum5_10;
  assign sum5_12 = carry4_7 ^ sum5_11;
  assign carry5_12 = carry4_7 & sum5_11;
  assign sum5_13 = carry4_8 ^ sum5_12;
  assign carry5_13 = carry4_8 & sum5_12;
  assign sum5_14 = carry4_9 ^ sum5_13;
  assign carry5_14 = carry4_9 & sum5_13;
  assign P[5] = sum5_14;
  assign PP_06 = A[0] & B[6];
  assign PP_15 = A[1] & B[5];
  assign PP_24 = A[2] & B[4];
  assign PP_33 = A[3] & B[3];
  assign PP_42 = A[4] & B[2];
  assign PP_51 = A[5] & B[1];
  assign PP_60 = A[6] & B[0];
  assign sum6_0 = PP_06 ^ PP_15;
  assign carry6_0 = PP_06 & PP_15;
  assign sum6_1 = PP_24 ^ sum6_0;
  assign carry6_1 = PP_24 & sum6_0;
  assign sum6_2 = PP_33 ^ sum6_1;
  assign carry6_2 = PP_33 & sum6_1;
  assign sum6_3 = PP_42 ^ sum6_2;
  assign carry6_3 = PP_42 & sum6_2;
  assign sum6_4 = PP_51 ^ sum6_3;
  assign carry6_4 = PP_51 & sum6_3;
  assign sum6_5 = PP_60 ^ sum6_4;
  assign carry6_5 = PP_60 & sum6_4;
  assign sum6_6 = carry5_0 ^ sum6_5;
  assign carry6_6 = carry5_0 & sum6_5;
  assign sum6_7 = carry5_1 ^ sum6_6;
  assign carry6_7 = carry5_1 & sum6_6;
  assign sum6_8 = carry5_2 ^ sum6_7;
  assign carry6_8 = carry5_2 & sum6_7;
  assign sum6_9 = carry5_3 ^ sum6_8;
  assign carry6_9 = carry5_3 & sum6_8;
  assign sum6_10 = carry5_4 ^ sum6_9;
  assign carry6_10 = carry5_4 & sum6_9;
  assign sum6_11 = carry5_5 ^ sum6_10;
  assign carry6_11 = carry5_5 & sum6_10;
  assign sum6_12 = carry5_6 ^ sum6_11;
  assign carry6_12 = carry5_6 & sum6_11;
  assign sum6_13 = carry5_7 ^ sum6_12;
  assign carry6_13 = carry5_7 & sum6_12;
  assign sum6_14 = carry5_8 ^ sum6_13;
  assign carry6_14 = carry5_8 & sum6_13;
  assign sum6_15 = carry5_9 ^ sum6_14;
  assign carry6_15 = carry5_9 & sum6_14;
  assign sum6_16 = carry5_10 ^ sum6_15;
  assign carry6_16 = carry5_10 & sum6_15;
  assign sum6_17 = carry5_11 ^ sum6_16;
  assign carry6_17 = carry5_11 & sum6_16;
  assign sum6_18 = carry5_12 ^ sum6_17;
  assign carry6_18 = carry5_12 & sum6_17;
  assign sum6_19 = carry5_13 ^ sum6_18;
  assign carry6_19 = carry5_13 & sum6_18;
  assign sum6_20 = carry5_14 ^ sum6_19;
  assign carry6_20 = carry5_14 & sum6_19;
  assign P[6] = sum6_20;
  assign PP_16 = A[1] & B[6];
  assign PP_25 = A[2] & B[5];
  assign PP_34 = A[3] & B[4];
  assign PP_43 = A[4] & B[3];
  assign PP_52 = A[5] & B[2];
  assign PP_61 = A[6] & B[1];
  assign sum7_0 = PP_16 ^ PP_25;
  assign carry7_0 = PP_16 & PP_25;
  assign sum7_1 = PP_34 ^ sum7_0;
  assign carry7_1 = PP_34 & sum7_0;
  assign sum7_2 = PP_43 ^ sum7_1;
  assign carry7_2 = PP_43 & sum7_1;
  assign sum7_3 = PP_52 ^ sum7_2;
  assign carry7_3 = PP_52 & sum7_2;
  assign sum7_4 = PP_61 ^ sum7_3;
  assign carry7_4 = PP_61 & sum7_3;
  assign sum7_5 = carry6_0 ^ sum7_4;
  assign carry7_5 = carry6_0 & sum7_4;
  assign sum7_6 = carry6_1 ^ sum7_5;
  assign carry7_6 = carry6_1 & sum7_5;
  assign sum7_7 = carry6_2 ^ sum7_6;
  assign carry7_7 = carry6_2 & sum7_6;
  assign sum7_8 = carry6_3 ^ sum7_7;
  assign carry7_8 = carry6_3 & sum7_7;
  assign sum7_9 = carry6_4 ^ sum7_8;
  assign carry7_9 = carry6_4 & sum7_8;
  assign sum7_10 = carry6_5 ^ sum7_9;
  assign carry7_10 = carry6_5 & sum7_9;
  assign sum7_11 = carry6_6 ^ sum7_10;
  assign carry7_11 = carry6_6 & sum7_10;
  assign sum7_12 = carry6_7 ^ sum7_11;
  assign carry7_12 = carry6_7 & sum7_11;
  assign sum7_13 = carry6_8 ^ sum7_12;
  assign carry7_13 = carry6_8 & sum7_12;
  assign sum7_14 = carry6_9 ^ sum7_13;
  assign carry7_14 = carry6_9 & sum7_13;
  assign sum7_15 = carry6_10 ^ sum7_14;
  assign carry7_15 = carry6_10 & sum7_14;
  assign sum7_16 = carry6_11 ^ sum7_15;
  assign carry7_16 = carry6_11 & sum7_15;
  assign sum7_17 = carry6_12 ^ sum7_16;
  assign carry7_17 = carry6_12 & sum7_16;
  assign sum7_18 = carry6_13 ^ sum7_17;
  assign carry7_18 = carry6_13 & sum7_17;
  assign sum7_19 = carry6_14 ^ sum7_18;
  assign carry7_19 = carry6_14 & sum7_18;
  assign sum7_20 = carry6_15 ^ sum7_19;
  assign carry7_20 = carry6_15 & sum7_19;
  assign sum7_21 = carry6_16 ^ sum7_20;
  assign carry7_21 = carry6_16 & sum7_20;
  assign sum7_22 = carry6_17 ^ sum7_21;
  assign carry7_22 = carry6_17 & sum7_21;
  assign sum7_23 = carry6_18 ^ sum7_22;
  assign carry7_23 = carry6_18 & sum7_22;
  assign sum7_24 = carry6_19 ^ sum7_23;
  assign carry7_24 = carry6_19 & sum7_23;
  assign sum7_25 = carry6_20 ^ sum7_24;
  assign carry7_25 = carry6_20 & sum7_24;
  assign P[7] = sum7_25;
  assign PP_26 = A[2] & B[6];
  assign PP_35 = A[3] & B[5];
  assign PP_44 = A[4] & B[4];
  assign PP_53 = A[5] & B[3];
  assign PP_62 = A[6] & B[2];
  assign sum8_0 = PP_26 ^ PP_35;
  assign carry8_0 = PP_26 & PP_35;
  assign sum8_1 = PP_44 ^ sum8_0;
  assign carry8_1 = PP_44 & sum8_0;
  assign sum8_2 = PP_53 ^ sum8_1;
  assign carry8_2 = PP_53 & sum8_1;
  assign sum8_3 = PP_62 ^ sum8_2;
  assign carry8_3 = PP_62 & sum8_2;
  assign sum8_4 = carry7_0 ^ sum8_3;
  assign carry8_4 = carry7_0 & sum8_3;
  assign sum8_5 = carry7_1 ^ sum8_4;
  assign carry8_5 = carry7_1 & sum8_4;
  assign sum8_6 = carry7_2 ^ sum8_5;
  assign carry8_6 = carry7_2 & sum8_5;
  assign sum8_7 = carry7_3 ^ sum8_6;
  assign carry8_7 = carry7_3 & sum8_6;
  assign sum8_8 = carry7_4 ^ sum8_7;
  assign carry8_8 = carry7_4 & sum8_7;
  assign sum8_9 = carry7_5 ^ sum8_8;
  assign carry8_9 = carry7_5 & sum8_8;
  assign sum8_10 = carry7_6 ^ sum8_9;
  assign carry8_10 = carry7_6 & sum8_9;
  assign sum8_11 = carry7_7 ^ sum8_10;
  assign carry8_11 = carry7_7 & sum8_10;
  assign sum8_12 = carry7_8 ^ sum8_11;
  assign carry8_12 = carry7_8 & sum8_11;
  assign sum8_13 = carry7_9 ^ sum8_12;
  assign carry8_13 = carry7_9 & sum8_12;
  assign sum8_14 = carry7_10 ^ sum8_13;
  assign carry8_14 = carry7_10 & sum8_13;
  assign sum8_15 = carry7_11 ^ sum8_14;
  assign carry8_15 = carry7_11 & sum8_14;
  assign sum8_16 = carry7_12 ^ sum8_15;
  assign carry8_16 = carry7_12 & sum8_15;
  assign sum8_17 = carry7_13 ^ sum8_16;
  assign carry8_17 = carry7_13 & sum8_16;
  assign sum8_18 = carry7_14 ^ sum8_17;
  assign carry8_18 = carry7_14 & sum8_17;
  assign sum8_19 = carry7_15 ^ sum8_18;
  assign carry8_19 = carry7_15 & sum8_18;
  assign sum8_20 = carry7_16 ^ sum8_19;
  assign carry8_20 = carry7_16 & sum8_19;
  assign sum8_21 = carry7_17 ^ sum8_20;
  assign carry8_21 = carry7_17 & sum8_20;
  assign sum8_22 = carry7_18 ^ sum8_21;
  assign carry8_22 = carry7_18 & sum8_21;
  assign sum8_23 = carry7_19 ^ sum8_22;
  assign carry8_23 = carry7_19 & sum8_22;
  assign sum8_24 = carry7_20 ^ sum8_23;
  assign carry8_24 = carry7_20 & sum8_23;
  assign sum8_25 = carry7_21 ^ sum8_24;
  assign carry8_25 = carry7_21 & sum8_24;
  assign sum8_26 = carry7_22 ^ sum8_25;
  assign carry8_26 = carry7_22 & sum8_25;
  assign sum8_27 = carry7_23 ^ sum8_26;
  assign carry8_27 = carry7_23 & sum8_26;
  assign sum8_28 = carry7_24 ^ sum8_27;
  assign carry8_28 = carry7_24 & sum8_27;
  assign sum8_29 = carry7_25 ^ sum8_28;
  assign carry8_29 = carry7_25 & sum8_28;
  assign P[8] = sum8_29;
  assign PP_36 = A[3] & B[6];
  assign PP_45 = A[4] & B[5];
  assign PP_54 = A[5] & B[4];
  assign PP_63 = A[6] & B[3];
  assign sum9_0 = PP_36 ^ PP_45;
  assign carry9_0 = PP_36 & PP_45;
  assign sum9_1 = PP_54 ^ sum9_0;
  assign carry9_1 = PP_54 & sum9_0;
  assign sum9_2 = PP_63 ^ sum9_1;
  assign carry9_2 = PP_63 & sum9_1;
  assign sum9_3 = carry8_0 ^ sum9_2;
  assign carry9_3 = carry8_0 & sum9_2;
  assign sum9_4 = carry8_1 ^ sum9_3;
  assign carry9_4 = carry8_1 & sum9_3;
  assign sum9_5 = carry8_2 ^ sum9_4;
  assign carry9_5 = carry8_2 & sum9_4;
  assign sum9_6 = carry8_3 ^ sum9_5;
  assign carry9_6 = carry8_3 & sum9_5;
  assign sum9_7 = carry8_4 ^ sum9_6;
  assign carry9_7 = carry8_4 & sum9_6;
  assign sum9_8 = carry8_5 ^ sum9_7;
  assign carry9_8 = carry8_5 & sum9_7;
  assign sum9_9 = carry8_6 ^ sum9_8;
  assign carry9_9 = carry8_6 & sum9_8;
  assign sum9_10 = carry8_7 ^ sum9_9;
  assign carry9_10 = carry8_7 & sum9_9;
  assign sum9_11 = carry8_8 ^ sum9_10;
  assign carry9_11 = carry8_8 & sum9_10;
  assign sum9_12 = carry8_9 ^ sum9_11;
  assign carry9_12 = carry8_9 & sum9_11;
  assign sum9_13 = carry8_10 ^ sum9_12;
  assign carry9_13 = carry8_10 & sum9_12;
  assign sum9_14 = carry8_11 ^ sum9_13;
  assign carry9_14 = carry8_11 & sum9_13;
  assign sum9_15 = carry8_12 ^ sum9_14;
  assign carry9_15 = carry8_12 & sum9_14;
  assign sum9_16 = carry8_13 ^ sum9_15;
  assign carry9_16 = carry8_13 & sum9_15;
  assign sum9_17 = carry8_14 ^ sum9_16;
  assign carry9_17 = carry8_14 & sum9_16;
  assign sum9_18 = carry8_15 ^ sum9_17;
  assign carry9_18 = carry8_15 & sum9_17;
  assign sum9_19 = carry8_16 ^ sum9_18;
  assign carry9_19 = carry8_16 & sum9_18;
  assign sum9_20 = carry8_17 ^ sum9_19;
  assign carry9_20 = carry8_17 & sum9_19;
  assign sum9_21 = carry8_18 ^ sum9_20;
  assign carry9_21 = carry8_18 & sum9_20;
  assign sum9_22 = carry8_19 ^ sum9_21;
  assign carry9_22 = carry8_19 & sum9_21;
  assign sum9_23 = carry8_20 ^ sum9_22;
  assign carry9_23 = carry8_20 & sum9_22;
  assign sum9_24 = carry8_21 ^ sum9_23;
  assign carry9_24 = carry8_21 & sum9_23;
  assign sum9_25 = carry8_22 ^ sum9_24;
  assign carry9_25 = carry8_22 & sum9_24;
  assign sum9_26 = carry8_23 ^ sum9_25;
  assign carry9_26 = carry8_23 & sum9_25;
  assign sum9_27 = carry8_24 ^ sum9_26;
  assign carry9_27 = carry8_24 & sum9_26;
  assign sum9_28 = carry8_25 ^ sum9_27;
  assign carry9_28 = carry8_25 & sum9_27;
  assign sum9_29 = carry8_26 ^ sum9_28;
  assign carry9_29 = carry8_26 & sum9_28;
  assign sum9_30 = carry8_27 ^ sum9_29;
  assign carry9_30 = carry8_27 & sum9_29;
  assign sum9_31 = carry8_28 ^ sum9_30;
  assign carry9_31 = carry8_28 & sum9_30;
  assign sum9_32 = carry8_29 ^ sum9_31;
  assign carry9_32 = carry8_29 & sum9_31;
  assign P[9] = sum9_32;
  assign PP_46 = A[4] & B[6];
  assign PP_55 = A[5] & B[5];
  assign PP_64 = A[6] & B[4];
  assign sum10_0 = PP_46 ^ PP_55;
  assign carry10_0 = PP_46 & PP_55;
  assign sum10_1 = PP_64 ^ sum10_0;
  assign carry10_1 = PP_64 & sum10_0;
  assign sum10_2 = carry9_0 ^ sum10_1;
  assign carry10_2 = carry9_0 & sum10_1;
  assign sum10_3 = carry9_1 ^ sum10_2;
  assign carry10_3 = carry9_1 & sum10_2;
  assign sum10_4 = carry9_2 ^ sum10_3;
  assign carry10_4 = carry9_2 & sum10_3;
  assign sum10_5 = carry9_3 ^ sum10_4;
  assign carry10_5 = carry9_3 & sum10_4;
  assign sum10_6 = carry9_4 ^ sum10_5;
  assign carry10_6 = carry9_4 & sum10_5;
  assign sum10_7 = carry9_5 ^ sum10_6;
  assign carry10_7 = carry9_5 & sum10_6;
  assign sum10_8 = carry9_6 ^ sum10_7;
  assign carry10_8 = carry9_6 & sum10_7;
  assign sum10_9 = carry9_7 ^ sum10_8;
  assign carry10_9 = carry9_7 & sum10_8;
  assign sum10_10 = carry9_8 ^ sum10_9;
  assign carry10_10 = carry9_8 & sum10_9;
  assign sum10_11 = carry9_9 ^ sum10_10;
  assign carry10_11 = carry9_9 & sum10_10;
  assign sum10_12 = carry9_10 ^ sum10_11;
  assign carry10_12 = carry9_10 & sum10_11;
  assign sum10_13 = carry9_11 ^ sum10_12;
  assign carry10_13 = carry9_11 & sum10_12;
  assign sum10_14 = carry9_12 ^ sum10_13;
  assign carry10_14 = carry9_12 & sum10_13;
  assign sum10_15 = carry9_13 ^ sum10_14;
  assign carry10_15 = carry9_13 & sum10_14;
  assign sum10_16 = carry9_14 ^ sum10_15;
  assign carry10_16 = carry9_14 & sum10_15;
  assign sum10_17 = carry9_15 ^ sum10_16;
  assign carry10_17 = carry9_15 & sum10_16;
  assign sum10_18 = carry9_16 ^ sum10_17;
  assign carry10_18 = carry9_16 & sum10_17;
  assign sum10_19 = carry9_17 ^ sum10_18;
  assign carry10_19 = carry9_17 & sum10_18;
  assign sum10_20 = carry9_18 ^ sum10_19;
  assign carry10_20 = carry9_18 & sum10_19;
  assign sum10_21 = carry9_19 ^ sum10_20;
  assign carry10_21 = carry9_19 & sum10_20;
  assign sum10_22 = carry9_20 ^ sum10_21;
  assign carry10_22 = carry9_20 & sum10_21;
  assign sum10_23 = carry9_21 ^ sum10_22;
  assign carry10_23 = carry9_21 & sum10_22;
  assign sum10_24 = carry9_22 ^ sum10_23;
  assign carry10_24 = carry9_22 & sum10_23;
  assign sum10_25 = carry9_23 ^ sum10_24;
  assign carry10_25 = carry9_23 & sum10_24;
  assign sum10_26 = carry9_24 ^ sum10_25;
  assign carry10_26 = carry9_24 & sum10_25;
  assign sum10_27 = carry9_25 ^ sum10_26;
  assign carry10_27 = carry9_25 & sum10_26;
  assign sum10_28 = carry9_26 ^ sum10_27;
  assign carry10_28 = carry9_26 & sum10_27;
  assign sum10_29 = carry9_27 ^ sum10_28;
  assign carry10_29 = carry9_27 & sum10_28;
  assign sum10_30 = carry9_28 ^ sum10_29;
  assign carry10_30 = carry9_28 & sum10_29;
  assign sum10_31 = carry9_29 ^ sum10_30;
  assign carry10_31 = carry9_29 & sum10_30;
  assign sum10_32 = carry9_30 ^ sum10_31;
  assign carry10_32 = carry9_30 & sum10_31;
  assign sum10_33 = carry9_31 ^ sum10_32;
  assign carry10_33 = carry9_31 & sum10_32;
  assign sum10_34 = carry9_32 ^ sum10_33;
  assign carry10_34 = carry9_32 & sum10_33;
  assign P[10] = sum10_34;
  assign PP_56 = A[5] & B[6];
  assign PP_65 = A[6] & B[5];
  assign sum11_0 = PP_56 ^ PP_65;
  assign carry11_0 = PP_56 & PP_65;
  assign sum11_1 = carry10_0 ^ sum11_0;
  assign carry11_1 = carry10_0 & sum11_0;
  assign sum11_2 = carry10_1 ^ sum11_1;
  assign carry11_2 = carry10_1 & sum11_1;
  assign sum11_3 = carry10_2 ^ sum11_2;
  assign carry11_3 = carry10_2 & sum11_2;
  assign sum11_4 = carry10_3 ^ sum11_3;
  assign carry11_4 = carry10_3 & sum11_3;
  assign sum11_5 = carry10_4 ^ sum11_4;
  assign carry11_5 = carry10_4 & sum11_4;
  assign sum11_6 = carry10_5 ^ sum11_5;
  assign carry11_6 = carry10_5 & sum11_5;
  assign sum11_7 = carry10_6 ^ sum11_6;
  assign carry11_7 = carry10_6 & sum11_6;
  assign sum11_8 = carry10_7 ^ sum11_7;
  assign carry11_8 = carry10_7 & sum11_7;
  assign sum11_9 = carry10_8 ^ sum11_8;
  assign carry11_9 = carry10_8 & sum11_8;
  assign sum11_10 = carry10_9 ^ sum11_9;
  assign carry11_10 = carry10_9 & sum11_9;
  assign sum11_11 = carry10_10 ^ sum11_10;
  assign carry11_11 = carry10_10 & sum11_10;
  assign sum11_12 = carry10_11 ^ sum11_11;
  assign carry11_12 = carry10_11 & sum11_11;
  assign sum11_13 = carry10_12 ^ sum11_12;
  assign carry11_13 = carry10_12 & sum11_12;
  assign sum11_14 = carry10_13 ^ sum11_13;
  assign carry11_14 = carry10_13 & sum11_13;
  assign sum11_15 = carry10_14 ^ sum11_14;
  assign carry11_15 = carry10_14 & sum11_14;
  assign sum11_16 = carry10_15 ^ sum11_15;
  assign carry11_16 = carry10_15 & sum11_15;
  assign sum11_17 = carry10_16 ^ sum11_16;
  assign carry11_17 = carry10_16 & sum11_16;
  assign sum11_18 = carry10_17 ^ sum11_17;
  assign carry11_18 = carry10_17 & sum11_17;
  assign sum11_19 = carry10_18 ^ sum11_18;
  assign carry11_19 = carry10_18 & sum11_18;
  assign sum11_20 = carry10_19 ^ sum11_19;
  assign carry11_20 = carry10_19 & sum11_19;
  assign sum11_21 = carry10_20 ^ sum11_20;
  assign carry11_21 = carry10_20 & sum11_20;
  assign sum11_22 = carry10_21 ^ sum11_21;
  assign carry11_22 = carry10_21 & sum11_21;
  assign sum11_23 = carry10_22 ^ sum11_22;
  assign carry11_23 = carry10_22 & sum11_22;
  assign sum11_24 = carry10_23 ^ sum11_23;
  assign carry11_24 = carry10_23 & sum11_23;
  assign sum11_25 = carry10_24 ^ sum11_24;
  assign carry11_25 = carry10_24 & sum11_24;
  assign sum11_26 = carry10_25 ^ sum11_25;
  assign carry11_26 = carry10_25 & sum11_25;
  assign sum11_27 = carry10_26 ^ sum11_26;
  assign carry11_27 = carry10_26 & sum11_26;
  assign sum11_28 = carry10_27 ^ sum11_27;
  assign carry11_28 = carry10_27 & sum11_27;
  assign sum11_29 = carry10_28 ^ sum11_28;
  assign carry11_29 = carry10_28 & sum11_28;
  assign sum11_30 = carry10_29 ^ sum11_29;
  assign carry11_30 = carry10_29 & sum11_29;
  assign sum11_31 = carry10_30 ^ sum11_30;
  assign carry11_31 = carry10_30 & sum11_30;
  assign sum11_32 = carry10_31 ^ sum11_31;
  assign carry11_32 = carry10_31 & sum11_31;
  assign sum11_33 = carry10_32 ^ sum11_32;
  assign carry11_33 = carry10_32 & sum11_32;
  assign sum11_34 = carry10_33 ^ sum11_33;
  assign carry11_34 = carry10_33 & sum11_33;
  assign sum11_35 = carry10_34 ^ sum11_34;
  assign carry11_35 = carry10_34 & sum11_34;
  assign P[11] = sum11_35;
  assign PP_66 = A[6] & B[6];
  assign sum12_0 = PP_66 ^ carry11_0;
  assign carry12_0 = PP_66 & carry11_0;
  assign sum12_1 = sum12_0 ^ carry11_1;
  assign carry12_1 = sum12_0 & carry11_1;
  assign sum12_2 = sum12_1 ^ carry11_2;
  assign carry12_2 = sum12_1 & carry11_2;
  assign sum12_3 = sum12_2 ^ carry11_3;
  assign carry12_3 = sum12_2 & carry11_3;
  assign sum12_4 = sum12_3 ^ carry11_4;
  assign carry12_4 = sum12_3 & carry11_4;
  assign sum12_5 = sum12_4 ^ carry11_5;
  assign carry12_5 = sum12_4 & carry11_5;
  assign sum12_6 = sum12_5 ^ carry11_6;
  assign carry12_6 = sum12_5 & carry11_6;
  assign sum12_7 = sum12_6 ^ carry11_7;
  assign carry12_7 = sum12_6 & carry11_7;
  assign sum12_8 = sum12_7 ^ carry11_8;
  assign carry12_8 = sum12_7 & carry11_8;
  assign sum12_9 = sum12_8 ^ carry11_9;
  assign carry12_9 = sum12_8 & carry11_9;
  assign sum12_10 = sum12_9 ^ carry11_10;
  assign carry12_10 = sum12_9 & carry11_10;
  assign sum12_11 = sum12_10 ^ carry11_11;
  assign carry12_11 = sum12_10 & carry11_11;
  assign sum12_12 = sum12_11 ^ carry11_12;
  assign carry12_12 = sum12_11 & carry11_12;
  assign sum12_13 = sum12_12 ^ carry11_13;
  assign carry12_13 = sum12_12 & carry11_13;
  assign sum12_14 = sum12_13 ^ carry11_14;
  assign carry12_14 = sum12_13 & carry11_14;
  assign sum12_15 = sum12_14 ^ carry11_15;
  assign carry12_15 = sum12_14 & carry11_15;
  assign sum12_16 = sum12_15 ^ carry11_16;
  assign carry12_16 = sum12_15 & carry11_16;
  assign sum12_17 = sum12_16 ^ carry11_17;
  assign carry12_17 = sum12_16 & carry11_17;
  assign sum12_18 = sum12_17 ^ carry11_18;
  assign carry12_18 = sum12_17 & carry11_18;
  assign sum12_19 = sum12_18 ^ carry11_19;
  assign carry12_19 = sum12_18 & carry11_19;
  assign sum12_20 = sum12_19 ^ carry11_20;
  assign carry12_20 = sum12_19 & carry11_20;
  assign sum12_21 = sum12_20 ^ carry11_21;
  assign carry12_21 = sum12_20 & carry11_21;
  assign sum12_22 = sum12_21 ^ carry11_22;
  assign carry12_22 = sum12_21 & carry11_22;
  assign sum12_23 = sum12_22 ^ carry11_23;
  assign carry12_23 = sum12_22 & carry11_23;
  assign sum12_24 = sum12_23 ^ carry11_24;
  assign carry12_24 = sum12_23 & carry11_24;
  assign sum12_25 = sum12_24 ^ carry11_25;
  assign carry12_25 = sum12_24 & carry11_25;
  assign sum12_26 = sum12_25 ^ carry11_26;
  assign carry12_26 = sum12_25 & carry11_26;
  assign sum12_27 = sum12_26 ^ carry11_27;
  assign carry12_27 = sum12_26 & carry11_27;
  assign sum12_28 = sum12_27 ^ carry11_28;
  assign carry12_28 = sum12_27 & carry11_28;
  assign sum12_29 = sum12_28 ^ carry11_29;
  assign carry12_29 = sum12_28 & carry11_29;
  assign sum12_30 = sum12_29 ^ carry11_30;
  assign carry12_30 = sum12_29 & carry11_30;
  assign sum12_31 = sum12_30 ^ carry11_31;
  assign carry12_31 = sum12_30 & carry11_31;
  assign sum12_32 = sum12_31 ^ carry11_32;
  assign carry12_32 = sum12_31 & carry11_32;
  assign sum12_33 = sum12_32 ^ carry11_33;
  assign carry12_33 = sum12_32 & carry11_33;
  assign sum12_34 = sum12_33 ^ carry11_34;
  assign carry12_34 = sum12_33 & carry11_34;
  assign sum12_35 = sum12_34 ^ carry11_35;
  assign carry12_35 = sum12_34 & carry11_35;
  assign P[12] = sum12_35;
  assign P[13] = carry12_0 | carry12_1 | carry12_2 | carry12_3 | carry12_4 | carry12_5 | carry12_6 | carry12_7 | carry12_8 | carry12_9 | carry12_10 | carry12_11 | carry12_12 | carry12_13 | carry12_14 | carry12_15 | carry12_16 | carry12_17 | carry12_18 | carry12_19 | carry12_20 | carry12_21 | carry12_22 | carry12_23 | carry12_24 | carry12_25 | carry12_26 | carry12_27 | carry12_28 | carry12_29 | carry12_30 | carry12_31 | carry12_32 | carry12_33 | carry12_34 | carry12_35;

endmodule

module exact_nr_4x2
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

module exact_nr_5x3
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

module exact_nr_2x4
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

module exact_nr_1x2
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

module exact_nr_2x1
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

module exact_nr_1x5
(
  input [0:0] A,
  input [4:0] B,
  output [4:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign P[1] = PP_01;
  assign PP_02 = A[0] & B[2];
  assign P[2] = PP_02;
  assign PP_03 = A[0] & B[3];
  assign P[3] = PP_03;
  assign PP_04 = A[0] & B[4];
  assign P[4] = PP_04;

endmodule

module exact_nr_6x1
(
  input [5:0] A,
  input [0:0] B,
  output [5:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_10 = A[1] & B[0];
  assign P[1] = PP_10;
  assign PP_20 = A[2] & B[0];
  assign P[2] = PP_20;
  assign PP_30 = A[3] & B[0];
  assign P[3] = PP_30;
  assign PP_40 = A[4] & B[0];
  assign P[4] = PP_40;
  assign PP_50 = A[5] & B[0];
  assign P[5] = PP_50;

endmodule

module exact_nr_3x2
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

module exact_nr_4x1
(
  input [3:0] A,
  input [0:0] B,
  output [3:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_10 = A[1] & B[0];
  assign P[1] = PP_10;
  assign PP_20 = A[2] & B[0];
  assign P[2] = PP_20;
  assign PP_30 = A[3] & B[0];
  assign P[3] = PP_30;

endmodule

module exact_nr_3x5
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

module exact_nr_5x2
(
  input [4:0] A,
  input [1:0] B,
  output [6:0] P
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
  assign sum5_0 = PP_41 ^ carry4_0;
  assign carry5_0 = PP_41 & carry4_0;
  assign sum5_1 = sum5_0 ^ carry4_1;
  assign carry5_1 = sum5_0 & carry4_1;
  assign sum5_2 = sum5_1 ^ carry4_2;
  assign carry5_2 = sum5_1 & carry4_2;
  assign sum5_3 = sum5_2 ^ carry4_3;
  assign carry5_3 = sum5_2 & carry4_3;
  assign P[5] = sum5_3;
  assign P[6] = carry5_0 | carry5_1 | carry5_2 | carry5_3;

endmodule

module exact_nr_4x4
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

module exact_nr_5x5
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

module exact_nr_1x1
(
  input [0:0] A,
  input [0:0] B,
  output [0:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;

endmodule

module exact_nr_1x4
(
  input [0:0] A,
  input [3:0] B,
  output [3:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign P[1] = PP_01;
  assign PP_02 = A[0] & B[2];
  assign P[2] = PP_02;
  assign PP_03 = A[0] & B[3];
  assign P[3] = PP_03;

endmodule

module exact_nr_2x3
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

module exact_nr_1x7
(
  input [0:0] A,
  input [6:0] B,
  output [6:0] P
);

  assign PP_00 = A[0] & B[0];
  assign P[0] = PP_00;
  assign PP_01 = A[0] & B[1];
  assign P[1] = PP_01;
  assign PP_02 = A[0] & B[2];
  assign P[2] = PP_02;
  assign PP_03 = A[0] & B[3];
  assign P[3] = PP_03;
  assign PP_04 = A[0] & B[4];
  assign P[4] = PP_04;
  assign PP_05 = A[0] & B[5];
  assign P[5] = PP_05;
  assign PP_06 = A[0] & B[6];
  assign P[6] = PP_06;

endmodule

module exact_nr_2x6
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

module exact_nr_6x6
(
  input [5:0] A,
  input [5:0] B,
  output [11:0] P
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
  assign PP_05 = A[0] & B[5];
  assign PP_14 = A[1] & B[4];
  assign PP_23 = A[2] & B[3];
  assign PP_32 = A[3] & B[2];
  assign PP_41 = A[4] & B[1];
  assign PP_50 = A[5] & B[0];
  assign sum5_0 = PP_05 ^ PP_14;
  assign carry5_0 = PP_05 & PP_14;
  assign sum5_1 = PP_23 ^ sum5_0;
  assign carry5_1 = PP_23 & sum5_0;
  assign sum5_2 = PP_32 ^ sum5_1;
  assign carry5_2 = PP_32 & sum5_1;
  assign sum5_3 = PP_41 ^ sum5_2;
  assign carry5_3 = PP_41 & sum5_2;
  assign sum5_4 = PP_50 ^ sum5_3;
  assign carry5_4 = PP_50 & sum5_3;
  assign sum5_5 = carry4_0 ^ sum5_4;
  assign carry5_5 = carry4_0 & sum5_4;
  assign sum5_6 = carry4_1 ^ sum5_5;
  assign carry5_6 = carry4_1 & sum5_5;
  assign sum5_7 = carry4_2 ^ sum5_6;
  assign carry5_7 = carry4_2 & sum5_6;
  assign sum5_8 = carry4_3 ^ sum5_7;
  assign carry5_8 = carry4_3 & sum5_7;
  assign sum5_9 = carry4_4 ^ sum5_8;
  assign carry5_9 = carry4_4 & sum5_8;
  assign sum5_10 = carry4_5 ^ sum5_9;
  assign carry5_10 = carry4_5 & sum5_9;
  assign sum5_11 = carry4_6 ^ sum5_10;
  assign carry5_11 = carry4_6 & sum5_10;
  assign sum5_12 = carry4_7 ^ sum5_11;
  assign carry5_12 = carry4_7 & sum5_11;
  assign sum5_13 = carry4_8 ^ sum5_12;
  assign carry5_13 = carry4_8 & sum5_12;
  assign sum5_14 = carry4_9 ^ sum5_13;
  assign carry5_14 = carry4_9 & sum5_13;
  assign P[5] = sum5_14;
  assign PP_15 = A[1] & B[5];
  assign PP_24 = A[2] & B[4];
  assign PP_33 = A[3] & B[3];
  assign PP_42 = A[4] & B[2];
  assign PP_51 = A[5] & B[1];
  assign sum6_0 = PP_15 ^ PP_24;
  assign carry6_0 = PP_15 & PP_24;
  assign sum6_1 = PP_33 ^ sum6_0;
  assign carry6_1 = PP_33 & sum6_0;
  assign sum6_2 = PP_42 ^ sum6_1;
  assign carry6_2 = PP_42 & sum6_1;
  assign sum6_3 = PP_51 ^ sum6_2;
  assign carry6_3 = PP_51 & sum6_2;
  assign sum6_4 = carry5_0 ^ sum6_3;
  assign carry6_4 = carry5_0 & sum6_3;
  assign sum6_5 = carry5_1 ^ sum6_4;
  assign carry6_5 = carry5_1 & sum6_4;
  assign sum6_6 = carry5_2 ^ sum6_5;
  assign carry6_6 = carry5_2 & sum6_5;
  assign sum6_7 = carry5_3 ^ sum6_6;
  assign carry6_7 = carry5_3 & sum6_6;
  assign sum6_8 = carry5_4 ^ sum6_7;
  assign carry6_8 = carry5_4 & sum6_7;
  assign sum6_9 = carry5_5 ^ sum6_8;
  assign carry6_9 = carry5_5 & sum6_8;
  assign sum6_10 = carry5_6 ^ sum6_9;
  assign carry6_10 = carry5_6 & sum6_9;
  assign sum6_11 = carry5_7 ^ sum6_10;
  assign carry6_11 = carry5_7 & sum6_10;
  assign sum6_12 = carry5_8 ^ sum6_11;
  assign carry6_12 = carry5_8 & sum6_11;
  assign sum6_13 = carry5_9 ^ sum6_12;
  assign carry6_13 = carry5_9 & sum6_12;
  assign sum6_14 = carry5_10 ^ sum6_13;
  assign carry6_14 = carry5_10 & sum6_13;
  assign sum6_15 = carry5_11 ^ sum6_14;
  assign carry6_15 = carry5_11 & sum6_14;
  assign sum6_16 = carry5_12 ^ sum6_15;
  assign carry6_16 = carry5_12 & sum6_15;
  assign sum6_17 = carry5_13 ^ sum6_16;
  assign carry6_17 = carry5_13 & sum6_16;
  assign sum6_18 = carry5_14 ^ sum6_17;
  assign carry6_18 = carry5_14 & sum6_17;
  assign P[6] = sum6_18;
  assign PP_25 = A[2] & B[5];
  assign PP_34 = A[3] & B[4];
  assign PP_43 = A[4] & B[3];
  assign PP_52 = A[5] & B[2];
  assign sum7_0 = PP_25 ^ PP_34;
  assign carry7_0 = PP_25 & PP_34;
  assign sum7_1 = PP_43 ^ sum7_0;
  assign carry7_1 = PP_43 & sum7_0;
  assign sum7_2 = PP_52 ^ sum7_1;
  assign carry7_2 = PP_52 & sum7_1;
  assign sum7_3 = carry6_0 ^ sum7_2;
  assign carry7_3 = carry6_0 & sum7_2;
  assign sum7_4 = carry6_1 ^ sum7_3;
  assign carry7_4 = carry6_1 & sum7_3;
  assign sum7_5 = carry6_2 ^ sum7_4;
  assign carry7_5 = carry6_2 & sum7_4;
  assign sum7_6 = carry6_3 ^ sum7_5;
  assign carry7_6 = carry6_3 & sum7_5;
  assign sum7_7 = carry6_4 ^ sum7_6;
  assign carry7_7 = carry6_4 & sum7_6;
  assign sum7_8 = carry6_5 ^ sum7_7;
  assign carry7_8 = carry6_5 & sum7_7;
  assign sum7_9 = carry6_6 ^ sum7_8;
  assign carry7_9 = carry6_6 & sum7_8;
  assign sum7_10 = carry6_7 ^ sum7_9;
  assign carry7_10 = carry6_7 & sum7_9;
  assign sum7_11 = carry6_8 ^ sum7_10;
  assign carry7_11 = carry6_8 & sum7_10;
  assign sum7_12 = carry6_9 ^ sum7_11;
  assign carry7_12 = carry6_9 & sum7_11;
  assign sum7_13 = carry6_10 ^ sum7_12;
  assign carry7_13 = carry6_10 & sum7_12;
  assign sum7_14 = carry6_11 ^ sum7_13;
  assign carry7_14 = carry6_11 & sum7_13;
  assign sum7_15 = carry6_12 ^ sum7_14;
  assign carry7_15 = carry6_12 & sum7_14;
  assign sum7_16 = carry6_13 ^ sum7_15;
  assign carry7_16 = carry6_13 & sum7_15;
  assign sum7_17 = carry6_14 ^ sum7_16;
  assign carry7_17 = carry6_14 & sum7_16;
  assign sum7_18 = carry6_15 ^ sum7_17;
  assign carry7_18 = carry6_15 & sum7_17;
  assign sum7_19 = carry6_16 ^ sum7_18;
  assign carry7_19 = carry6_16 & sum7_18;
  assign sum7_20 = carry6_17 ^ sum7_19;
  assign carry7_20 = carry6_17 & sum7_19;
  assign sum7_21 = carry6_18 ^ sum7_20;
  assign carry7_21 = carry6_18 & sum7_20;
  assign P[7] = sum7_21;
  assign PP_35 = A[3] & B[5];
  assign PP_44 = A[4] & B[4];
  assign PP_53 = A[5] & B[3];
  assign sum8_0 = PP_35 ^ PP_44;
  assign carry8_0 = PP_35 & PP_44;
  assign sum8_1 = PP_53 ^ sum8_0;
  assign carry8_1 = PP_53 & sum8_0;
  assign sum8_2 = carry7_0 ^ sum8_1;
  assign carry8_2 = carry7_0 & sum8_1;
  assign sum8_3 = carry7_1 ^ sum8_2;
  assign carry8_3 = carry7_1 & sum8_2;
  assign sum8_4 = carry7_2 ^ sum8_3;
  assign carry8_4 = carry7_2 & sum8_3;
  assign sum8_5 = carry7_3 ^ sum8_4;
  assign carry8_5 = carry7_3 & sum8_4;
  assign sum8_6 = carry7_4 ^ sum8_5;
  assign carry8_6 = carry7_4 & sum8_5;
  assign sum8_7 = carry7_5 ^ sum8_6;
  assign carry8_7 = carry7_5 & sum8_6;
  assign sum8_8 = carry7_6 ^ sum8_7;
  assign carry8_8 = carry7_6 & sum8_7;
  assign sum8_9 = carry7_7 ^ sum8_8;
  assign carry8_9 = carry7_7 & sum8_8;
  assign sum8_10 = carry7_8 ^ sum8_9;
  assign carry8_10 = carry7_8 & sum8_9;
  assign sum8_11 = carry7_9 ^ sum8_10;
  assign carry8_11 = carry7_9 & sum8_10;
  assign sum8_12 = carry7_10 ^ sum8_11;
  assign carry8_12 = carry7_10 & sum8_11;
  assign sum8_13 = carry7_11 ^ sum8_12;
  assign carry8_13 = carry7_11 & sum8_12;
  assign sum8_14 = carry7_12 ^ sum8_13;
  assign carry8_14 = carry7_12 & sum8_13;
  assign sum8_15 = carry7_13 ^ sum8_14;
  assign carry8_15 = carry7_13 & sum8_14;
  assign sum8_16 = carry7_14 ^ sum8_15;
  assign carry8_16 = carry7_14 & sum8_15;
  assign sum8_17 = carry7_15 ^ sum8_16;
  assign carry8_17 = carry7_15 & sum8_16;
  assign sum8_18 = carry7_16 ^ sum8_17;
  assign carry8_18 = carry7_16 & sum8_17;
  assign sum8_19 = carry7_17 ^ sum8_18;
  assign carry8_19 = carry7_17 & sum8_18;
  assign sum8_20 = carry7_18 ^ sum8_19;
  assign carry8_20 = carry7_18 & sum8_19;
  assign sum8_21 = carry7_19 ^ sum8_20;
  assign carry8_21 = carry7_19 & sum8_20;
  assign sum8_22 = carry7_20 ^ sum8_21;
  assign carry8_22 = carry7_20 & sum8_21;
  assign sum8_23 = carry7_21 ^ sum8_22;
  assign carry8_23 = carry7_21 & sum8_22;
  assign P[8] = sum8_23;
  assign PP_45 = A[4] & B[5];
  assign PP_54 = A[5] & B[4];
  assign sum9_0 = PP_45 ^ PP_54;
  assign carry9_0 = PP_45 & PP_54;
  assign sum9_1 = carry8_0 ^ sum9_0;
  assign carry9_1 = carry8_0 & sum9_0;
  assign sum9_2 = carry8_1 ^ sum9_1;
  assign carry9_2 = carry8_1 & sum9_1;
  assign sum9_3 = carry8_2 ^ sum9_2;
  assign carry9_3 = carry8_2 & sum9_2;
  assign sum9_4 = carry8_3 ^ sum9_3;
  assign carry9_4 = carry8_3 & sum9_3;
  assign sum9_5 = carry8_4 ^ sum9_4;
  assign carry9_5 = carry8_4 & sum9_4;
  assign sum9_6 = carry8_5 ^ sum9_5;
  assign carry9_6 = carry8_5 & sum9_5;
  assign sum9_7 = carry8_6 ^ sum9_6;
  assign carry9_7 = carry8_6 & sum9_6;
  assign sum9_8 = carry8_7 ^ sum9_7;
  assign carry9_8 = carry8_7 & sum9_7;
  assign sum9_9 = carry8_8 ^ sum9_8;
  assign carry9_9 = carry8_8 & sum9_8;
  assign sum9_10 = carry8_9 ^ sum9_9;
  assign carry9_10 = carry8_9 & sum9_9;
  assign sum9_11 = carry8_10 ^ sum9_10;
  assign carry9_11 = carry8_10 & sum9_10;
  assign sum9_12 = carry8_11 ^ sum9_11;
  assign carry9_12 = carry8_11 & sum9_11;
  assign sum9_13 = carry8_12 ^ sum9_12;
  assign carry9_13 = carry8_12 & sum9_12;
  assign sum9_14 = carry8_13 ^ sum9_13;
  assign carry9_14 = carry8_13 & sum9_13;
  assign sum9_15 = carry8_14 ^ sum9_14;
  assign carry9_15 = carry8_14 & sum9_14;
  assign sum9_16 = carry8_15 ^ sum9_15;
  assign carry9_16 = carry8_15 & sum9_15;
  assign sum9_17 = carry8_16 ^ sum9_16;
  assign carry9_17 = carry8_16 & sum9_16;
  assign sum9_18 = carry8_17 ^ sum9_17;
  assign carry9_18 = carry8_17 & sum9_17;
  assign sum9_19 = carry8_18 ^ sum9_18;
  assign carry9_19 = carry8_18 & sum9_18;
  assign sum9_20 = carry8_19 ^ sum9_19;
  assign carry9_20 = carry8_19 & sum9_19;
  assign sum9_21 = carry8_20 ^ sum9_20;
  assign carry9_21 = carry8_20 & sum9_20;
  assign sum9_22 = carry8_21 ^ sum9_21;
  assign carry9_22 = carry8_21 & sum9_21;
  assign sum9_23 = carry8_22 ^ sum9_22;
  assign carry9_23 = carry8_22 & sum9_22;
  assign sum9_24 = carry8_23 ^ sum9_23;
  assign carry9_24 = carry8_23 & sum9_23;
  assign P[9] = sum9_24;
  assign PP_55 = A[5] & B[5];
  assign sum10_0 = PP_55 ^ carry9_0;
  assign carry10_0 = PP_55 & carry9_0;
  assign sum10_1 = sum10_0 ^ carry9_1;
  assign carry10_1 = sum10_0 & carry9_1;
  assign sum10_2 = sum10_1 ^ carry9_2;
  assign carry10_2 = sum10_1 & carry9_2;
  assign sum10_3 = sum10_2 ^ carry9_3;
  assign carry10_3 = sum10_2 & carry9_3;
  assign sum10_4 = sum10_3 ^ carry9_4;
  assign carry10_4 = sum10_3 & carry9_4;
  assign sum10_5 = sum10_4 ^ carry9_5;
  assign carry10_5 = sum10_4 & carry9_5;
  assign sum10_6 = sum10_5 ^ carry9_6;
  assign carry10_6 = sum10_5 & carry9_6;
  assign sum10_7 = sum10_6 ^ carry9_7;
  assign carry10_7 = sum10_6 & carry9_7;
  assign sum10_8 = sum10_7 ^ carry9_8;
  assign carry10_8 = sum10_7 & carry9_8;
  assign sum10_9 = sum10_8 ^ carry9_9;
  assign carry10_9 = sum10_8 & carry9_9;
  assign sum10_10 = sum10_9 ^ carry9_10;
  assign carry10_10 = sum10_9 & carry9_10;
  assign sum10_11 = sum10_10 ^ carry9_11;
  assign carry10_11 = sum10_10 & carry9_11;
  assign sum10_12 = sum10_11 ^ carry9_12;
  assign carry10_12 = sum10_11 & carry9_12;
  assign sum10_13 = sum10_12 ^ carry9_13;
  assign carry10_13 = sum10_12 & carry9_13;
  assign sum10_14 = sum10_13 ^ carry9_14;
  assign carry10_14 = sum10_13 & carry9_14;
  assign sum10_15 = sum10_14 ^ carry9_15;
  assign carry10_15 = sum10_14 & carry9_15;
  assign sum10_16 = sum10_15 ^ carry9_16;
  assign carry10_16 = sum10_15 & carry9_16;
  assign sum10_17 = sum10_16 ^ carry9_17;
  assign carry10_17 = sum10_16 & carry9_17;
  assign sum10_18 = sum10_17 ^ carry9_18;
  assign carry10_18 = sum10_17 & carry9_18;
  assign sum10_19 = sum10_18 ^ carry9_19;
  assign carry10_19 = sum10_18 & carry9_19;
  assign sum10_20 = sum10_19 ^ carry9_20;
  assign carry10_20 = sum10_19 & carry9_20;
  assign sum10_21 = sum10_20 ^ carry9_21;
  assign carry10_21 = sum10_20 & carry9_21;
  assign sum10_22 = sum10_21 ^ carry9_22;
  assign carry10_22 = sum10_21 & carry9_22;
  assign sum10_23 = sum10_22 ^ carry9_23;
  assign carry10_23 = sum10_22 & carry9_23;
  assign sum10_24 = sum10_23 ^ carry9_24;
  assign carry10_24 = sum10_23 & carry9_24;
  assign P[10] = sum10_24;
  assign P[11] = carry10_0 | carry10_1 | carry10_2 | carry10_3 | carry10_4 | carry10_5 | carry10_6 | carry10_7 | carry10_8 | carry10_9 | carry10_10 | carry10_11 | carry10_12 | carry10_13 | carry10_14 | carry10_15 | carry10_16 | carry10_17 | carry10_18 | carry10_19 | carry10_20 | carry10_21 | carry10_22 | carry10_23 | carry10_24;

endmodule

        module exact_rr8x8__B__rr7x7__B__rr5x5__B__nr2x2__nr2x3__nr3x2__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__B__nr5x2__nr2x5__nr2x2__B__nr7x1__nr1x7__nr1x1__B__(
            input [7:0] A, 
            input [7:0] B, 
            output [15:0] P
        );
            // _AH__   _____AL___________ 
            // _BH__   _____BL___________ 
            // Lower bits are given to Higher part of bits, the other orientation is not considered
            wire [6:0] A_H, B_H;
            wire [0:0] A_L, B_L;
            
            assign A_H = A[7:1];
            assign B_H = B[7:1];
            assign A_L = A[0:0];
            assign B_L = B[0:0];
            
            wire [13:0] P1;
            wire [7:0] P2, P3;
            wire [1:0] P4;
            
            exact_rr_7x7 M1(.A(A_H), .B(B_H), .P(P1));
            exact_nr_7x1 M2(.A(A_H), .B(B_L), .P(P2));
            exact_nr_1x7 M3(.A(A_L), .B(B_H), .P(P3));
            exact_nr_1x1 M4(.A(A_L), .B(B_L), .P(P4));
            
            assign P = (P1 << 2) + (P3 << 1) + (P2 << 1) + P4;
        endmodule
        
        module exact_rr_7x7(
            input [6:0] A, 
            input [6:0] B, 
            output [13:0] P
        );
            // _AH__   _____AL___________ 
            // _BH__   _____BL___________ 
            // Lower bits are given to Higher part of bits, the other orientation is not considered
            wire [4:0] A_H, B_H;
            wire [1:0] A_L, B_L;
            
            assign A_H = A[6:2];
            assign B_H = B[6:2];
            assign A_L = A[1:0];
            assign B_L = B[1:0];
            
            wire [9:0] P1;
            wire [6:0] P2, P3;
            wire [3:0] P4;
            
            exact_rr_5x5 M1(.A(A_H), .B(B_H), .P(P1));
            exact_nr_5x2 M2(.A(A_H), .B(B_L), .P(P2));
            exact_nr_2x5 M3(.A(A_L), .B(B_H), .P(P3));
            exact_nr_2x2 M4(.A(A_L), .B(B_L), .P(P4));
            
            assign P = (P1 << 4) + (P3 << 2) + (P2 << 2) + P4;
        endmodule
        
        module exact_rr_5x5(
            input [4:0] A, 
            input [4:0] B, 
            output [9:0] P
        );
            // _AH__   _____AL___________ 
            // _BH__   _____BL___________ 
            // Lower bits are given to Higher part of bits, the other orientation is not considered
            wire [1:0] A_H, B_H;
            wire [2:0] A_L, B_L;
            
            assign A_H = A[4:3];
            assign B_H = B[4:3];
            assign A_L = A[2:0];
            assign B_L = B[2:0];
            
            wire [3:0] P1;
            wire [4:0] P2, P3;
            wire [5:0] P4;
            
            exact_nr_2x2 M1(.A(A_H), .B(B_H), .P(P1));
            exact_nr_2x3 M2(.A(A_H), .B(B_L), .P(P2));
            exact_nr_3x2 M3(.A(A_L), .B(B_H), .P(P3));
            exact_rr_3x3 M4(.A(A_L), .B(B_L), .P(P4));
            
            assign P = (P1 << 6) + (P3 << 3) + (P2 << 3) + P4;
        endmodule
        
        module exact_rr_3x3(
            input [2:0] A, 
            input [2:0] B, 
            output [5:0] P
        );
            // _AH__   _____AL___________ 
            // _BH__   _____BL___________ 
            // Lower bits are given to Higher part of bits, the other orientation is not considered
            wire [1:0] A_H, B_H;
            wire [0:0] A_L, B_L;
            
            assign A_H = A[2:1];
            assign B_H = B[2:1];
            assign A_L = A[0:0];
            assign B_L = B[0:0];
            
            wire [3:0] P1;
            wire [2:0] P2, P3;
            wire [1:0] P4;
            
            exact_nr_2x2 M1(.A(A_H), .B(B_H), .P(P1));
            exact_nr_2x1 M2(.A(A_H), .B(B_L), .P(P2));
            exact_nr_1x2 M3(.A(A_L), .B(B_H), .P(P3));
            exact_nr_1x1 M4(.A(A_L), .B(B_L), .P(P4));
            
            assign P = (P1 << 2) + (P3 << 1) + (P2 << 1) + P4;
        endmodule
        