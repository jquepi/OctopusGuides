#!/bin/bash

aws s3 cp "$MEDIA_PATH/fast.mp4" "s3://i.octopus.com/guides/$VIDEO_FILE_NAME" --acl public-read
aws s3 cp "$MEDIA_PATH/trimmed.mp4" "s3://i.octopus.com/guides/trimmed-$VIDEO_FILE_NAME" --acl public-read