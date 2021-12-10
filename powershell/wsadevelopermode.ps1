if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-ExecutionPolicy Bypass `"$PSCommandPath`" -nostop $nostopint" -Verb RunAs; exit }


reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"


$wsalocation = "$env:LOCALAPPDATA/Packages/MicrosoftCorporationII.WindowsSubsystemForAndroid_8wekyb3d8bbwe/Settings/settings.dat"
              $mountPoint = "HKLM\WSA"
reg load $mountPoint $wsalocation
              $develbit = "1"
              $data  = "Windows Registry Editor Version 5.00`n`n"
              $data += "[HKEY_LOCAL_MACHINE\WSA]`n`n"
              $data += "[HKEY_LOCAL_MACHINE\WSA\LocalState]`n"
              $data += "`"DeveloperModeEnabled`"=hex(5f5e10b):0"+ $develbit + ",07,b9,6f,f3,d3,dc,d7,01`n"
              $data | Out-File "./wsadevelopermode.reg"
[gc]::collect()
reg import "./wsadevelopermode.reg"
reg unload $mountPoint