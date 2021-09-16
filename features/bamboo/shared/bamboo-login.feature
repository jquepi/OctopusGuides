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
    And I open the URL "http://#{Hostname}:6990/bamboo/"
    And I refresh the page for "900" seconds if the "Log in" button does not exist
    # Force click because of org.openqa.selenium.ElementClickInterceptedException: Element <a id="login" href="/bamboo/userlogin!doDefault.action?os_destination=%2Fstart.action">
    # is not clickable at point (1798,986) because another element <div id="license-message" class="aui-message warning"> obscures it
    And I force click the "Log in" button
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "admin"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/login/010-login.png"
    And I click the "Log in Two" button

  Scenario: Close popups
    Given I set the following aliases:
      | Don't remind me again | (//a[@class="dismiss-notification"])[1] |

    # Dismiss any popups that might hide the run button. I've seen up to two popups before.
    And I sleep for "10" seconds
    And I click the "Don't remind me again" link if it exists
    And I sleep for "10" seconds
    And I click the "Don't remind me again" link if it exists