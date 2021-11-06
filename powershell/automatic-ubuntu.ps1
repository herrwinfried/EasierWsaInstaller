param(
[bool]$wsa,
[bool]$gapps,
[bool]$vmc
)
    $wsaint = [int][bool]::Parse($wsa)
    $gappsint = [int][bool]::Parse($gapps)
    $vmcint = [int][bool]::Parse($vmc)

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-ExecutionPolicy Bypass `"$PSCommandPath`" $wsaint $gappsint $vmcint " -Verb RunAs; exit }

$Arch = ($env:PROCESSOR_ARCHITECTURE)

if ($Arch -eq 'x86') {
    Write-Host -Object 'Running 32-bit PowerShell';
    Write-Host -Object 'Sorry I dont support 32 bit.';
}
elseif ($Arch -eq 'Arm32') {
    Write-Host -Object 'Running 32-bit arm PowerShell';
    Write-Host -Object 'Sorry I dont support 32 bit.';
}
elseif ($Arch -eq 'amd64') {
    Write-Host -Object 'Running 64-bit PowerShell';
    mkdir "C:\wsa"
    mkdir "C:\wsaproject"
    if ($vmcint) {
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    }
    if ($wsaint -and $gappsint) {
        wsl -d ubuntu -e sudo sh -c "cd ~ && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/main/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --gapps --all-okey"
    }
    elseif ($wsaint)
    {
        wsl -d ubuntu -e sudo sh -c "cd ~ && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/main/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --all-okey"
    }
    elseif ($gappsint)
    {
        wsl -d ubuntu -e sudo sh -c "cd ~ && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/main/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --gapps --all-okey"
    }
    elseif (! $wsaint -or ! $gappsint)
        Write-Host "Make sure you have Ubuntu(ubuntu without version number) installed or it could cause problems if things go wrong. If not, please close the window directly."
        Pause
    }
 
cd "C:\wsa\x64"
.\powershell.ps1

}
elseif ($Arch -eq 'Arm64') {
    Write-Host -Object 'Running 64-bit ARM PowerShell';
    mkdir "C:\wsa"
    mkdir "C:\wsaproject"
    Write-Host "BETA SCRIPT"
    if ($vmc) {
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    }
    if ($wsa -and $gapps) {
        wsl -d ubuntu -e sudo sh -c "cd ~ && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/main/setup-arm.sh -O setup-arm.sh && sudo chmod +x ./setup-arm.sh && sudo ./setup-arm.sh --wsa --gapps --all-okey"
    }
    elseif ($wsa)
    {
        wsl -d ubuntu -e sudo sh -c "cd ~ && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/main/setup-arm.sh -O setup-arm.sh && sudo chmod +x ./setup-arm.sh && sudo ./setup-arm.sh --wsa --all-okey"
    }
    elseif ($gapps)
    {
        wsl -d ubuntu -e sudo sh -c "cd ~ && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/main/setup-arm.sh -O setup-arm.sh && sudo chmod +x ./setup-arm.sh && sudo ./setup-arm.sh --gapps --all-okey"
    }
    else {
    Write-Host "Make sure you have Ubuntu(ubuntu without version number) installed or it could cause problems if things go wrong. If not, please close the window directly."
    Pause
    }
    cd "C:\wsa\ARM64"
.\powershell.ps1
}