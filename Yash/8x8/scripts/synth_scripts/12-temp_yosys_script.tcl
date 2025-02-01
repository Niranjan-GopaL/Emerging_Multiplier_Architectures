
read_verilog /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/rtl/12-temp.v
hierarchy -check -top rr8x8__B__nr3x3__nr3x5__nr5x3__nr5x5__B__
flatten
synth -top rr8x8__B__nr3x3__nr3x5__nr5x3__nr5x5__B__
dfflibmap -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
abc -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
write_json /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/netlists/12-temp_netlist.json
write_verilog -noattr /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/gate_level_netlists/12-temp_gate_level.v
