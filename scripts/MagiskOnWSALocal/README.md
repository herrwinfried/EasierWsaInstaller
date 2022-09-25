# Magisk on WSA (with Google Apps)

## Support for generating from these systems

- Linux (x86_64 or arm64)

    The following dependencies are required: `setools lzip wine patchelf e2fsprogs aria2 python3 attr`

    The following components need to be installed using `winetricks`: `msxml6`

    The python3 library `requests` is used.

    Python version ≥ 3.7.
  - Recommended Use
    - Ubuntu (You can use [WSL2](https://apps.microsoft.com/store/search?publisher=Canonical%20Group%20Limited))

        Ready to use right out of the box.
    - Debian (You can use [WSL2](https://apps.microsoft.com/store/detail/debian/9MSVKQC78PK6))

        Need to add `contrib` sources to the source list to install winetricks.

    - OpenSUSE (You can use [WSL2](https://apps.microsoft.com/store/search?publisher=SUSE))

        Ready to use right out of the box.

    `run.sh` will handle all dependencies automatically.

    No need to type any commands.
  - Other Distributions

    Install the dependencies manually.

    Use the command-line program `build.sh`.

## Features

- Integrate Magisk and GApps in a few clicks within minutes
- Keep each build up to date
- Support both ARM64 and x64
- Support all OpenGApps variants except for aroma (aroma does not support x86_64, please use super instead)
- Remove Amazon Appstore
- Fix VPN dialog not showing (use our [VpnDialogs app](https://github.com/LSPosed/VpnDialogs))
- Add device management feature
- Unattended installation
- Automatically activates developers mode in Windows 11
- Update to the new version while preserving data with a one-click script
- Merged all language packs
- Support managing start menu icons (manually installing [WSAHelper](https://github.com/LSPosed/WSAHelper/releases/latest) to use this feature)

## Text Guide

1. Star (if you like)
1. Clone the repo to local
   - Run `build.sh --help` to get the usage if you want to use CLI.
1. Run `scripts/run.sh`
1. Select the WSA version and its architecture (mostly x64)
1. Select the version of Magisk
1. Choose which brand of GApps you want to install
   - OpenGApps

        Select the [OpenGApps variant](https://github.com/opengapps/opengapps/wiki#variants) you like.
   - MindtheGapps

       There is no other variant we can choose.
1. Select the root solution (none means no root)
1. Wait for the script to complete and the artifact will be in the `output` folder
1. Move the artifact to a place you like
1. Double-click `Run.bat`
    - If you previously have a MagiskOnWSA installation, it will automatically uninstall the previous one while **preserving all user data** and install the new one, so don't worry about your data.
    - If you have an official WSA installation, you should uninstall it first. (In case you want to preserve your data, you can backup `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalCache\userdata.vhdx` before uninstallation and restore it after installation.) (If you want to restore the icons to the start menu, please install and use [WSAHelper](https://github.com/LSPosed/WSAHelper/releases/latest).)
    - If the popup windows disappear **without asking administrative permission** and WSA is not installed successfully, you should manually run `Install.ps1` as administrator:
        1. Press `Win+x` and select `Windows Terminal (Admin)`
        2. Input `cd "{X:\path\to\your\extracted\folder}"` and press `enter`, and remember to replace `{X:\path\to\your\extracted\folder}` including the `{}`, for example `cd "D:\wsa"`
        3. Input `PowerShell.exe -ExecutionPolicy Bypass -File .\Install.ps1` and press `enter`
        4. The script will run and WSA will be installed
        5. If this workaround does not work, your PC is not supported for WSA
1. Magisk/Play store will be launched. Enjoy by installing LSPosed-zygisk with zygisk enabled or Riru and LSPosed-riru

## FAQ

- Can I delete the installed folder?

    No.
- How can I update WSA to a new version?

    Delete the `download` folder
    Rerun the script, replace the content of your previous installation and rerun `Install.ps1`. Don't worry, your data will be preserved.
- How can I get the logcat from WSA?

    `%LOCALAPPDATA%\Packages\MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe\LocalState\diagnostics\logcat`
- How can I update Magisk to a new version?

    Do the same as updating WSA
- How to pass safetynet?

    Like all the other emulators, no way.
- Virtualization is not enabled?

    `Install.ps1` helps you enable it if not enabled. After rebooting, rerun `Install.ps1` to install WSA. If it's still not working, you have to enable virtualization in BIOS. That's a long story so ask Google for help.
- How to remount the system as read-write?

    No way in WSA since it's mounted as read-only by Hyper-V. You can modify the system by making a Magisk module. Or directly modify the system.img. Ask Google for help.
- I cannot `adb connect localhost:58526`

    Make sure developer mode is enabled. If the issue persists, check the IP address of WSA on the setting page and try `adb connect ip:5555`.
- Magisk online module list is empty?

    Magisk actively removes the online module repository. You can install the module locally or by `adb push module.zip /data/local/tmp` and `adb shell su -c magisk --install-module /data/local/tmp/module.zip`.
- Can I use Magisk 23.0 stable or a lower version?

    No. Magisk has bugs preventing itself from running on WSA. Magisk 24+ has fixed them. So you must use Magisk 24 or higher version.
- How can I get rid of Magisk?

    Choose `none` as the root solution.
- How to install custom GApps?

    [Tutorial](./Custom-GApps.md)
- Where can I download MindtheGapps?

    You can download from here [MindtheGapps](https://androidfilehost.com/?w=files&flid=322935) ([mirror](http://downloads.codefi.re/jdcteam/javelinanddart/gapps))

    Note that there is no x86_64 pre-build, so you need to build it by yourself ([Repository](https://gitlab.com/MindTheGapps/vendor_gapps)).
- Can I switch OpenGApps to MindTheGapps and keep user data in a previous build?

    No. You should wipe data after changing the GApps brand. Otherwise, you will find that the installed GApps are not recognized.

## Credits

- [StoreLib](https://github.com/StoreDev/StoreLib): API for downloading WSA
- [Magisk](https://github.com/topjohnwu/Magisk): The most famous root solution on Android
- [The Open GApps Project](https://opengapps.org): One of the most famous Google Apps packages solution
- [WSA-Kernel-SU](https://github.com/LSPosed/WSA-Kernel-SU) and [kernel-assisted-superuser](https://git.zx2c4.com/kernel-assisted-superuser/): The kernel `su` for debugging Magisk Integration
- [WSAGAScript](https://github.com/ADeltaX/WSAGAScript): The first GApps integration script for WSA
