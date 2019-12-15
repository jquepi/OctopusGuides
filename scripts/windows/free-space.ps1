# Some Azure Devops builds run out of space, so compress the drive to give us enough space.
# This script is run before the apps are installed, and then again after

$ErrorActionPreference = "SilentlyContinue"

# This gives us enough space to complete the install
cd C:\Windows
compact /c /s /i

# This gives us enough space to perform the deployments
if ( Test-Path -Path 'C:\Octopus' -PathType Container )
{
    cd C:\Octopus
    compact /c /s /i
}

if ( Test-Path -Path "C:\Program Files\Azure DevOps Server 2019" -PathType Container )
{
    cd "C:\Program Files\Azure DevOps Server 2019"
    compact /c /s /i
}