#!/bin/bash

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
  "-DCucumberAlias-ExternalTargetName=Kubernetes" \
  "-DCucumberAlias-ExternalEnvironment=//span[./div/div/div[text()='Dev']]" \
  "-DCucumberAlias-ExternalNamespace=randomquotes-dev" \
  "-DCucumberAlias-ExternalUrl=http://localhost:8081/index.html" \
  "-DCucumberAlias-Screenshot=nginx-random-quotes-dev-app.png" \
  "-DCucumberAlias-ExternalBrowserType=$BROWSER_TYPE" \
  -jar /opt/webdrivertraining.1.0-SNAPSHOT.jar \
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

FILES=/etc/nginx/conf.d/RandomQuotes.conf.d/*
for f in $FILES
do
  sudo cat "$f"
done

if [ -d /home/Octopus/Applications ]; then
  ls -Rla /home/Octopus/Applications
fi

if [ -d /etc/systemd/system ]; then
  ls -Rla /etc/systemd/system
fi

if [ -f /etc/systemd/system/RandomQuotes.service ]; then
  sudo cat /etc/systemd/system/RandomQuotes.service
  sudo systemctl status RandomQuotes.service
  sudo journalctl -u RandomQuotes.service
fi

if [ -f /home/Octopus/Applications/Dev/RandomQuotes/1.0.1/log/unicorn.stderr.log ]; then
  sudo cat /home/Octopus/Applications/Dev/RandomQuotes/1.0.1/log/unicorn.stderr.log
fi

if [ -f /home/Octopus/Applications/Dev/RandomQuotes/1.0.1/log/unicorn.stdout.log ]; then
  sudo cat /home/Octopus/Applications/Dev/RandomQuotes/1.0.1/log/unicorn.stdout.log
fi
