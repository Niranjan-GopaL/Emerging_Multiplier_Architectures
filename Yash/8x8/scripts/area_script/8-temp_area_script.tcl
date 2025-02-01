
# Read design and library
read_verilog 8x8/rtl/8-temp.v
hierarchy -check -top rr8x8__B__rr4x4__B__nr2x2__nr2x2__nr2x2__nr2x2__B__rr4x4__B__nr2x2__nr2x2__nr2x2__nr2x2__B__nr4x4__nr4x4__B__

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/reports/area_reports/8-temp_area.txt stat
tee -a /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/reports/area_reports/8-temp_area.txt stat -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
        