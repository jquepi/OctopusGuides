Get-ChildItem -Path c:\screenshots -Recurse -Include *.png | % {C:/tools/libwebp-1.2.4-windows-x64/bin/cwebp.exe -q 80 $_.FullName -o "$([System.IO.Path]::GetDirectoryName($_.FullName) + "\" + [System.IO.Path]::GetFileNameWithoutExtension($_.FullName)).webp"}

# Copy all images to a new dir called resized
mkdir c:\screenshots\resized
robocopy c:\screenshots c:\screenshots\resized /s

# Resize all the image in the new dir with a width of 800 pixels
Get-ChildItem -Path c:\screenshots\resized -Recurse -Include "*.*" | % {magick convert -resize "800x" $_.FullName $_.FullName}

& "C:\Program Files\Amazon\AWSCLIV2\aws.exe" s3 sync c:\screenshots s3://i.octopus.com/guides --acl public-read