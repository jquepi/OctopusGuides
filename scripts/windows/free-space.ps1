# Some Azure Devops builds run out of space, so compress the drive to give us enough space.
cd C:\Windows
compact /c /s /i

cd C:\Octopus
compact /c /s /i

cd "C:\Program Files\Azure DevOps Server 2019"
compact /c /s /i