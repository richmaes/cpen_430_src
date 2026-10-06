$ErrorActionPreference = 'Stop'

function Invoke-ModelSimCommand {
    param(
        [Parameter(Mandatory = $true)]
        [string] $Command,
        [Parameter(Mandatory = $true)]
        [string[]] $Arguments
    )

    if (-not (Get-Command -Name $Command -ErrorAction SilentlyContinue)) {
        throw "$Command was not found on PATH"
    }

    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "$Command failed with exit code $LASTEXITCODE"
    }
}

Push-Location -LiteralPath $PSScriptRoot
try {
    if (-not (Test-Path -LiteralPath 'work')) {
        Invoke-ModelSimCommand -Command 'vlib' -Arguments @('work')
    }

    Invoke-ModelSimCommand -Command 'vlog' -Arguments @(
        '-sv',
        '+define+SIMULATION',
        '../common/irst.v',
        '../common/iclk.v',
        'match_one.sv',
        'match_many.sv',
        'tb_pattern.sv'
    )

    Invoke-ModelSimCommand -Command 'vsim' -Arguments @(
        '-64',
        '-c',
        '+acc',
        '-nowlfcompress',
        '-nowlfdeleteonquit',
        '+fsdb+all=on',
        '-wlf',
        'tb_pattern.wlf',
        'tb_pattern',
        '-do',
        'run -all; quit -f'
    )
}
finally {
    Pop-Location
}