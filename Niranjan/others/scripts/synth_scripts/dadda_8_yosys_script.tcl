
read_verilog ./dadda_8.v
hierarchy -check -top dadda_8
flatten
synth -top dadda_8
dfflibmap -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
abc -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
write_json ./netlists/dadda_8_netlist.json
write_verilog -noattr ./gate_level_netlists/dadda_8_gate_level.v
