
read_verilog /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/rtl/11-temp.v
hierarchy -check -top rr8x8__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x4__nr4x4__nr4x4__B__
flatten
synth -top rr8x8__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x4__nr4x4__nr4x4__B__
dfflibmap -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
abc -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
write_json /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/netlists/11-temp_netlist.json
write_verilog -noattr /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/gate_level_netlists/11-temp_gate_level.v
