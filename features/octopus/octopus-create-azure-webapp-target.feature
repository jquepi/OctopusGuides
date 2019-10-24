Feature: Create Azure Web App Target

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

  Scenario: Add target
    Given I set the following aliases:
      | Infrastructure          | //span[contains(.,'Infrastructure')]                                                                    |
      | Deployment Targets      | (//a[contains(.,'Deployment Targets')])[1]                                                              |
      | Deployment Targets text | (//a/span[contains(.,'Deployment Targets')])[1]                                                         |
      | Add Deployment Target   | //button[contains(.,'Add deployment target')]                                                           |
      | Azure                   | //button[contains(.,'Azure')]                                                                           |
      | Azure Web App           | //div[contains(@class, 'EndpointCard_card') and contains(.,'Azure Web App')]                            |
      | Add                     | //div[contains(@class, 'EndpointCard_card') and contains(.,'Azure Web App')]//button[contains(.,'Add')] |
      | Save                    | //button[contains(.,'Save')]                                                                            |
      | Display Name            | //input[contains(@id,'Displayname')]                                                                    |
      | Environments            | //input[@title='Select environments']                                                                   |
      | Dev environment         | //span[./div/div/div[text()='Dev']]                                                                     |
      | Target Roles            | //input[@title='Roles (type to add new)']                                                               |
      | Azure web app role      | //span[./div/div/div[contains(.,'azurewebapp')]]                                                        |
      | Account                 | //div[../../div[text()='Select account']]                                                               |
      | Azure account           | //span[./div/div/div[text()='Azure']]                                                                   |
      | Azure Web App List      | //div[../../div[text()='Web app']]                                                                      |

    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Creating Azure deployment targets" for "3" seconds

    And I highlight outside the "Infrastructure" link with an offset of "5"
    And I save a screenshot to "C:\screenshots\octopus\azuretarget\010-target.png"
    And I click the "Infrastructure" link
    And I remove the highlight from the "Infrastructure" link

    And I highlight outside the "Deployment Targets text" link with an offset of "2"
    And I save a screenshot to "C:\screenshots\octopus\azuretarget\020-target.png"
    And I click the "Deployment Targets" link

    And I highlight outside the "Add Deployment Target" button
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\azuretarget\030-target.png"
    And I click the "Add Deployment Target" button

    And I click the "Azure" button

    And I scroll the "Azure Web App" tile into view offset by "-200"
    And I highlight outside the "Azure Web App" tile
    And I save a screenshot to "C:\screenshots\octopus\azuretarget\040-target.png"
    And I mouse over the "Azure Web App" tile
    And I click the "Add" button

    And I highlight outside the "Display Name" text box
    And I populate the "Display Name" text box with "ExternalTargetName"
    And I save a screenshot to "C:\screenshots\octopus\azuretarget\050-target.png"

    And I highlight outside the "Environments" text box
    And I scroll the "Environments" text box into view offset by "-200"
    And I populate the "Environments" text box with "ExternalEnvironmentName"
    And I click the "ExternalEnvironment" option
    And I save a screenshot to "C:\screenshots\octopus\azuretarget\055-target.png"

    And I highlight outside the "Target Roles" text box
    And I scroll the "Target Roles" text box into view offset by "-200"
    And I populate the "Target Roles" text box with "azurewebapp"
    And I click the "Azure web app role" option
    And I save a screenshot to "C:\screenshots\octopus\azuretarget\060-target.png"

    And I highlight outside the "Account" text box
    And I scroll the "Account" drop down list into view offset by "-200"
    And I click the "Account" drop down list
    And I click the "Azure account" option
    And I save a screenshot to "C:\screenshots\octopus\azuretarget\070-target.png"
    And I sleep for "5" seconds

    And I highlight outside the "Azure Web App List" text box
    And I scroll the "Azure Web App List" drop down list into view offset by "-200"
    And I click the "Azure Web App List" drop down list
    And I click the "ExternalAzureWebAppOption" option
    And I save a screenshot to "C:\screenshots\octopus\azuretarget\080-target.png"

    And I highlight outside the "Save" button
    And I save a screenshot to "C:\screenshots\octopus\azuretarget\090-target.png"
    And I click the "Save" button

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser