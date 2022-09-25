function wsagascriptmethod_d() {
echo "$green [WSAGAScript] $info_vv_ss"
requirePackage_normal

echo "$green [WSAGAScript] $white"
WSLFolder
echo "$green [WSAGAScript] $white"
WindowsFolder
echo "$green [WSAGAScript] $white"
scriptpip
echo "$green [WSAGAScript] $white"
Get_WSLFolderScripts
if [[ $WSATools == true ]]; then
echo "$green {WSAGAScript} $red WSATOOLS $white"
wsatoolspy || scriptabort
echo "$green {WSAGAScript} $red WSATOOLS Done $white"
fi
echo "$green [WSAGAScript] $white"
wsapy
echo "$green [WSAGAScript] $white"
opengappspy
echo "$green [WSAGAScript] $white"
Get_WindowsFolder
echo "$green [WSAGAScript] $white"

sleepwait 1
echo "$green [WSAGAScript] $yellow wsa.msixbundle is extracting. $red [Preparation] $white"
#+++++++++++++++++----------------------Expact WSA-------++++++++++++++++
unzip -o Microsoft*WindowsSubsystemForAndroid*.msixbundle -d microsoftwsa && cd microsoftwsa || scriptabort
echo "$green [WSAGAScript] $yellow wsa.msixbundle done $red [Preparation] $white"
echo "$green [WSAGAScript] $cyan wsa[ARCH] is extracting $red [Preparation] $white"
unzip -o "WsaPackage_*_$msarch_*.msix" -d wsa || scriptabort 
echo "$green [WSAGAScript] $cyan wsa[ARCH] done $red [Preparation] $white"
sleepwait 0.5
echo "$green [WSAGAScript] $yellow I'm clearing out unnecessary files. $red [Preparation] $white"

find . -maxdepth 1 ! -name WsaPackage_*_\$msarch_*.msix ! -name "wsa" ! -name . -exec rm -r {} \;
echo "$green [WSAGAScript] $yellow I go into the folder named wsa. $red [Preparation] $white"
cd wsa || scriptabort
echo "$green [WSAGAScript] $yellow I went into the folder. $red [Preparation] $white"
sleepwait 0.5
echo "$green [WSAGAScript] $yellow I'm deleting the files I need to delete. $red [Preparation] $white"
rm -rf '[Content_Types].xml' AppxBlockMap.xml AppxSignature.p7x AppxMetadata || scriptabort
echo "$green [WSAGAScript] $yellow Process completed. $red [Preparation] $white"
#
echo "$yellow [WSAGAScript] $green I am moving image files. $red [Preparation] $white"
mv *.img /root/wsa-script/scripts/WSAGAScript/#IMAGES/ || scriptabort
echo "$yellow [WSAGAScript] $green I moved the image files. $red [Preparation] $white"
echo "$yellow [WSAGAScript] $green I am running a Get_WindowsFolder function. [Preparation] $white"
Get_WindowsFolder
echo "$yellow [WSAGAScript] $white"
echo "$yellow [WSAGAScript] $green I'm moving opengapps to the required location. [Preparation] $white"
mv open_gapps-$gappsarch-11.0*.zip /root/wsa-script/scripts/WSAGAScript/#GAPPS/ || scriptabort
echo "$yellow [WSAGAScript] $green I moved it where needed. [Preparation] $white"
#+++++++++++++++++-------------------------Config WSAGAScript------------------++++++++++++++++
echo "$red [WSAGAScript] $green I am running a Get_WSLFolderScripts function. [Preparation] $white"
Get_WSLFolderScripts
echo "$red [WSAGAScript] $white"
echo "$red [WSAGAScript] $green Go to WSAGAScript folder. [Preparation] $white"
cd WSAGAScript || scriptabort
echo "$red [WSAGAScript] $green Make everything in the WSAGAScript folder executable. [Preparation] $white"
sudo chmod +x ./*.sh || find "$(pwd)" -iname "*.sh" -exec chmod +x "{}" \; || scriptabort
echo "$red [WSAGAScript] $green I make the necessary adjustments. [Preparation] $white"

    if [[ $gappsarch == "x86_64" ]] && [[ $msarch == "x64" ]] && [[ $mskernel == "x86_64" ]]; then
sed -ie 's+Root="$(pwd)"+Root="/root/wsa-script/scripts/WSAGAScript"+i' VARIABLES.sh || scriptabort
fi

 if [[ $gappsarch == "arm64" ]] && [[ $msarch == "ARM64" ]] && [[ $mskernel == "arm64" ]]; then
sed -ie 's+Root="$(pwd)"+Root="/root/wsa-script/scripts/WSAGAScript"+i' VARIABLES.sh || scriptabort
sed -ie 's+Architecture="x64"+Architecture="arm64"+i' VARIABLES.sh || scriptabort
fi
### 
echo "$red [WSAGAScript] $green I'm adjusting the naming. [Preparation] $white"
sed -ie 's+TARGET_PRODUCT="redfin"+TARGET_PRODUCT='$WSAProductName'+i' apply.sh || scriptabort
sed -ie 's+TARGET_DEVICE="redfin"+TARGET_DEVICE='$WSAProductName'+i' apply.sh || scriptabort

echo "$yellow It looks ready now. $green [WSAGAScript] $white [READY!]"
sleep 1
##
#########################################################----------------------------++++++++++++++++++++++++++++++++++++
echo "$green [WSAGAScript] $white [START!]"
sudo ./extract_gapps_pico.sh && sudo ./extend_and_mount_images.sh || scriptabort

if [ $WSAAmazonRemove == "true" ]; then
echo "$yellow I am deleting amazon store. $green [WSAGAScript] $white [+_+]"
    find /mnt/product/{etc/permissions,etc/sysconfig,framework,priv-app} | grep -e amazon -e venezia | sudo xargs rm -rf
    echo "$red done $green [WSAGAScript] $white [+_+]"
fi
echo "$green [WSAGAScript] $white [...]"
sudo ./apply.sh && sudo ./unmount_images.sh || scriptabort
echo "$green [WSAGAScript] $yellow The operation seems successful. $white [PRE-FINISH]"

echo "$green [WSAGAScript] $yellow image files are moved to the required location. $white [PRE-FINISH]"
mv \#IMAGES/*img /mnt/c/wsaproject/microsoftwsa/wsa/ || scriptabort
echo "$green [WSAGAScript] $yellow image files have been moved. $white [PRE-FINISH]"

echo "$green [WSAGAScript] $yellow old kernel is deleted. $white [PRE-FINISH]"
sudo rm /mnt/c/wsaproject/microsoftwsa/wsa/Tools/kernel || scriptabort
echo "$green [WSAGAScript] $yellow old kernel deleted. The new kernel is migrated. $white [PRE-FINISH]"
cp misc/kernel-$mskernel /mnt/c/wsaproject/microsoftwsa/wsa/Tools/kernel || scriptabort

echo "$green [WSAGAScript] $yellow Checking in /mnt/c/wsa/$msarch. If full, it will be deleted. $white [PRE-FINISH]"
sudo rm -rf /mnt/c/wsa/$msarch || scriptabort
echo "$green [WSAGAScript] $yellow Checking in /mnt/c/wsa/$msarch. If None, it will be created. $white [PRE-FINISH]"
sudo mkdir -p /mnt/c/wsa/$msarch || scriptabort
echo "$green [WSAGAScript] $yellow wsa is moving. $white [PRE-FINISH]"
sudo mv /mnt/c/wsaproject/microsoftwsa/wsa/* /mnt/c/wsa/$msarch/ || scriptabort
echo "$green [WSAGAScript] $yellow I am running a Get_WSLFolderScripts function. $white [PRE-FINISH]"
Get_WSLFolderScripts || scriptabort
echo "$green [WSAGAScript] $white [PRE-FINISH]"
echo "$green [WSAGAScript] $yellow go to powershell folder $white [PRE-FINISH]"
cd powershell || scriptabort
echo "$green [WSAGAScript] $yellow necessary files are copied. [0] $white [PRE-FINISH]"
sudo cp install.ps1 /mnt/c/wsa/$msarch/ || scriptabort
echo "$green [WSAGAScript] $yellow I am running a Get_WSLFolderScripts function. $white [PRE-FINISH]"
Get_WSLFolderScripts || scriptabort
echo "$green [WSAGAScript] $yellow go to batch folder $white [PRE-FINISH]"
cd batch || scriptabort
echo "$green [WSAGAScript] $yellow necessary files are copied. [1] $white [PRE-FINISH]"
sudo cp setup.bat /mnt/c/wsa/$msarch/ || scriptabort

echo $notonlywsa2
sleep 5
echo $notifwsa
sleep 5
}