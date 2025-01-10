module nr_5x2(

    input [4:0] A,
    input [1:0] B,
    output [6:0] p
);

    // Generate partial products
    wire [4:0] pp[1:0];
    
    genvar i, j;
    generate
        for (i = 0; i < 2; i = i + 1) begin
            for (j = 0; j < 5; j = j + 1) begin
                assign pp[i][j] = A[j] & B[i];
            end
        end
    endgenerate

    // Wallace tree reduction
    wire [6:0] final_sum;
    
    // First stage
    wire [6:0] stage1_sum;
    wire [6:0] stage1_carry;
    
    assign stage1_sum[4:0] = pp[0];
    assign stage1_sum[6:5] = 0;
    
    generate
        for (i = 1; i < 2; i = i + 1) begin
            assign stage1_carry[5+i-1:i-1] = pp[i];
        end
    endgenerate
    
    // Final addition
    assign p = stage1_sum + stage1_carry;

endmodule


module nr_5x2_tb;
    reg [4:0] A;
    reg [1:0] B;
    wire [6:0] p;
    
    // Instantiate the wallace multiplier
    nr_5x2 dut (
        .A(A),
        .B(B),
        .p(p)
    );
    
    integer i, j, errors;
    reg [6:0] expected;
    
    initial begin
        errors = 0;
        
        // Test all possible combinations
        for (i = 0; i < (1 << 5); i = i + 1) begin
            for (j = 0; j < (1 << 2); j = j + 1) begin
                A = i;
                B = j;
                expected = A * B;
                #10;
                
                if (p !== expected) begin
                    $display("Error: A=%d, B=%d, expected=%d, got=%d", 
                            A, B, expected, p);
                    errors = errors + 1;
                end
            end
        end
        
        if (errors == 0)
            $display("All tests passed successfully!");
        else
            $display("Tests completed with %d errors", errors);
            
        $finish;
    end
    
endmodule