param([bool]$nostop)
    $nostopint = [int][bool]::Parse($nostop)
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-ExecutionPolicy Bypass `"$PSCommandPath`" -nostop $nostopint" -Verb RunAs; exit }
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
    Set-Location "C:\wsa\x64"
    Add-AppxPackage -Register .\AppxManifest.xml
    $PSVersionTable
    if ($nostopint) {
Write-Host "No-Stop"
    } else {
        pause
    }


}
elseif ($Arch -eq 'Arm64') {
    Write-Host "BETA SCRIPT"
    Set-Location "C:\wsa\ARM64"
    Add-AppxPackage -Register .\AppxManifest.xml
    $PSVersionTable
    if ($nostopint) {
        Write-Host "No-Stop"
            } else {
                pause
            }
}