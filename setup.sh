#!/bin/bash
tempwsa=yes
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
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (unzip) $white"
sudo zypper install -y unzip lzip
else
echo "$red I couldn't find the unzip package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v lzip)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (lzip) $white"
sudo apt install -y unzip lzip
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (lzip) $white"
sudo zypper install -y unzip lzip
else
echo "$red I couldn't find the lzip package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v e2fsck)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (e2fsck) $white"
sudo apt install -y e2fsprogs
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (e2fsck) $white"
sudo zypper install -y ue2fsprogs
else
echo "$red I couldn't find the e2fsck package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v resize2fs)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (resize2fs) $white"
sudo apt install -y e2fsprogs
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (resize2fs) $white"
sudo zypper install -y ue2fsprogs
else
echo "$red I couldn't find the resize2fs package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v git)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (git) $white"
sudo apt install -y git wget
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (git) $white"
sudo zypper install -y git wget
else
echo "$red I couldn't find the git package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v wget)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (wget) $white"
sudo apt install -y git wget
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (wget) $white"
sudo zypper install -y git wget
else
echo "$red I couldn't find the wget package. That's why I canceled the transaction. $white"
exit 1
fi
fi
if ! [ -x "$(command -v python3)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (python3) $white"
sudo apt install -y python3.8 python3-pip
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (python3) $white"
sudo zypper install -y python38 python38-pip
else
echo "$red I couldn't find the python3 package. That's why I canceled the transaction. $white"
exit 1
fi
fi
if ! [ -x "$(command -v pip3)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (python3-pip) $white"
sudo apt install -y python3.8 python3-pip
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (python3-pip) $white"
sudo zypper install -y python38 python38-pip
else
echo "$red I couldn't find the python3-pip package. That's why I canceled the transaction. $white"
exit 1
fi
fi

gappsarch=x86_64
msarch=x64
mskernel=x86_64
############################
wsadownload=false;         #
opengappsdownload=false;   #
wsatoolsdownload=false;    #
allOkey=false;             #
okey=false;                #
wsaonlydownload=false;     #
############################
i=1;
j=$#;
while [ $i -le $j ]
do
if [[ $1 == "--arm" ]]; then
gappsarch=arm64
msarch=ARM64
mskernel=arm64
echo "$red Still in BETA $white"
 elif [[ $1 == "--wsaonly" ]]; then
wsadownload=false;
opengappsdownload=false;
okey=false;
wsaonlydownload=true;
  elif [[ $1 == "--wsa" ]]; then
wsadownload=true;
  elif [[ $1 == "--opengapps" ]]; then
opengappsdownload=true;
 elif [[ $1 == "--gapps" ]]; then
 opengappsdownload=true;
elif [[ $1 == "--wsatools" ]]; then
wsatoolsdownload=true;
elif [[ $1 == "--all-okey" ]]; then
allOkey=true;
elif [[ $1 == "--okey" ]]; then
okey=true;
    else
    echo "$red Invalid argument-$i: $1 $white";
    fi
    i=$((i + 1));
    shift 1;
done
$pwdsh=pwd
echo $yellow WSADownload: $red $wsadownload $yellow OpenGapps: $red $opengappsdownload $yellow WSATools: $red $wsatoolsdownload $yellow AllOkey: $red $allOkey $yellow Okey: $red $okey
echo $yellow TempWSA: $red $tempwsa $yellow WSAOnly: $red $wsaonlydownload
echo $yellow gappsarch: $red $gappsarch $yellow msarch: $red $msarch $yellow mskernel: $red $mskernel
echo $yellow Location: $red $pwdsh
function wsatools {
    if [ -d /tmp/wsaproject ]; then
cd /tmp && cd wsaproject
else
echo "$yellow Creating folder for project files. on the linux side $white"
cd /tmp && mkdir wsaproject && cd wsaproject
fi
if [[ $gappsarch == "x86_64" ]] && [[ $msarch == "x64" ]] && [[ $mskernel == "x86_64" ]]; then
if [[ -x "$(command -v python3)" ]]; then
if [[ -x "$(command -v pip3)" ]]; then
echo "$yellow Downloading packages "BeautifulSoup4, wget, lxml". Via pip. $white"
pip3 install BeautifulSoup4
pip3 install wget
pip3 install lxml
#pip3
fi
if [ -f "wsatools.py" ]; then
    echo "$red There is wsatools.py. This file will be deleted. $white"
    sudo rm -rf wsatools.py
    else
 echo "$green wsatools.py dont exists. $white"
    fi
if [ -f "/mnt/c/wsaproject/WSATools.Msixbundle" ]; then
    echo "$red There is WSATools. This file will be deleted. $white"
rm -rf /mnt/c/wsaproject/WSATools.Msixbundle
    else
 echo "$green WSATools dont exists. $white"
fi
echo "$green Downloading wsatools.py To download WSATools. $white"

wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/python/wsatools.py -O wsatools.py
echo "$green WSATools Beginning to download. $yellow"

chmod +x ./wsatools.py && python3 ./wsatools.py
echo "$green WSATools has been downloaded. Now the PS file is downloading. $white"

wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/powershell/wsatools1.ps1 -O wsatools.ps1
echo "$green Download completed, moving to required location."

mv wsatools.ps1 /mnt/c/wsaproject/wsatools.ps1
mv 54406Simizfo.WSATools*.Msixbundle /mnt/c/wsaproject/WSATools.Msixbundle

echo "$red Deleting wsatools.py file. $white"
sudo rm -rf wsatools.py
fi
else
echo "$red Developer Sorry, does not support ARM. (WSATools) $white"
fi
}

function wsa {
    if [ -d /tmp/wsaproject ]; then
cd /tmp && cd wsaproject
else
echo "$yellow Creating folder for project files. on the linux side $white"
cd /tmp && mkdir wsaproject && cd wsaproject
fi
if [[ -x "$(command -v python3)" ]]; then
if [[ -x "$(command -v pip3)" ]]; then
echo "$yellow Downloading packages "BeautifulSoup4, wget, lxml". Via pip. $white"
pip3 install BeautifulSoup4
pip3 install wget
pip3 install lxml
#pip3
fi
if [[ $tempwsa == "yes" ]]; then
echo "$yellow This script is set as temporary WSA. So probably because there is a problem with a current WSA, the old version will be downloaded. $white"
else
if [ -f "wsa.py" ]; then
    echo "$red There is wsa.py. This file will be deleted. $white"
    sudo rm -rf wsa.py
    else
 echo "$green wsa.py dont exists. $white"
    fi
echo "$green Downloading wsa.py To download WSA. $yellow"
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/python/wsa.py -O wsa.py
echo "$green WSA Beginning to download. $yellow"
chmod +x ./wsa.py && python3 ./wsa.py
echo "$green WSA has been downloaded. Now the PS file is downloading. $white"

if [ -f /mnt/c/wsaproject/Microsoft*WindowsSubsystemForAndroid*.Msixbundle ]; then
    echo "$red There is WindowsSubsystemForAndroid. This file will be deleted. $white"
rm -rf /mnt/c/wsaproject/Microsoft*WindowsSubsystemForAndroid*.Msixbundle
    else
 echo "$green WindowsSubsystemForAndroid dont exists. $white"
fi

echo "$green Download completed, moving to required location."
mv Microsoft*WindowsSubsystemForAndroid*.Msixbundle /mnt/c/wsaproject/
echo "$red Deleting wsatools.py file. $white"
sudo rm -rf wsa.py
fi
#py3
fi
}

function opengapps {
if [ -d /tmp/wsaproject ]; then
cd /tmp && cd wsaproject
else
echo "$yellow Creating folder for project files. on the linux side $white"
cd /tmp && mkdir wsaproject && cd wsaproject
fi
    if [ -f "opengapps.py" ]; then
    echo "$red There is opengapps.py. This file will be deleted. $white"
    sudo rm -rf opengapps.py
    else
 echo "$green opengapps.py dont exists. $white"
    fi

    echo "$green Downloading opengapps.py To download OpenGAPPS. $yellow"
    if [[ $gappsarch == "x86_64" ]] && [[ $msarch == "x64" ]] && [[ $mskernel == "x86_64" ]]; then
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/python/opengapps.py -O opengapps.py
fi
 if [[ $gappsarch == "arm64" ]] && [[ $msarch == "ARM64" ]] && [[ $mskernel == "arm64" ]]; then
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/python/opengapps-arm.py -O opengapps.py
fi
    if [ -f /mnt/c/wsaproject/open_gapps-$gappsarch-*.zip ]; then
    echo "$red open_gapps-$gappsarch. This file will be deleted. $white"
    sudo rm -rf /mnt/c/wsaproject/open_gapps-$gappsarch-*.zip
    else
 echo "$green open_gapps-$gappsarch dont exists. $white"
    fi
    echo "$green OpenGapps Beginning to download. $yellow"
chmod +x ./opengapps.py && python3 ./opengapps.py
echo "$green Download completed, moving to required location."
mv open_gapps-$gappsarch-*.zip /mnt/c/wsaproject/
echo "$red Deleting opengapps.py file. $white"
sudo rm -rf opengapps.py
}
function wsaonly {
if [ -d /tmp/wsaproject ]; then
cd /tmp && cd wsaproject
else
echo "$yellow Creating folder for project files. on the linux side $white"
cd /tmp && mkdir wsaproject && cd wsaproject
fi
sudo mkdir /mnt/c/wsaproject
sudo mkdir /mnt/c/wsaproject
    if [[ -x "$(command -v python3)" ]]; then
if [[ -x "$(command -v pip3)" ]]; then
echo "$yellow Downloading packages "BeautifulSoup4, wget, lxml". Via pip. $white"
pip3 install BeautifulSoup4
pip3 install wget
pip3 install lxml
#pip3
fi
if [ -f "wsa.py" ]; then
    echo "$red There is wsa.py. This file will be deleted. $white"
    sudo rm -rf wsa.py
    else
 echo "$green wsa.py dont exists. $white"
    fi
echo "$green Downloading wsa.py To download WSA. $yellow"
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/python/wsa.py -O wsa.py
echo "$green WSA Beginning to download. $yellow"
chmod +x ./wsa.py && python3 ./wsa.py
echo "$green WSA has been downloaded. Now the PS file is downloading. $white"

if [ -f /mnt/c/wsaproject/Microsoft*WindowsSubsystemForAndroid*.Msixbundle ]; then
    echo "$red There is WindowsSubsystemForAndroid. This file will be deleted. $white"
rm -rf /mnt/c/wsaproject/Microsoft*WindowsSubsystemForAndroid*.Msixbundle
    else
 echo "$green WindowsSubsystemForAndroid dont exists. $white"
fi

echo "$green Download completed, moving to required location."
mv Microsoft*WindowsSubsystemForAndroid*.Msixbundle /mnt/c/wsaproject/
echo "$red Deleting wsatools.py file. $white"
sudo rm -rf wsa.py

#wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/powershell/powershell.ps1 -O powershell.ps1
#echo "$yellow If all operations are successful, you can run the powershell.ps1 script in $yellow 'C:\wsaproject'$yellow. $white"
#py3
fi
echo "$green FINISH $white"
exit 1;
}

if [ -d /tmp/wsaproject ]; then
cd /tmp && cd wsaproject
else
echo "$yellow Creating folder for project files. on the linux side $white"
cd /tmp && mkdir wsaproject && cd wsaproject
fi


if [[ $wsatoolsdownload == true ]]; then
wsatools
fi
#/#/
if [[ $wsaonlydownload == true ]]; then

wsaonly

else
##//


if [[ $wsadownload == true ]]; then
wsa
fi
if [[ $opengappsdownload == true ]]; then
opengapps
fi

if [ -d "/mnt/c/wsaproject" ]; then
cd ~ && cd /mnt/c/wsaproject
else
echo "$yellow Creating folder for project files. on the windows side $white"
cd ~ && mkdir /mnt/c/wsaproject && cd /mnt/c/wsaproject
fi
    if [ -d /mnt/c/wsaproject/WSAGAScript ]; then
sudo rm -rf /mnt/c/wsaproject/WSAGAScript
else
fi
echo "$green WSAGAProject Downloading. $yellow"

git clone https://github.com/herrwinfried/WSAGAScript

echo "$green Downloading PS File for WSA. $yellow"

if [[ $allOkey == true ]]; then
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/powershell/powershell1.ps1 -O powershell.ps1
else
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/powershell/powershell.ps1 -O powershell.ps1
fi

echo " $green Have you placed the WSA and OpenGapps Files in the $red 'C:\wsaproject' $green directory ? $blue (Press enter to continue.) $white "
if [[ $allOkey == true ]] || [[ $okey == true ]]; then
echo "$yellow Okey $white"
else
read tr
fi

pwd

echo "$green Preparation: moving opengapps to required location. $white"

mv open_gapps-$gappsarch-11.0*.zip WSAGAScript/#GAPPS/

if [[ $tempwsa == "yes" ]] && [[ $wsadownload == true ]]; then
mkdir microsoftwsa
cd microsoftwsa
echo "$red This script is set as temporary WSA. So probably because there is a problem with a current WSA, the old version will be downloaded. $yellow"

    if [[ $gappsarch == "x86_64" ]] && [[ $msarch == "x64" ]] && [[ $mskernel == "x86_64" ]]; then
wget https://github.com/herrwinfried/wsa-mirror/releases/download/1.7.32815.0/WsaPackage_1.7.32815.0_x64_Release-Nightly.msix
fi
 if [[ $gappsarch == "arm64" ]] && [[ $msarch == "ARM64" ]] && [[ $mskernel == "arm64" ]]; then
wget https://github.com/herrwinfried/wsa-mirror/releases/download/1.7.32815.0/WsaPackage_1.7.32815.0_ARM64_Release-Nightly.msix
fi

else
echo "$yellow Preparation: Extracting the WSA file $white"
unzip -o Microsoft*WindowsSubsystemForAndroid*.Msixbundle -d microsoftwsa && cd microsoftwsa
fi
echo "$yellow Preparation: Extracting the WSA Package file $white"
unzip -o "WsaPackage_*_$msarch_*.msix" -d wsa
echo "$red Unnecessary files are deleted. $white"
find . -maxdepth 1 ! -name WsaPackage_*_\$msarch_*.msix ! -name "wsa" ! -name . -exec rm -r {} \;
cd wsa
echo "$green Preparation: files that need to be deleted are being deleted. $white"
rm -rf '[Content_Types].xml' AppxBlockMap.xml AppxSignature.p7x AppxMetadata
echo "$green Preparation: Moving files that need to be moved. $white"
mv *.img ../../WSAGAScript/#IMAGES/

cd ../..
cd WSAGAScript
echo "$green Preparation: Entering / changing required information $white"
    if [[ $gappsarch == "x86_64" ]] && [[ $msarch == "x64" ]] && [[ $mskernel == "x86_64" ]]; then
sed -ie 's+Root="$(pwd)"+Root="/mnt/c/wsaproject/WSAGAScript"+i' VARIABLES.sh
fi

 if [[ $gappsarch == "arm64" ]] && [[ $msarch == "ARM64" ]] && [[ $mskernel == "arm64" ]]; then

sed -ie 's+Root="$(pwd)"+Root="/mnt/c/wsaproject/WSAGAScript"+i' VARIABLES.sh

sed -ie 's+Architecture="x64"+Architecture="arm64"+i' VARIABLES.sh

fi

echo "$red Sta$blue\rting Oper$red\ation. $green !!! $yellow"
sudo ./extract_gapps_pico.sh && sudo ./extend_and_mount_images.sh && sudo ./apply.sh && sudo ./unmount_images.sh

echo " $green WSA and Opengapps merging is complete. $red It is now being moved to the necessary places. $white"
mv \#IMAGES/*img ../microsoftwsa/wsa/

sudo rm ../microsoftwsa/wsa/Tools/kernel && cp misc/kernel-$mskernel ../microsoftwsa/wsa/Tools/kernel

sudo rm -rf /mnt/c/wsa/$mskernel
sudo mkdir /mnt/c/wsa/$mskernel

sudo mv /mnt/c/wsaproject/microsoftwsa/wsa/* /mnt/c/wsa/$mskernel/

 if [[ $gappsarch == "arm64" ]] && [[ $msarch == "ARM64" ]] && [[ $mskernel == "arm64" ]]; then
echo "$red It's still in beta since we haven't found a device to test it, please let me know if you have any problems. $white"
fi
echo "$green Process completed. $red Note that Developer Mode must be turned on to install WSA."
echo "$yellow If all operations are successful, you can run the powershell.ps1 script in $yellow 'C:\wsaproject'$yellow. $white"

sudo rm -rf setup.sh
fi