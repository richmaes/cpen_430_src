# Mini-TCAM Testbench

Compile `mini_tcam.sv` and `tcam_tb.sv` as SystemVerilog. The testbench loads eight
512-bit entries into the dummy DUT's packed `mem` array through hierarchical
assignments. There is no hardware write port. Reset does not clear memory.

The DUT accepts `data` (key) and `tcam` (mask) when `valid` is high while idle.
It also accepts a request on the edge that reports the preceding result,
allowing requests every 9 clocks. Requests on other busy cycles are ignored. Reset is
synchronous and active high, and aborts an active search.
The registered RAM output is `logic [511:0] mem_d`; `addr` free-runs through
the eight locations, including while idle. Searches begin at the current
scan position and wrap around, comparing all eight entries before reporting
the lowest numerical matching address. A mask bit of 1 means don't-care.
`match` and `no_match` are mutually exclusive one-cycle pulses;
`match_addr` is meaningful only with `match`. Every result arrives 9 clocks
after request acceptance. To sustain the 9-clock interval, the next key, mask,
and `valid` must be set up before that result edge. Waiting to observe the
result before driving the next request instead gives a 10-clock interval.
The testbench uses only external ports after loading and checking memory;
it never reads internal control state. A second key/mask register for an 8-clock interval is not
implemented yet.

## Memory File

Pass the memory-file path using the required `+MEM_FILE` simulator argument.
The file uses `$readmemh` format: eight entries, in address order 0 through 7,
with 128 hexadecimal digits per entry. Use one entry per line and no `0x`
prefix. Data must contain only known bits, not `x` or `z`.
Relative paths are resolved from the simulator's working directory.

The supplied `entries.hex` contains eight known patterns: each entry repeats
its address digit across all 128 hexadecimal digits. The testbench first loads
`dut.mem[0]` through `dut.mem[7]`, holds reset with `valid` low for two clocks,
then checks and prints every entry. It then sends 1,000 lookups at exactly
9-clock intervals, repeating a pattern of eight exact-match queries, two masks constructed to match
at least two loaded entries, an all-don't-care query, and a guaranteed miss.
A reference comparison over the loaded data checks the lowest numerical
matching address, result timing, and single-cycle result pulses. Changing
key/mask inputs after each request also checks that the DUT latches them.

## Launch Script

With ModelSim's `vlib`, `vlog`, and `vsim` on PATH, run from the repository root:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
.\tcam\run_script.ps1
```

The execution-policy change applies only to the current PowerShell session.
The launcher compiles and simulates in command-line mode. To open the GUI:

```powershell
.\tcam\run_script.ps1 -gui
```

Alternatively, run from the `tcam` directory:

```powershell
.\run_script.ps1
.\run_script.ps1 -gui
.\run_script.ps1 -MemFile 'C:\my memories\entries.hex'
.\run_script.ps1 -gui -MemFile 'C:\my memories\entries.hex'
```

The script defaults to command-line mode and the supplied `entries.hex`.
It deletes and recreates `tcam/work` on every run, compiles both SystemVerilog
files, and passes the resolved memory-file path through `+MEM_FILE`.
Relative `-MemFile` paths are resolved from the caller's current directory.
Close any simulation using this work library before rerunning the script.

Debug access is enabled with `-voptargs=+acc`, and signals are logged recursively
to `tcam/tcam_tb.wlf`. Simulator output is saved in `tcam/simulation.log`.
GUI mode adds signals to the wave window, runs the test, and stays open at
`$finish`; command-line mode exits when the test finishes.

Equivalent manual ModelSim commands, run from the `tcam` directory after
removing any existing work library:

```text
vlib work
vlog -sv mini_tcam.sv tcam_tb.sv
vsim -c work.tcam_tb +MEM_FILE=entries.hex -do "run -all; quit -f"
```

Use a different path with `+MEM_FILE` to supply your own known data.