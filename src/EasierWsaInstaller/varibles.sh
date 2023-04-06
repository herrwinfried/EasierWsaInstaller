#!/bin/bash
SCRIPTVERSION="v1.0.2"

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
echo "$yellow I guess you are not using WSL Distro.$red The transaction has been cancelled." $white
exit 1
fi
}
function checkroot {
if [[ $EUID -ne 0 ]]; then
     echo "$red You need to be Super User/Root. $white"
   exit 1
fi
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

NotWSL=false;
#####################################################


function Information_script {
echo "$green"HOST_WSL_ARCH: "$red"$HOST_WSL_ARCH
if [[ $MagiskWSA == true ]]; then
echo "$green"gappsSelect: "$red""$gappsSelect"
fi
if [[ $MagiskWSA == true ]] || [[ $WSAGAScript == true ]]; then
echo "$green"gappsarch: "$red""$gappsarch"
echo "$green"gappsvariant: "$red""$gappsvariant"
fi
echo "$green"msarch: "$red""$msarch"
echo "$green"mskernel: "$red""$mskernel"
echo "$green"OnlyWSA: "$red""$onlywsa"
echo "$green"WSAGAScript: "$red""$WSAGAScript"
echo "$green"MagiskWSA: "$red""$MagiskWSA"
echo "$green"WSATools: "$red""$WSATools"
if [[ $MagiskWSA == true ]] || [[ $WSAGAScript == true ]]; then
echo "$green"WSAProductName: "$red""$WSAProductName"
echo "$green"WSAAmazonRemove: "$red""$WSAAmazonRemove"
fi
echo "$green"WSARelease: "$red""$WSARelease"
if [[ $MagiskWSA == true ]]; then
echo "$green"MagiskVersion: "$red""$MagiskVersion"
fi
echo "$green"NotWSL: "$cyan""$NotWSL $white"
############
sleep 5
echo "$red""Version: "$magenta"""$SCRIPTVERSION""$white"
sleep 1
############
}

function LogFile_Create()
{
mkdir -p ~/EasierWsaInstallerLog
File="$(date +%Y_%m_%d-%H_%M_%S)_$1"
touch ~/EasierWsaInstallerLog/$File
GetFile=~/EasierWsaInstallerLog/$File
echo "FOLDER: $( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
" >> $GetFile
timedatectl >> $GetFile
echo "" >> $GetFile    
}

function LogFile_input() 
{
echo "$(date +%H:%M:%S): [START] $1" >> $GetFile
}
function LogFile_input_start() 
{
echo "$(date +%H:%M:%S): [START] $1" >> $GetFile
}
function LogFile_input_finish() 
{
echo "$(date +%H:%M:%S): [FINISH] $1" >> $GetFile
}

function LogFile_input_if_start() 
{
echo "$(date +%H:%M:%S): [IF] [START] $1" >> $GetFile
}
function LogFile_input_if_finish() 
{
echo "$(date +%H:%M:%S): [IF] [FINISH] $1" >> $GetFile
}