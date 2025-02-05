
# Read design and library
read_verilog wallace_multiplier_8.v
hierarchy -check -top wallace_multiplier_8

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o ./reports/area_reports/wallace_multiplier_8_area.txt stat
tee -a ./reports/area_reports/wallace_multiplier_8_area.txt stat -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
        