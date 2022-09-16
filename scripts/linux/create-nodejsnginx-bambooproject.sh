#!/bin/bash

API_KEY=`cat /tmp/api_key.txt`

/opt/jdk-17.0.1/bin/java \
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
  "-DCucumberAlias-ExternalOctopusAPIKey=$API_KEY" \
  "-DCucumberAlias-GitUrl=$GIT_URL" \
  "-DCucumberAlias-ExternalDockerImage=$DOCKER_IMAGE" \
  "-DCucumberAlias-ExternalOctopusDockerImage=$OCTOPUS_DOCKER_IMAGE" \
  "-DCucumberAlias-ExternalDockerUsername=$DOCKER_USERNAME" \
  "-DCucumberAlias-ExternalDockerPassword=$DOCKER_PASSWORD" \
  "-DCucumberAlias-ExternalBrowserType=$BROWSER_TYPE" \
  "-DCucumberAlias-ArtifactPath=RandomQuotes.1.0.\${bamboo.buildNumber}.nupkg" \
  "-DCucumberAlias-Hostname=localhost" \
  "-DCucumberAlias-ExternalBambooPlugin=/opt/bamboo.jar" \
  -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
  --tags "$CUCUMBER_TAGS" \
  features/bamboo/bamboo-nodejs-project.feature

RETVALUE=$?
journalctl -u bamboo.service
exit $RETVALUE