$Host.UI.RawUI.WindowTitle = "EasierWsaInstaller Script for GUI requirements"


        if (-not ([System.Environment]::OSVersion.Version.Build -ge 22000)) {
            Write-Host "I don't support the Build..." -ForegroundColor red
            Start-Sleep -s 0.30
            Exit 1
        }
    

$ScriptArch = ($env:PROCESSOR_ARCHITECTURE)

if (!$ScriptArch) {
    Write-Host "Only Windows" -ForegroundColor Red;
    Start-Sleep -s 0.30
    Exit 1
}

elseif ($ScriptArch -eq 'x86' -or $ScriptArch -eq 'Arm32') {
    write-Host "Sorry I dont support $ScriptArch" -ForegroundColor Red;
    Start-Sleep -s 0.50
    Exit 1
}

$vmp = "Start-Process pwsh.exe -verb runas -ArgumentList '"
$vmp += "-c "
$vmp += "dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart"
$vmp += "'"
write-Host "EN: You will need administrator permission to enable the virtual machine platform..." -ForegroundColor yellow
write-Host "TR: Sanal makine platformunu etkinlestirmek icin yönetici iznine ihtiyaciniz olacak..." -ForegroundColor white -Background red
Start-Sleep -s 7
Invoke-Expression $vmp

function wingetx{
    param (
        [Parameter (Mandatory = $true)] [String]$Id
        )
$runnnx = "winget.exe install --id $Id --accept-package-agreements --accept-source-agreements"
        Invoke-Expression $runnnx
    }

wingetx -Id 9P9TQF7MRM4R
wingetx -Id 9PDXGNCFSCZV
wingetx -Id 9MZ1SNWT0N5D

write-Host "EN: Attention please" -ForegroundColor red
write-Host "TR: LUTFEN DIKKAT" -ForegroundColor white -Background red
write-Host "EN: If you want to delete Ubuntu, powershell core and WSL, use this command: " -ForegroundColor yellow
write-Host "TR: Ubuntu, powershell core ve WSL'yi silmek istiyorsaniz su komutu kullanin:" -ForegroundColor white -Background red
Write-Host " "
write-Host "winget.exe install --id 9P9TQF7MRM4R"
write-Host "winget.exe install --id 9PDXGNCFSCZV"
write-Host "winget.exe install --id 9MZ1SNWT0N5D"
Start-Sleep -s 3
write-Host "EN: If you want to turn off the virtual machine platform, you can turn it off if you type 'Turn Windows features on or off' in the search. " -ForegroundColor yellow
write-Host "TR: Sanal makine platformunu kapatmak istiyorsaniz arama kismina 'Windows ozelliklerini ac veya kapat' yazarsaniz kapatabilirsiniz." -ForegroundColor white -Background red
Write-Host " "
Start-Sleep -s 3
write-Host "EN: Don't forget to restart your computer! " -ForegroundColor yellow
write-Host "TR: Bilgisayarinizi yeniden baslatmayi unutmayin!" -ForegroundColor white -Background red
Write-Host " "
Start-Sleep -s 2
write-Host "EN: After rebooting, open the application named Ubuntu And perform the Installation. " -ForegroundColor yellow
write-Host "TR: Yeniden başlattıktan sonra Ubuntu isimli uygulamayı açın ve Kurulumu gerçekleştirin. " -ForegroundColor white -Background red
Write-Host " "


