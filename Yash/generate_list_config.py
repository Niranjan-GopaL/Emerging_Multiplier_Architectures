"""
Assume we have an array [5 -1 -1 3 -1 0 -1 -1 2 -1 -1 -1]

This will correspond to the configuration [[[[2,2], [2,1], [1,2], [1,1]], [3,2], [2,3], [2,2]], [5,3], [3,5], [3,3]]

What this code needs to generate is this:
{
    8: [[5,5], [5,3], [3,5], [3,3]]
    7: -1
    6: -1
    5: [[3,3], [3,2], [2,3], [2,2]]
    4: -1
    3: [[2,1], [2,1], [1,2], [1,1]]
    2: -1
}

From the 1D Array
"""

from itertools import count
from typing import KeysView
import generate_temp_config as gtc

repeating_index = 0

# def generate_config_dict(n_bits, array):
    
#     count_dict = {} # This dictionary stores how many nxn multipliers are there in the final configuration
#     count_dict_return = {}
#     config_dict = {} # This dictionary stores the configuration used
#     repeated_configs = set()
#     for i in range(2, n_bits+1):
#         count_dict[i] = 0
#         count_dict_return[i] = 0
#         config_dict[i] = []
    
#     BIT_TRACKER = n_bits
#     # count_dict_return[BIT_TRACKER] += 1 
#     for i in range(0, len(array)):
        
#         # print(f"Index = {i}")
#         # print(f"Array = {array}")
#         config_value = array[i]
#         # print("Printing COUNT DICT RETURN")
#         # print(count_dict_return)
#         # print(f"Printing BIT TRACKER = {BIT_TRACKER}")
#         # print(f"Printing CONFIG VALUE = {config_value}")
#         if BIT_TRACKER > 0 and config_value != 0 and config_value != -1:
#             temp_config, H, L = gtc.generate_temp_config(config_value, BIT_TRACKER)
#             # print(f"Printing Temp Config = {temp_config}")
#             # print(f"H = {H}, L = {L}")
            
#             if BIT_TRACKER > 2:
#                 # count_dict_return[BIT_TRACKER] += 1 
#                 count_dict[BIT_TRACKER] -= 1
#                 # print(H, L, BIT_TRACKER)
#                 # print("Printing COUNT DICT RETURN")
#                 # print(count_dict_return)
                
#                 if H != L:
#                     config_dict[BIT_TRACKER].append(temp_config)
#                     if H > 2: count_dict[H] += 1
#                     if L > 2: count_dict[L] += 1
                    
#                     if H > 2: count_dict_return[H] += 1
#                     if L > 2: count_dict_return[L] += 1
#                 else:
#                     # print("In Else")
#                     config_dict[BIT_TRACKER].append(temp_config)
#                     if H > 2: count_dict[H] += 2
#                     if L > 2: count_dict[L] += 2
                    
#                     if H > 2: count_dict_return[H] += 2
#                     if L > 2: count_dict_return[L] += 2
                    
#                     # print(f"Updated Count Dict has count_dict[{H}] = {count_dict_return[H]}")
                
            
            
            
#             # count_dict_return[H] += 1
#             # count_dict_return[L] += 1
            
#         elif BIT_TRACKER > 0 and array[i] == 0:
#             repeated_configs.add(BIT_TRACKER)
#         elif BIT_TRACKER <= 0:
#             # print("starting loop")
#             # print(count_dict, BIT_TRACKER)
#             # print("Printing COUNT DICT RETURN")
#             # print(count_dict_return)
#             for key in count_dict:
#                 if key != n_bits:
#                     if count_dict[key] != 0 and config_value != 0:
#                         # print(f"COUNT DICT = {count_dict}")
#                         # print(i, config_value, key)
#                         if config_value == -1 and key != n_bits:
#                             # print(f"Appending [] for {key}")
#                             config_dict[key].append([])
#                             count_dict[key] -= 1
#                             # count_dict_return[key] -= 1
#                             break
#                         # print(f"key chosen={key}")
#                         # print(count_dict)
#                         temp_config, H, L = gtc.generate_temp_config(config_value, key)
#                         # print(f"Temp Config = {temp_config}")
#                         config_dict[key].append(temp_config)
                        
                        
#                         count_dict[key] -= 1
#                         # count_dict_return[key] += 1
#                         # print(key, config_dict[key], count_dict[key], count_dict)
                        
#                         if L != H:
#                             if H > 2:
#                                 # print(f"H={H}")
#                                 count_dict[H] += 1
                                
                                
#                                 count_dict_return[H] += 1
#                             if L > 2:
#                                 # print(f"L={L}")
#                                 count_dict[L] += 1
                                
#                                 count_dict_return[L] += 1
#                         else:
#                             if H > 2:
#                                 # print(f"H_equal={H}")
#                                 count_dict[H] += 4
#                                 count_dict_return[H] += 4
#                         # print("breaking")
#                         break
            
#         BIT_TRACKER -= 1
    
#     # for key in config_dict:
#     #     count_dict_return[key] = len(config_dict[key])
#     # print(config_dict)
#     # print(count_dict_return)
#     return config_dict, count_dict_return

