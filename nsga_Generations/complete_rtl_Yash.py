import generate_configurations as gc
import generate_configuration_name as gcn
import generate_mult_dict as gmd
import organised_configs_Yash as oc
import generate_verilog as gv

import copy
import os


def main():
    
    n_bits = 4 # This means you want to construct all possible (n_bit x n_bit) multipliers
    os.makedirs(f"{n_bits}x{n_bits}", exist_ok=True)
    
    gc.generate_configurations(n_bits=n_bits)
    
    gc.filter_configurations()
    
    TEMPORARY_CONFIGURATIONS = copy.deepcopy(gc.CONFIGURATIONS)
    
    for key in range(3, n_bits+1):
        for configuration in TEMPORARY_CONFIGURATIONS[key]:

            for index, item in enumerate(configuration):

                item_high_bits, item_low_bits = item
                
                if gc.valid_configuration_for_further_decomposition(item_high_bits, item_low_bits):
                    list_configuration_to_fill = gc.CONFIGURATIONS[item_high_bits]
                    
                    temporary_configuration = copy.deepcopy(configuration)

                    for configuration_to_fill in list_configuration_to_fill:
                        new_configuration = copy.deepcopy(temporary_configuration)
                        new_configuration[index] = configuration_to_fill

                        gc.CONFIGURATIONS[key].append(new_configuration)
                     
    for key in gc.CONFIGURATIONS:
        if key == n_bits:
            with open("configs.dat", "w") as f:
                for index, item in enumerate(gc.CONFIGURATIONS[key]):
                    f.write(f"{item}\n")
    
    # The configs.dat now has all the configurations
    # Now for each configuration I need two things the configuration names, the configuration dictionary 
    # and the list of non-recursive multipliers used in the configuration
    
    # Open the file in read mode
    with open("configs.dat", "r") as file:
        
        for line in file:
            # Read one line from the file
            data = line.strip()  # Reads the first line and removes any extra whitespace
            data = eval(data)
            module_name = gcn.generate_configuration_name(data)
            
            mult_dict = gmd.parse_multiplier_string(module_name[0])
            
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
                        
                        if len(new_config[key]) != 1:
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
                        
                        else:
                            M1_nature = new_config[key][0][2]
                            M2_nature = new_config[key][0][2]
                            M3_nature = new_config[key][0][2]
                            M4_nature = new_config[key][0][2]
                            
                            size_11 = new_config[key][0][0]
                            size_12 = new_config[key][0][1]
                            
                            size_21 = new_config[key][0][0]
                            size_22 = new_config[key][0][1]
                            
                            size_31 = new_config[key][0][0]
                            size_32 = new_config[key][0][1]
                            
                            size_41 = new_config[key][0][0]
                            size_42 = new_config[key][0][1]
                            
                        
                        code += oc.write_main_verilog(top_nature, size_x, hi, lo, M1_nature, M2_nature, M3_nature, M4_nature, size_11, size_12, size_21, size_22, size_31, size_32, size_41, size_42, topflag, module_name[0])
                        topflag = False
                        
                        mult_dict = mult_dict[key]
                        tval = True
                if tval == False:
                    break
            
            set_of_nr_multipliers = set(tuple(sublist) for sublist in gcn.list_of_nr_multipliers)
            
            with open(f"{n_bits}x{n_bits}/{module_name[0]}.v", "w") as verilog_file:
                
                for nr_multipliers in set_of_nr_multipliers:
                    result = gv.generate_multiplier(nr_multipliers[0], nr_multipliers[1])
                    verilog_file.write(result)
                verilog_file.write(code)
                
                
            
                    
if __name__ == "__main__":
    main()
    

