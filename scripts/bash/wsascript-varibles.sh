#!/bin/bash
WSASCRIPTVERSION="v2.0.1"
# Colors
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
# Colors Finish

function onlywsl(){

unameout=$(uname -r | tr '[:upper:]' '[:lower:]');
if [ "$(echo $(cat /proc/cpuinfo | grep -m1 microcode | cut -f2 -d:))" != "0xffffffff" ]; then
echo $yellow I guess you are not using WSL Distro.$red The transaction has been cancelled. $white
exit 1
fi
#if [ "$(cat /proc/cpuinfo | grep microcode | grep 0xffffffff)" == "" ]
#then
#echo $yellow I guess you are not using WSL Distro.$red The transaction has been cancelled. $white
#fi

}


function checkroot {
if [[ $EUID -ne 0 ]]; then
     echo "$red You need to be Super User/Root. $white"
   exit 1
fi
}

function sleepwait () {
sleep $1
}

function requirePackage_magisk() {

if ! [ -x "$(command -v lsb_release)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (lsb_release) $white"
sudo apt install -y lsb-release
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (lsb_release) $white"
sudo zypper install -y unzip lzip
else
echo "$red I couldn't find the lsb_release package. That's why I canceled the transaction. $white"
exit 1
fi
fi

distroselect=$(lsb_release -d | awk -F"\t" '{print $2}')
distrocodename=$(lsb_release -c | awk -F"\t" '{print $2}')

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
if ! [ -x "$(command -v seinfo)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (setools) $white"
sudo apt install -y setools
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (setools-console) $white"
sudo zypper install -y setools-console
else
echo "$red I couldn't find the setools package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v whiptail)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (whiptail) $white"
sudo apt install -y whiptail
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (whiptail) $white"
sudo zypper install -y newt
else
echo "$red I couldn't find the whiptail package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v wine64)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (wine) $white"
sudo apt install -y wine
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (wine) $white"
sudo zypper install -y wine
else
echo "$red I couldn't find the wine package. That's why I canceled the transaction. $white"
exit 1
fi
fi
function debian_t() {
if [ $distroselect == "Debian GNU/Linux 11 (bullseye)"]; then 
find /etc/apt/sources* -type f -exec cat {} \; | grep -E 'contrib' && find /etc/apt/sources* -type f -exec cat {} \; | grep -E 'non-free'{
  echo "$yellow I am adding the $red contrib non-free $yellow repository. (winetricks) $white"
sudo apt-add-repository contrib
sudo apt-add-repository non-free
  }
    sudo apt update
  sudo apt install -y winetricks

fi
}
if ! [ -x "$(command -v winetricks)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (winetricks) $white"
sudo apt install -y winetricks || debian_t
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (winetricks) $white"
sudo zypper install -y winetricks 
else
echo "$red I couldn't find the winetricks package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v patchelf)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (patchelf) $white"
sudo apt install -y patchelf
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (patchelf) $white"
sudo zypper install -y patchelf 
else
echo "$red I couldn't find the patchelf package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v e2fsck)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (e2fsck) $white"
sudo apt install -y e2fsprogs
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (e2fsck) $white"
sudo zypper install -y e2fsprogs
else
echo "$red I couldn't find the e2fsck package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v aria2c)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (aria2c) $white"
sudo apt install -y aria2
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (aria2c) $white"
sudo zypper install -y aria2
else
echo "$red I couldn't find the aria2c package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v 7z)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (7z) $white"
sudo apt install -y p7zip-full
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (7z) $white"
sudo zypper install -y 7zip
else
echo "$red I couldn't find the 7z package. That's why I canceled the transaction. $white"
exit 1
fi
fi

if ! [ -x "$(command -v pip)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (python3-pip) $white"
sudo apt install -y python3-pip
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (python3.10-pip) $white"
sudo zypper install -y python310 python310-pip
else
echo "$red I couldn't find the python3-pip package. That's why I canceled the transaction. $white"
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

if ! [ -x "$(command -v setfattr)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (attr) $white"
sudo apt install -y attr
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (attr) $white"
sudo zypper install -y attr
else
echo "$red I couldn't find the attr package. That's why I canceled the transaction. $white"
exit 1
fi
fi

sleepwait 1

}

function requirePackage_normal() {
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
sudo zypper install -y e2fsprogs
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
sudo zypper install -y e2fsprogs
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
if ! [ -x "$(command -v python3.10)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (python3.10) $white"
sudo apt install -y python3-pip
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (python3.10) $white"
sudo zypper install -y python310 python310-pip
else
echo "$red I couldn't find the python3 package. That's why I canceled the transaction. $white"
exit 1
fi
fi
if ! [ -x "$(command -v pip)" ]; then
if [ -x "$(command -v apt)" ]; then
echo "$green I found a missing package, I'm installing it... (python3-pip) $white"
sudo apt install -y python3-pip
elif [ -x "$(command -v zypper)" ]; then
echo "$green I found a missing package, I'm installing it... (python3.10-pip) $white"
sudo zypper install -y python310 python310-pip
else
echo "$red I couldn't find the python3-pip package. That's why I canceled the transaction. $white"
exit 1
fi
fi
### REQUIRED PACKAGES FINISH
sleepwait 1
}
#----------------GAPPS----------------------------
HOST_WSL_ARCH=$(uname -m)
gappsarch=x86_64
gappsvariant=pico
msarch=x64
mskernel=x86_64
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
#####################################################



function scriptregex() {
echo $1 | tr -cd "[a-z]\n"
}
function equalcommand() {
  echo $1 | cut -f2 -d"="
}
function GetMessage() {
  chmod +x language/*
  unset ./language/en-us.sh
  unset ./language/tr.sh
  unset ./language/de-DE.sh
  if [[ $Language == "en_US" ]];
  then
  . ./language/en-US.sh
    elif [[ $Language == "tr" ]];
  then
  . ./language/tr.sh
      elif [[ $Language == "de_DE" ]];
  then
  . ./language/de-DE.sh
  else
  . ./language/en-US.sh
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