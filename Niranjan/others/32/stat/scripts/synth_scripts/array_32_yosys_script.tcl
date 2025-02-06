
read_verilog ./array_32.v
hierarchy -check -top array_32
flatten
synth -top array_32
dfflibmap -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
abc -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
write_json ./stat/netlists/array_32_netlist.json
write_verilog -noattr ./stat/gate_level_netlists/array_32_gate_level.v
