Feature: Create Octopus Users and Teams

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments

  @view-audit
  Scenario: Configure Users
    Given I set the following aliases:
      | More          | (//span[contains(.,'More')])[1]                                                                    |
      | Configuration | //a[./span[contains(.,'Configuration')][not(*)]] \| //div[normalize-space(text())='Configuration'] |
      | Audit         | (//a[contains(.,'Audit')][not(*)] \| //span[contains(.,'Audit')])[1]                               |

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