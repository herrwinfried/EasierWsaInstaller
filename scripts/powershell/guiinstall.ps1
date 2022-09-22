# Automated Install script by Midonei
# http://github.com/doneibcn


# copy MagiskOnWSALocal
# + If the process is completed, it will be successfully closed without pressing the key.

function Test-Administrator {
    [OutputType([bool])]
    param()
    process {
        [Security.Principal.WindowsPrincipal]$user = [Security.Principal.WindowsIdentity]::GetCurrent();
        return $user.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator);
    }
}

function Finish {
    Clear-Host
    Start-Process "wsa://com.topjohnwu.magisk"
    Start-Process "wsa://com.android.vending"
}

if (-not (Test-Administrator)) {
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force
    $proc = Start-Process -PassThru -WindowStyle Hidden -Verb RunAs powershell.exe -Args "-executionpolicy bypass -command Set-Location '$PSScriptRoot'; &'$PSCommandPath' EVAL"
    $proc.WaitForExit()
    if ($proc.ExitCode -ne 0) {
        Clear-Host
        Write-Warning "Failed to launch start as Administrator`r`nPress any key to exit"
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    }
    exit
}
elseif (($args.Count -eq 1) -and ($args[0] -eq "EVAL")) {
    Start-Process powershell.exe -Args "-executionpolicy bypass -command Set-Location '$PSScriptRoot'; &'$PSCommandPath'"
    exit
}

if (((Test-Path -Path "WsaProxy","vendor.img","gfxstream_backend.dll","lxutil.dll","product.img","WsaSettingsBroker","Microsoft.UI.Xaml.winmd","networking_schema.json","Tools","system.img","WSACrashUploader","Licenses","networking.json","Assets","WsaSettings.exe","vclibs-x64.appx","userdata.vhdx","WsaService","Styles","WsaClient","Registry.dat","classicAppInstaller_WSA.sccd","wsldeps.dll","wslhost.exe","appcompatdb_schema.json","Images","xaml-x64.appx","WSACodecs.dll","libGLESv2.dll","wsldevicehost.dll","resources.pri","GSKServer","libEGL.dll","appcompatdb.json","AppxManifest.xml","metadata.vhdx","CustomInstall","wslcore.dll","system_ext.img","Fonts","WsaSettings.winmd") -eq $false).Count) {
    Write-Error "Some files are missing in the folder. Please try to build again. Press any key to exist"
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    exit 1
}

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

$VMP = Get-WindowsOptionalFeature -Online -FeatureName 'VirtualMachinePlatform'
if ($VMP.State -ne "Enabled") {
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'VirtualMachinePlatform'
    Clear-Host
    Write-Warning "Need restart to enable virtual machine platform`r`nPress y to restart or press any key to exit"
    $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    If ("y" -eq $key.Character) {
        Restart-Computer -Confirm
    }
    Else {
        exit 1
    }
}

Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Path vclibs-x64.appx
Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Path xaml-x64.appx

$Installed = $null
$Installed = Get-AppxPackage -Name 'MicrosoftCorporationII.WindowsSubsystemForAndroid'

If (($null -ne $Installed) -and (-not ($Installed.IsDevelopmentMode))) {
    Clear-Host
    Write-Warning "There is already one installed WSA. Please uninstall it first.`r`nPress y to uninstall existing WSA or press any key to exit"
    $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    If ("y" -eq $key.Character) {
        Remove-AppxPackage -Package $Installed.PackageFullName
    }
    Else {
        exit 1
    }
}
Clear-Host
Write-Host "Installing MagiskOnWSA..."
Stop-Process -Name "wsaclient" -ErrorAction "silentlycontinue"
Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml
if ($?) {
    Finish
}
Elseif ($null -ne $Installed) {
    Clear-Host
    Write-Host "Failed to update, try to uninstall existing installation while preserving userdata..."
    Remove-AppxPackage -PreserveApplicationData -Package $Installed.PackageFullName
    Add-AppxPackage -ForceApplicationShutdown -ForceUpdateFromAnyVersion -Register .\AppxManifest.xml
    if ($?) {
        Finish
    }
}
Start-Sleep -s 5
