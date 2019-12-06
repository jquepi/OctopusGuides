Feature: Login to TeamCity
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
      | Username | //input[@id='username']      |
      | Password | //input[@id='password']      |
      | Log in   | //input[@name='submitLogin'] |

    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:8111"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Log in" button