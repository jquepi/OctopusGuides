#!/bin/bash

MINIKUBE_IP=`cat /tmp/minikubeip.txt`
echo "Minikube IP: $MINIKUBE_IP:8443"

echo "NODES"
sudo kubectl describe nodes

echo "PODS"
sudo kubectl get pods --all-namespaces
sudo kubectl describe pods -n randomquotes-test

echo "DEPLOYMENT"
sudo kubectl describe deployment randomquotes -n randomquotes-test

echo "SERVICES"
sudo kubectl get services --all-namespaces

echo "TEST SERVICES"
sudo kubectl describe service randomquotes -n randomquotes-test

/usr/lib/jvm/java-14-openjdk-amd64/bin/java \
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
  "-DCucumberAlias-ExternalEnvironmentName=Test" \
  "-DCucumberAlias-ExternalTargetName=Kubernetes" \
  "-DCucumberAlias-ExternalEnvironment=//span[./div/div/div[text()='Test']]" \
  "-DCucumberAlias-ExternalNamespace=randomquotes-test" \
  "-DCucumberAlias-ExternalUrl=http://$MINIKUBE_IP:$K8S_TEST_NODEPORT" \
  "-DCucumberAlias-Screenshot=k8s-random-quotes-test-app.png" \
  "-DCucumberAlias-ExternalBrowserType=$BROWSER_TYPE" \
  -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
  --tags "$CUCUMBER_TAGS" \
  features/octopus/open-randomquotes-generic.feature