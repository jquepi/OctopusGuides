Feature: Build two
  @build-now
  Scenario: Run build
    Given I set the following aliases:
      | Build Now      | //a[contains(.,'Build Now')]      |
      | Build Two      | //a[contains(.,'#2')]             |
      | Console Output | //a[contains(.,'Console Output')] |

    And I open the URL "http://localhost:8080/job/Random%20Quotes/"
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight inside the "Build Now" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}030-build-and-deploy-now.png"
    And I click the "Build Now" link

    And I highlight inside the "Build Two" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}035-build-two.png"
    # Faking a click, because clicking this element fails a lot of the time
    And I mouse over the "Build Two" link
    And I open the URL "http://localhost:8080/job/Random%20Quotes/2/"

    And I highlight inside the "Console Output" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}040-build-and-deploy-console.png"
    And I click the "Console Output" link
    And I scroll down "10000" px
    And I sleep for "30" seconds