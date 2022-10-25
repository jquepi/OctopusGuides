#!/bin/bash

# Convert png files to webp
find $MEDIA_PATH -name '*.png' -type f -exec bash -c 'cwebp -q 80 "$0" -o "${0%.png}.webp"' {} \;

# Upload all files
aws s3 sync "$MEDIA_PATH" s3://i.octopus.com/guides --acl public-read