
read_liberty /home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib
read_verilog ./gate_level_netlists/r8x8__4nr4x4_gate_level.v
link_design r8x8__4nr4x4
read_sdc ./test.sdc
report_power > ./reports/power_reports/r8x8__4nr4x4_power.txt
report_checks > ./reports/delay_reports/r8x8__4nr4x4_delay.txt
exit
