
read_liberty ./../NangateOpenCellLibrary_typical.lib
read_verilog ./gate_level_netlists/rr8x8__B__nr5x5__nr5x3__nr3x5__nr3x3__B___gate_level.v
link_design rr8x8__B__nr5x5__nr5x3__nr3x5__nr3x3__B__
read_sdc ./test.sdc
report_power > ./reports/power_reports/rr8x8__B__nr5x5__nr5x3__nr3x5__nr3x3__B___power.txt
report_checks > ./reports/delay_reports/rr8x8__B__nr5x5__nr5x3__nr3x5__nr3x3__B___delay.txt
exit
