def write_main_verilog(top_nature, size_x, hi, lo, M1_nature, M2_nature, M3_nature, M4_nature, size_11, size_12, size_21, size_22, size_31, size_32, size_41, size_42, topflag, name="lol"):
    p1 = 2*hi-1 if hi != 1 else 2*hi-2
    p2_3 = hi+lo-1 if hi != 1 and lo != 1 else hi+lo-2
    p4 = 2*lo-1 if lo != 1 else 2*lo-2
    if topflag == False:
        template = f'''
        module {top_nature}_{size_x}x{size_x}(
            input [{size_x-1}:0] A, 
            input [{size_x-1}:0] B, 
            output [{2*size_x-1}:0] P
        );
            // _AH__   _____AL___________ 
            // _BH__   _____BL___________ 
            // Lower bits are given to Higher part of bits, the other orientation is not considered
            wire [{hi-1}:0] A_H, B_H;
            wire [{lo-1}:0] A_L, B_L;
            
            assign A_H = A[{size_x-1}:{size_x-hi}];
            assign B_H = B[{size_x-1}:{size_x-hi}];
            assign A_L = A[{lo-1}:0];
            assign B_L = B[{lo-1}:0];
            
            wire [{p1}:0] P1;
            wire [{p2_3}:0] P2, P3;
            wire [{p4}:0] P4;
            
            {M1_nature}_{size_11}x{size_12} M1(.A(A_H), .B(B_H), .P(P1));
            {M2_nature}_{size_21}x{size_22} M2(.A(A_H), .B(B_L), .P(P2));
            {M3_nature}_{size_31}x{size_32} M3(.A(A_L), .B(B_H), .P(P3));
            {M4_nature}_{size_41}x{size_42} M4(.A(A_L), .B(B_L), .P(P4));
            
            assign P = (P1 << {2*lo}) + (P3 << {lo}) + (P2 << {lo}) + P4;
        endmodule
        '''
    else:
        template = f'''
        module {name}(
            input [{size_x-1}:0] A, 
            input [{size_x-1}:0] B, 
            output [{2*size_x-1}:0] P
        );
            // _AH__   _____AL___________ 
            // _BH__   _____BL___________ 
            // Lower bits are given to Higher part of bits, the other orientation is not considered
            wire [{hi-1}:0] A_H, B_H;
            wire [{lo-1}:0] A_L, B_L;
            
            assign A_H = A[{size_x-1}:{size_x-hi}];
            assign B_H = B[{size_x-1}:{size_x-hi}];
            assign A_L = A[{lo-1}:0];
            assign B_L = B[{lo-1}:0];
            
            
            wire [{p1}:0] P1;
            wire [{p2_3}:0] P2, P3;
            wire [{p4}:0] P4;
            
            {M1_nature}_{size_11}x{size_12} M1(.A(A_H), .B(B_H), .P(P1));
            {M2_nature}_{size_21}x{size_22} M2(.A(A_H), .B(B_L), .P(P2));
            {M3_nature}_{size_31}x{size_32} M3(.A(A_L), .B(B_H), .P(P3));
            {M4_nature}_{size_41}x{size_42} M4(.A(A_L), .B(B_L), .P(P4));
            
            assign P = (P1 << {2*lo}) + (P3 << {lo}) + (P2 << {lo}) + P4;
        endmodule
        '''
        
    
    return template
    
    
def main():
    config = {(8, 8, 'rr'): {(3, 3, 'nr'): {},
                (3, 5, 'nr'): {},
                (5, 3, 'nr'): {},
                (5, 5, 'rr'): {(1, 1, 'nr'): {},
                                (1, 4, 'nr'): {},
                                (4, 1, 'nr'): {},
                                (4, 4, 'rr'): {(1, 1, 'nr'): {},
                                                (1, 3, 'nr'): {},
                                                (3, 1, 'nr'): {},
                                                (3, 3, 'rr'): {(1, 1, 'nr'): {},
                                                                (1, 2, 'nr'): {},
                                                                (2, 1, 'nr'): {},
                                                                (2, 2, 'nr'): {}}}}}}
    
    code = ""   
    topflag = True                                 
    while True:
        tval = False
        for key in config:
            if key[2] == "rr":
                new_config = {key: [keys for keys in config[key]]}
                
                # Extracting all the parameters
                top_nature = key[2]
                
                size_x = key[0]
                
                hi = new_config[key][0][0]
                lo = size_x - hi
                
                M1_nature = new_config[key][0][2]
                M2_nature = new_config[key][1][2]
                M3_nature = new_config[key][2][2]
                M4_nature = new_config[key][3][2]
                
                size_11 = new_config[key][0][0]
                size_12 = new_config[key][0][1]
                
                size_21 = new_config[key][1][0]
                size_22 = new_config[key][1][1]
                
                size_31 = new_config[key][2][0]
                size_32 = new_config[key][2][1]
                
                size_41 = new_config[key][3][0]
                size_42 = new_config[key][3][1]
                
                code += write_main_verilog(top_nature, size_x, hi, lo, M1_nature, M2_nature, M3_nature, M4_nature, size_11, size_12, size_21, size_22, size_31, size_32, size_41, size_42, topflag)
                topflag = False
                
                config = config[key]
                tval = True
        if tval == False:
            break
    print(code)
        
if __name__ == "__main__":
    main()