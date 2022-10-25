#!/bin/bash

magick mogrify -format webP -define webp:lossless=false -path "$MEDIA_PATH" *.png
aws s3 sync "$MEDIA_PATH" s3://i.octopus.com/guides --acl public-read