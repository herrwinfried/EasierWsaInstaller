#!/bin/bash

. ./varibles.sh
echo "$red""Version: "$green"""$SCRIPTVERSION""$white"

checkroot

###################
i=1;
j=$#;
while [ $i -le $j ]
do
n=$(echo $1 | tr '[:upper:]' '[:lower:]')

###HELP
if [[ $n == "--help" ]] || [[ $n == "-h" ]]; then
echo -e "
"$yellow"those selected by default are marked with [*]

"$green"Arch:
    "$yellow"--arch=x86_64
    "$cyan"[*]x86_64, arm

"$green"Method:
    "$yellow"--method=magiskonwsalocal
 "$cyan"[*]magiskonwsalocal                     Install Wsa using the MagiskOnWsaLocal project.
    "$cyan"wsagascript                          Install Wsa using the WSAGAScript project.
    "$cyan"onlywsa                              Download WSA without touching the contents of the file.

"$green"Gapps:
    "$yellow"--gapps=mindthegapps                 "$red"Onlywsa and wsagascript method is not supported.
 "$cyan"[*]mindthegapps                         Use MindTheGapps as Gapps. 
    "$cyan"opengapps                            Use OpenGapps as Gapps.
    "$red"If mindthegapps is selected, the username will be invalid/disabled.
    "$magenta"The wsagascript method will always have opengapps selected.

"$green"Opengapps variant:
    "$yellow"--variant=pico                       "$red"Onlywsa method is not supported.
    "$cyan"super, stock, full, mini, micro, nano, [*]pico

"$green"Customizations:
    "$yellow"--wsatools=no
    "$cyan"wsatools=yes                         Download WSATools
 "$cyan"[*]wsatools=no                          Do not download WSATools.

    "$yellow"--productname=redfin                 "$red"Onlywsa method is not supported.
    "$cyan"productname=NAME                     Set the product name name.
 "$cyan"[*]productname=redfin


    "$yellow"--amazonstore=no                     "$red"Onlywsa method is not supported.
    "$cyan"amazonstore=yes                      Remove amazon store.
 "$cyan"[*]amazonstore=no                       Don't remove amazon store.

"$green"WSA Release Options:
    "$yellow"--wsarelease=retail
    "$cyan"fast, slow, rp, [*]retail

"$green"Magisk Version Options:
    "$yellow"--magiskversion=stable               "$red"Onlywsa and wsagascript method is not supported.
    "$cyan"[*]stable, beta, canary, debug       

"$yellow"Example:
"$magenta" sudo ./install.sh --arch=x86_64 --method=magiskonwsalocal --variant=pico --wsatools=yes --productname=redfin --amazonstore=no --wsarelease=retail --magiskversion=stable

                                        $blue https://github.com/herrwinfried/EasierWsaInstaller $white
"
exit 1
###HELP FINISH

#ARM
elif [[ $n == "--arch=arm" ]] || [[ $n == "--arch=aarch64" ]] || [[ $n == "--arch=arm64" ]]; then
gappsarch=arm64
msarch=ARM64
mskernel=arm64
#ARM FINISH
elif [[ $n == "--arch=x86_64" ]] || [[ $n == "--arch=x64" ]] || [[ $n == "--arch=amd64" ]]; then
gappsarch=x86_64
msarch=x64
mskernel=x86_64
#x64 FINISH

################################GAPPS##########################################
elif [[ $n == "--gapps=opengapps" ]]; then
gappsSelect="OpenGApps"
elif [[ $n == "--gapps=mindthegapps" ]]; then
gappsSelect="MindTheGapps"
elif [[ $n == "--gapps="* ]]; then
echo "$red invalid value(gapps). MindTheGapps selected $white"
gappsSelect="MindTheGapps"
################################GAPPS FINISH##########################################

################################METHOD##########################################
elif [[ $n == "--method=onlywsa" ]]; then
onlywsa=true;
WSAGAScript=false;
MagiskWSA=false;
elif [[ $n == "--method=magiskonwsalocal" ]]; then
onlywsa=false;
WSAGAScript=false;
MagiskWSA=true;
elif [[ $n == "--method=wsagascript" ]]; then
onlywsa=false;
WSAGAScript=true;
MagiskWSA=false;
gappsSelect="opengapps"
################################METHOD FINISH##########################################

################################WSA RELEASE SELECT#####################################
elif [[ $n == "--wsarelease=fast" ]]; then
WSARelease=fast
elif [[ $n == "--wsarelease=slow" ]]; then
WSARelease=slow
elif [[ $n == "--wsarelease=rp" ]]; then
WSARelease=rp
elif [[ $n == "--wsarelease=retail" ]]; then
WSARelease=retail
elif [[ $n == "--wsarelease"* ]]; then
echo "$yellow invalid value(wsa release). retail selected $white"
WSARelease=retail
################################WSA RELEASE SELECT FINISH#####################################

################################MAGISK VERSION SELECT#####################################
elif [[ $n == "--magiskversion=stable" ]]; then
MagiskVersion=stable
elif [[ $n == "--magiskversion=beta" ]]; then
MagiskVersion=beta
elif [[ $n == "--magiskversion=canary" ]]; then
MagiskVersion=canary
elif [[ $n == "--magiskversion=debug" ]]; then
MagiskVersion=debug
elif [[ $n == "--magiskversion=release" ]]; then
MagiskVersion=release
elif [[ $n == "--magiskversion"* ]]; then
echo "$yellow invalid value(magisk version). stable has been selected $white"
MagiskVersion=stable
################################MAGISK VERSION SELECT FINISH#####################################

################################Amazon store SELECT#####################################
elif [[ $n == "--amazonstore=yes" ]]; then
WSAAmazonRemove=true
elif [[ $n == "--amazonstore=no" ]]; then
WSAAmazonRemove=false
elif [[ $n == "--amazonstore"* ]]; then
echo "$yellow invalid value (amazon store). Not Uninstall selected $white"
WSAAmazonRemove=false
################################Amazon store SELECT FINISH#####################################+

################################WSATOOL SELECT#####################################
elif [[ $n == "--wsatools=yes" ]]; then
WSATools=true
elif [[ $n == "--wsatools=no" ]]; then
WSATools=false
elif [[ $n == "--wsatools"* ]]; then
echo "$red invalid value(wsatools). Keep Not Installed selected $white"
WSATools=false
################################WSATOOL SELECT FINISH#####################################

################################PRODUCT NAME SELECT#####################################
elif [[ $n == "--productname" ]]; then
echo "$yellow invalid value(product name). value: redfin $white"
WSAProductName=redfin
elif [[ $n == "--productname="* ]]; then
WSAProductName1=$(equalcommand $1)
WSAProductName=$(scriptregex $WSAProductName1)
################################PRODUCT NAME FINISH#####################################

################################GAPPS SELECT#####################################
elif [[ $n == "--variant=super" ]]; then
gappsvariant=super
elif [[ $n == "--variant=stock" ]]; then
gappsvariant=stock
elif [[ $n == "--variant=full" ]]; then
gappsvariant=full
elif [[ $n == "--variant=mini" ]]; then
gappsvariant=mini
elif [[ $n == "--variant=micro" ]]; then
gappsvariant=micro
elif [[ $n == "--variant=nano" ]]; then
gappsvariant=nano
elif [[ $n == "--variant=pico" ]]; then
gappsvariant=pico
elif [[ $n == "--variant"* ]]; then
echo "$yellow invalid value(variant). Pico selected $white"
gappsvariant=pico
################################GAPPS SELECT FINISH #####################################
elif [[ $n == "--pc" ]]; then
NotWSL=true
if [ "$(echo $(cat /proc/cpuinfo | grep -m1 microcode | cut -f2 -d:))" != "0xffffffff" ]; then

echo "You have removed WSL Lock with this command. In this way, the script will run. However, you should know that this script was written according to WSL."
fi
    else
    echo "$red Invalid argument-$i: $n $white";
    fi
    i=$((i + 1));
    shift 1;
done

function scriptabort(){
echo "$red An error has occurred, the transaction has been cancelled, Please check your last step. Automatically the process will be terminated in 60 seconds $white"
sleepwait 60
exit 1
}
if [ $NotWSL == false ]; then 
wslcheck
fi


function scriptpip(){
    if [[ -x "$(command -v pip3)" ]]; then
echo "$yellow""Downloading necessary pip packages. $white"
sleepwait 0.5
python3 -m pip install requests
python3 -m pip install BeautifulSoup4
python3 -m pip install lxml
python3 -m pip install wget
else
echo "$red pip3 Not Found. The operation is being cancelled. $white"
exit 1
fi
}
function WSLFolder() {
if [ -d /root/wsainstaller-files ]; then

echo "$yellow WSLFolder found. $white"
cd /root && cd wsainstaller-files
echo "$yellow I am deleting all the files in it. $white"
sudo rm -rf /root/wsainstaller-files/*
else
echo "$green The necessary folder for the linux(wsl) part has been created. $white"
cd /root/ && mkdir wsainstaller-files && cd wsainstaller-files || scriptabort
fi
sleepwait 5

}

function WindowsFolder() {
    if [ -d /mnt/c/wsainstaller-files ]; then
echo "$yellow WindowsFolder found. $white"
cd /mnt/c/ && cd wsainstaller-files
echo "$yellow I am deleting all the files in it. $white"
sudo rm -rf /mnt/c/wsainstaller-files/*
else
echo "$green The necessary folder for the windows part has been created. $white"
cd /mnt/c/ && mkdir wsainstaller-files && cd wsainstaller-files || scriptabort
fi
sleepwait 5
}

function Get_WSLFolder() {
cd /root/ && cd wsainstaller-files || scriptabort
}

function Get_WSLFolderBashScript() {
cd /root/ && cd easierwsainstaller && cd src && cd EasierWsaInstaller || scriptabort
}
function Get_WSLFolderPython() {
cd /root/ && cd easierwsainstaller && cd src && cd EasierWsaInstaller || scriptabort
}
function Get_WSLFolderPowershell() {
cd /root/ && cd easierwsainstaller && cd src && cd EasierWsaInstaller || scriptabort
}
function Get_WSLFolderScripts() {
cd /root/ && cd easierwsainstaller && cd src || scriptabort
}

function Get_WindowsFolder() {
echo "$yellow I go into the Get_WindowsFolder folder. $white"
cd /mnt/c/ && cd wsainstaller-files || scriptabort
echo "$yellow I went into the Get_WindowsFolder folder. $white" 
}
function wsapy() {
        if [[ -x "$(command -v python3)" ]]; then
        echo "$magenta""I will install WSA $white"
    python3 ./wsa.py -r $wsarelease
    echo echo "$green Download completed, moving to required location $white"
sudo mv Microsoft*WindowsSubsystemForAndroid*.msixbundle /mnt/c/wsainstaller-files/
    else 
echo "$red python3 Not Found. The operation is being cancelled. $white"
exit 1
fi
}

function wsatoolspy() {
    if [[ -x "$(command -v python3)" ]]; then
    echo "$blue""I will install WSATools $white"
    python3 ./wsatools.py
 echo echo "$green Download completed, moving to required location $white"
sudo rm -rf /mnt/c/wsainstaller-files/54406Simizfo.WSATools*.msixbundle
sleepwait 2
sudo mv 54406Simizfo.WSATools*.msixbundle /mnt/c/wsainstaller-files/WSATools.msixbundle
else 
echo "$red python3 Not Found. The operation is being cancelled. $white"
exit 1
fi
}

function opengappspy() {
    if [[ -x "$(command -v python3)" ]]; then
    echo "$green""I will install OpenGAPPS $white"
python3 ./opengapps.py -a $gappsarch -va $gappsvariant
 echo echo "$green Download completed, moving to required location $white"
sudo mv open_gapps-$gappsarch-*.zip /mnt/c/wsainstaller-files/
    else 
echo "$red python3 Not Found. The operation is being cancelled. $white"
exit 1
    fi
}

if [[ $MagiskWSA == true ]]; then
. ./magiskonwsalocal.sh
magiskonwsalocal_s

elif [[ $WSAGAScript == true ]]; then
. ./wsagascript.sh
wsagascript_s

elif [[ $onlywsa == true ]]; then
. ./onlywsa.sh
onlywsa_s

else
scriptabort
fi