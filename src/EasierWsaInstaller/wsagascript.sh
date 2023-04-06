#!/bin/bash
function wsagascript_s {

LogFile_Create "wsagascript"

echo "$magenta checking the package $white"
LogFile_input_start "checking the package." # LOGGER
requirePackages
LogFile_input_finish "package check finished." # LOGGER

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

LogFile_input_start "wsapy function" # LOGGER
wsapy || scriptabort
LogFile_input_finish "wsapy function" # LOGGER

LogFile_input_start "opengappspy function" # LOGGER
opengappspy || scriptabort
LogFile_input_finish "opengappspy function" # LOGGER

LogFile_input_start "Get_WindowsFolder function" # LOGGER
Get_WindowsFolder || scriptabort
LogFile_input_finish "Get_WindowsFolder function" # LOGGER

LogFile_input_start "UNZIP & cd microsoftwsa" # LOGGER
unzip -o Microsoft*WindowsSubsystemForAndroid*.msixbundle -d microsoftwsa && cd microsoftwsa || scriptabort
LogFile_input_finish "UNZIP & cd microsoftwsa" # LOGGER

LogFile_input_start "[WSA.ARCH] UNZIP & cd wsa" # LOGGER
unzip -o "WsaPackage_*_$msarch_*.msix" -d wsa || scriptabort 
LogFile_input_finish " [WSA.ARCH] UNZIP & cd wsa" # LOGGER

LogFile_input "Wait... 0.5" # LOGGER
sleepwait 0.5

LogFile_input_start "I'm clearing out unnecessary files" # LOGGER
find . -maxdepth 1 ! -name WsaPackage_*_\$msarch_*.msix ! -name "wsa" ! -name . -exec rm -r {} \;
LogFile_input_finish "I'm clearing out unnecessary files" # LOGGER

LogFile_input_start "go to wsa folder" # LOGGER
cd wsa || scriptabort
LogFile_input_finish "go to wsa folder" # LOGGER

LogFile_input_start "[XML,P7X | FORCE DELETE] I'm deleting the files I need to delete." # LOGGER
rm -rf '[Content_Types].xml' AppxBlockMap.xml AppxSignature.p7x AppxMetadata || scriptabort
LogFile_input_finish "[XML,P7X | FORCE DELETE] I'm deleting the files I need to delete." # LOGGER

LogFile_input_start "[WSAGAScript/IMAGES] I am moving image files." # LOGGER
mv *.img /root/easierwsainstaller/src/WSAGAScript/#IMAGES/ || scriptabort
LogFile_input_finish "[WSAGAScript/IMAGES] I am moving image files." # LOGGER

LogFile_input_start "Get_WindowsFolder function" # LOGGER
Get_WindowsFolder || scriptabort
LogFile_input_finish "Get_WindowsFolder function" # LOGGER

LogFile_input_start "I'm moving opengapps to the required location." # LOGGER
mv open_gapps-$gappsarch-11.0*.zip /root/easierwsainstaller/src/WSAGAScript/#GAPPS/ || scriptabort
LogFile_input_finish "I'm moving opengapps to the required location." # LOGGER

LogFile_input_start "Get_WSLFolderScripts function" # LOGGER
Get_WSLFolderScripts || scriptabort
LogFile_input_finish "Get_WSLFolderScripts function" # LOGGER

LogFile_input_start "Go to WSAGAScript folder" # LOGGER
cd WSAGAScript || scriptabort
LogFile_input_finish "Go to WSAGAScript folder" # LOGGER

LogFile_input_start "Make everything in the WSAGAScript folder executable." # LOGGER
sudo chmod +x ./*.sh || find "$(pwd)" -iname "*.sh" -exec chmod +x "{}" \; || scriptabort
LogFile_input_finish "Make everything in the WSAGAScript folder executable." # LOGGER

LogFile_input_if_start " [START] Root set value and Architecture Value" # LOGGER
if [[ $gappsarch == "x86_64" ]] && [[ $msarch == "x64" ]] && [[ $mskernel == "x86_64" ]]; then
LogFile_input "[IF.x64] START" # LOGGER
sed -ie 's+Root="$(pwd)"+Root="/root/easierwsainstaller/src/WSAGAScript"+i' VARIABLES.sh || scriptabort
LogFile_input "[IF.x64] FINISH" # LOGGER
fi
if [[ $gappsarch == "arm64" ]] && [[ $msarch == "ARM64" ]] && [[ $mskernel == "arm64" ]]; then
LogFile_input "[IF.arm] START" # LOGGER
sed -ie 's+Root="$(pwd)"+Root="/root/easierwsainstaller/src/WSAGAScript"+i' VARIABLES.sh || scriptabort
sed -ie 's+Architecture="x64"+Architecture="arm64"+i' VARIABLES.sh || scriptabort
LogFile_input "[IF.arm] FINISH" # LOGGER
fi
LogFile_input_if_finish "Root set value and Architecture Value " # LOGGER

LogFile_input_start "Customers Product Name" # LOGGER
sed -ie 's+TARGET_PRODUCT="redfin"+TARGET_PRODUCT='$WSAProductName'+i' apply.sh || scriptabort
sed -ie 's+TARGET_DEVICE="redfin"+TARGET_DEVICE='$WSAProductName'+i' apply.sh || scriptabort
LogFile_input_finish "Customers Product Name" # LOGGER

LogFile_input_start "PART 1 SHELL" # LOGGER
sudo ./extract_gapps_pico.sh && sudo ./extend_and_mount_images.sh || scriptabort
LogFile_input_finish "PART 1 SHELL" # LOGGER

LogFile_input_if_start " WSAAmazonRemove" # LOGGER
if [ $WSAAmazonRemove == "true" ]; then
LogFile_input_start "FIND VALUES AND REMOVE" # LOGGER
    find /mnt/product/{etc/permissions,etc/sysconfig,framework,priv-app} | grep -e amazon -e venezia | sudo xargs rm -rf
    LogFile_input_finish "FIND VALUES AND REMOVE" # LOGGER
fi
LogFile_input_if_finish "WSAAmazonRemove" # LOGGER

LogFile_input_start "PART 2 SHELL" # LOGGER
sudo ./apply.sh && sudo ./unmount_images.sh || scriptabort
LogFile_input_finish "PART 2 SHELL" # LOGGER

LogFile_input_start "[FIN] IMAGES .IMG MOVED WINDOWS-microsoftwsa/wsa/" # LOGGER
mv \#IMAGES/*img /mnt/c/wsainstaller-files/microsoftwsa/wsa/ || scriptabort
LogFile_input_finish "[FIN] IMAGES .IMG MOVED WINDOWS-microsoftwsa/wsa/" # LOGGER

LogFile_input_start "[FIN] Old Kernel Delete" # LOGGER
sudo rm /mnt/c/wsainstaller-files/microsoftwsa/wsa/Tools/kernel || scriptabort
LogFile_input_finish "[FIN] Old Kernel Delete" # LOGGER

LogFile_input_start "[FIN] New Kernel Copy" # LOGGER
cp misc/kernel-$mskernel /mnt/c/wsainstaller-files/microsoftwsa/wsa/Tools/kernel || scriptabort
LogFile_input_finish "[FIN] New Kernel Copy" # LOGGER

LogFile_input_start "[FIN] Checking in /mnt/c/wsa/$msarch. If full, it will be deleted." # LOGGER
sudo mkdir -p /mnt/c/wsa
sudo rm -rf /mnt/c/wsa/$msarch
LogFile_input_finish "[FIN] Checking in /mnt/c/wsa/$msarch. If full, it will be deleted." # LOGGER

LogFile_input_start "[FIN] mkdir $msarch " # LOGGER
sudo mkdir -p /mnt/c/wsa/$msarch
LogFile_input_finish "[FIN] mkdir $msarch " # LOGGER

LogFile_input_start "[FIN] Folder Moved wsa to $msarch folder" # LOGGER
sudo mv /mnt/c/wsainstaller-files/microsoftwsa/wsa/* /mnt/c/wsa/$msarch/ || scriptabort
LogFile_input_finish "[FIN] Folder Moved wsa to $msarch folder" # LOGGER

LogFile_input_start "[FIN] Get_WSLFolderScripts function" # LOGGER
Get_WSLFolderScripts
LogFile_input_finish "[FIN] Get_WSLFolderScripts function" # LOGGER

LogFile_input_start "[FIN] go to EasierWsaInstaller folder" # LOGGER
cd EasierWsaInstaller
LogFile_input_start "[FIN] go to EasierWsaInstaller folder" # LOGGER

LogFile_input_start "[FIN] Script Copy [PS1,BAT]" # LOGGER
sudo cp install.ps1 /mnt/c/wsa/$msarch/ || scriptabort
sudo cp setup.bat /mnt/c/wsa/$msarch/ || scriptabort
LogFile_input_finish "[FIN] Script Copy [PS1,BAT]" # LOGGER


LogFile_input "Quit Message" # LOGGER

echo "$yellow" "All transactions are finished. Please check the files in C: > wsa(/mnt/c/wsa) before deleting.""$white"
echo "$yellow" "Please check the folder mentioned above. If you have magisk installed, the name of the folder will be different. You can start it by entering the folder and double-clicking on the file named install.""$white"


LogFile_input "Wait... 1" # LOGGER
sleepwait 1
LogFile_input "[FORCE DELETE] /root/wsainstaller-files [?]" # LOGGER
sudo rm -rf /root/wsainstaller-files
LogFile_input "Wait... 10" # LOGGER
sleepwait 10
LogFile_input "[CLEAR & CLEAR]" # LOGGER
clear & clear
}