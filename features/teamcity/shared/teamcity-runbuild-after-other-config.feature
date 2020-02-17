Feature: Run a build

  @run-build
  Scenario: Run a build
    Run the first build. Note that this is different to the teamcity-runbuild.feature in that you still need to manually
    click the #1 link wne running a build from the main page.

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

    # It appears new version of team city take you to the first build when "run" is clicked

    And I highlight inside the "Build One" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}170-build-one.png"
    And I click the "Build One" link
    And I click the "Build log" link
    And I scroll down "10000" px
    And I sleep for "300" seconds
    And I stop recording the screen

    And I sleep for "150" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I sleep for "5" seconds

    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}180-build-one-results.png"