
# Read design and library
read_verilog 8x8/rtl/15-temp.v
hierarchy -check -top rr8x8__B__nr1x1__nr1x7__nr7x1__rr7x7__B__rr4x4__B__nr1x1__nr1x3__nr3x1__nr3x3__B__nr4x3__nr3x4__nr3x3__B__B__

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/reports/area_reports/15-temp_area.txt stat
tee -a /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/reports/area_reports/15-temp_area.txt stat -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
        