
read_liberty ./../NangateOpenCellLibrary_typical.lib
read_verilog ./gate_level_netlists/rr8x8__B__nr1x1__nr1x7__nr7x1__nr7x7__B___gate_level.v
link_design rr8x8__B__nr1x1__nr1x7__nr7x1__nr7x7__B__
read_sdc ./test.sdc
report_power > ./reports/power_reports/rr8x8__B__nr1x1__nr1x7__nr7x1__nr7x7__B___power.txt
report_checks > ./reports/delay_reports/rr8x8__B__nr1x1__nr1x7__nr7x1__nr7x7__B___delay.txt
exit
