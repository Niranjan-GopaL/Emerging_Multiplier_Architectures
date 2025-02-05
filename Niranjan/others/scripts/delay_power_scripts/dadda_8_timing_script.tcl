
read_liberty /home/nira/Documents/code/ece/Emerging_Multiplier_Architectures/global/NangateOpenCellLibrary_typical.lib
read_verilog ./gate_level_netlists/dadda_8_gate_level.v
link_design dadda_8
read_sdc ./test.sdc
report_power > ./reports/power_reports/dadda_8_power.txt
report_checks > ./reports/delay_reports/dadda_8_delay.txt
exit
