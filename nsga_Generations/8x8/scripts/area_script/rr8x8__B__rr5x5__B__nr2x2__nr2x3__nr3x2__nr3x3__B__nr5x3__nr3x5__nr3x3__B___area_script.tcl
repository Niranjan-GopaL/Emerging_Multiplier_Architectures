
# Read design and library
read_verilog rr8x8__B__rr5x5__B__nr2x2__nr2x3__nr3x2__nr3x3__B__nr5x3__nr3x5__nr3x3__B__.v
hierarchy -check -top rr8x8__B__rr5x5__B__nr2x2__nr2x3__nr3x2__nr3x3__B__nr5x3__nr3x5__nr3x3__B__

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty ./../NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o ./reports/area_reports/rr8x8__B__rr5x5__B__nr2x2__nr2x3__nr3x2__nr3x3__B__nr5x3__nr3x5__nr3x3__B___area.txt stat
tee -a ./reports/area_reports/rr8x8__B__rr5x5__B__nr2x2__nr2x3__nr3x2__nr3x3__B__nr5x3__nr3x5__nr3x3__B___area.txt stat -liberty ./../NangateOpenCellLibrary_typical.lib
        