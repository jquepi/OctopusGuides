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
    And I display a note with the text "Configure email notifications" for "3" seconds
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

  @configure-smtp
  Scenario: Configure SMTP
    Given I set the following aliases:
      | More                 | //span[contains(.,'More')]                 |
      | More Two             | (//span[contains(.,'More')])[2]            |
      | Configuration        | //span[contains(.,'Configuration')]        |
      | SMTP                 | //span[contains(.,'SMTP')]                 |
      | SMTP Host Section    | //span[contains(.,'SMTP Host')]            |
      | SMTP Port Section    | //span[contains(.,'SMTP Port')]            |
      | SMTP SSL Section     | //span[contains(.,'Use SSL/TLS')]          |
      | From Address Section | //span[contains(.,'From Address')]         |
      | Credentials Section  | //span[contains(.,'Credentials')]          |
      | SMTP Host            | //input[contains(@id,'SMTPhost')]          |
      | SMTP Port            | //input[contains(@id,'SMTPport')]          |
      | From Address         | //input[contains(@id,'Fromaddress')]       |
      | SMTP login           | //input[contains(@id,'SMTPlogin')]         |
      | SMTP password        | //input[contains(@id,'SMTPpassword')]      |
      | Use SSL              | //input[../div[contains(.,'Use SSL/TLS')]] |
      | Save                 | //button[@title='Save']                    |

    And I highlight outside the "More" link
    And I click the "More" link
    And I highlight inside the "Configuration" link
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\email\005-octopus-configuration.png"
    And I click the "Configuration" link
    And I remove the highlight from the "More" link
    And I sleep for "1" second

    And I highlight inside the "More Two" link
    And I click the "More Two" link
    And I highlight inside the "SMTP" link
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\email\010-octopus-smtp.png"
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
    And I clear the "SMTP Port" text box
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
    And I sleep for "5" second
    And I save a screenshot to "C:\screenshots\octopus\email\015-octopus-smtp-populated.png"

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  @add-email-notification
  Scenario: Add the notification step
    Given I set the following aliases:
      | Projects          | //span[contains(.,'Projects')]                                                                      |
      | Random Quotes     | //a[@href='#/Spaces-1/projects/random-quotes']                                                      |
      | Process           | //a[contains(.,'Process')]                                                                          |
      | Process text      | //a/span[contains(.,'Process')] \| //a[contains(.,'Process')][not(*)]                               |
      | Add Step          | //button[contains(.,'Add Step')]                                                                    |
      | Search            | //input[contains(@id, 'Filterbynamecategoryordescription')]                                         |
      | Send an Email     | //div[contains(@class, 'add-step-card') and contains(.,'Send an Email')]                            |
      | Add               | //div[contains(@class, 'add-step-card') and contains(.,'Send an Email')]//button[contains(.,'Add')] |
      | Step Name         | //input[contains(@id, 'Stepname')]                                                                  |
      | To                | //input[contains(@id, 'Separatemultipleemailaddresseswithor')]                                      |
      | To container      | //div[./input[contains(@id, 'Separatemultipleemailaddresseswithor')]]                               |
      | Subject           | //input[contains(@id, 'Subject')]                                                                   |
      | Subject container | //div[./input[contains(@id, 'Subject')]]                                                            |
      | Body              | //textarea[contains(@id, 'Body')]                                                                   |
      | Body container    | //div[./textarea[contains(@id, 'Body')]]                                                            |
      | Save              | //button[contains(.,'Save')]                                                                        |

    And I open the URL "http://localhost/app#"
    And I clear the transition

    And I highlight outside the "Projects" link
    And I click the "Projects" link
    And I sleep for "1" second

    And I highlight inside the "Random Quotes" project tile
    And I save a screenshot to "C:\screenshots\octopus\email\020-random-quotes-project.png"
    And I remove the highlight from the "Projects" link
    And I click the "Random Quotes" project tile

    And I highlight outside the "Process text" link with an offset of "2"
    And I click the "Process" link
    And I highlight outside the "Add Step" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\email\025-add-step.png"
    And I remove the highlight from the "Process text" link
    And I click the "Add Step" button

    And I highlight outside the "Search" text box with an offset of "3"
    And I populate the "Search" text box with "email"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\email\030-octopus-search-email.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Send an Email" tile into view offset by "-200"
    And I highlight outside the "Send an Email" tile with an offset of "5"
    And I save a screenshot to "C:\screenshots\octopus\email\035-octopus-add-email.png"
    And I mouse over the "Send an Email" tile
    And I click the "Add" button

    And I highlight outside the "Step Name" text box with an offset of "5"
    And I populate the "Step Name" text box with "Success Notification"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\email\040-octopus-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "To" text box into view offset by "-300"
    And I highlight outside the "To container" element with an offset of "5"
    And I populate the "To" text box with "octopusguides@gmail.com"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\email\045-octopus-step-to.png"
    And I remove the highlight from the "To container" element

    And I scroll the "Subject" text box into view offset by "-300"
    And I highlight outside the "Subject container" element with an offset of "5"
    And I populate the "Subject" text box with "Random quotes deployment success"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\email\050-octopus-step-subject.png"
    And I remove the highlight from the "Subject container" element

    And I scroll the "Body" text box into view offset by "-300"
    And I highlight outside the "Body container" element with an offset of "5"
    And I populate the "Body" text box with "Random quotes was successfully deployed to #{Octopus.Environment.Name}"
    And I highlight outside the "Save" button
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\email\055-octopus-step-body.png"
    And I remove the highlight from the "Body container" element

    And I click the "Save" button
    And I sleep for "2" seconds

  @deploy-to-test
  Scenario: Deploy to the test environment
    Given I set the following aliases:
      | Create Release | //button[contains(.,'Create release')] |
      | Deploy To      | //button[contains(.,'Deploy to...')]   |
      | Dev            | //span[./div/div/div[text()='Dev']]    |
      | Deploy         | //button[contains(.,'Deploy')]         |
      | Save           | //button[contains(.,'Save')]           |

    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/process"
    And I clear the transition
    And I display a note with the text "Deploy to the Dev environment" for "3" seconds

    And I click the "Create Release" button
    And I highlight outside the "Create Release" button
    And I highlight outside the "Save" button
    And I sleep for "1" second
    And I remove the highlight from the "Create Release" button
    And I click the "Save" button

    And I highlight outside the "Deploy To" button
    And I click the "Deploy To" button
    And I highlight inside the "Dev" option
    And I sleep for "1" second
    And I click the "Dev" option

    And I sleep for "3" second
    And I highlight outside the "Deploy" button
    And I sleep for "1" second
    And I click the "Deploy" button

    And I sleep for "30" seconds
    And I save a screenshot to "C:\screenshots\octopus\email\060-octopus-deployed.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser