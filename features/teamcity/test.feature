Feature: Test

  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@id='username']                   |
      | Password | //input[@id='password']                   |
      | Log in   | //input[@name='submitLogin']              |
      | Title    | //span[contains(@class,'contentWrapper')] |

    And I open the browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:8111"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Log in" button
    And I sleep for "2" seconds
    Then I verify the text from the "Title" element matches the regex "Getting started with TeamCity"