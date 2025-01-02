#!/bin/bash

# Paths
LIB_PATH="/home/yash-sengupta/Niranjan_file/Main_Workflow/lib/NangateOpenCellLibrary_typical.lib"
GATE_LEVEL_DIR="./gate_level_netlists"
SCRIPT_DIR="./synth_scripts"

mkdir -p $GATE_LEVEL_DIR
mkdir -p $SCRIPT_DIR

# Iterate over each design file
for DESIGN in *.v; do
    BASENAME=$(basename "$DESIGN" .v)
    echo "Running Yosys for $DESIGN..."

    # Generate Yosys script path
    SCRIPT_PATH="$SCRIPT_DIR/${BASENAME}_yosys_script.tcl"

    # Generate Yosys script
    cat <<EOF > "$SCRIPT_PATH"
    # Read the Verilog file
    read_verilog ./$DESIGN

    hierarchy -check -top $BASENAME 
    flatten
    # Synthesize the design
    synth -top $BASENAME



    # Map to a standard cell library
    dfflibmap -liberty $LIB_PATH
    abc -liberty $LIB_PATH


    # Write the synthesized design to JSON and dot format
    write_json ./netlists/${BASENAME}_netlist.json

    # Write the gate-level netlist
    write_verilog -noattr $GATE_LEVEL_DIR/${BASENAME}_gate_level.v
EOF

    # Run Yosys, Convert the netlist.json to svg
    yosys -s "$SCRIPT_PATH"
    netlistsvg ./netlists/${BASENAME}_netlist.json -o ./netlists/svg/${BASENAME}_netlist.svg

    # rm "$SCRIPT_PATH" 
done

echo "Automation complete!"