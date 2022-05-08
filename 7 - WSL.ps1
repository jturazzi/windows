# Open PowerShell as administrator and run
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# Reboot computer

# Open PowerShell as administrator and run
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Reboot computer

# Open PowerShell as administrator and run
wsl --set-default-version 2

# Install Debian
winget install --id=Debian.Debian  -e