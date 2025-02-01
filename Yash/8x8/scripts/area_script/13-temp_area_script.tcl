
# Read design and library
read_verilog 8x8/rtl/13-temp.v
hierarchy -check -top rr8x8__B__nr2x2__nr2x6__nr6x2__nr6x6__B__

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/reports/area_reports/13-temp_area.txt stat
tee -a /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/Yash/8x8/reports/area_reports/13-temp_area.txt stat -liberty /home/asus/Desktop/MR_PE/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
        