from pymoo.algorithms.moo.nsga2 import NSGA2
from pymoo.algorithms.soo.nonconvex.ga import GA
from pymoo.optimize import minimize
from pymoo.core.problem import Problem
from pymoo.operators.crossover.pntx import PointCrossover
from pymoo.operators.sampling.rnd import IntegerRandomSampling
from pymoo.operators.mutation.inversion import InversionMutation
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


import os
import re
from pathlib import Path
import pandas as pd

GATE_LEVEL_NETLIST_DIR = "./gate_level_netlists"
POWER_REPORTS_DIR = "./reports/power_reports"
DELAY_REPORTS_DIR = "./reports/delay_reports"
SUMMARY_FILE = "./summary/final_summary.txt"
AREA_REPORTS_DIR = "./reports/area_reports"

GLOBAL_DF = None


def extract_metrics(power_file, delay_file):
    # Regex patterns (slack is always preceeded by a float) ; 
    # total power is always the second last float in the second last line
    total_power_pattern = r"Total\s+[\d\.e\-+]+\s+[\d\.e\-+]+\s+[\d\.e\-+]+\s+([\d\.e\-+]+)"
    slack_pattern = r"([-+]?\d*\.\d+|\d+)\s+slack"

    # Extract total power
    total_power = None
    if os.path.exists(power_file):
        with open(power_file, 'r') as f:
            power_content = f.read()
            match = re.search(total_power_pattern, power_content)
            if match:
                total_power = float(match.group(1))

    # Extract Slack
    slack = None
    if os.path.exists(delay_file):
        with open(delay_file, 'r') as f:
            delay_content = f.read()
            match = re.search(slack_pattern, delay_content, re.IGNORECASE)
            if match:
                slack = float(match.group(1))
            else:
                with open("./logs/error_logs.txt", "a") as error_log:
                    error_log.write(f"Error extracting slack for {delay_file}\n")

    return slack, total_power



def extract_area( basename: str) -> str:
    area_file = Path(AREA_REPORTS_DIR) / f"{basename}_area.txt"
    with open(area_file) as f:
        content = f.read()
        match = re.search(r"Chip area for top module.*?:\s*([\d.]+)", content)
        return match.group(1) if match else "N/A"

def convert_to_df():
    global GLOBAL_DF
    columns = ['architecture', 'area', 'max_delay', 'max_power']
    GLOBAL_DF = pd.read_csv(SUMMARY_FILE, sep='|', names=columns, engine='python')
    GLOBAL_DF = GLOBAL_DF.apply(lambda x: x.str.strip() if x.dtype == "object" else x)

    # Convert numerical columns to appropriate data types
    GLOBAL_DF['area'] = pd.to_numeric(GLOBAL_DF['area'])
    GLOBAL_DF['max_delay'] = pd.to_numeric(GLOBAL_DF['max_delay'])
    GLOBAL_DF['max_power'] = pd.to_numeric(GLOBAL_DF['max_power'])

    head_df = GLOBAL_DF.head()
    stats_df = GLOBAL_DF.describe()
    print(head_df)
    print(stats_df)

    return GLOBAL_DF









#--------------- global variables --------------------------
THREADS=20
pool=ThreadPool(THREADS)

GENERATIONS=100
POPULATION=20
CURRENT_GEN=0
SEED=20
#----------------global variables --------------------------



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

    # initial values
    def __init__(self,**kwargs):

        # Lower and Upper 
        self.xl=[0]
        self.xu=[10]*10
        super().__init__(
            n_var=10, n_obj=3, 
            n_ieq_constr=1,
            n_constr=0,
            # When this is False => We can use Multiprocessing, now all the solutions will be reported at once
            elementwise_evaluation=False, 
            xl=self.xl, 
            xu=self.xu,
            vtype=int,
            **kwargs
            )



    # NSGA2 problem in-built function to evaluate solution.
    def _evaluate(self, X, out, *args, **kwargs):


        # X     -> SOLUTIONS ?
        # out   -> output by the algorithm 

        global GCURRENT_GEN
        # prepare the parameters for the pool
        genFile=open('generation.txt',mode='w',encoding='utf-8')
        genFile.write(str(CURRENT_GEN))
        genFile.close()
        CURRENT_GEN=CURRENT_GEN+1
        
        params = [[X[k],k] for k in range(len(X))]

        # calculate the function values in a parallelized manner and wait until done
        RESULT=pool.starmap(self.evaluateProblem, params)
        F=[] # Objective values
        G=[] # Violations

        for i in RESULT:
            F.append(i[0])
            G.append(i[1])
        
        # store the function values and return them.
        out["F"] = np.array(F)
        out['G'] = np.array(G)


    # This function is used to evaluate each solution independently and should return objectives and constraints
    # Very Useful !! Write outputs of the Generations to DIFFERENT FILES as is requirement
    def evaluateProblem(self,x,Z):


        print(x)
        f1=1 # We are minimizing this value
        
        for i in x:
            f1 *= i

        #constraint/violation evaluation
        g1=0
        for i in x:
            if (i%2==0):
                g1 = g1 + 1
            
            if sum(x) == 200:
                g1 = g1
                
            else:
                g1 = g1 + abs(sum(x) - 200) # To make sure that the sum(x) comes closer to 200

        return ([f1],[g1])



    
def runFramework():
    
    problem=CustomProblemClass()
    callback = MyCallback()
    # GA -> genetic algorithm
    # n_points -> number of splits to make in binary
    algorithm = GA(pop_size=POPULATION,sampling=IntegerRandomSampling(),crossover=PointCrossover(n_points=5),
        mutation=BitflipMutation())

    # you can terminate only after you found a better VALUE of parameter ( delay better than current research papers )
    termination = get_termination("n_gen", GENERATIONS)
    

    # Take -(parameter ) those that we want to maximize
    res = minimize(problem,
                    algorithm,
                    termination,
                    save_history=False,
                    callback=callback,
                    seed=SEED,

                    # prints out the important stuff at each iteration
                    verbose=True)
    pool.close()
    print('Solutions')
    print(res.F)
    solution=list(res.X.astype(int))
    print(res.X)

    # Convert data to numpy array for easier manipulation
    data = np.array(callback.data)
    #save fitness evluations in numpy array
    np.save('fitness.npy',data)

    



def main():

    for design in os.listdir(GATE_LEVEL_NETLIST_DIR):
        if not design.endswith("_gate_level.v"):
            continue

        basename = design.replace("_gate_level.v", "")

        power_file = os.path.join(POWER_REPORTS_DIR, f"{basename}_power.txt")
        delay_file = os.path.join(DELAY_REPORTS_DIR, f"{basename}_delay.txt")
        slack, total_power = extract_metrics(power_file, delay_file)

        max_delay = round((995.0 - slack) - 5.000, 6) if slack else None
        chip_area = round(float(extract_area(basename)), 6)
        print(f"{basename} ===> Total power: {total_power}, Slack: {slack}, Area : {chip_area} ")
        with open(SUMMARY_FILE, "a") as summary:
            summary.write(f"{basename} | {chip_area} | {(max_delay) or 'N/A'} | {total_power or 'N/A'}\n")
        
    GLOBAL_DF = convert_to_df()
    runFramework()



if __name__ == "__main__":
    main()



