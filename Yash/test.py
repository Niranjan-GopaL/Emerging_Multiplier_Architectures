import config_validator as cv
import generate_final_config as gfc
import get_values as gv
import numpy as np
# rr8x8__B__rr6x6__B__rr4x4__B__nr1x1__nr1x3__nr3x1__nr3x3__B__nr4x2__nr2x4__nr2x2__B__nr6x2__nr2x6__nr2x2__B__

N_BITS=8
x = np.array([6, -1, 4, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])
if cv.config_validator(N_BITS, x):
    final_configuration = gfc.generate_final_config(n_bits=N_BITS, array=x)
    print(final_configuration)
    f1, f2, f3 = gv.get_values(final_configuration,1)
    # print(final_configuration)
    print(f1, f2, f3)
else:
    print("False")
            
            