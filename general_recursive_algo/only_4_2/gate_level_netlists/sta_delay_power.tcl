# Load the standard cell library
read_liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib

# Read the gate-level netlist
read_verilog r8x8__1nr4x4__3r4x4__B__4_nr2x2__B_gate_level.v

link_design r8x8__1nr4x4__3r4x4__B__4_nr2x2__B

# Define input constraints (input delay) and output constraints (output delay)
set_input_delay 0 [all_inputs]
set_output_delay 10 [all_outputs]

# # Specify operating conditions
set_operating_conditions WORST

# Perform a timing analysis
report_checks -path_delay min_max  > report.txt