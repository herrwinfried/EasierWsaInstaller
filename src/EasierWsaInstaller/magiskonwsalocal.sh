#!/bin/bash
function magiskonwsalocal_s {
mkdir -p ~/EasierWsaInstallerLog
File="$(date +%Y_%m_%d-%H_%M_%S)_magiskonwsalocal"
touch ~/EasierWsaInstallerLog/$File
GetFile=~/EasierWsaInstallerLog/$File
echo $"FOLDER: $( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

" >> $GetFile
timedatectl >> $GetFile
echo $"" >> $GetFile

echo "$magenta checking the package $white"

echo $"$(date +%H:%M:%S): checking the package." >> $GetFile
requirePackages
echo $"$(date +%H:%M:%S): package check finished." >> $GetFile

echo $"$(date +%H:%M:%S): [PIP] checking the package." >> $GetFile
pip list --disable-pip-version-check | grep -E "^requests " >/dev/null 2>&1 || python3 -m pip install requests
echo $"$(date +%H:%M:%S): [PIP] package check finished." >> $GetFile

echo $"$(date +%H:%M:%S): [START] WSLFolder function" >> $GetFile
WSLFolder
echo $"$(date +%H:%M:%S): [FINISH] WSLFolder function" >> $GetFile

echo $"$(date +%H:%M:%S): [START] WindowsFolder function" >> $GetFile
WindowsFolder
echo $"$(date +%H:%M:%S): [FINISH] WindowsFolder function" >> $GetFile

echo $"$(date +%H:%M:%S): [START] scriptpip function" >> $GetFile
scriptpip
echo $"$(date +%H:%M:%S): [FINISH] scriptpip function" >> $GetFile

echo $"$(date +%H:%M:%S): [START] Get_WSLFolderScripts function" >> $GetFile
Get_WSLFolderScripts
echo $"$(date +%H:%M:%S): [FINISH] Get_WSLFolderScripts function" >> $GetFile

echo $"$(date +%H:%M:%S): [START] Go to EasierWsaInstaller" >> $GetFile
cd EasierWsaInstaller
echo $"$(date +%H:%M:%S): [FINISH] Go to EasierWsaInstaller" >> $GetFile

echo $"$(date +%H:%M:%S): [IF] WSATools" >> $GetFile
if [[ $WSATools == true ]]; then
echo $"$(date +%H:%M:%S): [START] wsatoolspy function" >> $GetFile
wsatoolspy || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] wsatoolspy function" >> $GetFile
fi
echo $"$(date +%H:%M:%S): [IF] WSATools FINISH" >> $GetFile

echo "$magenta I'm doing the presets. $white"

