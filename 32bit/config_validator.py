"""
This code basically takes a configuration and checks if it is a valid configuration or not.
The idea for this code is that we will generate the config dict list and verify if the configurations there are correct or not.

The validator function follows a recursion. We pass the bit to check if the mxm multiplier exists in the circuit or not.
At the end of the recursion if some number still has positive count that means it never occured in the multplier.
"""

import generate_list_config as glc
import numpy as np

flag = True

def config_validator(n_bits, config_array):
    
    config_array = config_array.tolist()
    global flag
    flag = True
    if flag == False:
        return False
    
    # try:
    #     # Generate configuration dictionaries
    #     x, y = glc.generate_config_dict(n_bits, config_array)
        
    #     # Print the contents of the dictionaries for debugging
    #     for key in x:
    #         print(key, x[key])
        
    #     for key in y:
    #         print(key, y[key])
        
    #     Tval = True
        
    #     # Check 1: Validate the lengths in y against x
    #     for key in y:
    #         if y[key] != 0 and len(x[key]) != 0:
    #             if y[key] == len(x[key]):
    #                 continue
    #             else: 
    #                 Tval = False
    #                 # print("False in 1")
        
    #     # Check 2: Validate specific conditions for each config in x
    #     if Tval:
    #         for key in y:
    #             if y[key] != 0:
    #                 for config in x[key]:
    #                     if (key > config[0][0]) and (key > config[3][0]) and (config[0][0] + config[3][0] == key):
    #                         # print(key, config[0][0], config[3][0])
    #                         continue
    #                     else: 
    #                         Tval = False
        
    #     return Tval
    
    # except Exception as e:
    #     print(f"An error occurred: {e}")
    #     return False
    
    # Generate configuration dictionaries
    x, y = glc.generate_config_dict(n_bits, config_array)
    
    # Print the contents of the dictionaries for debugging
    # for key in x:
    #     print(key, x[key])
    
    # for key in y:
    #     print(key, y[key])
        
    # if y[n_bits] != 1:
    #     # print("False 1")
    #     return False
    
    for i in range (0, n_bits):
        repeating_value = config_array[i] # To check if the repeating_value is actually repeating or not
        if n_bits - i > 2:
            # print(y[n_bits - i], repeating_value, n_bits - i)
            if repeating_value == -1:
                if y[n_bits - i] > 1 and (n_bits - i) > int(n_bits/2):
                    # print("False 2", n_bits-i)
                    return False
    
    
    y[n_bits] = 1
    config_validator_recursive(n_bits, x, y)
    
    # print("PRINTING")
    # Print the contents of the dictionaries for debugging
    # for key in x:
    #     print(key, x[key])
    
    # for key in y:
    #     print(key, y[key])
    
    for key in y:
        if y[key] > 0:
            return False
            
    else:
        return True

def config_validator_recursive(n_bits, config_dict, config_count_dict):
    
    # print(type(config_dict[n_bits]), n_bits)
    # print(f"Starting for {n_bits}")
    global flag
    if flag == False:
        # print(f"Returning due to false for {n_bits}")
        return
    
    # print("Printing", n_bits)
    # for key in config_count_dict:
    #     print(key, config_count_dict[key])
    
    if n_bits <= 2:
        return
    
    index = config_count_dict[n_bits] - 1
    
    config_count_dict[n_bits] -= 1
    if len(config_dict[n_bits]) == 0:
        # print(f"Returning due to config len for {n_bits}")
        return
    if index < 0:
        # print(f"Returning for {n_bits}")
        return
    
    # print(f"Deleted Config for {n_bits}")
    config = config_dict[n_bits][0]
    # if len(config) == 0:
    #     return
    # print(config)
    
    if config != []:
        H = config[0][0]
        L = config[3][0]
        
        if L <= 0 or H <= 0 or L >= n_bits or H >= n_bits:
            flag = False
        
        del config_dict[n_bits][0]
        
        # print(f"H={H}, L={L}")
        
        if H == L:
            # print("Going into equal")
            config_validator_recursive(H, config_dict, config_count_dict)
            config_validator_recursive(H, config_dict, config_count_dict)
            config_validator_recursive(H, config_dict, config_count_dict)
            config_validator_recursive(H, config_dict, config_count_dict)
        
        else:
            config_validator_recursive(H, config_dict, config_count_dict)
            config_validator_recursive(L, config_dict, config_count_dict)
    else:
        del config_dict[n_bits][0]
            
        

def main():
    x = config_validator(32, np.array([16, 1, 11, 1, -1, 1, 5, 3, -1, -1, 13, -1, 7, 3, 1, 1, 5, -1, 11, 2, 1, 3, 1, 1, -1, 3, 1, 3, -1, 3, -1, 1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))
    print(x)
    
if __name__ == "__main__":
    main()
    