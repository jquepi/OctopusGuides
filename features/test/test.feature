Feature: Test feature
  Scenario: Open google
    And I open the shared browser "ExternalBrowserType"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    And I run the feature "test2.feature"