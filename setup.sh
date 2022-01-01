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
### Fonts FINISH
if [[ $EUID -ne 0 ]]; then
   echo "$red You have to start it as SuperUser $white"
   exit 1
fi

function package_check {
### REQUIRED PACKAGES
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
if ! [ -x "$(command -v python3.9)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (python3.9) $white"
sudo apt install -y python3.9 python3-pip
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (python3.9) $white"
sudo zypper install -y python39 python39-pip
else
echo "$red I couldn't find the python3 package. That's why I canceled the transaction. $white"
exit 1
fi
fi
if ! [ -x "$(command -v pip)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (python3-pip) $white"
sudo apt install -y python3.9 python3-pip
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (python39-pip) $white"
sudo zypper install -y python39 python39-pip
else
echo "$red I couldn't find the python3-pip package. That's why I canceled the transaction. $white"
exit 1
fi
fi
### REQUIRED PACKAGES FINISH
}
package_check


gappsarch=x86_64
gappsvariant=pico
#gappslistvariant=("super", "stock", "full", "mini", "micro", "nano", "pico")
msarch=x64
mskernel=x86_64
############################
wsadownload=false;         #
opengappsdownload=false;   #
wsatoolsdownload=false;    #
allOkey=false;             #
okey=false;                #
wsaonlydownload=false;     #
install_all=false;         #
tempwsa=false;             #
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
wsaonlydownload=true;
  elif [[ $1 == "--wsa" ]]; then
wsadownload=true;
  elif [[ $1 == "--opengapps" ]] || [[ $1 == "--gapps" ]]; then
opengappsdownload=true;
elif [[ $1 == "--wsatools" ]]; then
wsatoolsdownload=true;
elif [[ $1 == "--all-okey" ]]; then
allOkey=true;
elif [[ $1 == "--okey" ]]; then
okey=true;
elif [[ $1 == "--tempwsa" ]]; then
tempwsa=true;
elif [[ $1 == "--no-tempwsa" ]]; then
tempwsa=false;
elif [[ $1 == "--variant=super" ]]; then
gappsvariant=super
elif [[ $1 == "--variant=stock" ]]; then
gappsvariant=stock
elif [[ $1 == "--variant=full" ]]; then
gappsvariant=full
elif [[ $1 == "--variant=mini" ]]; then
gappsvariant=mini
elif [[ $1 == "--variant=micro" ]]; then
gappsvariant=micro
elif [[ $1 == "--variant=nano" ]]; then
gappsvariant=nano
elif [[ $1 == "--variant=mini" ]]; then
gappsvariant=mini
elif [[ $1 == "--variant=pico" ]]; then
gappsvariant=pico
elif [[ $1 == "--variant"* ]]; then
echo "$red invalid value. Pico selected $white"
gappsvariant=pico
    else
    echo "$red Invalid argument-$i: $1 $white";
    fi
    i=$((i + 1));
    shift 1;
done
### INFORMATION
pwdsh="$(pwd)"

echo $yellow gappsarch: $red $gappsarch $yellow msarch: $red $msarch $yellow mskernel: $red $mskernel
sleep 1
echo $yellow Location: $red $pwdsh
sleep 1
echo $yellow WSA Download: $red $wsadownload $yellow OpenGapps: $red $opengappsdownload
sleep 1
echo $yellow TempWSA: $red $tempwsa
sleep 1
echo $yellow WSAOnly: $red $wsaonlydownload 
sleep 1
echo $yellow Gapps Variant: $red $gappsvariant 
sleep 1
echo $yellow WSATools: $red $wsatoolsdownload $yellow AllOkey: $red $allOkey $yellow Okey: $red $okey
sleep 4
### INFORMATION finish
### Normal Function
function check_linux_wsaproject {
    #while ! find /tmp/wsaproject 1> /dev/null 2>&1
    #do
    #echo "$red folder not found if the same thing keeps appearing please create a folder manually$yellow(/tmp/wsaproject)$white"
if [ -d /tmp/wsaproject ]; then
cd /tmp && cd wsaproject
else
echo "$yellow Creating folder for project files. on the linux side $white"
cd /tmp && mkdir wsaproject && cd wsaproject
fi
sleep 5
#done
}
function check_windows_wsaproject {
  #  while ! find /mnt/c/wsaproject 1> /dev/null 2>&1
   # do
    #echo "$red folder not found if the same thing keeps appearing please create a folder manually$yellow(/mnt/c/wsaproject | C://wsaproject)$white"

if [ -d /mnt/c/wsaproject ]; then
cd /mnt/c/ && cd wsaproject
else
echo "$yellow Creating folder for project files. on the windows side $white"
cd /mnt/c/ && mkdir wsaproject && cd wsaproject
fi
sleep 5
#done
}
function pip_install {
    if [[ -x "$(command -v python3.9)" ]]; then
echo "$yellow Downloading packages "BeautifulSoup4, wget, lxml". Via pip. $white"
python3.9 -m pip install requests
python3.9 -m pip install BeautifulSoup4
python3.9 -m pip install lxml
python3.9 -m pip install wget
fi
}
function wsagaproject_already_remove {
            if [ -d "/mnt/c/wsaproject/WSAGAScript" ]; then
sudo rm -rf /mnt/c/wsaproject/WSAGAScript
fi
     # while ! find /mnt/c/WSAGAScript 1> /dev/null 2>&1
    #do
      #echo "$red folder found if the same thing keeps appearing please delete folder manually$yellow(/mnt/c/wsaproject/WSAGAScript | C://wsaproject/WSAGAScript)$white"
sleep 5
#done
}
### Normal Function End

### WSATools Function
function wsatools {
check_linux_wsaproject

if [[ $gappsarch == "x86_64" ]] && [[ $msarch == "x64" ]] && [[ $mskernel == "x86_64" ]]; then
pip_install
if [[ -x "$(command -v python3.9)" ]] && [[ -x "$(command -v pip3)" ]]; then
if [ -f "wsatools.py" ]; then
echo "$red There is wsatools.py. This file will be deleted. $white"
    sudo rm -rf wsatools.py
    else
 echo "$green wsatools.py dont exists. $white"
    fi
####################
    if [ -f "/mnt/c/wsaproject/WSATools.msixbundle" ]; then
    echo "$red There is WSATools. This file will be deleted. $white"
sudo rm -rf /mnt/c/wsaproject/WSATools.msixbundle
    else
 echo "$green WSATools dont exists. $white"
fi
####################
echo "$green Downloading wsatools.py To download WSATools. $white"

wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/python/wsatools.py -O wsatools.py
echo "$green WSATools Beginning to download. $yellow"

wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/powershell/wsatools.ps1 -O wsatools.ps1

chmod +x ./wsatools.py && python3.9 ./wsatools.py
echo "$green WSATools has been downloaded. Now the PS file is downloading. $white"
echo "$green Download completed, moving to required location."
sudo mv wsatools.ps1 /mnt/c/wsaproject/wsatools.ps1
sudo mv 54406Simizfo.WSATools*.msixbundle /mnt/c/wsaproject/WSATools.msixbundle

echo "$red Deleting wsatools.py file. $white"
sudo rm -rf wsatools.py
else
echo "$yellow I think there was a problem. I may not have downloaded WSATools. $white"
sleep 5
fi
###
else 
echo "$red WSATools has no support yet for the Processor you are using. $white"
sleep 5
fi
}
### WSATools Function FINISH

### WSA Function

function wsa {
check_linux_wsaproject
pip_install
if [[ -x "$(command -v python3.9)" ]] && [[ -x "$(command -v pip3)" ]]; then
if [[ $tempwsa == "yes" ]]; then
echo "$yellow This script is set as temporary WSA. So probably because there is a problem with a current WSA, the old version will be downloaded. $white"
else
#
if [ -f "wsa.py" ]; then
    echo "$red There is wsa.py. This file will be deleted. $white"
    sudo rm -rf wsa.py
    else
 echo "$green wsa.py dont exists. $white"
    fi
#
echo "$green Downloading wsa.py To download WSA. $yellow"
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/python/wsa.py -O wsa.py
echo "$green WSA Beginning to download. $yellow"
chmod +x ./wsa.py && python3.9 ./wsa.py
echo "$green WSA has been downloaded. Now the PS file is downloading. $white"

if [ -f /mnt/c/wsaproject/Microsoft*WindowsSubsystemForAndroid*.msixbundle ]; then
    echo "$red There is WindowsSubsystemForAndroid. This file will be deleted. $white"
sudo rm -rf /mnt/c/wsaproject/Microsoft*WindowsSubsystemForAndroid*.msixbundle
    else
 echo "$green WindowsSubsystemForAndroid dont exists. $white"
fi

echo "$green Download completed, moving to required location."
sudo mv Microsoft*WindowsSubsystemForAndroid*.msixbundle /mnt/c/wsaproject/
echo "$red Deleting wsatools.py file. $white"
sudo rm -rf wsa.py

fi
###
else
echo "$red Process aborted because python or pip is not installed.$white"
sleep 3
exit 1
fi
}

### WSA Function FINISH

### OpenGapps Function
function opengapps {
    check_linux_wsaproject
    pip_install
    if [[ -x "$(command -v python3.9)" ]] && [[ -x "$(command -v pip3)" ]]; then
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/python/opengapps.py -O opengapps.py
#
    if [ -f /mnt/c/wsaproject/open_gapps-$gappsarch-*.zip ]; then
    echo "$red open_gapps-$gappsarch. This file will be deleted. $white"
    sudo rm -rf /mnt/c/wsaproject/open_gapps-$gappsarch-*.zip
    else
 echo "$green open_gapps-$gappsarch dont exists. $white"
    fi
    echo "$green OpenGapps Beginning to download. $yellow"
chmod +x ./opengapps.py && python3.9 ./opengapps.py -a $gappsarch -va $gappsvariant
echo "$green Download completed, moving to required location."
mv open_gapps-$gappsarch-*.zip /mnt/c/wsaproject/
echo "$red Deleting opengapps.py file. $white"
sudo rm -rf opengapps.py
#
else
echo "$red Process aborted because python or pip is not installed.$white"
sleep 3
exit 1
fi
}
### OpenGapps Function FINISH

### Only WSA Function

function wsaonly {
    check_linux_wsaproject
    pip_install
       if [[ -x "$(command -v python3.9)" ]] && [[ -x "$(command -v pip3)" ]]; then
###############
if [ -f /mnt/c/wsaproject/Microsoft*WindowsSubsystemForAndroid*.msixbundle ]; then
    echo "$red There is WindowsSubsystemForAndroid. This file will be deleted. $white"
sudo rm -rf /mnt/c/wsaproject/Microsoft*WindowsSubsystemForAndroid*.msixbundle
    else
 echo "$green WindowsSubsystemForAndroid dont exists. $white"
fi

if [ -f "wsa.py" ]; then
    echo "$red There is wsa.py. This file will be deleted. $white"
    sudo rm -rf wsa.py
    else
 echo "$green wsa.py dont exists. $white"
    fi
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/powershell/Setup.ps1 -O Setup.ps1
sudo mv Setup.ps1 /mnt/c/wsaproject/
echo "$green Downloading wsa.py To download WSA. $yellow"
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/python/wsa.py -O wsa.py
echo "$green WSA Beginning to download. $yellow"
chmod +x ./wsa.py && python3.9 ./wsa.py
echo "$green WSA has been downloaded. Now the PS file is downloading. $white"

echo "$green Download completed, moving to required location."
sudo mv Microsoft*WindowsSubsystemForAndroid*.msixbundle /mnt/c/wsaproject/
echo "$red Deleting wsatools.py file. $white"
sudo rm -rf wsa.py
echo "$green Downloaded to C://wsaproject folder. Go to Location and then Double click on it and it will be installed. $white"

sleep 5
#
else
echo "$red Process aborted because python or pip is not installed.$white"
sleep 3
exit 1
fi
}

### Only WSA Function FINISH

### Processor
check_linux_wsaproject
sleep 1
# WSA Tools
if [[ $wsatoolsdownload == true ]]; then
wsatools
fi
# WSA Tools End
sleep 2
# Only WSA
if [[ $wsaonlydownload == true ]]; then
wsaonly
sleep 2
exit 1
fi
# Only WSA End

# WSA
if [[ $wsadownload == true ]]; then
wsa
fi
# WSA END
sleep 2

# OpenGapps
if [[ $opengappsdownload == true ]]; then
opengapps
fi
# OpenGapps END
check_windows_wsaproject
wsagaproject_already_remove

echo "$green WSAGAProject Downloading. $yellow"
git clone https://github.com/herrwinfried/WSAGAScript

echo "$green Downloading PS File for WSA. $yellow"

wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/powershell/Setup.ps1 -O Setup.ps1
sleep 3

echo " $green Have you placed the WSA and OpenGapps Files in the $red 'C:\wsaproject' $green directory ? $blue (Press enter to continue.) $white "
if [[ $allOkey == true ]] || [[ $okey == true ]]; then
echo "$yellow Okey $white"
else
read tr
fi

while ! ls /mnt/c/wsaproject/MicrosoftCorporationII.WindowsSubsystemForAndroid*.msixbundle 1> /dev/null 2>&1
do
echo "$red WSA file not found.$white"
echo "$yellow Go To$blue https://store.rg-adguard.net 
echo $yellow 1. Select ProductID 
echo $cyan ProductId: $red 9P3395VX91NR 
echo $cyan Ring: $red slow 
echo $yellow Download the file which is approximately 1.2 GiB starting with MicrosoftCorporationII.WindowsSubsystemForAndroid. Drop the wsaproject folder under the C directory.$magenta(c://wsaproject) $white"
sleep 10
done
echo "$green WSA file found.$white"
sleep 2
while ! ls /mnt/c/wsaproject/open_gapps-$gappsarch-*.zip 1> /dev/null 2>&1
do
echo "$red OpenGapps file not found.$white"
echo "$yellow Go To$blue https://opengapps.org/ 
echo $cyan Platform: $red $gappsarch 
echo $cyan Android: $red 11.0 
echo $cyan Variant: pico (recomment) 
echo $yellow download the file. and drop the wsaproject folder under the C directory.$magenta(c://wsaproject) $white"
sleep 10
done
echo "$green OpenGapps file found.$white"
sleep 2

pwd 

echo "$green Preparation: moving opengapps to required location. $white"

mv open_gapps-$gappsarch-11.0*.zip WSAGAScript/#GAPPS/
sleep 2
if [[ $tempwsa == "yes" ]] && [[ $wsadownload == true ]]; then
mkdir microsoftwsa
cd microsoftwsa
echo "$red This script is set as temporary WSA. So probably because there is a problem with a current WSA, the old version will be downloaded. $yellow"

    if [[ $gappsarch == "x86_64" ]] && [[ $msarch == "x64" ]] && [[ $mskernel == "x86_64" ]]; then
#wget https://github.com/herrwinfried/wsa-mirror/releases/download/1.7.32815.0/WsaPackage_1.7.32815.0_x64_Release-Nightly.msix
wget https://github.com/herrwinfried/wsa-mirror/releases/download/1.8.32828.0/WsaPackage_1.8.32828.0_x64_Release-Nightly.msix
 elif [[ $gappsarch == "arm64" ]] && [[ $msarch == "ARM64" ]] && [[ $mskernel == "arm64" ]]; then
#wget https://github.com/herrwinfried/wsa-mirror/releases/download/1.7.32815.0/WsaPackage_1.7.32815.0_ARM64_Release-Nightly.msix
wget https://github.com/herrwinfried/wsa-mirror/releases/download/1.8.32828.0/WsaPackage_1.8.32828.0_x64_Release-Nightly.msix
fi

else
echo "$yellow Preparation: Extracting the WSA file $white"
sleep 3
unzip -o Microsoft*WindowsSubsystemForAndroid*.msixbundle -d microsoftwsa && cd microsoftwsa
fi
echo "$yellow Preparation: Extracting the WSA Package file $white"
sleep 3
unzip -o "WsaPackage_*_$msarch_*.msix" -d wsa
echo "$red Unnecessary files are deleted. $white"
find . -maxdepth 1 ! -name WsaPackage_*_\$msarch_*.msix ! -name "wsa" ! -name . -exec rm -r {} \;
cd wsa
echo "$green Preparation: files that need to be deleted are being deleted. $white"
sleep 2
rm -rf '[Content_Types].xml' AppxBlockMap.xml AppxSignature.p7x AppxMetadata
sleep 2
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

echo "$red Starting $magenta Operation. $green !!! $yellow"
sudo ./extract_gapps_pico.sh && sudo ./extend_and_mount_images.sh && sudo ./apply.sh && sudo ./unmount_images.sh

echo " $green WSA and Opengapps merging is complete. $red It is now being moved to the necessary places. $white"
mv \#IMAGES/*img ../microsoftwsa/wsa/

sudo rm ../microsoftwsa/wsa/Tools/kernel && cp misc/kernel-$mskernel ../microsoftwsa/wsa/Tools/kernel

sudo rm -rf /mnt/c/wsa/$msarch
sudo mkdir /mnt/c/wsa/$msarch

sudo mv /mnt/c/wsaproject/microsoftwsa/wsa/* /mnt/c/wsa/$msarch/
 if [[ $gappsarch == "arm64" ]] && [[ $msarch == "ARM64" ]] && [[ $mskernel == "arm64" ]]; then
echo "$red It's still in beta since we haven't found a device to test it, please let me know if you have any problems. $white"
fi
if [ $wsatoolsdownload == "false" ]; then
sudo cp /mnt/c/wsaproject/Setup.ps1 /mnt/c/wsa/Setup.ps1
fi

echo "$green Process completed."
if [ $wsatoolsdownload == "false" ]; then
echo "$red Note that Developer Mode must be turned on to install WSA. $white"
echo "$green Open Settings"
echo "$magenta Press $red Privacy & security"
echo "$magenta Press $red for developers"
echo "$magenta Select $yellow enable $red Developer Mode"
echo "$yellow If you are going to $green install apk via adb. $red Enable Developer settings from WSA Settings."
sleep 2
fi

echo "$yellow If all operations are successful, you can run the powershell.ps1 script in $yellow 'C:\wsaproject'$yellow. $white"
sleep 1
sudo rm -rf setup.sh
### Processor finish