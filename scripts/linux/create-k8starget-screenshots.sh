#!/bin/bash

MINIKUBE_IP=`cat /tmp/minikubeip.txt`
echo "Minikube IP: $MINIKUBE_IP:8443"

/opt/jdk-17.0.1/bin/java \
  "-Xmx2g" \
  "-Dwebdriver.gecko.driver=/usr/bin/geckodriver" \
  "-Dwebdriver.firefox.marionette=false" \
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
  "-DCucumberAlias-ExternalEnvironmentName=Prod" \
  "-DCucumberAlias-ExternalTargetName=Kubernetes Prod" \
  "-DCucumberAlias-ExternalEnvironment=//span[./div/div/div[text()='Prod']]" \
  "-DCucumberAlias-ExternalNamespace=randomquotes-prod" \
  "-DCucumberAlias-ExternalK8SIP=$MINIKUBE_IP:8443" \
  "-DCucumberAlias-ExternalBrowserType=$BROWSER_TYPE" \
  -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
  --tags "$CUCUMBER_TAGS" \
  features/octopus/octopus-create-k8s-target.feature

/opt/jdk-17.0.1/bin/java \
  "-Xmx2g" \
  "-Dwebdriver.gecko.driver=/usr/bin/geckodriver" \
  "-Dwebdriver.firefox.marionette=false" \
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
  "-DCucumberAlias-ExternalEnvironmentName=Test" \
  "-DCucumberAlias-ExternalTargetName=Kubernetes Test" \
  "-DCucumberAlias-ExternalEnvironment=//span[./div/div/div[text()='Test']]" \
  "-DCucumberAlias-ExternalNamespace=randomquotes-test" \
  "-DCucumberAlias-ExternalK8SIP=$MINIKUBE_IP:8443" \
  "-DCucumberAlias-ExternalBrowserType=$BROWSER_TYPE" \
  -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
  --tags "$CUCUMBER_TAGS" \
  features/octopus/octopus-create-k8s-target.feature

/opt/jdk-17.0.1/bin/java \
  "-Xmx2g" \
  "-Dwebdriver.gecko.driver=/usr/bin/geckodriver" \
  "-Dwebdriver.firefox.marionette=false" \
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
  "-DCucumberAlias-ExternalEnvironmentName=Dev" \
  "-DCucumberAlias-ExternalTargetName=Kubernetes Dev" \
  "-DCucumberAlias-ExternalEnvironment=//span[./div/div/div[text()='Dev']]" \
  "-DCucumberAlias-ExternalNamespace=randomquotes-dev" \
  "-DCucumberAlias-ExternalK8SIP=$MINIKUBE_IP:8443" \
  "-DCucumberAlias-ExternalBrowserType=$BROWSER_TYPE" \
  -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
  --tags "$CUCUMBER_TAGS" \
  features/octopus/octopus-create-k8s-target.feature


