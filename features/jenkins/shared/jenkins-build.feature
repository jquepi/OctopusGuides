Feature: Build Jenkins project
  @build-now
  Scenario: Run build
    Given I set the following aliases:
      | Build Now      | //a[contains(.,'Build Now')]      |
      | Build One      | //a[contains(.,'#1')]             |
      | Console Output | //a[contains(.,'Console Output')] |

    And I open the URL "http://localhost:8080/job/Random%20Quotes/"
    And I clear the transition
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight inside the "Build Now" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}300-build-now.png"
    And I click the "Build Now" link

    And I highlight inside the "Build One" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}310-build-one.png"
    # Fake a click here to fix stale element errors in WebDriver
    And I mouse over the "Build One" link
    And I open the URL "http://localhost:8080/job/Random%20Quotes/1/"

    And I highlight inside the "Console Output" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}320-console.png"
    And I click the "Console Output" link
    And I scroll down "10000" px
    And I sleep for "10" seconds

    And I stop recording the screen
    And I sleep for "900" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I scroll down "10000" px
    And I sleep for "5" seconds