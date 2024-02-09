# Install PowerShell 7 using winget
Write-Host "Installing PowerShell 7 using winget..."
winget install Microsoft.PowerShell -y

# Check if installation is successful
if (!(Get-Command pwsh -ErrorAction SilentlyContinue)) {
    Write-Host "PowerShell 7 installation failed. Please check the installation and try again."
    return
}

# Install Chocolatey
Write-Host "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Wait for Chocolatey to be available in the current session
while (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Waiting for Chocolatey to be available..."
    Start-Sleep -Seconds 2
}

# Install Neovim, make, fzf, ripgrep, and Golang using Chocolatey
Write-Host "Installing Neovim, make, fzf, ripgrep, and Golang..."
choco install neovim -y
choco install make -y
choco install fzf -y
choco install ripgrep -y
choco install golang -y

Write-Host "Installation complete."
