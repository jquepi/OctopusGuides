#!/bin/bash

# Dump the jenkins logs
cat /var/log/jenkins/jenkins.log

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
  "-DCucumberAlias-ArtifactPath=\${WORKSPACE}/target/randomquotes.1.0.\${BUILD_NUMBER}.war" \
  "-DCucumberAlias-ExternalBrowserType=$BROWSER_TYPE" \
  -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
  --tags "$CUCUMBER_TAGS" \
  features/jenkins/jenkins-javawar-git.feature