def generate_config_dict(n_bits, array):
    
    global repeating_index
    repeating_index = 0
    count_of_bits = {}
    count_of_bits_return = {}
    config_dict = {}
    
    for i in range(3, n_bits+1):
        count_of_bits[i] = 0
        count_of_bits_return[i] = 0
        config_dict[i] = []
    generate_list_config_non_repeating(config_dict, count_of_bits, count_of_bits_return, n_bits, n_bits, array)
    
    repeating_array = array[n_bits : ]
    
    for i in range(n_bits, 2, -1):
        
        if count_of_bits[i] > 1:
            
            while count_of_bits[i] != 0:
                count_of_bits[i] -= 1
                # print(f"Index={repeating_index}")
                generate_list_config_repeating(config_dict, count_of_bits_return, i, repeating_array)
                
                
    
    return config_dict, count_of_bits_return

def generate_list_config_non_repeating(config_dict, count_of_bits, count_of_bits_return, n_bits, N_BITS, array):
    
    index = N_BITS - n_bits
    config_value = array[index]
    if n_bits <= 2:
        return
    
    # print(f"Incrementing Count for {n_bits}")
    if config_value == -1:
        count_of_bits_return[n_bits] += 1
        count_of_bits[n_bits] += 1
        # if config_value == -1:
        config_dict[n_bits].append([])
        return 
    count_of_bits_return[n_bits] += 1
    count_of_bits[n_bits] += 1
    if config_value == 0:
        return
    high_bits = config_value
    low_bits = n_bits - config_value
    
    if high_bits == low_bits:
        # count_of_bits[high_bits] += 4
        # count_of_bits_return[high_bits] += 4
        config_dict[n_bits].append([[high_bits, high_bits], [high_bits, high_bits], [high_bits, high_bits], [high_bits, high_bits]])
        generate_list_config_non_repeating(config_dict, count_of_bits, count_of_bits_return, high_bits, N_BITS, array)
        generate_list_config_non_repeating(config_dict, count_of_bits, count_of_bits_return, high_bits, N_BITS, array)
        generate_list_config_non_repeating(config_dict, count_of_bits, count_of_bits_return, high_bits, N_BITS, array)
        generate_list_config_non_repeating(config_dict, count_of_bits, count_of_bits_return, high_bits, N_BITS, array)
    else:
        config_dict[n_bits].append([[high_bits, high_bits], [high_bits, low_bits], [low_bits, high_bits], [low_bits, low_bits]])
        generate_list_config_non_repeating(config_dict, count_of_bits, count_of_bits_return, max(high_bits, low_bits), N_BITS, array)
        generate_list_config_non_repeating(config_dict, count_of_bits, count_of_bits_return, min(high_bits, low_bits), N_BITS, array)

def generate_list_config_repeating(config_dict, count_of_bits_return, n_bits, array):
    
    global repeating_index
    # count_of_bits[n_bits] -= 1
    if n_bits <= 2:
        return 
    
    # print(len(array), re)
    config = array[repeating_index]
    repeating_index += 1
    
    
    if config == -1:
        config_dict[n_bits].append([])
        return 
        
    else:
        
        high_bits = config
        low_bits = n_bits - config
        
        if high_bits != low_bits:
            if high_bits > 2:
                count_of_bits_return[high_bits] += 1
            if low_bits > 2:
                count_of_bits_return[low_bits] += 1
            
            config_dict[n_bits].append([[high_bits, high_bits], [high_bits, low_bits], [low_bits, high_bits], [low_bits, low_bits]])
            
            if min(high_bits, low_bits) > 2:
                generate_list_config_repeating(config_dict, count_of_bits_return, min(high_bits, low_bits), array)
            if max(high_bits, low_bits) > 2:
                generate_list_config_repeating(config_dict, count_of_bits_return, max(high_bits, low_bits), array)
            
        else:
            if high_bits > 2:
                count_of_bits_return[high_bits] += 4
                config_dict[n_bits].append([[high_bits, high_bits], [high_bits, high_bits], [high_bits, high_bits], [high_bits, high_bits]])
                generate_list_config_repeating(config_dict, count_of_bits_return, high_bits, array)
                generate_list_config_repeating(config_dict, count_of_bits_return, high_bits, array)
                generate_list_config_repeating(config_dict, count_of_bits_return, high_bits, array)
                generate_list_config_repeating(config_dict, count_of_bits_return, high_bits, array)
            
            
def main():
#     [[ 6 -1  3 -1 -1  0 -1 -1  1 -1 -1  1 -1 -1 -1 -1]
#  [ 1  2 -1  1  1  1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1]
#  [ 6 -1  3 -1 -1  0 -1 -1  1  1  1  1 -1 -1 -1 -1]
#  [ 1  1  2 -1  2 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1]
#  [ 1  1  1  3 -1  1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1]
#  [ 1  1  3 -1 -1  0 -1 -1  1 -1 -1 -1 -1 -1 -1 -1]
#  [ 2 -1  3 -1 -1  0 -1 -1  1  1  1  1 -1 -1 -1 -1]
#  [ 6 -1  3 -1 -1  0 -1 -1  1  1 -1  1 -1 -1 -1 -1]
#  [ 1  5 -1  3 -1  1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1]]
    N_BITS = 8
    array = [2, -1, 7, -1, -1, -1, -1, -1, -1, 0, -1, -1, -1, -1, -1, -1, 1, 3, -1, -1, 4, -1, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
    # print(len(array))
    temp_array = [-1]*(52 - len(array))
    array = array + temp_array
    
    # print(len(array))
    x, y = generate_config_dict(N_BITS, array)
    
    for key in x:
        print(key, x[key])
        
    for key in y:
        print(key, y[key])
        
        
if __name__ == "__main__":
    main()