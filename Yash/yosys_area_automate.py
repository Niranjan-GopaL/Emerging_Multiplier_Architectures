import os
import subprocess
from pathlib import Path
import re
import sys

n_bits = int(sys.argv[1])
verbose = int(sys.argv[2])

class AreaAnalyzer:
    def __init__(self):
        self.LIB_PATH = f"/home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib"
        self.AREA_REPORTS_DIR = f"/home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/{n_bits}x{n_bits}/reports/area_reports"
        self.SCRIPT_DIR = f"/home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/{n_bits}x{n_bits}/scripts/area_script"
        self.SUMMARY_FILE = f"/home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/{n_bits}x{n_bits}/summary/{verbose}_summary_area.txt"

    def create_directories(self):
        for directory in [self.AREA_REPORTS_DIR, self.SCRIPT_DIR, f"./{n_bits}x{n_bits}/summary"]:
            os.makedirs(directory, exist_ok=True)
    def generate_yosys_script(self, design_file: Path, basename: str) -> str:
        basename = basename.split("-")[1] # the name of the module does not have VERBOSE
        script_content = f"""
# Read design and library
read_verilog {design_file}
hierarchy -check -top {basename}

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty {self.LIB_PATH}
# Generate area report
tee -o {self.AREA_REPORTS_DIR}/{verbose}-{basename}_area.txt stat
tee -a {self.AREA_REPORTS_DIR}/{verbose}-{basename}_area.txt stat -liberty {self.LIB_PATH}
        """
        return script_content

    def extract_area(self, basename: str) -> str:
        area_file = Path(self.AREA_REPORTS_DIR) / f"{basename}_area.txt"
        with open(area_file) as f:
            content = f.read()
            match = re.search(r"Chip area for top module.*?:\s*([\d.]+)", content)
            return match.group(1) if match else "N/A"

    def analyze_design(self, design_file: Path):
        basename = design_file.stem
        print(f"Analyzing area for {design_file}...")

        script_path = Path(self.SCRIPT_DIR) / f"{basename}_area_script.tcl"
        script_content = self.generate_yosys_script(design_file, basename)

        with open(script_path, "w") as f:
            f.write(script_content)

        try:
            subprocess.run(["yosys", "-s", str(script_path)], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            chip_area = self.extract_area(basename)
            
            with open("./area.txt", "a") as f:
                f.write(chip_area)
                
            with open(self.SUMMARY_FILE, "a") as f:
                f.write(f"{basename} | {chip_area}\n")

            print(f"Area analysis for {basename} completed")
            return True
        except subprocess.CalledProcessError as e:
            print(f"Error analyzing {basename}: {e}")
            return False

# take n_bits as a parameter from cli, verbose also
def main():
    analyzer = AreaAnalyzer()
    analyzer.create_directories()

    verilog_file = next(Path(f"./{n_bits}x{n_bits}/rtl").glob(f"{verbose}-*.v"), None)
    if verilog_file and verilog_file.is_file():
        result = analyzer.analyze_design(verilog_file)
        print(f"Analysis complete! Summary available in {analyzer.SUMMARY_FILE}")
        return result
    else:
        print("No matching Verilog file found.")
        return False

if __name__ == "__main__":
    main()