
read_liberty ./../NangateOpenCellLibrary_typical.lib
read_verilog ./gate_level_netlists/rr8x8__B__rr7x7__B__rr6x6__B__rr5x5__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__nr5x1__nr1x5__nr1x1__B__nr6x1__nr1x6__nr1x1__B__nr7x1__nr1x7__nr1x1__B___gate_level.v
link_design rr8x8__B__rr7x7__B__rr6x6__B__rr5x5__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__nr5x1__nr1x5__nr1x1__B__nr6x1__nr1x6__nr1x1__B__nr7x1__nr1x7__nr1x1__B__
read_sdc ./test.sdc
report_power > ./reports/power_reports/rr8x8__B__rr7x7__B__rr6x6__B__rr5x5__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__nr5x1__nr1x5__nr1x1__B__nr6x1__nr1x6__nr1x1__B__nr7x1__nr1x7__nr1x1__B___power.txt
report_checks > ./reports/delay_reports/rr8x8__B__rr7x7__B__rr6x6__B__rr5x5__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__nr5x1__nr1x5__nr1x1__B__nr6x1__nr1x6__nr1x1__B__nr7x1__nr1x7__nr1x1__B___delay.txt
exit
