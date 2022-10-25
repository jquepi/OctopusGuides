magick mogrify -format webP -define webp:lossless=false -path c:\screenshots *.png
& "C:\Program Files\Amazon\AWSCLIV2\aws.exe" s3 sync c:\screenshots s3://i.octopus.com/guides --acl public-read