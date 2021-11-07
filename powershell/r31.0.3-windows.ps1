if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


$Folder = 'C:\src\platform-tools'
if (Test-Path -Path $Folder) {
   Write-Host "I found folder named platform-tools and deleted it."
    Remove-Item C:\src\platform-tools -Recurse
} else {
}

Write-Host "I'm downloading platform-tools r31.0.3-windows."
Invoke-WebRequest https://dl.google.com/android/repository/platform-tools_r31.0.3-windows.zip -OutFile c:\src\platform-tools_r31.0.3-windows.zip
Write-Host "I unzip platform-tools r31.0.3-windows"
Expand-Archive c:\src\platform-tools_r31.0.3-windows.zip -DestinationPath c:\src\platform-tools_r31.0.3-windows
Write-Host "I find and extract the main folder"
Move-Item -Path  c:\src\platform-tools_r31.0.3-windows\platform-tools -Destination c:\src\platform-tools

Write-Host "I delete unnecessary files and folders."
Remove-Item  c:\src\platform-tools_r31.0.3-windows.zip -Recurse
Remove-Item  c:\src\platform-tools_r31.0.3-windows -Recurse

$pathContent = [Environment]::GetEnvironmentVariable('Path', 'Machine')
$myPath = 'c:\src\platform-tools'
if ($pathContent -ne $null)
{
  # "Exist in the system!"
  if ($pathContent -split ';'  -contains  $myPath)
  {
    # My path Exists
    Write-Host "I don't touch it because the path I will add is already there"
  }
  else
  {
    Write-Host "I add PATH as system. (It is added in the type that every user can use.)"
    $path = [Environment]::GetEnvironmentVariable('Path', 'Machine')
    $newpath = $path + ';c:\src\platform-tools'
    [Environment]::SetEnvironmentVariable("Path", $newpath, 'Machine')
    Write-Host "You may need to close all open CMD, Powershell, Terminal to use it. If it does not appear, restart your computer."
  }
}