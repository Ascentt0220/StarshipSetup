$FontPath = Test-Path -Path "$env:USERPROFILE\Fonts" -ErrorAction SilentlyContinue

if ($FontPath -eq $false) {
    New-Item -Path "$env:USERPROFILE\Fonts" -Name "Fonts" -ItemType "Directory" -Force
    Write-Host "Created Fonts directory at $env:USERPROFILE\Fonts" -ForegroundColor Green
}

$ChocoInstalled = Test-Path -Path "$env:PROGRAMDATA\chocolatey" -ErrorAction SilentlyContinue

if ($ChocoInstalled -eq $false) {
    Write-Host "Installing Chocolatey..." -ForegroundColor Cyan
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Host "Chocolatey has been installed" -ForegroundColor Green
}

if ($ChocoInstalled) {
    Write-Host "Installing FiraCode font" -ForegroundColor Cyan
    choco install firacode -y
    Write-Host "FiraCode font has been installed." -ForegroundColor Green
}

$FontInstalled = Get-ChildItem -Path "$env:USERPROFILE\Fonts" -Filter "FiraCode*" -ErrorAction SilentlyContinue

if ($FontInstalled.Count -gt 0) {
    Write-Host "Installing starship..." -ForegroundColor Cyan
    choco install starship -y
    Write-Host "Starship has been installed" -ForegroundColor Green
}

$StarshipConfig = "$env:USERPROFILE\.config\starship.toml"
$StarshipConfigExists = Test-Path -Path $StarshipConfig -ErrorAction SilentlyContinue

if ($StarshipConfigExists -eq $false) {
    New-Item -Path "$env:USERPROFILE" -Name ".config" -ItemType "Directory" -Force
    iwr -Uri "https://raw.githubusercontent.com/Ascentt0220/StarshipSetup/refs/heads/main/starship.toml" -OutFile "$env:USERPROFILE\.config\starship.toml"
}

Write-Host "Starship setup is complete. Please restart your terminal to apply the changes." -ForegroundColor Green