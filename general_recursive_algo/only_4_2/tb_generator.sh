#!/bin/bash

mkdir -p validation

for verilog_file in *.v; do

    if [ -f "$verilog_file" ]; then

        filename=$(basename "$verilog_file" .v)
        output_file="validation/tb_${filename}.vvp"
        
        echo "Compiling $verilog_file -> $output_file"
        
        iverilog -o "$output_file" "$verilog_file"
        
        if [ $? -eq 0 ]; then
            echo "Successfully compiled $verilog_file"
        else
            echo "Error compiling $verilog_file"
        fi
    fi
done

echo "Compilation process complete!"