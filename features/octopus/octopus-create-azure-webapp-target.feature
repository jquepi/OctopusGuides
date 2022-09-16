Feature: Create Azure Web App Target

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments

  Scenario: Add target
    Given I set the following aliases:
      | Infrastructure          | //span[contains(.,'Infrastructure')]                                                                    |
      | Deployment Targets      | (//a[contains(.,'Deployment Targets')])[1]                                                              |
      | Deployment Targets text | (//a/span[contains(.,'Deployment Targets')] \| //a[contains(.,'Deployment Targets')])[1]                |
      | Add Deployment Target   | //button[contains(.,'Add deployment target')]                                                           |
      | Azure                   | //button[contains(.,'Azure')]                                                                           |
      | Azure Web App           | //div[contains(@class, 'EndpointCard-module_card') and contains(.,'Azure Web App')]                            |
      | Add                     | //div[contains(@class, 'EndpointCard-module_card') and contains(.,'Azure Web App')]//button[contains(.,'Add')] |
      | Save                    | //button[contains(.,'Save')]                                                                            |
      | Display Name            | //input[@name='Display name']                                                                           |
      | Environments            | //input[../../label[text()='Select environments']]                                                      |
      | Environments Container  | //div[./div/div/div/label[text()='Select environments']]                                                |
      | Dev environment         | //span[./div/div/div[text()='Dev']]                                                                     |
      | Target Roles            | //input[../../label[text()='Roles (type to add new)']]                                                  |
      | Target Roles Container  | //div[./div/div/label[text()='Roles (type to add new)']]                                                |
      | Azure web app role      | //span[./div/div/div[contains(.,'azurewebapp')]]                                                        |
      | Account                 | //div[../../label[text()='Select account']]                                                             |
      | Azure account           | //button[./div/div[text()='Azure']]                                                                     |
      | Azure Web App List      | //div[../../label[text()='Web app']]                                                                    |
      | Expand All              | //a[text()='EXPAND ALL']                                                                                |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating Azure deployment targets" for "3" seconds

    And I highlight outside the "Infrastructure" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azuretarget/010-target.png"
    And I click the "Infrastructure" link
    And I remove the highlight from the "Infrastructure" link

    And I highlight outside the "Deployment Targets text" link with an offset of "2"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azuretarget/020-target.png"
    And I click the "Deployment Targets" link

    And I highlight outside the "Add Deployment Target" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azuretarget/030-target.png"
    And I click the "Add Deployment Target" button

    And I click the "Azure" button

    And I scroll the "Azure Web App" tile into view offset by "-200"
    And I highlight outside the "Azure Web App" tile
    And I mouse over the "Azure Web App" tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azuretarget/040-target.png"
    And I force click the "Add" button

    And I stop recording the screen
    And I sleep for "5" seconds
    And I click the "Expand All" link if the "Display Name" text box does not exist
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Display Name" text box
    And I populate the "Display Name" text box with "ExternalTargetName"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azuretarget/050-target.png"

    And I highlight inside the "Environments Container" element
    And I scroll the "Environments" text box into view offset by "-200"
    And I populate the "Environments" text box with "ExternalEnvironmentName"
    And I click the "ExternalEnvironment" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azuretarget/055-target.png"

    And I highlight outside the "Target Roles Container" element
    And I scroll the "Target Roles" text box into view offset by "-200"
    And I populate the "Target Roles" text box with "azurewebapp"
    And I click the "Azure web app role" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azuretarget/060-target.png"

    And I highlight outside the "Account" text box
    And I scroll the "Account" drop down list into view offset by "-200"
    And I click the "Account" drop down list
    And I click the "Azure account" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azuretarget/070-target.png"

    # Pause the recording to remove some dead time in the video
    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "14" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Azure Web App List" text box
    And I scroll the "Azure Web App List" drop down list into view offset by "-200"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azuretarget/075-target.png"
    And I click the "Azure Web App List" drop down list
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azuretarget/080-target.png"
    And I scroll the "ExternalAzureWebAppOption" option into view offset by "-200"
    And I click the "ExternalAzureWebAppOption" option

    And I highlight outside the "Save" button
    And I save a screenshot to "#{ExternalMediaPath}/octopus/azuretarget/090-target.png"
    And I click the "Save" button

    And I sleep for "1" second

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser