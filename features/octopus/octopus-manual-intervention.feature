Feature: Add a manual intervention step

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
    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Add a manual sign off step to the deployment" for "3" seconds
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

  @add-manual-intervention
  Scenario: Add the intervention step
    Given I set the following aliases:
      | Projects                      | //span[contains(.,'Projects')]                                                                                     |
      | Random Quotes                 | //a[@href='#/Spaces-1/projects/random-quotes']                                                                     |
      | Process                       | //a[contains(.,'Process')]                                                                                         |
      | Process text                  | //a/span[contains(.,'Process')] \| //a[contains(.,'Process')][not(*)]                                              |
      | Add Step                      | //button[contains(.,'Add Step')]                                                                                   |
      | Search                        | //input[contains(@id, 'Filterbynamecategoryordescription')]                                                        |
      | Manual Intervention           | //div[contains(@class, 'add-step-card') and contains(.,'Manual Intervention Required')]                            |
      | Add                           | //div[contains(@class, 'add-step-card') and contains(.,'Manual Intervention Required')]//button[contains(.,'Add')] |
      | Step Name                     | //input[contains(@id, 'Stepname')]                                                                                 |
      | Instructions                  | //textarea[contains(@id, 'Instructions')]                                                                          |
      | Instructions container        | //div[./textarea[contains(@id, 'Instructions')]]                                                                   |
      | Environments                  | //span[contains(.,'Environments')]                                                                                 |
      | Save                          | //button[contains(.,'Save')]                                                                                       |
      | Skip specific environment     | //input[../div[contains(.,'Skip specific environments')]]                                                          |
      | Select environments           | //input[@title='Select environments']                                                                              |
      | Select environments container | //div[./div/div/div/div/div/input[@title='Select environments']]                                                   |
      | Dev Environment               | //div[contains(@class, 'VirtualListWithKeyboard_menuContainer')]//span[contains(.,'Dev')]//span                    |

    And I open the URL "http://localhost/app#"
    And I sleep for "1" second

    And I highlight outside the "Projects" link
    And I click the "Projects" link
    And I sleep for "1" second

    And I highlight inside the "Random Quotes" project tile
    And I save a screenshot to "C:\screenshots\octopus\intervention\005-random-quotes-project.png"
    And I remove the highlight from the "Projects" link
    And I click the "Random Quotes" project tile

    And I highlight outside the "Process text" link with an offset of "2"
    And I click the "Process" link
    And I highlight outside the "Add Step" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\intervention\010-add-step.png"
    And I remove the highlight from the "Process text" link
    And I click the "Add Step" button

    And I highlight outside the "Search" text box with an offset of "3"
    And I populate the "Search" text box with "manual intervention"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\intervention\015-octopus-search-intervention.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Manual Intervention" tile into view offset by "-200"
    And I highlight outside the "Manual Intervention" tile
    And I save a screenshot to "C:\screenshots\octopus\intervention\020-octopus-add-intervention.png"
    And I mouse over the "Manual Intervention" tile
    And I click the "Add" button

    And I highlight outside the "Step Name" text box
    And I populate the "Step Name" text box with "Deployment Sign Off"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\intervention\025-octopus-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "Instructions" text box into view offset by "-300"
    And I highlight outside the "Instructions container" element
    And I populate the "Instructions" text box with "Open the application at [http://localhost:#{IIS Port}](http://localhost:#{IIS Port}) and confirm it meets all the requirements."
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\intervention\030-octopus-step-instructions.png"
    And I remove the highlight from the "Instructions container" element

    And I scroll the "Environments" section into view offset by "-300"
    And I highlight outside the "Environments" element
    And I click the "Environments" element
    And I save a screenshot to "C:\screenshots\octopus\intervention\035-octopus-step-conditions.png"

    And I scroll the "Skip specific environment" radio button into view offset by "-300"
    And I highlight outside the "Skip specific environment" radio button
    And I force click the "Skip specific environment" radio button
    And I save a screenshot to "C:\screenshots\octopus\intervention\040-octopus-step-skip-envs.png"
    And I remove the highlight from the "Skip specific environment" radio button

    And I scroll the "Select environments" text box into view offset by "-400"
    And I highlight outside the "Select environments container" element
    And I populate the "Select environments" text box with "Dev"
    And I click the "Dev Environment" option
    And I highlight the "Save" button
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\intervention\045-octopus-step-skip-dev.png"
    And I click the "Save" button
    And I sleep for "2" seconds

  @deploy-to-test
  Scenario: Deploy to the test environment
    Given I set the following aliases:
      | Create Release | //button[contains(.,'Create release')] |
      | Deploy To      | //button[contains(.,'Deploy to...')]   |
      | Test           | //span[./div/div/div[text()='Test']]   |
      | Deploy         | //button[contains(.,'Deploy')]         |
      | Save           | //button[contains(.,'Save')]           |

    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/process"
    And I display a note with the text "Deploy to the Test environment" for "3" seconds

    And I click the "Create Release" button
    And I highlight outside the "Create Release" button
    And I highlight outside the "Save" button
    And I sleep for "1" second
    And I remove the highlight from the "Create Release" button
    And I click the "Save" button

    And I highlight outside the "Deploy To" button
    And I click the "Deploy To" button
    And I highlight inside the "Test" option
    And I sleep for "1" second
    And I click the "Test" option

    And I sleep for "3" second
    And I highlight outside the "Deploy" button
    And I sleep for "1" second
    And I click the "Deploy" button

    And I sleep for "23" seconds

  @approve-deployment
  Scenario: Approve manual intervention
    Given I set the following aliases:
      | Assign to me    | //button[contains(.,'Assign to me')]     |
      | Proceed         | //button[contains(.,'Proceed')]          |
      | Notes           | //textarea[contains(@id,'Notes')]        |
      | Notes container | //div[./textarea[contains(@id,'Notes')]] |

    And I highlight outside the "Assign to me" button
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\intervention\050-octopus-deploy-assign-intervention.png"
    And I click the "Assign to me" button
    And I sleep for "1" second

    And I highlight outside the "Notes container" text box with an offset of "2"
    And I highlight outside the "Proceed" button with an offset of "2"
    And I scroll the "Notes" text box into view offset by "-200"
    And I populate the "Notes" text box with "Confirmed this deployment meets all the requirements."
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\intervention\055-octopus-deploy-intervention-notes.png"
    And I click the "Proceed" button
    And I sleep for "20" second

    And I save a screenshot to "C:\screenshots\octopus\intervention\060-octopus-deploy-success.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser