<#
.SYNOPSIS
Compiles and runs the LCD IP testbench with ModelSim.

.DESCRIPTION
Creates the work library, compiles the LCD IP and testbench, then runs the
simulation in command-line mode by default. Use -Gui to open the ModelSim GUI
and leave it open after the testbench finishes.

.PARAMETER Gui
Run the simulation in the ModelSim GUI and keep the GUI open at completion.

.EXAMPLE
.\run_script.ps1
Compile and run the testbench in command-line mode.

.EXAMPLE
.\run_script.ps1 -Gui
Compile and run the testbench in the ModelSim GUI.
#>
param(
    [switch] $Gui
)

$ErrorActionPreference = 'Stop'

function Invoke-ModelSimCommand {
    param(
        [Parameter(Mandatory = $true)]
        [string] $Command,
        [Parameter(Mandatory = $true)]
        [string[]] $Arguments
    )

    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "$Command failed with exit code $LASTEXITCODE"
    }
}

foreach ($command in @('vlib', 'vlog', 'vsim')) {
    if (-not (Get-Command -Name $command -ErrorAction SilentlyContinue)) {
        throw "$command was not found on PATH"
    }
}

Push-Location -LiteralPath $PSScriptRoot
try {
    if (Test-Path -LiteralPath 'work') {
        Remove-Item -LiteralPath 'work' -Recurse -Force
    }
    Invoke-ModelSimCommand -Command 'vlib' -Arguments @('work')
    Invoke-ModelSimCommand -Command 'vlog' -Arguments @(
        '-sv',
        '-work', 'work',
        '../common/iclk.v',
        '../common/irst.v',
        'lcd_timer.sv',
        'lcd_slow_cntr.sv'
        'lcd_ip.sv',
        'lcd_ip_tb.sv'
    )

    $simulationArguments = @(
        '-voptargs=+acc',
        '-wlf', 'lcd_ip_tb.wlf',
        '-l', 'simulation.log',
        'work.lcd_ip_tb'
    )
    if ($Gui) {
        $simulationArguments = @('-gui', '-onfinish', 'stop') + $simulationArguments + @(
            '-do', 'log -r /*; add wave -r /lcd_ip_tb/*; run -all; wave zoom full'
        )
    }
    else {
        $simulationArguments = @('-c', '-onfinish', 'exit') + $simulationArguments + @(
            '-do', 'log -r /*; run -all; quit -f'
        )
    }
    Invoke-ModelSimCommand -Command 'vsim' -Arguments $simulationArguments
}
finally {
    Pop-Location
}