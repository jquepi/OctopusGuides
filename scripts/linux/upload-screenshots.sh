#!/bin/bash

# Convert png files to webp
find $MEDIA_PATH -name '*.png' -type f -exec bash -c 'cwebp -q 80 "$0" -o "${0%.png}.webp"' {} \;

# Copy all images to a new dir called resized
mkdir $MEDIA_PATH/resized
cp -R $MEDIA_PATH $MEDIA_PATH/resized

# Resize all the image in the new dir with a width of 800 pixels
find $MEDIA_PATH/resized -name '*.*' -type f -exec bash -c 'mogrify -resize 800x "$0"' {} \;

# Upload all files
aws s3 sync "$MEDIA_PATH" s3://i.octopus.com/guides --acl public-read