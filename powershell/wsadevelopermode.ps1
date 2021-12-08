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