Feature: Create Octopus Users and Teams

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username   | //input[@name='userName']                                                                                 |
      | Password   | //input[@name='password']                                                                                 |
      | Sign In    | //button[contains(.,'SIGN IN')]                                                                           |
      | Close help | //div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M11 18h2v-2h-2v2zm1-16C6.48 2 2')]] |
    And I open the shared browser "ExternalBrowserType"
    And I fullscreen the window
    #And I set the window size to "1024" x "768"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button
    And I click the "Close help" button

  @view-audit
  Scenario: Configure Users
    Given I set the following aliases:
      | More          | (//span[contains(.,'More')])[1]                                                                 |
      | Configuration | //a[./span[contains(.,'Configuration')][not(*)]] \| //span[.//div[contains(.,'Configuration')]] |
      | Audit         | (//a[contains(.,'Audit')][not(*)] \| //span[contains(.,'Audit')])[1]                            |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "View the audit log" for "3" seconds
    And I sleep for "1" second

    And I highlight outside the "More" link if it exists
    And I click the "More" link waiting up to "1" second if it exists
    And I highlight inside the "Configuration" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/audit/005-octopus-configuration.png"
    And I click the "Configuration" link
    And I remove the highlight from the "More" link waiting up to "3" seconds if it exists
    And I remove the highlight from the "Configuration" link waiting up to "3" seconds if it exists
    And I sleep for "1" second

    And I highlight inside the "Audit" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/audit/010-octopus-audit.png"
    And I click the "Audit" link

    And I sleep for "3" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/audit/015-octopus-audit-logs.png"

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  Scenario: Shutdown
    And I stop recording the screen
    And I close the browser