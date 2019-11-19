& "C:\Program Files\OpenJDK\jdk-13\bin\java" `
    "--enable-preview" `
    "-Xmx2g" `
    "-Dwebdriver.gecko.driver=C:\tools\geckodriver.exe" `
    "-DmoveCursorToElement=false" `
    "-DmouseMoveVerticalOffset=$env:MOUSE_VERTICAL_OFFSET" `
    "-DdisableHighlights=true" `
    "-DdisableScreenshots=true" `
    "-DdisableVideoRecording=true" `
    "-DslackHookUrl=$env:SLACK_HOOK_URL" `
    "-DslackStepHandlerEnabled=false" `
    "-DscreenshotS3Enabled=true" `
    "-DscreenshotS3Bucket=octopus-guides-screenshots" `
    "-DstepHandlerMessage=$env:GITHUB_SHA" `
    "-DretryCount=3" `
    "-DCucumberAlias-ExternalWistiaUsername=$env:WISTIA_USERNAME" `
    "-DCucumberAlias-ExternalWistiaPassword=$env:WISTIA_PASSWORD" `
    "-DCucumberAlias-ExternalMediaID=$env:WISTIA_MEDIA_ID" `
    "-DCucumberAlias-ExternalMediaPath=$env:MEDIA_PATH" `
    "-DCucumberAlias-ExternalBrowserType=FirefoxNoImplicitWait" `
    -jar c:\tools\webdrivertraining-1.0-SNAPSHOT.jar `
    --plugin progress `
    --monochrome `
    features\wistia\replace-video.feature