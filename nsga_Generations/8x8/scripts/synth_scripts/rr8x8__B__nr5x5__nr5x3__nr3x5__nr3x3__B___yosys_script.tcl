
read_verilog ./rr8x8__B__nr5x5__nr5x3__nr3x5__nr3x3__B__.v
hierarchy -check -top rr8x8__B__nr5x5__nr5x3__nr3x5__nr3x3__B__
flatten
synth -top rr8x8__B__nr5x5__nr5x3__nr3x5__nr3x3__B__
dfflibmap -liberty ./../NangateOpenCellLibrary_typical.lib
abc -liberty ./../NangateOpenCellLibrary_typical.lib
write_json ./netlists/rr8x8__B__nr5x5__nr5x3__nr3x5__nr3x3__B___netlist.json
write_verilog -noattr ./gate_level_netlists/rr8x8__B__nr5x5__nr5x3__nr3x5__nr3x3__B___gate_level.v
