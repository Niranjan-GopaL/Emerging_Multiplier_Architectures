module tb_multiplier;

    parameter M = 8;
    parameter N = 8;

    reg [M-1:0] a;
    reg [N-1:0] b;

    wire [M+N-1:0] product;

    exact_symmetric__8x8 uut (
        .A(a),
        .B(b),
        .P(product)
    );

    integer i, j;
    integer total_tests = 0;
    integer mismatches = 0;

    initial begin
        for (i = 0; i < (1 << M); i = i + 1) begin
            for (j = 0; j < (1 << N); j = j + 1) begin
                a = i;
                b = j;
                #2; // Wait for the result to propagate
                $display("At time %t, a = %d, b = %hd product = %d, epected = %d", $time, a, b, product, a*b);
                if (product !== (a * b)) begin
                    mismatches = mismatches + 1;
                end
                total_tests = total_tests + 1;
            end
        end

        $display("Total tests: %d", total_tests);
        $display("Mismatches: %d", mismatches);
        $display("Accuracy: %f%%", 100.0 * (total_tests - mismatches) / total_tests);

        $finish;
    end


endmodule


module exact_symmetric__8x8(
        input [7:0] A, 
        input [7:0] B, 
        output [15:0] P
    );
        // _AH__   _____AL___________ 
        // _BH__   _____BL___________ 
        // Lower bits are given to Higher part of bits, the other orientation is not considered
        wire [1:0] A_H, B_H;
        wire [5:0] A_L, B_L;
        
        assign A_H = A[7:6];
        assign B_H = B[7:6];
        assign A_L = A[5:0];
        assign B_L = B[5:0];
        
        wire [3:0] P1;
        wire [7:0] P2, P3;
        wire [11:0] P4;
        
        exact_2x2 M1(.A(A_H), .B(B_H), .P(P1));
        exact_2x6 M2(.A(A_H), .B(B_L), .P(P2));
        exact_6x2 M3(.A(A_L), .B(B_H), .P(P3));
        exact_6x6 M4(.A(A_L), .B(B_L), .P(P4));
        
        assign P = (P1 << 12) + (P3 << 6) + (P2 << 6) + P4;
    endmodule
    



module exact_6x6
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




module exact_6x2
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




module exact_2x6
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




module exact_2x2
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
