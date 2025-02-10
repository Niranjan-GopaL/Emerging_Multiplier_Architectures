
read_verilog ./wallace_multiplier_8.v
hierarchy -check -top wallace_multiplier_8
flatten
synth -top wallace_multiplier_8
abc -liberty /home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# write_json ./stat/netlists/wallace_multiplier_8_netlist.json
write_verilog -noattr ./stat/gate_level_netlists/wallace_multiplier_8_gate_level.v
