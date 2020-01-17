Feature: Run a build

  @run-build
  Scenario: Run a build
    Given I set the following aliases:
      | Run                      | //button[contains(.,'Run')]                                |
      | Build Configuration Home | //a[@href='/viewType.html?buildTypeId=RandomQuotes_Build'] |
      | Build One                | //a[contains(.,'#1')]                                      |
      | Build log                | //a[contains(.,'Build Log')]                               |
      | Lets Go                  | //a[contains(.,"Let's go")]                                |
      | No thanks                | //button[contains(.,'No, thanks')]                         |

    And I stop recording the screen
    And I click the "No thanks" button if it exists
    And I sleep for "1" second

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Run" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}160-run.png"
    And I click the "Run" button
    And I sleep for "10" seconds

    And I stop recording the screen
    And I refresh the page

    And I click the "No thanks" button if it exists
    And I sleep for "1" second

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    # Teamcity will open the first build, but in case of an error you can open the
    # build logs manually.

    # And I highlight inside the "Build One" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}170-build-one.png"
    And I click the "Build One" link waiting up to "5" seconds if it exists
    And I click the "Build log" link waiting up to "1" seconds if it exists
    And I scroll down "10000" px
    And I sleep for "20" seconds
    And I stop recording the screen

    And I sleep for "150" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I sleep for "5" seconds

    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}180-build-one-results.png"