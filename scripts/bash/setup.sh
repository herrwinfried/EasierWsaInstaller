#!/bin/bash

. ./wsascript-varibles.sh
onlywsl
checkroot
requirePackage
###################
i=1;
j=$#;
while [ $i -le $j ]
do
#ARM
if [[ $1 == "--arm" ]]; then
gappsarch=arm64
msarch=ARM64
mskernel=arm64
#ARM 0

################################language SELECT#####################################
elif [[ $1 == "--lang=en" ]] || [[ $1 == "--lang=en-US" ]]; then
Language=en_US
GetMessage
elif [[ $1 == "--lang=tr" ]]; then
Language=tr
GetMessage
elif [[ $1 == "--lang=de" ]] || [[ $1 == "--lang=de-DE" ]]; then
Language=de_DE
GetMessage
elif [[ $1 == "--wsatools"* ]]; then
echo "$red invalid value(language). English selected $white"
Language=en_US
GetMessage
################################language FINISH#####################################


################################METHOD##########################################
elif [[ $1 == "--onlywsa" ]]; then
onlywsa=true;
WSAGAScript=false;
MagiskWSA=false;
elif [[ $1 == "--magisk" ]]; then
onlywsa=false;
WSAGAScript=false;
MagiskWSA=true;
elif [[ $1 == "--wsagascript" ]]; then
onlywsa=false;
WSAGAScript=true;
MagiskWSA=false;
################################METHOD FINISH##########################################

################################WSA RELEASE SELECT#####################################
elif [[ $1 == "--wsarelease=fast" ]]; then
WSARelease=fast
elif [[ $1 == "--wsarelease=slow" ]]; then
WSARelease=slow
elif [[ $1 == "--wsarelease=rp" ]] || [[ $1 == "--wsarelease=RP" ]]; then
WSARelease=rp
elif [[ $1 == "--wsarelease=retail" ]]; then
WSARelease=retail
elif [[ $1 == "--wsarelease"* ]]; then
echo $invalidwsarelease
WSARelease=retail
################################WSA RELEASE SELECT FINISH#####################################

################################MAGISK VERSION SELECT#####################################
elif [[ $1 == "--magiskversion=stable" ]]; then
MagiskVersion=stable
elif [[ $1 == "--magiskversion=beta" ]]; then
MagiskVersion=beta
elif [[ $1 == "--magiskversion=canary" ]]; then
MagiskVersion=canary
elif [[ $1 == "--magiskversion=debug" ]]; then
MagiskVersion=debug
elif [[ $1 == "--magiskversion"* ]]; then
echo $invalidmagiskversion
MagiskVersion=stable
################################MAGISK VERSION SELECT FINISH#####################################

################################Amazon store SELECT#####################################
elif [[ $1 == "--amazonstore=yes" ]]; then
WSAAmazonRemove=true
elif [[ $1 == "--amazonstore=no" ]]; then
WSAAmazonRemove=false
elif [[ $1 == "--amazonstore"* ]]; then
echo $invalidamazonstore
WSAAmazonRemove=false
################################Amazon store SELECT FINISH#####################################+

################################WSATOOL SELECT#####################################
elif [[ $1 == "--wsatools=yes" ]]; then
WSATools=true
elif [[ $1 == "--wsatools=no" ]]; then
WSATools=false
elif [[ $1 == "--wsatools"* ]]; then
echo $invalidwsatools
WSATools=false
################################WSATOOL SELECT FINISH#####################################

################################PRODUCT NAME SELECT#####################################
elif [[ $1 == "--productname" ]]; then
echo $invalidproductname
WSAProductName=redfin
elif [[ $1 == "--productname="* ]]; then
WSAProductName1=$(equalcommand $1)
WSAProductName=$(scriptregex $WSAProductName1)
################################PRODUCT NAME FINISH#####################################

################################GAPPS SELECT#####################################
elif [[ $1 == "--variant=super" ]]; then
gappsvariant=super
elif [[ $1 == "--variant=stock" ]]; then
gappsvariant=stock
elif [[ $1 == "--variant=full" ]]; then
gappsvariant=full
elif [[ $1 == "--variant=mini" ]]; then
gappsvariant=mini
elif [[ $1 == "--variant=micro" ]]; then
gappsvariant=micro
elif [[ $1 == "--variant=nano" ]]; then
gappsvariant=nano
elif [[ $1 == "--variant=mini" ]]; then
gappsvariant=mini
elif [[ $1 == "--variant=pico" ]]; then
gappsvariant=pico
elif [[ $1 == "--variant"* ]]; then
echo $invalidgapps
gappsvariant=pico
################################GAPPS SELECT FINISH #####################################
    else
    echo "$red Invalid argument-$i: $1 $white";
    fi
    i=$((i + 1));
    shift 1;
done

####################################################################################################################################
function scriptpip(){
    if [[ -x "$(command -v pip3)" ]]; then
echo "$yellow Downloading packages "BeautifulSoup4, wget, lxml". Via pip. $white"
sleepwait 0.5
python3.9 -m pip install requests
python3.9 -m pip install BeautifulSoup4
python3.9 -m pip install lxml
python3.9 -m pip install wget
echo "$red pip3 bulunamadı için işlem iptal edildi. $white"
exit 1
fi
}

function wsapy() {
    scriptpip
        if [[ -x "$(command -v python3.9)" ]]; then
    python3.9 ./python/wsa.py -r $wsarelease
    echo "$green Download completed, moving to required location."
sudo mv Microsoft*WindowsSubsystemForAndroid*.msixbundle /mnt/c/wsaproject/
    else 
echo "$red Python 3.9 bulunamadı için işlem iptal edildi. $white"
exit 1
fi
}
function wsatoolspy() {
    scriptpip
    if [[ -x "$(command -v python3.9)" ]]; then
    python3.9 ./python/wsatools.py
echo "$green Download completed, moving to required location."
sudo mv 54406Simizfo.WSATools*.msixbundle /mnt/c/wsaproject/WSATools.msixbundle
else 
echo "$red Python 3.9 bulunamadı için işlem iptal edildi. $white"
exit 1
fi
}
function opengappspy() {
    scriptpip
    if [[ -x "$(command -v python3.9)" ]]; then
python3.9 ./python/opengapps.py -a $gappsarch -va $gappsvariant
echo "$green Download completed, moving to required location."
sudo mv open_gapps-$gappsarch-*.zip /mnt/c/wsaproject/
    else 
echo "$red Python 3.9 bulunamadı için işlem iptal edildi. $white"
exit 1
    fi
}
function magiskpy() {
    scriptpip
    if [[ -x "$(command -v python3.9)" ]]; then
python3.9 ./python/magisk.py -a $gappsarch -v $MagiskVersion
echo "$green Download completed, moving to required location."
sudo mv magisk*.zip /mnt/c/wsaproject/
sudo mv magisk* /mnt/c/wsaproject/
    else 
echo "$red Python 3.9 bulunamadı için işlem iptal edildi. $white"
exit 1
    fi
}
function linux_checkFolderFile( {
    if [ -d /tmp/wsaproject ]; then
cd /tmp && cd wsaproject
sudo rm -rf /tmp/wsaproject/*
else
echo "$yellow Creating folder for project files. on the linux side $white"
cd /tmp/ && mkdir wsaproject && cd wsaproject
fi
sleepwait 5
}
function win_checkFolderFile() {
    if [ -d /mnt/c/wsaproject ]; then
cd /mnt/c/ && cd wsaproject
sudo rm -rf /mnt/c/wsaproject/*
else
echo "$yellow Creating folder for project files. on the windows side $white"
cd /mnt/c/ && mkdir wsaproject && cd wsaproject
fi
sleepwait 5
}
function linux_getscriptfolder()
{
    if [ -d /tmp/wsaproject ]; then
cd /tmp && cd wsaproject
else
echo "$yellow Creating folder for project files. on the linux side $white"
cd /tmp/ && mkdir wsaproject && cd wsaproject
fi
}
function win_getscriptfolder()
{
    if [ -d /mnt/c/wsaproject ]; then
cd /mnt/c/ && cd wsaproject
else
echo "$yellow Creating folder for project files. on the windows side $white"
cd /mnt/c/ && mkdir wsaproject && cd wsaproject
fi
}

if (( $Onlywsa == 1 )); then
    echo "$yellow Only WSA method selected. $white"
    if (( $wsatools == 1 )); then
        echo "$yellow wsatools will be downloaded. $white"
    fi
    echo "$green Wsa release type: $red $WSARelease $white"
    
    ##################
    linux_checkFolderFile
    win_checkFolderFile
    if (( $wsatools == 1 )); then
    wsatoolspy
    echo "$green Browse C > wsaproject folder for wsatools $white"
    sleepwait 2
    fi
    wsapy
      echo "$green Browse C > wsaproject folder for wsa $white"
    sleepwait 2
echo "$yellow All transactions are finished. Please check the files inside C: > wsaproject(/mnt/c/wsaproject) before deleting it. $white"
fi

if (( $MagiskWSA == 1 )); then
linux_checkFolderFile
win_checkFolderFile
    if (( $wsatools == 1 )); then
    wsatoolspy
    sleepwait 2
    fi
    opengappspy
    wsapy
    magiskpy
    ####################
    
    echo "$yellow All transactions are finished. Please check the files inside C: > wsaproject(/mnt/c/wsaproject) before deleting it. $white"
#################

fi