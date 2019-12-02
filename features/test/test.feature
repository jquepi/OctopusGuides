Feature: Test feature
  Scenario: Open google
    And I open the shared browser "ExternalBrowserType"
    And I fullscreen the window
    #And I press the "F11" function key
    And I set the default explicit wait time to "30" seconds
    #And I fullscreen the window
    And I run the feature "test2.feature"