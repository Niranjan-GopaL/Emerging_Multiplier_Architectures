
# Read design and library
read_verilog dadda_16.v
hierarchy -check -top dadda_16

# Basic synthesis and optimization
proc; opt; 
techmap; opt

# Map to standard cells
abc -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
# Generate area report
tee -o ./stat/reports/area_reports/dadda_16_area.txt stat
tee -a ./stat/reports/area_reports/dadda_16_area.txt stat -liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
        