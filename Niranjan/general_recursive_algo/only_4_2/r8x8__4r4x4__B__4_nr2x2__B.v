// Half Adder Module
module HA(
    input A, B,
    output sum, carry
);
    assign sum = A ^ B;   
    assign carry = A & B;  
endmodule



// Full Adder Module
module FA(
    input A, B, cin,
    output sum, carry
);
    wire A_xor_B;

    assign A_xor_B = A ^ B;
    assign sum = A_xor_B ^ cin;   
    assign carry = (A & B) | (A_xor_B & cin);  
endmodule


module nr2x2(input [1:0] A, input [1:0] B, output [3:0] P);

    wire pp0, pp1, pp2, pp3;
    wire s1, c1, c2;

    assign pp0 = A[0] & B[0];
    assign pp1 = A[1] & B[0];
    assign pp2 = A[0] & B[1];
    assign pp3 = A[1] & B[1];

    assign P[0] = pp0;
    HA ha1 (.A(pp1), .B(pp2), .sum(P[1]), .carry(c1));
    HA ha2 (.A(c1), .B(pp3), .sum(P[2]), .carry(c2));
    assign P[3] = c2;

endmodule


module r4x4__B__4_nr2x2__B(
    input [3:0] A, B,  
    output [7:0] P     
);

    wire [1:0] A_H, B_H; 
    wire [1:0] A_L, B_L;

    assign A_H = A[3:2]; 
    assign A_L = A[1:0];   
    assign B_H = B[3:2]; 
    assign B_L = B[1:0];   

    wire [3:0] P4, P2, P3, P1;

    nr2x2 M1(.A(A_L), .B(B_L), .P(P1));
    nr2x2 M2(.A(A_H), .B(B_L), .P(P2));
    nr2x2 M3(.A(B_H), .B(A_L), .P(P3));
    nr2x2 M4(.A(B_H), .B(A_H), .P(P4));

    assign P = (P4 << 4) + (P3 << 2 )  +  (P2 << 2 ) + P1 ;

endmodule


module r8x8__4r4x4__B__4_nr2x2__B(
    input [7:0] A, 
    input [7:0] B, 
    output [15:0] P     
);

    // Internal wires for 4x4 multipliers
    wire [3:0] A_H, B_H; 
    wire [3:0] A_L, B_L;

    assign A_H = A[7:4]; 
    assign A_L = A[3:0];   
    assign B_H = B[7:4]; 
    assign B_L = B[3:0];   

    wire [7:0] P4, P2, P3, P1;
    reg [15:0] P1_reg, P2_shifted, P3_shifted, P4_shifted;

    // Instantiate the 4x4 multipliers
    r4x4__B__4_nr2x2__B M1(.A(A_L), .B(B_L), .P(P1));
    r4x4__B__4_nr2x2__B M2(.A(A_H), .B(B_L), .P(P2));
    r4x4__B__4_nr2x2__B M3(.A(B_H), .B(A_L), .P(P3));
    r4x4__B__4_nr2x2__B M4(.A(B_H), .B(A_H), .P(P4));

    assign P = (P4 << 8) + (P3 << 4 )  +  (P2 << 4 ) + P1 ;

endmodule
