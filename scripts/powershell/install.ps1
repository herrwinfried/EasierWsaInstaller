param([bool]$nostop=1,
[bool]$original=1)
    $nostopint = [int][bool]::Parse($nostop)
    $originalint = [int][bool]::Parse($original)
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-ExecutionPolicy Bypass `"$PSCommandPath`" -nostop $nostopint -original $originalint" -Verb RunAs; exit }
$Arch = ($env:PROCESSOR_ARCHITECTURE)
if ( ((Get-Host).Version).Major -ne "5" ) 
{ 
    Import-Module -Name Appx -UseWIndowsPowershell
} 
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
    Write-Host -Object 'Running 64-bit PowerShell';
    Set-Location "C:\wsa\x64"
}
elseif ($Arch -eq 'Arm64') {
    Write-Host -Object 'Running 64-bit arm PowerShell';
    Set-Location "C:\wsa\ARM64"
}
if ($Arch -eq 'Arm64' -or $Arch -eq 'amd64') {
    if ($originalint -eq 1) {

        Set-Location "C:\wsaproject"
        Add-AppxPackage Microsoft*WindowsSubsystemForAndroid*.msixbundle
    } else {
        Add-AppxPackage -Register .\AppxManifest.xml
    }
    $PSVersionTable
    if ($nostopint) {
Write-Host "No-Stop"
    } else {
        pause
    }
}