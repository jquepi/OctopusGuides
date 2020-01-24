#!/bin/bash

# Generate a badge showing when the last video build was successfully run. This badge is included in the guides
# with a link to the blog post https://octopus.com/blog/devops-documentation
# We use https://npm.runkit.com/gh-badges to generatethe badge image

sudo npm install -g gh-badges
mkdir "$MEDIA_PATH/badges"
badge Verified "$(date "+%d %b %y")" :green .svg @flat > "$MEDIA_PATH/badges/$BUILD_NAME.svg"
aws s3 cp "$MEDIA_PATH/badges/$BUILD_NAME.svg" s3://i.octopus.com/guides/badges/ --acl public-read