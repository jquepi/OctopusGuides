#!/bin/bash

npm install -g gh-badges
mkdir "$MEDIA_PATH/badges"
badge verified "$(date "+%d %b %y")" :green .svg @flat > "$MEDIA_PATH/badges/$BUILD_NAME.svg"