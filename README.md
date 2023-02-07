# Warning

1. **Due to the intensity of my real life, the development and updating phase of the project has slowed down.**

2. **This is an experimental project. We are not responsible for an incident that you will encounter. Do it within your own consciousness.**

3. This method is experimental. Made easy for you to enter fewer commands.
# What is EasierWsaInstaller?

Our project is a simple CLI that makes it easier to install WSAGAScript, MagiskOnWSA Local and original wsa(download).

# why keep wsagascript and magiskonwsalocal projects inside your own project?

We thought it would be more logical to use it after reviewing the update coming to the projects so that it can work properly, so it is in the project. There is no play involved. (Except for product name change etc.)

# Command lines not for you?
[Try our EasierWsaInstallerGui project](https://github.com/herrwinfried/EasierWsaInstallerGui#readme)

# Information before you start

You need to remove the existing WSA.

___The ARM version is still beta, please give feedback when you encounter an error.___ **(Applicable if you are going to use the wsagascript and magiskonwsalocal method.)**

# What are the Requirements?

> You need to fully install ubuntu, OpenSUSE Tumbleweed or debian. So you have to create a User account.

- You must have a minimum Windows 11 device. It is adjusted for Windows 11 only.

- [Virtual Machine Platform Must Be Active](#virtual-machine-platform-must-be-active)
- [Developer Mode must be active.](#developer-mode-must-be-turned-on) **(Applicable if you are going to use the MagiskOnWSA and WSAGAScript method.)**
- [WSL](https://aka.ms/wslstorepage)
- [Ubuntu](https://www.microsoft.com/store/productId/9PDXGNCFSCZV), [OpenSUSE Tumbleweed](https://www.microsoft.com/p/opensuse-tumbleweed/9mssk2zxxn11) or [Debian](https://www.microsoft.com/p/debian/9msvkqc78pk6)
- [Powershell Core(7+)](https://www.microsoft.com/en-us/p/powershell/9mz1snwt0n5d) **(Applicable if you are going to use the EasierWsaInstallerGui project.)**

## Developer Mode must be turned on.
> Settings > Privacy & security > For Developers > Developer Mode
> ![image](https://user-images.githubusercontent.com/52379312/138754144-e81779ea-4c61-46c6-8860-6c39b33aab47.png)

## **Virtual Machine Platform must be active.**

> Open windows terminal as administrator. You can easily enable it by typing the following command. You should have enabled Ubuntu, OpenSUSE Tumbleweed or Debian WSL when you installed it.

> ```
> dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
> ```
> You need to Activate [WSL](https://aka.ms/wslstorepage) also to use ubuntu, openSUSE Tumbleweed or Debian

# What to do before you start

- Create a folder named `easierwsainstaller` under the `C` directory. (`C:\easierwsainstaller`)
- Create a folder named `wsa` under the `C` directory. (`C:\wsa`)

> NOTE: If you choose onlywsa method. You do not need to create a WSA folder.

# Information before you start

You need to remove the existing WSA.

___The ARM version is still beta, please give feedback when you encounter an error.___

# About Parameters

> You can also access it by typing **sudo ./install.sh --help**

```
those selected by default are marked with [*]

Language:
    [*]en-US

Arch:
    --arch=x86_64
    [*]x86_64, arm

Method:
    --method=magiskonwsalocal
 [*]magiskonwsalocal                     Install Wsa using the MagiskOnWsaLocal project.
    wsagascript                          Install Wsa using the WSAGAScript project.
    onlywsa                              Download WSA without touching the contents of the file.

Gapps:
    --gapps=mindthegapps                 Onlywsa and wsagascript method is not supported.
 [*]mindthegapps                         Use MindTheGapps as Gapps.
    opengapps                            Use OpenGapps as Gapps.
    The wsagascript method will always have opengapps selected.

Opengapps variant:
    --variant=pico                       Onlywsa method is not supported.
    super, stock, full, mini, micro, nano, [*]pico

Customizations:
    --wsatools=no
    wsatools=yes                         Download WSATools
 [*]wsatools=no                          Do not download WSATools.

    --productname=redfin                 Onlywsa method is not supported.
    productname=NAME                     Set the product name name.
 [*]productname=redfin

    --amazonstore=no                     Onlywsa method is not supported.
    amazonstore=yes                      Remove amazon store.
 [*]amazonstore=no                       Don't remove amazon store.

WSA Release Options:
    --wsarelease=retail
    fast, slow, rp, [*]retail

Magisk Version Options:
    --magiskversion=stable               Onlywsa and wsagascript method is not supported.
    [*]stable, beta, canary, debug

Example:
 sudo ./install.sh --arch=x86_64 --method=magiskonwsalocal --variant=pico --wsatools=yes --productname=redfin --amazonstore=no --wsarelease=retail --magiskversion=stable
```

# WSL Requirements

## Packages

> Written based on Ubuntu.

### MagiskOnWSALocal

- `lsb-release`
- `sudo`
- `lzip`
- `unzip`
- `setools`
- `whiptail`
- `wine`
- `winetricks`
- `patchelf`
- `e2fsprogs`
- `aria2`
- `p7zip-full`
- `python3`
- `python3-pip`
- `git`
- `wget`
- `attr`
- `xz-utils`
- `unzip`

### onlywsa and WSAGAScript

- `lsb-release`
- `sudo`
- `lzip`
- `unzip`
- `e2fsprogs`
- `git`
- `wget`
- `python3`
- `python3-pip`

# Example Install
## Ubuntu & AMD64 & MagiskOnWSALocal

```bash 
sudo sh -c "cd ~; sudo rm -rf /root/easierwsainstaller; sudo rm -rf /root/easierwsainstaller-project; sudo apt update && sudo apt upgrade -y; sudo apt install -y git curl wget unzip python3 python3-pip; cd /root/; wget https://github.com/herrwinfried/EasierWsaInstaller/archive/refs/heads/main.zip -O easierwsainstaller.zip; unzip easierwsainstaller.zip -d /root/easierwsainstaller; cd /root/easierwsainstaller; mv /root/easierwsainstaller/EasierWsaInstaller*/* /root/easierwsainstaller; cd src; cd EasierWsaInstaller; chmod +x ./*.sh && ./install.sh --arch=amd64 --method=magiskonwsalocal --gapps=mindthegapps --variant=pico --wsatools=no --productname=winfried --amazonstore=no --wsarelease=retail --magiskversion=stable"
```
[Go To "What to do after installation"](#what-to-do-after-installation)
## openSUSE Tumbleweed & AMD64 & MagiskOnWSALocal
```bash 
sudo sh -c "cd ~; sudo rm -rf /root/easierwsainstaller; sudo rm -rf /root/easierwsainstaller-project; sudo apt update && sudo apt upgrade -y; sudo zypper dup -l -y; sudo zypper install -l -y git curl wget unzip python310 python310-pip; cd /root/; wget https://github.com/herrwinfried/EasierWsaInstaller/archive/refs/heads/main.zip -O easierwsainstaller.zip; unzip easierwsainstaller.zip -d /root/easierwsainstaller; cd /root/easierwsainstaller; mv /root/easierwsainstaller/EasierWsaInstaller*/* /root/easierwsainstaller; cd src; cd EasierWsaInstaller; chmod +x ./*.sh && ./install.sh --arch=amd64 --method=magiskonwsalocal --gapps=mindthegapps --variant=pico --wsatools=no --productname=winfried --amazonstore=no --wsarelease=retail --magiskversion=stable"
```

[Go To "What to do after installation"](#what-to-do-after-installation)
## Ubuntu & ARM64 & MagiskOnWSALocal
```bash 
sudo sh -c "cd ~; sudo rm -rf /root/easierwsainstaller; sudo rm -rf /root/easierwsainstaller-project; sudo apt update && sudo apt upgrade -y; sudo apt install -y git curl wget unzip python3 python3-pip; cd /root/; wget https://github.com/herrwinfried/EasierWsaInstaller/archive/refs/heads/main.zip -O easierwsainstaller.zip; unzip easierwsainstaller.zip -d /root/easierwsainstaller; cd /root/easierwsainstaller; mv /root/easierwsainstaller/EasierWsaInstaller*/* /root/easierwsainstaller; cd src; cd EasierWsaInstaller; chmod +x ./*.sh && ./install.sh --arch=arm64 --method=magiskonwsalocal --gapps=mindthegapps --variant=pico --wsatools=no --productname=winfried --amazonstore=no --wsarelease=retail --magiskversion=stable"

```
[Go To "What to do after installation"](#what-to-do-after-installation)

## openSUSE Tumbleweed & ARM64 & MagiskOnWSALocal
```bash 
sudo sh -c "cd ~; sudo rm -rf /root/easierwsainstaller; sudo rm -rf /root/easierwsainstaller-project; sudo apt update && sudo apt upgrade -y; sudo zypper dup -l -y; sudo zypper install -l -y git curl wget unzip python310 python310-pip; cd /root/; wget https://github.com/herrwinfried/EasierWsaInstaller/archive/refs/heads/main.zip -O easierwsainstaller.zip; unzip easierwsainstaller.zip -d /root/easierwsainstaller; cd /root/easierwsainstaller; mv /root/easierwsainstaller/EasierWsaInstaller*/* /root/easierwsainstaller; cd src; cd EasierWsaInstaller; chmod +x ./*.sh && ./install.sh --arch=arm64 --method=magiskonwsalocal --gapps=mindthegapps --variant=pico --wsatools=no --productname=winfried --amazonstore=no --wsarelease=retail --magiskversion=stable"
```

[Go To "What to do after installation"](#what-to-do-after-installation)

# What to do after installation

**Only If You Download OnlyWSA Method . Go to `C:\easierwsainstaller-project` and double click the file. then install it.**

**If you used the WSAGAScript or magiskonwsalocal Method, read on**

- [Method 1](#method-1)
- [Method 2](#method-2) (Manuel)


# Method 1

## WSAGAScript Method

> If you are using arm arm64. x64 if you are using intel or amd processor 64 bit. As the folder you will choose

Go to target `C:\wsa\[x64/arm64]` and double click **setup.bat**

## MagiskOnWsaLocal Method

Go to target `C:\wsa\wsamagisk` and double click **Run.bat**

# Method 2
or if you want to do it manually, start windows terminal administrator and type the following commands.
> If you are using arm arm64. x64 if you are using intel or amd processor 64 bit. As the folder you will choose

```
cd 'C:\wsa\[x64/arm64]'
```

```
Add-AppxPackage -Register .\AppxManifest.xml
```

# **FAQ**

### **MagiskOnWsaLocal offers Custom Gapps option, do you offer it?**

No, unfortunately we do not support it.

### **Is there Language Support?**

No for now.


# Credits

- [MagiskOnWSALocal](https://github.com/LSPosed/MagiskOnWSALocal)
- [WSAGAScript](https://github.com/ADeltaX/WSAGAScript)
- [WSA-Kernel-SU](https://github.com/LSPosed/WSA-Kernel-SU)
- [kernel-assisted-superuser](https://git.zx2c4.com/kernel-assisted-superuser/)
- [Magisk](https://github.com/topjohnwu/Magisk)
- [The Open GApps Project](https://opengapps.org/)