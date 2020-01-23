Feature: Open Random Quotes

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments

  Scenario: View Random Quotes Overview
    Given I set the following aliases:
      | Random Quotes | //a[contains(.,'Random Quotes')] |

    And I click the "Random Quotes" link
    And I scroll down "10000" px
    And I display a note with the text "There are no options to deploy to the Dev or Test environments" for "3" seconds
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/185-octopus-proudction-deployer-overview.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser