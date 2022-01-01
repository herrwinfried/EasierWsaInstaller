# Important warning

**Do it within your own consciousness. We take no responsibility.**

This method is experimental. Made easy for you to enter fewer commands.

# What is wsa script?

wsa-script allows you to perform an easier installation by using the [WSAGAScript](https://github.com/WSA-Community/WSAGAScript) infrastructure. and as a secondary plan it allows you to download only the original wsa.

> NOTE: The [WSAGAScript](https://github.com/WSA-Community/WSAGAScript) Project is Forked for the script to run properly. In this way, the script will not be corrupted when a new update comes. This does not mean that [WSAGAScript](https://github.com/WSA-Community/WSAGAScript) will not be updated. When the command is updated on the [WSAGAScript](https://github.com/WSA-Community/WSAGAScript) side, our Script will be available as soon as possible and the Fork will be updated.

> [WSAGAScript fork link: https://github.com/herrwinfried/WSAGAScript](https://github.com/herrwinfried/WSAGAScript)

# Command lines not for you?
[Try our wsa-gui project](https://github.com/herrwinfried/wsa-gui#readme)

# An amateur video showing the installation

Soon...

# What are the Requirements?

> You need to fully install ubuntu, OpenSUSE Tumbleweed or debian. So you have to create a User account.

- You must have a minimum Windows 11 device. It is adjusted for Windows 11 only.

- [Virtual Machine Platform Must Be Active](#virtual-machine-platform-must-be-active)
- [Developer Mode must be active.](#developer-mode-must-be-turned-on) **(Applicable if you are going to use the opengapps + wsa method.)**
- [WSL](https://aka.ms/wslstorepage)
- [Ubuntu](https://www.microsoft.com/p/ubuntu/9nblggh4msv6), [OpenSUSE Tumbleweed](https://www.microsoft.com/p/opensuse-tumbleweed/9mssk2zxxn11) or [Debian](https://www.microsoft.com/p/debian/9msvkqc78pk6)
- [Powershell Core(7+)](https://www.microsoft.com/en-us/p/powershell/9mz1snwt0n5d) **(Applicable if you are going to use the WSA-Gui project.)**

## Developer Mode must be turned on.
> Settings > Privacy & security > For Developers > Developer Mode
> ![image](https://user-images.githubusercontent.com/52379312/138754144-e81779ea-4c61-46c6-8860-6c39b33aab47.png)

__**IF YOU ARE USING WINDOWS TERMINAL, "Windows Powershell" MUST BE SELECTED. IT IS MORE LIKELY TO GET AN ERROR WITH POWERSHELL 7.**__
__**In normal use, you should prefer windows terminal instead of Powershell 7.**__

## **Virtual Machine Platform must be active.**

> Open windows terminal as administrator. You can easily enable it by typing the following command. You should have enabled Ubuntu, OpenSUSE TumbleWeed or Debian WSL when you installed it.

> ```
> dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
> ```
> You need to Activate [WSL](https://aka.ms/wslstorepage) also to use ubuntu, openSUSE TumbleWeed or Debian

# What to do before you start

- Create a folder named `wsaproject` under the `C` directory. (`C:\wsaproject`)
- Create a folder named `wsa` under the `C` directory. (`C:\wsa`)

> NOTE: If you are going to do WSA Upload only. You do not need to create a WSA folder.

# Information before you start

You need to remove the existing WSA.

___The ARM version is still beta, please give feedback when you encounter an error.___ **(Applicable if you are going to use the opengapps + wsa method.)**

- [WSA + OpenGapps Method](#wsa--opengapps-method)
- [WSA Upload only](#wsa-upload-only)
# WSA + OpenGapps Method

**(Files are not original, contain OpenGapps, can't get MS Store updates later)**

- [amd64](#amd64) (x64 intel/amd)
- [arm64](#arm64)

## amd64
### **Ubuntu or Debian:**

```
sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.9 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --opengapps --okey"
```
> Also, if you want to download wsatools, you have to write this command completely. If you want to download the above command without WSATools, use it.
>
> ```
> sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.9 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --opengapps --wsatools --okey"
> ```
[Go To "What to do after installation"](#what-to-do-after-installation)

### **openSUSE Tumbleweed**

```
sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python39 python39-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --opengapps --okey"
```
> Also, if you want to download wsatools, you have to write this command completely. If you want to download the above command without WSATools, use it.
>
> ```
> sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python39 python39-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --opengapps --wsatools --okey"
> ```
[Go To "What to do after installation"](#what-to-do-after-installation)

### Other Distros:
 **You need to download and install the following Packages. (Listed by name on Ubuntu.)**
 - `sudo`
 - `unzip`
 - `lzip`
 - `e2fsprogs`
 - `git`
 - `wget`
 - `python3.9`
 - `python3-pip`
 
**What to install via pip**
- `BeautifulSoup4`
 - `wget`
 - `lxml`

```
sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --opengapps --okey"
```
> Also, if you want to download wsatools, you have to write this command completely. If you want to download the above command without WSATools, use it.
>
> ```
> sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --opengapps --wsatools --okey"
> ```
[Go To "What to do after installation"](#what-to-do-after-installation)

## arm64

### **Ubuntu or Debian:**

```
sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.9 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --opengapps --okey"
```
> Also, if you want to download wsatools, you have to write this command completely. If you want to download the above command without WSATools, use it.
>
> ```
> sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.9 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --opengapps --wsatools --okey"
> ```
[Go To "What to do after installation"](#what-to-do-after-installation)

### **openSUSE Tumbleweed**

```
sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python39 python39-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --opengapps --okey"
```
> Also, if you want to download wsatools, you have to write this command completely. If you want to download the above command without WSATools, use it.
>
> ```
> sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python39 python39-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --opengapps --wsatools --okey"
> ```
[Go To "What to do after installation"](#what-to-do-after-installation)

### Other Distros:
 **You need to download and install the following Packages. (Listed by name on Ubuntu.)**
 - `sudo`
 - `unzip`
 - `lzip`
 - `e2fsprogs`
 - `git`
 - `wget`
 - `python3.9`
 - `python3-pip`
 
**What to install via pip**
- `BeautifulSoup4`
 - `wget`
 - `lxml`

```
sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --opengapps --okey"
```
> Also, if you want to download wsatools, you have to write this command completely. If you want to download the above command without WSATools, use it.
>
> ```
> sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsa --opengapps --wsatools --okey"
> ```
[Go To "What to do after installation"](#what-to-do-after-installation)

# WSA Upload only
**(No file touch original, no OpenGapps)**

- [amd64](#amd64-1) (x64 intel/amd)
- [arm64](#arm64-1)

## amd64
### **Ubuntu or Debian:**

```
sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.9 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsaonly --okey"
```
> Also, if you want to download wsatools, you have to write this command completely. If you want to download the above command without WSATools, use it.
>
> ```
> sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.9 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsaonly --wsatools --okey"
> ```
[Go To "What to do after installation"](#what-to-do-after-installation)

### **openSUSE Tumbleweed**

```
sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python39 python39-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsaonly --okey"
```
> Also, if you want to download wsatools, you have to write this command completely. If you want to download the above command without WSATools, use it.
>
> ```
> sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python39 python39-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsaonly --wsatools --okey"
> ```
[Go To "What to do after installation"](#what-to-do-after-installation)

### Other Distros:
 **You need to download and install the following Packages. (Listed by name on Ubuntu.)**
 - `sudo`
 - `unzip`
 - `lzip`
 - `e2fsprogs`
 - `git`
 - `wget`
 - `python3.9`
 - `python3-pip`
 
**What to install via pip**
- `BeautifulSoup4`
 - `wget`
 - `lxml`

```
sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsaonly --okey"
```
> Also, if you want to download wsatools, you have to write this command completely. If you want to download the above command without WSATools, use it.
>
> ```
> sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsaonly --wsatools --okey"
> ```
[Go To "What to do after installation"](#what-to-do-after-installation)

## arm64

### **Ubuntu or Debian:**

```
sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.9 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsaonly --okey"
```
> Also, if you want to download wsatools, you have to write this command completely. If you want to download the above command without WSATools, use it.
>
> ```
> sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip e2fsprogs git wget python3.9 python3-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsaonly --wsatools --okey"
> ```
[Go To "What to do after installation"](#what-to-do-after-installation)

### **openSUSE Tumbleweed**

```
sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python39 python39-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsaonly --okey"
```
> Also, if you want to download wsatools, you have to write this command completely. If you want to download the above command without WSATools, use it.
>
> ```
> sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python39 python39-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsaonly --wsatools --okey"
> ```
[Go To "What to do after installation"](#what-to-do-after-installation)

### Other Distros:
 **You need to download and install the following Packages. (Listed by name on Ubuntu.)**
 - `sudo`
 - `unzip`
 - `lzip`
 - `e2fsprogs`
 - `git`
 - `wget`
 - `python3.9`
 - `python3-pip`
 
**What to install via pip**
- `BeautifulSoup4`
 - `wget`
 - `lxml`

```
sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsaonly --okey"
```
> Also, if you want to download wsatools, you have to write this command completely. If you want to download the above command without WSATools, use it.
>
> ```
> sudo sh -c "cd ~; sudo rm -rf /tmp/wsaproject; sudo mkdir /tmp/wsaproject; cd /tmp/wsaproject && sudo rm -rf setup.sh && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/beta/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --arm --wsaonly --wsatools --okey"
> ```
[Go To "What to do after installation"](#what-to-do-after-installation)

# What to do after installation

**Only If You Download Original WSA . Go to `C:\\wsaproject` and double click the file. then install it.** *(Only If You Used WSA Upload only method)*

**Continue reading if you used the WSA + Opengapps Method**

- [Method 1](#method-1)
- [Method 2](#method-2) (Manuel)

In order for the powershell script in the "C:\wsaproject" directory to run, you need to change your permission setting. Below is the command you need to type. Run as Administrator Powershell.
# Method 1
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
# Method 2
or if you want to do it manually, start windows terminal administrator and type the following commands.
> If you are using arm arm64. x64 if you are using intel or amd processor 64 bit. As the folder you will choose
```
cd 'C:\wsa\[x64/arm64]'
```

```
Add-AppxPackage -Register .\AppxManifest.xml
```
