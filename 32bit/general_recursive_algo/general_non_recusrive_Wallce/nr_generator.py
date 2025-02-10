"""
Author: Niranjan Gopal, IIITB, under guidance of Prof. Madhav Rao.
This code generates all possible configurations of A multiplier possible for given number of bits
"""


def generate_wallace_multiplier(a_width, b_width):
    module_name = f"nr_{a_width}x{b_width}"
    rtl_code = f"""module {module_name}(

    input [{a_width-1}:0] A,
    input [{b_width-1}:0] B,
    output [{a_width+b_width-1}:0] p
);

    // Generate partial products
    wire [{a_width-1}:0] pp[{b_width-1}:0];
    
    genvar i, j;
    generate
        for (i = 0; i < {b_width}; i = i + 1) begin
            for (j = 0; j < {a_width}; j = j + 1) begin
                assign pp[i][j] = A[j] & B[i];
            end
        end
    endgenerate

    // Wallace tree reduction
    wire [{a_width+b_width-1}:0] final_sum;
    
    // First stage
    wire [{a_width+b_width-1}:0] stage1_sum;
    wire [{a_width+b_width-1}:0] stage1_carry;
    
    assign stage1_sum[{a_width-1}:0] = pp[0];
    assign stage1_sum[{a_width+b_width-1}:{a_width}] = 0;
    
    generate
        for (i = 1; i < {b_width}; i = i + 1) begin
            assign stage1_carry[{a_width}+i-1:i-1] = pp[i];
        end
    endgenerate
    
    // Final addition
    assign p = stage1_sum + stage1_carry;

endmodule


module {module_name}_tb;
    reg [{a_width-1}:0] A;
    reg [{b_width-1}:0] B;
    wire [{a_width+b_width-1}:0] p;
    
    // Instantiate the wallace multiplier
    {module_name} dut (
        .A(A),
        .B(B),
        .p(p)
    );
    
    integer i, j, errors;
    reg [{a_width+b_width-1}:0] expected;
    
    initial begin
        errors = 0;
        
        // Test all possible combinations
        for (i = 0; i < (1 << {a_width}); i = i + 1) begin
            for (j = 0; j < (1 << {b_width}); j = j + 1) begin
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


"""
    return rtl_code


def main():
    a_width = 5 
    b_width = 2 
    
    rtl_code    = generate_wallace_multiplier(a_width, b_width)
    
    with open(f'nr_{a_width}x{b_width}.v', 'w') as f:
        f.write(rtl_code)
    
    
    print("Generated files...")

if __name__ == "__main__":
    main()