
# Read design and library
read_verilog rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr1x1__nr1x4__nr4x1__nr4x4__B__B__nr6x2__nr2x6__nr2x2__B__.v
hierarchy -check -top rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr1x1__nr1x4__nr4x1__nr4x4__B__B__nr6x2__nr2x6__nr2x2__B__

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty ./../NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o ./reports/area_reports/rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr1x1__nr1x4__nr4x1__nr4x4__B__B__nr6x2__nr2x6__nr2x2__B___area.txt stat
tee -a ./reports/area_reports/rr8x8__B__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr1x1__nr1x4__nr4x1__nr4x4__B__B__nr6x2__nr2x6__nr2x2__B___area.txt stat -liberty ./../NangateOpenCellLibrary_typical.lib
        