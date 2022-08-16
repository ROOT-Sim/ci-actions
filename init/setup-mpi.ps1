$ErrorActionPreference = "Stop"

$mpi_url = "https://registrationcenter-download.intel.com/akdlm/irc_nas/18715/w_mpi_oneapi_p_2021.6.0.546_offline.exe"

$tempdir = $Env:RUNNER_TEMP
$mpi_installer_path = Join-Path $tempdir intel_installer.exe

Write-Host "Downloading Intel MPI from $mpi_url"
Invoke-WebRequest "$mpi_url" -OutFile $mpi_installer_path

Write-Host "Installing Intel MPI"
Start-Process $mpi_installer_path -ArgumentList "--silent -a --silent --action=install --eula=accept" -Wait
