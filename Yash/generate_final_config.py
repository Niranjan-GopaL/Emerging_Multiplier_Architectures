"""
Assume we have an array [5 -1 -1 3 -1 0 -1 -1 2 -1 -1 -1]

This will correspond to the configuration [[[[2,2], [2,1], [1,2], [1,1]], [3,2], [2,3], [2,2]], [5,3], [3,5], [3,3]]

What this code needs to generate is this: [[[[2,2], [2,1], [1,2], [1,1]], [3,2], [2,3], [2,2]], [5,3], [3,5], [3,3]]

From:
{
    8: [[5,5], [5,3], [3,5], [3,3]]
    7: []
    6: -1
    5: [[3,3], [3,2], [2,3], [2,2]]
    4: []
    3: [[2,1], [2,1], [1,2], [1,1]]
    2: []
}

The idea is basically a recursive approach.
"""

COUNT = 7

import generate_list_config as glc
import generate_temp_config as gtc
import numpy as np

def generate_final_config(n_bits, array):
    
    array = array.tolist()
    
    config_dict, repeated_config_count = glc.generate_config_dict(n_bits, array)
    
    print(config_dict)
    print(repeated_config_count)
    
    final_configuration = generate_final_config_recursive(n_bits=n_bits, config_dict=config_dict, repeated_config_count=repeated_config_count, array=array)
    
    return final_configuration
    

def generate_final_config_recursive(n_bits, config_dict, repeated_config_count, array):
    
    global COUNT
    
    # print("N_Bits:", n_bits)
    if n_bits <= 1:
        # print("Returning None as N_Bits")
        return None
    if config_dict[n_bits] == []:
        # print("Returning None as config_dict")
        return None
    
    else:
        if repeated_config_count[n_bits] > 0:
            # print(f"COUNT={COUNT}")
            if array[COUNT] == 0:
                COUNT += 1
                # print("Returning None as COUNT")
                return None
            COUNT += 1
        # print(repeated_config_count)
        index = repeated_config_count[n_bits] - 1
        repeated_config_count[n_bits] -= 1
        
        # print(repeated_config_count)
        # print(n_bits, index)
        if index < 0:
            return None
        
        
        config = config_dict[n_bits][0] + []
        del config_dict[n_bits][0]
        
        high_bits = config[0][0]
        low_bits = config[3][0]
        
        # print(f"{high_bits}, {low_bits}")
        
        if high_bits != low_bits:
            high_config = generate_final_config_recursive(high_bits, config_dict, repeated_config_count, array)
            # print("HIGH", high_config)
            low_config = generate_final_config_recursive(low_bits, config_dict, repeated_config_count, array)
            # print("LOW", low_config)
            
            if high_config != None:
                config[0] = high_config
            
            if low_config != None:
                config[3] = low_config
        
        else:
            # print("Entering Equal high, low configuration.")
            # print("HIGH....")
            high_config = generate_final_config_recursive(high_bits, config_dict, repeated_config_count, array)
            # print("MID1....")
            mid1_config = generate_final_config_recursive(high_bits, config_dict, repeated_config_count, array)
            # print("MID2....")
            mid2_config = generate_final_config_recursive(high_bits, config_dict, repeated_config_count, array)
            # print("LOW....")
            low_config = generate_final_config_recursive(high_bits, config_dict, repeated_config_count, array)
            
            if high_config != None:
                config[0] = high_config
            if mid1_config != None:
                config[1] = mid1_config
            if mid2_config != None:
                config[2] = mid2_config
            if low_config != None:
                config[3] = low_config
            
        
        return config
        
def main():
    n_bits = 8
    array = np.array([6, -1, 4, -1, 3, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])
    
    final_configuration = generate_final_config(n_bits=8, array=array)
    
    print(final_configuration)
    
if __name__ == "__main__":
    main()
    