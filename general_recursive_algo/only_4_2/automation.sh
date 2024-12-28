#!/bin/bash

# Create validation directory if it doesn't exist
mkdir -p validation

# Find all .v files in current directory
for verilog_file in *.v; do

    # Check if file exists and is a regular file
    if [ -f "$verilog_file" ]; then

        # Extract filename without extension
        filename=$(basename "$verilog_file" .v)
        
        # Create output filename with bt_ prefix
        output_file="validation/tb_${filename}.vvp"
        
        echo "Compiling $verilog_file -> $output_file"
        
        # Compile the Verilog file
        iverilog -o "$output_file" "$verilog_file"
        
        # Check if compilation was successful
        if [ $? -eq 0 ]; then
            echo "Successfully compiled $verilog_file"
        else
            echo "Error compiling $verilog_file"
        fi
    fi
done

echo "Compilation process complete!"