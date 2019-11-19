& "C:\Program Files\OpenJDK\jdk-13\bin\java" `
    "--enable-preview" `
    "-Xmx2g" `
    "-Dwebdriver.gecko.driver=C:\tools\geckodriver.exe" `
    "-DCucumberAlias-ExternalArtifactoryKey=$env:ARTIFACTORY_KEY" `
    "-DmoveCursorToElement=false" `
    "-DmouseMoveVerticalOffset=$env:MOUSE_VERTICAL_OFFSET" `
    "-DdisableHighlights=true" `
    "-DdisableScreenshots=true" `
    "-DdisableVideoRecording=true" `
    "-DslackHookUrl=$env:SLACK_HOOK_URL" `
    "-DslackStepHandlerEnabled=false" `
    "-DscreenshotS3Enabled=$env:STHREE_SCREENSHOT_ENABLED" `
    "-DscreenshotS3Bucket=$env:SCREENSHOT_BUCKET" `
    "-DstepHandlerMessage=$env:GITHUB_SHA" `
    "-DCucumberAlias-ExternalMediaPath=$env:MEDIA_PATH" `
    -jar c:\tools\webdrivertraining-1.0-SNAPSHOT.jar `
    --tags $env:CUCUMBER_TAGS `
    --plugin progress `
    --monochrome `
    features\jenkins\teamcity-setup.feature