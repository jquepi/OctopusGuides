#!/bin/bash

if [ -n "$WISTIA_MEDIA_ID" ]; then
  /opt/jdk-17.0.1/bin/java \
    "-Xmx2g" \
    "-Dwebdriver.gecko.driver=/usr/bin/geckodriver" \
    "-DstepPause=$STEP_PAUSE" \
    "-DCucumberAlias-GuideSpecificScreenshotDir=$SCREENSHOT_PATH" \
    "-DCucumberAlias-ExternalMediaPath=$MEDIA_PATH" \
    "-DmoveCursorToElement=false" \
    "-DmouseMoveVerticalOffset=$MOUSE_VERTICAL_OFFSET" \
    "-DdisableHighlights=true" \
    "-DdisableScreenshots=true" \
    "-DslackHookUrl=$SLACK_HOOK_URL" \
    "-DscreenshotS3Enabled=$STHREE_SCREENSHOT_ENABLED" \
    "-DscreenshotS3Bucket=$SCREENSHOT_BUCKET" \
    "-DstepHandlerMessage=$GITHUB_SHA" \
    "-DslackStepHandlerEnabled=$SLACK_STEP_HANDLER" \
    "-DslackStepHandlerErrorOnly=$SLACK_ON_ERROR_ONLY" \
    "-DCucumberAlias-ExternalWistiaUsername=$WISTIA_USERNAME" \
    "-DCucumberAlias-ExternalWistiaPassword=$WISTIA_PASSWORD" \
    "-DCucumberAlias-ExternalMediaID=$WISTIA_MEDIA_ID" \
    "-DCucumberAlias-ExternalBrowserType=$BROWSER_TYPE" \
    -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
    --tags "$CUCUMBER_TAGS" \
    features/wistia/replace-video-linux.feature
fi
