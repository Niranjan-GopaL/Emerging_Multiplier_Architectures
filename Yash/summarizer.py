"""
Author: Bhargav D V, Research Scholar, IIITB, under guidance of Prof. Madhav Rao.
Evolutionary optimization template code
"""


'''  
My Notes:
-------------------------------------------------------------
pymoo: Collection of all evolutionary genetic algorithms.
NSGA2 is multi objective
GA is single objective
-------------------------------------------------------------
THREADS=20
pool=ThreadPool(THREADS)

GENERATIONS=100 # Number of iterations
POPULATION=20 # Population size
CURRENT_GEN=0  # Current Optimization run
SEED=20

Maybe our system can handle all our P solutions independently. So we can use multi threading. Every generation we have multile solutions. We multi process it.
-------------------------------------------------------------

CustomProblemClass()
Define the problem
How many variables we have
Upper limit on each variable
--------------------------------------------------------------

Constraint:


'''

#import packages
import os
from pymoo.algorithms.moo.nsga2 import NSGA2
from pymoo.algorithms.soo.nonconvex.ga import GA
from pymoo.optimize import minimize
from pymoo.core.problem import Problem
from pymoo.operators.crossover.pntx import PointCrossover
from pymoo.operators.sampling.rnd import IntegerRandomSampling
from pymoo.operators.mutation.inversion import InversionMutation
from pymoo.core.mutation import Mutation
from pymoo.operators.mutation.pm import PolynomialMutation
from pymoo.operators.repair.rounding import RoundingRepair
from pymoo.operators.mutation.bitflip import BitflipMutation
from pymoo.termination import get_termination
from pymoo.operators.crossover.sbx import SBX
from pymoo.core.repair import Repair
from pymoo.optimize import minimize
from pymoo.core.callback import Callback
from pymoo.visualization.scatter import Scatter
import numpy as np
from multiprocessing.pool import ThreadPool
import re
#import package

import config_validator as cv
import generate_final_config as gfc
import get_values as gv
import custom_mutation as cm

#--------------- custom mutation  --------------------------
class CustomMutation(Mutation):

    def _do(self, problem, X, params=None, **kwargs):
        X = X.astype(float)

        Xp = cm.custom_mutation(X)
        
        return Xp
#--------------- global variables --------------------------
THREADS=1
pool=ThreadPool(THREADS)

GENERATIONS=100
POPULATION=20
CURRENT_GEN=0
SEED=0
N_BITS = 8
#----------------global variables --------------------------

VERBOSE_NUMBER_RIGHT_NOW = 0

#this class is used to get data of entire evolution
class MyCallback:
    def __init__(self):
        self.data = []

    def __call__(self, algorithm):
        # Extract the objective values for all solutions in the current population
        F = algorithm.pop.get('F')
        # Store the objective values
        self.data.append(F)

#this is custom problem class for NSGA2
class CustomProblemClass(Problem):

    def __init__(self,**kwargs):
        # Define as a list of each variables
        # EX: self.xl = [2, 4, 3]
        self.xl=[-1]*16
        self.xu=[]
        COUNT = 0
        print("Starting")
        for i in range(0, 16):
            if COUNT <=7 :
                if COUNT >= 6:
                    self.xu.append(-1)
                    COUNT +=1
                    continue
                print(N_BITS - i - 1)
                self.xu.append(N_BITS - i - 1)
                print(self.xu)
                COUNT +=1
                continue
            
            self.xu.append(int(N_BITS / 2))
        
        print("Over")
        print(self.xu)
        
        super().__init__(n_var=16, n_obj=3, n_ieq_constr=1,n_constr=0,elementwise_evaluation=False, xl=self.xl, xu=self.xu,vtype=int,**kwargs)

        # elementwise_evaluation=True: At each time it will give 1 solution instead of all 10 solutions.
        # n_var: each solution should have 10 numbers

    #NSGA2 problem in-built function to evaluate solution. This function is called everytime we have a solution X
    # out: O/P of the solution X
    def _evaluate(self, X, out, *args, **kwargs):
        global CURRENT_GEN
        # prepare the parameters for the pool
        genFile=open('generation.txt',mode='w',encoding='utf-8')
        genFile.write(str(CURRENT_GEN))
        genFile.close()
        CURRENT_GEN=CURRENT_GEN+1
        
        
        # This part handles multithreading
        params = [[X[k],k] for k in range(len(X))]

        # calculate the function values in a parallelized manner and wait until done
        RESULT=pool.starmap(self.evaluateProblem, params)
        F=[] # Objective Values
        G=[] # Violations
        for i in RESULT:
            F.append(i[0])
            G.append(i[1])
        
        # store the function values and return them.
        out["F"] = np.array(F)
        out['G'] = np.array(G)


    #this function is used to evaluate each solution independently and should return objectives and constraints
    def evaluateProblem(self,x,Z):
        global VERBOSE_NUMBER_RIGHT_NOW
        # x: Single solution 
        # Z: Which thread?
        
        #objective evaluation
        # Convert the set of numbers into a verilog files
        
        # Find a solution so that product of odd numbers is minimized and sum=200
        # print(type(x))
        
        
        
        # if cv.config_validator(N_BITS, x):
        #     # final_configuration = gfc.generate_final_config(n_bits=N_BITS, array=x)
        #     # print("this is ",VERBOSE_NUMBER_RIGHT_NOW)
        #     # f1, f2, f3 = gv.get_values(final_configuration, Z)
        #     # VERBOSE_NUMBER_RIGHT_NOW += 1
        print(f"Config={x}")
        final_configuration = gfc.generate_final_config(n_bits=N_BITS, array=x)
        f1, f2, f3 = gv.get_values(final_configuration, Z)
        # f1 = np.sum(x)
        # f2 = np.prod(x)
        # f3 = 0
        
        # else:
            
        #     print("Invalid Config=",x)
        #     f1, f2, f3 = -1, -1, -1

        #constraint/violation evaluation
        g1=0
        # if cv.config_validator(N_BITS, x):
        #     print("Valid")
        #     g1 = 0
        # else:
        #     g1 = 1
        # for i in x:
        #     if (i%2==1):
        #         g1 = g1 + 1
            
        # if sum(x) == 200:
        #     g1 = 0
        # else: 
        #     g1 = 1
            
        # else:
        #     g1 = g1 + abs(sum(x) - 200) # To make sure that the sum(x) comes closer to 200
        return ([f1, f2, f3],[g1]) # This is in the RESULT list
    
