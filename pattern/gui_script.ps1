$ErrorActionPreference = 'Stop'

Push-Location -LiteralPath $PSScriptRoot
try {
    if (-not (Test-Path -LiteralPath 'tb_pattern.wlf' -PathType Leaf)) {
        throw 'tb_pattern.wlf not found; run .\run_script.ps1 first.'
    }

    if (-not (Get-Command -Name 'vsim' -ErrorAction SilentlyContinue)) {
        throw 'vsim was not found on PATH'
    }

    & vsim -64 -view tb_pattern.wlf
    if ($LASTEXITCODE -ne 0) {
        throw "vsim failed with exit code $LASTEXITCODE"
    }
}
finally {
    Pop-Location
}