param(
[string]$selectos,
[bool]$wsa,
[bool]$vmc,
[bool]$wsatools

)
    $wsaint = [int][bool]::Parse($wsa)
    $vmcint = [int][bool]::Parse($vmc)
    $wsatoolsint = [int][bool]::Parse($wsatools)
Write-Host "$wsatoolsint $wsaint $vmcint $selectos"
pause

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-ExecutionPolicy Bypass `"$PSCommandPath`" $selectos $wsaint $vmcint $wsatoolsint" -Verb RunAs; exit }
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
    Write-Host -Object 'Running 64-bit PowerShell';
    $wsaprojectfolderr = 'C:\wsaproject'
    if (Test-Path -Path $wsaprojectfolderr) {
       Write-Host "I found folder named wsaproject."
    } else {
        mkdir "C:\wsaproject"
    }
    Clear-Host
        if ($vmcint) {
            dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
            Clear-Host
        }
if ( $selectos -eq "Ubuntu") {
    Clear-Host
        if ($wsa)
        {
            Clear-Host
            wsl -d ubuntu -e sudo sh -c "cd /tmp/ && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsaonly --all-okey"
    }
    elseif ($wsaint -and $wsatoolsint) {
        {
            Clear-Host
            wsl -d ubuntu -e sudo sh -c "cd /tmp/ && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsaonly --wsatools --all-okey"
    }
    }
}
if ( $selectos -eq "openSUSE-Tumbleweed") {
   Clear-Host
    if ($wsa)
    {
        Clear-Host
        wsl -d ubuntu -e sudo sh -c "cd /tmp/ && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsaonly --all-okey"
}
elseif ($wsaint -and $wsatoolsint) {
    
        Clear-Host
        wsl -d ubuntu -e sudo sh -c "cd /tmp/ && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsaonly --wsatools --all-okey"
}

}
Set-Location "C:\wsaproject"
Write-Host "Your file has been downloaded under c:\wsaproject. You can double click and install."
pause
}
elseif ($Arch -eq 'Arm64') {
$wsaprojectfolderr = 'C:\wsaproject'
if (Test-Path -Path $wsaprojectfolderr) {
   Write-Host "I found folder named wsaproject."
} else {
    mkdir "C:\wsaproject"
}

Clear-Host
    Write-Host "BETA SCRIPT"
    if ($vmcint) {
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    }
    if ( $selectos -eq "Ubuntu") {
        Clear-Host
            if ($wsa)
            {
                Clear-Host
                wsl -d ubuntu -e sudo sh -c "cd /tmp/ && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsaonly --all-okey"
        }
        elseif ($wsaint -and $wsatoolsint) {
            {
                Clear-Host
                wsl -d ubuntu -e sudo sh -c "cd /tmp/ && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsaonly --wsatools --all-okey"
        }
        }
    }
    if ( $selectos -eq "openSUSE-Tumbleweed") {
       Clear-Host
        if ($wsa)
        {
            Clear-Host
            wsl -d ubuntu -e sudo sh -c "cd /tmp/ && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsaonly --all-okey"
    }
    elseif ($wsaint -and $wsatoolsint) {
        
            Clear-Host
            wsl -d ubuntu -e sudo sh -c "cd /tmp/ && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsaonly --wsatools --all-okey"
    }
    
    }
Set-Location "C:\wsaproject"
Write-Host "Your file has been downloaded under c:\wsaproject. You can double click and install."
pause
}