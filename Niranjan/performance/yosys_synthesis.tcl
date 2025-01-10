read_verilog  ./test.v


# What is the difference between the synthesis of `*` operator and manual
# synth -top exact_3x2_mult_op
synth -top test
hierarchy -check -top test

# Map to a standard cell library (replace with your cell library)
dfflibmap   -liberty   /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
abc         -liberty   /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib


# Write the synthesized gate-level netlist
write_verilog -noattr ./gate_level_netlists/test_gate_level.v