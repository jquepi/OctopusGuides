#!/bin/bash

sudo npm install -g gh-badges
mkdir "$MEDIA_PATH/badges"
badge verified "$(date "+%d %b %y")" :green .svg @flat > "$MEDIA_PATH/badges/$BUILD_NAME.svg"
aws s3 cp "$MEDIA_PATH/badges/$BUILD_NAME.svg" s3://i.octopus.com/guides/badges/ --acl public-read