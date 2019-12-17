# Some Azure Devops builds run out of space, so compress the drive to give us enough space.
# This script is run before the apps are installed, and then again after

$ErrorActionPreference = "SilentlyContinue"

# Prepare some installation directories to already be compressed
mkdir C:/install
cd C:\install
compact /c /s /i

mkdir C:/Octopus
cd C:\Octopus
compact /c /s /i

mkdir "C:\Program Files\Azure DevOps Server 2019"
cd "C:\Program Files\Azure DevOps Server 2019"
compact /c /s /i

mkdir "C:\Program Files\dotnet"
cd "C:\Program Files\dotnet"
compact /c /s /i

# This gives us enough space to complete the install
cd C:\Windows
compact /c /s /i
