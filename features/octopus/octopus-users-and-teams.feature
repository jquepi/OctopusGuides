Feature: Create Octopus Users and Teams

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@name='userName']       |
      | Password | //input[@name='password']       |
      | Sign In  | //button[contains(.,'SIGN IN')] |
    And I open the shared browser "FirefoxNoImplicitWait"
    #And I maximize the window
    And I set the window size to "1024" x "768"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Add users and teams" for "3" seconds
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

  @add-users
  Scenario: Configure SMTP
    Given I set the following aliases:
      | More             | //span[contains(.,'More')]               |
      | More Two         | (//span[contains(.,'More')])[2]          |
      | Configuration    | //span[contains(.,'Configuration')]      |
      | Users            | //span[contains(.,'Users')]              |
      | Add user         | //button[contains(.,'Add user')]         |
      | Username         | //input[contains(@id,'Username')]        |
      | Display name     | //input[contains(@id,'Displayname')]     |
      | Email address    | //input[contains(@id,'Emailaddress')]    |
      | Password         | //input[contains(@id,'Password')]        |
      | Confirm password | //input[contains(@id,'Confirmpassword')] |
      | Save             | //button[contains(.,'Save')]             |

    And I highlight outside the "More" link
    And I click the "More" link
    And I highlight inside the "Configuration" link
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\permissions\005-octopus-configuration.png"
    And I click the "Configuration" link
    And I remove the highlight from the "More" link
    And I sleep for "1" second

    And I highlight inside the "More Two" link
    And I click the "More Two" link
    And I highlight inside the "Users" link
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\permissions\010-octopus-users.png"
    And I click the "Users" link
    And I sleep for "1" second

    And I highlight outside the "Add user" button
    And I save a screenshot to "C:\screenshots\octopus\permissions\015-octopus-add-user.png"
    And I click the "Add user" button

    And I scroll the "Username" text box into view offset by "-200"
    And I highlight outside the "Username" text box with an offset of "5"
    And I clear the "Username" text box
    And I populate the "Username" text box with "internaldeployer"
    And I save a screenshot to "C:\screenshots\octopus\permissions\020-octopus-username.png"
    And I remove the highlight from the "Username" text box

    And I scroll the "Display name" text box into view offset by "-200"
    And I highlight outside the "Display name" text box with an offset of "5"
    And I clear the "Display name" text box
    And I populate the "Display name" text box with "Internal Deployer"
    And I save a screenshot to "C:\screenshots\octopus\permissions\025-octopus-displayname.png"
    And I remove the highlight from the "Display name" text box

    And I scroll the "Email address" text box into view offset by "-200"
    And I highlight outside the "Email address" text box with an offset of "5"
    And I clear the "Email address" text box
    And I populate the "Email address" text box with "internaldeployer@example.org"
    And I save a screenshot to "C:\screenshots\octopus\permissions\030-octopus-email.png"
    And I remove the highlight from the "Email address" text box

    And I scroll the "Password" text box into view offset by "-200"
    And I highlight outside the "Password" text box with an offset of "2"
    And I clear the "Password" text box
    And I populate the "Password" text box with "Password01!"
    And I scroll the "Confirm password" text box into view offset by "-200"
    And I highlight outside the "Confirm password" text box with an offset of "2"
    And I clear the "Confirm password" text box
    And I populate the "Confirm password" text box with "Password01!"
    And I highlight outside the "Save" button with an offset of "5"
    And I save a screenshot to "C:\screenshots\octopus\permissions\035-octopus-password.png"

    And I click the "Save" button
    And I sleep for "2" seconds

    And I highlight inside the "More Two" link
    And I click the "More Two" link
    And I highlight inside the "Users" link
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\permissions\040-octopus-users.png"
    And I click the "Users" link
    And I sleep for "1" second

    And I highlight outside the "Add user" button
    And I save a screenshot to "C:\screenshots\octopus\permissions\045-octopus-add-user.png"
    And I click the "Add user" button

    And I scroll the "Username" text box into view offset by "-200"
    And I highlight outside the "Username" text box with an offset of "5"
    And I clear the "Username" text box
    And I populate the "Username" text box with "productiondeployer"
    And I save a screenshot to "C:\screenshots\octopus\permissions\050-octopus-username.png"
    And I remove the highlight from the "Username" text box

    And I scroll the "Display name" text box into view offset by "-200"
    And I highlight outside the "Display name" text box with an offset of "5"
    And I clear the "Display name" text box
    And I populate the "Display name" text box with "Production Deployer"
    And I save a screenshot to "C:\screenshots\octopus\permissions\055-octopus-displayname.png"
    And I remove the highlight from the "Display name" text box

    And I scroll the "Email address" text box into view offset by "-200"
    And I highlight outside the "Email address" text box with an offset of "5"
    And I clear the "Email address" text box
    And I populate the "Email address" text box with "productiondeployer@example.org"
    And I save a screenshot to "C:\screenshots\octopus\permissions\060-octopus-email.png"
    And I remove the highlight from the "Email address" text box

    And I scroll the "Password" text box into view offset by "-200"
    And I highlight outside the "Password" text box with an offset of "2"
    And I clear the "Password" text box
    And I populate the "Password" text box with "Password01!"
    And I scroll the "Confirm password" text box into view offset by "-200"
    And I highlight outside the "Confirm password" text box with an offset of "2"
    And I clear the "Confirm password" text box
    And I populate the "Confirm password" text box with "Password01!"
    And I highlight outside the "Save" button with an offset of "5"
    And I save a screenshot to "C:\screenshots\octopus\permissions\065-octopus-password.png"

    And I click the "Save" button
    And I sleep for "2" seconds