#!/bin/bash

if [ -n "$WISTIA_MEDIA_ID" ]; then
  /usr/lib/jvm/java-13-openjdk-amd64/bin/java \
    "--enable-preview" \
    "-Xmx2g" \
    "-Xmx2g" \
    "--enable-preview" \
    "-Xmx2g" \
    "-Dwebdriver.gecko.driver=/usr/bin/geckodriver" \
    "-DCucumberAlias-GuideSpecificScreenshotDir=$SCREENSHOT_PATH" \
    "-DCucumberAlias-ExternalMediaPath=$MEDIA_PATH" \
    "-DmoveCursorToElement=false" \
    "-DmouseMoveVerticalOffset=$MOUSE_VERTICAL_OFFSET_CHROME" \
    "-DdisableHighlights=true" \
    "-DdisableScreenshots=true" \
    "-DslackHookUrl=$SLACK_HOOK_URL" \
    "-DscreenshotS3Enabled=$STHREE_SCREENSHOT_ENABLED" \
    "-DscreenshotS3Bucket=$SCREENSHOT_BUCKET" \
    "-DstepHandlerMessage=$GITHUB_SHA" \
    "-DslackStepHandlerEnabled=false" \
    "-DCucumberAlias-ExternalWistiaUsername=$WISTIA_USERNAME" \
    "-DCucumberAlias-ExternalWistiaPassword=$WISTIA_PASSWORD" \
    "-DCucumberAlias-ExternalMediaID=$WISTIA_MEDIA_ID" \
    "-DCucumberAlias-ExternalBrowserType=ChromeNoImplicitWait" \
    -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
    --plugin progress \
    features/wistia/replace-video-linux.feature
fi
