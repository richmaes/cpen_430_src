# LCD IP Prototype

This directory contains an LCD controller prototype, its initialization timer,
a slow pulse generator, and a ModelSim testbench. The testbench clock has a
20 ns period (50 MHz).

## Testbench

`lcd_ip_tb.sv` instantiates the shared clock and reset helpers, `lcd_slow_cntr`,
and `lcd_ip`. After reset and a short settling period, it runs for 5,000,000
clock cycles (about 100 ms at 50 MHz) and then finishes. It does not contain
assertions or check LCD transactions; this is currently a simulation harness,
not a self-checking testbench.

## Slow Counter

`lcd_slow_cntr.sv` contains a 16-bit counter that counts from 0 through 50,000,
then returns to 0. Its registered `pulse` output is high for one clock when the
counter is 0, producing a pulse about every 50,001 clocks (approximately
1.00002 ms at 50 MHz). The testbench connects this signal to `lcd_ip.pulse`;
the current `lcd_ip` implementation does not use that input.

## LCD Controller and Timer

`lcd_ip.sv` contains an initialization state machine and instantiates
`lcd_timer.sv`. The state machine waits for 15 ms, passes through `FS_0`, waits
5 ms, passes through `FS_1`, then performs four 1 ms waits around the
`FS_2`, `DISPLAY_OFF`, and `DISPLAY_CLEAR` states before reaching
`ENTRY_MODE_SET` and `LCD_READY`. `clear` is asserted on entry to each wait
state to restart the timer.

`lcd_timer.sv` uses a 20-bit counter. At 50 MHz its thresholds are 50,000,
250,000, and 750,000 clocks for the 1 ms, 5 ms, and 15 ms outputs. The outputs
are registered threshold flags; `clear` resets both the counter and flags.
Without `clear`, the counter increments until it reaches its maximum value and
then holds.

The LCD data-transfer path is not implemented yet. `lcd_cmd`, `lcd_char`, and
`lcd_valid` are unused, `lcd_ready` and `e` are not driven, and `rs`/`rw` are
held low while `db` is high impedance. The internal transfer state machine
also depends on `w_cmd` and `is_done`, which are not currently driven.

## Run

With ModelSim's `vlib`, `vlog`, and `vsim` on `PATH`, run from the repository
root:

```powershell
.\lcd_ip\run_script.ps1
```

If PowerShell blocks the script because of the execution policy, allow scripts
for the current PowerShell process and then run the launcher:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
.\lcd_ip\run_script.ps1
```

This temporary setting applies only to the current PowerShell session and
does not require administrator privileges. A policy enforced by your
organization may override it.

Use GUI mode with:

```powershell
.\lcd_ip\run_script.ps1 -Gui
```

The script can also be run from this directory as `./run_script.ps1` or
`./run_script.ps1 -Gui`. It recreates `work`, compiles the helper modules and
LCD sources, and writes `simulation.log` and `lcd_ip_tb.wlf` here. GUI mode
adds testbench signals to the wave window and leaves ModelSim open at the end;
command-line mode exits when the testbench finishes. Use `Get-Help
.\lcd_ip\run_script.ps1 -Full` for the launcher's help.