import engine.config_gen as gc
import engine.config_name_gen as gcn
import engine.mult_dict_gen as gmd
import engine.mult_rr_body as oc
import engine.mult_nr_gen as gv

import os
import sys
import subprocess
from pprint import pprint


def write_complete_verilog(multiplier, n_bits):
    os.makedirs(f"{n_bits}x{n_bits}", exist_ok=True)

    module_name = gcn.generate_configuration_name(multiplier)
    print("generating", module_name)
    
    mult_dict = gmd.parse_multiplier_string(module_name[0])
    pprint(mult_dict)
    
    code = ""   
    topflag = True                                 
    while True:
        tval = False
        for key in mult_dict:
            if key[2] == "rr":
                new_config = {key: [keys for keys in mult_dict[key]]}
                
                # Extracting all the parameters
                top_nature = key[2]
                
                size_x = key[0]
                
                hi = new_config[key][0][0]
                lo = size_x - hi
                
                # if len(new_config[key]) != 1:
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
                
                code += oc.write_main_verilog(top_nature, size_x, hi, lo, M1_nature, M2_nature, M3_nature, M4_nature, size_11, size_12, size_21, size_22, size_31, size_32, size_41, size_42, topflag, module_name[0])
                topflag = False
                
                mult_dict = mult_dict[key]
                tval = True
        if tval == False:
            break
            
    print(code)
    set_of_nr_multipliers = set(tuple(sublist) for sublist in gcn.list_of_nr_multipliers)
    os.makedirs(f"{n_bits}x{n_bits}/rtl/", exist_ok=True)
    with open(f"{n_bits}x{n_bits}/rtl/{VERBOSE}-{module_name[0]}.v", "w") as verilog_file:
        
        for nr_multipliers in set_of_nr_multipliers:
            result = gv.generate_multiplier(nr_multipliers[0], nr_multipliers[1])
            verilog_file.write(result)
        verilog_file.write(code)


# accept -v (verbose) from cli to print stuff to logs, not to delete the folders, for debugging
# usage python3 main.py x ( x goes from 1 ... , if x is not provided then it's treated as not verbose ) increment x externally
def get_values(data):
    
    # data = data.tolist()
        
    global VERBOSE
    VERBOSE = 0
    if len(sys.argv) > 1:
        VERBOSE = int(sys.argv[1])
    n_bits = 8

    data = str(data)
    # data = "[[7, 7], [7, 1], [1, 7], [1, 1]]"
    iteration = 10  # whatever solution of nsga, for a given 
    multiplier = eval(data.strip())
    # print((multiplier))
    write_complete_verilog(multiplier, n_bits)

    subprocess.run(["python3", "yosys_synth_automate.py", f"{n_bits}", str(VERBOSE)], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(["python3", "yosys_area_automate.py",  f"{n_bits}", str(VERBOSE)], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    subprocess.run(["python3", "sta_delay_power_automate.py",  f"{n_bits}", str(VERBOSE)], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    with open("area.txt", 'r') as f:
        area = f.read().strip()
        # print(area)
    with open("power.txt", 'r') as f:
        power = f.read().strip()
        # print(power)
    with open("delay.txt", 'r') as f:
        delay = f.read().strip()
        # print(delay)

    
    # remove the folder 8x8
    if not VERBOSE :
        subprocess.run(["rm","-rf", f"{n_bits}x{n_bits}" , "area.txt", "delay.txt", "power.txt"]  )
    
    return (area, power, delay)


def main():
    data = [[7, 7], [7, 1], [1, 7], [1, 1]]
    print(data)
    area, power, delay = get_values(data)
    print(area, power, delay)
if __name__ == "__main__":
    main()