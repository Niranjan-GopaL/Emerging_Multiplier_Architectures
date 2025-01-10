
# Read the Liberty file (standard cell library)
read_liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib


# Read the synthesized gate-level netlist
read_verilog  


link_design exact_assymetric__8x8__5_3

# Read timing constraints (SDC file)
# read_sdc /home/yash-sengupta/Niranjan_file/Main_Workflow/controller/constraints.sdc


# Link the design (resolve hierarchy)
# link_design exact_assymetric__8x8__5_3

# Perform timing analysis
report_checks -path_delay min_max > /home/yash-sengupta/Niranjan_file/Main_Workflow/STA/reports/exact_assymetric__8x8__5_3.txt