
# Read design and library
read_verilog 8x8/rtl/0-temp.v
hierarchy -check -top rr8x8__B__rr5x5__B__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x2__nr2x3__nr2x2__B__nr5x3__nr3x5__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__B__

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/reports/area_reports/0-temp_area.txt stat
tee -a /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/reports/area_reports/0-temp_area.txt stat -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
        