Feature: Create a Lifecycle in Octopus

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments

  @define-lifecycle
  Scenario: Add dev, test and prod
    Given I set the following aliases:
      | More                            | //span[contains(.,'More')]                                             |
      | Library                         | //span[contains(.,'Library')]                                          |
      | Lifecycles                      | //a[contains(.,'Lifecycles')]                                          |
      | Lifecycles text                 | //a[contains(.,'Lifecycles')][not(*)] \| //a/span[text()='Lifecycles'] |
      | Add Lifecycle                   | //button[contains(.,'Add Lifecycle')]                                  |
      | Lifecycle name                  | //input[@name='Lifecycle name']                                        |
      | Lifecycle description           | //textarea[@name='Lifecycle description']                              |
      | Lifecycle description container | //div[./textarea[@name='Lifecycle description']]                       |
      | Add Phase                       | (//button[@title='Add phase'])[1]                                      |
      | Phase name 1                    | (//input[../../label[contains(.,'Phase name')]])[1]                    |
      | Add Environment 1               | (//button[@title='Add Environment'])[1]                                |
      | Phase name 2                    | (//input[../../label[contains(.,'Phase name')]])[2]                    |
      | Add Environment 2               | (//button[@title='Add Environment'])[2]                                |
      | Phase name 3                    | (//input[../../label[contains(.,'Phase name')]])[3]                    |
      | Add Environment 3               | (//button[@title='Add Environment'])[3]                                |
      | Environment list                | //div[./label[text() = 'Environment']]//button                         |
      | Dev environment                 | //button[./div/div[text()='Dev']]                                      |
      | Test environment                | //button[./div/div[text()='Test']]                                     |
      | Prod environment                | //button[./div/div[text()='Prod']]                                     |
      | OK                              | //button[@title='Ok']                                                  |
      | Save                            | //button[@title='Save']                                                |
      | Optional phase                  | //input[..//label[text()='Optional phase']]                            |
      | Required to progress            | //div[./h4[text()='Required to progress']]                             |
      | Expand All                      | //a[text()='EXPAND ALL']                                               |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Create a lifecycle in Octopus" for "3" seconds

    And I click the "More" link waiting up to "1" seconds if the "Library" link does not exist

    And I highlight outside the "Library" link
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}005-lifecycle-library.png"
    And I click the "Library" link

    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}010-lifecycle-lifecycles.png"
    And I click the "Lifecycles" link
    And I highlight outside the "Lifecycles text" link with an offset of "2"
    And I highlight outside the "Add Lifecycle" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}015-lifecycle-add-lifecycle.png"
    And I remove the highlight from the "Library" link if it exists
    And I click the "Add Lifecycle" button

    And I stop recording the screen
    And I sleep for "5" seconds
    And I click the "Expand All" link if the "Lifecycle name" text box does not exist
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I populate the "Lifecycle name" text box with "Dev, Test and Prod"
    And I populate the "Lifecycle description" text box with "Progression from the Dev to the Prod environments"
    And I highlight outside the "Lifecycle name" text box with an offset of "2"
    And I highlight outside the "Lifecycle description container" element with an offset of "2"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}020-lifecycle-name.png"
    And I remove the highlight from the "Lifecycle name" text box
    And I remove the highlight from the "Lifecycle description container" text box

    # Dev environment
    And I highlight outside the "Add Phase" button with an offset of "2"
    And I scroll the "Add Phase" button into view
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}025-lifecycle-add-phase-1.png"
    # Force click to fix:
    # org.openqa.selenium.ElementClickInterceptedException: element click intercepted: Element <button title="Add phase" class="style_globalActionButton__2mAxn style_secondaryButton__2KOA8" tabindex="0" type="button" style="border: 10px; box-sizing: border-box; display: inline-block; font-family: Roboto, sans-serif; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); cursor: pointer; text-decoration: none; margin: 0px; padding: 0px; outline: rgb(0, 204, 101) solid 5px; font-size: inherit; font-weight: inherit; position: relative; height: 36px; line-height: 36px; min-width: 88px; color: rgb(51, 51, 51); transition: all 450ms cubic-bezier(0.23, 1, 0.32, 1) 0ms; border-radius: 2px; user-select: none; overflow: hidden; background-color: rgba(0, 0, 0, 0); text-align: center; outline-offset: 2px;">...</button> is not clickable at point (1489, 18). Other element would receive the click: <ul>...</ul>
    And I force click the "Add Phase" button
    And I remove the highlight from the "Add Phase" button

    And I scroll the "Phase name 1" text box into view offset by "-200"
    And I populate the "Phase name 1" text box with "Dev"
    And I force click the "Optional phase" radio button
    And I highlight outside the "Phase name 1" text box
    And I highlight outside the "Required to progress" element
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}030-lifecycle-phase-name-1.png"
    And I remove the highlight from the "Phase name 1" text box
    And I remove the highlight from the "Required to progress" element

    And I highlight outside the "Add Environment 1" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}035-lifecycle-add-environment-1.png"
    And I click the "Add Environment 1" button
    And I remove the highlight from the "Add Environment 1" button

    And I highlight outside the "Environment list" button
    And I highlight outside the "OK" button with an offset of "2"
    And I click the "Environment list" button
    And I click the "Dev environment" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}040-lifecycle-select-environment-1.png"
    And I click the "OK" button

    # Test environment
    And I highlight outside the "Add Phase" button with an offset of "2"
    And I sleep for "1" second
    And I scroll the "Add Phase" button into view offset by "-300"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}045-lifecycle-add-phase-2.png"
    # Force click to fix:
    # org.openqa.selenium.ElementClickInterceptedException: element click intercepted: Element <button title="Add phase" class="style_globalActionButton__2mAxn style_secondaryButton__2KOA8" tabindex="0" type="button" style="border: 10px; box-sizing: border-box; display: inline-block; font-family: Roboto, sans-serif; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); cursor: pointer; text-decoration: none; margin: 0px; padding: 0px; outline: rgb(0, 204, 101) solid 5px; font-size: inherit; font-weight: inherit; position: relative; height: 36px; line-height: 36px; min-width: 88px; color: rgb(51, 51, 51); transition: all 450ms cubic-bezier(0.23, 1, 0.32, 1) 0ms; border-radius: 2px; user-select: none; overflow: hidden; background-color: rgba(0, 0, 0, 0); text-align: center; outline-offset: 2px;">...</button> is not clickable at point (1489, 18). Other element would receive the click: <ul>...</ul>
    And I force click the "Add Phase" button
    And I remove the highlight from the "Add Phase" button

    And I scroll the "Phase name 2" text box into view offset by "-200"
    And I populate the "Phase name 2" text box with "Test"
    And I highlight outside the "Phase name 2" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}050-lifecycle-phase-name-2.png"
    And I remove the highlight from the "Phase name 2" text box

    And I highlight outside the "Add Environment 2" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}055-lifecycle-add-environment-2.png"
    And I click the "Add Environment 2" button
    And I remove the highlight from the "Add Environment 2" button

    And I highlight outside the "Environment list" button
    And I highlight outside the "OK" button with an offset of "2"
    And I click the "Environment list" button
    And I click the "Test environment" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}060-lifecycle-select-environment-2.png"
    And I click the "OK" button

    # Prod environment
    And I highlight outside the "Add Phase" button with an offset of "2"
    And I sleep for "1" second
    And I scroll the "Add Phase" button into view offset by "-300"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}065-lifecycle-add-phase-3.png"
    # Force click to fix:
    # org.openqa.selenium.ElementClickInterceptedException: element click intercepted: Element <button title="Add phase" class="style_globalActionButton__2mAxn style_secondaryButton__2KOA8" tabindex="0" type="button" style="border: 10px; box-sizing: border-box; display: inline-block; font-family: Roboto, sans-serif; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); cursor: pointer; text-decoration: none; margin: 0px; padding: 0px; outline: rgb(0, 204, 101) solid 5px; font-size: inherit; font-weight: inherit; position: relative; height: 36px; line-height: 36px; min-width: 88px; color: rgb(51, 51, 51); transition: all 450ms cubic-bezier(0.23, 1, 0.32, 1) 0ms; border-radius: 2px; user-select: none; overflow: hidden; background-color: rgba(0, 0, 0, 0); text-align: center; outline-offset: 2px;">...</button> is not clickable at point (1489, 18). Other element would receive the click: <ul>...</ul>
    And I force click the "Add Phase" button
    And I remove the highlight from the "Add Phase" button

    And I scroll the "Phase name 3" text box into view offset by "-200"
    And I populate the "Phase name 3" text box with "Prod"
    And I highlight outside the "Phase name 3" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}070-lifecycle-phase-name-3.png"
    And I remove the highlight from the "Phase name 3" text box

    And I highlight outside the "Add Environment 3" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}075-lifecycle-add-environment-3.png"
    And I click the "Add Environment 3" button
    And I remove the highlight from the "Add Environment 3" button

    And I highlight outside the "Environment list" button
    And I highlight outside the "OK" button with an offset of "2"
    And I click the "Environment list" button
    And I click the "Prod environment" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}080-lifecycle-select-environment-3.png"
    And I click the "OK" button

    And I highlight outside the "Save" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}090-lifecycle-save.png"
    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds

  @assign-lifecycle
  Scenario: Assign the lifecycle
    Given I set the following aliases:
      | Projects           | //span[contains(.,'Projects')]                                   |
      | Random Quotes      | //a[@href='#/Spaces-1/projects/random-quotes']                   |
      | Deployments        | //a[contains(.,'Deployments')]                                   |
      | Process            | //a[contains(.,'Process')][not(*)] \| //a//div[text()='Process'] |
      | Change             | //button[contains(.,'CHANGE')]                                   |
      | Lifecycle list     | //button[../../../../label[text()='Lifecycle']]                  |
      | Save               | //button[contains(.,'Save')]                                     |
      | Dev, Test and Prod | //button[./div/div[text()='Dev, Test and Prod']]                 |

    And I open the URL "http://localhost/app#/Spaces-1/library/lifecycles"
    And I sleep for "10" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I display a note with the text "Assign the custom lifecycle to the Octopus project" for "3" seconds

    And I highlight outside the "Projects" link
    And I click the "Projects" link
    And I sleep for "1" second

    And I highlight inside the "Random Quotes" project tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}095-random-quotes-project.png"
    And I remove the highlight from the "Projects" link
    And I click the "Random Quotes" project tile

    And I highlight inside the "Deployments" link
    And I click the "Deployments" link

    And I highlight inside the "Process" link
    And I click the "Process" link

    And I highlight outside the "Change" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}100-random-quotes-change-lifecycle.png"
    And I remove the highlight from the "Deployments" link
    And I remove the highlight from the "Process" link
    And I remove the highlight from the "Change" button
    And I click the "Change" button

    And I highlight outside the "Lifecycle list" button
    And I highlight outside the "Save" button with an offset of "2"
    And I click the "Lifecycle list" button
    And I click the "Dev, Test and Prod" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}105-random-quotes-select-lifecycle.png"
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
      | Task Log       | //button[contains(.,'Task Log')]                    |

    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/deployments/process"
    And I sleep for "10" seconds

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Deploy to the Test environment, skipping Dev" for "3" seconds

    And I click the "Create Release" button
    And I highlight inside the "Create Release" button
    And I highlight outside the "Save" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}110-random-quotes-create-release.png"
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
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}115-random-quotes-select-test.png"
    And I click the "Test" option

    And I sleep for "3" second
    And I highlight outside the "Deploy" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}120-random-quotes-deploy-test.png"
    And I click the "Deploy" button

    And I sleep for "10" seconds
    And I save a screenshot to "#{ExternalMediaPath}/octopus/lifecycle/#{GuideSpecificScreenshotDir}125-random-quotes-deployed-test.png"

    And I force click the "Task Log" button
    And I sleep for "10" seconds

    And I stop recording the screen
    And I sleep for "60" seconds

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I close the browser