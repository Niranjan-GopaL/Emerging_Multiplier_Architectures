
read_liberty ./../NangateOpenCellLibrary_typical.lib
read_verilog ./gate_level_netlists/rr8x8__B__nr2x2__nr2x6__nr6x2__rr6x6__B__rr5x5__B__nr1x1__nr1x4__nr4x1__rr4x4__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x1__nr1x3__nr1x1__B__B__nr5x1__nr1x5__nr1x1__B__B___gate_level.v
link_design rr8x8__B__nr2x2__nr2x6__nr6x2__rr6x6__B__rr5x5__B__nr1x1__nr1x4__nr4x1__rr4x4__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x1__nr1x3__nr1x1__B__B__nr5x1__nr1x5__nr1x1__B__B__
read_sdc ./test.sdc
report_power > ./reports/power_reports/rr8x8__B__nr2x2__nr2x6__nr6x2__rr6x6__B__rr5x5__B__nr1x1__nr1x4__nr4x1__rr4x4__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x1__nr1x3__nr1x1__B__B__nr5x1__nr1x5__nr1x1__B__B___power.txt
report_checks > ./reports/delay_reports/rr8x8__B__nr2x2__nr2x6__nr6x2__rr6x6__B__rr5x5__B__nr1x1__nr1x4__nr4x1__rr4x4__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x1__nr1x3__nr1x1__B__B__nr5x1__nr1x5__nr1x1__B__B___delay.txt
exit
