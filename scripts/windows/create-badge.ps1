npm install -g gh-badges
mkdir "$($env:MEDIA_PATH)\badges"
$date = get-date -format "dd MMM yyyy"
badge Verified $date ":green" ".svg" "@flat" > "$($env:MEDIA_PATH)\badges\$($env:BUILD_NAME).svg"
& "C:\Program Files\Amazon\AWSCLI\bin\aws.exe" s3 cp "$($env:MEDIA_PATH)\badges\$($env:BUILD_NAME).svg" s3://i.octopus.com/guides/badges/ --acl public-read