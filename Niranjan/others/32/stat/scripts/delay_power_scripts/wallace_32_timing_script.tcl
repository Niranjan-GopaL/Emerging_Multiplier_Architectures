
read_liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
read_verilog ./stat/gate_level_netlists/wallace_32_gate_level.v
link_design wallace_32
read_sdc /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/test.sdc
report_power > ./stat/reports/power_reports/wallace_32_power.txt
report_checks > ./stat/reports/delay_reports/wallace_32_delay.txt
exit
