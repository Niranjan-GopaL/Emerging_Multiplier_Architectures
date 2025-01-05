
# Read design and library
read_verilog rr8x8__B__nr2x2__nr2x6__nr6x2__rr6x6__B__rr4x4__B__nr2x2__nr2x2__nr2x2__nr2x2__B__nr4x2__nr2x4__nr2x2__B__B__.v
hierarchy -check -top rr8x8__B__nr2x2__nr2x6__nr6x2__rr6x6__B__rr4x4__B__nr2x2__nr2x2__nr2x2__nr2x2__B__nr4x2__nr2x4__nr2x2__B__B__

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty ./../NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o ./reports/area_reports/rr8x8__B__nr2x2__nr2x6__nr6x2__rr6x6__B__rr4x4__B__nr2x2__nr2x2__nr2x2__nr2x2__B__nr4x2__nr2x4__nr2x2__B__B___area.txt stat
tee -a ./reports/area_reports/rr8x8__B__nr2x2__nr2x6__nr6x2__rr6x6__B__rr4x4__B__nr2x2__nr2x2__nr2x2__nr2x2__B__nr4x2__nr2x4__nr2x2__B__B___area.txt stat -liberty ./../NangateOpenCellLibrary_typical.lib
        