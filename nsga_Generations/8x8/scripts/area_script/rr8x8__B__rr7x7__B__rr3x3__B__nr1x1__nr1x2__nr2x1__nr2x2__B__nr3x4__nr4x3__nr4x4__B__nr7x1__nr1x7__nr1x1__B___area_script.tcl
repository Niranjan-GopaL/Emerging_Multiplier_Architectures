
# Read design and library
read_verilog rr8x8__B__rr7x7__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x4__nr4x3__nr4x4__B__nr7x1__nr1x7__nr1x1__B__.v
hierarchy -check -top rr8x8__B__rr7x7__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x4__nr4x3__nr4x4__B__nr7x1__nr1x7__nr1x1__B__

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty ./../NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o ./reports/area_reports/rr8x8__B__rr7x7__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x4__nr4x3__nr4x4__B__nr7x1__nr1x7__nr1x1__B___area.txt stat
tee -a ./reports/area_reports/rr8x8__B__rr7x7__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x4__nr4x3__nr4x4__B__nr7x1__nr1x7__nr1x1__B___area.txt stat -liberty ./../NangateOpenCellLibrary_typical.lib
        