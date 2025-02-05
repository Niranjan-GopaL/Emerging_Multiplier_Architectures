
# Read design and library
read_verilog dadda_8.v
hierarchy -check -top dadda_8

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o ./reports/area_reports/dadda_8_area.txt stat
tee -a ./reports/area_reports/dadda_8_area.txt stat -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
        