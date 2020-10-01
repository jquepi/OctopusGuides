#!/bin/bash

API_KEY=`cat /tmp/api_key.txt`

/usr/lib/jvm/java-15-openjdk-amd64/bin/java \
  "--enable-preview" \
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
  "-DCucumberAlias-ExternalDockerUsername=$DOCKER_USERNAME" \
  "-DCucumberAlias-ExternalDockerPassword=$DOCKER_PASSWORD" \
  "-DCucumberAlias-ArtifactPath=target/randomquotes.1.0.\${bamboo.buildNumber}.war" \
  "-DCucumberAlias-ExternalBrowserType=$BROWSER_TYPE" \
  "-DCucumberAlias-Hostname=$(hostname)" \
  "-DCucumberAlias-ExternalBambooPlugin=/opt/bamboo.jar" \
  -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
  --tags "$CUCUMBER_TAGS" \
  features/bamboo/bamboo-javawar-project.feature
