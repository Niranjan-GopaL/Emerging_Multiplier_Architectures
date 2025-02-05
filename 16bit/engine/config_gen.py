"""
Author: Yash Sengupta, IIITB, under guidance of Prof. Madhav Rao.
This code generates all possible configurations of a multiplier possible for given number of bits
"""

import copy

CONFIGURATIONS = {}         # This dictionary will store the possible configurations as bits
CURRENT_CONFIGURATION = 0   # This will keep track of the current configuration and will act as the key of the configuration value

def valid_configuration_for_further_decomposition(n_high_bits, n_low_bits):
    # We don't decompose MxN, 1x1 ,2x2 

    tval = True
    
    if n_high_bits != n_low_bits:
        tval = False
    elif n_high_bits == 1 or n_high_bits == 2:
        tval = False
        
    return tval
    

def generate_configurations(n_bits):
    # print("---------------------------------------")
    # print("Generating configurations for", n_bits)
    # print(CONFIGURATIONS)

    CURRENT_CONFIGURATION = n_bits
    if n_bits not in CONFIGURATIONS.keys():
        CONFIGURATIONS[n_bits] = []
    
    for i in range(1, n_bits):
        
        # print(f"Generating configurations for {i} and {n_bits-i}") 
        n_high_bits = i
        n_low_bits = n_bits - i
        
        possible_configuration = [[n_high_bits, n_high_bits], [n_high_bits, n_low_bits], [n_low_bits, n_high_bits], [n_low_bits, n_low_bits]] # This is one possible configuration
        # print(possible_configuration)
        CONFIGURATIONS[CURRENT_CONFIGURATION].append(possible_configuration)
        # print(CONFIGURATIONS)
        
        for configuration in possible_configuration:
            
            n_high_bits_configuration, n_low_bits_configuration = configuration
            
            if valid_configuration_for_further_decomposition(n_high_bits_configuration, n_low_bits_configuration):
                # print(f"VALID DECOMPOSITION FOUND !!! new new_bits = {n_high_bits_configuration}\n\n\n")
                generate_configurations(n_high_bits_configuration)
                # print("\n\n\n")
                # print("RECURSION OVER FOR ", n_high_bits_configuration)
            
def filter_configurations():
    global CONFIGURATIONS

    for key in CONFIGURATIONS:
        # Convert inner lists to tuples for hashability
        CONFIGURATIONS[key] = list(set(tuple(map(tuple, config)) for config in CONFIGURATIONS[key]))
        # Optionally convert tuples back to lists if needed
        CONFIGURATIONS[key] = [list(map(list, config)) for config in CONFIGURATIONS[key]]

    
                
def main():
    n_bits = 8
    generate_configurations(n_bits=n_bits)
    
    
    filter_configurations()
    
    TEMPORARY_CONFIGURATIONS = copy.deepcopy(CONFIGURATIONS)
    
    for key in range(3, n_bits+1):
        for configuration in TEMPORARY_CONFIGURATIONS[key]:

            for index, item in enumerate(configuration):

                item_high_bits, item_low_bits = item
                
                if valid_configuration_for_further_decomposition(item_high_bits, item_low_bits):
                    list_configuration_to_fill = CONFIGURATIONS[item_high_bits]
                    
                    temporary_configuration = copy.deepcopy(configuration)

                    for configuration_to_fill in list_configuration_to_fill:
                        new_configuration = copy.deepcopy(temporary_configuration)
                        new_configuration[index] = configuration_to_fill

                        CONFIGURATIONS[key].append(new_configuration)
                     
    for key in CONFIGURATIONS:
        if key == 8:
            # print(key, "----------------------------------------------")
            with open("configs.dat", "w") as f:
                for index, item in enumerate(CONFIGURATIONS[key]):
                    # print(index, item)
                    f.write(f"{item}\n")

    # print(CONFIGURATIONS[8])
            

if __name__ == "__main__":
    main()