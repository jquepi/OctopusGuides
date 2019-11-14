#!/bin/bash

SERVICE_URL=`minikube service service --url`

/usr/lib/jvm/java-13-openjdk-amd64/bin/java \
  "--enable-preview" \
  "-Xmx2g" \
  "-Dwebdriver.gecko.driver=/usr/bin/geckodriver" \
  "-DCucumberAlias-GuideSpecificScreenshotDir=$SCREENSHOT_PATH" \
  "-DmoveCursorToElement=$MOVE_TO_MOUSE_CURSOR" \
  "-DmouseMoveVerticalOffset=$MOUSE_VERTICAL_OFFSET" \
  "-DdisableHighlights=$DISABLE_HIGHLIGHTS" \
  "-DdisableScreenshots=$DISABLE_SCREENSHOTS" \
  "-DslackHookUrl=$SLACK_HOOK_URL" \
  "-DscreenshotS3Enabled=$STHREE_SCREENSHOT_ENABLED" \
  "-DscreenshotS3Bucket=$SCREENSHOT_BUCKET" \
  "-DstepHandlerMessage=$GITHUB_SHA" \
  "-DslackStepHandlerEnabled=true" \
  "-DCucumberAlias-ExternalEnvironmentName=Dev" \
  "-DCucumberAlias-ExternalTargetName=Kubernetes" \
  "-DCucumberAlias-ExternalEnvironment=//span[./div/div/div[text()='Dev']]" \
  "-DCucumberAlias-ExternalNamespace=randomquotes-dev" \
  "-DCucumberAlias-ExternalUrl=$SERVICE_URL" \
  -jar /opt/webdrivertraining-1.0-SNAPSHOT.jar \
  --plugin progress \
  --monochrome \
  features/octopus/open-randomquotes-azurewebapp.feature