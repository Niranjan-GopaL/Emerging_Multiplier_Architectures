
# Read design and library
read_verilog rr8x8__B__nr1x1__nr1x7__nr7x1__rr7x7__B__nr1x1__nr1x6__nr6x1__nr6x6__B__B__.v
hierarchy -check -top rr8x8__B__nr1x1__nr1x7__nr7x1__rr7x7__B__nr1x1__nr1x6__nr6x1__nr6x6__B__B__

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty ./../NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o ./reports/area_reports/rr8x8__B__nr1x1__nr1x7__nr7x1__rr7x7__B__nr1x1__nr1x6__nr6x1__nr6x6__B__B___area.txt stat
tee -a ./reports/area_reports/rr8x8__B__nr1x1__nr1x7__nr7x1__rr7x7__B__nr1x1__nr1x6__nr6x1__nr6x6__B__B___area.txt stat -liberty ./../NangateOpenCellLibrary_typical.lib
        