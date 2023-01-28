param (

    [ValidateSet('tr-tr', 'en-us')]
    [string]$scriptLanguage = 'en-us',

    [string]$distro = 'Ubuntu',

    [ValidateSet('amd64','arm64')]
    [string]$arch = 'amd64',

    [ValidateSet('magiskonwsalocal', 'wsagascript', 'onlywsa')]
    [string]$method = 'magiskonwsalocal',

    [ValidateSet('mindthegapps', 'opengapps')]
    [string]$gapps = 'mindthegapps',

    [ValidateSet('super','stock', 'full', 'mini','micro','nano', 'pico')]
    [string]$gappsvariant = 'pico',

    [ValidateSet('yes','no')]
    [string]$winvmp = 'yes',

    [ValidateSet('yes','no')]
    [string]$windevmode = 'yes',

    [ValidateSet('yes','no')]
    [string]$autosetup = 'yes',

    [ValidateSet('yes','no')]
    [string]$adb = 'no',

    [ValidateSet('yes','no')]
    [string]$wsatools = 'yes',

    [string]$productname = 'redfin',

    [ValidateSet('yes','no')]
    [string]$amazonstore = 'no',

    [ValidateSet('fast','slow', 'rp', 'retail')]
    [string]$wsarelease = 'retail',

    [ValidateSet('stable','beta', 'canary', 'debug')]
    [string]$magiskversion = 'stable'
)
#Requires -Version 7.0

$Host.UI.RawUI.WindowTitle = "EasierWsaInstaller Script for GUI"

# Powershell help for Project EasierWsaInstallerGui. 
#Normally the Project only covers Bash(script). 
#But there is a GUI project because not everyone can use the CLI. 
#It would be silly to write bash directly in bash in this GUI project. 
#Because windows works better in Powershell.

if (-Not $isWindows) {
Write-Host "I don't support the operating system..." -ForegroundColor red
Start-Sleep -s 0.30
Exit 1
} else {
    if (-not ([System.Environment]::OSVersion.Version.Build -ge 22000)) {
        Write-Host "I don't support the Build..." -ForegroundColor red
        Start-Sleep -s 0.30
        Exit 1
    }
}

