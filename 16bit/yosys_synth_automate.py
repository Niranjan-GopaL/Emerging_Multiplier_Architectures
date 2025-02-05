import os
import sys
import subprocess

n_bits = int(sys.argv[1])
verbose = int(sys.argv[2])
module_name = sys.argv[3]

LIB_PATH = "/home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib"
GATE_LEVEL_DIR = f"./{n_bits}x{n_bits}/gate_level_netlists"
TEMP_FOLDER = f"./{n_bits}x{n_bits}/rtl"  
SCRIPT_DIR = f"./{n_bits}x{n_bits}/scripts/synth_scripts"
NETLIST_DIR = f"./{n_bits}x{n_bits}/netlists"
# SVG_DIR = f"./{n_bits}x{n_bits}/netlists/svg"


def create_directories():
    os.makedirs(GATE_LEVEL_DIR, exist_ok=True)
    os.makedirs(SCRIPT_DIR, exist_ok=True)
    os.makedirs(NETLIST_DIR, exist_ok=True)
    # os.makedirs(SVG_DIR, exist_ok=True)


def create_synth_script(script_path, design, basename:str):
    basename = basename.split("-")[1] # the name of the module does not have VERBOSEJ
    with open(script_path, "w") as script_file:
        script_file.write(f"""
read_verilog /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/Yash/{n_bits}x{n_bits}/rtl/{design}
hierarchy -check -top {module_name}
flatten
synth -top {module_name}
dfflibmap -liberty {LIB_PATH}
abc -liberty {LIB_PATH}
write_json /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/Yash/{n_bits}x{n_bits}/netlists/{verbose}-{basename}_netlist.json
write_verilog -noattr /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/Yash/{n_bits}x{n_bits}/gate_level_netlists/{verbose}-temp_gate_level.v
""")


# take n_bits as a parameter from cli 
def main():
    create_directories()
    hdl = next((f for f in os.listdir(f'./{n_bits}x{n_bits}/rtl') if f.startswith(f"{verbose}") and f.endswith('.v')), None)
    if hdl:
        basename = os.path.splitext(hdl)[0]
        print(f"Running Yosys for {hdl}...")

        # Yosys script is created
        script_path = os.path.join(SCRIPT_DIR, f"{basename}_yosys_script.tcl")
        create_synth_script(script_path, hdl, basename)

        subprocess.run(["yosys", "-s", script_path], check=True, 
                       stdout=subprocess.DEVNULL, 
                       stderr=subprocess.DEVNULL
                       )
        
        # This npm package converts netlist.json to SVG
        # subprocess.run(["netlistsvg", 
        #                 os.path.join(NETLIST_DIR, f"{basename}_netlist.json"), 
        #                 "-o", os.path.join(SVG_DIR, f"{basename}_netlist.svg")], check=True)

        print("Automation complete!")
    else:
        print("No matching Verilog file found.")

if __name__ == '__main__':
    main()