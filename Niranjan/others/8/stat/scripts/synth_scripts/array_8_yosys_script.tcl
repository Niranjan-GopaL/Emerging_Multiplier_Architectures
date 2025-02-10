
read_verilog ./array_8.v
hierarchy -check -top array_8
flatten
synth -top array_8
abc -liberty /home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# write_json ./stat/netlists/array_8_netlist.json
write_verilog -noattr ./stat/gate_level_netlists/array_8_gate_level.v
