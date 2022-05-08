# Show the "This PC" icon on Desktop
Write-Output "Show This PC ..."
if (-not (Test-Path -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel))
{
	New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Force
}
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -PropertyType DWord -Value 0 -Force


# Enable the Windows 10 File Explorer
Write-Output "Enable Windows 10 File Explorer ..."
if (-not (Test-Path -Path "HKCU:\Software\Classes\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}\InprocServer32"))
{
	New-Item -Path "HKCU:\Software\Classes\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}\InprocServer32" -Force
}
New-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}\InprocServer32" -Name "(default)" -PropertyType String -Value "" -Force


# Show hidden files, folders, and drives
Write-Output "Enable Hidden Items ..."
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Hidden -PropertyType DWord -Value 1 -Force


# Show file name extensions
Write-Output "Show File Extensions ..."
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideFileExt -PropertyType DWord -Value 0 -Force


# Open File Explorer to "This PC"
Write-Output "This PC Open File Explorer To ..."
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -PropertyType DWord -Value 1 -Force


# Show the file transfer dialog box in the detailed mode
Write-Output "Setting Detailed File Transfer Dialog ..."
if (-not (Test-Path -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager))
{
	New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager -Force
}
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager -Name EnthusiastMode -PropertyType DWord -Value 1 -Force


# Hide recently used files in Quick access
Write-Output "Hide Quick Access Recent Files ..."
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowRecent -PropertyType DWord -Value 0 -Force


# Set the taskbar alignment to the left
Write-Output "Setting Left Taskbar Alignment ..."
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarAl -PropertyType DWord -Value 0 -Force


# Hide the search icon on the taskbar
Write-Output "Hide Taskbar Search ..."
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name SearchboxTaskbarMode -PropertyType DWord -Value 0 -Force


# Hide the Task view button on the taskbar
Write-Output "Hide Task View Button ..."
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowTaskViewButton -PropertyType DWord -Value 0 -Force


# Hide the widgets icon on the taskbar
Write-Output "Hide Taskbar Widgets ..."
if (Get-AppxPackage -Name MicrosoftWindows.Client.WebExperience)
{
	New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarDa -PropertyType DWord -Value 0 -Force
}


# Hide the Chat icon (Microsoft Teams) on the taskbar
Write-Output "Hide Taskbar Chat ..."
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarMn -PropertyType DWord -Value 0 -Force


# Notify me when a restart is required to finish updating
Write-Output "Show Restart Notification ..."
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings -Name RestartNotificationsAllowed2 -PropertyType DWord -Value 1 -Force


# Do not add the "- Shortcut" suffix to the file name of created shortcuts
Write-Output "Disable Shortcuts Suffix ..."
if (-not (Test-Path -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates))
{
	New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates -Force
}
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates -Name ShortcutNameTemplate -PropertyType String -Value "%s.lnk" -Force


# Use the Print screen button to open screen snipping
Write-Output "Enable PrtScn Snipping Tool ..."
New-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name PrintScreenKeyForSnippingEnabled -PropertyType DWord -Value 1 -Force


# Do not use a different input method for each app window
Write-Output "Disable Apps Language Switch ..."
Set-WinLanguageBarOption


# Disable bluetooth icon to taskbar
Write-Output "Disable bluetooth icon to taskbar ..."
New-ItemProperty -Path "HKCU:\Control Panel\Bluetooth" -Name "Notification Area Icon" -PropertyType DWord -Value 0 -Force


# Rename sytem disk
Write-Output "Rename system disk ..."
label c: "Windows"


# W11 - Old Context Menu
Write-Output "W11 - Old Context Menu ..."
If (!(Test-Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32")) {
	New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" | Out-Null
}
stop-process -name explorer –force


# Remove shortcut
Write-Output "Remove shortcut ..."
Remove-Item "C:\Users\jeremy\Desktop\*.lnk"
Remove-Item "C:\Users\Public\Desktop\*.lnk"


# Set full name to user jeremy
Write-Output "Set full name ..."
Set-LocalUser -Name "jeremy" -FullName "Jérémy"


# Set the default Windows mode to dark
Write-Output "Setting Dark Windows Color Mode ..."
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -PropertyType DWord -Value 0 -Force


# Set the default app mode to dark
Write-Output "Setting Dark App Color Mode ..."
New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -PropertyType DWord -Value 0 -Force


# Showing all tray icons
Write-Output "Showing all tray icons ..."
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0
If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
	New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
}
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoAutoTrayNotify" -Type DWord -Value 1