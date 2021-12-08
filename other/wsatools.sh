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

if [[ -x "$(command -v python3)" ]]; then
if [[ -x "$(command -v pip3)" ]]; then
pip3 install BeautifulSoup4
pip3 install wget
pip3 install lxml
#pip3
fi
echo "$red Only 64 Bit(amd64)"
wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/python/wsatools.py -O wsatools.py
chmod +x ./wsatools.py && python3 ./wsatools.py

wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/powershell/wsatools.ps1 -O wsatools.ps1

mv wsatools.ps1 /mnt/c/wsaproject/wsatools.ps1

mv 54406Simizfo.WSATools*.Msixbundle /mnt/c/wsaproject/WSATools.Msixbundle

sudo rm -rf wsatools.py

#py3
fi