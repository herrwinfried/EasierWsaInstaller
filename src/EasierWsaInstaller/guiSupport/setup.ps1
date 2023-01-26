param (

    [ValidateSet('tr-tr', 'en-us')]
    [string]$scriptLanguage = 'en-us',

    [string]$distro = 'Ubuntu',

    [ValidateSet('amd64','arm64')]
    [string]$arch = 'amd64',

    [ValidateSet('magiskonwsalocal', 'wsagascript', 'onlywsa')]
    [string]$method = 'magiskonwsalocal',

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
Write-Host "gappsvariant " -ForegroundColor Green -NoNewline; Write-Host $gappsvariant -ForegroundColor Red
Write-Host "winvmp " -ForegroundColor Green -NoNewline; Write-Host $winvmp -ForegroundColor Red
Start-Sleep -s 4
write-Host ""
Write-Host "windevmode " -ForegroundColor Green -NoNewline; Write-Host $windevmode -ForegroundColor Red
Write-Host "autosetup " -ForegroundColor Green -NoNewline; Write-Host $autosetup -ForegroundColor Red
Write-Host "adb " -ForegroundColor Green -NoNewline; Write-Host $adb -ForegroundColor Red
Write-Host "wsatools " -ForegroundColor Green -NoNewline; Write-Host $wsatools -ForegroundColor Red
Write-Host "productname " -ForegroundColor Green -NoNewline; Write-Host $productname -ForegroundColor Red
Write-Host "amazonstore " -ForegroundColor Green -NoNewline; Write-Host $amazonstore -ForegroundColor Red
Start-Sleep -s 4
write-Host ""
Write-Host "wsarelease " -ForegroundColor Green -NoNewline; Write-Host $wsarelease -ForegroundColor Red
Write-Host "magiskversion " -ForegroundColor Green -NoNewline; Write-Host $magiskversion -ForegroundColor Red
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
return "sudo apt update && sudo apt upgrade -y; sudo apt install -y git curl wget; "
}
elseif ( $distro -eq "openSUSE-Tumbleweed") {
return "sudo zypper dup -l -y; sudo zypper install -l -y git curl wget; "
}
elseif ( $distro -eq "Debian") {
return "sudo apt update && sudo apt upgrade -y; sudo apt install -y git curl wget; "    
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
$preCommand = $preCommand + "wget https://github.com/herrwinfried/EasierWsaInstaller/archive/refs/heads/alpha.zip -O easierwsainstaller.zip; " 
$preCommand = $preCommand + "unzip easierwsainstaller.zip -d /root/easierwsainstaller; "
$preCommand = $preCommand + "cd /root/easierwsainstaller; mv /root/easierwsainstaller/EasierWsaInstaller*/* /root/easierwsainstaller; "
$preCommand = $preCommand + "cd scripts; cd bash; chmod +x ./*.sh "

if ( ((Get-Host).Version).Major -ne "5" ) 
{ 
    Import-Module -Name Appx -UseWindowsPowershell
}


## //TODO https://github.com/LSPosed/MagiskOnWSALocal/blob/main/scripts/build.sh ARCH parametresini değiştir
