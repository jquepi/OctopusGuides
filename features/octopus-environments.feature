Feature: Configure the Octopus environments

  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@name='userName']     |
      | Password | //input[@name='password']     |
      | Sign In  | //button[contains(.,'SIGN IN')] |
    And I open the shared browser "FirefoxNoImplicitWait"
    And I maximize the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I start recording the screen to the directory "C:\screenshots"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

  Scenario: Add dev, test and prod
    Given I set the following aliases:
      | Infrastructure       | //span[contains(.,'Infrastructure')]         |
      | Environments         | (//a[contains(.,'Environments')])[1]         |
      | Add Environment      | //button[contains(.,'Add Environment')]      |
      | New environment name | //input[contains(@id, 'Newenvironmentname')] |
      | Save                 | //button[contains(.,'Save')]                 |
    And I click the "Infrastructure" link

    And I click the "Environments" link
    And I click the "Add Environment" button
    And I populate the "New environment name" text box with "Dev"
    And I click the "Save" button

    And I click the "Environments" link
    And I click the "Add Environment" button
    And I populate the "New environment name" text box with "Test"
    And I click the "Save" button

    And I click the "Environments" link
    And I click the "Add Environment" button
    And I populate the "New environment name" text box with "Prod"
    And I click the "Save" button

    And I sleep for "1" second

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "2000" milliseconds
    And I stop recording the screen
    And I clear the transition
    And I close the browser