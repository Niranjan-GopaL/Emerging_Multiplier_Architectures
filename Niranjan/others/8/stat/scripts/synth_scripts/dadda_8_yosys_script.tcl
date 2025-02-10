
read_verilog ./dadda_8.v
hierarchy -check -top dadda_8
flatten
synth -top dadda_8
abc -liberty /home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# write_json ./stat/netlists/dadda_8_netlist.json
write_verilog -noattr ./stat/gate_level_netlists/dadda_8_gate_level.v