def runFramework():
    
    problem=CustomProblemClass() # Here we need to define the problem.
    callback = MyCallback()
    # What algorithm to use?
    # sampling: What initial random solution to start with?
    solution1 = np.array([5, -1, -1, 3, -1, 0, -1, -1, 2, 2, -1, -1, -1, -1, -1, -1])
    solution2 = np.array([6, -1, 4, -1, 3, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])
    solution3 = np.array([4, -1, -1, -1, 0, 0, -1, -1, 3, 2, 3, 2, 3, 2, 3, 2])
    solution4 = np.array([7, 6, 5, 4, 3, 2, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])
    solution5 = np.array([5, -1, -1, 3, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])
    solution6 = np.array([4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])
    solution7 = np.array([3, -1, -1, 3, -1, 0, -1, -1, 1, 1, -1, -1, -1, -1, -1, -1])
    solution8 = np.array([4, -1, -1, -1, 0, 0, -1, -1, 2, 3, 2, -1, -1, -1, -1, -1])
    solution9 = np.array([4, 2, -1, -1, 0, 0, -1, -1, 2, -1, 2, -1, -1, -1, -1, -1])
    solution10 = np.array([6, 2, 4, -3, 0, 1, 1, -1, 2, 3, 2, -1, -1, 1, -1, -1])
    solution11 = np.array([5, -1, -1, -1, 0, 1, -1, -1, 2, 3, 2, -1, -1, -1, -1, -1])
    solution12 = np.array([4, 4, -1, -1, 3, 0, -1, -1, 2, 2, 2, -1, -1, -1, 4, -1])
    solution13 = np.array([3, 6, -1, -1, 3, 2, -1, -1, 2, 3, 2, -1, -1, -1, 2, -1])
    solution14 = np.array([2, 1, -1, -1, 2, 0, -1, -1, 2, 1, 2, -1, -1, -1, 1, -1])
    solution15 = np.array([1, 1, -1, -1, 1, 1, -1, -1, 2, 1, 2, -1, -1, -1, 3, -1])
    solution16 = np.array([1, 4, -1, -1, 1, 2, -1, -1, 2, 2, 2, -1, -1, -1, 4, -1])
    solution17 = np.array([1, 3, -1, -1, 2, 2, -1, -1, 2, 1, 2, -1, -1, -1, 4, -1])
    solution18 = np.array([3, 2, -1, -1, -1, 0, -1, -1, 2, 3, 2, -1, -1, -1, 4, -1])
    solution19 = np.array([4, 3, -1, 3, 3, 0, -1, -1, 2, 3, 2, -1, 1, -1, -1, -1])
    solution20 = np.array([5, 6, -1, -1, 0, 0, -1, -1, 2, 3, 2, -1, 3, 4, -1, -1])
    
    sampling = np.vstack([solution1,
                         solution2,
                         solution3, 
                         solution4, 
                         solution5,
                         solution6,
                         solution7,
                         solution8,
                         solution9,
                         solution10,
                         solution11,
                         solution12,
                         solution13,
                         solution14,
                         solution15,
                         solution16,
                         solution17,
                         solution18,
                         solution19,
                         solution20])

    
    algorithm = NSGA2(pop_size=POPULATION,sampling=sampling,crossover=PointCrossover(n_points=5, prob=0),
        mutation=CustomMutation()) 
    
    # Termination in possible ways?
    # We know till what value we want to converge to?
    # Maybe for the last 30 generations the error is not changing. Tolerance Value.
    # Mostly we don't know what is the optimal value. We say what is the maximum value the code can reach in this generations.
    termination = get_termination("n_gen", GENERATIONS)
    
    # For maximization, take negative of the value. So we will minimize the negative value i.e. maximize the positive value.
    res = minimize(problem,
                    algorithm,
                    termination,
                    save_history=False, # Keep track of check points
                    callback=callback,
                    seed=SEED,
                    verbose=True) # Verbose for print statements. For Degugging. Tells about each iteration...
    pool.close()
    print('Solutions')
    print(res.F)
    solution=list(res.X.astype(int))
    print(res.X)

    # Convert data to numpy array for easier manipulation
    data = np.array(callback.data)
    #save fitness evluations in numpy array
    np.save('fitness.npy',data)

    


runFramework()