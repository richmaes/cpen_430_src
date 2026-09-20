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

# List your SystemVerilog source files for firebird
# Include common support files (clock/reset/assert) if needed
TB_FILES = ../common/irst.v ../common/iclk.v ../common/assert_cpen430.v firebird_tb.v
RTL_FILES = debouncer.v counter.v taillight.v firebird.v
# Specify the top-level module for simulation
TOP_MODULE = firebird_tb
TOP_OPT_MODULE = $(TOP_MODULE)_opt

all: work compile simulate

include $(MAKEFILE_INCLUDE)

.PHONY: firebird_tb clean work

# Override compile target to ensure work directory exists
compile: work
	@echo $(TEST_MSG)
	$(VLOG_CMD)

# Main target: using the top-level module as the target name
top_tb: TEST_MSG = "Starting simulation for $(TOP_MODULE)"
top_tb: simulate

# Override the clean target for Windows compatibility
clean:
	@echo "Cleaning up simulation files..."
	@$(CLEAN_CMD)
