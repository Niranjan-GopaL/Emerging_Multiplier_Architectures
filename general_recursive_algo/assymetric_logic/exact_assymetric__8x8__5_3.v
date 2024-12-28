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

module exact_5x3(
    input [4:0] A, 
    input [2:0] B,
    output [7:0] P
);
    // wire pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9, pp10, pp11, pp12, pp13, pp14;
    // wire s1, c1, s2, c2, s3, c3, s4, c4, s5, c5, s6, c6, s7, c7, s8, c8;

    // assign pp0 = A[0] & B[0];
    // assign pp1 = A[1] & B[0];
    // assign pp2 = A[2] & B[0];
    // assign pp3 = A[3] & B[0];
    // assign pp4 = A[4] & B[0];

    // assign pp5 = A[0] & B[1];
    // assign pp6 = A[1] & B[1];
    // assign pp7 = A[2] & B[1];
    // assign pp8 = A[3] & B[1];
    // assign pp9 = A[4] & B[1];

    // assign pp10 = A[0] & B[2];
    // assign pp11 = A[1] & B[2];
    // assign pp12 = A[2] & B[2];
    // assign pp13 = A[3] & B[2];
    // assign pp14 = A[4] & B[2];

    // // Column-wise addition using HAs and FAs
    // assign P[0] = pp0;

    // HA ha1 (.a(pp1), .b(pp5), .sum(P[1]), .carry(c1));

    // FA fa1 (.a(pp2), .b(pp6), .cin(c1), .sum(P[2]), .carry(c2));
    // FA fa2 (.a(pp3), .b(pp7), .cin(c2), .sum(s3), .carry(c4));
    // FA fa3 (.a(s3), .b(c2), .cin(c3), .sum(P[3]), .carry(c5));

    // FA fa4 (.a(pp4), .b(pp8), .cin(pp12), .sum(s4), .carry(c6));
    // FA fa5 (.a(s4), .b(c4), .cin(c5), .sum(P[4]), .carry(c7));

    // FA fa6 (.a(pp9), .b(pp13), .cin(c6), .sum(s5), .carry(c8));
    // HA ha3 (.a(s5), .b(c7), .sum(P[5]), .carry(c9));

    // HA ha4 (.a(pp14), .b(c8), .sum(P[6]), .carry(P[7]));

    assign P = A * B;
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

    // I understood this VERY ELEGANT way to shift only after I coded it out LOL !!
    assign P = (P4 << 4) + (P3 << 2 )  +  (P2 << 2 ) + P1 ;

endmodule

// Aliase in verilog
module exact_5x5(input [4:0] A, input [4:0] B, output [9:0] P);
     exact_assymetric__5x5 m(.A(A), .B(B), .P(P));
endmodule



    module exact_assymetric__8x8__5_3(
    input [7:0] A, 
    input [7:0] B, 
    input clk,               // Clock signal
    output reg [15:0] P      // Registered output for synchronization
);

    wire [4:0] A_H, B_H; 
    wire [2:0] A_L, B_L;

    assign A_H = A[7:3]; 
    assign A_L = A[2:0];   
    assign B_H = B[7:3]; 
    assign B_L = B[2:0];   

    wire [9:0] P4;
    wire [7:0] P2, P3;
    wire [5:0] P1;
    
    // Instantiate the sub-modules
    exact_3x3 M1(.A(A_L), .B(B_L), .P(P1));
    exact_5x3 M2(.A(A_H), .B(B_L), .P(P2));
    exact_5x3 M3(.A(B_H), .B(A_L), .P(P3));
    exact_5x5 M4(.A(B_H), .B(A_H), .P(P4));

    // Registers for intermediate results
    reg [15:0] P1_shifted, P2_shifted, P3_shifted;

    // Sequential logic for synchronization
    always @(posedge clk) begin
        P1_shifted <= {10'b0, P1};                // P1 << 0
        P2_shifted <= {P2, 3'b0};                 // P2 << 3
        P3_shifted <= {P3, 3'b0};                 // P3 << 3
        P <= {P4, 6'b0} + P3_shifted + P2_shifted + P1_shifted;  // Final result
    end

endmodule



// module tb_mult_8x8;

//     reg [7:0] a, b;      
//     wire [15:0] Y;        
//     integer i, j;        

//     integer N = 8;

//     integer correct_results;        // Counter for correct matches
//     integer total_tests;           // Total number of test cases
//     integer total_tests_mred;
//     integer increment;
//     integer N_sq;
//     integer max_value; 

//     // For NMED calculation, MRED calculation,  NoEB calculation
//     real exact_result, error_distance, total_error_distance;             
//     real max_possible_value, total_relative_error, total_squared_error;       
//     real relative_error, squared_error;
//     real nmed, mred, noeb;        
    
//     exact_assymetric__8x8 uut ( .A(a),  .B(b),  .P(Y) );
//     // n8_6 uut ( .a(a),  .b(b),  .Y(Y) );
//     // n8_L1 uut ( .a(a),  .b(b),  .Y(Y) );
//     // n8_L2 uut ( .a(a),  .b(b),  .Y(Y) );


    
//     initial begin
//         // Initialize variables
//         N_sq = 1 << N;

//         correct_results = 0;
//         error_distance = 0;
//         exact_result = 0;  
//         relative_error = 0;   
//         total_error_distance = 0;
//         total_relative_error = 0;
//         total_squared_error = 0;
//         squared_error = 0;
//         total_tests = N_sq*N_sq;  // 16 * 16 combinations
// 	    total_tests_mred = 0;
// 	    increment = 0;
// 	    max_value = 0;
        
//         // Calculate maximum possible value for NMED: (2^(n-1))^2, where n=4
//         max_possible_value = (1 << (N-1)) * (1 << (4-1));  // 8^2 = 64
        

//         $display("Testing all possible combinations of 4-bit inputs for a and b:");
//         $display("\n\n a   b  | Y(a*b)  | Expected  | Match | Error Distance | Relative Error (x 10^-2)\n");
        
//         // Loop over all possible values of a and b (4-bit numbers: 0 to 15)
//         for (i = 0; i < N_sq; i = i + 1) begin
//             for (j = 0; j < N_sq; j = j + 1) begin
//                 a = i;  
//                 b = j;  


//                 // Wait for output to stabilize
//                 #10;    
                
//                 // Calculate error metrics for each test case
//                 exact_result = i * j;

// 		        max_value = (exact_result > max_value) ? exact_result : max_value;
//                 error_distance = abs(Y - exact_result);
//                 relative_error = (exact_result != 0) ? (error_distance / exact_result) : 0; // Tricky CASE
		 
// 		        increment = (exact_result != 0) ? 1 : 0;
// 		        total_tests_mred = total_tests_mred + increment; // Tricky CASE
//                 squared_error = error_distance * error_distance;
                
//                 // Accumulate errors
//                 total_error_distance = total_error_distance + error_distance;
//                 total_relative_error = total_relative_error + relative_error;
//                 total_squared_error = total_squared_error + squared_error;
                
//                 // Formatted display with fixed column widths
//                 $display("%2d %2d |   %3d    |    %3d   |   %1d   |     %6.3f      |     %6.3f", 
//                         a, b, Y, i * j, (Y == (i * j)) ? 1 : 0, error_distance, relative_error*100);
                
//                 correct_results = correct_results + ((Y == i*j) ? 1 : 0);
//             end
//         end
        
//         // Calculate final error metrics
//         nmed = total_error_distance / (total_tests * max_value);
//         mred = total_relative_error / ( total_tests_mred);

//         noeb = (2*N) - $ln(1 + $sqrt(total_squared_error/total_tests)) / $ln(2);  // 8 = 2*N where N=4
        
//         // Display results
//         $display("\n=== Performance Metrics ===");
//         $display("Total tests: %d", total_tests);
// 	    $display("Total tests MRED: %d", total_tests_mred);
//         $display("Correct results: %d", correct_results);
//         $display("Accuracy: %f%%\n\n\n", (correct_results * 100.0) / total_tests);
        
//         // Display new error metrics
//         $display("\n=== Error Metrics ===");    
//         $display("Total Error Distance : %f", total_error_distance);
//         $display("Total Relative error : %f", total_relative_error);
//         $display("Error rate: %f%%", 100 - (correct_results * 100.0) / total_tests);
//         $display("NMED (Normalized Mean Error Distance): %f", nmed);
//         $display("MRED (Mean Relative Error Distance): %f", mred);
//         $display("NoEB (Number of Effective Bits): %f\n\n\n", noeb);
        
//         $finish;
//     end
    
//     // Helper function to calculate absolute value
//     function real abs;
//         input real value;
//         begin
//             abs = (value < 0) ? -value : value;
//         end
//     endfunction
    
// endmodule