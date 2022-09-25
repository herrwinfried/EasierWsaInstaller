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
elif [[ $n == "--lang=en" ]] || [[ $n == "--lang=en-us" ]]; then
Language=en_US
GetMessage
elif [[ $n == "--lang=tr" ]] || [[ $n == "--lang=tr-tr" ]]; then
Language=tr
GetMessage
elif [[ $n == "--lang=de" ]] || [[ $n == "--lang=de-de" ]]; then
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
if [ -d /root/wsaproject ]; then

function_regex_folder WSLFolder
cd /root && cd wsaproject
echo $info_Folder1
sudo rm -rf /root/wsaproject/*
else
echo $selectwslfolder
cd /root/ && mkdir wsaproject && cd wsaproject || scriptabort
fi
sleepwait 5

}

function WindowsFolder() {
    if [ -d /mnt/c/wsaproject ]; then
function_regex_folder WindowsFolder
cd /mnt/c/ && cd wsaproject
echo $info_Folder1
sudo rm -rf /mnt/c/wsaproject/*
else
echo $selectwindowsfolder
cd /mnt/c/ && mkdir wsaproject && cd wsaproject || scriptabort
fi
sleepwait 5
}

function Get_WSLFolder() {
  function_regex_getfolder Get_WSLFolder
cd /root/ && cd wsaproject || scriptabort
function_regex_getfolder1 Get_WSLFolder
}

function Get_WSLFolderBashScript() {
    function_regex_getfolder Get_WSLFolderBashScript
cd /root/ && cd wsa-script && cd scripts && cd bash || scriptabort
function_regex_getfolder1 Get_WSLFolderBashScript
}
function Get_WSLFolderPython() {
    function_regex_getfolder Get_WSLFolderPython
cd /root/ && cd wsa-script && cd scripts && cd python || scriptabort
function_regex_getfolder1 Get_WSLFolderPython
}
function Get_WSLFolderPowershell() {
   function_regex_getfolder Get_WSLFolderPowershell
cd /root/ && cd wsa-script && cd scripts && cd powershell || scriptabort
function_regex_getfolder1 Get_WSLFolderPowershell
}
function Get_WSLFolderScripts() {
   function_regex_getfolder Get_WSLFolderScripts
cd /root/ && cd wsa-script && cd scripts || scriptabort
function_regex_getfolder1 Get_WSLFolderScripts
}

function Get_WindowsFolder() {
function_regex_getfolder Get_WindowsFolder
cd /mnt/c/ && cd wsaproject || scriptabort
function_regex_getfolder1 Get_WindowsFolder
}

function scriptpip(){
    if [[ -x "$(command -v pip3)" ]]; then
echo $pipinstall
sleepwait 0.5
python3.10 -m pip install requests
python3.10 -m pip install BeautifulSoup4
python3.10 -m pip install lxml
python3.10 -m pip install wget
else
echo $nopip
exit 1
fi
}

function wsapy() {
        if [[ -x "$(command -v python3.10)" ]]; then
        echo "I will install $yellow W $red S $green A $white"
    python3.10 ./python/wsa.py -r $wsarelease
    echo $downloadsus
sudo mv Microsoft*WindowsSubsystemForAndroid*.msixbundle /mnt/c/wsaproject/
    else 
echo $nopy39
exit 1
fi
}

function wsatoolspy() {
    if [[ -x "$(command -v python3.10)" ]]; then
    echo "I will install $yellow WSA $red TOOLS $white"
    python3.10 ./python/wsatools.py
 echo $downloadsus
sudo mv 54406Simizfo.WSATools*.msixbundle /mnt/c/wsaproject/WSATools.msixbundle
else 
echo $nopy39
exit 1
fi
}

function opengappspy() {
    if [[ -x "$(command -v python3.10)" ]]; then
    echo "I will install $yellow OPEN $red GAPPS $white"
python3.10 ./python/opengapps.py -a $gappsarch -va $gappsvariant
 echo $downloadsus
sudo mv open_gapps-$gappsarch-*.zip /mnt/c/wsaproject/
    else 
echo $nopy39
exit 1
    fi
}
####################################################################################################################################
if [[ $onlywsa == true ]]; then
echo $info_vv_ss
requirePackage_normal
WSLFolder
WindowsFolder
scriptpip
Get_WSLFolderScripts
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
sudo rm -rf /root/wsaproject