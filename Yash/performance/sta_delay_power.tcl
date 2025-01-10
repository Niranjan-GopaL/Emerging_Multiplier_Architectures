# Load the standard cell library
read_liberty -max /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
read_liberty -min /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib

# Read the gate-level netlist
read_verilog r8x8__1nr4x4__3r4x4__B__4_nr2x2__B_gate_level.v

link_design r8x8__1nr4x4__3r4x4__B__4_nr2x2__B

# Specify operating conditions
set_operating_conditions WORST

# Perform a timing analysis
report_checks -path full -fields {slew transition delay}

# Report the critical path delay
report_timing -max_paths 1 -path full