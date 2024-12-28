import os
import subprocess

lib_path = "/home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib"
gate_level_dir = "./gate_level_netlists/"
os.makedirs(gate_level_dir, exist_ok=True)

# Get all Verilog files in the current directory
design_files = [f for f in os.listdir('.') if f.endswith('.v')]

# Iterate over each design file
for design in design_files:
    base_name = os.path.splitext(design)[0]
    yosys_script = f"""
    read_verilog ./{design}
    synth -top {base_name}
    write_json ./netlists/{base_name}_netlist.json
    dfflibmap -liberty {lib_path}
    abc -liberty {lib_path}
    write_verilog -noattr {gate_level_dir}{base_name}_gate_level.v
    """
    script_file = f"./{base_name}_yosys_script.ys"
    with open(script_file, "w") as file:
        file.write(yosys_script)
    subprocess.run(["yosys", script_file])
    print(f"Finished synthesising {design}")
    # os.remove(script_file)