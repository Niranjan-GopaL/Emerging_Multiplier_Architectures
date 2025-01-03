
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

        module exact_rr4x4__B__nr2x2__nr2x2__nr2x2__nr2x2__B__(
            input [3:0] A, 
            input [3:0] B, 
            output [7:0] P
        );
            // _AH__   _____AL___________ 
            // _BH__   _____BL___________ 
            // Lower bits are given to Higher part of bits, the other orientation is not considered
            wire [1:0] A_H, B_H;
            wire [1:0] A_L, B_L;
            
            assign A_H = A[3:2];
            assign B_H = B[3:2];
            assign A_L = A[1:0];
            assign B_L = B[1:0];
            
            wire [3:0] P1;
            wire [3:0] P2, P3;
            wire [3:0] P4;
            
            exact_nr_2x2 M1(.A(A_H), .B(B_H), .P(P1));
            exact_nr_2x2 M2(.A(A_H), .B(B_L), .P(P2));
            exact_nr_2x2 M3(.A(A_L), .B(B_H), .P(P3));
            exact_nr_2x2 M4(.A(A_L), .B(B_L), .P(P4));
            
            assign P = (P1 << 4) + (P3 << 2) + (P2 << 2) + P4;
        endmodule
        