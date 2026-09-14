# Detect OS and set appropriate shell and commands
ifeq ($(OS),Windows_NT)
    SHELL = cmd.exe
    # Windows-specific settings
    MAKEFILE_INCLUDE = $(CURDIR)\..\Makefile.include
    PATH_SEP = \\
    ECHO = echo
    RM = del /F /Q
    RMDIR = rmdir /S /Q
    CLEAN_CMD = if exist work $(RMDIR) work & if exist transcript $(RM) transcript & if exist *.wlf $(RM) *.wlf

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

TB_FILES = ../common/irst.v ../common/iclk.v  ../sim_model/eth_test_pkg.sv ../sim_model/eth_tse_sim.sv ./sim/tb_de2_115.sv
RTL_FILES = DE2_115.sv
RTL_FILES += eth_core.sv
RTL_FILES += ../common/cpen430_dcfifo.v
# Specify the top-level module for simulation
TOP_MODULE = tb_de2_115
TOP_OPT_MODULE = $(TOP_MODULE)_opt

all: work compile optimize simulate

include $(MAKEFILE_INCLUDE)

.PHONY: tb_mac_byp clean work optimize

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
