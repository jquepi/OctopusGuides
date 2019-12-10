# Do a disk cleanup
$vol = Get-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches
$vol.GetSubKeyNames() | ForEach-Object { $vol.OpenSubKey($_, $true).SetValue('StateFlags0000', 2) }
cleanmgr /SAGERUN:0

# Some Azure Devops builds run out of space, so compress the drive to give us enough space
#cd C:\Windows
#compact /c /s /i