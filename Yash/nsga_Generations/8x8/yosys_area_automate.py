import os
import subprocess
from pathlib import Path
import re

class AreaAnalyzer:
    def __init__(self):
        self.LIB_PATH = "./../NangateOpenCellLibrary_typical.lib"
        self.AREA_REPORTS_DIR = "./reports/area_reports"
        self.SCRIPT_DIR = "./scripts/area_script"
        self.SUMMARY_FILE = f"summary/summary_area.txt"

    def create_directories(self):
        for directory in [self.AREA_REPORTS_DIR, self.SCRIPT_DIR]:
            os.makedirs(directory, exist_ok=True)

    def generate_yosys_script(self, design_file: Path, basename: str) -> str:
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
tee -o {self.AREA_REPORTS_DIR}/{basename}_area.txt stat
tee -a {self.AREA_REPORTS_DIR}/{basename}_area.txt stat -liberty {self.LIB_PATH}
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
            subprocess.run(["yosys", "-s", str(script_path)], check=True)
            chip_area = self.extract_area(basename)
            
            with open(self.SUMMARY_FILE, "a") as f:
                f.write(f"{basename} | {chip_area}\n")
                
            print(f"Area analysis for {basename} completed")
            return True
        except subprocess.CalledProcessError as e:
            print(f"Error analyzing {basename}: {e}")
            return False

def main():
    analyzer = AreaAnalyzer()
    analyzer.create_directories()

    verilog_files = Path(".").glob("*.v")
    results = [
        analyzer.analyze_design(vfile)
        for vfile in verilog_files
        if vfile.is_file()
    ]

    print(f"Analysis complete! Summary available in {analyzer.SUMMARY_FILE}")
    return all(results)

if __name__ == "__main__":
    main()