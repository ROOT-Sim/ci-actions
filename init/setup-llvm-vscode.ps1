# SPDX-FileCopyrightText: 2008-2025 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
Set-Location "C:\Program Files (x86)\Microsoft Visual Studio\Installer\"
$InstallPath = "C:\Program Files\Microsoft Visual Studio\2022\Preview"
$WorkLoads = '--add Microsoft.VisualStudio.Component.VC.Llvm.Clang --add Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset'
$Arguments = ('/c', "vs_installer.exe", 'modify', '--installPath', "`"$InstallPath`"", $WorkLoads, '--norestart', '--nocache')
$process = Start-Process -FilePath cmd.exe -ArgumentList $Arguments -Wait -PassThru -WindowStyle Hidden
if ($process.ExitCode -eq 0)
{
    Write-Host "components have been successfully added"
}
else
{
    Write-Host "components were not installed"
    exit 1
}