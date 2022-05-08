# Turn on Storage Sense
Write-Output "Enable Storage Sense ..."
if (-not (Test-Path -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy))
{
	New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -ItemType Directory -Force
}
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Name 01 -PropertyType DWord -Value 1 -Force


# Turn on automatic cleaning up temporary system and app files
Write-Output "Enable Storage Sense Temp Files ..."
if ((Get-ItemPropertyValue -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Name 01) -eq "1")
{
	New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Name 04 -PropertyType DWord -Value 1 -Force
}	


# Run Storage Sense every month
Write-Output "Setting Month Storage Sense Frequency ..."
if ((Get-ItemPropertyValue -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Name 01) -eq "1")
{
	New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Name 2048 -PropertyType DWord -Value 30 -Force
}


# Disable hibernation
Write-Output "Disable Hibernation ..."
POWERCFG /HIBERNATE OFF


# Disable the Windows 260 character path limit
Write-Output "Disable Win32 Long Path Limit ..."
New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem -Name LongPathsEnabled -PropertyType DWord -Value 1 -Force


# Display the Stop error information on the BSoD
Write-Output "Enable BSoD Stop Error ..."
New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl -Name DisplayParameters -PropertyType DWord -Value 1 -Force


# Turn off Delivery Optimization
Write-Output "Disable Delivery Optimization ..."
New-ItemProperty -Path Registry::HKEY_USERS\S-1-5-20\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings -Name DownloadMode -PropertyType DWord -Value 0 -Force
Delete-DeliveryOptimizationCache -Force


# Set power plan on "High performance"
Write-Output "Setting High Power Plan ..."
POWERCFG /SETACTIVE SCHEME_MIN


# Disable help lookup via F1
Write-Output "Disable F1 Help Page ..."
if (-not (Test-Path -Path "HKCU:\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win64"))
{
	New-Item -Path "HKCU:\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win64" -Force
}
New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\win64" -Name "(default)" -PropertyType String -Value "" -Force


# Enable Num Lock at startup
Write-Output "Enable NumLock at startup ..."
New-ItemProperty -Path "Registry::HKEY_USERS\.DEFAULT\Control Panel\Keyboard" -Name InitialKeyboardIndicators -PropertyType String -Value 2147483650 -Force


# Turn off pressing the Shift key 5 times to turn Sticky keys
Write-Output "Disable Sticky Shift ..."
New-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name Flags -PropertyType String -Value 506 -Force


# Don't use AutoPlay for all media and devices
Write-Output "Disable Autoplay ..."
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers -Name DisableAutoplay -PropertyType DWord -Value 1 -Force


# Disable thumbnail cache removal
Write-Output "Disable Thumbnail Cache Removal ..."
New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" -Name Autorun -PropertyType DWord -Value 0 -Force


# Enable "Network Discovery" and "File and Printers Sharing" for workgroup networks
Write-Output "Enable Network Discovery ..."
$FirewallRules = @(
	# File and printer sharing		
	"@FirewallAPI.dll,-32752",

	# Network discovery
	"@FirewallAPI.dll,-28502"
)
if ((Get-CimInstance -ClassName CIM_ComputerSystem).PartOfDomain -eq $false)
{
	Set-NetFirewallRule -Group $FirewallRules -Profile Private -Enabled True
	Set-NetFirewallRule -Profile Public, Private -Name FPS-SMB-In-TCP -Enabled True
	Set-NetConnectionProfile -NetworkCategory Private
}


# Automatically adjust active hours for me based on daily usage
Write-Output "Setting Automatically Active Hours ..."
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings -Name SmartActiveHoursState -PropertyType DWord -Value 1 -Force


# Hide recently added apps in the Start menu
Write-Output "Hide Recently Added Apps ..."
if (-not (Test-Path -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer))
{
	New-Item -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Force
}
New-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name HideRecentlyAddedApps -PropertyType DWord -Value 1 -Force


# Run the Windows PowerShell shortcut from the Start menu as Administrator
Write-Output "Setting Elevated Run PowerShell Shortcut ..."
[byte[]]$bytes = Get-Content -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk" -Encoding Byte -Raw
$bytes[0x15] = $bytes[0x15] -bor 0x20
Set-Content -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell.lnk" -Value $bytes -Encoding Byte -Force


# Disable Xbox Game Bar tips
Write-Output "Disable Xbox Game Tips ..."
if ((Get-AppxPackage -Name Microsoft.XboxGamingOverlay) -or (Get-AppxPackage -Name Microsoft.GamingApp))
{
	New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\GameBar -Name ShowStartupPanel -PropertyType DWord -Value 0 -Force
}