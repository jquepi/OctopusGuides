Feature: Build Jenkins project

  @build-now
  Scenario: Run build
    Given I set the following aliases:
      | Build Now      | //a[@title='Build Now']\|//a[contains(.,'Build Now')] |
      | Build One      | //a[contains(.,'#1')]                                 |
      | Console Output | //a[contains(.,'Console Output')]                     |

    And I open the URL "http://localhost:8080/job/Random%20Quotes/"
    And I clear the transition
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight inside the "Build Now" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}300-build-now.png"
    And I click the "Build Now" link
    And I sleep for "2" seconds

    And I stop recording the screen
    And I open the URL "http://localhost:8080"
    And I open the URL "http://localhost:8080/job/Random%20Quotes/"
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight inside the "Build One" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}310-build-one.png"
    # Fake a click here to fix stale element errors in WebDriver
    And I force mouse over the "Build One" link waiting up to "120" seconds
    And I open the URL "http://localhost:8080/job/Random%20Quotes/1/"

    And I highlight inside the "Console Output" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}320-console.png"
    And I click the "Console Output" link
    And I scroll down "10000" px
    And I sleep for "10" seconds

    And I stop recording the screen
    # These sleeps allow debugging to keep capturing the logs
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "5" seconds
    And I sleep for "350" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I scroll down "10000" px
    And I sleep for "5" seconds