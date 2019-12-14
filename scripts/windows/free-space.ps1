# Some Azure Devops builds run out of space, so compress the drive to give us enough space.

$ErrorActionPreference = "SilentlyContinue"

mkdir "C:\Octopus"
mkdir "C:\Program Files\Azure DevOps Server 2019"

cd "C:\Program Files"
compact /c /s /i

cd C:\Octopus
compact /c /s /i
