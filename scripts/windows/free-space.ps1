# Some Azure Devops builds run out of space, so compress the drive to give us enough space.

$ErrorActionPreference = "SilentlyContinue"

cd "C:\Program Files"
compact /c /s /i

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