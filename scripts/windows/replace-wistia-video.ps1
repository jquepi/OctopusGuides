if (-not [string]::IsNullOrEmpty($env:WISTIA_MEDIA_ID))
{
    & "C:\tools\zulu17.36.17-ca-jdk17.0.4.1-win_x64\bin\java" `
    "-Xmx2g" `
    "-Dwebdriver.gecko.driver=C:\tools\geckodriver.exe" `
    "-DstepPause=$STEP_PAUSE" `
    "-DmoveCursorToElement=false" `
    "-DmouseMoveVerticalOffset=$env:MOUSE_VERTICAL_OFFSET" `
    "-DdisableHighlights=true" `
    "-DdisableScreenshots=true" `
    "-DdisableVideoRecording=true" `
    "-DslackHookUrl=$env:SLACK_HOOK_URL" `
    "-DslackStepHandlerEnabled=$env:SLACK_STEP_HANDLER" `
    "-DslackStepHandlerErrorOnly=$env:SLACK_ON_ERROR_ONLY" `
    "-DscreenshotS3Enabled=true" `
    "-DscreenshotS3Bucket=octopus-guides-screenshots" `
    "-DstepHandlerMessage=$env:GITHUB_SHA" `
    "-DretryCount=3" `
    "-DCucumberAlias-ExternalWistiaUsername=$env:WISTIA_USERNAME" `
    "-DCucumberAlias-ExternalWistiaPassword=$env:WISTIA_PASSWORD" `
    "-DCucumberAlias-ExternalMediaID=$env:WISTIA_MEDIA_ID" `
    "-DCucumberAlias-ExternalMediaPath=$env:MEDIA_PATH" `
    "-DCucumberAlias-GuideSpecificScreenshotDir=$env:SCREENSHOT_PATH" `
    "-DCucumberAlias-ExternalBrowserType=FirefoxNoImplicitWait" `
    -jar c:\tools\webdrivertraining.1.0-SNAPSHOT.jar `
    --tags $env:CUCUMBER_TAGS `
    features\wistia\replace-video.feature
}