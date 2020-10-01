#!/bin/bash

MICROK8S_TOKEN=$(microk8s.kubectl config view --raw -o json | jq -r '.users[0].user.token' | tr -d '"')

/opt/jdk-15/bin/java \
  "-Xmx2g" \
  "-Dwebdriver.gecko.driver=/usr/bin/geckodriver" \
  "-DstepPause=$STEP_PAUSE" \
  "-DCucumberAlias-GuideSpecificScreenshotDir=$SCREENSHOT_PATH" \
  "-DCucumberAlias-ExternalMediaPath=$MEDIA_PATH" \
  "-DmoveCursorToElement=$MOVE_TO_MOUSE_CURSOR" \
  "-DmouseMoveVerticalOffset=$MOUSE_VERTICAL_OFFSET" \
  "-DdisableHighlights=$DISABLE_HIGHLIGHTS" \
  "-DdisableScreenshots=$DISABLE_SCREENSHOTS" \
  "-DdisableVideoRecording=$DISABLE_VIDEO" \
  "-DslackHookUrl=$SLACK_HOOK_URL" \
  "-DscreenshotS3Enabled=$STHREE_SCREENSHOT_ENABLED" \
  "-DscreenshotS3Bucket=$SCREENSHOT_BUCKET" \
  "-DstepHandlerMessage=$GITHUB_SHA" \
  "-DslackStepHandlerEnabled=$SLACK_STEP_HANDLER" \
  "-DslackStepHandlerErrorOnly=$SLACK_ON_ERROR_ONLY" \
  "-DCucumberAlias-ExternalBrowserType=$BROWSER_TYPE" \
  "-DCucumberAlias-ExternalMicroK8SToken=$MICROK8S_TOKEN" \
  -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
  --tags "$CUCUMBER_TAGS" \
  features/octopus/octopus-create-microk8s-account.feature
