
read_verilog ./wallace_32.v
hierarchy -check -top wallace_32
flatten
synth -top wallace_32
dfflibmap -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
abc -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
write_json ./stat/netlists/wallace_32_netlist.json
write_verilog -noattr ./stat/gate_level_netlists/wallace_32_gate_level.v
