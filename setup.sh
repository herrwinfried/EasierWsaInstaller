#!/bin/bash
### Fonts
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
### Finish
if [[ $EUID -ne 0 ]]; then
   echo "$red You have to start it as SuperUser $white" 
   exit 1
fi
if ! [ -x "$(command -v unzip)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (unzip) $white"
sudo apt install -y unzip lzip
else 
echo "$red I couldn't find the unzip package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v lzip)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (unzip) $white"
sudo apt install -y unzip lzip
else 
echo "$red I couldn't find the lzip package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v git)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (git) $white"
sudo apt install -y git wget
else 
echo "$red I couldn't find the git package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v wget)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (wget) $white"
sudo apt install -y git wget
else 
echo "$red I couldn't find the wget package. That's why I canceled the transaction. $white"
exit 1
fi
fi

mkdir /mnt/c/wsaproject
cd /mnt/c/wsaproject && pwd

git clone https://github.com/ADeltaX/WSAGAScript
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/main/powershell.ps1 -O powershell.ps1

echo " $green Have you placed the WSA and OpenGapps Files in the $red 'C:\wsaproject' $green directory ? $blue (Press enter to continue.) $white "
read tr
pwd
mv open_gapps-x86_64-11.0*.zip WSAGAScript/#GAPPS/

unzip -o Microsoft*WindowsSubsystemForAndroid*.Msixbundle -d microsoftwsa && cd microsoftwsa

unzip -o WsaPackage_*_x64_*.msix -d wsa && cd wsa

rm -rf '[Content_Types].xml' AppxBlockMap.xml AppxSignature.p7x AppxMetadata

mv *.img ../../WSAGAScript/#IMAGES/

cd ../..
cd WSAGAScript 

sed -ie 's+Root="$(pwd)"+Root="/mnt/c/wsaproject/WSAGAScript"+i' VARIABLES.sh

sudo ./extract_gapps_pico.sh && sudo ./extend_and_mount_images.sh && sudo ./apply.sh && sudo ./unmount_images.sh

mv \#IMAGES/*img ../microsoftwsa/wsa/

rm ../microsoftwsa/wsa/Tools/kernel && cp misc/kernel ../microsoftwsa/wsa/Tools/

echo "$yellow If all operations are successful, you can run the powershell.ps1 script in $yellow 'C:\wsaproject'$yellow. $white"
