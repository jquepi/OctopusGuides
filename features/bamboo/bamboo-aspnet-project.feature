Feature: Configure Bamboo

  Scenario: Login
    Given I set the following aliases:
      | Log in     | //a[text()='Log in']                 |
      | Username   | //input[@id='loginForm_os_username'] |
      | Password   | //input[@id='loginForm_os_password'] |
      | Log in Two | // input[@id='loginForm_save']       |

    And I open the URL "http://localhost:6990"
    And I click the "Log in" button
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "admin"
    And I click the "Log in Two" button

