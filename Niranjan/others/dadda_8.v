// Dadda Multiplier
// A - 8 bits, B - 8 bits, P (output) - 16 bits

module HA(a, b, sum, cout);
    input a, b; // a and b are inputs with size 1-bit
    output sum, cout; // sum and cout are outputs with size 1-bit

    assign sum = a ^ b; 
    assign cout = a & b; 
endmodule

module CSA(a, b, cin, sum, cout);
    input a, b, cin;
    output sum, cout;
    
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

module dadda_8(A, B, P);
    input [7:0] A;
    input [7:0] B;
    output wire [15:0] P;
    wire gen_pp [0:7][7:0];
// stage-1 sum and carry
    wire [0:5]s1,c1;
// stage-2 sum and carry
    wire [0:13]s2,c2;   
// stage-3 sum and carry
    wire [0:9]s3,c3;
// stage-4 sum and carry
    wire [0:11]s4,c4;
// stage-5 sum and carry
    wire [0:13]s5,c5;

// generating partial products 
genvar i;
genvar j;

for(i = 0; i<8; i=i+1)begin

   for(j = 0; j<8;j = j+1)begin
      assign gen_pp[i][j] = A[j]*B[i];
end
end

//Reduction by stages.
// di_values = 2,3,4,6,8,13...

//Stage 1 - reducing fom 8 to 6  

    HA h1(.a(gen_pp[6][0]),.b(gen_pp[5][1]),.sum(s1[0]),.cout(c1[0]));
    HA h2(.a(gen_pp[4][3]),.b(gen_pp[3][4]),.sum(s1[2]),.cout(c1[2]));
    HA h3(.a(gen_pp[4][4]),.b(gen_pp[3][5]),.sum(s1[4]),.cout(c1[4]));

    CSA c11(.a(gen_pp[7][0]),.b(gen_pp[6][1]),.cin(gen_pp[5][2]),.sum(s1[1]),.cout(c1[1]));
    CSA c12(.a(gen_pp[7][1]),.b(gen_pp[6][2]),.cin(gen_pp[5][3]),.sum(s1[3]),.cout(c1[3]));     
    CSA c13(.a(gen_pp[7][2]),.b(gen_pp[6][3]),.cin(gen_pp[5][4]),.sum(s1[5]),.cout(c1[5]));
    
//Stage 2 - reducing fom 6 to 4

    HA h4(.a(gen_pp[4][0]),.b(gen_pp[3][1]),.sum(s2[0]),.cout(c2[0]));
    HA h5(.a(gen_pp[2][3]),.b(gen_pp[1][4]),.sum(s2[2]),.cout(c2[2]));

    CSA c21(.a(gen_pp[5][0]),.b(gen_pp[4][1]),.cin(gen_pp[3][2]),.sum(s2[1]),.cout(c2[1]));
    CSA c22(.a(s1[0]),.b(gen_pp[4][2]),.cin(gen_pp[3][3]),.sum(s2[3]),.cout(c2[3]));
    CSA c23(.a(gen_pp[2][4]),.b(gen_pp[1][5]),.cin(gen_pp[0][6]),.sum(s2[4]),.cout(c2[4]));
    CSA c24(.a(s1[1]),.b(s1[2]),.cin(c1[0]),.sum(s2[5]),.cout(c2[5]));
    CSA c25(.a(gen_pp[2][5]),.b(gen_pp[1][6]),.cin(gen_pp[0][7]),.sum(s2[6]),.cout(c2[6]));
    CSA c26(.a(s1[3]),.b(s1[4]),.cin(c1[1]),.sum(s2[7]),.cout(c2[7]));
    CSA c27(.a(c1[2]),.b(gen_pp[2][6]),.cin(gen_pp[1][7]),.sum(s2[8]),.cout(c2[8]));
    CSA c28(.a(s1[5]),.b(c1[3]),.cin(c1[4]),.sum(s2[9]),.cout(c2[9]));
    CSA c29(.a(gen_pp[4][5]),.b(gen_pp[3][6]),.cin(gen_pp[2][7]),.sum(s2[10]),.cout(c2[10]));
    CSA c210(.a(gen_pp[7][3]),.b(c1[5]),.cin(gen_pp[6][4]),.sum(s2[11]),.cout(c2[11]));
    CSA c211(.a(gen_pp[5][5]),.b(gen_pp[4][6]),.cin(gen_pp[3][7]),.sum(s2[12]),.cout(c2[12]));
    CSA c212(.a(gen_pp[7][4]),.b(gen_pp[6][5]),.cin(gen_pp[5][6]),.sum(s2[13]),.cout(c2[13]));
    
//Stage 3 - reducing fom 4 to 3

    HA h6(.a(gen_pp[3][0]),.b(gen_pp[2][1]),.sum(s3[0]),.cout(c3[0]));

    CSA c31(.a(s2[0]),.b(gen_pp[2][2]),.cin(gen_pp[1][3]),.sum(s3[1]),.cout(c3[1]));
    CSA c32(.a(s2[1]),.b(s2[2]),.cin(c2[0]),.sum(s3[2]),.cout(c3[2]));
    CSA c33(.a(c2[1]),.b(c2[2]),.cin(s2[3]),.sum(s3[3]),.cout(c3[3]));
    CSA c34(.a(c2[3]),.b(c2[4]),.cin(s2[5]),.sum(s3[4]),.cout(c3[4]));
    CSA c35(.a(c2[5]),.b(c2[6]),.cin(s2[7]),.sum(s3[5]),.cout(c3[5]));
    CSA c36(.a(c2[7]),.b(c2[8]),.cin(s2[9]),.sum(s3[6]),.cout(c3[6]));
    CSA c37(.a(c2[9]),.b(c2[10]),.cin(s2[11]),.sum(s3[7]),.cout(c3[7]));
    CSA c38(.a(c2[11]),.b(c2[12]),.cin(s2[13]),.sum(s3[8]),.cout(c3[8]));
    CSA c39(.a(gen_pp[7][5]),.b(gen_pp[6][6]),.cin(gen_pp[5][7]),.sum(s3[9]),.cout(c3[9]));

