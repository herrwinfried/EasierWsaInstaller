param (
    [string]$wsldistro = 'Ubuntu',

    [ValidateSet('amd64','arm64')]
    [string]$arch = 'amd64',

    [ValidateSet('tr-tr','de-de', 'en-us')]
    [string]$scriptlang = 'en-us',

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
        [string]$winvmp = 'yes',

        [ValidateSet('yes','no')]
        [string]$windevmode = 'yes',

        [ValidateSet('yes','no')]
        [string]$adb = 'no'
)
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-ExecutionPolicy Bypass `"$PSCommandPath`" -wsldistro $wsldistro -arch $arch -scriptlang $scriptlang -method $method -wsarelease $wsarelease -magiskversion $magiskversion -amazonstore $amazonstore -wsatools $wsatools -productname $productname -gappsvariant $gappsvariant -winvmp $winvmp -windevmode $windevmode -adb $adb" -Verb RunAs; exit }
$WindowsArch = ($env:PROCESSOR_ARCHITECTURE)
if (!$WindowsArch) {
    Write-Host "Only Windows Powershell Core." -ForegroundColor Red;
    Start-Sleep -s 0.60
    Exit 1
}
 elseif ($WindowsArch -eq 'x86' -or $WindowsArch -eq 'Arm32') {
    write-Host "Sorry I dont support $WindowsArch"
    Start-Sleep -s 0.60
    Exit 1
}


Write-Host "This script is for the wsa-gui project." -ForegroundColor Yellow;
Start-Sleep -s 0.70
write-host "== Script ==" -ForegroundColor Cyan;
write-host $wsldistro $arch $scriptlang $method $wsarelease $magiskversion $amazonstore $wsatools $productname $gappsvariant
write-host "== Windows ==" -ForegroundColor Green; Write-Host $winvmp $windevmode $adb

####################################################################################################################################

if ($winvmc) {
    Write-host "[PREP] I Activate Virtual Machine Platform."
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
}

if ($adb) {
    Write-host "[PREP] ADB."
    $Folder = 'C:\src\platform-tools'
if (Test-Path -Path $Folder) {
   Write-Host "[PREP] I found folder named platform-tools and deleted it.[ADB]"
    Remove-Item C:\src\platform-tools -Recurse
} else {
}

Write-Host "[PREP] I'm downloading platform-tools r33.0.3-windows. [ADB]"
Invoke-WebRequest https://dl.google.com/android/repository/platform-tools_r33.0.3-windows.zip -OutFile c:\src\platform-tools_r33.0.3-windows.zip
Write-Host "[PREP] I unzip platform-tools r33.0.3-windows[ADB]"
Expand-Archive c:\src\platform-tools_r33.0.3-windows.zip -DestinationPath c:\src\platform-tools_r33.0.3-windows
Write-Host "[PREP] I find and extract the main folder[ADB]"
Move-Item -Path  c:\src\platform-tools_r33.0.3-windows\platform-tools -Destination c:\src\platform-tools

Write-Host "[PREP] I delete unnecessary files and folders.[ADB]"
Remove-Item  c:\src\platform-tools_r33.0.3-windows.zip -Recurse
Remove-Item  c:\src\platform-tools_r33.0.3-windows -Recurse

$pathContent = [Environment]::GetEnvironmentVariable('Path', 'Machine')
$myPath = 'c:\src\platform-tools'
if ($pathContent -ne $null)
{
  # "Exist in the system!"
  if ($pathContent -split ';'  -contains  $myPath)
  {
    # My path Exists
    Write-Host "[PREP] I don't touch it because the path I will add is already there[ADB]"
  }
  else
  {
    Write-Host "[PREP] I add PATH as system. (It is added in the type that every user can use.)[ADB]"
    $path = [Environment]::GetEnvironmentVariable('Path', 'Machine')
    $newpath = $path + ';c:\src\platform-tools'
    [Environment]::SetEnvironmentVariable("Path", $newpath, 'Machine')
    Write-Host "[PREP] You may need to close all open CMD, Powershell, Terminal to use it. If it does not appear, restart your computer.[ADB]"
  }
}
}

$wslprep
$wslprep1 = 'sudo sh -c "'
$wslprep2 = '"'
$wslsetup = "&& ./install.sh "

if ( $wsldistro -eq "Ubuntu") {
    $wslprep = "cd ~; sudo rm -rf /root/wsa*; sudo apt update && sudo apt upgrade -y; sudo apt install -y git curl wget; cd /root/; git clone -b beta https://github.com/herrwinfried/wsa-script.git ; cd wsa-script; cd scripts; cd bash; chmod +x ./*.sh "
}

elseif ( $wsldistro -eq "openSUSE-Tumbleweed") {
    $wslprep = "cd ~; sudo rm -rf /root/wsa*; sudo zypper dup -y; sudo zypper install -y git curl wget; cd /root/; git clone -b beta https://github.com/herrwinfried/wsa-script.git ; cd wsa-script; cd scripts; cd bash; chmod +x ./*.sh "

}
elseif ( $wsldistro -eq "Debian") {
    $wslprep = "cd ~; sudo rm -rf /root/wsa*; sudo apt update && sudo apt upgrade -y; sudo apt install -y git curl wget; cd /root/; git clone -b beta https://github.com/herrwinfried/wsa-script.git ; cd wsa-script; cd scripts; cd bash; chmod +x ./*.sh "
}
else {
    $wslprep = "cd ~; sudo rm -rf /root/wsa*; cd /root/; git clone -b beta https://github.com/herrwinfried/wsa-script.git ; cd wsa-script; cd scripts; cd bash; chmod +x ./*.sh "
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
Start-Sleep -Seconds 5
Clear-Host
Clear-Host
write-host "-d $wsldistro -u root -e $wslprep1 $wslprep $wslsetup $wslprep2"
Start-Sleep -Seconds 6
Clear-Host
Clear-Host
$runwsl = "wsl -d $wsldistro -u root -e $wslprep1$wslprep$wslsetup$wslprep2"
Invoke-Expression $runwsl || Write-Host "WSL failed to start." -ForegroundColor Red

####Finish
Clear-Host
Clear-Host
Start-Sleep -Seconds 7
Clear-Host
Clear-Host

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
        Invoke-Expression 'cmd /c start powershell.exe -ExecutionPolicy Bypass -File .\install.ps1 1 0'

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
        Start-Sleep -s 1
        Set-Location C:\wsa\wsamagisk
        Start-Sleep -s 1
        Invoke-Expression 'cmd /c start powershell.exe -ExecutionPolicy Bypass -File .\guiinstall.ps1'
        
    }

if ($method -eq "onlywsa") {
    Start-Sleep -s 1
    Set-Location "C:\wsaproject"
    Start-Sleep -s 1
    Add-AppxPackage Microsoft*WindowsSubsystemForAndroid*.msixbundle
}

Start-Sleep -s 0.80
if ($wsatools -eq "yes") {
    Start-Sleep -s 1
    Set-Location "C:\wsaproject"
    Start-Sleep -s 1
    add-appxpackage .\WSATools.Msixbundle
}

}




