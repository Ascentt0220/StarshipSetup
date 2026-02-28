# StarshipSetup
Hands off installation of Starship and FiraCode nerdfont for the Windows Terminal default Powershell profile

Depends on chocolatey, make sure to install this first

Copy paste the following into powershell:
$script = "$env:TEMP\StarshipInstallScript.ps1"; iwr -uri "https://raw.githubusercontent.com/Ascentt0220/StarshipSetup/refs/heads/main/setup.ps1" -OutFile "$env:TEMP\StarshipInstallScript.ps1"; powershell -ExecutionPolicy Bypass -File $script; Remove-Item $script -Force