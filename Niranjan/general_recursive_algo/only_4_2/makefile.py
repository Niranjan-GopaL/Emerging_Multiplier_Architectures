import os
import subprocess
from pathlib import Path

def create_validation_dir():
    os.makedirs("validation", exist_ok=True)

def compile_verilog(verilog_file: Path) -> bool:
    filename = verilog_file.stem
    output_file = f"validation/tb_{filename}.vvp"
    
    print(f"Compiling {verilog_file} -> {output_file}")
    
    try:
        subprocess.run(["iverilog", "-o", output_file, str(verilog_file)], check=True)
        print(f"Successfully compiled {verilog_file}")
        return True
    except subprocess.CalledProcessError:
        print(f"Error compiling {verilog_file}")
        return False

def main():
    create_validation_dir()
    verilog_files = Path(".").glob("*.v")
    
    compilation_results = [
        compile_verilog(vfile) 
        for vfile in verilog_files 
        if vfile.is_file()
    ]
    
    print("Compilation process complete!")
    return all(compilation_results)

if __name__ == "__main__":
    main()