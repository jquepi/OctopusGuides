Feature: Open Random Quotes

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username   | //input[@name='userName']                                                                                 |
      | Password   | //input[@name='password']                                                                                 |
      | Sign In    | //button[contains(.,'SIGN IN')]                                                                           |
      | Close help | //div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M11 18h2v-2h-2v2zm1-16C6.48 2 2')]] |
    And I open the shared browser "ExternalBrowserType"
    And I fullscreen the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button
    And I click the "Close help" button

  Scenario: View Random Quotes Overview
    Given I set the following aliases:
      | Random Quotes | //a[contains(.,'Random Quotes')]                                                                          |
      | Close help    | //div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M11 18h2v-2h-2v2zm1-16C6.48 2 2')]] |

    And I click the "Random Quotes" link
    And I click the "Close help" button
    And I scroll down "10000" px
    And I display a note with the text "There are no options to deploy to the Prod environment" for "3" seconds
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/180-octopus-internal-deployer-overview.png"
    And I sleep for "3" seconds

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser