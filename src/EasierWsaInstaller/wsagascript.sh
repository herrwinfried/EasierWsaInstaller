#!/bin/bash
function wsagascript_s {

mkdir -p ~/EasierWsaInstallerLog
File="$(date +%Y_%m_%d-%H_%M_%S)_wsagascript"
touch ~/EasierWsaInstallerLog/$File
GetFile=~/EasierWsaInstallerLog/$File
echo "FOLDER: $( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

" >> $GetFile
timedatectl >> $GetFile
echo "" >> $GetFile

echo "$(date +%H:%M:%S): I'm checking the package." >> $GetFile
requirePackages
echo "$(date +%H:%M:%S): package check finished." >> $GetFile

echo "$(date +%H:%M:%S): [START] WSLFolder function" >> $GetFile
WSLFolder
echo "$(date +%H:%M:%S): [FINISH] WSLFolder function" >> $GetFile

echo "$(date +%H:%M:%S): [START] WindowsFolder function" >> $GetFile
WindowsFolder
echo "$(date +%H:%M:%S): [FINISH] WindowsFolder function" >> $GetFile

echo "$(date +%H:%M:%S): [START] scriptpip function" >> $GetFile
scriptpip
echo "$(date +%H:%M:%S): [FINISH] scriptpip function" >> $GetFile

echo "$(date +%H:%M:%S): [START] Get_WSLFolderScripts function" >> $GetFile
Get_WSLFolderScripts
echo "$(date +%H:%M:%S): [FINISH] Get_WSLFolderScripts function" >> $GetFile

echo "$(date +%H:%M:%S): [IF] WSATools" >> $GetFile
if [[ $WSATools == true ]]; then
echo "$(date +%H:%M:%S): [START] wsatoolspy function" >> $GetFile
wsatoolspy || scriptabort
echo "$(date +%H:%M:%S): [FINISH] wsatoolspy function" >> $GetFile
fi
echo "$(date +%H:%M:%S): [IF] WSATools FINISH" >> $GetFile

echo "$(date +%H:%M:%S): [START] wsapy function" >> $GetFile
wsapy || scriptabort
echo "$(date +%H:%M:%S): [FINISH] wsapy function" >> $GetFile

echo "$(date +%H:%M:%S): [START] opengappspy function" >> $GetFile
opengappspy || scriptabort
echo "$(date +%H:%M:%S): [FINISH] opengappspy function" >> $GetFile

echo "$(date +%H:%M:%S): [START] wsatoolspy function" >> $GetFile
Get_WindowsFolder || scriptabort
echo "$(date +%H:%M:%S): [FINISH] wsatoolspy function" >> $GetFile





#Write the rest of the code here...








echo "$(date +%Y_%m_%d-%H_%M_%S): Wait... 1" >> $GetFile
sleepwait 1
echo "$(date +%Y_%m_%d-%H_%M_%S): [FORCE DELETE] /root/easierwsainstaller-project [?]" >> $GetFile
sudo rm -rf /root/easierwsainstaller-project
echo "$(date +%Y_%m_%d-%H_%M_%S): Wait... 10" >> $GetFile
sleepwait 10
echo "$(date +%Y_%m_%d-%H_%M_%S): [CLEAR & CLEAR]" >> $GetFile
clear & clear
}