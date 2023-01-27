#!/bin/bash
function onlywsa_s {


mkdir -p ~/EasierWsaInstallerLog
File="$(date +%Y_%m_%d-%H_%M_%S)_onlywsa"
touch ~/EasierWsaInstallerLog/$File
GetFile=~/EasierWsaInstallerLog/$File
echo $"FOLDER: $( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

" >> $GetFile
timedatectl >> $GetFile
echo $"" >> $GetFile

echo "$magenta checking the package $white"

echo $"$(date +%H:%M:%S): checking the package." >> $GetFile
requirePackages || scriptabort
echo $"$(date +%H:%M:%S): package check finished." >> $GetFile

echo $"$(date +%H:%M:%S): [START] WSLFolder function" >> $GetFile
WSLFolder || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] WSLFolder function" >> $GetFile

echo $"$(date +%H:%M:%S): [START] WindowsFolder function" >> $GetFile
WindowsFolder || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] WindowsFolder function" >> $GetFile

echo $"$(date +%H:%M:%S): [START] scriptpip function" >> $GetFile
scriptpip || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] scriptpip function" >> $GetFile

echo $"$(date +%H:%M:%S): [START] Get_WSLFolderScripts function" >> $GetFile
Get_WSLFolderScripts || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] Get_WSLFolderScripts function" >> $GetFile

echo $"$(date +%H:%M:%S): [START] Go to EasierWsaInstaller" >> $GetFile
cd EasierWsaInstaller
echo $"$(date +%H:%M:%S): [FINISH] Go to EasierWsaInstaller" >> $GetFile

echo $"$(date +%H:%M:%S): [START] wsapy function" >> $GetFile
wsapy || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] wsapy function" >> $GetFile

echo $"$(date +%H:%M:%S): [IF] WSATools" >> $GetFile
if [[ $WSATools == true ]]; then
echo $"$(date +%H:%M:%S): [START] wsatoolspy function" >> $GetFile
wsatoolspy || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] wsatoolspy function" >> $GetFile
fi

echo $"$(date +%H:%M:%S): [IF] WSATools FINISH" >> $GetFile

echo $"$(date +%H:%M:%S): Quit Message" >> $GetFile
echo $"$yellow All transactions are finished. Please check the files in C: > wsaproject(/mnt/c/wsaproject) before deleting. $white" >> $GetFile
echo $"$(date +%H:%M:%S): Wait... 90" >> $GetFile
sleepwait 90
echo $"$(date +%H:%M:%S): Wait... 1" >> $GetFile
sleepwait 1
echo $"$(date +%H:%M:%S): [FORCE DELETE] /root/easierwsainstaller-project [?]" >> $GetFile
sudo rm -rf /root/easierwsainstaller-project
echo $"$(date +%H:%M:%S): Wait... 10" >> $GetFile
sleepwait 10
echo $"$(date +%H:%M:%S): [CLEAR & CLEAR]" >> $GetFile
clear & clear
}

