# This code generates a random initialization.
# [8, -1, -1, -1, -1, -1, -1, -1, 0, -1, -1, -1, -1, -1, -1, -1, 3, 1, 1, 2, 4, 1, -1, 2, 5, -1, 2, 1, 6, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
from itertools import count
import random
from random import choice
from re import A
import numpy as np
from pprint import pprint

import config_validator as cv

Y = []
TRACKER = {}
REPEATING_CONFIG = []

def DynamicCustomMutation(array, bit, count_of_bits):
    
    global Y
    global TRACKER
    l = len(array)
    # print(f"Bit={bit}, count={count_of_bits[bit]}")
    
    if bit > 2:
        N_BITS = 1
        if l == 16:
            N_BITS = 8
        elif l == 52:
            N_BITS = 16
        elif l == 180:
            N_BITS = 32
            
        index = N_BITS - bit
        
        if count_of_bits[bit] > 1:
            # count_of_bits[bit] += 1
            Y[index] = 0
        
        else:
            # count_of_bits[bit] += 1
            limit = bit - 1
            # print(f"Limit for {bit} = {limit}")
            if bit != N_BITS:
                Y[index] = choice([i for i in range(-1,limit) if i not in [0]])
            else:
                Y[index] = choice([i for i in range(1,limit) if i not in [0]])
            
            config_value = Y[index]
            # print(f"Config Value for {bit} = {config_value}")
            
            if config_value != -1:
                high_bits = config_value
                low_bits = bit - config_value
                
                # print(f"High={high_bits}, Low={low_bits}")
                
                if high_bits != low_bits:
                    TRACKER[bit].append((high_bits, low_bits))
                    if high_bits > 2:
                        count_of_bits[high_bits] += 1
                    if low_bits > 2:
                        count_of_bits[low_bits] += 1
                    
                    if max(high_bits, low_bits) > 2:
                        DynamicCustomMutation(array, max(high_bits, low_bits), count_of_bits)
                    if min(high_bits, low_bits) > 2:
                        DynamicCustomMutation(array, min(high_bits, low_bits), count_of_bits)
                else:
                    if high_bits > 2:
                        count_of_bits[high_bits] += 4
                        TRACKER[bit].append((high_bits, high_bits, high_bits, high_bits))
                        DynamicCustomMutation(array, min(high_bits, low_bits), count_of_bits)

def update_Y(array):
    
    global TRACKER
    l = len(array)
    N_BITS = 1
    if l == 16:
        N_BITS = 8
    elif l == 52:
        N_BITS = 16
    elif l == 180:
        N_BITS = 32
        
    for i in range(N_BITS, 2, -1):
        TRACKER[i] = []
        
def filter_config(count_of_bits, N_BITS = 16):
    
    global Y
    global TRACKER

    for key in count_of_bits:
        
        if count_of_bits[key] >= 2:
            if TRACKER[key] != []:
                # print(f"Case Found for {key}")
                # print(count_of_bits)
                # print(Y)
                
                recursive_del(count_of_bits, key, N_BITS)
    
def recursive_del(count_of_bits, key, N_BITS):
    
    global TRACKER
    global Y
    for item in TRACKER[key]:
        if len(item) == 2:
            high_bits = item[0]
            low_bits = item[1]
            
            if high_bits > 2:
                count_of_bits[high_bits] -= 1
            if low_bits > 2:
                count_of_bits[low_bits] -= 1
            
            del TRACKER[key][0]
            
            high_index = N_BITS - high_bits
            # print("HIGH")
            # print(high_bits, high_index)
            low_index = N_BITS - low_bits
            # print("LOW")
            # print(low_bits, low_index)
            
            if Y[high_index] != 0:
                Y[high_index] = -1
            if Y[low_index] != 0:
                Y[low_index] = -1
                
            if high_bits > 2:
                recursive_del(count_of_bits, high_bits, N_BITS)
            if low_bits > 2:
                recursive_del(count_of_bits, low_bits, N_BITS)
        
        elif len(item) == 4:
            bits = item[0]
            
            if bits > 2:
                count_of_bits[bits] -= 4
            
            del TRACKER[key][0]
            
            if bits > 2:
                recursive_del(count_of_bits, bits, N_BITS)
            
            