$Scriptparameters = "-scriptLanguage $scriptLanguage -distro $distro -arch $arch "
$Scriptparameters = $Scriptparameters + "-method $method -gappsvariant $gappsvariant "
$Scriptparameters = $Scriptparameters + "-winvmp $winvmp -windevmode $windevmode "
$Scriptparameters = $Scriptparameters + "-autosetup $autosetup -adb $adb -wsatools $wsatools "
$Scriptparameters = $Scriptparameters + "-productname $productname -amazonstore $amazonstore -wsarelease $wsarelease "
$Scriptparameters = $Scriptparameters + "-magiskversion $magiskversion "

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process pwsh.exe "-ExecutionPolicy Bypass `"$PSCommandPath`" $Scriptparameters" -Verb RunAs; exit }


$ScriptArch = ($env:PROCESSOR_ARCHITECTURE)

if (!$ScriptArch) {
    Write-Host "Only Windows" -ForegroundColor Red;
    Start-Sleep -s 0.30
    Exit 1
}

elseif ($ScriptArch -eq 'x86' -or $ScriptArch -eq 'Arm32') {
    write-Host "Sorry I dont support $ScriptArch" -ForegroundColor Red;
    Start-Sleep -s 0.50
    Exit 1
}

#############################################################################################################################
Write-Host "This script is for the EasierWsaInstallerGui project." -Background DarkBlue -ForegroundColor White;
Start-Sleep -s 0.70
write-host "== Arguments ==" -ForegroundColor Cyan;
Write-Host $Scriptparameters -ForegroundColor White;
Start-Sleep -s 1.50
Write-Host "scriptLanguage(UNSUPPORT) " -ForegroundColor Green -NoNewline; Write-Host $scriptLanguage -ForegroundColor Red
Write-Host "distro " -ForegroundColor Green -NoNewline; Write-Host $distro -ForegroundColor Red
Write-Host "arch " -ForegroundColor Green -NoNewline; Write-Host $arch -ForegroundColor Red
Write-Host "method " -ForegroundColor Green -NoNewline; Write-Host $method -ForegroundColor Red
if ($method -eq "magiskonwsalocal") {
    Write-Host "gapps " -ForegroundColor Green -NoNewline; Write-Host $gapps -ForegroundColor Red
}
if ($method -ne "onlywsa") {
Write-Host "gappsvariant " -ForegroundColor Green -NoNewline; Write-Host $gappsvariant -ForegroundColor Red
}
Write-Host "winvmp " -ForegroundColor Green -NoNewline; Write-Host $winvmp -ForegroundColor Red
Start-Sleep -s 4
write-Host ""
Write-Host "windevmode " -ForegroundColor Green -NoNewline; Write-Host $windevmode -ForegroundColor Red
Write-Host "autosetup " -ForegroundColor Green -NoNewline; Write-Host $autosetup -ForegroundColor Red
Write-Host "adb " -ForegroundColor Green -NoNewline; Write-Host $adb -ForegroundColor Red
Write-Host "wsatools " -ForegroundColor Green -NoNewline; Write-Host $wsatools -ForegroundColor Red
if ($method -ne "onlywsa") {
Write-Host "productname " -ForegroundColor Green -NoNewline; Write-Host $productname -ForegroundColor Red
Write-Host "amazonstore " -ForegroundColor Green -NoNewline; Write-Host $amazonstore -ForegroundColor Red

Start-Sleep -s 4
write-Host ""
}
Write-Host "wsarelease " -ForegroundColor Green -NoNewline; Write-Host $wsarelease -ForegroundColor Red

if ($method -eq "magiskonwsalocal") {
Write-Host "magiskversion " -ForegroundColor Green -NoNewline; Write-Host $magiskversion -ForegroundColor Red
}
Start-Sleep -s 5
#############################################################################################################################

if (Test-Path -Path 'C:\easierwsainstaller-project') {
    Write-Host "I found folder named easierwsainstaller-project." -ForegroundColor Red
 } else {
    Write-Host "A folder will be created in the C directory named easierwsainstaller-project" -ForegroundColor Green
    New-Item "C:\easierwsainstaller-project" -ItemType Directory
    
 }

 if (Test-Path -Path 'C:\wsa') {
    Write-Host "I found folder named wsa." -ForegroundColor Red
 } else {
    Write-Host "A folder will be created in the C directory named wsa" -ForegroundColor Green
    New-Item "C:\wsa" -ItemType Directory
 }

 if ($winvmp -eq "yes") {
Write-host "I Activate Virtual Machine Platform." -ForegroundColor yellow
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
}

if ($adb -eq "yes") { 

$Folder = 'C:\src\platform-tools'
# Folder Check
if (Test-Path -Path $Folder) {
    Write-Host "[ADB]" -ForegroundColor Cyan -NoNewline
    Write-Host "I found folder named platform-tools and deleted it." -ForegroundColor Red

    Remove-Item C:\src\platform-tools -Recurse
}
#Download
Write-Host "[ADB]" -ForegroundColor Cyan -NoNewline 
Write-Host "I'm downloading platform-tools r33.0.3-windows." -ForegroundColor Green
Invoke-WebRequest https://dl.google.com/android/repository/platform-tools_r33.0.3-windows.zip -OutFile c:\src\platform-tools_r33.0.3-windows.zip

# Unzip
Write-Host "[ADB]" -ForegroundColor Cyan -NoNewline
Write-Host "I unzip platform-tools r33.0.3-windows[ADB]" -ForegroundColor Green
Expand-Archive c:\src\platform-tools_r33.0.3-windows.zip -DestinationPath c:\src\platform-tools_r33.0.3-windows

#Move Folder
Write-Host "[ADB]" -ForegroundColor Cyan -NoNewline
Write-Host "I find and extract the main folder" -ForegroundColor Green
Move-Item -Path  c:\src\platform-tools_r33.0.3-windows\platform-tools -Destination c:\src\platform-tools

#Trash Folder Delete
Write-Host "[ADB]" -ForegroundColor Cyan -NoNewline
Write-Host " I delete unnecessary files and folders." -ForegroundColor Green
Remove-Item  c:\src\platform-tools_r33.0.3-windows.zip -Recurse
Remove-Item  c:\src\platform-tools_r33.0.3-windows -Recurse

Start-Sleep -s 2
#------------PATH ADD
$pathContent = [Environment]::GetEnvironmentVariable('Path', 'Machine')
$myPath = 'c:\src\platform-tools'
if ($pathContent -ne $null)
{
  # "Exist in the system!"
  if ($pathContent -split ';'  -contains  $myPath)
  {
    # My path Exists
    Write-Host "[ADB.PATH]" -ForegroundColor Cyan -NoNewline
    Write-Host "I don't touch it because the path I will add is already there" -ForegroundColor Red
  }
  else
  {
    Write-Host "[ADB.PATH]" -ForegroundColor Cyan -NoNewline
    Write-Host "I add PATH as system." -ForegroundColor Green -NoNewline
    Write-Host "(It is added in the type that every user can use.)" -ForegroundColor yellow
    $path = [Environment]::GetEnvironmentVariable('Path', 'Machine')
    $newpath = $path + ';c:\src\platform-tools'
    [Environment]::SetEnvironmentVariable("Path", $newpath, 'Machine')
    Write-Host "[ADB.PATH]" -ForegroundColor Cyan -NoNewline
    Write-Host "You may need to close all open CMD, Powershell, Terminal to use it. If it does not appear, restart your computer." -ForegroundColor Green
    Start-Sleep -s 5
  }
}
}

$bashPrep1 = 'sudo sh -c "'
$preCommand;
$WCommand = "&& ./install.sh "
$bashPrep2 = '"'

function prepackage {
if ($distro -eq "Ubuntu") {
return "sudo apt update && sudo apt upgrade -y; sudo apt install -y git curl wget unzip python3 python3-pip; "
}
elseif ( $distro -eq "openSUSE-Tumbleweed") {
return "sudo zypper dup -l -y; sudo zypper install -l -y git curl wget unzip python310 python310-pip; "
}
elseif ( $distro -eq "Debian") {
return "sudo apt update && sudo apt upgrade -y; sudo apt install -y git curl wget unzip python3 python3-pip; "    
}
else {
    return " echo 'I hope you downloaded the packages.'; "
}
}


if ($scriptLanguage -eq "tr-tr") {
$preCommand = "LANG=tr_TR.UTF-8 LC_ALL=tr_TR.UTF-8 "
}
else {
$preCommand = "LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 "    
}


$preCommand = "cd ~; sudo rm -rf /root/easierwsainstaller; sudo rm -rf /root/easierwsainstaller-project; " 
$preCommand = $preCommand + "$([string](prepackage)) cd /root/; "
$preCommand = $preCommand + "wget https://github.com/herrwinfried/EasierWsaInstaller/archive/refs/heads/main.zip -O easierwsainstaller.zip; " 
$preCommand = $preCommand + "unzip easierwsainstaller.zip -d /root/easierwsainstaller; "
$preCommand = $preCommand + "cd /root/easierwsainstaller; mv /root/easierwsainstaller/EasierWsaInstaller*/* /root/easierwsainstaller; "
$preCommand = $preCommand + "cd src; cd EasierWsaInstaller; chmod +x ./*.sh "

if ( ((Get-Host).Version).Major -ne "5" ) 
{ 
    Import-Module -Name Appx -UseWindowsPowershell
}

    $WCommand = $WCommand + "--lang="+$scriptlang+" ";
    $WCommand = $WCommand + "--arch="+$arch+" ";
    $WCommand = $WCommand + "--method="+$method+" ";
    if ($method -eq "magiskonwsalocal") {
    $WCommand = $WCommand + "--gapps="+$gapps+" ";
    } else {
        $WCommand = $WCommand + "--gapps="+"opengapps"+" ";
    }
    $WCommand = $WCommand + "--variant="+$gappsvariant+" ";
    $WCommand = $WCommand + "--wsatools="+$wsatools+" ";
    $WCommand = $WCommand + "--productname="+$productname+" ";
    $WCommand = $WCommand + "--amazonstore="+$amazonstore+" ";
    $WCommand = $WCommand + "--wsarelease="+$wsarelease+" ";
    $WCommand = $WCommand + "--magiskversion="+$magiskversion+" ";

$runwsl = "wsl -d $distro -u root -e $bashPrep1$preCommand$WCommand$bashPrep2"
Write-Host "WSL will pass, please be careful. If you are asked for a password, please enter your password correctly. If you enter it incorrectly, a mishap may occur." -ForegroundColor Green
Start-Sleep -Seconds 5
Clear-Host
write-host $runwsl
Start-Sleep -Seconds 6
Clear-Host
Clear-Host   
Invoke-Expression $runwsl || Write-Host "WSL failed to start." -ForegroundColor Red
Clear-Host
Clear-Host 
Start-Sleep -Seconds 7
Clear-Host
Clear-Host 

if ($autosetup -eq "yes") {

if ($method -eq "onlywsa") {

    Start-Sleep -s 1
    Set-Location "C:\easierwsainstaller-project"
    Start-Sleep -s 1
    Add-AppxPackage Microsoft*WindowsSubsystemForAndroid*.msixbundle

    }
    elseif ($method -eq "wsagascript") {
        if ($ScriptArch -eq "amd64") {
            Set-Location C:\wsa\x64
        }
        if ($ScriptArch -eq "arm64") {
            Set-Location C:\wsa\ARM64
        }
    Invoke-Expression "Start-Process pwsh.exe -verb runas -ArgumentList '-ExecutionPolicy Bypass -c .\install.ps1 -nostop 1 -original 0'"

    Start-Sleep -s 10
    if ($windevmode) {  

        Write-host "Windows developer mode and WSA Developer mode are activated."
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"
        $wsalocation = "$env:LOCALAPPDATA/Packages/MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe/Settings/settings.dat"
                $mountPoint = "HKLM\WSA"
            reg load $mountPoint $wsalocation
                $develbit = "1"
                $data  = "Windows Registry Editor Version 5.00`n`n"
                $data += "[HKEY_LOCAL_MACHINE\WSA]`n`n"
                $data += "[HKEY_LOCAL_MACHINE\WSA\LocalState]`n"
                $data += "`"DeveloperModeEnabled`"=hex(5f5e10b):0"+ $develbit + ",87,c4,ba,af,65,32,d9,01`n"
                $data += "`"FixedFocusModeEnabled`"=hex(5f5e10b):0"+ $develbit + ",87,c4,ba,af,65,32,d9,01`n"
                $data | Out-File "./wsadevelopermode.reg"
            [gc]::collect()
            reg import "./wsadevelopermode.reg"
            reg unload $mountPoint

    }

    }
    elseif ($method -eq "magiskonwsalocal") {
        Start-Sleep -s 1
        Set-Location C:\wsa\wsamagisk
        Start-Sleep -s 1
        Invoke-Expression 'cmd /c start powershell.exe -ExecutionPolicy Bypass -File .\guiSupport.ps1'
    }
    if ($wsatools -eq "yes") {
    Start-Sleep -s 1
    Set-Location "C:\easierwsainstaller-project"
    Start-Sleep -s 1
    add-appxpackage .\WSATools.Msixbundle
    }
}

    

