#!/bin/bash

/usr/lib/jvm/java-13-openjdk-amd64/bin/java \
  "--enable-preview" \
  "-Xmx2g" \
  "-Dwebdriver.gecko.driver=/usr/bin/geckodriver" \
  "-DstepPause=$STEP_PAUSE" \
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
  "-DslackStepHandlerEnabled=$SLACK_STEP_HANDLER" \
  "-DslackStepHandlerErrorOnly=true" \
  "-DCucumberAlias-ExternalEnvironmentName=Dev" \
  "-DCucumberAlias-ExternalTargetName=Kubernetes" \
  "-DCucumberAlias-ExternalEnvironment=//span[./div/div/div[text()='Dev']]" \
  "-DCucumberAlias-ExternalNamespace=randomquotes-dev" \
  "-DCucumberAlias-ExternalUrl=http://localhost:8081/index.html" \
  "-DCucumberAlias-Screenshot=nginx-random-quotes-dev-app.png" \
  "-DCucumberAlias-ExternalBrowserType=ChromeNoImplicitWait" \
  -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
  --plugin progress \
  --tags "$CUCUMBER_TAGS" \
  features/octopus/open-randomquotes-generic.feature

if [ -f /var/log/php7.2-fpm.log ]; then
  sudo cat /var/log/php7.2-fpm.log
fi

if [ -f /var/log/nginx/error.log ]; then
  sudo cat /var/log/nginx/error.log
fi

if [ -f /etc/nginx/conf.d/RandomQuotes.conf ]; then
  sudo cat /etc/nginx/conf.d/RandomQuotes.conf
fi

if [ -d /etc/nginx/conf.d/RandomQuotes.conf.d ]; then
  ls -la /etc/nginx/conf.d/RandomQuotes.conf.d
fi

if [ -f /etc/nginx/conf.d/RandomQuotes.conf.d/location.0.conf ]; then
  sudo cat /etc/nginx/conf.d/RandomQuotes.conf.d/location.0.conf
fi

if [ -f /etc/nginx/conf.d/RandomQuotes.conf.d/location.1.conf ]; then
  sudo cat /etc/nginx/conf.d/RandomQuotes.conf.d/location.1.conf
fi

if [ -d /home/Octopus/Applications/Dev/RandomQuotes ]; then
  ls -la /home/Octopus/Applications/Dev/RandomQuotes
fi

if [ -d /home/Octopus/Applications/Dev/RandomQuotes/1.0.1 ]; then
  ls -la /home/Octopus/Applications/Dev/RandomQuotes/1.0.1
fi