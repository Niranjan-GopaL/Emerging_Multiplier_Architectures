
# Read design and library
read_verilog 8x8/rtl/14-temp.v
hierarchy -check -top rr8x8__B__nr1x1__nr1x7__nr7x1__rr7x7__B__nr1x1__nr1x6__nr6x1__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__nr2x2__nr2x3__nr3x2__nr3x3__B__B__B__B__

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/reports/area_reports/14-temp_area.txt stat
tee -a /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/reports/area_reports/14-temp_area.txt stat -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
        