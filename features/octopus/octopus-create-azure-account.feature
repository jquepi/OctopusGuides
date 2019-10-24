Feature: Create Azure Account

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@name='userName']       |
      | Password | //input[@name='password']       |
      | Sign In  | //button[contains(.,'SIGN IN')] |
    And I open the shared browser "FirefoxNoImplicitWait"
    And I maximize the window
    And I set the window size to "1024" x "768"
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
      | Azure Subscription   | //span[./div/div/div[text()='Azure Subscription']]   |
      | Account name         | //input[contains(@id,'Accountname')]                 |
      | Subscription ID      | //input[contains(@id,'Subscription')]                |
      | Tenant ID            | //input[contains(@id,'ActiveDirectoryTenantID')]     |
      | Application ID       | //input[contains(@id,'ActiveDirectoryAppicationID')] |
      | Application Password | //input[contains(@id,'ActiveDirectoryPasswordKey')]  |
      | Save                 | (//button[contains(.,'Save')])[2]                    |

    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Creating Azure account" for "3" seconds

    And I highlight outside the "Infrastructure" link with an offset of "5"
    And I save a screenshot to "C:\screenshots\octopus\azureaccount\005-infrastructure.png"
    And I click the "Infrastructure" link
    And I sleep for "1" second

    And I force click the "More" link waiting up to "5" seconds if it exists
    And I click the "Accounts" link
    And I click the "Add Account" button
    And I click the "Azure Subscription" option

    And I populate the "Account name" text box with "Azure"

    And I scroll the "Subscription ID" text box into view offset by "-200"
    And I populate the "Subscription ID" text box with "ExternalAzureSubscriptionID"

    And I scroll the "Tenant ID" text box into view offset by "-200"
    And I populate the "Tenant ID" text box with "ExternalAzureTenantID"

    And I scroll the "Application ID" text box into view offset by "-200"
    And I populate the "Application ID" text box with "ExternalApplicationTenantID"

    And I scroll the "Application Password" text box into view offset by "-200"
    And I populate the "Application Password" text box with "ExternalApplicationPassword"

    And I click the "Save" button

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser