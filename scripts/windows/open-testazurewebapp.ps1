& "C:\Program Files\OpenJDK\$((Get-ChildItem "C:\Program Files\OpenJDK\")[0])\bin\java" `
    "--enable-preview" `
    "-Xmx2g" `
    "-Dwebdriver.gecko.driver=C:\tools\geckodriver.exe" `
    "-DCucumberAlias-ExternalArtifactoryKey=$env:ARTIFACTORY_KEY" `
    "-DmoveCursorToElement=$env:MOVE_TO_MOUSE_CUSROR" `
    "-DmouseMoveVerticalOffset=$env:MOUSE_VERTICAL_OFFSET" `
    "-DdisableHighlights=$env:DISABLE_HIGHLIGHTS" `
    "-DdisableScreenshots=$env:DISABLE_SCREENSHOTS" `
    "-DdisableVideoRecording=$env:DISABLE_VIDEO" `
    "-DslackHookUrl=$env:SLACK_HOOK_URL" `
    "-DslackStepHandlerEnabled=false" `
    "-DslackStepHandlerErrorOnly=true" `
    "-DscreenshotS3Enabled=$env:STHREE_SCREENSHOT_ENABLED" `
    "-DscreenshotS3Bucket=$env:SCREENSHOT_BUCKET" `
    "-DstepHandlerMessage=$env:GITHUB_SHA" `
    "-DCucumberAlias-ExternalUrl=https://$($env:TEST_RES_GROUP).azurewebsites.net/" `
    "-DCucumberAlias-ExternalMediaPath=$env:MEDIA_PATH" `
    "-DCucumberAlias-GuideSpecificScreenshotDir=$env:SCREENSHOT_PATH" `
    "-DCucumberAlias-Screenshot=aspnet-random-quotes-test-app.png" `
    "-DCucumberAlias-ExternalBrowserType=FirefoxNoImplicitWait" `
    -jar c:\tools\webdrivertraining.1.0-SNAPSHOT.jar `
    --plugin progress `
    --tags $env:CUCUMBER_TAGS `
    features\octopus\open-randomquotes-azurewebapp.feature
