Feature: Build and deploy a ASP.NET Core application hosted in Git on a local Octopus instance

  @login
  Scenario: Log into Jenkins
    Given I set the following aliases:
      | Username     | #j_username                                                  |
      | Password     | body > div > div > form > div:nth-child(2) > input           |
      | Sign In      | body > div > div > form > div.submit.formRow > input         |
      | Profile Name | #header > div.login > span > a.model-link.inside.inverse > b |
    And I open the shared browser "ExternalBrowserType"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    #And I set the window size to "1024" x "768"
    When I open the URL "http://localhost:8080"
    # It can take some time for Jenkins to start up, so we need to be able to wait here for the login box
    And I verify the "Username" text box is present waiting up to "900" seconds if it exists
    And I refresh the page
    And I populate the "Username" text box with the text "jenkinsadmin"
    And I populate the "Password" text box with the text "Password01!"
    And I click the "Sign In" button
    Then I verify the text from the "Profile Name" element matches the regex "jenkinsadmin" waiting up to "120" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"