import re
import os
import subprocess
import sys

n_bits = int(sys.argv[1])
verbose = int(sys.argv[2])
module_name = sys.argv[3]

LIB_PATH = f"/home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib"
POWER_REPORTS_DIR = f"/home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/Yash/{n_bits}x{n_bits}/reports/power_reports"
DELAY_REPORTS_DIR = f"/home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/Yash/{n_bits}x{n_bits}/reports/delay_reports"
SUMMARY_FILE = f"/home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/Yash/{n_bits}x{n_bits}/summary/summary_timing.txt"
SCRIPT_DIR = f"/home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/Yash/{n_bits}x{n_bits}/scripts/delay_power_scripts"
GATE_LEVEL_NETLIST_DIR = f"/home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/Yash/{n_bits}x{n_bits}/gate_level_netlists"
SDC_FILE = f"/home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/global/test.sdc"


def create_directories():
    for directory in [POWER_REPORTS_DIR, DELAY_REPORTS_DIR, SCRIPT_DIR, os.path.dirname(SUMMARY_FILE)]:
        os.makedirs(directory, exist_ok=True)

def create_timing_script(basename, design):
    basename = basename.split("-")[1] # the name of the module does not have VERBOSE
    script_content = f"""
read_liberty {LIB_PATH}
read_verilog /home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/Yash/{n_bits}x{n_bits}/gate_level_netlists/{design}
link_design {module_name}
read_sdc {SDC_FILE}
report_power > {os.path.join(POWER_REPORTS_DIR, f"{verbose}-{basename}_power.txt")}
report_checks > {os.path.join(DELAY_REPORTS_DIR, f"{verbose}-{basename}_delay.txt")}
exit
"""
    return script_content


def extract_metrics(power_file, delay_file):
    # Regex patterns
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

    with open('power.txt' , 'w') as f:
        f.write(str(total_power))

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
    max_delay = round((995.0 - slack) - 5.000, 3) if slack else None
    with open('delay.txt' , 'w') as f:
        f.write(str(max_delay))
    return slack, max_delay


def main():
    create_directories()

    design = next((f for f in os.listdir(GATE_LEVEL_NETLIST_DIR) if f.startswith(f"{verbose}") ), None)
    print(design)
    if design:
        basename = design.replace("_gate_level.v", "")
        print(f"Running static timing analysis for {design}...")

        # Small workaround => the scripts are STORED In scripts folder, 
        # but actual scripts are created in the parent directory -> executed -> deleted 
        script_path = f"{basename}_timing_script.tcl"
        copy_script_path = os.path.join(SCRIPT_DIR, script_path)
        
        script_content = create_timing_script(basename, design)
        
        for path in [script_path, copy_script_path]:
            with open(path, "w") as f:
                f.write(script_content)
        
        # Run STA, catch errors, clean up script file (backup in scripts folder) 
        try:
            subprocess.run(["sta", script_path], check=True, 
                        #    stdout=subprocess.DEVNULL, 
                        #    stderr=subprocess.DEVNULL
                           )
            print(f"Static timing analysis for {basename} completed.")
        except subprocess.CalledProcessError as e:
            print(f"Error running STA for {basename}: {e}")
        finally:
            if os.path.exists(script_path):
                os.remove(script_path)

        # Extract metrics
        power_file = os.path.join(POWER_REPORTS_DIR, f"{basename}_power.txt")
        delay_file = os.path.join(DELAY_REPORTS_DIR, f"{basename}_delay.txt")
        slack, total_power = extract_metrics(power_file, delay_file)
        print(f"Total power: {total_power}, Slack: {slack}")
        max_delay = round((995.0 - slack) - 5.000, 3) if slack else None
        with open(SUMMARY_FILE, "a") as summary:
            summary.write(f"{basename} | {(max_delay) or 'N/A'} | {total_power or 'N/A'}\n")
    else:
        print("No matching design file found.")

    print(f"Static timing analysis complete! Summary available in {SUMMARY_FILE}")

if __name__ == "__main__":
    main()