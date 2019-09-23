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
      | Library                         | //span[contains(.,'Library')]                           |
      | Lifecycles                      | //a[contains(.,'Lifecycles')]                           |
      | Add Lifecycle                   | //button[contains(.,'Add Lifecycle')]                   |
      | Lifecycle name                  | //input[contains(@id,'Lifecyclename')]                  |
      | Lifecycle description           | //textarea[contains(@id,'Lifecycledescription')]        |
      | Lifecycle description container | //div[./textarea[contains(@id,'Lifecycledescription')]] |
      | Add Phase                       | (//button[@title='Add phase'])[1]                       |
      | Phase name 1                    | (//input[../label[contains(.,'Phase name')]])[1]        |
      | Add Environment 1               | (//button[@title='Add Environment'])[1]                 |
      | Phase name 2                    | (//input[../label[contains(.,'Phase name')]])[2]        |
      | Add Environment 2               | (//button[@title='Add Environment'])[2]                 |
      | Phase name 3                    | (//input[../label[contains(.,'Phase name')]])[3]        |
      | Add Environment 3               | (//button[@title='Add Environment'])[3]                 |
      | Environment list                | //div[./div[text() = 'Environment']]//button            |
      | Dev environment                 | //div[./div/div[text() = 'Dev']]                        |
      | Test environment                | //div[./div/div[text() = 'Test']]                       |
      | Prod environment                | //div[./div/div[text() = 'Prod']]                       |
      | OK                              | //button[@title='Ok']                                   |
      | Save                            | //button[@title='Save']                                 |

    And I sleep for "1" second
    And I highlight outside the "Library" link
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\005-lifecycle-library.png"
    And I click the "Library" link
    And I remove the highlight from the "Library" link

    And I highlight outside the "Lifecycles" link with an offset of "2"
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\010-lifecycle-lifecycles.png"
    And I click the "Lifecycles" link
    And I sleep for "1" second

    And I highlight outside the "Add Lifecycle" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\015-lifecycle-add-lifecycle.png"
    And I click the "Add Lifecycle" button

    And I populate the "Lifecycle name" text box with "Dev, Test and Prod"
    And I populate the "Lifecycle description" text box with "Progression from the Dev to the Prod environments"
    And I highlight outside the "Lifecycle name" text box with an offset of "2"
    And I highlight outside the "Lifecycle description container" element with an offset of "2"
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\020-lifecycle-name.png"
    And I remove the highlight from the "Lifecycle name" text box
    And I remove the highlight from the "Lifecycle description container" text box

    # Dev environment
    And I highlight outside the "Add Phase" button with an offset of "2"
    And I scroll the "Add Phase" button into view
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\025-lifecycle-add-phase-1.png"
    And I click the "Add Phase" button
    And I remove the highlight from the "Add Phase" button

    And I scroll the "Phase name 1" text box into view offset by "-200"
    And I populate the "Phase name 1" text box with "Dev"
    And I highlight outside the "Phase name 1" text box
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\030-lifecycle-phase-name-1.png"
    And I remove the highlight from the "Phase name 1" text box

    And I highlight outside the "Add Environment 1" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\035-lifecycle-add-environment-1.png"
    And I click the "Add Environment 1" button
    And I remove the highlight from the "Add Environment 1" button

    And I highlight outside the "Environment list" button
    And I highlight outside the "OK" button with an offset of "2"
    And I click the "Environment list" button
    And I click the "Dev environment" option
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\040-lifecycle-select-environment-1.png"
    And I click the "OK" button

    # Test environment
    And I highlight outside the "Add Phase" button with an offset of "2"
    And I scroll the "Add Phase" button into view offset by "-300"
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\045-lifecycle-add-phase-2.png"
    And I click the "Add Phase" button
    And I remove the highlight from the "Add Phase" button

    And I scroll the "Phase name 2" text box into view offset by "-200"
    And I populate the "Phase name 2" text box with "Test"
    And I highlight outside the "Phase name 2" text box
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\050-lifecycle-phase-name-2.png"
    And I remove the highlight from the "Phase name 2" text box

    And I highlight outside the "Add Environment 2" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\055-lifecycle-add-environment-2.png"
    And I click the "Add Environment 2" button
    And I remove the highlight from the "Add Environment 2" button

    And I highlight outside the "Environment list" button
    And I highlight outside the "OK" button with an offset of "2"
    And I click the "Environment list" button
    And I click the "Test environment" option
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\060-lifecycle-select-environment-2.png"
    And I click the "OK" button

    # Prod environment
    And I highlight outside the "Add Phase" button with an offset of "2"
    And I scroll the "Add Phase" button into view offset by "-300"
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\065-lifecycle-add-phase-3.png"
    And I click the "Add Phase" button
    And I remove the highlight from the "Add Phase" button

    And I scroll the "Phase name 3" text box into view offset by "-200"
    And I populate the "Phase name 3" text box with "Prod"
    And I highlight outside the "Phase name 3" text box
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\070-lifecycle-phase-name-3.png"
    And I remove the highlight from the "Phase name 3" text box

    And I highlight outside the "Add Environment 3" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\075-lifecycle-add-environment-3.png"
    And I click the "Add Environment 3" button
    And I remove the highlight from the "Add Environment 3" button

    And I highlight outside the "Environment list" button
    And I highlight outside the "OK" button with an offset of "2"
    And I click the "Environment list" button
    And I click the "Prod environment" option
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\080-lifecycle-select-environment-3.png"
    And I click the "OK" button

    And I highlight outside the "Save" button
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\090-lifecycle-save.png"
    And I click the "Save" button

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser