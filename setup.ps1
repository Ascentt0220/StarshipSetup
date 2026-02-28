$ChocoInstalled = Test-Path -Path "$env:PROGRAMDATA\chocolatey" -ErrorAction SilentlyContinue

if ($ChocoInstalled -eq $false) {
    Write-Host "Please install Chocolatey first" -ForegroundColor Cyan
    Write-Host "Exiting the script..." -ForegroundColor Yellow
    exit
}

try {
    if ($ChocoInstalled -eq $true) {
        Write-Host 'Installing FiraCode font' -ForegroundColor Cyan
        choco install firacode -y
        Write-Host 'FiraCode font has been installed.' -ForegroundColor Green
    }
}
catch {
    Write-Host 'An error occurred while installing FiraCode font: $_' -ForegroundColor Red
    Write-Host 'Exiting the script.' -ForegroundColor Yellow
    exit
}

$FontInstalled = Get-ChildItem -Path 'C:\Windows\fonts' -Filter 'FiraCode*' -ErrorAction SilentlyContinue

try {
    if ($FontInstalled.Count -gt 0) {
        Write-Host 'Installing starship...' -ForegroundColor Cyan
        choco install starship -y
        Write-Host 'Starship has been installed' -ForegroundColor Green
    }
}
catch {
    Write-Host 'An error occurred while installing Starship: $_' -ForegroundColor Red
    Write-Host 'Exiting the script.' -ForegroundColor Yellow
    exit
}

$StarshipConfig = "$env:USERPROFILE\.config\starship.toml"
$StarshipConfigExists = Test-Path -Path $StarshipConfig -ErrorAction SilentlyContinue

try {
    if ($StarshipConfigExists -eq $false) {
        New-Item -Path "$env:USERPROFILE" -Name ".config" -ItemType "Directory" -Force
        iwr -Uri "https://raw.githubusercontent.com/Ascentt0220/StarshipSetup/refs/heads/main/starship.toml" -OutFile "$env:USERPROFILE\.config\starship.toml"
    }
}
catch {
    Write-Host "An error occurred while setting up Starship configuration: $_" -ForegroundColor Red
    Write-Host "Exiting the script." -ForegroundColor Yellow
    exit
}

if ($StarshipConfigExists -eq $true) {
    Write-Host "Starship setup is complete. Please restart your terminal to apply the changes" -ForegroundColor Cyan
}