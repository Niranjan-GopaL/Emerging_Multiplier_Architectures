
read_verilog ./r8x8__4nr4x4.v
hierarchy -check -top r8x8__4nr4x4
flatten
synth -top r8x8__4nr4x4
dfflibmap -liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
abc -liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
write_json ./netlists/r8x8__4nr4x4_netlist.json
write_verilog -noattr ./gate_level_netlists/r8x8__4nr4x4_gate_level.v