def repeatingConfig(count_of_bits):
    
    global REPEATING_CONFIG
    global Y
    REPEATING_CONFIG = []
    for key in count_of_bits:
        if count_of_bits[key] > 1:
            while count_of_bits[key] != 0:
                count_of_bits[key] -= 1
                # print(f"KEY={key}")
                repeatingConfigRecursive(key)
    
    l = len(Y)
    N_BITS = 1
    if l == 16:
        N_BITS = 8
    elif l == 52:
        N_BITS = 16
    
    index = 0
    # print(f"LEN_R={len(REPEATING_CONFIG)}, LEN_Y={len(Y)}")
    for i in range(N_BITS, N_BITS+len(REPEATING_CONFIG)):
        # print("Printing indices")
        # print(i, index)
        Y[i] = REPEATING_CONFIG[index]
        index += 1
        
    
                
def repeatingConfigRecursive(bit):
    
    global REPEATING_CONFIG
    limit = bit - 1
    # print("BIT AND ITS LIMIT")
    # print(bit, limit)
    config_value = choice([i for i in range(-1,limit) if i not in [0]])
    
    # print("Incrementing")
    REPEATING_CONFIG.append(config_value)
    
    if config_value!= -1:
        high_bit = config_value
        low_bit = bit - config_value
        # print("2 configs")
        # print(high_bit, low_bit)
        
        if high_bit > 2:
            repeatingConfigRecursive(min(low_bit, high_bit))
        if low_bit > 2:
            repeatingConfigRecursive(max(high_bit, low_bit))
    else:
        # print(f"Config Value for {bit} = -1")
        return
def mutate(n_bits, X):
    global Y
    Xp = []
    for item in X:
        if n_bits == 8:
            Y = [-1] * 16
        elif n_bits == 16:
            Y = [-1] * 52
        elif n_bits == 32:
            Y = [-1] * 180
        count_of_bits = {}
        for i in range(3, n_bits+1):
            count_of_bits[i] = 0
        count_of_bits[n_bits] = 1
        update_Y(Y)
        DynamicCustomMutation(array=Y, bit=n_bits, count_of_bits=count_of_bits)
        filter_config(count_of_bits)
        repeatingConfig(count_of_bits)
        Xp.append(Y) 
    Xp = np.array(Xp)
    return Xp


def main():
    global Y
    COUNT = 0
    incorrect = set()
    correct = set()
    X = []
    for i in range(0, 9):
        temp = [-1] * 180
        X.append(temp)
    # for k in range(10000):
    print("Starting")
    # print()
        # Y = [-1] * 16
    nbits = 32
    Xp = mutate(n_bits=nbits, X=X)
    # print(Xp)
    for item in Xp:
        item = item.astype(int)
        if cv.config_validator(n_bits=nbits, config_array=np.array(item)):
            print(item.tolist())
    # print("Count of Bits before filtering")
    # print(count_of_bits)
    # print("Count of Bits after filtering")
    # print(count_of_bits)
    
    # print("Count of Bits after considering repeated multipliers")
    # print(count_of_bits)
    # print(Y)
    
    # if cv.config_validator(n_bits=nbits, config_array=np.array(Y)) == False:
    #     incorrect.add(tuple(Y))
    #     # print(Y)
    #     COUNT += 1
    # else:
    #     correct.add(tuple(Y))
    #     print(Y)
    # print(len(list(incorrect)), len(correct))
    
    
    
    
    # for i in range(3, nbits+1):
    #     print(i, count_of_bits[i])
    #     print(TRACKER[i])
    
if __name__ == "__main__":
    main()
    
        

        
        
        
        
        
        
    
    