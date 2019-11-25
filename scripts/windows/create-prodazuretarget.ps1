& "C:\Program Files\OpenJDK\$((Get-ChildItem "C:\Program Files\OpenJDK\")[0])\bin\java" `
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
    "-DCucumberAlias-ExternalEnvironmentName=Prod" `
    "-DCucumberAlias-ExternalTargetName=Azure web app - Prod" `
    "-DCucumberAlias-ExternalEnvironment=//span[./div/div/div[text()='Prod']]" `
    "-DCucumberAlias-ExternalAzureWebAppOption=//span[./div/div/div[contains(.,'$($env:PROD_RES_GROUP)')]]" `
    "-DCucumberAlias-ExternalMediaPath=$env:MEDIA_PATH" `
    "-DCucumberAlias-GuideSpecificScreenshotDir=$env:SCREENSHOT_PATH" `
    "-DCucumberAlias-ExternalBrowserType=FirefoxNoImplicitWait" `
    -jar c:\tools\webdrivertraining-1.0-SNAPSHOT.jar `
    --plugin progress `
    --monochrome `
    features\octopus\octopus-create-azure-webapp-target.feature
