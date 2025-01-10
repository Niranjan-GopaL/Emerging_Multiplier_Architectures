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




// 4x4 Multiplier Module
module nr4x4(
    input [3:0] A, B,   // 4-bit inputs
    output [7:0] P      // 8-bit product output
);

    // Column - 0
    assign P[0] = A[0] & B[0];  // product LSB


    // Column - 1
    wire S1_1, C_12_1;


    HA ha_1_1(.A(A[1] & B[0]), .B(A[0] & B[1]), .sum(S1_1), .carry(C_12_1));
    assign P[1] = S1_1;


    // Column - 2
    wire S2_1, C23_1, S2_2, C23_2;


    FA fa_2_1(.A(A[2] & B[0]), .B(A[1] & B[1]), .cin(A[0] & B[2]), .sum(S2_1), .carry(C23_1));
    HA ha_2_2(.A(S2_1), .B(C_12_1), .sum(S2_2), .carry(C23_2));
    assign P[2] = S2_2;


    // Column - 3
    wire S3_1, C34_1, S3_2, C34_2;
    FA fa_3_1(.A(A[3] & B[0]), .B(A[2] & B[1]), .cin(A[1] & B[2]), .sum(S3_1), .carry(C34_1));
    FA fa_3_2(.A(S3_1), .B(C23_1), .cin(A[0] & B[3]), .sum(S3_2), .carry(C34_2) );


    // Column - 4
    wire S4_1, C45_1, S4_2, C45_2;
    FA fa_4_1(.A(A[3] & B[1]), .B(A[2] & B[2]), .cin(A[1] & B[3]), .sum(S4_1), .carry(C45_1));
    HA ha_4_2(.A(S4_1), .B(C34_1), .sum(S4_2), .carry(C45_2));
    

    // Column - 5
    wire S5_2, C56_2;
    FA fa_5_2(.A(A[3] & B[2]), .B(A[2] & B[3]), .cin(C45_1), .sum(S5_2), .carry(C56_2));

    // Carry Propogation Adder ( to get P[3]..P[7] ) => 4 bit adder ??
    wire carry_3, carry_4, carry_5, carry_6;
    HA cpa_3(.A(S3_2), .B(C23_2), .sum(P[3]), .carry(carry_3) ) ;
    FA cpa_4(.A(S4_2), .B(C34_2), .cin(carry_3), .sum(P[4]), .carry(carry_4) ) ;
    FA cpa_5(.A(S5_2), .B(C45_2), .cin(carry_4), .sum(P[5]), .carry(carry_5) ) ;
    FA cpa_6(.A(A[3] & B[3]), .B(C56_2), .cin(carry_5), .sum(P[6]), .carry(carry_6) ) ;
    assign P[7] = carry_6 ;

endmodule



module r8x8__3nr4x4__1r4x4__B__4_nr2x2__B(
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

    // Instantiate the 4x4 multipliers
    nr4x4 M1(.A(A_L), .B(B_L), .P(P1));
    nr4x4 M2(.A(A_H), .B(B_L), .P(P2));
    nr4x4 M3(.A(B_H), .B(A_L), .P(P3));
    r4x4__B__4_nr2x2__B M4(.A(B_H), .B(A_H), .P(P4));

    assign P = (P4 << 8) + (P3 << 4 )  +  (P2 << 4 ) + P1 ;

endmodule



// module tb_mult_8x8;
//     reg [7:0] a, b;        // Input registers
//     wire [15:0] Y;         // Output wire
//     integer i, j;          // Loop variables

//     integer N = 8;
//     integer correct_results;        // Counter for correct matches
//     integer total_tests;           // Total number of test cases
//     integer total_tests_mred;
//     integer increment;
//     integer N_sq;
//     integer max_value; 

//     // For NMED calculation, MRED calculation, NoEB calculation
//     real exact_result, error_distance, total_error_distance;             
//     real max_possible_value, total_relative_error, total_squared_error;       
//     real relative_error, squared_error;
//     real nmed, mred, noeb;        
    
//     // Instantiate the multiplier
//     r8x8__3nr4x4__1r4x4__B__4_nr2x2__B uut (
//         .A(a),
//         .B(b),
//         .P(Y)
//     );

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
//         total_tests = N_sq*N_sq;
//         total_tests_mred = 0;
//         increment = 0;
//         max_value = 0;
        
//         max_possible_value = (1 << (N-1)) * (1 << (4-1));

//         $display("Testing all possible combinations of 8-bit inputs for a and b:");
//         $display("\n\n a   b  | Y(a*b)  | Expected  | Match | Error Distance | Relative Error (x 10^-2)\n");
        
//         // Loop over all possible values
//         for (i = 0; i < N_sq; i = i + 1) begin
//             for (j = 0; j < N_sq; j = j + 1) begin
//                 a = i;  
//                 b = j;  

//                 #4;
                
//                 // Calculate error metrics
//                 exact_result = i * j;
//                 max_value = (exact_result > max_value) ? exact_result : max_value;
//                 error_distance = abs(Y - exact_result);
//                 relative_error = (exact_result != 0) ? (error_distance / exact_result) : 0;
                
//                 increment = (exact_result != 0) ? 1 : 0;
//                 total_tests_mred = total_tests_mred + increment;
//                 squared_error = error_distance * error_distance;
                
//                 // Accumulate errors
//                 total_error_distance = total_error_distance + error_distance;
//                 total_relative_error = total_relative_error + relative_error;
//                 total_squared_error = total_squared_error + squared_error;
                
//                 // Display results
//                 $display("%2d %2d |   %3d    |    %3d   |   %1d   |     %6.3f      |     %6.3f", 
//                         a, b, Y, i * j, (Y == (i * j)) ? 1 : 0, error_distance, relative_error*100);
                
//                 correct_results = correct_results + ((Y == i*j) ? 1 : 0);
//             end
//         end
        
//         // Calculate final metrics
//         nmed = total_error_distance / (total_tests * max_value);
//         mred = total_relative_error / total_tests_mred;
//         noeb = (2*N) - $ln(1 + $sqrt(total_squared_error/total_tests)) / $ln(2);
        
//         // Display results
//         $display("\n=== Performance Metrics ===");
//         $display("Total tests: %d", total_tests);
//         $display("Total tests MRED: %d", total_tests_mred);
//         $display("Correct results: %d", correct_results);
//         $display("Accuracy: %f%%\n\n\n", (correct_results * 100.0) / total_tests);
        
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