# Automatic
This script combines only powershell and bash scripts. __You have to download opengapps and WSA yourself and put them in their locations.__ **Note that you have to do all the basic requirements in the readme.**

## What you need to do before running a powershell script

Run as Administrator Powershell.
Or Install manually. I talked about it below.

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

Making change permission default for Powershell

```
Set-ExecutionPolicy -ExecutionPolicy Restricted
```

## [Ubuntu](https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6)

```
Invoke-WebRequest https://raw.githubusercontent.com/herrwinfried/wsa-script/main/automatic-ubuntu.ps1 -OutFile $HOME\Downloads\automatic-ubuntu.ps1 && .\automatic-ubuntu.ps1
```

## [openSUSE Tumbleweed](https://www.microsoft.com/en-us/p/opensuse-tumbleweed/9mssk2zxxn11)

```
Invoke-WebRequest https://raw.githubusercontent.com/herrwinfried/wsa-script/main/automatic-opensusetw.ps1 -OutFile $HOME\Downloads\automatic-opensusetw.ps1 && cd $HOME\Downloads && .\automatic-opensusetw.ps1
```
