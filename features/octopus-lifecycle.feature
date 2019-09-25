Feature: Create a Lifecycle in Octopus

  @login
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
    And I display a note with the text "Create a lifecycle in Octopus" for "3" seconds
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

  @define-lifecycle
  Scenario: Add dev, test and prod
    Given I set the following aliases:
      | Library                         | //span[contains(.,'Library')]                                          |
      | Lifecycles                      | //a[contains(.,'Lifecycles')]                                          |
      | Lifecycles text                 | //a[contains(.,'Lifecycles')][not(*)] \| //a/span[text()='Lifecycles'] |
      | Add Lifecycle                   | //button[contains(.,'Add Lifecycle')]                                  |
      | Lifecycle name                  | //input[contains(@id,'Lifecyclename')]                                 |
      | Lifecycle description           | //textarea[contains(@id,'Lifecycledescription')]                       |
      | Lifecycle description container | //div[./textarea[contains(@id,'Lifecycledescription')]]                |
      | Add Phase                       | (//button[@title='Add phase'])[1]                                      |
      | Phase name 1                    | (//input[../label[contains(.,'Phase name')]])[1]                       |
      | Add Environment 1               | (//button[@title='Add Environment'])[1]                                |
      | Phase name 2                    | (//input[../label[contains(.,'Phase name')]])[2]                       |
      | Add Environment 2               | (//button[@title='Add Environment'])[2]                                |
      | Phase name 3                    | (//input[../label[contains(.,'Phase name')]])[3]                       |
      | Add Environment 3               | (//button[@title='Add Environment'])[3]                                |
      | Environment list                | //div[./div[text() = 'Environment']]//button                           |
      | Dev environment                 | //div[./div/div[text() = 'Dev']]                                       |
      | Test environment                | //div[./div/div[text() = 'Test']]                                      |
      | Prod environment                | //div[./div/div[text() = 'Prod']]                                      |
      | OK                              | //button[@title='Ok']                                                  |
      | Save                            | //button[@title='Save']                                                |
      | Optional phase                  | //input[..//label[text()='Optional phase']]                            |
      | Required to progress            | //div[./h4[text()='Required to progress']]                             |

    And I sleep for "1" second
    And I highlight outside the "Library" link
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\005-lifecycle-library.png"
    And I click the "Library" link

    And I highlight outside the "Lifecycles text" link with an offset of "2"
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\010-lifecycle-lifecycles.png"
    And I click the "Lifecycles" link
    And I highlight outside the "Add Lifecycle" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\015-lifecycle-add-lifecycle.png"
    And I remove the highlight from the "Library text" link
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
    And I force click the "Optional phase" radio button
    And I highlight outside the "Phase name 1" text box
    And I highlight outside the "Required to progress" element
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\030-lifecycle-phase-name-1.png"
    And I remove the highlight from the "Phase name 1" text box
    And I remove the highlight from the "Required to progress" element

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
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\090-lifecycle-save.png"
    And I click the "Save" button

  @assign-lifecycle
  Scenario: Assign the lifecycle
    Given I set the following aliases:
      | Projects           | //span[contains(.,'Projects')]                          |
      | Random Quotes      | //a[@href='#/Spaces-1/projects/random-quotes']          |
      | Process            | //a[contains(.,'Process')]                              |
      | Change             | //button[contains(.,'CHANGE')]                          |
      | Lifecycle list     | //button[../../../../div[text()='Lifecycle']]           |
      | Save               | //button[contains(.,'Save')]                            |
      | Dev, Test and Prod | //span[./div/div/div[contains(.,'Dev, Test and Prod')]] |

    And I open the URL "http://localhost/app#/Spaces-1/library/lifecycles"
    And I display a note with the text "Assign the custom lifecycle to the Octopus project" for "3" seconds

    And I highlight outside the "Projects" link
    And I click the "Projects" link
    And I sleep for "1" second

    And I highlight inside the "Random Quotes" project tile
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\095-random-quotes-project.png"
    And I remove the highlight from the "Projects" link
    And I click the "Random Quotes" project tile

    And I highlight inside the "Process" link
    And I click the "Process" link
    And I highlight outside the "Change" button
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\100-random-quotes-change-lifecycle.png"
    And I remove the highlight from the "Process" button
    And I remove the highlight from the "Change" button
    And I click the "Change" button

    And I highlight outside the "Lifecycle list" button
    And I highlight outside the "Save" button with an offset of "2"
    And I click the "Lifecycle list" button
    And I click the "Dev, Test and Prod" option
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\105-random-quotes-select-lifecycle.png"
    And I click the "Save" button
    And I sleep for "2" seconds

  @deploy-to-dev
  Scenario: Deploy to the test environment
    Given I set the following aliases:
      | Create Release | //button[contains(.,'Create release')] |
      | Deploy To      | //button[contains(.,'Deploy to...')]   |
      | Test           | //span[./div/div/div[text()='Test']]   |
      | Deploy         | //button[contains(.,'Deploy')]         |
      | Save           | //button[contains(.,'Save')]           |

    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/process"
    And I display a note with the text "Deploy to the Test environment, skipping Dev" for "3" seconds

    And I click the "Create Release" button
    And I highlight outside the "Create Release" button
    And I highlight outside the "Save" button
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\110-random-quotes-create-release.png"
    And I remove the highlight from the "Create Release" button
    And I click the "Save" button

    And I highlight outside the "Deploy To" button
    And I click the "Deploy To" button
    And I highlight inside the "Test" option
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\115-random-quotes-select-test.png"
    And I click the "Test" option

    And I sleep for "1" second
    And I highlight outside the "Deploy" button
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\120-random-quotes-deploy-test.png"
    And I click the "Deploy" button

    And I sleep for "30" seconds
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\125-random-quotes-deployed-test.png"

  Scenario: Open the app
    And I open the URL "http://localhost:8082"
    And I display a note with the text "Open the application in the Test environment (port 8082)" for "3" seconds
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\130-random-quotes-test-app.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser