Feature: Add a manual intervention step

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments

  @add-manual-intervention
  Scenario: Add the intervention step
    Given I set the following aliases:
      | Projects                      | //span[contains(.,'Projects')]                                                                  |
      | Random Quotes                 | //a[@href='#/Spaces-1/projects/random-quotes']                                                  |
      | Deployments                   | //a[contains(.,'Deployments')]                                                                  |
      | Process                       | //a[contains(.,'Process')][not(*)] \| //a//div[text()='Process']                                |
      | Add Step                      | //button[contains(.,'Add Step')]                                                                |
      | Search                        | //input[@name='Filter by name, category or description...']                                     |
      | Manual Intervention           | //div[./div/div[text()='Manual Intervention Required']]                                         |
      | Add                           | //div[./div/div[text()='Manual Intervention Required']]//button[contains(.,'Add')]              |
      | Step Name                     | //input[@name='Step name']                                                                      |
      | Instructions                  | //textarea[@name='Instructions']                                                                |
      | Instructions container        | //div[./textarea[@name='Instructions']]                                                         |
      | Environments                  | //span[contains(.,'Environments')]                                                              |
      | Save                          | //button[contains(.,'Save')]                                                                    |
      | Skip specific environment     | //input[../div[contains(.,'Skip specific environments')]]                                       |
      | Select environments           | //input[../../label[text()='Select environments']]                                              |
      | Select environments container | //div[./div/div/div/label[text()='Select environments']]                                        |
      | Dev Environment               | //div[contains(@class, 'VirtualListWithKeyboard')]//span[contains(.,'Dev')]//span |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Add a manual sign off step to the deployment" for "3" seconds

    And I highlight outside the "Projects" link
    And I click the "Projects" link
    And I sleep for "1" second

    And I highlight inside the "Random Quotes" project tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/intervention/#{GuideSpecificScreenshotDir}005-random-quotes-project.png"
    And I remove the highlight from the "Projects" link
    And I click the "Random Quotes" project tile

    And I highlight inside the "Deployments" link
    And I click the "Deployments" link
    And I highlight inside the "Process" link
    And I click the "Process" link
    And I scroll the "Add Step" button into view offset by "-500"
    And I highlight outside the "Add Step" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/intervention/#{GuideSpecificScreenshotDir}010-add-step.png"
    And I remove the highlight from the "Deployments" link
    And I remove the highlight from the "Process" link
    And I click the "Add Step" button

    And I highlight outside the "Search" text box with an offset of "3"
    And I populate the "Search" text box with "manual intervention"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/intervention/#{GuideSpecificScreenshotDir}015-octopus-search-intervention.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Manual Intervention" tile into view offset by "-200"
    And I highlight outside the "Manual Intervention" tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/intervention/#{GuideSpecificScreenshotDir}020-octopus-add-intervention.png"
    And I mouse over the "Manual Intervention" tile
    And I force click the "Add" button

    And I highlight outside the "Step Name" text box
    And I force clear the "Step Name" text box
    And I populate the "Step Name" text box with "Deployment Sign Off"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/intervention/#{GuideSpecificScreenshotDir}025-octopus-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "Instructions" text box into view offset by "-300"
    And I highlight outside the "Instructions container" element
    And I populate the "Instructions" text box with "Open the application and confirm it meets all the requirements."
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/intervention/#{GuideSpecificScreenshotDir}030-octopus-step-instructions.png"
    And I remove the highlight from the "Instructions container" element

    And I scroll the "Environments" section into view offset by "-300"
    And I highlight outside the "Environments" element
    And I click the "Environments" element if the "Skip specific environment" radio button does not exist
    And I save a screenshot to "#{ExternalMediaPath}/octopus/intervention/#{GuideSpecificScreenshotDir}035-octopus-step-conditions.png"

    And I scroll the "Skip specific environment" radio button into view offset by "-300"
    And I highlight outside the "Skip specific environment" radio button
    And I force click the "Skip specific environment" radio button
    And I save a screenshot to "#{ExternalMediaPath}/octopus/intervention/#{GuideSpecificScreenshotDir}040-octopus-step-skip-envs.png"
    And I remove the highlight from the "Skip specific environment" radio button

    And I scroll the "Select environments" text box into view offset by "-400"
    And I highlight outside the "Select environments container" element
    And I populate the "Select environments" text box with "Dev"
    And I click the "Dev Environment" option
    And I highlight the "Save" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/intervention/#{GuideSpecificScreenshotDir}045-octopus-step-skip-dev.png"
    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds

  @deploy-to-test
  Scenario: Deploy to the test environment
    Given I set the following aliases:
      | Create Release | //button[contains(.,'Create release')]              |
      | Deploy To      | //button[contains(.,'Deploy to...')]                |
      | Test           | //a[./div/div[text()='Test']] \| //a[text()='Test'] |
      | Deploy         | //button[contains(.,'Deploy')]                      |
      | Save           | //button[contains(.,'Save')]                        |

    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/deployments/process"
    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Deploy to the Test environment" for "3" seconds

    And I click the "Create Release" button
    And I highlight inside the "Create Release" button
    And I highlight outside the "Save" button
    And I sleep for "1" second
    And I remove the highlight from the "Create Release" button
    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Deploy To" button
    And I click the "Deploy To" button
    And I highlight inside the "Test" option
    And I sleep for "1" second
    And I click the "Test" option

    And I sleep for "3" second
    And I highlight outside the "Deploy" button
    And I sleep for "1" second
    And I click the "Deploy" button
    And I sleep for "5" seconds

    And I stop recording the screen

  @approve-deployment
  Scenario: Approve manual intervention
    Given I set the following aliases:
      | Assign to me    | //button[contains(.,'Assign to me')] |
      | Proceed         | //button[contains(.,'Proceed')]      |
      | Notes           | //textarea[@name='Notes']            |
      | Notes container | //div[./textarea[@name='Notes']]     |
      | Task Log        | //button[contains(.,'Task Log')]     |

    And I verify the "Assign to me" button is present waiting up to "1200" seconds if it exists

    # If the button does not exist, look at the logs
    And I force click the "Task Log" button if the "Assign to me" button does not exist
    And I scroll down "10000" px

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I scroll the "Assign to me" button into view offset by "-500" if it exists
    And I highlight outside the "Assign to me" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/intervention/#{GuideSpecificScreenshotDir}050-octopus-deploy-assign-intervention.png"
    And I click the "Assign to me" button
    And I sleep for "1" second

    And I highlight outside the "Notes container" text box with an offset of "2"
    And I highlight outside the "Proceed" button with an offset of "2"
    And I scroll the "Notes" text box into view offset by "-200"
    And I populate the "Notes" text box with "Confirmed this deployment meets all the requirements."
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/intervention/#{GuideSpecificScreenshotDir}055-octopus-deploy-intervention-notes.png"
    And I click the "Proceed" button
    And I sleep for "10" second

    And I save a screenshot to "#{ExternalMediaPath}/octopus/intervention/#{GuideSpecificScreenshotDir}060-octopus-deploy-success.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser