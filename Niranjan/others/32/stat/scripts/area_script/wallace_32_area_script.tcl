
# Read design and library
read_verilog wallace_32.v
hierarchy -check -top wallace_32

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o ./stat/reports/area_reports/wallace_32_area.txt stat
tee -a ./stat/reports/area_reports/wallace_32_area.txt stat -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
        