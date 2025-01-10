

module tb_multiplier;

    parameter M = 8;
    parameter N = 8;

    reg [M-1:0] a;
    reg [N-1:0] b;

    wire [M+N-1:0] product;

    name_of_module uut (
        .A(a),
        .B(b),
        .out(product)
    );

    integer i, j;
    integer total_tests = 0;
    integer mismatches = 0;

    initial begin
        for (i = 0; i < (1 << M); i = i + 1) begin
            for (j = 0; j < (1 << N); j = j + 1) begin
                a = i;
                b = j;
                #2; // Wait for the result to propagate
                if (product !== (a * b)) begin
                    mismatches = mismatches + 1;
                end
                total_tests = total_tests + 1;
            end
        end

        $display("Total tests: %d", total_tests);
        $display("Mismatches: %d", mismatches);
        $display("Accuracy: %f%%", 100.0 * (total_tests - mismatches) / total_tests);

        $finish;
    end

    initial begin
        $monitor("At time %t, a = %h, b = %h, product = %h", $time, a, b, product);
    end

endmodule

module multiplier #(parameter M = 8, parameter N = 8) (
    input [M-1:0] a,
    input [N-1:0] b,
    output [M+N-1:0] product
);
    assign product = a * b;
endmodule