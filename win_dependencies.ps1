# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Wait for Chocolatey to be available in the current session
while (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Waiting for Chocolatey to be available..."
    Start-Sleep -Seconds 2
}

# Install make, fzf, and ripgrep using Chocolatey
choco install make -y
choco install fzf -y
choco install ripgrep -y
choco install nerd-fonts-hack -y

# Install Golang
choco install golang -y

Write-Host "Installation complete."
