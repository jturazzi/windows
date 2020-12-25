## Prepare for Windows installation

[Link to download Windows 10 ISO](https://tb.rg-adguard.net/public.php)

Copy the ei.cfg file to the Sources folder on the USB stick.

ei.cfg
```
[Channel]
Retail
```


## Chocolatey ( Package Manager for Windows )

Install with PowerShell
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```


Packages List
```
choco install 7zip -y
choco install authy-desktop -y
choco install bitwarden -y
choco install ccleaner -y
choco install chocolateygui -y
choco install crystaldiskinfo -y
choco install discord -y --ignore-checksums
choco install eddie -y
choco install etcher -y
choco install filezilla -y
choco install firefox -y
choco install git -y
choco install googlechrome -y
choco install jre8 -y
choco install mobaxterm -y
choco install nextcloud-client -y
choco install nmap -y
choco install nodejs-lts -y
choco install notepadplusplus -y
choco install putty -y
choco install qbittorrent -y
choco install rufus -y
choco install sourcetree -y
choco install spacedesk-server -y
choco install spotify -y
choco install teamviewer -y
choco install virustotaluploader -y
choco install vlc -y
choco install vscode -y
choco install wireguard -y
choco install whatsapp -y
choco install windirstat -y

:: On my gaming computer
choco install battle.net -y
choco install epicgameslauncher -y
choco install uplay -y
choco install steam -y
choco install streamdeck -y
choco install streamlabs-obs -y
```

Upgrade all packages
```
choco upgrade all -y
```

## TaskbarX - Center taskbar icons

[Link to download TaskbarX](https://chrisandriessen.nl/taskbarx)
