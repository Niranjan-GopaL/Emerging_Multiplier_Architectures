
read_verilog ./array_16.v
hierarchy -check -top array_16
flatten
synth -top array_16
dfflibmap -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
abc -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
write_json ./stat/netlists/array_16_netlist.json
write_verilog -noattr ./stat/gate_level_netlists/array_16_gate_level.v
