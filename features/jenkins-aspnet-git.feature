Feature: Build and deploy a ASP.NET application hosted in Git on a local Octopus instance
  Scenario: Log into Jenkins
    Given I set the following aliases:
      | Username | #j_username |
      | Password | body > div > div > form > div:nth-child(2) > input |
      | Sign In  | body > div > div > form > div.submit.formRow > input |
      | Profile Name | #header > div.login > span > a.model-link.inside.inverse > b |
    And I dump the aliases
    And I set the default explicit wait time to "30" seconds
    And I open the shared browser "FirefoxNoImplicitWait"
    When I open the URL "http://localhost:8080"
    # It can take some time for Jenkins to start up, so we need to be able to wait here for the login box
    And I populate the "Username" text box with the text "jenkinsadmin" waiting up to "300" seconds
    And I populate the "Password" text box with the text "Password01!"
    And I click the "Sign In" button
    Then I verify the text from the "Profile Name" element matches the regex "jenkinsadmin"

  Scenario: Shutdown
    And I close the browser