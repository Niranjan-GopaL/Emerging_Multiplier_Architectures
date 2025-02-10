
read_liberty /home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
read_verilog ./stat/gate_level_netlists/array_8_gate_level.v
link_design array_8
read_sdc /home/niranjan_yash/Emergin_Mult/Emerging_Multiplier_Architectures/global/test.sdc
report_power > ./stat/reports/power_reports/array_8_power.txt
report_checks > ./stat/reports/delay_reports/array_8_delay.txt
exit
