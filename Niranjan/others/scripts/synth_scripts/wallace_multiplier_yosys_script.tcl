
read_verilog ./wallace_multiplier.v
hierarchy -check -top wallace_multiplier
flatten
synth -top wallace_multiplier
dfflibmap -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
abc -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
write_json ./netlists/wallace_multiplier_netlist.json
write_verilog -noattr ./gate_level_netlists/wallace_multiplier_gate_level.v
