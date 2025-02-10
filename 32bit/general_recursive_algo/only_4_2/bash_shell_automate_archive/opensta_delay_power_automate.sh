#!/bin/bash

# Paths
LIB_PATH="/home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib"
POWER_REPORTS_DIR="./reports/power_reports"
DELAY_REPORTS_DIR="./reports/delay_reports"
SUMMARY_FILE="./summary/summary_timing.txt"



# Create/clear summary file
echo "Design Name | Total Power | Critical Path Delay" > $SUMMARY_FILE
echo "-------------------------------------------------" >> $SUMMARY_FILE

# Iterate over each Verilog design file
for DESIGN in ./gate_level_netlists/*.v; do
    BASENAME=$(basename "$DESIGN" _gate_level.v)

    echo "---------------->>>> $BASENAME <<<-------------------"
    echo "---------------->>>> $DESIGN <<<-------------------"
    echo "Running static timing analysis for $DESIGN..."
    
    # Generate STA script path
    SCRIPT_PATH="./${BASENAME}_timing_script.tcl"
    
    # Generate STA script
    cat <<EOF > "$SCRIPT_PATH"
read_liberty $LIB_PATH
read_verilog ./gate_level_netlists/${BASENAME}_gate_level.v
link_design $BASENAME
read_sdc ./test.sdc
report_power > $POWER_REPORTS_DIR/${BASENAME}_power.txt
report_checks > $DELAY_REPORTS_DIR/${BASENAME}_delay.txt
exit
EOF

    # Run STA tool
    sta "$SCRIPT_PATH"

    # Extract total power and critical path delay
    # TOTAL_POWER=$(grep "Total Power" $POWER_REPORTS_DIR/"${BASENAME}_power.txt" | awk -F: '{print $2}' | tr -d '[:space:]')
    # CRITICAL_DELAY=$(grep "Critical Path Delay" $DELAY_REPORTS_DIR/"${BASENAME}_delay.txt" | awk -F: '{print $2}' | tr -d '[:space:]')

    # Append results to summary
    echo "$BASENAME | $TOTAL_POWER | $CRITICAL_DELAY" >> "$SUMMARY_FILE"

    echo "Static timing analysis for $BASENAME completed"
done

echo "Static timing analysis complete! Summary available in $SUMMARY_FILE"
