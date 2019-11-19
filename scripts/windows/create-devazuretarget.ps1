& "C:\Program Files\OpenJDK\jdk-13\bin\java" `
    "--enable-preview" `
    "-Xmx2g" `
    "-Dwebdriver.gecko.driver=C:\tools\geckodriver.exe" `
    "-DmoveCursorToElement=$env:MOVE_TO_MOUSE_CUSROR" `
    "-DmouseMoveVerticalOffset=$env:MOUSE_VERTICAL_OFFSET" `
    "-DdisableHighlights=$env:DISABLE_HIGHLIGHTS" `
    "-DdisableScreenshots=$env:DISABLE_SCREENSHOTS" `
    "-DdisableVideoRecording=$env:DISABLE_VIDEO" `
    "-DslackHookUrl=$env:SLACK_HOOK_URL" `
    "-DslackStepHandlerEnabled=false" `
    "-DscreenshotS3Enabled=$env:STHREE_SCREENSHOT_ENABLED" `
    "-DscreenshotS3Bucket=$env:SCREENSHOT_BUCKET" `
    "-DstepHandlerMessage=$env:GITHUB_SHA" `
    "-DCucumberAlias-ExternalArtifactoryKey=$env:ARTIFACTORY_KEY" `
    "-DCucumberAlias-ExternalEnvironmentName=Dev" `
    "-DCucumberAlias-ExternalTargetName=Azure web app - Dev" `
    "-DCucumberAlias-ExternalEnvironment=//span[./div/div/div[text()='Dev']]" `
    "-DCucumberAlias-ExternalAzureWebAppOption=//span[./div/div/div[contains(.,'$($env:DEV_RES_GROUP)')]]" `
    "-DCucumberAlias-ExternalMediaPath=$env:MEDIA_PATH" `
    "-DCucumberAlias-ExternalBrowserType=FirefoxNoImplicitWait" `
    -jar c:\tools\webdrivertraining-1.0-SNAPSHOT.jar `
    --plugin progress `
    --monochrome `
    features\octopus\octopus-environments.feature
