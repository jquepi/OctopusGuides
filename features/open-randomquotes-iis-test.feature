Feature: Open Random Quotes in the Test environment

  Scenario: Login
    Given I set the following aliases:
      | Refresh | //input[@type='submit'] |

    And I open the shared browser "FirefoxNoImplicitWait"
    And I maximize the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:8082"
    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Open the application in the Test environment (port 8082)" for "3" seconds
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\130-random-quotes-test-app.png"
    And I click the "Refresh" button
    And I sleep for "2" seconds

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser