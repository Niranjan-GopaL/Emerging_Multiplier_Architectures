
read_verilog ./dadda_16.v
hierarchy -check -top dadda_16
flatten
synth -top dadda_16
dfflibmap -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
abc -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
write_json ./stat/netlists/dadda_16_netlist.json
write_verilog -noattr ./stat/gate_level_netlists/dadda_16_gate_level.v