//Stage 4 - reducing fom 3 to 2

    HA h7(.a(gen_pp[2][0]),.b(gen_pp[1][1]),.sum(s4[0]),.cout(c4[0]));

    CSA c41(.a(s3[0]),.b(gen_pp[1][2]),.cin(gen_pp[0][3]),.sum(s4[1]),.cout(c4[1]));
    CSA c42(.a(c3[0]),.b(s3[1]),.cin(gen_pp[0][4]),.sum(s4[2]),.cout(c4[2]));
    CSA c43(.a(c3[1]),.b(s3[2]),.cin(gen_pp[0][5]),.sum(s4[3]),.cout(c4[3]));
    CSA c44(.a(c3[2]),.b(s3[3]),.cin(s2[4]),.sum(s4[4]),.cout(c4[4]));
    CSA c45(.a(c3[3]),.b(s3[4]),.cin(s2[6]),.sum(s4[5]),.cout(c4[5]));
    CSA c46(.a(c3[4]),.b(s3[5]),.cin(s2[8]),.sum(s4[6]),.cout(c4[6]));
    CSA c47(.a(c3[5]),.b(s3[6]),.cin(s2[10]),.sum(s4[7]),.cout(c4[7]));
    CSA c48(.a(c3[6]),.b(s3[7]),.cin(s2[12]),.sum(s4[8]),.cout(c4[8]));
    CSA c49(.a(c3[7]),.b(s3[8]),.cin(gen_pp[4][7]),.sum(s4[9]),.cout(c4[9]));
    CSA c410(.a(c3[8]),.b(s3[9]),.cin(c2[13]),.sum(s4[10]),.cout(c4[10]));
    CSA c411(.a(c3[9]),.b(gen_pp[7][6]),.cin(gen_pp[6][7]),.sum(s4[11]),.cout(c4[11]));
    
//Stage 5 - reducing fom 2 to 1
    // adding total sum and carry to get final output

    HA h8(.a(gen_pp[1][0]),.b(gen_pp[0][1]),.sum(P[1]),.cout(c5[0]));

    CSA c51(.a(s4[0]),.b(gen_pp[0][2]),.cin(c5[0]),.sum(P[2]),.cout(c5[1]));
    CSA c52(.a(c4[0]),.b(s4[1]),.cin(c5[1]),.sum(P[3]),.cout(c5[2]));
    CSA c54(.a(c4[1]),.b(s4[2]),.cin(c5[2]),.sum(P[4]),.cout(c5[3]));
    CSA c55(.a(c4[2]),.b(s4[3]),.cin(c5[3]),.sum(P[5]),.cout(c5[4]));
    CSA c56(.a(c4[3]),.b(s4[4]),.cin(c5[4]),.sum(P[6]),.cout(c5[5]));
    CSA c57(.a(c4[4]),.b(s4[5]),.cin(c5[5]),.sum(P[7]),.cout(c5[6]));
    CSA c58(.a(c4[5]),.b(s4[6]),.cin(c5[6]),.sum(P[8]),.cout(c5[7]));
    CSA c59(.a(c4[6]),.b(s4[7]),.cin(c5[7]),.sum(P[9]),.cout(c5[8]));
    CSA c510(.a(c4[7]),.b(s4[8]),.cin(c5[8]),.sum(P[10]),.cout(c5[9]));
    CSA c511(.a(c4[8]),.b(s4[9]),.cin(c5[9]),.sum(P[11]),.cout(c5[10]));
    CSA c512(.a(c4[9]),.b(s4[10]),.cin(c5[10]),.sum(P[12]),.cout(c5[11]));
    CSA c513(.a(c4[10]),.b(s4[11]),.cin(c5[11]),.sum(P[13]),.cout(c5[12]));
    CSA c514(.a(c4[11]),.b(gen_pp[7][7]),.cin(c5[12]),.sum(P[14]),.cout(c5[13]));

    assign P[0] = gen_pp[0][0];
    assign P[15] = c5[13];

endmodule 

// module tb_dadda_multiplier;
//     parameter M = 8;
//     parameter N = 8;

//     reg [M-1:0] A;
//     reg [N-1:0] B;
//     wire [M+N-1:0] P;
//     reg [M+N-1:0] correct;

//     dadda_8 uut (
//         .A(A),
//         .B(B),
//         .P(P)
//     );

//     integer i, j;
//     integer total_tests = 0;
//     integer mismatches = 0;

//     initial begin
//         for (i = 0; i < (1 << M); i = i + 1) begin
//             for (j = 0; j < (1 << N); j = j + 1) begin
//                 A = i;
//                 B = j;
//                 correct = A * B;
//                 #2; // Wait for the result to propagate
//                 if (P !== correct) begin
//                     mismatches = mismatches + 1;
//                 end
//                 total_tests = total_tests + 1;
//             end
//         end

//         $display("Total tests: %d", total_tests);
//         $display("Mismatches: %d", mismatches);
//         $display("Accuracy: %f%%", 100.0 * (total_tests - mismatches) / total_tests);

//         $finish;
//     end

//     initial begin
//         $monitor("At time %t, A = %d, B = %d, P = %d, correct = %d", $time, A, B, P, correct);
//     end
// endmodule