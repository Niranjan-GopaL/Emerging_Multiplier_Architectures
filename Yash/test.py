import config_validator as cv
import generate_final_config as gfc
import get_values as gv
import numpy as np


N_BITS=8
x = np.array([5, -1, -1, -1, 0, 1, -1, -1, 2, 3, 2, -1, -1, -1, -1, -1])
if cv.config_validator(N_BITS, x):
    final_configuration = gfc.generate_final_config(n_bits=N_BITS, array=x)
    print(final_configuration)
    f1, f2, f3 = gv.get_values(final_configuration,1)
    # print(final_configuration)
    print(f1, f2, f3)
else:
    print("False")
            
            