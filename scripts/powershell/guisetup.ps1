param (
    [string]$wsldistro = 'Ubuntu',

    [ValidateSet('amd64','arm64')]
    [string]$arch = 'amd64',

    [ValidateSet('tr-tr','de-de', 'en-US')]
    [string]$scriptlang = 'en-US',

    [ValidateSet('onlywsa','wsagascript', 'magiskonwsalocal')]
    [string]$method = 'magiskonwsalocal',

       [ValidateSet('fast','slow', 'rp', 'retail')]
        [string]$wsarelease = 'retail',

        [ValidateSet('stable','beta', 'canary', 'debug')]
        [string]$magiskversion = 'stable',

        [ValidateSet('yes','no')]
        [string]$amazonstore = 'no',

        [ValidateSet('yes','no')]
        [string]$wsatools = 'no',

        [string]$productname = 'redfin',

        [ValidateSet('super','stock', 'full', 'mini','micro','nano', 'pico')]
        [string]$gappsvariant = 'pico',

        [ValidateSet('yes','no')]
        [string]$winvmc = 'yes',

        [ValidateSet('yes','no')]
        [string]$windevmode = 'yes'
        )
      
#$WindowsArch = ($env:PROCESSOR_ARCHITECTURE)
#if (!$WindowsArch) {
#    Write-Host "Only Windows Powershell Core." -ForegroundColor Red;
#    Start-Sleep -s 0.60
#    Exit 1
#} else if ($WindowsArch -eq 'x86' -or $WindowsArch -eq 'Arm32') {
#    write-Host "Sorry I dont support $WindowsArch"
#    Start-Sleep -s 0.60
#    Exit 1
#}


Write-Host "This script is for the wsa-gui project." -ForegroundColor Yellow;
Start-Sleep -s 0.70
write-host "== Script ==" -ForegroundColor Cyan;
write-host $wsldistro $arch $scriptlang $method $wsarelease $magiskversion $amazonstore $wsatools $productname $gappsvariant
write-host "== Windows ==" -ForegroundColor Green; Write-Host $winvmc $windevmode

####################################################################################################################################

if ($winvmc) {
    Write-host "[PREP] I Activate Virtual Machine Platform."
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
}

$wslprep
$wslprep1 = 'sudo sh -c "'
$wslprep2 = '"'
$wslsetup = "&& setup.sh "

if ( $wsldistro -eq "Ubuntu") {
    $wslprep = "cd ~; sudo rm -rf /tmp/wsa*; sudo apt update && sudo apt upgrade -y; sudo apt install -y git curl wget; cd /tmp/; git clone https://github.com/herrwinfried/wsa-script.git ; cd wsa-script; cd scripts; cd bash; chmod +x /*.sh "
}

elseif ( $wsldistro -eq "openSUSE-Tumbleweed") {
    $wslprep = "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python39 python39-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.1.0/setup.sh -O setup.sh && sudo chmod +x ./setup.sh"

}
elseif ( $wsldistro -eq "Debian") {
    $wslprep = "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.9 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.1.0/setup.sh -O setup.sh && sudo chmod +x ./setup.sh"
}
else {
    $wslprep = "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.9 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.1.0/setup.sh -O setup.sh && sudo chmod +x ./setup.sh"
}
if ($arch -eq "arm64") {
$wslsetup = $wslsetup + "--arm ";
}
$wslsetup = $wslsetup + "--lang="+$scriptlang+" ";
$wslsetup = $wslsetup + "--"+$method+" ";
$wslsetup = $wslsetup + "--wsarelease="+$wsarelease+" ";
$wslsetup = $wslsetup + "--magiskversion="+$magiskversion+" ";
$wslsetup = $wslsetup + "--amazonstore="+$amazonstore+" ";
$wslsetup = $wslsetup + "--wsatools="+$wsatools+" ";
$wslsetup = $wslsetup + "--productname="+$productname+" ";
$wslsetup = $wslsetup + "--variant="+$gappsvariant+" ";

Write-Host "WSL will pass, please be careful. If you are asked for a password, please enter your password correctly. If you enter it incorrectly, a mishap may occur." -ForegroundColor Green
Start-Sleep -Seconds 60
# wsl -d $wsldistro -u root -e $wslprep1 $wslprep $wslsetup $wslprep2

write-host "-d $wsldistro -u root -e $wslprep1 $wslprep $wslsetup $wslprep2"

exit 1
####Finish


### FFF
if ( ((Get-Host).Version).Major -ne "5" ) 
{ 
    Import-Module -Name Appx -UseWIndowsPowershell
}
if ($method -ne "onlywsa") {
    if ($method -eq "wsagascript") {
        if ($arch -eq "amd64") {
            Set-Location C:\wsa\x64
        }
        if ($method -eq "arm64") {
            Set-Location C:\wsa\ARM64
        }
        ./install.ps1 0 0

        Start-Sleep -s 10

        if ($windevmode) {
            Write-host "[Finish.Prep] Windows developer mode and WSA Developer mode are activated."
            reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"
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

    } else {
        Set-Location C:\wsa\wsamagisk
        ./guiinstall.ps1
    }

if ($method -eq "onlywsa") {
    Set-Location "C:\wsaproject"
    Add-AppxPackage Microsoft*WindowsSubsystemForAndroid*.msixbundle
}

Start-Sleep -s 0.80
if ($wsatools -eq "yes") {
    Set-Location "C:\wsaproject"
    add-appxpackage .\WSATools.Msixbundle
}

}