echo $"$(date +%H:%M:%S): [IF] [START] /proc/sys/fs/binfmt_misc/WSLInterop" >> $GetFile
if [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ] && which wine64 > /dev/null; then
echo $"$(date +%H:%M:%S): [IF] [START] winetricks" >> $GetFile
    winetricks list-installed | grep -E "^msxml6" >/dev/null 2>&1 || {
echo $"$(date +%H:%M:%S): [IF] [winetricks] ELSE" >> $GetFile
        cp -r ../wine/.cache/* ~/.cache
        winetricks msxml6 || abort
    }
echo $"$(date +%H:%M:%S): [IF] [FINISH] winetricks" >> $GetFile
fi
echo $"$(date +%H:%M:%S): [IF] [FINISH] /proc/sys/fs/binfmt_misc/WSLInterop" >> $GetFile    

# DEBUG=--debug
# CUSTOM_MAGISK=--magisk-custom
echo $"$yellow I'm adjusting the values ​​to be compatible with the magisk installation. $white"

echo $"$(date +%H:%M:%S): [IF] [START] Change ARCH Value" >> $GetFile  
if [[ $mskernel == "x86_64" ]]; then
ARCH="x64"
elif [[ $mskernel == "arm64" ]]; then
ARCH="arm64"
else
ARCH="x64"
fi
echo $"$(date +%H:%M:%S): [IF] [FINISH] Change ARCH Value" >> $GetFile  

echo $"$(date +%H:%M:%S): [START] Change MAGISK_VER , GAPPS_BRAND, GAPPS_VARIANT Value" >> $GetFile 
MAGISK_VER=$MagiskVersion
GAPPS_BRAND="OpenGApps"
GAPPS_VARIANT=$gappsvariant
echo $"$(date +%H:%M:%S): [FINISH] Change MAGISK_VER , GAPPS_BRAND, GAPPS_VARIANT Value" >> $GetFile 


echo $"$(date +%H:%M:%S): [IF] [START] WSA RELEASE CHANGE" >> $GetFile  
if [[ $WSARelease == "fast" ]]; then
RELEASE_TYPE=WIF
elif [[ $WSARelease == "slow" ]]; then
RELEASE_TYPE=WIS
elif [[ $WSARelease == "retail" ]]; then
RELEASE_TYPE=retail
elif [[ $WSARelease == "rp" ]]; then
RELEASE_TYPE=rp
else
RELEASE_TYPE=retail
fi
echo $"$(date +%H:%M:%S): [IF] [START] WSA RELEASE CHANGE" >> $GetFile  


echo $"$(date +%H:%M:%S): [IF] [START] Amazon Store 0/1" >> $GetFile  
if [[ $WSAAmazonRemove == "true" ]]; then

REMOVE_AMAZON="--remove-amazon"
else 
REMOVE_AMAZON=""
fi
echo $"$(date +%H:%M:%S): [IF] [FINISH] Amazon Store 0/1" >> $GetFile

echo $"$(date +%H:%M:%S): [START] ROOT_SOL , COMPRESS_OUTPUT VALUE CHANGE" >> $GetFile
ROOT_SOL="magisk"
COMPRESS_OUTPUT="" #"--compress"
echo $"$(date +%H:%M:%S): [FINISH] ROOT_SOL , COMPRESS_OUTPUT VALUE CHANGE" >> $GetFile

echo $"$(date +%H:%M:%S): [START] CREATE COMMAND_LINE" >> $GetFile
COMMAND_LINE=(--arch "$ARCH" --release-type "$RELEASE_TYPE" --magisk-ver "$MAGISK_VER" --gapps-brand "$GAPPS_BRAND" --gapps-variant "$GAPPS_VARIANT" "$REMOVE_AMAZON" --root-sol "$ROOT_SOL" "$COMPRESS_OUTPUT" "$OFFLINE" "$DEBUG" "$CUSTOM_MAGISK")
echo $"$(date +%H:%M:%S): [FINISH] CREATE COMMAND_LINE" >> $GetFile

echo $"$(date +%H:%M:%S): [START] WSLFolder function" >> $GetFile
WSLFolder || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] WSLFolder function" >> $GetFile

echo $"$(date +%H:%M:%S): [START] Get_WSLFolderScripts function" >> $GetFile
Get_WSLFolderScripts || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] Get_WSLFolderScripts function" >> $GetFile

echo $"$(date +%H:%M:%S): [START] Go to MagiskOnWSALocal/scripts" >> $GetFile
cd MagiskOnWSALocal && cd scripts || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] Go to MagiskOnWSALocal/scripts" >> $GetFile

echo $"$(date +%H:%M:%S): [START] Make everything in the WSAGAScript folder executable." >> $GetFile
sudo chmod +x ./*.sh || find "$(pwd)" -iname "*.sh" -exec chmod +x "{}" \; || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] Make everything in the WSAGAScript folder executable." >> $GetFile


echo $"$(date +%H:%M:%S): [START] CUSTOMERS CHANGE SCRIPT" >> $GetFile

sed -ie 's+# export TMPDIR=$(dirname "$PWD")/WORK_DIR_+export TMPDIR=$(dirname "$PWD")/WORK_DIR_+i' build.sh || scriptabort
sed -ie 's+("build", "product"): "redfin"+("build", "product"): "'$WSAProductName'"+i' fixGappsProp.py || scriptabort
sed -ie 's+("product", "name"): "redfin"+("product", "name"): "'$WSAProductName'"+i' fixGappsProp.py || scriptabort
sed -ie 's+("product", "device"): "redfin"+("product", "device"): "'$WSAProductName'"+i' fixGappsProp.py || scriptabort
sed -ie 's+("build", "flavor"): "redfin-user"+("build", "flavor"): "'$WSAProductName'-user"+i' fixGappsProp.py || scriptabort

if [[ $mskernel == "x86_64" ]]; then
sed -ie 's+HOST_ARCH=$(uname -m)+HOST_ARCH=x86_64+i' fixGappsProp.py || scriptabort
elif [[ $mskernel == "arm64" ]]; then
sed -ie 's+HOST_ARCH=$(uname -m)+HOST_ARCH=aarch64+i' fixGappsProp.py || scriptabort
else
sed -ie 's+HOST_ARCH=$(uname -m)+HOST_ARCH=x86_64+i' fixGappsProp.py || scriptabort
fi

echo $"$(date +%H:%M:%S): [FINISH] CUSTOMERS CHANGE SCRIPT" >> $GetFile

echo $"$yellow Everything seems ready. After this stage, the control will now be in the magiskonwsalocal project. When the process is finished, I will perform the migration. $white"
echo $"$(date +%Y_%m_%d-%H_%M_%S): Wait... 3" >> $GetFile
sleepwait 3
echo $"COMMAND_LINE=${COMMAND_LINE[*]}"
echo $"$(date +%Y_%m_%d-%H_%M_%S): Wait... 2" >> $GetFile
sleepwait 2
echo $"$(date +%H:%M:%S): [START] ./build.sh ${COMMAND_LINE[@]}" >> $GetFile
./build.sh "${COMMAND_LINE[@]}" || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] ./build.sh ${COMMAND_LINE[@]}" >> $GetFile

echo $"$(date +%H:%M:%S): [START] [FIN] Get_WSLFolderScripts function" >> $GetFile
Get_WSLFolderScripts || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] [FIN] Get_WSLFolderScripts function" >> $GetFile

echo $"$(date +%H:%M:%S): [START] [FIN] Go to MagiskOnWSALocal/output" >> $GetFile
cd MagiskOnWSALocal && cd output || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] [FIN] Go to MagiskOnWSALocal/output" >> $GetFile

echo $"$(date +%H:%M:%S): [START] [FIN] Checking in /mnt/c/wsa/wsamagisk. If full, it will be deleted." >> $GetFile
sudo mkdir -p /mnt/c/wsa
sudo rm -rf /mnt/c/wsa/wsamagisk
echo $"$(date +%H:%M:%S): [FINISH] [FIN] Checking in /mnt/c/wsa/wsamagisk. If full, it will be deleted." >> $GetFile

echo $"$(date +%H:%M:%S): [START] [FIN] mkdir wsamagisk " >> $GetFile
sudo mkdir -p /mnt/c/wsa/wsamagisk
echo $"$(date +%H:%M:%S): [FINISH] [FIN] mkdir wsamagisk " >> $GetFile

echo $"$(date +%H:%M:%S): [START] [FIN] go to WSL: WSA " >> $GetFile
cd WSA* || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] [FIN] go to WSL: WSA " >> $GetFile

echo $"$(date +%H:%M:%S): [START] [FIN] Copy Folder " >> $GetFile
cp -r * /mnt/c/wsa/wsamagisk || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] [FIN] Copy Folder " >> $GetFile

echo $"$(date +%H:%M:%S): [START] [FIN] Get_WSLFolderScripts function" >> $GetFile
Get_WSLFolderScripts
echo $"$(date +%H:%M:%S): [FINISH] [FIN] Get_WSLFolderScripts function" >> $GetFile

echo $"$(date +%H:%M:%S): [START] [FIN] go to EasierWsaInstaller/guiSupport folder" >> $GetFile
cd EasierWsaInstaller/guiSupport
echo $"$(date +%H:%M:%S): [START] [FIN] go to EasierWsaInstaller/guiSupport folder" >> $GetFile

echo $"$(date +%H:%M:%S): [START] [FIN] Script Copy [PS1]" >> $GetFile
sudo cp guiSupport.ps1 /mnt/c/wsa/wsamagisk/ || scriptabort
echo $"$(date +%H:%M:%S): [FINISH] [FIN] Script Copy [PS1]" >> $GetFile

echo $"$(date +%H:%M:%S): Quit Message" >> $GetFile

echo $"$yellow All transactions are finished. Please check the files in C: > wsa(/mnt/c/wsa) before deleting. $white"
echo $"$yellow Please check the folder mentioned above. If you have magisk installed, the name of the folder will be different. You can start it by entering the folder and double-clicking on the file named install. $white"

echo $"$(date +%Y_%m_%d-%H_%M_%S): Wait... 1" >> $GetFile
sleepwait 1
echo $"$(date +%Y_%m_%d-%H_%M_%S): [FORCE DELETE] /root/easierwsainstaller-project [?]" >> $GetFile
sudo rm -rf /root/easierwsainstaller-project
echo $"$(date +%Y_%m_%d-%H_%M_%S): Wait... 10" >> $GetFile
sleepwait 10
echo $"$(date +%Y_%m_%d-%H_%M_%S): [CLEAR & CLEAR]" >> $GetFile
clear & clear 
}
