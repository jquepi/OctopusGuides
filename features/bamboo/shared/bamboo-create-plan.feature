Feature: Create plan
  Scenario: Create plan
    Given I set the following aliases:
      | Build one | //a[@href='/bamboo/browse/RQ-WEB-1']     |
      | Logs      | //a[@href='/bamboo/browse/RQ-WEB-1/log'] |
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I refresh the page for "60" seconds if the "Build one" link does not exists
    And I highlight outside the "Build one" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}230-build-one.png"
    And I force click the "Build one" link
    And I click the "Logs" link
    And I sleep for "10" seconds
    And I scroll down "10000" px
    And I sleep for "50" seconds
    And I stop recording the screen
    And I sleep for "300" seconds
    And I scroll down "10000" px
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}240-build-results.png"