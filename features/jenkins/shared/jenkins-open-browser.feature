Feature: Open Browser
  @login @browserspecific @firefox
  Scenario: Open Browser
    And I open the shared browser "ExternalBrowserType"
    And I fullscreen the window

  @login @browserspecific @chrome
  Scenario: Open Browser
    And I open the shared browser "ExternalBrowserType"
    # Maximise in Linux because we don't have an os taskbar, but we want to see the Chrome UI
    And I maximize the window

  @login
  Scenario: Set wait time
    And I set the default explicit wait time to "30" seconds