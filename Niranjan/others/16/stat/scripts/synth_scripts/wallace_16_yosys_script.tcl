
read_verilog ./wallace_16.v
hierarchy -check -top wallace_16
flatten
synth -top wallace_16
dfflibmap -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
abc -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
write_json ./stat/netlists/wallace_16_netlist.json
write_verilog -noattr ./stat/gate_level_netlists/wallace_16_gate_level.v
