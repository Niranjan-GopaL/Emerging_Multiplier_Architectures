
# Read design and library
read_verilog wallace_multiplier_8.v
hierarchy -check -top wallace_multiplier_8

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty /home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o ./stat/reports/area_reports/wallace_multiplier_8_area.txt stat
tee -a ./stat/reports/area_reports/wallace_multiplier_8_area.txt stat -liberty /home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
        