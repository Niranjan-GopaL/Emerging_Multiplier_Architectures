
read_liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
read_verilog ./gate_level_netlists/r8x8__3nr4x4__1r4x4__B__4_nr2x2__B_gate_level.v
link_design r8x8__3nr4x4__1r4x4__B__4_nr2x2__B
read_sdc ./test.sdc
report_power > ./reports/power_reports/r8x8__3nr4x4__1r4x4__B__4_nr2x2__B_power.txt
report_checks > ./reports/delay_reports/r8x8__3nr4x4__1r4x4__B__4_nr2x2__B_delay.txt
exit
