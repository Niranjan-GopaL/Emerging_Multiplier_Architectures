
read_verilog ./rr8x8__B__nr3x3__nr3x5__nr5x3__rr5x5__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__B__.v
hierarchy -check -top rr8x8__B__nr3x3__nr3x5__nr5x3__rr5x5__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__B__
flatten
synth -top rr8x8__B__nr3x3__nr3x5__nr5x3__rr5x5__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__B__
dfflibmap -liberty ./../NangateOpenCellLibrary_typical.lib
abc -liberty ./../NangateOpenCellLibrary_typical.lib
write_json ./netlists/rr8x8__B__nr3x3__nr3x5__nr5x3__rr5x5__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__B___netlist.json
write_verilog -noattr ./gate_level_netlists/rr8x8__B__nr3x3__nr3x5__nr5x3__rr5x5__B__rr4x4__B__nr3x3__nr3x1__nr1x3__nr1x1__B__nr4x1__nr1x4__nr1x1__B__B___gate_level.v
