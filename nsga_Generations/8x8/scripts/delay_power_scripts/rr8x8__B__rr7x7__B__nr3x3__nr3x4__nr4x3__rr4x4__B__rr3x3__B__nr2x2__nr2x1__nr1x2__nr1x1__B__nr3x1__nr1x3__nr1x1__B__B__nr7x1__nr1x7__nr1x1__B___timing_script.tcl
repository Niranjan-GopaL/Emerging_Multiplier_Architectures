
read_liberty ./../NangateOpenCellLibrary_typical.lib
read_verilog ./gate_level_netlists/rr8x8__B__rr7x7__B__nr3x3__nr3x4__nr4x3__rr4x4__B__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x1__nr1x3__nr1x1__B__B__nr7x1__nr1x7__nr1x1__B___gate_level.v
link_design rr8x8__B__rr7x7__B__nr3x3__nr3x4__nr4x3__rr4x4__B__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x1__nr1x3__nr1x1__B__B__nr7x1__nr1x7__nr1x1__B__
read_sdc ./test.sdc
report_power > ./reports/power_reports/rr8x8__B__rr7x7__B__nr3x3__nr3x4__nr4x3__rr4x4__B__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x1__nr1x3__nr1x1__B__B__nr7x1__nr1x7__nr1x1__B___power.txt
report_checks > ./reports/delay_reports/rr8x8__B__rr7x7__B__nr3x3__nr3x4__nr4x3__rr4x4__B__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x1__nr1x3__nr1x1__B__B__nr7x1__nr1x7__nr1x1__B___delay.txt
exit
