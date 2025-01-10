read_verilog  ./multiply_operator.v


# What is the difference between the synthesis of `*` operator and manual
# synth -top exact_3x2_mult_op
synth -top exact_3x2


# Write the synthesized design to JSON format, in Graphviz dot format
write_json netlist_mult_op.json
# show -format dot -prefix netlist_mult_op
write_json netlist_manual_design_HA_FA.json
# show -format dot -prefix netlist_manual_design_HA_FA


# Map to a standard cell library (replace with your cell library)
dfflibmap   -liberty   /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
abc         -liberty   /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib


# Write the synthesized gate-level netlist
write_verilog -noattr ./gate_level_netlists/manual_design_HA_FA_gate_level.v
# write_verilog -noattr ./gate_level_netlists/multiply_operator_gate_level.v