import sys
import copy
from pprint import pprint

from generate_verilog import generate_multiplier


STD_OUT_FILE = 'stdout.dat'


class Tee:
    def __init__(self, filename):
        self.file = open(filename, 'w')
        self.stdout = sys.stdout

    def write(self, data):
        self.file.write(data)
        self.stdout.write(data)
        
    def flush(self):
        self.file.flush()
        self.stdout.flush()
        
    def close(self):
        self.file.close()



def generate_rtl(dictionary, top_level=True):

    def get_module_name(size_x, size_y, is_recursive):
        # Some way to get the recursive module name 
        return f"exact_{size_x}x{size_y}"
    
    def generate_recursive_module(size_x, size_y, submodules):
        half = size_x // 2

        # Second submodule is always 6x2, 4x3, 2x1  => ( higher, lower )
        hi, lo= list(submodules.keys())[1][:2]

        return f'''
    module exact_symmetric__{size_x}x{size_x}(
        input [{size_x-1}:0] A, 
        input [{size_y-1}:0] B, 
        output [{size_x+size_y-1}:0] P
    );
        // _AH__   _____AL___________ 
        // _BH__   _____BL___________ 
        // Lower bits are given to Higher part of bits, the other orientation is not considered
        wire [{lo-1}:0] A_H, B_H;
        wire [{hi-1}:0] A_L, B_L;
        
        assign A_H = A[{size_x-1}:{size_x-lo}];
        assign B_H = B[{size_x-1}:{size_x-lo}];
        assign A_L = A[{hi-1}:0];
        assign B_L = B[{hi-1}:0];
        
        wire [{2*lo-1}:0] P1;
        wire [{hi+lo-1}:0] P2, P3;
        wire [{2*hi-1}:0] P4;
        
        {get_module_name(*list(submodules.keys())[3][:2], list(submodules.keys())[3][2] == 'rr')} M1(.A(A_H), .B(B_H), .P(P1));
        {get_module_name(*list(submodules.keys())[2][:2], list(submodules.keys())[2][2] == 'rr')} M2(.A(A_H), .B(B_L), .P(P2));
        {get_module_name(*list(submodules.keys())[1][:2], list(submodules.keys())[1][2] == 'rr')} M3(.A(A_L), .B(B_H), .P(P3));
        {get_module_name(*list(submodules.keys())[0][:2], list(submodules.keys())[0][2] == 'rr')} M4(.A(A_L), .B(B_L), .P(P4));
        
        assign P = (P1 << {2*lo}) + (P3 << {lo}) + (P2 << {lo}) + P4;
    endmodule
    '''

    complete_rtl = []
    for (size_x, size_y, mod_type), submodules in dictionary.items():
        print(f"VARS :== {(size_x, size_y, mod_type)}\n\n\n\n")
        if mod_type == 'rr':
            complete_rtl.append(generate_recursive_module(size_x, size_y, submodules))
            if submodules:
                print(f"Submodule found, recursion for starts \n\n")
                sub_rtl = generate_rtl(submodules, top_level=False)
                print(complete_rtl)
                print("RECUSRION DONE !!!! \n\n")
                complete_rtl.extend(sub_rtl)
        if mod_type == 'nr':
            complete_rtl.append(generate_multiplier(size_x, size_y))
            print(complete_rtl)


    print(f"THIS IS DONE for {size_x}, {size_y}, {mod_type}\n\n\n")
    print("___________________________________________________||_____||__________________"*7)
    print(complete_rtl)
    print("___________________________________________________||_____||__________________"*7)
    return complete_rtl




def get_complete_rtl(dictionary):
    modules = generate_rtl(dictionary)
    return '\n\n\n'.join(modules)



def main():
    
    try:
        tee = Tee(STD_OUT_FILE)
        sys.stdout = tee
        module_name = "rr8x8__B__nr6x6__nr6x2__nr2x6__nr2x2__B__" 
        dictionary = {(8, 8, 'rr'): {(6, 6, 'nr'): {}, (6, 2, 'nr'): {}, (2, 6, 'nr'): {}, (2, 2, 'nr'): {}}}
        pprint(dictionary)
        rtl = get_complete_rtl(dictionary)
        filename = f"{module_name}.v"
        with open(filename, "w") as f:
            f.write(rtl)
        print(f"RTL code written to {filename}")
        print(rtl)

    finally:
        sys.stdout = tee.stdout
        tee.close()

if __name__ == "__main__":
    main()