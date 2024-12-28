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


module exact_2x1(
    input [1:0] A, 
    input B,
    output [2:0] P
);
    assign P[0] = A[0] & B ;
    assign P[1] = A[1] & B ;
    assign P[2] = 0;
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



module exact_assymetric__5x5(input [4:0] A, input [4:0] B, output [9:0] P);

    wire [2:0] A_H, B_H; wire [1:0]A_L, B_L;

    assign A_H = A[4:2]; 
    assign A_L = A[1:0];   
    assign B_H = B[4:2]; 
    assign B_L = B[1:0];   

    wire [5:0] P4;
    wire [4:0] P2, P3;
    wire [3:0]P1;

    exact_2x2 M1(.A(A_L), .B(B_L), .P(P1) );
    exact_3x2 M2(.A(A_H), .B(B_L), .P(P2) );
    exact_3x2 M3(.A(B_H), .B(A_L), .P(P3) );
    exact_3x3 M4(.A(B_H), .B(A_H), .P(P4) );

    assign P = (P4 << 4) + (P3 << 2 )  +  (P2 << 2 ) + P1 ;

endmodule


module tb_exact_assymetric__5x5;

    reg [4:0] A, B;
    wire [9:0] P;

    // Instantiate the exact 5x5 multiplier
    exact_assymetric__5x5 uut (
        .A(A),
        .B(B),
        .P(P)
    );


    real accuracy, error_rate;
    integer i, j;
    reg [9:0] expected;
    integer pass_count, fail_count;

    initial begin
        pass_count = 0;
        fail_count = 0;

        $display("A      B      | P          | Expected   | Result");
        $display("-------------------------------------------------");

        // Test all possible combinations of 5x5 inputs
        for (i = 0; i < 32; i = i + 1) begin
            for (j = 0; j < 32; j = j + 1) begin
                A = i;
                B = j;
                #1; // Wait for the combinational logic to settle
                expected = A * B;

                if (P == expected) begin
                    pass_count = pass_count + 1;
                    $display("%b  %b  | %b  | %b      | PASS", A, B, P, expected);
                end else begin
                    fail_count = fail_count + 1;
                    $display("%b  %b  | %b  | %b      | FAIL", A, B, P, expected);
                end
            end
        end
        // Display final accuracy and error rate
        $display("------------------------------------------");
        $display("Total Tests: %d", pass_count + fail_count);
        $display("Pass Count: %d", pass_count);
        $display("Fail Count: %d", fail_count);

        // Calculate and display accuracy and error rate
        accuracy = (pass_count / (pass_count + fail_count)) * 100;
        error_rate = (fail_count / (pass_count + fail_count)) * 100;
        
        $display("Accuracy: %0.2f%%", accuracy);
        $display("Error Rate: %0.2f%%", error_rate);


        $finish;
    end
endmodule
