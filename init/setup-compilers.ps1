$ErrorActionPreference = "Stop"

$tempdir    = $Env:RUNNER_TEMP

Write-Host "Installing Clang"
Start-Process choco.exe upgrade llvm -y --no-progress --allow-downgrade
Write-Host "Installing MinGW"
Start-Process choco.exe upgrade mingw -y --no-progress --allow-downgrade
