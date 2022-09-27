#!/bin/bash
function magiskonwsamethod_d () {
    echo "$green [Magisk] $info_vv_ss"
    requirePackage_magisk
echo "$green [Magisk] $yellow Before I start, I make the necessary adjustments to pip. $white"
    pip list --disable-pip-version-check | grep -E "^requests " >/dev/null 2>&1 || python3 -m pip install requests
    scriptpip || abort
echo "$green [Magisk] $yellow I'm making winetrick adjustments. $white"
winetricks list-installed | grep -E "^msxml6" >/dev/null 2>&1 || {
    echo "$green [Magisk] $red [winetricks.1.0] $yellow [...] $white"
    cp -r ../wine/.cache/* ~/.cache
     echo "$green [Magisk] $red [winetricks.2.0] $yellow [...] $white"
    winetricks msxml6 || abort
}
# DEBUG=--debug
# CUSTOM_MAGISK=--magisk-custom
echo "$green [Magisk] $yellow I'm adjusting the values ​​to be compatible with the magisk installation. $white"
if [[ $mskernel == "x86_64" ]]; then
ARCH="x64"

elif [[ $mskernel == "arm64" ]]; then
ARCH="arm64"
else
ARCH="x64"
fi

MAGISK_VER=$MagiskVersion
GAPPS_BRAND="OpenGApps"
GAPPS_VARIANT=$gappsvariant
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

if [[ $WSAAmazonRemove == "true" ]]; then

REMOVE_AMAZON="--remove-amazon"
else 
REMOVE_AMAZON=""
fi

ROOT_SOL="magisk"
COMPRESS_OUTPUT="" #"--compress"

if [[ $WSATools == true ]]; then
Get_WSLFolderScripts || scriptabort
echo "$green {MAGISK} $red WSATOOLS $white"
wsatoolspy || scriptabort
echo "$green {MAGISK} $red WSATOOLS Done $white"

fi

sleepwait 2
COMMAND_LINE=(--arch "$ARCH" --release-type "$RELEASE_TYPE" --magisk-ver "$MAGISK_VER" --gapps-brand "$GAPPS_BRAND" --gapps-variant "$GAPPS_VARIANT" "$REMOVE_AMAZON" --root-sol "$ROOT_SOL" "$COMPRESS_OUTPUT" "$OFFLINE" "$DEBUG" "$CUSTOM_MAGISK")
echo "COMMAND_LINE=${COMMAND_LINE[*]}"
sleepwait 2
echo "[Magisk] $green I am running a WSLFolder function. [Preparation]$white"
WSLFolder || scriptabort
echo "[Magisk] $green I am running a Get_WSLFolderScripts function. [Preparation] $white"
Get_WSLFolderScripts || scriptabort
echo "[Magisk] Go to MagiskOnWSALocal/scripts folder [Preparation] $white"
cd MagiskOnWSALocal && cd scripts || scriptabort
echo "[Magisk] Make everything in the MagiskOnWSALocal/scripts folder executable. [Preparation] $white"
sudo chmod +x ./*.sh || find "$(pwd)" -iname "*.sh" -exec chmod +x "{}" \; || scriptabort
echo "$red Everything seems ready. After this stage, the control will now be in the magiskonwsalocal project. When the process is finished, I will perform the migration. $white [Magisk] [Ready!]"
#
sed -ie 's+# export TMPDIR=$(dirname "$PWD")/WORK_DIR_+export TMPDIR=$(dirname "$PWD")/WORK_DIR_+i' build.sh || scriptabort
sed -ie 's+("build", "product"): "redfin"+("build", "product"): "'$WSAProductName'"+i' fixGappsProp.py || scriptabort
sed -ie 's+("product", "name"): "redfin"+("product", "name"): "'$WSAProductName'"+i' fixGappsProp.py || scriptabort
sed -ie 's+("product", "device"): "redfin"+("product", "device"): "'$WSAProductName'"+i' fixGappsProp.py || scriptabort
sed -ie 's+("build", "flavor"): "redfin-user"+("build", "flavor"): "'$WSAProductName'-user"+i' fixGappsProp.py || scriptabort

echo "$red [Magisk.0.0] $white"

sleepwait 2
./build.sh "${COMMAND_LINE[@]}" || scriptabort
#################################3
echo "$red [Magisk] $green I am running a Get_WSLFolderScripts function. $white"
Get_WSLFolderScripts || scriptabort
echo "$red [Magisk] $green Go to MagiskOnWSALocal folder. $white"
cd MagiskOnWSALocal || scriptabort
echo "$red [Magisk] $green Go to MagiskOnWSALocal/output folder. $white"
cd output || scriptabort
echo "$red [Magisk] $green Open the file and move it where needed. $white"
sudo mkdir -p /mnt/c/wsa
echo "$red [Magisk] $green [0] $white"
sudo rm -rf /mnt/c/wsa/wsamagisk
echo "$red [Magisk] $green [1] $white"
sudo mkdir -p /mnt/c/wsa/wsamagisk
echo "$red [Magisk] $green [2] $white"
sudo rm -rf /mnt/c/wsa/wsamagisk/*
echo "$red [Magisk] $green [3] $white"
cd WSA-with-magisk* || scriptabort
echo "$red [Magisk] $green [4] $white"
cp -r * /mnt/c/wsa/wsamagisk || scriptabort

#############################7Z##############################################
#7z x -y WSA-with-magisk* -o/mnt/c/wsa/wsamagisk -r || scriptabort          #
#cd /mnt/c/wsa/wsamagisk/WSA* || scriptabort                                #
#mv * /mnt/c/wsa/wsamagisk || scriptabort                                   #
#############################7Z##############################################

echo "$green [Magisk] $white [PRE-FINISH]"
echo "$green [Magisk] $yellow go to powershell folder $white [PRE-FINISH]"
Get_WSLFolderPowershell || scriptabort
echo "$green [Magisk] $yellow necessary files are copied. [0] $white [PRE-FINISH]"
sudo cp guiinstall.ps1 /mnt/c/wsa/wsamagisk || scriptabort

sleepwait 5
echo $notonlywsa2
sleepwait 5
echo $notifwsa
sleepwait 5
}