Feature: Add a manual intervention step

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments

  @configure-smtp
  Scenario: Configure SMTP
    Given I set the following aliases:
      | More                 | //span[contains(.,'More')]                                    |
      | More Two             | (//span[contains(.,'More')])[2]                               |
      | Configuration        | //span[contains(.,'Configuration')]                           |
      | SMTP                 | //span[contains(.,'SMTP')] \| //a[contains(.,'SMTP')][not(*)] |
      | SMTP Host Section    | //span[contains(.,'SMTP Host')]                               |
      | SMTP Port Section    | //span[contains(.,'SMTP Port')]                               |
      | SMTP SSL Section     | //span[contains(.,'Use SSL/TLS')]                             |
      | From Address Section | //span[contains(.,'From Address')]                            |
      | Credentials Section  | //span[contains(.,'Credentials')]                             |
      | SMTP Host            | //input[contains(@id,'SMTPhost')]                             |
      | SMTP Port            | //input[contains(@id,'SMTPport')]                             |
      | From Address         | //input[contains(@id,'Fromaddress')]                          |
      | SMTP login           | //input[contains(@id,'SMTPlogin')]                            |
      | SMTP password        | //input[contains(@id,'SMTPpassword')]                         |
      | Use SSL              | //input[../div[contains(.,'Use SSL/TLS')]]                    |
      | Save                 | //button[@title='Save']                                       |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Configure SMTP settings" for "3" seconds

    And I highlight outside the "More" link if it exists
    And I click the "More" link waiting up to "1" second if it exists
    And I highlight inside the "Configuration" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}005-octopus-configuration.png"
    And I click the "Configuration" link
    And I remove the highlight from the "More" link
    And I sleep for "1" second

    And I highlight inside the "More Two" link waiting up to "1" second if it exists
    And I click the "More Two" link waiting up to "1" second if it exists
    And I highlight inside the "SMTP" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}010-octopus-smtp.png"
    And I click the "SMTP" link
    And I sleep for "1" second

    And I highlight outside the "Save" button

    And I scroll the "SMTP Host Section" element into view offset by "-200"
    And I click the "SMTP Host Section" element
    And I highlight outside the "SMTP Host" text box with an offset of "5"
    And I clear the "SMTP Host" text box
    And I populate the "SMTP Host" text box with "smtp.gmail.com"

    And I scroll the "SMTP Port Section" element into view offset by "-200"
    And I click the "SMTP Port Section" element
    And I highlight outside the "SMTP Port" text box with an offset of "5"
    And I force clear the "SMTP Port" text box
    And I populate the "SMTP Port" text box with "587"

    And I scroll the "SMTP SSL Section" element into view offset by "-200"
    And I click the "SMTP SSL Section" element
    And I highlight outside the "Use SSL" checkbox with an offset of "5"
    And I force click the "Use SSL" checkbox

    And I scroll the "From Address Section" element into view offset by "-200"
    And I click the "From Address Section" element
    And I highlight outside the "From Address" text box with an offset of "5"
    And I clear the "From Address" text box
    And I populate the "From Address" text box with "octopusguides@gmail.com"

    And I scroll the "Credentials Section" element into view offset by "-200"
    And I click the "Credentials Section" element
    And I highlight outside the "SMTP login" text box with an offset of "5"
    And I highlight outside the "SMTP password" text box with an offset of "5"

    And I scroll the "SMTP login" text box into view offset by "-200"
    And I clear the "SMTP login" text box
    And I populate the "SMTP login" text box with "octopusguides@gmail.com"

    And I scroll the "Credentials Section" element into view offset by "-200"
    And I clear the "SMTP password" text box
    And I populate the "SMTP password" text box with "SMTPPassword"

    And I click the "Save" button
    And I remove the highlight from the "Save" button
    And I sleep for "1" second
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}015-octopus-smtp-populated.png"

  @add-email-notification
  Scenario: Add the notification step
    Given I set the following aliases:
      | Projects                      | //span[contains(.,'Projects')]                                                                      |
      | Random Quotes                 | //a[@href='#/Spaces-1/projects/random-quotes']                                                      |
      | Deployments                   | //a[contains(.,'Deployments')]                                                                      |
      | Process                       | //a[contains(.,'Process')][not(*)] \| //a//div[text()='Process']                                    |
      | Add Step                      | //button[contains(.,'Add Step')]                                                                    |
      | Search                        | //input[contains(@id, 'Filterbynamecategoryordescription')]                                         |
      | Send an Email                 | //div[contains(@class, 'add-step-card') and contains(.,'Send an Email')]                            |
      | Add                           | //div[contains(@class, 'add-step-card') and contains(.,'Send an Email')]//button[contains(.,'Add')] |
      | Step Name                     | //input[contains(@id, 'Stepname')]                                                                  |
      | To                            | //input[contains(@id, 'Separatemultipleemailaddresseswithor')]                                      |
      | To container                  | //div[./input[contains(@id, 'Separatemultipleemailaddresseswithor')]]                               |
      | Subject                       | //input[contains(@id, 'Subject')]                                                                   |
      | Subject container             | //div[./input[contains(@id, 'Subject')]]                                                            |
      | Body                          | //textarea[contains(@id, 'Body')]                                                                   |
      | Body container                | //div[./textarea[contains(@id, 'Body')]]                                                            |
      | Run Condition                 | //span[contains(.,'Run Condition')]                                                                 |
      | Always run                    | //input[@value='Always']                                                                            |
      | Save                          | //button[contains(.,'Save')]                                                                        |
      | Environments                  | //span[contains(.,'Environments')]                                                                  |
      | Skip specific environment     | //input[../div[contains(.,'Skip specific environments')]]                                           |
      | Select environments           | //input[@title='Select environments']                                                               |
      | Select environments container | //div[./div/div/div/div/div/input[@title='Select environments']]                                    |
      | Dev Environment               | //div[contains(@class, 'VirtualListWithKeyboard_menuContainer')]//span[contains(.,'Dev')]//span     |

    And I open the URL "http://localhost/app#"
    And I clear the transition
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I display a note with the text "Add an email notification step" for "3" seconds

    And I highlight outside the "Projects" link
    And I click the "Projects" link
    And I sleep for "1" second

    And I highlight inside the "Random Quotes" project tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}020-random-quotes-project.png"
    And I remove the highlight from the "Projects" link
    And I click the "Random Quotes" project tile

    And I highlight inside the "Deployments" link
    And I click the "Deployments" link
    And I highlight inside the "Process" link
    And I click the "Process" link
    And I highlight outside the "Add Step" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}025-add-step.png"
    And I remove the highlight from the "Deployments" link
    And I remove the highlight from the "Process" link
    And I click the "Add Step" button

    And I highlight outside the "Search" text box with an offset of "3"
    And I populate the "Search" text box with "email"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}030-octopus-search-email.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Send an Email" tile into view offset by "-200"
    And I highlight outside the "Send an Email" tile with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}035-octopus-add-email.png"
    And I mouse over the "Send an Email" tile
    And I force click the "Add" button

    And I scroll the "Step Name" text box into view offset by "-300"
    And I highlight outside the "Step Name" text box with an offset of "5"
    And I populate the "Step Name" text box with "Random quotes deployment status"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}040-octopus-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "To" text box into view offset by "-300"
    And I highlight outside the "To container" element with an offset of "5"
    And I populate the "To" text box with "octopusguides@gmail.com"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}045-octopus-step-to.png"
    And I remove the highlight from the "To container" element

    And I scroll the "Subject" text box into view offset by "-300"
    And I highlight outside the "Subject container" element with an offset of "5"
    And I populate the "Subject" text box with "Random quotes deployment status"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}050-octopus-step-subject.png"
    And I remove the highlight from the "Subject container" element

    And I scroll the "Body" text box into view offset by "-300"
    And I highlight outside the "Body container" element with an offset of "5"
    And I populate the "Body" text box with:
      """
        Deployment to #{Octopus.Environment.Name}
        #{each step in Octopus.Step}
        StepName: #{step}
        Status: #{step.Status.Code}
        #{/each}
      """
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}055-octopus-step-body.png"
    And I remove the highlight from the "Body container" element

    And I scroll the "Run Condition" section into view offset by "-300"
    And I highlight outside the "Run Condition" element
    # There have been cases where clicking the Run Condition label resulted in the section below it being expanded,
    # so we force click to make sure the correct section is opened.
    And I force click the "Run Condition" element
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}057-octopus-step-conditions.png"
    And I remove the highlight from the "Run Condition" element

    And I scroll the "Always run" radio button into view offset by "-300"
    And I highlight inside the "Always run" radio button
    And I force click the "Always run" radio button
    And I sleep for "2" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}058-octopus-step-always-run.png"

    And I scroll the "Environments" section into view offset by "-300"
    And I highlight outside the "Environments" element
    And I click the "Environments" element
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}059-octopus-step-conditions.png"

    And I scroll the "Skip specific environment" radio button into view offset by "-300"
    And I highlight outside the "Skip specific environment" radio button
    And I force click the "Skip specific environment" radio button
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}059-octopus-step-skip-envs.png"
    And I remove the highlight from the "Skip specific environment" radio button

    And I scroll the "Select environments" text box into view offset by "-400"
    And I highlight outside the "Select environments container" element
    And I populate the "Select environments" text box with "Dev"
    And I click the "Dev Environment" option
    And I highlight the "Save" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}059-octopus-step-skip-dev.png"
    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds


  @deploy-to-test
  Scenario: Deploy to the test environment
    Given I set the following aliases:
      | Create Release | //button[contains(.,'Create release')] |
      | Deploy To      | //button[contains(.,'Deploy to...')]   |
      | Test           | //li[text()='Test']                    |
      | Deploy         | //button[contains(.,'Deploy')]         |
      | Save           | //button[contains(.,'Save')]           |

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

    And I sleep for "10" seconds
    And I stop recording the screen

  @approve-deployment
  Scenario: Approve manual intervention
    Given I set the following aliases:
      | Assign to me    | //button[contains(.,'Assign to me')]     |
      | Proceed         | //button[contains(.,'Proceed')]          |
      | Notes           | //textarea[contains(@id,'Notes')]        |
      | Notes container | //div[./textarea[contains(@id,'Notes')]] |
      | Task Log        | //button[contains(.,'Task Log')]         |

    And I verify the "Assign to me" button is present waiting up to "1200" seconds if it exists

    # If the button does not exist, look at the logs
    And I click the "Task Log" button if the "Assign to me" button does not exist
    And I scroll down "10000" px

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Assign to me" button
    And I sleep for "1" second
    And I click the "Assign to me" button
    And I sleep for "1" second

    And I highlight outside the "Notes container" text box with an offset of "2"
    And I highlight outside the "Proceed" button with an offset of "2"
    And I scroll the "Notes" text box into view offset by "-200"
    And I populate the "Notes" text box with "Confirmed this deployment meets all the requirements."
    And I sleep for "1" second
    And I click the "Proceed" button
    And I sleep for "10" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/email/#{GuideSpecificScreenshotDir}060-octopus-deployed.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser