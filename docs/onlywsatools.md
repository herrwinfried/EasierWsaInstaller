# Only WSATools
It is for 64 bit only.

Transactions are made over WSL. So it's main requirements apply.
# You need to run the script on Ubuntu/OpenSUSE TumbleWeed (or WSL Linux Distro)

## 64 Bit

### **Ubuntu**
```
cd ~ && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/other/wsatools.sh -O wsatools.sh && sudo chmod +x ./wsatools.sh && sudo ./wsatools.sh
```
[Go To "What to do after installation"](#what-to-do-after-installation)

### **OpenSUSE Tumbleweed**
```
cd ~ && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/other/wsatools.sh -O wsatools.sh && sudo chmod +x ./wsatools.sh && sudo ./wsatools.sh
```
[Go To "What to do after installation"](#what-to-do-after-installation)

### **In Other Distros**
Be sure to install the following packages before running, as you have to install the missing packages yourself.
Packages that need to install their own script and WSAGAScript
- `unzip`
- `lzip`
- `lzip` 
- `git`
- `wget`
- `curl`
- `python3.8`
- `python3-pip`
- `pip3` -> `BeautifulSoup4`
- `pip3` -> `wget`
- `pip3` -> `lxml`
```
 wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/other/wsatools.sh -O wsatools.sh && sudo chmod +x ./wsatools.sh && sudo ./wsatools.sh
```
[Go To "What to do after installation"](#what-to-do-after-installation)

## What to do after installation

In order for the powershell script in the "C:\wsaproject" directory to run, you need to change your permission setting. Below is the command you need to type. Run as Administrator Powershell. I talked about it below.

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```
we can run the script now!
![image](https://user-images.githubusercontent.com/52379312/138756336-feef2fd0-f697-401a-85d1-a243c9763e75.png)
The operation is successful when it is as in the picture. Red text should not necessarily be.

Making change permission default for Powershell
```
Set-ExecutionPolicy -ExecutionPolicy Restricted
```