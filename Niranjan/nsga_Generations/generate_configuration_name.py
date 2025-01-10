"""
Author: Yash Sengupta and Niranjan Gopal, IIITB, under guidance of Prof. Madhav Rao.
This code takes in a configuration in the form of a list and outputs a name. That name will be used to model the multipliers.

Ex:
Configuration: [[3, 3], [3, 5], [5, 3], [[1, 1], [1, 4], [4, 1], [[3, 3], [3, 1], [1, 3], [1, 1]]]]
Output: r_8x8__B__1_nr_3x3_1_nr_3x5_1_nr_5x3_1_r_5x5__B__1_nr_1x1_1_nr_1x4_1_nr_4x1_1_r_4x4__B__1_nr_3x3_1_nr_3x1_1_nr_1x3_1_nr_1x1
"""

import ast
import numpy as np

name = ""
final_name = ""


def generate_configuration_name(configuaration_array):
    
    global name
    global final_name
    
    try:
        configuaration_array = np.array(configuaration_array)
    
        if configuaration_array.shape == (4, 2):
            n_bits = configuaration_array[1][0] + configuaration_array[1][1]
            config_name = f"rr{n_bits}x{n_bits}__B__"
            
            for item in configuaration_array:
                config_name += f"nr{item[0]}x{item[1]}__"
                
            config_name += "B__"
            
            configuaration_array = np.array([n_bits, n_bits]).tolist()
            
            # name += config_name
            return (config_name, configuaration_array)
        else:
            return ("", configuaration_array.tolist())
    
    except ValueError:
        # print(f"Giving value error for {configuaration_array}")
        
        list_of_indices = []
        list_of_names = []
        
        for index, item in enumerate(configuaration_array):
            
            # print(f"In ValueError Part item is {item}")
            x = generate_configuration_name(item)
            if x is not None:
                y = x[1]
                x = x[0]
                # print(f"In ValueError Part {x}, {y}")
            
            if x != "":
                configuaration_array[index] = y
                list_of_indices.append(index)
                list_of_names.append(x)
            
        
        configuaration_array = np.array(configuaration_array)
    
        if configuaration_array.shape == (4, 2):
            n_bits = configuaration_array[1][0] + configuaration_array[1][1]
            config_name = f"rr{n_bits}x{n_bits}__B__"

            
            for index, item in enumerate(configuaration_array):
                
                if index not in list_of_indices:
                    config_name += f"nr{item[0]}x{item[1]}__"
                else:
                    # print(f"List of names: {list_of_indices.index(index)}")
                    config_name += list_of_names[list_of_indices.index(index)]
                
            config_name += "B__"
            
            configuaration_array = np.array([n_bits, n_bits]).tolist()
            
            # print(f"Adding Name: {config_name}")
            name += config_name
            final_name = config_name
            return (config_name, configuaration_array)
        else:
            return ("", configuaration_array.tolist())
        

    
    
def main():
    configs = []
    with open("configs.dat","r") as f:
        for line in f:
            line = line.strip()     
            if line:                
                configs.append(line)

    with open("configs_name.dat", "w") as f:
        for config in configs:
            config = ast.literal_eval(config)
            # print(type(config).__name__)
            name = generate_configuration_name(list(config))[0]
            # print(name)
            f.write(f"{name}\n")

    # config = [[6, 6], [6, 2], [2, 6], [2, 2]]
    # print(generate_configuration_name(config)[0])

    
if __name__=="__main__":
    main()