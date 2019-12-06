Feature: Test feature
  Scenario: Open google
    Given I open the shared browser "ChromeNoImplicitWait"
    When I open the URL "https://google.com"
    And I sleep for "1" second
    And I save a screenshot to "/tmp/screenshot/image.png"