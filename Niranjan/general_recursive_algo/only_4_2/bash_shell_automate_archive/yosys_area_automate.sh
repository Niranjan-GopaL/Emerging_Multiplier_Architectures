#!/bin/bash

# Paths
LIB_PATH="/home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib"
AREA_REPORTS_DIR="./area_reports"
SCRIPT_DIR="./area_script"
SUMMARY_FILE="$AREA_REPORTS_DIR/summary.txt"

mkdir -p $AREA_REPORTS_DIR
mkdir -p $SCRIPT_DIR


# Create/clear summary file
echo "Design Name | Total Area" > $SUMMARY_FILE
echo "----------------------" >> $SUMMARY_FILE

# Iterate over each design file
for DESIGN in *.v; do
    BASENAME=$(basename "$DESIGN" .v)
    echo "Analyzing area for $DESIGN..."
    
    # Generate Yosys script path
    SCRIPT_PATH="$SCRIPT_DIR/${BASENAME}_area_script.tcl"
    
    # Generate Yosys script
    cat <<EOF > "$SCRIPT_PATH"
    # Read design and library
    read_verilog $DESIGN
    hierarchy -check -top $BASENAME
    
    # Basic synthesis and optimization
    proc; opt; 
    techmap; opt
    
    # Map to standard cells
    abc -liberty $LIB_PATH

    # Generate area report
    tee -o $AREA_REPORTS_DIR/${BASENAME}_area.txt stat
    tee -a $AREA_REPORTS_DIR/${BASENAME}_area.txt stat -liberty $LIB_PATH
EOF

    # Run Yosys
    yosys -s "$SCRIPT_PATH"

    # Extract total area and append to summary
    CHIP_AREA=$(grep "Chip area for top module" $AREA_REPORTS_DIR/"$BASENAME"_area.txt  | awk -F: '{print $2}' | tr -d '[:space:]')
    echo "$BASENAME | $CHIP_AREA" >> "$SUMMARY_FILE"

    # Optional: Extract key metrics and create summary
    echo "Area analysis for $BASENAME completed"
done

echo "Analysis complete! Summary available in $SUMMARY_FILE"