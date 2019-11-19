Feature: Create Octopus Users and Teams

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@name='userName']       |
      | Password | //input[@name='password']       |
      | Sign In  | //button[contains(.,'SIGN IN')] |
    And I open the shared browser "FirefoxNoImplicitWait"
    And I maximize the window
    #And I set the window size to "1024" x "768"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"

    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

  @view-audit
  Scenario: Configure Users
    Given I set the following aliases:
      | More          | (//span[contains(.,'More')])[1]     |
      | Configuration | //span[contains(.,'Configuration')] |
      | Audit         | //span[contains(.,'Audit')]         |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "View the audit log" for "3" seconds
    And I sleep for "1" second

    And I highlight outside the "More" link
    And I click the "More" link
    And I highlight inside the "Configuration" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}\octopus\audit\005-octopus-configuration.png"
    And I click the "Configuration" link
    And I remove the highlight from the "More" link
    And I sleep for "1" second

    And I highlight inside the "Audit" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}\octopus\audit\010-octopus-audit.png"
    And I click the "Audit" link

    And I sleep for "3" second
    And I save a screenshot to "#{ExternalMediaPath}\octopus\audit\015-octopus-audit-logs.png"

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  Scenario: Shutdown
    And I stop recording the screen
    And I close the browser