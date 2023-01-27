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

echo "$(date +%H:%M:%S): [START] Get_WindowsFolder function" >> $GetFile
Get_WindowsFolder || scriptabort
echo "$(date +%H:%M:%S): [FINISH] Get_WindowsFolder function" >> $GetFile

echo "$(date +%H:%M:%S): [START] UNZIP & cd microsoftwsa" >> $GetFile
unzip -o Microsoft*WindowsSubsystemForAndroid*.msixbundle -d microsoftwsa && cd microsoftwsa || scriptabort
echo "$(date +%H:%M:%S): [FINISH] UNZIP & cd microsoftwsa" >> $GetFile

echo "$(date +%H:%M:%S): [START] [WSA.ARCH] UNZIP & cd wsa" >> $GetFile
unzip -o "WsaPackage_*_$msarch_*.msix" -d wsa || scriptabort 
echo "$(date +%H:%M:%S): [FINISH]  [WSA.ARCH] UNZIP & cd wsa" >> $GetFile

echo "$(date +%Y_%m_%d-%H_%M_%S): Wait... 0.5" >> $GetFile
sleepwait 0.5

echo "$(date +%H:%M:%S): [START] I'm clearing out unnecessary files" >> $GetFile
find . -maxdepth 1 ! -name WsaPackage_*_\$msarch_*.msix ! -name "wsa" ! -name . -exec rm -r {} \;
echo "$(date +%H:%M:%S): [FINISH] I'm clearing out unnecessary files" >> $GetFile

echo "$(date +%H:%M:%S): [START] go to wsa folder" >> $GetFile
cd wsa || scriptabort
echo "$(date +%H:%M:%S): [FINISH] go to wsa folder" >> $GetFile

echo "$(date +%H:%M:%S): [START] [XML,P7X | FORCE DELETE] I'm deleting the files I need to delete." >> $GetFile
rm -rf '[Content_Types].xml' AppxBlockMap.xml AppxSignature.p7x AppxMetadata || scriptabort
echo "$(date +%H:%M:%S): [FINISH] [XML,P7X | FORCE DELETE] I'm deleting the files I need to delete." >> $GetFile

echo "$(date +%H:%M:%S): [START] [WSAGAScript/IMAGES] I am moving image files." >> $GetFile
mv *.img /root/easierwsainstaller/scripts/WSAGAScript/#IMAGES/ || scriptabort
echo "$(date +%H:%M:%S): [FINISH] [WSAGAScript/IMAGES] I am moving image files." >> $GetFile

echo "$(date +%H:%M:%S): [START] Get_WindowsFolder function" >> $GetFile
Get_WindowsFolder || scriptabort
echo "$(date +%H:%M:%S): [FINISH] Get_WindowsFolder function" >> $GetFile

echo "$(date +%H:%M:%S): [START] I'm moving opengapps to the required location." >> $GetFile
mv open_gapps-$gappsarch-11.0*.zip /root/easierwsainstaller/scripts/WSAGAScript/#GAPPS/ || scriptabort
echo "$(date +%H:%M:%S): [FINISH] I'm moving opengapps to the required location." >> $GetFile

echo "$(date +%H:%M:%S): [START] Get_WSLFolderScripts function" >> $GetFile
Get_WSLFolderScripts || scriptabort
echo "$(date +%H:%M:%S): [FINISH] Get_WSLFolderScripts function" >> $GetFile

echo "$(date +%H:%M:%S): [START] Go to WSAGAScript folder" >> $GetFile
cd WSAGAScript || scriptabort
echo "$(date +%H:%M:%S): [FINISH] Go to WSAGAScript folder" >> $GetFile

