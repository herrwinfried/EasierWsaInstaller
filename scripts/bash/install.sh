#!/bin/bash

. ./wsascript-varibles.sh
echo "$red Version: $green $WSASCRIPTVERSION $white"
onlywsl
checkroot
###################
i=1;
j=$#;
while [ $i -le $j ]
do
n=$(echo $1 | tr '[:upper:]' '[:lower:]')
#ARM
if [[ $n == "--arm" ]]; then
gappsarch=arm64
msarch=ARM64
mskernel=arm64
#ARM FINISH

################################language SELECT#####################################
elif [[ $n == "--lang=en" ]] || [[ $n == "--lang=en-US" ]]; then
Language=en_US
GetMessage
elif [[ $n == "--lang=tr" ]] || [[ $n == "--lang=tr-TR" ]]; then
Language=tr
GetMessage
elif [[ $n == "--lang=de" ]] || [[ $n == "--lang=de-DE" ]]; then
Language=de_DE
GetMessage
elif [[ $n == "--lang="* ]]; then
echo "$red invalid value(language). English selected $white"
Language=en_US
GetMessage
################################language FINISH#####################################


################################METHOD##########################################
elif [[ $n == "--onlywsa" ]]; then
onlywsa=true;
WSAGAScript=false;
MagiskWSA=false;
elif [[ $n == "--magiskonwsalocal" ]]; then
onlywsa=false;
WSAGAScript=false;
MagiskWSA=true;
elif [[ $n == "--wsagascript" ]]; then
onlywsa=false;
WSAGAScript=true;
MagiskWSA=false;
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
echo $invalidwsarelease
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
elif [[ $n == "--magiskversion"* ]]; then
echo $invalidmagiskversion
MagiskVersion=stable
################################MAGISK VERSION SELECT FINISH#####################################

################################Amazon store SELECT#####################################
elif [[ $n == "--amazonstore=yes" ]]; then
WSAAmazonRemove=true
elif [[ $n == "--amazonstore=no" ]]; then
WSAAmazonRemove=false
elif [[ $n == "--amazonstore"* ]]; then
echo $invalidamazonstore
WSAAmazonRemove=false
################################Amazon store SELECT FINISH#####################################+

################################WSATOOL SELECT#####################################
elif [[ $n == "--wsatools=yes" ]]; then
WSATools=true
elif [[ $n == "--wsatools=no" ]]; then
WSATools=false
elif [[ $n == "--wsatools"* ]]; then
echo $invalidwsatools
WSATools=false
################################WSATOOL SELECT FINISH#####################################

################################PRODUCT NAME SELECT#####################################
elif [[ $n == "--productname" ]]; then
echo $invalidproductname
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
echo $invalidgapps
gappsvariant=pico
################################GAPPS SELECT FINISH #####################################
    else
    echo "$red Invalid argument-$i: $n $white";
    fi
    i=$((i + 1));
    shift 1;
done

function scriptabort(){
echo $processabort
sleepwait 30
exit 1
}

function WSLFolder() {
if [ -d /tmp/wsaproject ]; then

echo "$green Function: $yellow WSLFolder found. $white"
cd /tmp && cd wsaproject
echo "$green Function: $yellow I am deleting all the files in it. $white"
sudo rm -rf /tmp/wsaproject/*
else
echo $selectwslfolder
cd /tmp/ && mkdir wsaproject && cd wsaproject || scriptabort
fi
sleepwait 5

}

function WindowsFolder() {
    if [ -d /mnt/c/wsaproject ]; then
    echo "$green Function: $yellow WindowsFolder found. $white"
cd /mnt/c/ && cd wsaproject
echo "$green Function: $yellow I am deleting all the files in it. $white"
sudo rm -rf /mnt/c/wsaproject/*
else
echo $selectwindowsfolder
cd /mnt/c/ && mkdir wsaproject && cd wsaproject || scriptabort
fi
sleepwait 5
}

function Get_WSLFolder() {
    echo "$green Function: $yellow I go into the Get_WSLFolder Folder. $white"
cd /tmp/ && cd wsaproject || scriptabort
echo "$green Function: $yellow I went into the Get_WSLFolder Folder. $white"
}

function Get_WSLFolderBashScript() {
    echo "$green Function: $yellow I go into the Get_WSLFolderBashScript Folder. $white"
cd /tmp/ && cd wsa-script && cd scripts && cd bash || scriptabort
echo "$green Function: $yellow I went into the Get_WSLFolderBashScript Folder. $white"
}
function Get_WSLFolderPython() {
    echo "$green Function: $yellow I go into the Get_WSLFolderPython Folder. $white"
cd /tmp/ && cd wsa-script && cd scripts && cd python || scriptabort
echo "$green Function: $yellow I went into the Get_WSLFolderPython Folder. $white"
}
function Get_WSLFolderPowershell() {
    echo "$green Function: $yellow I go into the Get_WSLFolderPowershell Folder. $white"
cd /tmp/ && cd wsa-script && cd scripts && cd powershell || scriptabort
echo "$green Function: $yellow I went into the Get_WSLFolderPowershell Folder. $white"
}
function Get_WSLFolderScripts() {
        echo "$green Function: $yellow I go into the Get_WSLFolderScripts Folder. $white"
cd /tmp/ && cd wsa-script && cd scripts || scriptabort
echo "$green Function: $yellow I went into the Get_WSLFolderScripts Folder. $white"
}

function Get_WindowsFolder() {
        echo "$green Function: $yellow I go into the Get_WindowsFolder Folder. $white"
cd /mnt/c/ && cd wsaproject || scriptabort
echo "$green Function: $yellow I went into the Get_WindowsFolder Folder. $white"
}

function scriptpip(){
    if [[ -x "$(command -v pip3)" ]]; then
echo $pipinstall
sleepwait 0.5
python3.9 -m pip install requests
python3.9 -m pip install BeautifulSoup4
python3.9 -m pip install lxml
python3.9 -m pip install wget
else
echo $nopip
exit 1
fi
}

function wsapy() {
        if [[ -x "$(command -v python3.9)" ]]; then
        echo "I will install $yellow W $red S $green A $white"
    python3.9 ./python/wsa.py -r $wsarelease
    echo $downloadsus
sudo mv Microsoft*WindowsSubsystemForAndroid*.msixbundle /mnt/c/wsaproject/
    else 
echo $nopy39
exit 1
fi
}

function wsatoolspy() {
    if [[ -x "$(command -v python3.9)" ]]; then
    echo "I will install $yellow WSA $red TOOLS $white"
    python3.9 ./python/wsatools.py
 echo $downloadsus
sudo mv 54406Simizfo.WSATools*.msixbundle /mnt/c/wsaproject/WSATools.msixbundle
else 
echo $nopy39
exit 1
fi
}

function opengappspy() {
    if [[ -x "$(command -v python3.9)" ]]; then
    echo "I will install $yellow OPEN $red GAPPS $white"
python3.9 ./python/opengapps.py -a $gappsarch -va $gappsvariant
 echo $downloadsus
sudo mv open_gapps-$gappsarch-*.zip /mnt/c/wsaproject/
    else 
echo $nopy39
exit 1
    fi
}
####################################################################################################################################
if [[ $onlywsa == true ]]; then
echo "$yellow I'm doing Package Check. The package will be installed if needed. (If in supported distribution list) $red . $green . $white "
requirePackage_normal
WSLFolder
WindowsFolder
scriptpip
Get_WindowsFolder
wsapy
if [[ $WSATools == true ]]; then
wsatoolspy
fi
echo $notonlywsa1
sleepwait 90

elif [[ $MagiskWSA == true ]]; then
. ./magiskonwsalocal.sh
magiskonwsamethod_d

elif [[ $WSAGAScript == true ]]; then
 . ./wsagascript.sh
wsagascriptmethod_d
else
 . ./wsagascript.sh
echo $invalidmethod
sleepwait 2
wsagascriptmethod_d
fi
####################################################################################################################################
sleepwait 1
#sudo rm -rf *