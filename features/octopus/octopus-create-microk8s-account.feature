Feature: Create MicroK8s Account

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments


  Scenario: Add account
    Given I set the following aliases:
      | Infrastructure    | //span[contains(.,'Infrastructure')]                          |
      | More              | (//span[contains(.,'More')])[2]                               |
      | Accounts          | //span[contains(.,'Accounts')] \| //a[contains(.,'Accounts')] |
      | Add Account       | //button[contains(.,'Add Account')]                           |
      | Username/Password | //a[.//div[normalize-space(text())='Username/Password']]      |
      | Token             | //a[.//div[normalize-space(text())='Token']]                  |
      | Account name      | //input[@name='Account name']                                 |
      | Token value       | //input[@name='Token']                                        |
      | Username          | //input[@name='Username']                                     |
      | Password          | //input[@name='Password']                                     |
      | Save              | //button[contains(.,'Save')]                                  |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating MicroK8S account" for "3" seconds

    And I highlight outside the "Infrastructure" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/microk8saccount/010-infrastructure.png"
    And I click the "Infrastructure" link
    And I remove the highlight from the "Infrastructure" link
    And I sleep for "1" second

    And I force click the "More" link waiting up to "5" seconds if it exists
    And I highlight outside the "More" link with an offset of "5" if it exists
    And I highlight inside the "Accounts" link
    And I zoom the browser out
    And I save a screenshot to "#{ExternalMediaPath}/octopus/microk8saccount/020-accounts.png"
    And I zoom the browser in
    And I click the "Accounts" link

    And I highlight inside the "Add Account" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/microk8saccount/030-accounts.png"
    And I click the "Add Account" button

    And I highlight inside the "Token" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/microk8saccount/040-accounts.png"
    And I click the "Token" option

    And I highlight outside the "Account name" link
    And I populate the "Account name" text box with "MicroK8S Account"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/microk8saccount/045-accounts.png"
    And I remove the highlight from the "Account name" link

    And I highlight outside the "Token value" link
    And I scroll the "Token value" text box into view offset by "-200"
    And I populate the "Token value" text box with "ExternalMicroK8SToken"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/microk8saccount/060-accounts.png"
    And I remove the highlight from the "Token value" link

    And I highlight outside the "Save" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/microk8saccount/090-accounts.png"
    And I click the "Save" button

    And I sleep for "1" second

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser