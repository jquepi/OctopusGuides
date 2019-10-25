Feature: Open Random Quotes

  Scenario: Login
    Given I set the following aliases:
      | Refresh | //input[@type='submit'] |

    And I open the shared browser "FirefoxNoImplicitWait"
    And I maximize the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "ExternalUrl"
    And I verify the "Refresh" button is present waiting up to "300" seconds if it exists
    And I refresh the page
    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Running the Random Quotes sample application" for "3" seconds
    And I save a screenshot to "Screenshot"
    And I click the "Refresh" button
    And I sleep for "2" seconds

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser