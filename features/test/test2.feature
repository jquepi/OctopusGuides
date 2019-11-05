Feature: Test feature
  Scenario: Open google
    When I open the URL "https://google.com"
    And I sleep for "10" second
    And I save a screenshot to "c:\screenshots\test.png"