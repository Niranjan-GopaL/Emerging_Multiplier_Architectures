
read_verilog ./rr8x8__B__rr6x6__B__nr3x3__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x3__nr3x3__B__nr6x2__nr2x6__nr2x2__B__.v
hierarchy -check -top rr8x8__B__rr6x6__B__nr3x3__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x3__nr3x3__B__nr6x2__nr2x6__nr2x2__B__
flatten
synth -top rr8x8__B__rr6x6__B__nr3x3__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x3__nr3x3__B__nr6x2__nr2x6__nr2x2__B__
dfflibmap -liberty ./../NangateOpenCellLibrary_typical.lib
abc -liberty ./../NangateOpenCellLibrary_typical.lib
write_json ./netlists/rr8x8__B__rr6x6__B__nr3x3__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x3__nr3x3__B__nr6x2__nr2x6__nr2x2__B___netlist.json
write_verilog -noattr ./gate_level_netlists/rr8x8__B__rr6x6__B__nr3x3__rr3x3__B__nr2x2__nr2x1__nr1x2__nr1x1__B__nr3x3__nr3x3__B__nr6x2__nr2x6__nr2x2__B___gate_level.v
