# Upgrade to PowerShell 7
# Check PowerShell version and upgrade if necessary.
if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host "Upgrading to PowerShell 7..."
    # Install PowerShell 7
    Invoke-Expression "& { iwr https://aka.ms/install-powershell.ps1 -UseBasicParsing | iex }"
    Write-Host "PowerShell 7 installed. Please restart the session to use PowerShell 7."
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
