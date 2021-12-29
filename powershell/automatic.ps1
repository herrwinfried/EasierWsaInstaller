param(
[string]$selectos,
[bool]$wsa,
[bool]$gapps,
[bool]$vmc,
[bool]$wsatools,
[bool]$wsadevwin,
[bool]$tempwsa,
[bool]$onlywsa
)

if ([string]::IsNullOrEmpty($selectos)) {
$selectos = "Unknown"
} elseif ([string]::IsNullOrWhiteSpace($selectos)) {
    $selectos = "Unknown"
}
$wsaint = [int][bool]::Parse($wsa)
$gappsint = [int][bool]::Parse($gapps)
$vmcint = [int][bool]::Parse($vmc)
$wsatoolsint = [int][bool]::Parse($wsatools)
$wsadevwinint = [int][bool]::Parse($wsadevwin)
$tempwsaint = [int][bool]::Parse($tempwsa)
$onlywsaint = [int][bool]::Parse($onlywsa)

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-ExecutionPolicy Bypass `"$PSCommandPath`" $selectos $wsaint $gappsint $vmcint $wsatoolsint $wsadevwinint $tempwsaint $onlywsaint" -Verb RunAs; exit }


Write-Host "1 = True/Yes/Active" -ForegroundColor Green
Write-Host "0 = False/No/Deactive" -ForegroundColor Red
Start-Sleep -s 0.75
Write-Host "Select OS: " -ForegroundColor Yellow -NoNewline; Write-Host "$selectos" -ForegroundColor White
Start-Sleep -s 0.2
Write-Host "WSA Value: " -ForegroundColor Green -NoNewline; Write-Host "$wsaint " -ForegroundColor White -NoNewline; Write-Host "| TempWSA Value: " -ForegroundColor Green -NoNewline; Write-Host "$tempwsaint" -ForegroundColor White
Start-Sleep -s 0.2
Write-Host "openGapps Value: " -ForegroundColor Blue -NoNewline; Write-Host "$gappsint" -ForegroundColor White 
Start-Sleep -s 0.2
Write-Host "Only WSA Value: " -ForegroundColor Blue -NoNewline; Write-Host "$onlywsaint" -ForegroundColor White 
Start-Sleep -s 0.2
Write-Host "Virtual Machine Platform Value: " -ForegroundColor Cyan -NoNewline; Write-Host "$vmcint" -ForegroundColor White
Start-Sleep -s 0.2
Write-Host "WSATools Value: " -ForegroundColor DarkYellow -NoNewline; Write-Host "$wsatoolsint" -ForegroundColor White
Start-Sleep -s 0.2
Write-Host "WSA And Windows Developer Mode Value: " -ForegroundColor Magenta -NoNewline; Write-Host "$wsadevwinint" -ForegroundColor White
Start-Sleep -s 0.2
Write-Host "Running Powershell version: " -ForegroundColor DarkBlue -NoNewline; Write-Host (Get-Host).Version -ForegroundColor White
Start-Sleep -s 3.88
Clear-Host

#####################################
if ( ((Get-Host).Version).Major -ne "5" ) 
{ 
    Import-Module -Name Appx -UseWIndowsPowershell
} 

$Arch = ($env:PROCESSOR_ARCHITECTURE)

if ($Arch -eq 'x86') {
    Write-Host -Object 'Running 32-bit PowerShell' -ForegroundColor Green
    Write-Host -Object 'Sorry I dont support 32 bit.' -ForegroundColor Red
    pause
    exit
}
elseif ($Arch -eq 'Arm32') {
    Write-Host -Object 'Running 32-bit arm PowerShell' -ForegroundColor Green
    Write-Host -Object 'Sorry I dont support 32 bit.' -ForegroundColor Red
    pause
    exit
}

elseif ($Arch -eq 'amd64') {
    Write-Host -Object 'Running 64-bit PowerShell' -ForegroundColor Green
}
elseif ($Arch -eq 'Arm64') {
    Write-Host -Object 'Running 64-bit ARM PowerShell' -ForegroundColor Green
}

#######
if ($Arch -eq 'Arm64' -or $Arch -eq 'amd64') {
    if (Test-Path -Path 'C:\wsa') {
        Write-Host "I found folder named wsa." -ForegroundColor Red
     } else {
        Write-Host "A folder will be created in the C directory named WSA" -ForegroundColor Green
         mkdir "C:\wsa"
     }
     if (Test-Path -Path 'C:\wsaproject') {
        Write-Host "I found folder named wsaproject." -ForegroundColor Red
     } else {
        Write-Host "A folder will be created in the C directory named wsaproject" -ForegroundColor Green
         mkdir "C:\wsaproject"
     }
     if (Test-Path -Path 'C:\wsaproject\microsoftwsa') {
        Write-Host "I found folder named microsoftwsa and delete." -ForegroundColor Red
        Remove-Item -Path C:\wsaproject\microsoftwsa\ -Force -Recurse
     } else {
     }

    if ($Arch -eq 'amd64') {
        if (Test-Path -Path 'C:\wsa\x64') {
            Write-Host "I found folder named amd64 and delete." -ForegroundColor Red
            Remove-Item -Path C:\wsa\x64 -Force -Recurse
         }

    }
    elseif ($Arch -eq 'Arm64') {
        if (Test-Path -Path 'C:\wsa\arm64') {
            Write-Host "I found folder named arm64 and delete." -ForegroundColor Red
            Remove-Item -Path C:\wsa\arm64 -Force -Recurse
         }
     } 
     if ($vmcint) {
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
        Clear-Host
    }

    if ( $selectos -eq "Ubuntu") {
        $prep = "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh"
        $OS = "Ubuntu"
    }
    
    elseif ( $selectos -eq "openSUSE-Tumbleweed") {
        $prep = "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh"
        $OS = "openSUSE-Tumbleweed"
    }
    elseif ( $selectos -eq "Debian") {
        $prep = "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.8 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh"
        $OS = "Debian"
    }
    else {
        Write-Host "cancel the transaction" -ForegroundColor Red
        Start-Sleep 2
        exit
    }

    $setup = "&& ./setup.sh"
    if ($Arch -eq 'Arm64') {
        $setup = $setup + " --arm"
    }
    if ( $wsaint -eq "1") {
        $setup = $setup + " --wsa"
        }
        if ( $gappsint -eq "1")
        {
            $setup = $setup + " --gapps"
        }
        $setup = $setup + " --all-okey"
        if ( $Arch -eq 'Arm64' -and $wsatoolsint -eq "1")
        {
            White-Host "No WSATools Arm support." -ForegroundColor Red
            Start-Sleep 2.5
            $wsatoolsint = $False;
            $wsatools = $False;
        }
        elseif ( $Arch -eq 'amd64' -and $wsatoolsint -eq "1")
        {
            $setup = $setup + " --wsatools"
        }
        if ( $tempwsaint -eq "1") {
            $setup = $setup + " --tempwsa"
        }
        if ( $tempwsaint -eq "0") {
            $setup = $setup + " --no-tempwsa"
        }
        if ( $onlywsaint -eq "1") {
            $setup = $setup + " --wsaonly"
        }
        $prep1 = 'sudo sh -c "'
        $prep2 = '"'
Write-Host "wsl -d $OS -e $prep1$prep$setup$prep2"
Start-Process -NoNewWindow wsl "-d $OS -e $prep1$prep$setup$prep2"

        if ( $wsatoolsint ) {
            Clear-Host
            Set-Location "C:\wsaproject"
           .\wsatools.ps1 1
        }
    pause
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