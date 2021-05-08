# The latest JDKs have the following error:
# java.security.KeyStoreException: Key protection  algorithm not found: java.security.UnrecoverableKeyException: Encrypt Private Key failed: unrecognized algorithm name: PBEWithSHA1AndDESede
# So we use a specific version of Java for Artifactory
$env:JAVA_HOME="C:/install/jdk8u282-b08"
start "C:\install\artifactory-pro-6.17.0\bin\artifactory.bat" -PassThru `
    -RedirectStandardOutput "c:\install\artifactory-pro-6.17.0\out.txt" `
    -RedirectStandardError "c:\install\artifactory-pro-6.17.0\error.txt"

# Add the NuGet source for the current user
C:\ProgramData\chocolatey\bin\nuget.exe sources add `
      -Name Artifactory `
      -Source http://localhost:8041/artifactory/api/nuget/NuGet `
      -Username admin `
      -Password Password01!

# Add the NuGet source for the LOCAL SYSTEM user
C:\tools\pstools\PsExec.exe `
      -accepteula `
      -s C:\ProgramData\chocolatey\bin\nuget.exe sources add `
      -Name Artifactory `
      -Source http://localhost:8041/artifactory/api/nuget/NuGet `
      -Username admin `
      -Password Password01!

New-Item -ItemType file c:\ArtifactoryStarted.txt

# Wait for artifactory
for ($x = 0; $x -lt 15; ++$x) {
    Write-Host "Sleeping...";
    Start-Sleep 30;
    if ((Test-NetConnection -ComputerName localhost -Port 8041).TcpTestSucceeded) {
        break
    }
}

Write-Host "Proxy details"
Write-Host "NO_PROXY : $($env:no_proxy)"
Write-Host "HTTP_PROXY: $($env:http_proxy)"
Write-Host "HTTPS_PROXY: $($env:https_proxy)"

Get-Content "c:\install\artifactory-pro-6.17.0\out.txt"
Get-Content "c:\install\artifactory-pro-6.17.0\error.txt"

# Dump the log files
Get-ChildItem "C:\install\artifactory-pro-6.17.0\logs" -Filter *.log |
        Foreach-Object {Get-Content $_.FullName}

& "C:\Program Files\OpenJDK\$((Get-ChildItem "C:\Program Files\OpenJDK\")[0])\bin\java" `
    "-Xmx2g" `
    "-Dwebdriver.gecko.driver=C:\tools\geckodriver.exe" `
    "-DstepPause=$STEP_PAUSE" `
    "-DmoveCursorToElement=$env:MOVE_TO_MOUSE_CUSROR" `
    "-DmouseMoveVerticalOffset=$env:MOUSE_VERTICAL_OFFSET" `
    "-DdisableHighlights=$env:DISABLE_HIGHLIGHTS" `
    "-DdisableScreenshots=$env:DISABLE_SCREENSHOTS" `
    "-DdisableVideoRecording=$env:DISABLE_VIDEO" `
    "-DslackHookUrl=$env:SLACK_HOOK_URL" `
    "-DslackStepHandlerEnabled=$env:SLACK_STEP_HANDLER" `
    "-DslackStepHandlerErrorOnly=$env:SLACK_ON_ERROR_ONLY" `
    "-DscreenshotS3Enabled=$env:STHREE_SCREENSHOT_ENABLED" `
    "-DscreenshotS3Bucket=$env:SCREENSHOT_BUCKET" `
    "-DstepHandlerMessage=$env:GITHUB_SHA" `
    "-DCucumberAlias-ExternalArtifactoryKey=$env:ARTIFACTORY_KEY" `
    "-DCucumberAlias-ExternalMediaPath=$env:MEDIA_PATH" `
    "-DCucumberAlias-GuideSpecificScreenshotDir=$env:SCREENSHOT_PATH" `
    "-DCucumberAlias-ExternalBrowserType=FirefoxNoImplicitWait" `
    -jar c:\tools\webdrivertraining.1.0-SNAPSHOT.jar `
    --tags $env:CUCUMBER_TAGS `
    features\artifactory\artifactory-setup.feature