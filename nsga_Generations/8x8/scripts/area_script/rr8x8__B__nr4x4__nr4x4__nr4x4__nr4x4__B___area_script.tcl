
# Read design and library
read_verilog rr8x8__B__nr4x4__nr4x4__nr4x4__nr4x4__B__.v
hierarchy -check -top rr8x8__B__nr4x4__nr4x4__nr4x4__nr4x4__B__

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty ./../NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o ./reports/area_reports/rr8x8__B__nr4x4__nr4x4__nr4x4__nr4x4__B___area.txt stat
tee -a ./reports/area_reports/rr8x8__B__nr4x4__nr4x4__nr4x4__nr4x4__B___area.txt stat -liberty ./../NangateOpenCellLibrary_typical.lib
        