if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
$Arch = ($env:PROCESSOR_ARCHITECTURE)
Import-Module -Name Appx -UseWIndowsPowershell
if ($Arch -eq 'x86') {
    Write-Host -Object 'Running 32-bit PowerShell';
    Write-Host -Object 'Sorry I dont support 32 bit.';
    pause
}
elseif ($Arch -eq 'Arm32') {
    Write-Host -Object 'Running 32-bit arm PowerShell';
    Write-Host -Object 'Sorry I dont support 32 bit.';
    pause
}
elseif ($Arch -eq 'amd64') {
    Set-Location "C:\wsaproject"
    add-appxpackage .\WSATools.Msixbundle
    $PSVersionTable
pause
}
elseif ($Arch -eq 'Arm64') {
    Write-Host "Developer Sorry, it doesn't support ARM. (WSATools)"
Pause
}