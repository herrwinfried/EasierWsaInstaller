
Our project was written to aim to use [WSAGAScript](https://github.com/WSA-Community/WSAGAScript) more easily. Due to the smooth running of the project and issues that may arise against the WSAGAScript update in the future. WSAGAScript is forked. ([You can navigate to the forked project here](https://github.com/herrwinfried/WSAGAScript))

## Important Information
**You need to delete the pre-installed WSA. You cannot get updates from Microsoft Store after installing WSA.**

> The ARM version is still beta, please give feedback when you encounter an error.

## Information
You can also install it with a graphical interface. [Click if you want to take a look](https://github.com/herrwinfried/wsa-gui#readme).
![image](https://user-images.githubusercontent.com/52379312/140661103-d5c4a0f8-9347-40f9-a739-4c7219cf6f96.png)


## An amateur video showing the installation

[![q_yd7DohKQA](https://img.youtube.com/vi/NAEF_S1JTFk/0.jpg)](https://www.youtube.com/watch?v=NAEF_S1JTFk)

https://youtu.be/NAEF_S1JTFk

# Requirements

- Windows 11
- [Ubuntu](https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6) or [openSUSE Tumbleweed](https://www.microsoft.com/en-us/p/opensuse-tumbleweed/9mssk2zxxn11)
- [WSL](https://aka.ms/wslstorepage)
- [Developer mode must be on](#developer-mode-must-be-turned-on)
- [Active Virtual Machine Platform](#virtual-machine-platform-must-be-active)

## What needs to be created before starting the process
- Create a folder named `wsaproject` under the `C` directory. (`C:\wsaproject`)
- Create a folder named `wsa` under the `C` directory. (`C:\wsa`)

## Developer Mode must be turned on.
> Settings > Privacy & security > For Developers > Developer Mode
> ![image](https://user-images.githubusercontent.com/52379312/138754144-e81779ea-4c61-46c6-8860-6c39b33aab47.png)

__**IF YOU ARE USING WINDOWS TERMINAL, "Windows Powershell" MUST BE SELECTED. IT IS MORE LIKELY TO GET AN ERROR WITH POWERSHELL 7.**__
__**In normal use, you should prefer windows terminal instead of Powershell 7.**__

## **Virtual Machine Platform must be active.**

> Open windows terminal as administrator. You can easily enable it by typing the following command. You should have enabled Ubuntu or OpenSUSE TumbleWeed WSL when you installed it.

> ```
> dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
> ```
> You need to Activate [WSL](https://aka.ms/wslstorepage) also to use ubuntu or openSUSE TumbleWeed

[WSA and OpenGapps Click Here to download it yourself.](#you-need-to-run-the-script-on-ubuntuopensuse-tumbleweed-or-wsl-linux-distro)

[If you want it to happen automatically, keep reading.](#you-need-to-run-the-script-on-ubuntuopensuse-tumbleweed-or-wsl-linux-distro-wsa-and-opengapps-install-automatically)

# You need to run the script on Ubuntu/OpenSUSE TumbleWeed (or WSL Linux Distro). wsa and opengapps install automatically

- [64 Bit(amd64)](#64-bit)
- [ARM64](#arm64)

## 64 Bit

### **Ubuntu**
```
cd ~ && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --gapps --okey
```
[Go To "What to do after installation"](#what-to-do-after-installation)

### **OpenSUSE Tumbleweed**
```
sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --gapps --okey
```
[Go To "What to do after installation"](#what-to-do-after-installation)

### **In Other Distros**
Be sure to install the following packages before running, as you have to install the missing packages yourself.
Packages that need to install their own script and WSAGAScript
- `unzip` (WSAGAScript)
- `lzip` (WSAGAScript)
- `lzip` (WSAGAScript)
- `git` (own script)
- `wget` (own script)
- `curl` (own script)
- `python3.8` (own script)
- `python3-pip` (own script)
- `pip3` -> `BeautifulSoup4` (own script)
- `pip3` -> `wget` (own script)
- `pip3` -> `lxml` (own script)
```
 wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh --wsa --gapps --okey
```
[Go To "What to do after installation"](#what-to-do-after-installation)

## ARM64

> Still beta

### **Ubuntu**
```
cd ~ && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup-arm.sh -O setup-arm.sh && sudo chmod +x ./setup-arm.sh && sudo ./setup-arm.sh --wsa --gapps --okey
[Go To "What to do after installation"](#what-to-do-after-installation)
```
### **OpenSUSE Tumbleweed**
```
sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup-arm.sh -O setup-arm.sh && sudo chmod +x ./setup-arm.sh && sudo ./setup-arm.sh --wsa --gapps --okey
```
[Go To "What to do after installation"](#what-to-do-after-installation)

### **In Other Distros**
Be sure to install the following packages before running, as you have to install the missing packages yourself.
Packages that need to install their own script and WSAGAScript
- `unzip` (WSAGAScript)
- `lzip` (WSAGAScript)
- `lzip` (WSAGAScript)
- `git` (own script)
- `wget` (own script)
- `curl` (own script)
- `python3.8` (own script)
- `python3-pip` (own script)
- `pip3` -> `BeautifulSoup4` (own script)
- `pip3` -> `wget` (own script)
- `pip3` -> `lxml` (own script)
```
 wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup-arm.sh -O setup-arm.sh && sudo chmod +x ./setup-arm.sh && sudo ./setup-arm.sh --wsa --gapps --okey
```
[Go To "What to do after installation"](#what-to-do-after-installation)

# You need to run the script on Ubuntu/OpenSUSE TumbleWeed (or WSL Linux Distro)

### **WSA and OpenGapps Download**
- [OpenGapps](https://opengapps.org/) | [What should I choose when installing opengapps](https://github.com/herrwinfried/wsa-script/blob/main/docs/opengapps.md)
- [WSA msixbundle file](https://github.com/herrwinfried/wsa-script/blob/main/docs/wsamsixbundle.md)


- [64 Bit(amd64)](#64-bit-1)
- [ARM64](#arm64-1)

## 64 Bit

### **Ubuntu**
```
cd ~ && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh
```
[Go To "What to do after installation"](#what-to-do-after-installation)

### **OpenSUSE Tumbleweed**
```
sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh
```
[Go To "What to do after installation"](#what-to-do-after-installation)

### **In Other Distros**
Be sure to install the following packages before running, as you have to install the missing packages yourself.
Packages that need to install their own script and WSAGAScript
- `unzip` (WSAGAScript)
- `lzip` (WSAGAScript)
- `lzip` (WSAGAScript)
- `git` (own script)
- `wget` (own script)
- `curl` (own script)
- `python3.8` (own script)
- `python3-pip` (own script)
- `pip3` -> `BeautifulSoup4` (own script)
- `pip3` -> `wget` (own script)
- `pip3` -> `lxml` (own script)
```
 wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh
```
[Go To "What to do after installation"](#what-to-do-after-installation)

## ARM64

> Still beta

### **Ubuntu**
```
cd ~ && sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip lzip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup-arm.sh -O setup-arm.sh && sudo chmod +x ./setup-arm.sh && sudo ./setup-arm.sh
```
[Go To "What to do after installation"](#what-to-do-after-installation)
### **OpenSUSE Tumbleweed**
```
sudo zypper ref && sudo zypper dup -y && sudo zypper in -y git curl wget lzip unzip e2fsprogs python38 python38-pip && wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup-arm.sh -O setup-arm.sh && sudo chmod +x ./setup-arm.sh && sudo ./setup-arm.sh
```
[Go To "What to do after installation"](#what-to-do-after-installation)

### **In Other Distros**
Be sure to install the following packages before running, as you have to install the missing packages yourself.
Packages that need to install their own script and WSAGAScript
- `unzip` (WSAGAScript)
- `lzip` (WSAGAScript)
- `lzip` (WSAGAScript)
- `git` (own script)
- `wget` (own script)
- `curl` (own script)
- `python3.8` (own script)
- `python3-pip` (own script)
- `pip3` -> `BeautifulSoup4` (own script)
- `pip3` -> `wget` (own script)
- `pip3` -> `lxml` (own script)
```
 wget https://raw.githubusercontent.com/herrwinfried/wsa-script/1.0.1/setup.sh -O setup.sh && sudo chmod +x ./setup.sh && sudo ./setup.sh
```
[Go To "What to do after installation"](#what-to-do-after-installation)

## What to do after installation

In order for the powershell script in the "C:\wsaproject" directory to run, you need to change your permission setting. Below is the command you need to type. Run as Administrator Powershell.
Or Install manually. I talked about it below.

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

or if you want to do it manually, start windows terminal administrator and type the following commands.
> If you are using arm arm64. x64 if you are using intel or amd processor 64 bit. As the folder you will choose
```
cd 'C:\wsa\[x64/arm64]'
```

```
Add-AppxPackage -Register .\AppxManifest.xml
```
> In the past, it was necessary to connect adb and do something additional for google play, it is not needed anymore.
