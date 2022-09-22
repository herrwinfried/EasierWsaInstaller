
# Warn

1. **This is an experimental project. We are not responsible for an incident that you will encounter. Do it within your own consciousness.**

2. This method is experimental. Made easy for you to enter fewer commands.

# BETA
**Not Stable. Still under construction, not finished yet.**

# What is wsa-script?

Our project is a simple CLI that makes it easier to install WSAGAScript, MagiskOnWSA Local and original wsa(download).

# why keep wsagascript and magiskonwsalocal projects inside your own project?

We thought it would be more logical to use it after reviewing the update coming to the projects so that it can work properly, so it is in the project. There is no play involved. (Except for product name change etc.)

# Command lines not for you?
[Try our wsa-gui project](https://github.com/herrwinfried/wsa-gui#readme)

# An amateur video showing the installation

Soon...

# Information before you start

You need to remove the existing WSA.

___The ARM version is still beta, please give feedback when you encounter an error.___ **(Applicable if you are going to use the wsagascript and magiskonwsalocal method.)**

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

> Open windows terminal as administrator. You can easily enable it by typing the following command. You should have enabled Ubuntu, OpenSUSE Tumbleweed or Debian WSL when you installed it.

> ```
> dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
> ```
> You need to Activate [WSL](https://aka.ms/wslstorepage) also to use ubuntu, openSUSE Tumbleweed or Debian

# What to do before you start

- Create a folder named `wsaproject` under the `C` directory. (`C:\wsaproject`)
- Create a folder named `wsa` under the `C` directory. (`C:\wsa`)

> NOTE: If you are going to do WSA Upload only. You do not need to create a WSA folder.

# Information before you start

You need to remove the existing WSA.

___The ARM version is still beta, please give feedback when you encounter an error.___ **(Applicable if you are going to use the opengapps + wsa method.)**

## Parametres
All the parameters you need to know to make things easier.
### Global Parametres
- `--arm` ~ Allows you to select the architect as arm.
> Unless you enter arm value, 64 bit is selected as normal processor.
- `--wsatools=yes` ~ it will download WSATools for you.
### Method Parametres
- `--onlywsa` ~ It only downloads WSA.
- `--wsagascript` ~ Upload Opengapps to WSA using wsagascript method *(Degraded file)*
- `--magiskonwsalocal` ~ Upload Opengapps and magisk to WSA using wsagascript method *(Degraded file)*

### `wsarelease` parametres

>**Valid for all methods.**

- `wsarelease=fast`
- `wsarelease=slow`
- `wsarelease=rp`
- `wsarelease=retail` [Default]

### `magiskversion` parametres

>**only magiskonwsalocal method is valid.**

- `magiskversion=debug`
- `magiskversion=canary`
- `magiskversion=beta`
- `magiskversion=stable` [Default]

### `amazonstore` parametres

>**only magiskonwsalocal and wsagascript method is valid.**

- `amazonstore=yes`
- `amazonstore=no` [Default]

### `wsatools` parametres

>**Valid for all methods**

- `wsatools=yes`
- `wsatools=no` [Default]

### `productname` parametres

>**only magiskonwsalocal and wsagascript method is valid.**

- `productname=$NAME` ~ Set Product name $NAME
- `productname=redfin` [Default]

### `productname` parametres

>**only magiskonwsalocal and wsagascript method is valid.**

- `productname=super`
- `productname=stock`
- `productname=full`
- `productname=mini`
- `productname=micro`
- `productname=nano`
- `productname=pico` [Default]

# Credits

- [MagiskOnWSALocal](https://github.com/LSPosed/MagiskOnWSALocal)
- [WSAGAScript](https://github.com/ADeltaX/WSAGAScript)
- [WSA-Kernel-SU](https://github.com/LSPosed/WSA-Kernel-SU)
- [kernel-assisted-superuser](https://git.zx2c4.com/kernel-assisted-superuser/)
- [Magisk](https://github.com/topjohnwu/Magisk)
- [The Open GApps Project](https://opengapps.org/)