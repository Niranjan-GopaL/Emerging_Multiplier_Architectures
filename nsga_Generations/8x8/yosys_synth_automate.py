import os
import subprocess

LIB_PATH = "./../NangateOpenCellLibrary_typical.lib"
GATE_LEVEL_DIR = "./gate_level_netlists"
SCRIPT_DIR = "./scripts/synth_scripts"
NETLIST_DIR = "./netlists"
SVG_DIR = os.path.join(NETLIST_DIR, "svg")


def create_directories():
    os.makedirs(GATE_LEVEL_DIR, exist_ok=True)
    os.makedirs(SCRIPT_DIR, exist_ok=True)
    os.makedirs(NETLIST_DIR, exist_ok=True)
    os.makedirs(SVG_DIR, exist_ok=True)


def create_synth_script(script_path, design, basename):
    with open(script_path, "w") as script_file:
        script_file.write(f"""
read_verilog ./{design}
hierarchy -check -top {basename}
flatten
synth -top {basename}
dfflibmap -liberty {LIB_PATH}
abc -liberty {LIB_PATH}
write_json {os.path.join(NETLIST_DIR, f"{basename}_netlist.json")}
write_verilog -noattr {os.path.join(GATE_LEVEL_DIR, f"{basename}_gate_level.v")}
""")


def main():

    create_directories()
    hdls = [f for f in os.listdir('.') if f.endswith('.v')]
    for design in hdls :
        basename = os.path.splitext(design)[0]
        print(f"Running Yosys for {design}...")

        # Yosys script is created
        script_path = os.path.join(SCRIPT_DIR, f"{basename}_yosys_script.tcl")
        create_synth_script(script_path, design, basename)

        subprocess.run(["yosys", "-s", script_path], check=True)

        # This npm pakcage converts netlist.json to SVG
        subprocess.run(["netlistsvg", 
                        os.path.join(NETLIST_DIR, f"{basename}_netlist.json"), 
                        "-o", os.path.join(SVG_DIR, f"{basename}_netlist.svg")], check=True)

    print("Automation complete!")

if __name__ == '__main__':
    main()
