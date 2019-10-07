Feature: Set up Team City

  Scenario: Set up Team City
    Given I set the following aliases:
      | Proceed        | //input[@value='Proceed']             |
      | Accept         | //input[@id='accept']                 |
      | Continue       | //input[@name='Continue']             |
      | Username       | //input[@id='input_teamcityUsername'] |
      | Password One   | //input[@id='password1']              |
      | Password Two   | //input[@id='retypedPassword']        |
      | Create Account | //input[@value='Create Account']      |
      | Title          | //h1                                  |

    And I open the shared browser "FirefoxNoImplicitWaitNoProxy"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:8111"
    And I click the "Proceed" button
    And I sleep for "2" seconds
    And I click the "Proceed" button
    And I sleep for "120" seconds
    And I click the "Accept" check box
    And I click the "Continue" button

    And I populate the "Username" text box with "admin"
    And I populate the "Password One" text box with "Password01!"
    And I populate the "Password Two" text box with "Password01!"

    When I click the "Create Account" button
    Then I verify the text from the "Title" element matches the regex "My Settings & Tools"