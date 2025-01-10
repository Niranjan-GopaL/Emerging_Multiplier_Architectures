
# Read design and library
read_verilog r8x8__2nr4x4__2r4x4__B__4_nr2x2__B.v
hierarchy -check -top r8x8__2nr4x4__2r4x4__B__4_nr2x2__B

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o ./reports/area_reports/r8x8__2nr4x4__2r4x4__B__4_nr2x2__B_area.txt stat
tee -a ./reports/area_reports/r8x8__2nr4x4__2r4x4__B__4_nr2x2__B_area.txt stat -liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
        