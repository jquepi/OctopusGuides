Feature: Configure the Octopus environments

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments

  Scenario: Add dev, test and prod
    Given I set the following aliases:
      | Infrastructure       | //span[contains(.,'Infrastructure')]                                                 |
      | Environments         | (//a[contains(.,'Environments')])[1]                                                 |
      | Environments text    | (//a/span[contains(.,'Environments')])[1] \| //a[contains(.,'Environments')][not(*)] |
      | Add Environment      | //button[contains(.,'Add Environment')]                                              |
      | New environment name | //input[@name='New environment name']                                                |
      | Save                 | //button[contains(.,'Save')]                                                         |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating the Octopus environments" for "3" seconds

    And I highlight outside the "Infrastructure" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/environments/005-infrastructure.png"
    And I click the "Infrastructure" link

    And I highlight outside the "Environments text" link with an offset of "2"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/environments/010-environments-1.png"
    And I click the "Environments" link

    And I highlight outside the "Add Environment" button
    And I highlight outside the "Environments text" link with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/environments/015-add-environment-1.png"
    And I click the "Add Environment" button
    And I remove the highlight from the "Environments text" link
    And I remove the highlight from the "Add Environment" button
    And I remove the highlight from the "Infrastructure" link

    And I populate the "New environment name" text box with "Dev"
    And I highlight outside the "New environment name" text box with an offset of "2"
    And I highlight outside the "Save" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/environments/020-environment-dev.png"
    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Environments text" link with an offset of "2"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/environments/025-environments-2.png"
    And I click the "Environments" link
    And I highlight outside the "Add Environment" button
    And I save a screenshot to "#{ExternalMediaPath}/octopus/environments/030-add-environment-2.png"
    And I click the "Add Environment" button
    And I remove the highlight from the "Add Environment" button

    And I populate the "New environment name" text box with "Test"
    And I highlight outside the "New environment name" text box with an offset of "2"
    And I highlight outside the "Save" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/environments/035-environment-test.png"
    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Environments text" link with an offset of "2"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/environments/040-environments-3.png"
    And I click the "Environments" link
    And I highlight outside the "Add Environment" button
    And I save a screenshot to "#{ExternalMediaPath}/octopus/environments/045-add-environment-3.png"
    And I click the "Add Environment" button
    And I remove the highlight from the "Add Environment" button

    And I populate the "New environment name" text box with "Prod"
    And I highlight outside the "New environment name" text box with an offset of "2"
    And I highlight outside the "Save" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/environments/050-environment-prod.png"
    And I click the "Save" button
    And I sleep for "1" second

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser