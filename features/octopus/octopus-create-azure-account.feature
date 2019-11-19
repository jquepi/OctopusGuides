Feature: Create Azure Account

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@name='userName']       |
      | Password | //input[@name='password']       |
      | Sign In  | //button[contains(.,'SIGN IN')] |
    And I open the shared browser "ExternalBrowserType"
    And I maximize the window
    #And I set the window size to "1024" x "768"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"

    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button


  Scenario: Add target
    Given I set the following aliases:
      | Infrastructure       | //span[contains(.,'Infrastructure')]                 |
      | More                 | (//span[contains(.,'More')])[2]                      |
      | Accounts             | //span[contains(.,'Accounts')]                       |
      | Add Account          | //button[contains(.,'Add Account')]                  |
      | Azure Subscription   | //li[normalize-space(text())='Azure Subscription']   |
      | Account name         | //input[contains(@id,'Accountname')]                 |
      | Subscription ID      | //input[contains(@id,'Subscription')]                |
      | Tenant ID            | //input[contains(@id,'ActiveDirectoryTenantID')]     |
      | Application ID       | //input[contains(@id,'ActiveDirectoryAppicationID')] |
      | Application Password | //input[contains(@id,'ActiveDirectoryPasswordKey')]  |
      | Save                 | (//button[contains(.,'Save')])[2]                    |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating Azure account" for "3" seconds

    And I highlight outside the "Infrastructure" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azureaccount/010-infrastructure.png"
    And I click the "Infrastructure" link
    And I remove the highlight from the "Infrastructure" link
    And I sleep for "1" second

    And I force click the "More" link waiting up to "5" seconds if it exists
    And I highlight outside the "More" link with an offset of "5"
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

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser