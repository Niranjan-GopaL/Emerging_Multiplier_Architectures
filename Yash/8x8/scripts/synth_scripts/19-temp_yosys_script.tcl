
read_verilog /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/rtl/19-temp.v
hierarchy -check -top rr8x8__B__rr5x5__B__nr3x3__nr3x2__nr2x3__nr2x2__B__nr5x3__nr3x5__nr3x3__B__
flatten
synth -top rr8x8__B__rr5x5__B__nr3x3__nr3x2__nr2x3__nr2x2__B__nr5x3__nr3x5__nr3x3__B__
dfflibmap -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
abc -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
write_json /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/netlists/19-temp_netlist.json
write_verilog -noattr /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/gate_level_netlists/19-temp_gate_level.v
