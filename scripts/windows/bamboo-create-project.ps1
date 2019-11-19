& "C:\Program Files\OpenJDK\jdk-13\bin\java" `
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
    "-DslackStepHandlerEnabled=true" `
    "-DscreenshotS3Enabled=$env:STHREE_SCREENSHOT_ENABLED" `
    "-DscreenshotS3Bucket=$env:SCREENSHOT_BUCKET" `
    "-DstepHandlerMessage=$env:GITHUB_SHA" `
    "-DCucumberAlias-GitUrl=$env:GIT_URL" `
    "-DCucumberAlias-ExternalOctopusAPIKey=$((cat C:\octopus_api.txt).Trim())" `
    "-DCucumberAlias-ExternalMediaPath=$env:MEDIA_PATH" `
    "-DCucumberAlias-ExternalBrowserType=FirefoxNoImplicitWait" `
    -jar c:\tools\webdrivertraining-1.0-SNAPSHOT.jar `
    --tags $env:CUCUMBER_TAGS `
    --plugin progress `
    --monochrome `
    features\bamboo\bamboo-aspnet-project.feature
