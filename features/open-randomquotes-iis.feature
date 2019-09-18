Feature: Open Random Quotes

  Scenario: Login
    Given I set the following aliases:
      | Refresh | //input[@type='submit'] |

    And I open the shared browser "FirefoxNoImplicitWait"
    And I maximize the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:8081"
    And I start recording the screen to the directory "C:\screenshots"
    And I click the "Refresh" button
    And I sleep for "2" seconds
    And I stop recording the screen
    And I close the browser