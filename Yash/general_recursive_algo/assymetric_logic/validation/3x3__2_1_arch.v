
// Utils

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


module exact_2x1( input [1:0] A,  input B, output [2:0] P );
    assign P[0] = A[0] & B ;
    assign P[1] = A[1] & B ;
    assign P[2] = 0;
endmodule


module exact_assymetric_3x3(input [2:0] A, input [2:0] B, output [5:0] P);

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


module tb_exact_assymetric_3x3;
    reg [2:0] A, B;
    wire [5:0] P;

    // Instantiate the 3x3 multiplier
    exact_assymetric_3x3 uut (
        .A(A),
        .B(B),
        .P(P)
    );

    real accuracy, error_rate;
    integer i, j;
    reg [5:0] expected;
    integer pass_count, fail_count;

    initial begin
        // Initialize counters
        pass_count = 0;
        fail_count = 0;

        $display("A      B      | P      | Expected | Result");
        $display("------------------------------------------");

        // Test all possible combinations of 3x3 numbers
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                A = i; 
                B = j; 
                #1; // Wait for the combinational logic to settle
                expected = A * B;

                // Check result
                if (P == expected) begin
                    $display("%b  %b  | %b  | %b      | PASS", A, B, P, expected);
                    pass_count = pass_count + 1;
                end else begin
                    $display("%b  %b  | %b  | %b      | FAIL", A, B, P, expected);
                    fail_count = fail_count + 1;
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
