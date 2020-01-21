# We need more space for our application stack, and the GitHub agents come with a lot of junk we
# didn't ask for and don't need.
# https://gist.github.com/mcasperson/d5abf6990185f0d74bca748f530f43d7 is a break down of the folders and their
# sizes in a Windows VM

Get-PSDrive C

Write-Host "Deleting C:\Program Files\boost"
rm -Recurse -Force "C:\Program Files\boost"
Write-Host "Deleting C:\Program Files\unity"
rm -Recurse -Force "C:\Program Files\unity"
Write-Host "Deleting c:\Program Files (x86)\Android"
rm -Recurse -Force "c:\Program Files (x86)\Android"
Write-Host "Deleting c:\Modules"
rm -Recurse -Force "c:\Modules"

Get-PSDrive C