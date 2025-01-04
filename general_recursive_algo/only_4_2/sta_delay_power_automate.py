import re
import os
import subprocess

LIB_PATH = "/home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib"
POWER_REPORTS_DIR = "./reports/power_reports"
DELAY_REPORTS_DIR = "./reports/delay_reports"
SUMMARY_FILE = "./summary/summary_timing.txt"
SCRIPT_DIR = "./scripts/delay_power_scripts"
GATE_LEVEL_NETLIST_DIR = "./gate_level_netlists"
SDC_FILE = "./test.sdc"


def create_directories():
    for directory in [POWER_REPORTS_DIR, DELAY_REPORTS_DIR, SCRIPT_DIR, os.path.dirname(SUMMARY_FILE)]:
        os.makedirs(directory, exist_ok=True)



def create_timing_script(basename, design):
    script_content = f"""
read_liberty {LIB_PATH}
read_verilog ./gate_level_netlists/{design}
link_design {basename}
read_sdc {SDC_FILE}
report_power > {os.path.join(POWER_REPORTS_DIR, f"{basename}_power.txt")}
report_checks > {os.path.join(DELAY_REPORTS_DIR, f"{basename}_delay.txt")}
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


def main():
    create_directories()

    for design in os.listdir(GATE_LEVEL_NETLIST_DIR):
        if not design.endswith("_gate_level.v"):
            continue
            
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
            subprocess.run(["sta", script_path], check=True)
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

    print(f"Static timing analysis complete! Summary available in {SUMMARY_FILE}")

if __name__ == "__main__":
    main()