echo "$(date +%H:%M:%S): [START] Make everything in the WSAGAScript folder executable." >> $GetFile
sudo chmod +x ./*.sh || find "$(pwd)" -iname "*.sh" -exec chmod +x "{}" \; || scriptabort
echo "$(date +%H:%M:%S): [FINISH] Make everything in the WSAGAScript folder executable." >> $GetFile

echo "$(date +%H:%M:%S): [IF] [START] Root set value and Architecture Value" >> $GetFile
if [[ $gappsarch == "x86_64" ]] && [[ $msarch == "x64" ]] && [[ $mskernel == "x86_64" ]]; then
echo "$(date +%H:%M:%S): [IF.x64] START" >> $GetFile
sed -ie 's+Root="$(pwd)"+Root="/root/easierwsainstaller/scripts/WSAGAScript"+i' VARIABLES.sh || scriptabort
echo "$(date +%H:%M:%S): [IF.x64] FINISH" >> $GetFile
fi
if [[ $gappsarch == "arm64" ]] && [[ $msarch == "ARM64" ]] && [[ $mskernel == "arm64" ]]; then
echo "$(date +%H:%M:%S): [IF.arm] START" >> $GetFile
sed -ie 's+Root="$(pwd)"+Root="/root/easierwsainstaller/scripts/WSAGAScript"+i' VARIABLES.sh || scriptabort
sed -ie 's+Architecture="x64"+Architecture="arm64"+i' VARIABLES.sh || scriptabort
echo "$(date +%H:%M:%S): [IF.arm] FINISH" >> $GetFile
fi
echo "$(date +%H:%M:%S): [IF] [FINISH] Root set value and Architecture Value " >> $GetFile

echo "$(date +%H:%M:%S): [START] Customers Product Name" >> $GetFile
sed -ie 's+TARGET_PRODUCT="redfin"+TARGET_PRODUCT='$WSAProductName'+i' apply.sh || scriptabort
sed -ie 's+TARGET_DEVICE="redfin"+TARGET_DEVICE='$WSAProductName'+i' apply.sh || scriptabort
echo "$(date +%H:%M:%S): [FINISH] Customers Product Name" >> $GetFile

echo "$(date +%H:%M:%S): [START] PART 1 SHELL" >> $GetFile
sudo ./extract_gapps_pico.sh && sudo ./extend_and_mount_images.sh || scriptabort
echo "$(date +%H:%M:%S): [FINISH] PART 1 SHELL" >> $GetFile

echo "$(date +%H:%M:%S): [IF] WSAAmazonRemove" >> $GetFile
if [ $WSAAmazonRemove == "true" ]; then
echo "$(date +%H:%M:%S): [START] FIND VALUES AND REMOVE" >> $GetFile
    find /mnt/product/{etc/permissions,etc/sysconfig,framework,priv-app} | grep -e amazon -e venezia | sudo xargs rm -rf
    echo "$(date +%H:%M:%S): [FINISH] FIND VALUES AND REMOVE" >> $GetFile
fi
echo "$(date +%H:%M:%S): [IF] [FINISH] WSAAmazonRemove" >> $GetFile

echo "$(date +%H:%M:%S): [START] PART 2 SHELL" >> $GetFile
sudo ./apply.sh && sudo ./unmount_images.sh || scriptabort
echo "$(date +%H:%M:%S): [FINISH] PART 2 SHELL" >> $GetFile

echo "$(date +%H:%M:%S): [START] [FIN] IMAGES .IMG MOVED WINDOWS-microsoftwsa/wsa/" >> $GetFile
mv \#IMAGES/*img /mnt/c/easierwsainstaller-project/microsoftwsa/wsa/ || scriptabort
echo "$(date +%H:%M:%S): [FINISH] [FIN] IMAGES .IMG MOVED WINDOWS-microsoftwsa/wsa/" >> $GetFile

echo "$(date +%H:%M:%S): [START] [FIN] Old Kernel Delete" >> $GetFile
sudo rm /mnt/c/easierwsainstaller-project/microsoftwsa/wsa/Tools/kernel || scriptabort
echo "$(date +%H:%M:%S): [FINISH] [FIN] Old Kernel Delete" >> $GetFile

echo "$(date +%H:%M:%S): [START] [FIN] New Kernel Copy" >> $GetFile
cp misc/kernel-$mskernel /mnt/c/easierwsainstaller-project/microsoftwsa/wsa/Tools/kernel || scriptabort
echo "$(date +%H:%M:%S): [FINISH] [FIN] New Kernel Copy" >> $GetFile

echo "$(date +%H:%M:%S): [START] [FIN] Checking in /mnt/c/wsa/$msarch. If full, it will be deleted." >> $GetFile
sudo mkdir -p /mnt/c/wsa
sudo rm -rf /mnt/c/wsa/$msarch
echo "$(date +%H:%M:%S): [FINISH] [FIN] Checking in /mnt/c/wsa/$msarch. If full, it will be deleted." >> $GetFile

echo "$(date +%H:%M:%S): [START] [FIN] mkdir $msarch " >> $GetFile
sudo mkdir -p /mnt/c/wsa/$msarch
echo "$(date +%H:%M:%S): [FINISH] [FIN] mkdir $msarch " >> $GetFile

echo "$(date +%H:%M:%S): [START] [FIN] Folder Moved wsa to $msarch folder" >> $GetFile
sudo mv /mnt/c/easierwsainstaller-project/microsoftwsa/wsa/* /mnt/c/wsa/$msarch/ || scriptabort
echo "$(date +%H:%M:%S): [FINISH] [FIN] Folder Moved wsa to $msarch folder" >> $GetFile

echo "$(date +%H:%M:%S): [START] [FIN] Get_WSLFolderScripts function" >> $GetFile
Get_WSLFolderScripts
echo "$(date +%H:%M:%S): [FINISH] [FIN] Get_WSLFolderScripts function" >> $GetFile

echo "$(date +%H:%M:%S): [START] [FIN] go to EasierWsaInstaller folder" >> $GetFile
cd EasierWsaInstaller
echo "$(date +%H:%M:%S): [START] [FIN] go to EasierWsaInstaller folder" >> $GetFile

echo "$(date +%H:%M:%S): [START] [FIN] Script Copy [PS1,BAT]" >> $GetFile
sudo cp install.ps1 /mnt/c/wsa/$msarch/ || scriptabort
sudo cp setup.bat /mnt/c/wsa/$msarch/ || scriptabort
echo "$(date +%H:%M:%S): [FINISH] [FIN] Script Copy [PS1,BAT]" >> $GetFile


echo "$(date +%H:%M:%S): Quit Message" >> $GetFile

echo $"$yellow All transactions are finished. Please check the files in C: > wsa(/mnt/c/wsa) before deleting. $white"
echo $"$yellow Please check the folder mentioned above. If you have magisk installed, the name of the folder will be different. You can start it by entering the folder and double-clicking on the file named install. $white"


echo "$(date +%Y_%m_%d-%H_%M_%S): Wait... 1" >> $GetFile
sleepwait 1
echo "$(date +%Y_%m_%d-%H_%M_%S): [FORCE DELETE] /root/easierwsainstaller-project [?]" >> $GetFile
sudo rm -rf /root/easierwsainstaller-project
echo "$(date +%Y_%m_%d-%H_%M_%S): Wait... 10" >> $GetFile
sleepwait 10
echo "$(date +%Y_%m_%d-%H_%M_%S): [CLEAR & CLEAR]" >> $GetFile
clear & clear
}