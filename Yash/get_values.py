import engine.config_gen as gc
import engine.config_name_gen as gcn
import engine.mult_dict_gen as gmd
import engine.mult_rr_body as oc
import engine.mult_nr_gen as gv

import os
import sys
import subprocess
from pprint import pprint

VERBOSE = 0
def write_complete_verilog(multiplier, n_bits, Z):
    os.makedirs(f"{n_bits}x{n_bits}", exist_ok=True)

    module_name = gcn.generate_configuration_name(multiplier)
    # print("generating", module_name[0])
    
    mult_dict = gmd.parse_multiplier_string(module_name[0])
    # pprint(mult_dict)
    # def generate_config(config, code, key=(8, 8, 'rr', 0), topflag=True, name="lol"):
    
    topflag = True 
    code = ""      
    code = oc.generate_config(config=mult_dict, code=code, key=(8, 8, 'rr', 0), topflag=True, name=module_name[0])
    # oc.generate_config_recursive(config=mult_dict, key=(8, 8, 'rr', 0), topflag=True, name=module_name[0]) 
    # print("Finished")  
    # code = oc.code                         
    # while True:
        # tval = False
        # for key in mult_dict:
        #     if key[2] == "rr":
        #         new_config = {key: [keys for keys in mult_dict[key]]}
                
        #         # Extracting all the parameters
        #         top_nature = key[2]
                
        #         size_x = key[0]
                
        #         hi = new_config[key][0][0]
        #         lo = size_x - hi
                
        #         # if len(new_config[key]) != 1:
        #         M1_nature = new_config[key][0][2]
        #         M2_nature = new_config[key][1][2]
        #         M3_nature = new_config[key][2][2]
        #         M4_nature = new_config[key][3][2]
                
        #         size_11 = new_config[key][0][0]
        #         size_12 = new_config[key][0][1]
                
        #         size_21 = new_config[key][1][0]
        #         size_22 = new_config[key][1][1]
                
        #         size_31 = new_config[key][2][0]
        #         size_32 = new_config[key][2][1]
                
        #         size_41 = new_config[key][3][0]
        #         size_42 = new_config[key][3][1]                            
                
        #         code += oc.write_main_verilog(top_nature, size_x, hi, lo, M1_nature, M2_nature, M3_nature, M4_nature, size_11, size_12, size_21, size_22, size_31, size_32, size_41, size_42, topflag, module_name[0])
        #         topflag = False
                
        #         mult_dict = mult_dict[key]
        #         tval = True
        # if tval == False:
        #     break
        

    if VERBOSE : print(code)
    set_of_nr_multipliers = set(tuple(sublist) for sublist in gcn.list_of_nr_multipliers)
    os.makedirs(f"{n_bits}x{n_bits}/rtl/", exist_ok=True)
    with open(f"{n_bits}x{n_bits}/rtl/{Z}-temp.v", "w") as verilog_file:
        
        verilog_file.write(code)
        for nr_multipliers in set_of_nr_multipliers:
            result = gv.generate_multiplier(nr_multipliers[0], nr_multipliers[1])
            verilog_file.write(result)
        
        
    return module_name[0]


# accept -v (verbose) from cli to print stuff to logs, not to delete the folders, for debugging
# usage python3 main.py x ( x goes from 1 ... , if x is not provided then it's treated as not verbose ) increment x externally
def get_values(data, Z):
    
    # data = data.tolist()
        
    global VERBOSE
    # VERBOSE = VERBOSE_GIVEN
    n_bits = 8

    data = str(data)
    # data = "[[7, 7], [7, 1], [1, 7], [1, 1]]"
    iteration = 10  # whatever solution of nsga, for a given 
    multiplier = eval(data.strip())
    # print((multiplier))
    module_name = write_complete_verilog(multiplier, n_bits,Z)

    subprocess.run(["python3", "yosys_synth_automate.py", f"{n_bits}", str(Z), module_name], check=True, 
                #    stdout=subprocess.DEVNULL, 
                #    stderr=subprocess.DEVNULL
                   )
    subprocess.run(["python3", "yosys_area_automate.py",  f"{n_bits}", str(Z), module_name], 
                   check=True, stdout=subprocess.DEVNULL, 
                   stderr=subprocess.DEVNULL
                   )
    subprocess.run(["python3", "sta_delay_power_automate.py",  f"{n_bits}", str(Z), module_name], check=True, 
                   stdout=subprocess.DEVNULL, 
                   stderr=subprocess.DEVNULL
                   )

    with open("area.txt", 'r') as f:
        area = f.read().strip()
        # print(area)
    with open("power.txt", 'r') as f:
        power = f.read().strip()
        # print("Power")
        # print(power)
    with open("delay.txt", 'r') as f:
        delay = f.read().strip()
        # print("Delay")
        # print(delay)

    
    # remove the folder 8x8
    # if not VERBOSE :
    #     subprocess.run(["rm","-rf", f"{n_bits}x{n_bits}" , "area.txt", "delay.txt", "power.txt"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL  )
    
    # Every time get_values is called 1.1 1.2 1.3
    
    return (area, power, delay)


def main():
    data = [[[[2, 2], [2, 1], [1, 2], [1, 1]], [3, 2], [2, 3], [2, 2]], [5, 3], [3, 5], [[2, 2], [2, 1], [1, 2], [1, 1]]]
    print(data)
    n_bits = 8
    data = str(data)
    multiplier = eval(data.strip())
    # write_complete_verilog(multiplier, n_bits)
    area, power, delay = get_values(data)
    print(f"{area} || {power} || {delay}")
if __name__ == "__main__":
    main()