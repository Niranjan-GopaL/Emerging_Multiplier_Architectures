import os
import re
from pathlib import Path

GATE_LEVEL_NETLIST_DIR = "./gate_level_netlists"
POWER_REPORTS_DIR = "./reports/power_reports"
DELAY_REPORTS_DIR = "./reports/delay_reports"
SUMMARY_FILE = "./summary/final_summary.txt"
AREA_REPORTS_DIR = "./reports/area_reports"


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


if __name__ == "__main__":
    main()