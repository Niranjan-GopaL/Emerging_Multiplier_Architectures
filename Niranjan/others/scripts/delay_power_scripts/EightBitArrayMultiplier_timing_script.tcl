
read_liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
read_verilog ./gate_level_netlists/EightBitArrayMultiplier_gate_level.v
link_design EightBitArrayMultiplier
read_sdc ./test.sdc
report_power > ./reports/power_reports/EightBitArrayMultiplier_power.txt
report_checks > ./reports/delay_reports/EightBitArrayMultiplier_delay.txt
exit
