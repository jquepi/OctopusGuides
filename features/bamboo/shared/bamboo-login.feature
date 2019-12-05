Feature: Bamboo login
  @login @browserspecific @firefox
  Scenario: Open Browser
    And I open the shared browser "ExternalBrowserType"
    And I fullscreen the window

  @login @browserspecific @chrome
  Scenario: Open Browser
    And I open the shared browser "ExternalBrowserType"
    # Maximise in Linux because we don't have an os taskbar, but we want to see the Chrome UI
    And I maximize the window

  Scenario: Login
    Given I set the following aliases:
      | Log in     | (//a[text()='Log in'])[1]            |
      | Username   | //input[@id='loginForm_os_username'] |
      | Password   | //input[@id='loginForm_os_password'] |
      | Log in Two | // input[@id='loginForm_save']       |

    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:6990/bamboo"
    And I click the "Log in" button
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "admin"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/login/010-login.png"
    And I click the "Log in Two" button