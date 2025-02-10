from pprint import pprint


def write_main_verilog(top_nature, top_index, size_x, hi, lo, M1_nature, M1_index, M2_nature, M2_index, M3_nature, M3_index, M4_nature, M4_index, size_11, size_12, size_21, size_22, size_31, size_32, size_41, size_42, topflag, name="lol"):
    p1 = 2*hi-1 if hi != 1 else 2*hi-2
    p2_3 = hi+lo-1 if hi != 1 and lo != 1 else hi+lo-2
    p4 = 2*lo-1 if lo != 1 else 2*lo-2
    
    if M1_nature == "rr":
        M1_Name = f"{M1_nature}_{size_11}x{size_12}_{M1_index}"
    else:
        M1_Name = f"{M1_nature}_{size_11}x{size_12}"
        
    if M2_nature == "rr":
        M2_Name = f"{M2_nature}_{size_21}x{size_22}_{M2_index}"
    else:
        M2_Name = f"{M2_nature}_{size_21}x{size_22}"
        
    if M3_nature == "rr":
        M3_Name = f"{M3_nature}_{size_31}x{size_32}_{M3_index}"
    else:
        M3_Name = f"{M3_nature}_{size_31}x{size_32}"
        
    if M4_nature == "rr":
        M4_Name = f"{M4_nature}_{size_41}x{size_42}_{M4_index}"
    else:
        M4_Name = f"{M4_nature}_{size_41}x{size_42}"
        
        
        
    if topflag == False:
        template = f'''
        module {top_nature}_{size_x}x{size_x}_{top_index}(
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
            
            {M1_Name} M1(.A(A_H), .B(B_H), .P(P1));
            {M2_Name} M2(.A(A_H), .B(B_L), .P(P2));
            {M3_Name} M3(.A(A_L), .B(B_H), .P(P3));
            {M4_Name} M4(.A(A_L), .B(B_L), .P(P4));
            
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
            
            {M1_Name} M1(.A(A_H), .B(B_H), .P(P1));
            {M2_Name} M2(.A(A_H), .B(B_L), .P(P2));
            {M3_Name} M3(.A(A_L), .B(B_H), .P(P3));
            {M4_Name} M4(.A(A_L), .B(B_L), .P(P4));
            
            assign P = (P1 << {2*lo}) + (P3 << {lo}) + (P2 << {lo}) + P4;
        endmodule
        '''
        
    
    return template

# code = ""

def generate_config_recursive(config, code, key, topflag, name ):
    
    # global code
    # code = ""
    # print("Printing")
    # pprint(config)
    # print(f"Key={key}")
    
    if key[3] == 'nr':
        return
    
    # print(key, config)
    new_config_full = config[key]
    new_config = {key: [keys for keys in config[key]]}
    # print(new_config)
                
    # Extracting all the parameters
    top_nature = key[3]
    
    size_x = key[1]
    
    top_index = key[0]
    
    hi = new_config[key][0][1]
    lo = size_x - hi
    
    M1_nature = new_config[key][0][3]
    M2_nature = new_config[key][1][3]
    M3_nature = new_config[key][2][3]
    M4_nature = new_config[key][3][3]
    
    M1_index = new_config[key][0][0]
    M2_index = new_config[key][1][0]
    M3_index = new_config[key][2][0]
    M4_index = new_config[key][3][0]
    
    size_11 = new_config[key][0][1]
    size_12 = new_config[key][0][2]
    
    size_21 = new_config[key][1][1]
    size_22 = new_config[key][1][2]
    
    size_31 = new_config[key][2][1]
    size_32 = new_config[key][2][2]
    
    size_41 = new_config[key][3][1]
    size_42 = new_config[key][3][2]
    
    code = write_main_verilog(top_nature, top_index, size_x, hi, lo, M1_nature, M1_index, M2_nature, M2_index, M3_nature, M3_index, M4_nature, M4_index, size_11, size_12, size_21, size_22, size_31, size_32, size_41, size_42, topflag, name)
    # print(f"Code={code}")
    if topflag == True:
        topflag = False
    
    for values in new_config[key]:
        code_1 = generate_config_recursive(new_config_full, code, values, topflag, name)
        if code_1 != None:
            code += code_1
    
    return code
    
def generate_config(config, code, key=(0, 32, 32, 'rr'), topflag=True, name="lol"):
    
    code = generate_config_recursive(config, code, key, topflag, name)
    
    return code
    
    
def main():
    config = {(0, 32, 32, 'rr'): {(1, 23, 23, 'rr'): {(2, 15, 15, 'nr'): {},
                                         (3, 15, 8, 'nr'): {},
                                         (4, 8, 15, 'nr'): {},
                                         (5, 8, 8, 'rr'): {(6, 5, 5, 'nr'): {},
                                                           (7, 5, 3, 'nr'): {},
                                                           (8, 3, 5, 'nr'): {},
                                                           (9, 3, 3, 'nr'): {}}},
                     (10, 23, 9, 'nr'): {},
                     (11, 9, 23, 'nr'): {},
                     (12, 9, 9, 'rr'): {(13, 5, 5, 'nr'): {},
                                        (14, 5, 4, 'nr'): {},
                                        (15, 4, 5, 'nr'): {},
                                        (16, 4, 4, 'nr'): {}}}}
     
    topflag = True                                 
    # while True:
        
    #     tval = False
    #     for key in config:
    #         print("Key=", key)
    #         pprint(config)
    #         if key[2] == "rr":
    #             new_config = {key: [keys for keys in config[key]]}
                
    #             # Extracting all the parameters
    #             top_nature = key[2]
                
    #             size_x = key[0]
                
    #             hi = new_config[key][0][0]
    #             lo = size_x - hi
                
    #             M1_nature = new_config[key][0][2]
    #             M2_nature = new_config[key][1][2]
    #             M3_nature = new_config[key][2][2]
    #             M4_nature = new_config[key][3][2]
                
    #             size_11 = new_config[key][0][0]
    #             size_12 = new_config[key][0][1]
                
    #             size_21 = new_config[key][1][0]
    #             size_22 = new_config[key][1][1]
                
    #             size_31 = new_config[key][2][0]
    #             size_32 = new_config[key][2][1]
                
    #             size_41 = new_config[key][3][0]
    #             size_42 = new_config[key][3][1]
                
    #             code += write_main_verilog(top_nature, size_x, hi, lo, M1_nature, M2_nature, M3_nature, M4_nature, size_11, size_12, size_21, size_22, size_31, size_32, size_41, size_42, topflag)
    #             topflag = False
                
    #             config = config[key]
    #             tval = True
    #     if tval == False:
    #         break
    code = ""
    code = generate_config(config=config, key=(0, 32, 32, 'rr'), topflag=True, name="lol", code=code)
    # code = generate_config_recursive(config=config, key=(8, 8, 'rr', 0), topflag=True, name="lol", code=code)
    print(code)
    
if __name__ == "__main__":
    main()