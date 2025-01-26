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

import generate_temp_config as gtc

def generate_config_dict(n_bits, array):
    
    count_dict = {} # This dictionary stores how many nxn multipliers are there in the final configuration
    count_dict_return = {}
    config_dict = {} # This dictionary stores the configuration used
    repeated_configs = set()
    for i in range(2, n_bits+1):
        count_dict[i] = 0
        count_dict_return[i] = 0
        config_dict[i] = []
    
    BIT_TRACKER = n_bits
    count_dict_return[BIT_TRACKER] += 1 
    for i in range(0, len(array)):
                   
        config_value = array[i]
        # print(count_dict_return)
        if BIT_TRACKER > 0 and config_value != 0 and config_value != -1:
            temp_config, H, L = gtc.generate_temp_config(config_value, BIT_TRACKER)
            
            if BIT_TRACKER > 2:
                # count_dict_return[BIT_TRACKER] += 1 
                # print(H, L, BIT_TRACKER)
                
                if H != L:
                    config_dict[BIT_TRACKER].append(temp_config)
                    if H > 2: count_dict[H] += 1
                    if L > 2: count_dict[L] += 1
                    
                    if H > 2: count_dict_return[H] += 1
                    if L > 2: count_dict_return[L] += 1
                else:
                    # print("In Else")
                    config_dict[BIT_TRACKER].append(temp_config)
                    if H > 2: count_dict[H] += 2
                    if L > 2: count_dict[L] += 2
                    
                    if H > 2: count_dict_return[H] += 2
                    if L > 2: count_dict_return[L] += 2
                
            
            
            
            # count_dict_return[H] += 1
            # count_dict_return[L] += 1
            
        elif BIT_TRACKER > 0 and array[i] == 0:
            repeated_configs.add(BIT_TRACKER)
        elif BIT_TRACKER <= 0:
            # print("starting loop")
            # print(count_dict, BIT_TRACKER)
            for key in count_dict:
                if count_dict[key] != 0 and config_value != 0:
                    # print(i, config_value)
                    if config_value == -1:
                        count_dict[key] -= 1
                        break
                    # print(f"key chosen={key}")
                    # print(count_dict)
                    temp_config, H, L = gtc.generate_temp_config(config_value, key)
                    config_dict[key].append(temp_config)
                    
                    
                    count_dict[key] -= 1
                    # print(key, config_dict[key], count_dict[key], count_dict)
                    
                    if H > 2:
                        # print(f"H={H}")
                        count_dict[H] += 1
                        
                        
                        count_dict_return[H] += 1
                    if L > 2:
                        # print(f"L={L}")
                        count_dict[L] += 1
                        
                        count_dict_return[L] += 1
                    # print("breaking")
                    break
            
        BIT_TRACKER -= 1
    
    # for key in config_dict:
    #     count_dict_return[key] = len(config_dict[key])
    return config_dict, count_dict_return

def main():
    x, y = generate_config_dict(8, [5, -1, -1, 3, -1, -1, -1, -1, 2, 2, -1, -1, -1, -1, -1, -1])
    
    for key in x:
        print(key, x[key])
        
    for key in y:
        print(key, y[key])
        
        
if __name__ == "__main__":
    main()