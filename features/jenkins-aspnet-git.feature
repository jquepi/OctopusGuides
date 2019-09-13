Feature: Build and deploy a ASP.NET application hosted in Git on a local Octopus instance
  Scenario: Log into Jenkins
    Given I set the following aliases:
      | Username | #j_username |
      | Password | body > div > div > form > div:nth-child(2) > input |
      | Sign In  | body > div > div > form > div.submit.formRow > input |
    And I open the shared browser "FirefoxNoImplicitWait"
    When I open the URL "http://localhost:8080"
    And I populate the "Username" text box with the text "jenkinsadmin"
    And I populate the "Password" text box with the text "Password01!"
    And I click the "Sign In" button

  Scenario: Shutdown
    And I close the browser