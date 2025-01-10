
'''
Given a configuration, I need to tell

 
[
    [6,6]
        [
            [3, 3], [3, 3], [3, 3], [3, 3]
        ], 
    [6, 2], 
    [2, 6], 
    [2, 2]
]




2x2 -- depth = 1
2x6 -- depth = 1
6x2 -- depth = 1


// Make the representation SIMPLE
    def check(l,depth):
        if not isinstance(l[0], list):



Maybe do the GENERATION FROM SCARTCH
He is able to generate everything but the representaion is pretty bad


'''


def main(a,b):
    # a = b = ...,8,6,4,2
    if (a == b) and (a % 2 == 0):
        code = f'''
        module exact_symetric__{a}x{a}(input [{a-1}:0] A, input [{a-1}:0] B, output [{2*a-1}:0] P);

            wire [{a//2 - 1}:0] A_H, B_H; 
            wire [{a//2 - 1}:0] A_L, B_L;

            assign A_H = A[{a-1}:{a//2}]; 
            assign A_L = A[{a//2-1}:0];   
            assign B_H = A[{a-1}:{a//2}]; 
            assign B_L = A[{a//2-1}:0];   


            wire [7:0] P1,P2,P3,P4;

            exact_{a//2}x{a//2} M1(.A(A_L), .B(B_L), .P(P1) );
            exact_{a//2}x{a//2} M2(.A(A_H), .B(B_L), .P(P2) );
            exact_{a//2}x{a//2} M3(.A(B_H), .B(A_L), .P(P3) );
            exact_{a//2}x{a//2} M4(.A(B_H), .B(A_H), .P(P4) );

            assign P = (P4 << {a}) + (P3 << {a//2} )  +  (P2 << {a//2} ) + P1 ;

        endmodule
        '''


if __name__ == "__main__":
    a = 4
    b = 4
    main(a,b)