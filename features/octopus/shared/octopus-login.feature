Feature: Octopus Login

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username   | //input[@id='userName']                                                                                   |
      | Password   | //input[@id='password']                                                                                   |
      | Sign In    | //button[contains(.,'SIGN IN')]                                                                           |
      | Close help | //div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M11 18h2v-2h-2v2zm1-16C6.48 2 2')]] |
      | Close EAP  | (//div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M19 6.41L17.59')]])[1]             |

    And I set the default explicit wait time to "30" seconds
    And I open the URL "#{OctopusURL:-http://localhost}"
    # Give the form time to load
    And I sleep for "5" seconds
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button
    And I click the "Close help" button waiting up to "5" seconds if it exists
    And I click the "Close EAP" button waiting up to "5" seconds if it exists
    # Give the dashboard time to load
    And I sleep for "10" seconds