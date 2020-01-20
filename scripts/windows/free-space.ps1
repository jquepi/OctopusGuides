# Some Azure Devops builds run out of space, so compress the drive to give us enough space.

$ErrorActionPreference = "SilentlyContinue"

cd C:\
compact /c /s /i

# Ensure MS SQL is an uncompressed directory
mkdir "C:\Program Files\Microsoft SQL Server"
compact /u /s /i
