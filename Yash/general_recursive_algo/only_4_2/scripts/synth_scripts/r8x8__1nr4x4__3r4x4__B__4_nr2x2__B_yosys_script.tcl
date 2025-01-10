
read_verilog ./r8x8__1nr4x4__3r4x4__B__4_nr2x2__B.v
hierarchy -check -top r8x8__1nr4x4__3r4x4__B__4_nr2x2__B
flatten
synth -top r8x8__1nr4x4__3r4x4__B__4_nr2x2__B
dfflibmap -liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
abc -liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
write_json ./netlists/r8x8__1nr4x4__3r4x4__B__4_nr2x2__B_netlist.json
write_verilog -noattr ./gate_level_netlists/r8x8__1nr4x4__3r4x4__B__4_nr2x2__B_gate_level.v
