# This code generates a random initialization.
import random
from random import choice
import numpy as np

Y = []
config_dict = {}
def custom_mutation(X):
    
    Xp = []
    # print("Inside Custom Mutation")
    # print(f"X={X}")
    # print(type(X))
    COUNT = 0
    
    global config_dict
    global Y
    
    for item in X:
        l = len(item)
        N_BITS  = int(l / 2)
        config_dict = {}
        
        # print("Custom Mutation")
        for i in range(1, N_BITS + 1):
            config_dict[i] = 0
        
        Y = [-1] * l
        
        custom_mutation_recursive(0, 8, 8, config_dict)
        
        
        
        for i in range(3, N_BITS+1):
            if config_dict[i] >= 2:
                COUNT += config_dict[i]
                # config_dict[i] = 0
                Y[N_BITS - i] = 0
        # print(f"COUNT={COUNT}")
        
        for i in range(N_BITS, l):
            if COUNT != 0:
                limit = int(N_BITS / 2)
                Y[i] = choice([i for i in range(-1,limit) if i not in [0]])
                COUNT -= 1
        Xp.append(Y)
    # print(config_dict)
    Xp = np.array(Xp)
    # print(f"Xp={Xp}")
    return Xp
            
            

def custom_mutation_recursive(index, curr_bits, N_BITS, config_dict):
    
    global Y
 
    # print(f"Index={index}, N_BITS={curr_bits}")
    limit = N_BITS - index
    
    if curr_bits == 1 or curr_bits == 2:
        limit = 0
    # print(f"limit={limit}")
    config_number = choice([i for i in range(-1,limit) if i not in [0]])
    
    if curr_bits == N_BITS:
        config_number = choice([i for i in range(1,limit) if i not in [0]])
    
    # print(f"config_number={config_number}")
    
    if config_number != -1:
        config_dict[curr_bits] += 1
    
    Y[index] = config_number
    # print(f"Y={Y}")
    
    if config_number != -1:
        
        high_bits = config_number
        low_bits = curr_bits - config_number
        index_high = N_BITS - high_bits
        index_low = N_BITS - low_bits
        # print(f"High_Bits={high_bits}, Low_Bits={low_bits}")

        custom_mutation_recursive(index_low, low_bits, N_BITS, config_dict)
        custom_mutation_recursive(index_high, high_bits, N_BITS, config_dict)


def main():
    
    set_of_config = set()
    with open("configs.dat", "w") as file:
        for i in range(0, 2000000):
            custom_mutation([5, -1, -1, 4, 3, 0, -1, -1, 2, 1, -1, -1, -1, -1, -1, -1])
            file.write(str(Y) + "\n")
            set_of_config.add(tuple(Y))
    print(len(set_of_config))
    
if __name__ == "__main__":
    main()
    
    