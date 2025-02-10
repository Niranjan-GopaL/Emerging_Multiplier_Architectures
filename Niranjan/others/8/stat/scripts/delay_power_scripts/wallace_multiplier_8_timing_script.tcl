
read_liberty /home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
read_verilog ./stat/gate_level_netlists/wallace_multiplier_8_gate_level.v
link_design wallace_multiplier_8
read_sdc /home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/global/test.sdc
report_power > ./stat/reports/power_reports/wallace_multiplier_8_power.txt
report_checks > ./stat/reports/delay_reports/wallace_multiplier_8_delay.txt
exit
