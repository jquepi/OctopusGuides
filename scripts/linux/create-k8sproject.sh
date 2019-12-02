#!/bin/bash

/usr/lib/jvm/java-13-openjdk-amd64/bin/java \
  "--enable-preview" \
  "-Xmx2g" \
  "-Xmx2g" \
  "--enable-preview" \
  "-Xmx2g" \
  "-Dwebdriver.gecko.driver=/usr/bin/geckodriver" \
  "-DCucumberAlias-GuideSpecificScreenshotDir=$SCREENSHOT_PATH" \
  "-DCucumberAlias-ExternalMediaPath=$MEDIA_PATH" \
  "-DmoveCursorToElement=$MOVE_TO_MOUSE_CURSOR" \
  "-DmouseMoveVerticalOffset=$MOUSE_VERTICAL_OFFSET_CHROME" \
  "-DdisableHighlights=$DISABLE_HIGHLIGHTS" \
  "-DdisableScreenshots=$DISABLE_SCREENSHOTS" \
  "-DdisableVideoRecording=$DISABLE_VIDEO" \
  "-DslackHookUrl=$SLACK_HOOK_URL" \
  "-DscreenshotS3Enabled=$STHREE_SCREENSHOT_ENABLED" \
  "-DscreenshotS3Bucket=$SCREENSHOT_BUCKET" \
  "-DstepHandlerMessage=$GITHUB_SHA" \
  "-DslackStepHandlerEnabled=true" \
  "-DCucumberAlias-ExternalBrowserType=ChromeNoImplicitWait" \
  "-DCucumberAlias-ExternalDockerImage=$DOCKER_IMAGE" \
  "-DCucumberAlias-ExternalConfigFile=$CONFIG_FILE" \
  "-DCucumberAlias-ExternalConfigMountPath=$CONFIG_FILE_MOUNT_PATH" \
  "-DCucumberAlias-ExternalConfigFileName=$CONFIG_FILE_NAME" \
  -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
  --tags "$CUCUMBER_TAGS" \
  --plugin progress \
  --monochrome \
  features/octopus/octopus-k8s-project.feature
