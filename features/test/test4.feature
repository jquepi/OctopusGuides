Feature: Test feature
  Scenario: Open google
    Given I open the shared browser "ChromeNoImplicitWait"
    And I maximize the window
    And I start recording the screen to the directory "/tmp/screenshot"
    When I open the URL "https://google.com"
    And I force clear the "//input[@name='q']" text box
    And I sleep for "1" second
    And I save a screenshot to "/tmp/screenshot/image.png"