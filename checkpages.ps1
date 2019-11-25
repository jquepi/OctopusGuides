foreach($line in Get-Content .\links.txt) {
    if($line -match $regex){
        & "C:\Program Files\Java\jdk-13\bin\java.exe" `
        --enable-preview `
        "-Dwebdriver.gecko.driver=c:\tools\geckodriver.exe" `
        "-DCucumberAlias-ExternalBrowserType=FirefoxHeadless" `
        "-DCucumberAlias-ExternalURL=$line" `
        -jar ..\WebDriverTraining\target\webdrivertraining-1.0-SNAPSHOT.jar `
        features\verify\verify.feature
    }
    #break
}