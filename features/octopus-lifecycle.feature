Feature: Create a Lifecycle in Octopus

  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@name='userName']       |
      | Password | //input[@name='password']       |
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
      | Library               | //span[contains(.,'Library')]                    |
      | Lifecycles            | //a[contains(.,'Lifecycles')]                    |
      | Add Lifecycle         | //button[contains(.,'Add Lifecycle')]            |
      | Lifecycle name        | //input[contains(@id,'Lifecyclename')]           |
      | Lifecycle description | //textarea[contains(@id,'Lifecycledescription')] |
      | Add Phase             | //button[@title='Add phase']                     |
      | Phase name 1          | (//input[../label[contains(.,'Phase name')]])[1] |
      | Add Environment 1     | (//button[@title='Add Environment'])[1]          |
      | Phase name 2          | (//input[../label[contains(.,'Phase name')]])[2] |
      | Add Environment 2     | (//button[@title='Add Environment'])[2]          |
      | Phase name 3          | (//input[../label[contains(.,'Phase name')]])[3] |
      | Add Environment 3     | (//button[@title='Add Environment'])[3]          |
      | Environment list      | //div[./div[text() = 'Environment']]//button     |
      | Dev environment       | //div[./div/div[text() = 'Dev']]                 |
      | Test environment      | //div[./div/div[text() = 'Test']]                |
      | Prod environment      | //div[./div/div[text() = 'Prod']]                |
      | OK                    | //button[@title='Ok']                            |
      | Save                  | //button[@title='Save']                          |

    And I click the "Library" link
    And I click the "Lifecycles" link
    And I click the "Add Lifecycle" button
    And I populate the "Lifecycle name" text box with "Dev, Test and Prod"
    And I populate the "Lifecycle description" text box with "Progression from the Dev to the Prod environments"

    And I click the "Add Phase" button
    And I scroll the "Phase name 1" text box into view offset by "-200"
    And I populate the "Phase name 1" text box with "Dev"
    And I click the "Add Environment 1" button
    And I click the "Environment list" button
    And I click the "Dev environment" option
    And I click the "OK" button

    And I click the "Add Phase" button
    And I scroll the "Phase name 2" text box into view offset by "-200"
    And I populate the "Phase name 2" text box with "Test"
    And I click the "Add Environment 2" button
    And I click the "Environment list" button
    And I click the "Test environment" option
    And I click the "OK" button

    And I click the "Add Phase" button
    And I scroll the "Phase name 3" text box into view offset by "-200"
    And I populate the "Phase name 3" text box with "Prod"
    And I click the "Add Environment 3" button
    And I click the "Environment list" button
    And I click the "Prod environment" option
    And I click the "OK" button

    And I click the "Save" button