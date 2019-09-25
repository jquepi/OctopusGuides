Feature: Add a manual intervention step

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
    And I display a note with the text "Add a manual sign off step to the deployment" for "3" seconds
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

  @add-manual-intervention
  Scenario: Assign the lifecycle
    Given I set the following aliases:
      | Projects               | //span[contains(.,'Projects')]                                                                                     |
      | Random Quotes          | //a[@href='#/Spaces-1/projects/random-quotes']                                                                     |
      | Process                | //a[contains(.,'Process')]                                                                                         |
      | Process text           | //a/span[contains(.,'Process')] \| //a[contains(.,'Process')][not(*)]                                              |
      | Add Step               | //button[contains(.,'Add Step')]                                                                                   |
      | Search                 | //input[@type='search']                                                                                            |
      | Manual Intervention    | //div[contains(@class, 'add-step-card') and contains(.,'Manual Intervention Required')]                            |
      | Add                    | //div[contains(@class, 'add-step-card') and contains(.,'Manual Intervention Required')]//button[contains(.,'Add')] |
      | Step Name              | //input[contains(@id, 'Stepname')]                                                                                 |
      | Instructions           | //textarea[contains(@id, 'Instructions')]                                                                          |
      | Instructions container | //div[./textarea[contains(@id, 'Instructions')]]                                                                   |
      | Save                   | //button[contains(.,'Save')]                                                                                       |

    And I open the URL "http://localhost/app#"

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
    And I save a screenshot to "C:\screenshots\intervention\015-octopus-search-intervention.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Manual Intervention" tile into view offset by "-200"
    And I highlight outside the "Manual Intervention" tile
    And I save a screenshot to "C:\screenshots\intervention\020-octopus-add-intervention.png"
    And I mouse over the "Manual Intervention" tile
    And I click the "Add" button

    And I highlight outside the "Step Name" text box
    And I populate the "Step Name" text box with "Deployment Sign Off"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\intervention\025-octopus-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "Instructions" text box into view offset by "-300"
    And I highlight outside the "Instructions container" element
    And I click the "Instructions" text box
    And I populate the "Instructions" text box with "Open the application at [http://localhost:#{IIS Port}](http://localhost:#{IIS Port}) and confirm it deployed successfully."
    And I save a screenshot to "C:\screenshots\intervention\030-octopus-step-instructions.png"
    And I remove the highlight from the "Instructions container" element

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser