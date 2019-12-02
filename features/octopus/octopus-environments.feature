Feature: Configure the Octopus environments

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username   | //input[@name='userName']                                                                                 |
      | Password   | //input[@name='password']                                                                                 |
      | Sign In    | //button[contains(.,'SIGN IN')]                                                                           |
      | Close help | //div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M11 18h2v-2h-2v2zm1-16C6.48 2 2')]] |
    And I open the shared browser "ExternalBrowserType"
    And I fullscreen the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button
    And I click the "Close help" button

  Scenario: Add dev, test and prod
    Given I set the following aliases:
      | Infrastructure       | //span[contains(.,'Infrastructure')]                                                 |
      | Environments         | (//a[contains(.,'Environments')])[1]                                                 |
      | Environments text    | (//a/span[contains(.,'Environments')])[1] \| //a[contains(.,'Environments')][not(*)] |
      | Add Environment      | //button[contains(.,'Add Environment')]                                              |
      | New environment name | //input[contains(@id, 'Newenvironmentname')]                                         |
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