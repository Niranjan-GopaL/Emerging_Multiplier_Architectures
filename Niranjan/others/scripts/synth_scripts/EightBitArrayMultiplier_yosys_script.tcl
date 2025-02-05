
read_verilog ./EightBitArrayMultiplier.v
hierarchy -check -top EightBitArrayMultiplier
flatten
synth -top EightBitArrayMultiplier
dfflibmap -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
abc -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
write_json ./netlists/EightBitArrayMultiplier_netlist.json
write_verilog -noattr ./gate_level_netlists/EightBitArrayMultiplier_gate_level.v
