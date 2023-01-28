#!/bin/bash
SCRIPTVERSION="v1.0.0"

ScriptLocal=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function installer_color {
termcols=$(tput cols)
bold="$(tput bold)"
fontnormal="$(tput init)"
fontreset="$(tput reset)"
underline="$(tput smul)"
standout="$(tput smso)"
normal="$(tput sgr0)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"
}
installer_color

function wslcheck(){
unameout=$(uname -r | tr '[:upper:]' '[:lower:]');
if [ "$(echo $(cat /proc/cpuinfo | grep -m1 microcode | cut -f2 -d:))" != "0xffffffff" ]; then
echo $"$yellow I guess you are not using WSL Distro.$red The transaction has been cancelled." $white
exit 1
fi
}
function checkroot {
if [[ $EUID -ne 0 ]]; then
     echo $"$red You need to be Super User/Root. $white"
   exit 1
fi
}

function sleepwait () {
sleep $1
}

function scriptregex() {
echo $1 | tr -cd "[a-z]\n"
}
function equalcommand() {
  echo $1 | cut -f2 -d"="
}

#----------------GAPPS----------------------------
HOST_WSL_ARCH=$(uname -m)
gappsarch=x86_64
gappsvariant=pico
msarch=x64
mskernel=x86_64
gappsSelect="MindTheGapps"
#---------------METHOD-----------------------
OnlyWSA=false;
WSAGAScript=false;
MagiskWSA=true;
#####################################################
WSATools=false;
#--------------CUSTOMIZER--------------
WSAProductName=redfin
WSAAmazonRemove=false;
WSARelease=retail
MagiskVersion=stable
Language=en_US

NotWSL=false;
#####################################################
<<com
function GetMessage() {

for LANGOUTPUT in $(ls $ScriptLocal/lang)
do
unset ./$LANGOUTPUT
done

if [[ $Language == "en_US" ]];
  then
. ./$ScriptLocal/lang/en-US.sh
elif [[ $Language == "tr_TR" ]];
  then
. ./$ScriptLocal/lang/tr-TR.sh
else
. ./$ScriptLocal/lang/en-US.sh
  fi
}

function function_regex_folder() {
 echo ${info_Folder/\$x/$1}
}
function function_regex_getfolder() {
 echo ${info_get_Folder/\$x/$1}
}

function function_regex_getfolder1() {
 echo ${info_get_Folder1/\$x/$1}
}
com

function requirePackages() {
DownloadPackage=""

if [[ $MagiskWSA == true ]]; then
if ! [ -x "$(command -v lsb_release)" ]; then
echo $"$green I found a missing package, I'm installing it... (lsb_release) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage lsb-release"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage lsb-release"
fi
fi
distroselect=$(lsb_release -d | awk -F"\t" '{print $2}')
distrocodename=$(lsb_release -c | awk -F"\t" '{print $2}')

if ! [ -x "$(command -v xz)" ]; then
echo $"$green I found a missing package, I'm installing it... (xz-utils) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage xz-utils"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage xz"
fi
fi
#
if ! [ -x "$(command -v lzip)" ]; then
echo $"$green I found a missing package, I'm installing it... (lzip) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage lzip"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage lzip"
fi
fi
#
if ! [ -x "$(command -v seinfo)" ]; then
echo $"$green I found a missing package, I'm installing it... (setools) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage setools"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage setools-console"
fi
fi
#
if ! [ -x "$(command -v whiptail)" ]; then
echo $"$green I found a missing package, I'm installing it... (whiptail) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage whiptail"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage newt"
fi
fi
#
if ! [ -x "$(command -v wine64)" ]; then
echo $"$green I found a missing package, I'm installing it... (wine) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage wine"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage wine"
fi
fi
#
if ! [ -x "$(command -v winetricks)" ]; then
echo $"$green I found a missing package, I'm installing it... (winetricks) $white"
if [ -x "$(command -v apt)" ]; then
sudo apt-add-repository contrib
sudo apt update
DownloadPackage=" $DownloadPackage winetricks"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage winetricks"
fi
fi
#
if ! [ -x "$(command -v patchelf)" ]; then
echo $"$green I found a missing package, I'm installing it... (patchelf) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage patchelf"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage patchelf"
fi
fi
#
if ! [ -x "$(command -v e2fsck)" ]; then
echo $"$green I found a missing package, I'm installing it... (e2fsprogs) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage e2fsprogs"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage e2fsprogs"
fi
fi
#
if ! [ -x "$(command -v aria2c)" ]; then
echo $"$green I found a missing package, I'm installing it... (aria2) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage aria2"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage aria2"
fi
fi
#
if ! [ -x "$(command -v 7z)" ]; then
echo $"$green I found a missing package, I'm installing it... (p7zip-full) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage p7zip-full"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage 7zip"
fi
fi
#
if ! [ -x "$(command -v pip)" ]; then
echo $"$green I found a missing package, I'm installing it... (python3-pip) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage python3-pip"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage python310 python310-pip"
fi
fi
#
if ! [ -x "$(command -v git)" ]; then
echo $"$green I found a missing package, I'm installing it... (git) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage git"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage git"
fi
fi
#
if ! [ -x "$(command -v wget)" ]; then
echo $"$green I found a missing package, I'm installing it... (wget) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage wget"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage wget"
fi
fi
#
if ! [ -x "$(command -v setfattr)" ]; then
echo $"$green I found a missing package, I'm installing it... (attr) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage attr"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage attr"
fi
fi
#
sleepwait 1
if [ ! -z "$DownloadPackage" ]; then
if [ -x "$(command -v apt)" ]; then
sudo apt update && sudo apt install -y $DownloadPackage
elif [ -x "$(command -v zypper)" ]; then
sudo zypper refresh && sudo zypper install -y -l $DownloadPackage
else
scriptabort
fi
fi
sleepwait 1
### other method
  else
if ! [ -x "$(command -v unzip)" ]; then
echo $"$green I found a missing package, I'm installing it... (unzip) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage unzip"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage unzip"
fi
fi
#
if ! [ -x "$(command -v lzip)" ]; then
echo $"$green I found a missing package, I'm installing it... (lzip) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage lzip"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage lzip"
fi
fi
#
if ! [ -x "$(command -v e2fsck)" ]; then
echo $"$green I found a missing package, I'm installing it... (e2fsprogs) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage e2fsprogs"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage e2fsprogs"
fi
fi
#
if ! [ -x "$(command -v git)" ]; then
echo $"$green I found a missing package, I'm installing it... (git) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage git"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage git"
fi
fi
#
if ! [ -x "$(command -v wget)" ]; then
echo $"$green I found a missing package, I'm installing it... (wget) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage wget"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage wget"
fi
fi
#
if ! [ -x "$(command -v pip)" ]; then
echo $"$green I found a missing package, I'm installing it... (python3-pip) $white"
if [ -x "$(command -v apt)" ]; then
DownloadPackage=" $DownloadPackage python3-pip"
elif [ -x "$(command -v zypper)" ]; then
DownloadPackage=" $DownloadPackage python310 python310-pip"
fi
fi
#
sleepwait 1
if [ ! -z "$DownloadPackage" ]; then
if [ -x "$(command -v apt)" ]; then
sudo apt update && sudo apt install -y $DownloadPackage
elif [ -x "$(command -v zypper)" ]; then
sudo zypper refresh && sudo zypper install -y -l $DownloadPackage
else
scriptabort
fi
fi
sleepwait 1
## Other method end
  fi
}