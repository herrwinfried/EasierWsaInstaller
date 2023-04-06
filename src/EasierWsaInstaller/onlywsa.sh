#!/bin/bash
function onlywsa_s {


LogFile_Create onlywsa

LogFile_input_start "WSLFolder function" # LOGGER
WSLFolder || scriptabort
LogFile_input_finish "WSLFolder function" # LOGGER

LogFile_input_start "WindowsFolder function" # LOGGER
WindowsFolder || scriptabort
LogFile_input_finish "WindowsFolder function" # LOGGER

LogFile_input_start "scriptpip function" # LOGGER
scriptpip || scriptabort
LogFile_input_finish "scriptpip function" # LOGGER

LogFile_input_start "Get_WSLFolderScripts function" # LOGGER
Get_WSLFolderScripts || scriptabort
LogFile_input_finish "Get_WSLFolderScripts function" # LOGGER

LogFile_input_start "Go to EasierWsaInstaller" # LOGGER
cd EasierWsaInstaller
LogFile_input_finish "Go to EasierWsaInstaller" # LOGGER

LogFile_input_start "wsapy function" # LOGGER
wsapy || scriptabort
LogFile_input_finish "wsapy function" # LOGGER

LogFile_input_if_start "WSATools" # LOGGER
if [[ $WSATools == true ]]; then
LogFile_input_start "wsatoolspy function" # LOGGER
wsatoolspy || scriptabort
LogFile_input_finish "wsatoolspy function" # LOGGER
fi

LogFile_input_if_finish "WSATools" # LOGGER

LogFile_input "Quit Message" # LOGGER
echo "$yellow""All transactions are finished. Please check the files in C: > wsaproject(/mnt/c/wsaproject) before deleting.""$yellow"
LogFile_input "Wait... 90" # LOGGER
sleepwait 90
LogFile_input "Wait... 1" # LOGGER
sleepwait 1
LogFile_input "[FORCE DELETE] /root/wsainstaller-files [?]" # LOGGER
sudo rm -rf /root/wsainstaller-files
LogFile_input "Wait... 10" # LOGGER
sleepwait 10
LogFile_input "[CLEAR & CLEAR]" # LOGGER
clear & clear
}

