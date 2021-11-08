$ErrorActionPreference = "Stop"

$tempdir    = $Env:RUNNER_TEMP

Write-Host "Installing CMake"
Start-Process choco.exe install cmake --installargs 'ADD_CMAKE_TO_PATH=System'
