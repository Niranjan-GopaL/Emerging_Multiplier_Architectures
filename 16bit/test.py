import config_validator as cv
import generate_final_config as gfc
import get_values as gv
import numpy as np
import custom_mutation_updated as cm2
import engine.config_name_gen as cn
# rr8x8__B__rr6x6__B__rr4x4__B__nr1x1__nr1x3__nr3x1__nr3x3__B__nr4x2__nr2x4__nr2x2__B__nr6x2__nr2x6__nr2x2__B__

N_BITS = 16
# array = [8, -1, -1, -1, -1, -1, -1, -1, 0, -1, -1, -1, 0, 0, -1, -1, 7, 4, 2, 3, 1, 6, 3, 1, -1, 5, 1, 3, 1]
# # print(len(array))
# temp_array = [-1]*(52 - len(array))
# array = array + temp_array
# x = np.array(array + [])

# x = np.array([-1]*52)
X = []
for i in range(0, 9):
    temp = [-1] * 52
    X.append(temp)
# for k in range(10000):
print("Starting")
# print()
    # Y = [-1] * 16
nbits = 16

for i in range(0, 20):
    Xp = cm2.mutate(n_bits=nbits, X=X)

    for item in Xp:
        x = item
        x = np.array(x)
        if cv.config_validator(N_BITS, x):
            final_configuration = gfc.generate_final_config(n_bits=N_BITS, array=x)
            # print(final_configuration)
            # print(cn.generate_configuration_name(final_configuration)[0])
            f1, f2, f3 = gv.get_values(final_configuration,1)
            # print(final_configuration)
            print(f1, f2, f3)
        else:
            print("False")