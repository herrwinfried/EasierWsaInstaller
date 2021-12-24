param(
[string]$selectos,
[bool]$wsa,
[bool]$gapps,
[bool]$vmc,
[bool]$wsatools,
[bool]$wsadevwin
)
    $wsaint = [int][bool]::Parse($wsa)
    $gappsint = [int][bool]::Parse($gapps)
    $vmcint = [int][bool]::Parse($vmc)
    $wsatoolsint = [int][bool]::Parse($wsatools)
    $wsadevwinint = [int][bool]::Parse($wsadevwin)
Write-Host "$selectos $wsaint $gappsint $vmcint $wsatoolsint $wsadevwinint"

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-ExecutionPolicy Bypass `"$PSCommandPath`" $selectos $wsaint $gappsint $vmcint $wsatoolsint $wsadevwinint" -Verb RunAs; exit }
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
    $wsafolder = 'C:\wsa'
    if (Test-Path -Path $wsafolder) {
       Write-Host "I found folder named wsa."
    } else {
        mkdir "C:\wsa"
    }
    $wsaprojectfolderr = 'C:\wsaproject'
    if (Test-Path -Path $wsaprojectfolderr) {
       Write-Host "I found folder named wsaproject."
    } else {
        mkdir "C:\wsaproject"
    }
    
    $wsaprojectfolderr = 'C:\wsaproject\microsoftwsa'
    if (Test-Path -Path $wsaprojectfolderr) {
       Write-Host "I found folder named microsoftwsa and delete."
       Remove-Item -Path C:\wsaproject\microsoftwsa\ -Force -Recurse
    } else {
    }
    $wsaprojectfolderr = 'C:\wsa\x64'
    if (Test-Path -Path $wsaprojectfolderr) {
       Write-Host "I found folder named wsa and delete."
       Remove-Item -Path C:\wsa\x64 -Force -Recurse
    } else {
    }
    Clear-Host
        if ($vmcint) {
            dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
            Clear-Host
        }
if ( $selectos -eq "Ubuntu") {
    Clear-Host

    if ($wsatoolsint) {
        if ($wsaint -and $gappsint) {
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --opengapps --wsatools --all-okey"
        }
        elseif ($wsaint)
        {
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --wsatools --all-okey"
        }
        elseif ($gappsint)
        {
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --opengapps --wsatools --all-okey"
        }
        elseif (! $wsaint -or !$gappsint )
        {
            Write-Host "Make sure you have Ubuntu(ubuntu without version number) installed or it could cause problems if things go wrong. If not, please close the window directly."
            Pause
            Clear-Host
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsatools --all-okey"
        }
        if ( $wsatoolsint ) {
            Clear-Host
            Set-Location "C:\wsaproject"
           .\wsatools.ps1 1
        }
    }
    else {
        if ($wsaint -and $gappsint) {
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --opengapps --all-okey"
        }
        elseif ($wsaint)
        {
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --all-okey"
        }
        elseif ($gappsint)
        {
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --opengapps --all-okey"
        }
        elseif (! $wsaint -or !$gappsint )
        {
            Write-Host "Make sure you have Ubuntu(ubuntu without version number) installed or it could cause problems if things go wrong. If not, please close the window directly."
            Pause
            Clear-Host
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --all-okey"
        }
    }
    
}

if ( $selectos -eq "openSUSE-Tumbleweed") {
    Clear-Host
    if ($wsatoolsint) {
        if ($wsaint -and $gappsint) {
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --opengapps --wsatools --all-okey"
        }
        elseif ($wsaint)
        {
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --wsatools --all-okey"
        }
        elseif ($gappsint)
        {
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --opengapps --wsatools --all-okey"
        }
        elseif (! $wsaint -or !$gappsint )
        {
            Write-Host "Make sure you have openSUSE Tumbleweed installed or it could cause problems if things go wrong. If not, please close the window directly."
            Pause
            Clear-Host
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsatools --all-okey"
        }
        if ( $wsatoolsint ) {
            Clear-Host
            Set-Location "C:\wsaproject"
           .\wsatools.ps1 1
        }
    }
    else {
        if ($wsaint -and $gappsint) {
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --opengapps --all-okey"
        }
        elseif ($wsaint)
        {
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --all-okey"
        }
        elseif ($gappsint)
        {
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --opengapps --all-okey"
        }
        elseif (! $wsaint -or !$gappsint )
        {
            Write-Host "Make sure you have openSUSE Tumbleweed installed or it could cause problems if things go wrong. If not, please close the window directly."
            Pause
            Clear-Host
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --all-okey"
        }
    }
}
if ( $selectos -eq "Debian") {
    Clear-Host

    if ($wsatoolsint) {
        if ($wsaint -and $gappsint) {
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --opengapps --wsatools --all-okey"
        }
        elseif ($wsaint)
        {
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --wsatools --all-okey"
        }
        elseif ($gappsint)
        {
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --opengapps --wsatools --all-okey"
        }
        elseif (! $wsaint -or !$gappsint )
        {
            Write-Host "Make sure you have Debian(Debian without version number) installed or it could cause problems if things go wrong. If not, please close the window directly."    
            Pause
            Clear-Host
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsatools --all-okey"
        }
        if ( $wsatoolsint ) {
            Clear-Host
            Set-Location "C:\wsaproject"
           .\wsatools.ps1 1
        }
    }
    else {
        if ($wsaint -and $gappsint) {
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --opengapps --all-okey"
        }
        elseif ($wsaint)
        {
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --all-okey"
        }
        elseif ($gappsint)
        {
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --opengapps --all-okey"
        }
        elseif (! $wsaint -or !$gappsint )
        {
            Write-Host "Make sure you have Debian(Debian without version number) installed or it could cause problems if things go wrong. If not, please close the window directly."    
            Pause
            Clear-Host
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --all-okey"
        }
    }
    
}
Set-Location "C:\wsaproject"
if ( $wsadevwinint -eq 1 ) {
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"
}
.\Setup.ps1 1
if ( $wsadevwinint -eq 1 ) {
    $wsalocation = "$env:LOCALAPPDATA/Packages/MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe/Settings/settings.dat"
    $mountPoint = "HKLM\WSA"
reg load $mountPoint $wsalocation
    $develbit = "1"
    $data  = "Windows Registry Editor Version 5.00`n`n"
    $data += "[HKEY_LOCAL_MACHINE\WSA]`n`n"
    $data += "[HKEY_LOCAL_MACHINE\WSA\LocalState]`n"
    $data += "`"DeveloperModeEnabled`"=hex(5f5e10b):0"+ $develbit + ",07,b9,6f,f3,d3,dc,d7,01`n"
    $data | Out-File "./wsadevelopermode.reg"
[gc]::collect()
reg import "./wsadevelopermode.reg"
reg unload $mountPoint
}
}
elseif ($Arch -eq 'Arm64') {
    $wsafolder = 'C:\wsa'
if (Test-Path -Path $wsafolder) {
   Write-Host "I found folder named wsa."
} else {
    mkdir "C:\wsa"
}
$wsaprojectfolderr = 'C:\wsaproject'
if (Test-Path -Path $wsaprojectfolderr) {
   Write-Host "I found folder named wsaproject."
} else {
    mkdir "C:\wsaproject"
}

$wsaprojectfolderr = 'C:\wsaproject\microsoftwsa'
if (Test-Path -Path $wsaprojectfolderr) {
   Write-Host "I found folder named microsoftwsa and delete."
   Remove-Item -Path C:\wsaproject\microsoftwsa\ -Force -Recurse
} else {
}
$wsaprojectfolderr = 'C:\wsa\arm64'
if (Test-Path -Path $wsaprojectfolderr) {
   Write-Host "I found folder named wsa and delete."
   Remove-Item -Path C:\wsa\arm64 -Force -Recurse
} else {
}
Clear-Host
    Write-Host "BETA SCRIPT"
    if ($vmcint) {
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    }
if ( $selectos -eq "Ubuntu") {
    Clear-Host
    if ($wsatoolsint) {
        if ($wsaint -and $gappsint) {
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --opengapps --wsatools --all-okey"
        }
        elseif ($wsaint)
        {
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --wsatools --all-okey"
        }
        elseif ($gappsint)
        {
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --opengapps --wsatools --all-okey"
        }
        elseif (! $wsaint -or !$gappsint )
        {
            Write-Host "Make sure you have Ubuntu(ubuntu without version number) installed or it could cause problems if things go wrong. If not, please close the window directly."
            Pause
            Clear-Host
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsatools --all-okey"
        }
        if ( $wsatoolsint ) {
            Clear-Host
            Set-Location "C:\wsaproject"
           .\wsatools.ps1 1
        }
    }
    else {
        if ($wsaint -and $gappsint) {
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --opengapps --all-okey"
        }
        elseif ($wsaint)
        {
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --all-okey"
        }
        elseif ($gappsint)
        {
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --opengapps --all-okey"
        }
        elseif (! $wsaint -or !$gappsint )
        {
            Write-Host "Make sure you have Ubuntu(ubuntu without version number) installed or it could cause problems if things go wrong. If not, please close the window directly."
            Pause
            Clear-Host
            wsl -d ubuntu -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --all-okey"
        }
    }

}
if ( $selectos -eq "openSUSE-Tumbleweed") {
    Clear-Host
    if ($wsatoolsint) {
        if ($wsaint -and $gappsint) {
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --opengapps --wsatools --all-okey"
        }
        elseif ($wsaint)
        {
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --wsatools --all-okey"
        }
        elseif ($gappsint)
        {
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --opengapps --wsatools --all-okey"
        }
        elseif (! $wsaint -or !$gappsint )
        {
            Write-Host "Make sure you have openSUSE Tumbleweed installed or it could cause problems if things go wrong. If not, please close the window directly."
            Pause
            Clear-Host
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsatools --all-okey"
        }
        if ( $wsatoolsint ) {
            Clear-Host
            Set-Location "C:\wsaproject"
           .\wsatools.ps1 1
        }
    }
    else {
        if ($wsaint -and $gappsint) {
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --opengapps --all-okey"
        }
        elseif ($wsaint)
        {
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --all-okey"
        }
        elseif ($gappsint)
        {
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --opengapps --all-okey"
        }
        elseif (! $wsaint -or !$gappsint )
        {
            Write-Host "Make sure you have openSUSE Tumbleweed installed or it could cause problems if things go wrong. If not, please close the window directly."
            Pause
            Clear-Host
            wsl -d openSUSE-Tumbleweed -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --all-okey"
        }
    }
}
if ( $selectos -eq "Debian") {
    Clear-Host
    if ($wsatoolsint) {
        if ($wsaint -and $gappsint) {
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --opengapps --wsatools --all-okey"
        }
        elseif ($wsaint)
        {
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --wsatools --all-okey"
        }
        elseif ($gappsint)
        {
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --opengapps --wsatools --all-okey"
        }
        elseif (! $wsaint -or !$gappsint )
        {
            Write-Host "Make sure you have Debian(Debian without version number) installed or it could cause problems if things go wrong. If not, please close the window directly."
            Pause
            Clear-Host
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsatools --all-okey"
        }
        if ( $wsatoolsint ) {
            Clear-Host
            Set-Location "C:\wsaproject"
           .\wsatools.ps1 1
        }
    }
    else {
        if ($wsaint -and $gappsint) {
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --opengapps --all-okey"
        }
        elseif ($wsaint)
        {
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --all-okey"
        }
        elseif ($gappsint)
        {
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --opengapps --all-okey"
        }
        elseif (! $wsaint -or !$gappsint )
        {
            Write-Host "Make sure you have Debian(Debian without version number) installed or it could cause problems if things go wrong. If not, please close the window directly."
            Pause
            Clear-Host
            wsl -d Debian -e sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --all-okey"
        }
    }

}
Set-Location "C:\wsaproject"
if ( $wsadevwinint -eq 1 ) {
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"
}
.\Setup.ps1 1
if ( $wsadevwinint -eq 1 ) {
    $wsalocation = "$env:LOCALAPPDATA/Packages/MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe/Settings/settings.dat"
    $mountPoint = "HKLM\WSA"
reg load $mountPoint $wsalocation
    $develbit = "1"
    $data  = "Windows Registry Editor Version 5.00`n`n"
    $data += "[HKEY_LOCAL_MACHINE\WSA]`n`n"
    $data += "[HKEY_LOCAL_MACHINE\WSA\LocalState]`n"
    $data += "`"DeveloperModeEnabled`"=hex(5f5e10b):0"+ $develbit + ",07,b9,6f,f3,d3,dc,d7,01`n"
    $data | Out-File "./wsadevelopermode.reg"
[gc]::collect()
reg import "./wsadevelopermode.reg"
reg unload $mountPoint
}
}
