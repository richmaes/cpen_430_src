# ModelSim simulation script
# Save this as run_test.do

# Clean up any existing work library
if {[file exists work]} {
    vdel -lib work -all
}

# Create a new work library
vlib work

# Compile the Verilog files
vlog assert_cpen430.v
vlog assert_cpen430_tb.v

# Start simulation
vsim -c assert_cpen430_tb

# Add waves if needed (even though we're in command-line mode)
add wave -r /*

# Run the simulation
run -all

# Exit ModelSim
quit -f