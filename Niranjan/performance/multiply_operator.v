// What does this synthesis into ?

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

module exact_3x2(
    input [2:0] A, 
    input [1:0] B,
    output [4:0] P
);
    wire pp0, pp1, pp2, pp3, pp4, pp5;
    wire s1, c1, s2, c2, s3, c3, s4;

    // Generate partial products
    assign pp0 = A[0] & B[0];  // A0 * B0
    assign pp1 = A[1] & B[0];  // A1 * B0
    assign pp2 = A[2] & B[0];  // A2 * B0
    assign pp3 = A[0] & B[1];  // A0 * B1
    assign pp4 = A[1] & B[1];  // A1 * B1
    assign pp5 = A[2] & B[1];  // A2 * B1

    assign P[0] = pp0; 
    HA ha1 (.a(pp1), .b(pp3), .sum(P[1]), .carry(c1));
    FA fa  (.a(pp2), .b(pp4), .cin(c1), .sum(P[2]), .carry(c2));
    HA ha2 (.a(c2), .b(pp5),  .sum(P[3]), .carry(P[4]));

endmodule



module exact_3x2_mult_op(
    input [2:0] A, 
    input [1:0] B,
    output [4:0] P
);
    assign P = A * B ;
endmodule