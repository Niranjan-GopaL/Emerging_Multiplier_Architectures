    # Read design and library
    read_verilog r8x8__4nr4x4.v
    hierarchy -check -top r8x8__4nr4x4
    
    # Basic synthesis and optimization
    proc; opt; 
    techmap; opt
    
    # Map to standard cells
    abc -liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib

    # Generate area report
    tee -o ./area_reports/r8x8__4nr4x4_area.txt stat
    tee -a ./area_reports/r8x8__4nr4x4_area.txt stat -liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
