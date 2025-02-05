"""
Author: Yash Sengupta and Niranjan Gopal, IIITB, under guidance of Prof. Madhav Rao.
This code takes in a configuration in the form of a list and outputs a name. That name will be used to model the multipliers.

Ex:
Configuration: [[3, 3], [3, 5], [5, 3], [[1, 1], [1, 4], [4, 1], [[3, 3], [3, 1], [1, 3], [1, 1]]]]
Output: r_8x8__B__1_nr_3x3_1_nr_3x5_1_nr_5x3_1_r_5x5__B__1_nr_1x1_1_nr_1x4_1_nr_4x1_1_r_4x4__B__1_nr_3x3_1_nr_3x1_1_nr_1x3_1_nr_1x1
"""

import numpy as np

name = ""
final_name = ""
list_of_nr_multipliers = []

# configuration_array => entire mutliuplier, entire mutliuplier converted to nmpy array, parent module :- [3,3]
def generate_configuration_name(configuaration_array):
    
    global name
    global final_name
    global list_of_nr_multipliers

    # print("====================================")
    # print(f"name, {name}")
    # print(f"final_name, {final_name}")
    # print(f"list_of_nr_multipliers, {list_of_nr_multipliers}")

    try:
        # where can ValueError happen ? numpy can convert to array ONLY IF ELEMENTS ARE HOMOGENOUS => [ [[]]  []  "" ] these are not allowed
        # ERROR precisly happens when WE GET A HOMOGENEOUS ARRAY  =>  [ [] [] [] []  ]
        # print(f"THIS IS configuaration_array ... {configuaration_array}")
        configuaration_array = np.array(configuaration_array)
        # Manually go to Exception when shape is 4,4,2 etc
        if not (configuaration_array.shape == (4, 2) or configuaration_array.shape == (2,)):
            configuaration_array = configuaration_array.tolist()
            # print(type(configuaration_array))
            raise ValueError("Forced ValueError for shapes OTHER THAN (4, 2) or (2,)")
        # possible values for configuration array := [3,2] ; [ [1,1] [1,2] [2,1] [2,2] ] ; entire multiplier mult-dim array
        # print(f"shape of configuaration_array: {configuaration_array.shape}")
        # this will only be triggered in [ [],  [], [], [] ] case ?
        if configuaration_array.shape == (4, 2):
            n_bits = configuaration_array[1][0] + configuaration_array[1][1]
            config_name = f"rr{n_bits}x{n_bits}__B__"
            for item in configuaration_array:
                config_name += f"nr{item[0]}x{item[1]}__"
                list_of_nr_multipliers.append([int(item[0]), int(item[1])])
            config_name += "B__"
            # by this point, we have the complete config_name ready
            configuaration_array = np.array([n_bits, n_bits]).tolist()
            # we return THE NAME of the smalled 4-some [ [] [] [] [] ] and this sub-module MULTIPLIER is 
            # print(f"Adding Name: {config_name}, the submodule it corresponds to is :- {configuaration_array}")
            return (config_name, configuaration_array)
        elif configuaration_array.shape == (2,):
            # when configuration_array is [3,2] ( 2 values 1d array, smallest block ) 
            # print(f"WHEN THE FUCK DOES THIS return PRINT ANYTHING ????????????????????????????????? {configuaration_array}")
            return ("", configuaration_array.tolist())
    
    except ValueError:
        # print(f"name, {name}")
        # print(f"final_name, {final_name}")
        # print(f"list_of_nr_multipliers, {list_of_nr_multipliers}")
        # print(f"Giving value error for {configuaration_array}")
        
        # WHAT are these index, name used for ???
        list_of_indices = []
        list_of_names = []

        for index, item in enumerate(configuaration_array):
            # print(f"In ValueError Part item is {item}")
            # print(f"\n\n\nBegin recursion {item}")
            return_val_of_try = generate_configuration_name(item)
            # print(f"\n\n\n|||||||||||||||||||||||||||||||||||||End recursion {item}")
            # print(f"========================================= THIS IS THE END OF THE RECURSION for {item}")          
            parent_module = return_val_of_try[1]
            config_name_or_empty_str = return_val_of_try[0]
            # print(f"In ValueError Part {return_val_of_try}, {y}")
            if config_name_or_empty_str != "":
                # print(f"Replacing {configuaration_array[index]} with {parent_module}")
                configuaration_array[index] = parent_module
                list_of_indices.append(index)
                # print("list of indeices", list_of_indices)
                # print("list of names", list_of_names)
                list_of_names.append(config_name_or_empty_str)
        
        # print(f"\n\n\n\n<-------------------------------- AFTER out of the LOOP :- {configuaration_array}")
        # print("-------------------------------- list of indeices", list_of_indices)
        # print("--------------------------------- list of names", list_of_names)
        # THIS CAN RAISE VALUE ERROR AGAIN ????
        # print(configuaration_array)
        configuaration_array = np.array(configuaration_array)
    
        if configuaration_array.shape == (4, 2):
            n_bits = configuaration_array[1][0] + configuaration_array[1][1]
            config_name = f"rr{n_bits}x{n_bits}__B__"
            for index, item in enumerate(configuaration_array):
                # if THIS INDEX is in the list => add the name from the LIST_OF_NAMES ( it's a recursive module whose name we have already calculated in try block )
                if index not in list_of_indices:
                    config_name += f"nr{item[0]}x{item[1]}__"
                    list_of_nr_multipliers.append([int(item[0]), int(item[1])])
                else:
                    # print(f"List of names: {list_of_indices.index(index)}")
                    config_name += list_of_names[list_of_indices.index(index)]
            config_name += "B__"
            # print(f"+++++++++++++++++++++++++++++++++++++++++++++AFTER LOOP, name is {config_name}")
            configuaration_array = np.array([n_bits, n_bits]).tolist()
            
            # print(f"Adding Name: {config_name}")
            name += config_name
            final_name = config_name
            
            return (config_name, configuaration_array)
        else:
            return ("", configuaration_array.tolist())        
    
    
def main():
    config = [[[[1, 1], [1, 2], [2, 1], [2, 2]], [[1, 1], [1, 2], [2, 1], [2, 2]], [[1, 1], [1, 2], [2, 1], [2, 2]], [[1, 1], [1, 2], [2, 1], [2, 2]]], [6, 2], [2, 6], [2, 2]]
    # config = [[[[2, 2], [2, 1], [1, 2], [1, 1]], [3, 2], [2, 3], [2, 2]], [5, 3], [3, 5], [[2, 2], [2, 1], [1, 2], [1, 1]]]
    # predicted error giving config
    # config = [ [[2,2], [2,2], [2,2], [2,2]] ,  [[2,2], [2,2], [2,2], [2,2]] ,  [[2,2], [2,2], [2,2], [2,2]] ,  [[2,2], [2,2], [2,2], [2,2]] ]
    
    print(generate_configuration_name(config)[0])
    
if __name__=="__main__":
    main()