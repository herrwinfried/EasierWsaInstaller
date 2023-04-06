#!/bin/bash
function magiskonwsalocal_s {

LogFile_Create "magiskonwsalocal"



echo "$magenta checking the package $white"

LogFile_input_start "checking the package." # LOGGER
requirePackages
LogFile_input_finish "package check finished." # LOGGER

LogFile_input "[PIP] checking the package." # LOGGER
pip list --disable-pip-version-check | grep -E "^requests " >/dev/null 2>&1 || python3 -m pip install requests
LogFile_input "[PIP] package check finished." # LOGGER

LogFile_input_start "WSLFolder function" # LOGGER
WSLFolder
LogFile_input_finish "WSLFolder function" # LOGGER

LogFile_input_start "WindowsFolder function" # LOGGER
WindowsFolder
LogFile_input_finish "WindowsFolder function" # LOGGER

LogFile_input_start "scriptpip function" # LOGGER
scriptpip
LogFile_input_finish "scriptpip function" # LOGGER

LogFile_input_start "Get_WSLFolderScripts function" # LOGGER
Get_WSLFolderScripts
LogFile_input_finish "Get_WSLFolderScripts function" # LOGGER

LogFile_input_start "Go to EasierWsaInstaller" # LOGGER
cd EasierWsaInstaller
LogFile_input_finish "Go to EasierWsaInstaller" # LOGGER

LogFile_input_if_start "WSATools" # LOGGER
if [[ $WSATools == true ]]; then
LogFile_input_start "wsatoolspy function" # LOGGER
wsatoolspy || scriptabort
LogFile_input_finish "wsatoolspy function" # LOGGER
fi
LogFile_input_if_finish "WSATools" # LOGGER

echo "$magenta" "I'm doing the presets.""$white"

# DEBUG=--debug
# CUSTOM_MAGISK=--magisk-custom
echo "$yellow I'm adjusting the values ​​to be compatible with the magisk installation. $white"

LogFile_input_if_start "Change ARCH Value" # LOGGER  
if [[ $mskernel == "x86_64" ]]; then
ARCH="x64"
elif [[ $mskernel == "arm64" ]]; then
ARCH="arm64"
else
ARCH="x64"
fi
LogFile_input_if_finish "Change ARCH Value" # LOGGER  

LogFile_input_start "Change MAGISK_VER , GAPPS_BRAND, GAPPS_VARIANT Value" # LOGGER 
MAGISK_VER=$MagiskVersion

GAPPS_BRAND=$gappsSelect

GAPPS_VARIANT=$gappsvariant
LogFile_input_finish "Change MAGISK_VER , GAPPS_BRAND, GAPPS_VARIANT Value" # LOGGER 


LogFile_input_if_start "WSA RELEASE CHANGE" # LOGGER  
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
LogFile_input_if_start "WSA RELEASE CHANGE" # LOGGER  


LogFile_input_if_start "Amazon Store 0/1" # LOGGER  
if [[ $WSAAmazonRemove == "true" ]]; then

REMOVE_AMAZON="--remove-amazon"
else 
REMOVE_AMAZON=""
fi
LogFile_input_if_finish "Amazon Store 0/1" # LOGGER

LogFile_input_start "ROOT_SOL , COMPRESS_OUTPUT VALUE CHANGE" # LOGGER
ROOT_SOL="magisk"
COMPRESS_OUTPUT="" #"--compress"
LogFile_input_finish "ROOT_SOL , COMPRESS_OUTPUT VALUE CHANGE" # LOGGER

LogFile_input_start "CREATE COMMAND_LINE" # LOGGER
COMMAND_LINE=(--arch "$ARCH" --release-type "$RELEASE_TYPE" --magisk-ver "$MAGISK_VER" --gapps-brand "$GAPPS_BRAND" --gapps-variant "$GAPPS_VARIANT" "$REMOVE_AMAZON" --root-sol "$ROOT_SOL" "$COMPRESS_OUTPUT" "$OFFLINE" "$DEBUG" "$CUSTOM_MAGISK")
LogFile_input_finish "CREATE COMMAND_LINE" # LOGGER

LogFile_input_start "WSLFolder function" # LOGGER
WSLFolder || scriptabort
LogFile_input_finish "WSLFolder function" # LOGGER

LogFile_input_start "Get_WSLFolderScripts function" # LOGGER
Get_WSLFolderScripts || scriptabort
LogFile_input_finish "Get_WSLFolderScripts function" # LOGGER

LogFile_input_start "Go to MagiskOnWSALocal/scripts" # LOGGER
cd MagiskOnWSALocal && cd scripts || scriptabort
LogFile_input_finish "Go to MagiskOnWSALocal/scripts" # LOGGER

LogFile_input_start "Make everything in the WSAGAScript folder executable." # LOGGER
sudo chmod +x ./*.sh || find "$(pwd)" -iname "*.sh" -exec chmod +x "{}" \; || scriptabort
LogFile_input_finish "Make everything in the WSAGAScript folder executable." # LOGGER


LogFile_input_start "CUSTOMERS CHANGE SCRIPT" # LOGGER

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

LogFile_input_finish "CUSTOMERS CHANGE SCRIPT" # LOGGER

echo "$yellow Everything seems ready. After this stage, the control will now be in the magiskonwsalocal project. When the process is finished, I will perform the migration. $white"
LogFile_input "Wait... 3" # LOGGER
sleepwait 3
echo "COMMAND_LINE=${COMMAND_LINE[*]}"
LogFile_input "Wait... 2" # LOGGER
sleepwait 2
LogFile_input_start "./build.sh ${COMMAND_LINE[@]}" # LOGGER
./build.sh "${COMMAND_LINE[@]}" || scriptabort
LogFile_input_finish "./build.sh ${COMMAND_LINE[@]}" # LOGGER

LogFile_input_start "[FIN] Get_WSLFolderScripts function" # LOGGER
Get_WSLFolderScripts || scriptabort
LogFile_input_finish "[FIN] Get_WSLFolderScripts function" # LOGGER

LogFile_input_start "[FIN] Go to MagiskOnWSALocal/output" # LOGGER
cd MagiskOnWSALocal && cd output || scriptabort
LogFile_input_finish "[FIN] Go to MagiskOnWSALocal/output" # LOGGER

LogFile_input_start "[FIN] Checking in /mnt/c/wsa/wsamagisk. If full, it will be deleted." # LOGGER
sudo mkdir -p /mnt/c/wsa
sudo rm -rf /mnt/c/wsa/wsamagisk
LogFile_input_finish "[FIN] Checking in /mnt/c/wsa/wsamagisk. If full, it will be deleted." # LOGGER

LogFile_input_start "[FIN] mkdir wsamagisk " # LOGGER
sudo mkdir -p /mnt/c/wsa/wsamagisk
LogFile_input_finish "[FIN] mkdir wsamagisk " # LOGGER

LogFile_input_start "[FIN] go to WSL: WSA " # LOGGER
cd WSA* || scriptabort
LogFile_input_finish "[FIN] go to WSL: WSA " # LOGGER

LogFile_input_start "[FIN] Copy Folder " # LOGGER
cp -r * /mnt/c/wsa/wsamagisk || scriptabort
LogFile_input_finish "[FIN] Copy Folder " # LOGGER

LogFile_input_start "[FIN] Get_WSLFolderScripts function" # LOGGER
Get_WSLFolderScripts
LogFile_input_finish "[FIN] Get_WSLFolderScripts function" # LOGGER

LogFile_input_start "[FIN] go to EasierWsaInstaller/guiSupport folder" # LOGGER
cd EasierWsaInstaller/guiSupport
LogFile_input_start "[FIN] go to EasierWsaInstaller/guiSupport folder" # LOGGER

LogFile_input_start "[FIN] Script Copy [PS1]" # LOGGER
sudo cp guiSupport.ps1 /mnt/c/wsa/wsamagisk/ || scriptabort
LogFile_input_finish "[FIN] Script Copy [PS1]" # LOGGER

echo "$(date +%H:%M:%S): Quit Message" # LOGGER

echo "$yellow" "All transactions are finished. Please check the files in C: > wsa(/mnt/c/wsa) before deleting." "$white"
echo "$yellow" "Please check the folder mentioned above. If you have magisk installed, the name of the folder will be different. You can start it by entering the folder and double-clicking on the file named install." "$white"

LogFile_input "Wait... 1" # LOGGER
sleepwait 1
LogFile_input "[FORCE DELETE] /root/wsainstaller-files [?]" # LOGGER
sudo rm -rf /root/wsainstaller-files
LogFile_input "Wait... 10" # LOGGER
sleepwait 10
LogFile_input "[CLEAR & CLEAR]" # LOGGER
clear & clear 
}
