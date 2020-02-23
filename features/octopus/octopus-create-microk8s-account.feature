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
      | Username/Password | //li[normalize-space(text())='Username/Password']             |
      | Account name      | //input[contains(@id,'Accountname')]                          |
      | Username          | //input[contains(@id,'Username')]                             |
      | Password          | //input[contains(@id,'Password')]                             |
      | Save              | (//button[contains(.,'Save')])[2]                             |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating Azure account" for "3" seconds

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

    And I highlight inside the "Username/Password" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/microk8saccount/040-accounts.png"
    And I click the "Username/Password" option

    And I highlight outside the "Account name" link
    And I populate the "Account name" text box with "MicroK8S Account"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/microk8saccount/045-accounts.png"
    And I remove the highlight from the "Account name" link

    And I highlight outside the "Username" link
    And I scroll the "Username" text box into view offset by "-300"
    And I populate the "Username" text box with "admin"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/microk8saccount/050-accounts.png"
    And I remove the highlight from the "Username" link

    And I highlight outside the "Password" link
    And I scroll the "Password" text box into view offset by "-200"
    And I populate the "Password" text box with "ExternalMicroK8SPassword"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/microk8saccount/060-accounts.png"
    And I remove the highlight from the "Password" link

    And I highlight outside the "Save" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/microk8saccount/090-accounts.png"
    And I click the "Save" button

    And I sleep for "1" second

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser