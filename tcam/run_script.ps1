param(
    [switch] $Gui,
    [string] $MemFile = (Join-Path $PSScriptRoot 'entries.hex')
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

$memoryPath = (Resolve-Path -LiteralPath $MemFile).ProviderPath
if (-not (Test-Path -LiteralPath $memoryPath -PathType Leaf)) {
    throw "Memory file is not a file: $memoryPath"
}
$memoryPath = $memoryPath.Replace('\', '/')

Push-Location -LiteralPath $PSScriptRoot
try {
    if (Test-Path -LiteralPath 'work') {
        Remove-Item -LiteralPath 'work' -Recurse -Force
    }
    Invoke-ModelSimCommand -Command 'vlib' -Arguments @('work')
    Invoke-ModelSimCommand -Command 'vlog' -Arguments @(
        '-sv',
        '-work', 'work',
        'mini_tcam.sv',
        'tcam_tb.sv'
    )

    $simulationArguments = @(
        '-voptargs=+acc',
        '-wlf', 'tcam_tb.wlf',
        '-l', 'simulation.log',
        'work.tcam_tb',
        "+MEM_FILE=$memoryPath"
    )
    if ($Gui) {
        $simulationArguments = @('-gui', '-onfinish', 'stop') + $simulationArguments + @(
            '-do', 'log -r /*; add wave -r /tcam_tb/*; run -all; wave zoom full'
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