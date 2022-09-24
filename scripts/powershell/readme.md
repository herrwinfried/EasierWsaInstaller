# install.ps1
## Parametres

### `nostop` Parametres

> After the process is complete, it waits for you to press a key.

- `-nostop 0` - No

- `-nostop 1` - Yes

### `original` Parametres

> Loads the msixpackage file. Otherwise, the custom wsa will be loaded.

- `-original 0` - No

- `-original 1` - Yes

# guisetup.ps1

> **NOTE: It is designed for GUI project. It works according to bash/install.sh. If you write too many values, you will not get an error, unnecessary parameters will not work.**

## Parametres

### `wsldistro` Parametres

> launches on a distribution of your choice. script

- `-wsldistro Ubuntu` [Default]
- `-wsldistro Debian` [alternative]
- `-wsldistro openSUSE-Tumbleweed` [alternative]
- `-wsldistro {WSLDistro}` - WSLDistro (which you specify) starts with the deployment. However, you may encounter an error because no support is provided.

### `arch` Parametres

> lets you choose which arch you want to download.

- `-arch amd64` [Default]
- `-arch arm64`

### `scriptlang` Parametres

> determines the script language.

- `-scriptlang en-us` [default]
- `-scriptlang tr-tr`
- `-scriptlang de-de`

### `method` Parametres

> Allows you to select the method to be applied.

- `-method magiskonwsalocal` [default]
- `-method wsagascript`
- `-method onlywsa`

### `wsarelease` Parametres

> Allows you to select your WSA Release version.

- `-wsarelease retail` [default]
- `-wsarelease fast`
- `-wsarelease slow`
- `-wsarelease rp`

### `magiskversion` Parametres

> Allows you to select your magisk version.

- `-magiskversion stable` [default]
- `-magiskversion beta`
- `-magiskversion canary`
- `-magiskversion debug`

### `amazonstore` Parametres

> Specify whether to delete amazon store.

- `-amazonstore no` [default]
- `-amazonstore yes`

### `wsatools` Parametres

> Choose whether to install wsatools.

- `-wsatools no` [default]
- `-wsatools yes`

### `productname` Parametres

> Set/change product name.

- `-productname redfin` [default]
- `-productname $USER` ~ set productname $USER(which you specify)

### `gappsvariant` Parametres

> Lets you choose the opengapps version.

- `-gappsvariant pico` [default]
- `-gappsvariant super`
- `-gappsvariant stock`
- `-gappsvariant full`
- `-gappsvariant mini`
- `-gappsvariant micro`
- `-gappsvariant nano`

### `winvmp` Parametres

> Would you like to activate the virtual machine platform feature?

- `-winvmp yes` [default]
- `-winvmp no`

### `windevmode` Parametres

> Would you like to activate windows developer mode and WSA Developer mode?

- `-winvmp yes` [default]
- `-winvmp no`

### `adb` Parametres

> Do you want to install adb?

- `-winvmp no` [default]
- `-winvmp yes`