# Detect OS and set appropriate shell and commands
ifeq ($(OS),Windows_NT)
    SHELL = cmd.exe
    # Windows-specific settings
    MAKEFILE_INCLUDE = $(CURDIR)\..\Makefile.include
    PATH_SEP = \\
    ECHO = echo
    RM = del /F /Q
    RMDIR = rmdir /S /Q
    CLEAN_CMD = if exist work $(RMDIR) work & if exist transcript $(RM) transcript & if exist *.wlf $(RM) *.wlf & if exist modelsim.ini $(RM) modelsim.ini & if exist ip\eth_tse\eth_tse_sim\mentor\libraries $(RMDIR) ip\eth_tse\eth_tse_sim\mentor\libraries & if exist ip\eth_tse\eth_tse_sim\mentor\modelsim.ini $(RM) ip\eth_tse\eth_tse_sim\mentor\modelsim.ini & if exist ip\eth_tse\eth_tse_sim\mentor\transcript $(RM) ip\eth_tse\eth_tse_sim\mentor\transcript

else
    SHELL = /bin/bash
    # Unix-specific settings
    MAKEFILE_INCLUDE = ../Makefile.include
    PATH_SEP = /
endif

# Create work library
work:
	@if not exist work (vlib work)

# List your SystemVerilog source files for FIFO demo
# Include common support files (clock/reset) if needed
INCDIR = -incdir "./sim"
INCDIR += -incdir "../common"
INCDIR += -incdir "../sim_model"

# Real eth_tse IP: compiled into its own libraries via the Quartus-generated
# msim_setup.tcl script (see the "eth_tse" target below), then pulled into
# the main design at elaboration time via -L instead of being compiled
# directly into this project's own work library.
IP_TSE_DIR      = ip/eth_tse/eth_tse_sim/mentor
IP_TSE_WORK_LIB = $(IP_TSE_DIR)/libraries/work
IP_TSE_MAC_LIB  = $(IP_TSE_DIR)/libraries/i_tse_mac

TB_FILES = ../common/irst.v ../common/iclk.v ../sim_model/eth_test_pkg.sv
TB_FILES += ip/eth_tse/eth_tse_testbench/testbench_verilog/models/ethgen.v
TB_FILES += ip/eth_tse/eth_tse_testbench/testbench_verilog/models/ethmon.v
TB_FILES += ../sim_model/eth_mii_bfm.sv
TB_FILES += ./sim/tb_de2_115.sv
RTL_FILES = DE2_115.sv
RTL_FILES += eth_core.sv
RTL_FILES += ../common/cpen430_dcfifo.v
# Specify the top-level module for simulation
TOP_MODULE = tb_de2_115
TOP_OPT_MODULE = $(TOP_MODULE)_opt

all: work compile optimize simulate

include $(MAKEFILE_INCLUDE)

# Pull the eth_tse IP libraries into the main design's elaboration/optimization
# step (see the "eth_tse" target for how these libraries get built and mapped).
VOPT_CMD += -L eth_tse_work -L i_tse_mac

.PHONY: tb_mac_byp clean work optimize eth_tse

# compile depends on the eth_tse IP already being compiled into its own libraries
compile: eth_tse

# Compile the eth_tse IP into its own libraries (work and i_tse_mac, under
# $(IP_TSE_DIR)/libraries) using the Quartus-generated msim_setup.tcl script,
# then map those libraries under project-local names so the main design can
# reference them via -L without recompiling the IP sources every time and
# without clashing with this project's own "work" library.
# No target file is produced, so this is a .PHONY target.
eth_tse:
	cd $(IP_TSE_DIR) && vsim -c -do "source msim_setup.tcl; com; quit -f"
	vmap eth_tse_work $(IP_TSE_WORK_LIB)
	vmap i_tse_mac $(IP_TSE_MAC_LIB)

# Override compile target to ensure work directory exists
#compile: work
#	@echo $(TEST_MSG)
#	$(VLOG_CMD)

# Main target: using the top-level module as the target name
tb_mac_byp: TEST_MSG = "Starting simulation for $(TOP_MODULE)"
tb_mac_byp: simulate

# Override the clean target for Windows compatibility
clean:
	@echo "Cleaning up simulation files..."
	@$(CLEAN_CMD)
