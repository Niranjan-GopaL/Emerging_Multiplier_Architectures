
read_verilog ./rr8x8__B__rr7x7__B__nr1x1__nr1x6__nr6x1__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x2__nr2x3__nr2x2__B__B__B__nr7x1__nr1x7__nr1x1__B__.v
hierarchy -check -top rr8x8__B__rr7x7__B__nr1x1__nr1x6__nr6x1__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x2__nr2x3__nr2x2__B__B__B__nr7x1__nr1x7__nr1x1__B__
flatten
synth -top rr8x8__B__rr7x7__B__nr1x1__nr1x6__nr6x1__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x2__nr2x3__nr2x2__B__B__B__nr7x1__nr1x7__nr1x1__B__
dfflibmap -liberty ./../NangateOpenCellLibrary_typical.lib
abc -liberty ./../NangateOpenCellLibrary_typical.lib
write_json ./netlists/rr8x8__B__rr7x7__B__nr1x1__nr1x6__nr6x1__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x2__nr2x3__nr2x2__B__B__B__nr7x1__nr1x7__nr1x1__B___netlist.json
write_verilog -noattr ./gate_level_netlists/rr8x8__B__rr7x7__B__nr1x1__nr1x6__nr6x1__rr6x6__B__nr1x1__nr1x5__nr5x1__rr5x5__B__rr3x3__B__nr1x1__nr1x2__nr2x1__nr2x2__B__nr3x2__nr2x3__nr2x2__B__B__B__nr7x1__nr1x7__nr1x1__B___gate_level.v
