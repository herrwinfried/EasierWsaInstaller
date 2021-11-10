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
if ! [ -x "$(command -v python3)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (python3) $white"
sudo apt install -y python3.8 python3-pip
else 
echo "$red I couldn't find the python3 package. That's why I canceled the transaction. $white"
exit 1
fi
fi
if ! [ -x "$(command -v pip3)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (python3-pip) $white"
sudo apt install -y python3.8 python3-pip
else 
echo "$red I couldn't find the python3-pip package. That's why I canceled the transaction. $white"
exit 1
fi
fi

gappsarch=x86_64
msarch=x64
mskernel=x86_64


mkdir /mnt/c/wsaproject
if [[ $1 == "--wsatools" ]] || [[ $2 == "--wsatools" ]] || [[ $3 == "--wsatools"]] || [[ $4 == "--wsatools" ]]; then
if [[ -x "$(command -v python3)" ]]; then
if [[ -x "$(command -v pip3)" ]]; then
pip3 install BeautifulSoup4
pip3 install wget
pip3 install lxml
#pip3
fi
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/python/wsatools.py -O wsatools.py
chmod +x ./wsatools.py && python3 ./wsatools.py

mv 54406Simizfo.WSATools*.Msixbundle /mnt/c/wsaproject/WSATools.Msixbundle

sudo rm -rf wsatools.py

#py3
fi
###-yes-py
fi

if [[ $1 == "--wsa" ]] || [[ $2 == "--wsa" ]] || [[ $3 == "--wsa"]] || [[ $4 == "--wsa" ]]; then
if [[ -x "$(command -v python3)" ]]; then
if [[ -x "$(command -v pip3)" ]]; then
pip3 install BeautifulSoup4
pip3 install wget
pip3 install lxml
#pip3
fi
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/python/wsa.py -O wsa.py
chmod +x ./wsa.py && python3 ./wsa.py
rm -rf /mnt/c/wsaproject/Microsoft*WindowsSubsystemForAndroid*.Msixbundle
mv Microsoft*WindowsSubsystemForAndroid*.Msixbundle /mnt/c/wsaproject/

sudo rm -rf wsa.py

#py3
fi
###-yes-py
fi

if [[ $1 == "--gapps" ]] || [[ $2 == "--gapps" ]] || [[ $3 == "--gapps" ]] || [[ $4 == "--gapps" ]]; then
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/python/opengapps.py -O opengapps.py

rm -rf /mnt/c/wsaproject/open_gapps-$gappsarch-*.zip

chmod +x ./opengapps.py && python3 ./opengapps.py

mv open_gapps-$gappsarch-*.zip /mnt/c/wsaproject/

sudo rm -rf opengapps.py
fi

########
cd /mnt/c/wsaproject && pwd
git clone https://github.com/herrwinfried/WSAGAScript
if [[ $1 == "--all-okey" ]] || [[ $2 == "--all-okey" ]] || [[ $3 == "--all-okey" ]] || [[ $4 == "--all-okey" ]]; then
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/powershell/powershell1.ps1 -O powershell.ps1
else
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/powershell/powershell.ps1 -O powershell.ps1
fi

echo " $green Have you placed the WSA and OpenGapps Files in the $red 'C:\wsaproject' $green directory ? $blue (Press enter to continue.) $white "
##
if [[ $1 == "--all-okey" ]] || [[ $2 == "--all-okey" ]] || [[ $3 == "--all-okey" ]] || [[ $4 == "--all-okey" ]] || [[ $1 == "--okey" ]] || [[ $2 == "--okey" ]] || [[ $3 == "--okey" ]] || [[ $4 == "--okey" ]]; then
echo "Okey"
else
read tr
fi
##
pwd

mv open_gapps-$gappsarch-11.0*.zip WSAGAScript/#GAPPS/

unzip -o Microsoft*WindowsSubsystemForAndroid*.Msixbundle -d microsoftwsa && cd microsoftwsa 
unzip -o "WsaPackage_*_$msarch_*.msix" -d wsa
find . -maxdepth 1 ! -name WsaPackage_*_\$msarch_*.msix ! -name "wsa" ! -name . -exec rm -r {} \;

cd wsa
rm -rf '[Content_Types].xml' AppxBlockMap.xml AppxSignature.p7x AppxMetadata

mv *.img ../../WSAGAScript/#IMAGES/

cd ../..
cd WSAGAScript 

sed -ie 's+Root="$(pwd)"+Root="/mnt/c/wsaproject/WSAGAScript"+i' VARIABLES.sh

sudo ./extract_gapps_pico.sh && sudo ./extend_and_mount_images.sh && sudo ./apply.sh && sudo ./unmount_images.sh

mv \#IMAGES/*img ../microsoftwsa/wsa/

sudo rm ../microsoftwsa/wsa/Tools/kernel && cp misc/kernel-$mskernel ../microsoftwsa/wsa/Tools/kernel

sudo rm -rf /mnt/c/wsa/$msarch
sudo mkdir /mnt/c/wsa/$msarch

sudo mv /mnt/c/wsaproject/microsoftwsa/wsa/* /mnt/c/wsa/$msarch/
echo "$yellow If all operations are successful, you can run the powershell.ps1 script in $yellow 'C:\wsaproject'$yellow. $white"

sudo rm -rf setup.sh