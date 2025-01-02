    # Read the Verilog file
    read_verilog ./r8x8__4nr4x4.v

    hierarchy -check -top r8x8__4nr4x4 
    flatten
    # Synthesize the design
    synth -top r8x8__4nr4x4



    # Map to a standard cell library
    dfflibmap -liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
    abc -liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib


    # Write the synthesized design to JSON and dot format
    write_json ./netlists/r8x8__4nr4x4_netlist.json

    # Write the gate-level netlist
    write_verilog -noattr ./gate_level_netlists/r8x8__4nr4x4_gate_level.v
