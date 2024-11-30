module HA(
    input a, b,
    output sum, carry
);
    assign sum = a ^ b;   
    assign carry = a & b;  
endmodule



module FA(
    input a, b, cin,
    output sum, carry
);
    wire A_xor_B;

    assign A_xor_B = a ^ b;
    assign sum = A_xor_B ^ cin;   
    assign carry = (a & b) | (A_xor_B & cin);  
endmodule



module exact_1x1(input A, input B, output P);
    assign P = A & B;
endmodule


module exact_2x1(
    input [1:0] A, 
    input B,
    output [2:0] P
);
    assign P[0] = A[0] & B ;
    assign P[1] = A[1] & B ;
    assign P[2] = 0;
endmodule


module exact_2x2(input [1:0] A, input [1:0] B, output [3:0] P);

    wire pp0, pp1, pp2, pp3;
    wire s1, c1, c2;

    assign pp0 = A[0] & B[0];
    assign pp1 = A[1] & B[0];
    assign pp2 = A[0] & B[1];
    assign pp3 = A[1] & B[1];

    assign P[0] = pp0;
    HA ha1 (.a(pp1), .b(pp2), .sum(P[1]), .carry(c1));
    HA ha2 (.a(c1), .b(pp3), .sum(P[2]), .carry(c2));
    assign P[3] = c2;

endmodule


module exact_assymetric__3x3(input [2:0] A, input [2:0] B, output [5:0] P);

    wire [1:0] A_H, B_H; wire A_L, B_L;

    assign A_H = A[2:1]; 
    assign A_L = A[0];   
    assign B_H = B[2:1]; 
    assign B_L = B[0];   

    wire [3:0] P4;
    wire [2:0] P2, P3;
    wire P1;

    exact_1x1 M1(.A(A_L), .B(B_L), .P(P1) );
    exact_2x1 M2(.A(A_H), .B(B_L), .P(P2) );
    exact_2x1 M3(.A(B_H), .B(A_L), .P(P3) );
    exact_2x2 M4(.A(B_H), .B(A_H), .P(P4) );

    // I understood this VERY ELEGANT way to shift only after I coded it out LOL !!
    assign P = (P4 << 2) + (P3 << 1 )  +  (P2 << 1 ) + P1 ;

endmodule

// Aliase in verilog
module exact_3x3(input [2:0] A, input [2:0] B, output [5:0] P);
    exact_assymetric__3x3 m(.A(A), .B(B), .P(P));
endmodule


module exact_assymetric__6x6(input [5:0] A, input [5:0] B, output [11:0] P);

    wire [2:0] A_H, B_H, A_L, B_L;

    assign A_H = A[5:3]; 
    assign A_L = A[2:0];   
    assign B_H = B[5:3]; 
    assign B_L = B[2:0];   

    wire [5:0] P1,P2,P3,P4;

    exact_3x3 M1(.A(A_L), .B(B_L), .P(P1) );
    exact_3x3 M2(.A(A_H), .B(B_L), .P(P2) );
    exact_3x3 M3(.A(B_H), .B(A_L), .P(P3) );
    exact_3x3 M4(.A(B_H), .B(A_H), .P(P4) );

    // I understood this VERY ELEGANT way to shift only after I coded it out LOL !!
    assign P = (P4 << 6) + (P3 << 3 )  +  (P2 << 3 ) + P1 ;

endmodule
