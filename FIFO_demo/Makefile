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
    LIB_PATH = C:\intelFPGA\18.0\modelsim_ase\altera\verilog
    
else
    SHELL = /bin/bash
    # Unix-specific settings
    MAKEFILE_INCLUDE = ../Makefile.include
    PATH_SEP = /
endif

LIBS = altera_mf altera_lnsim
# LIB_INC collects -L flags for the simulator. Compute at parse-time using make's
# foreach so the flags are available to recipe commands (not generated inside a shell loop).
# By default this produces: -L altera_mf -L altera_lnsim
LIB_INC := $(foreach L,$(LIBS),-L $(L))

# Create work library
work:
	@if not exist work (vlib work)

# List your SystemVerilog source files for FIFO demo
# Include common support files (clock/reset) if needed
TB_FILES = ../common/irst.v ../common/iclk.v tb_FIFO_demo.sv
RTL_FILES = fifo_structs.svh FIFO_demo.sv
RTL_FILES += ip/fifo_33x16.v



# Specify the top-level module for simulation
TOP_MODULE = tb_FIFO_demo
TOP_OPT_MODULE = $(TOP_MODULE)_opt

all: work compile simulate

include $(MAKEFILE_INCLUDE)

# Append the computed LIB_INC flags to the VLOG command defined in Makefile.include
# This adds the -L <lib> flags to the simulator compile command
# VLOG_CMD += $(LIB_INC)
VSIM_CMD += $(LIB_INC)
.PHONY: tb_FIFO_demo clean work vmap_all

# Create vmap mappings for all libraries listed in LIBS
# This ensures ModelSim/Questa knows where each library directory is
vmap_all:
	@echo "Creating library mappings (vmap)"
ifeq ($(OS),Windows_NT)
	@for %%L in ($(LIBS)) do vmap  %%L "$(LIB_PATH)$(PATH_SEP)%%L"
else
	@for lib in $(LIBS); do vmap $$lib "$(LIB_PATH)$(PATH_SEP)$$lib"; done
endif

# Override compile target to ensure work directory exists and the
# vmap mappings are created before compilation
compile: work vmap_all
	@echo $(TEST_MSG)
	$(VLOG_CMD)

# Main target: using the top-level module as the target name
top_tb: TEST_MSG = "Starting simulation for $(TOP_MODULE)"
top_tb: simulate

# Override the clean target for Windows compatibility
clean:
	@echo "Cleaning up simulation files..."
	@$(CLEAN_CMD)
