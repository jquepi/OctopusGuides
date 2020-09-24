Feature: Create Azure Account

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments


  Scenario: Add account
    Given I set the following aliases:
      | Infrastructure       | //span[contains(.,'Infrastructure')]                          |
      | More                 | (//span[contains(.,'More')])[2]                               |
      | Accounts             | //span[contains(.,'Accounts')] \| //a[contains(.,'Accounts')] |
      | Add Account          | //button[contains(.,'Add Account')]                           |
      | Azure Subscription   | //li[normalize-space(text())='Azure Subscription']            |
      | Account name         | //input[@name='Account name']                                 |
      | Subscription ID      | //input[@name='Subscription']                                 |
      | Tenant ID            | //input[@name='Active Directory Tenant ID']                   |
      | Application ID       | //input[@name='Active Directory Appication ID']               |
      | Application Password | //input[@name='AActive Directory Password\\\\Key']            |
      | Save                 | (//button[contains(.,'Save')])[2]                             |
      | Expand All           | //a[text()='EXPAND ALL']                                      |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating Azure account" for "3" seconds

    And I highlight outside the "Infrastructure" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azureaccount/010-infrastructure.png"
    And I click the "Infrastructure" link
    And I remove the highlight from the "Infrastructure" link
    And I sleep for "1" second

    And I force click the "More" link waiting up to "5" seconds if it exists
    And I highlight outside the "More" link with an offset of "5" if it exists
    And I highlight inside the "Accounts" link
    And I zoom the browser out
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azureaccount/020-accounts.png"
    And I zoom the browser in
    And I click the "Accounts" link

    And I highlight inside the "Add Account" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azureaccount/030-accounts.png"
    And I click the "Add Account" button

    And I highlight inside the "Azure Subscription" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azureaccount/040-accounts.png"
    And I click the "Azure Subscription" option

    And I stop recording the screen
    And I sleep for "5" seconds
    And I click the "Expand All" link if the "Account name" text box does not exist
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Account name" link
    And I populate the "Account name" text box with "Azure"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azureaccount/045-accounts.png"
    And I remove the highlight from the "Account name" link

    And I highlight outside the "Subscription ID" link
    And I scroll the "Subscription ID" text box into view offset by "-300"
    And I populate the "Subscription ID" text box with "ExternalAzureSubscriptionID"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azureaccount/050-accounts.png"
    And I remove the highlight from the "Subscription ID" link

    And I highlight outside the "Tenant ID" link
    And I scroll the "Tenant ID" text box into view offset by "-200"
    And I populate the "Tenant ID" text box with "ExternalAzureTenantID"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azureaccount/060-accounts.png"
    And I remove the highlight from the "Tenant ID" link

    And I highlight outside the "Application ID" link
    And I scroll the "Application ID" text box into view offset by "-300"
    And I populate the "Application ID" text box with "ExternalApplicationTenantID"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azureaccount/070-accounts.png"
    And I remove the highlight from the "Application ID" link

    And I highlight outside the "Application Password" link
    And I scroll the "Application Password" text box into view offset by "-300"
    And I populate the "Application Password" text box with "ExternalApplicationPassword"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azureaccount/080-accounts.png"

    And I highlight outside the "Save" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azureaccount/090-accounts.png"
    And I click the "Save" button

    And I sleep for "1" second


  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser