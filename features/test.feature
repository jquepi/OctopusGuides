Feature: Test highlights
  Scenario: Login
    Given I open the shared browser "FirefoxNoImplicitWait"
    And I open the URL "http://localhost:8080"
    And I highlight the "#security-token" text box
    And I sleep for "3" seconds
    And I remove the highlight from the "#security-token" text box
    And I sleep for "3" seconds
    And I close the browser