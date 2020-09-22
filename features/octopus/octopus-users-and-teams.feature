Feature: Create Octopus Users and Teams

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments

  @add-users
  Scenario: Configure Users
    Given I set the following aliases:
      | More             | (//span[contains(.,'More')])[1]                                           |
      | More Two         | (//span[contains(.,'More')])[2]                                           |
      | Configuration    | //span[contains(.,'Configuration')]                                       |
      | Users            | //span[./div/div/div[text()='Users']] \| //a[contains(.,'Users')][not(*)] |
      | Add user         | //button[contains(.,'Add user')]                                          |
      | Username         | //input[@name='Username']                                                 |
      | Display name     | //input[@name='Display name']                                             |
      | Email address    | //input[@name='Email address']                                            |
      | Password         | //input[@name='Password']                                                 |
      | Confirm password | //input[@name='Confirm password']                                         |
      | Save             | //button[contains(.,'Save')]                                              |
      | Expand All       | //a[text()='EXPAND ALL']                                                  |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Create users for internal and production deployments" for "3" seconds

    And I highlight outside the "More" link if it exists
    And I click the "More" link waiting up to "1" second if it exists
    And I highlight inside the "Configuration" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/005-octopus-configuration.png"
    And I click the "Configuration" link
    And I remove the highlight from the "More" link
    And I sleep for "1" second

    And I highlight inside the "More Two" link waiting up to "1" second if it exists
    And I click the "More Two" link waiting up to "1" second if it exists
    And I highlight inside the "Users" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/010-octopus-users.png"
    And I scroll the "Users" link into view
    And I force click the "Users" link
    And I sleep for "1" second

    And I highlight outside the "Add user" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/015-octopus-add-user.png"
    And I click the "Add user" button

    And I stop recording the screen
    And I sleep for "5" seconds
    # Force click to fix the issue:
    # Element <a class="style_expandLink__1iKhk" href="#"> is not clickable at point (1342,147) because another element <div class="style_container__C3zvD style_title__3dtC6 style_stickied__mFxEA"> obscures it
    And I force click the "Expand All" link if the "Username" text box does not exist
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I scroll the "Username" text box into view offset by "-200"
    And I highlight outside the "Username" text box with an offset of "5"
    And I clear the "Username" text box
    And I populate the "Username" text box with "internaldeployer"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/020-octopus-username.png"
    And I remove the highlight from the "Username" text box

    And I scroll the "Display name" text box into view offset by "-200"
    And I highlight outside the "Display name" text box with an offset of "5"
    And I clear the "Display name" text box
    And I populate the "Display name" text box with "Internal Deployer"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/025-octopus-displayname.png"
    And I remove the highlight from the "Display name" text box

    And I scroll the "Email address" text box into view offset by "-200"
    And I highlight outside the "Email address" text box with an offset of "5"
    And I clear the "Email address" text box
    And I populate the "Email address" text box with "internaldeployer@example.org"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/030-octopus-email.png"
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
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/035-octopus-password.png"

    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/037-octopus-user-overview.png"

    # Click the Users link in the breadcrumb
    And I highlight inside the "Users" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/040-octopus-users.png"
    And I scroll the "Users" link into view
    And I force click the "Users" link
    And I sleep for "1" second

    And I highlight outside the "Add user" buttonl
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/045-octopus-add-user.png"
    And I click the "Add user" button

    And I stop recording the screen
    And I sleep for "5" seconds
    # Force click to fix the issue:
    # Element <a class="style_expandLink__1iKhk" href="#"> is not clickable at point (1342,147) because another element <div class="style_container__C3zvD style_title__3dtC6 style_stickied__mFxEA"> obscures it
    And I force click the "Expand All" link if the "Username" text box does not exist
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I scroll the "Username" text box into view offset by "-200"
    And I highlight outside the "Username" text box with an offset of "5"
    And I clear the "Username" text box
    And I populate the "Username" text box with "productiondeployer"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/050-octopus-username.png"
    And I remove the highlight from the "Username" text box

    And I scroll the "Display name" text box into view offset by "-200"
    And I highlight outside the "Display name" text box with an offset of "5"
    And I clear the "Display name" text box
    And I populate the "Display name" text box with "Production Deployer"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/055-octopus-displayname.png"
    And I remove the highlight from the "Display name" text box

    And I scroll the "Email address" text box into view offset by "-200"
    And I highlight outside the "Email address" text box with an offset of "5"
    And I clear the "Email address" text box
    And I populate the "Email address" text box with "productiondeployer@example.org"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/060-octopus-email.png"
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
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/065-octopus-password.png"

    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/067-octopus-user-overview.png"

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  @add-internal-team
  Scenario: Configure Teams
    Given I set the following aliases:
      | More                           | (//span[contains(.,'More')])[1]                                 |
      | More Two                       | (//span[contains(.,'More')])[2]                                 |
      | Configuration                  | //span[contains(.,'Configuration')]                             |
      | Teams                          | //span[contains(.,'Teams')] \| //a[contains(.,'Teams')][not(*)] |
      | Add Team                       | //button[contains(.,'Add Team')]                                |
      | New team name                  | //input[@name='New team name']                                  |
      | New team description           | //textarea[@name='Team description']                            |
      | New team description container | //div[./textarea[@name='Team description']]                     |
      | Save                           | //button[@title='Save']                                         |
      | Add Member                     | //button[@title='Add Member']                                   |
      | Select users                   | //input[@title='Select users']                                  |
      | Select users container         | //div[./div/div/div/input[@title='Select users']]               |
      | Add                            | //button[@title='Add']                                          |
      | Internal Deployer User         | //div[./div/span[text()='internaldeployer@example.org']]        |
      | User roles                     | //button[contains(.,'User Roles')]                              |
      | Include User Role              | //button[contains(.,'Include User Role')]                       |
      | Select user role               | (//div[../div[text()='Select a user role']])[2]                 |
      | Select user role container     | //div[./div/div[../div[text()='Select a user role']]]           |
      | Deployment creator             | //span[./div[contains(.,'Deployment creator')]]                 |
      | Project viewer                 | //span[./div[contains(.,'Project viewer')]]                     |
      | Apply                          | //button[contains(.,'Apply')]                                   |
      | Define Scope                   | //button[contains(.,'Define Scope')]                            |
      | Select environments            | //input[@title='Select environments']                           |
      | Dev environment                | //span[./div/div/div[text()='Dev']]                             |
      | Test environment               | //span[./div/div/div[text()='Test']]                            |

    And I open the URL "http://localhost"
    And I clear the transition
    And I display a note with the text "Create the internal deployment team" for "3" seconds

    And I highlight outside the "More" link if it exists
    And I click the "More" link waiting up to "1" second if it exists
    And I highlight inside the "Configuration" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/070-octopus-configuration.png"
    And I click the "Configuration" link
    And I remove the highlight from the "More" link
    And I sleep for "1" second

    And I highlight inside the "More Two" link waiting up to "1" second if it exists
    And I click the "More Two" link waiting up to "1" second if it exists
    And I highlight inside the "Teams" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/075-octopus-teams.png"
    And I scroll the "Teams" link into view
    And I force click the "Teams" link
    And I sleep for "1" second

    And I highlight outside the "Add Team" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/080-octopus-add-team.png"
    And I click the "Add Team" button

    And I highlight outside the "New team name" text box with an offset of "0"
    And I highlight outside the "New team description container" text box with an offset of "0"
    And I highlight outside the "Save" button with an offset of "2"
    And I populate the "New team name" text box with "Internal Deployers"
    And I populate the "New team description" text box with "Grants access to perform a deployment to the internal environments"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/085-octopus-new-team.png"
    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Add Member" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/090-octopus-add-member.png"
    And I remove the highlight from the "Add Member" button
    And I click the "Add Member" button

    And I highlight outside the "Select users container" element with an offset of "5"
    And I highlight outside the "Add" button with an offset of "2"
    And I click the "Select users" drop down list
    And I click the "Internal Deployer User" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/095-octopus-add-internal-user.png"
    And I click the "Add" button

    # Force click to fix:
    # element click intercepted: Element <button class="MuiButtonBase-root MuiTab-root MuiTab-textColorInherit jss178" tabindex="0" type="button" role="tab" aria-selected="false">...</button> is not clickable at point (624, 303). Other element would receive the click: <div class="MuiDialog-container MuiDialog-scrollPaper" role="document" tabindex="-1" style="opacity: 0; transition: opacity 195ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;">...</div>
    And I force click the "User roles" tab
    And I highlight the "Include User Role" button
    And I highlight inside the "User roles" tab
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/100-octopus-user-roles.png"
    And I remove the highlight from the "User roles" tab
    And I remove the highlight from the "Include User Role" button
    And I click the "Include User Role" button

    And I click the "Select user role" drop down list
    And I click the "Deployment creator" option
    And I highlight outside the "Select user role container" element with an offset of "2"
    And I highlight outside the "Define Scope" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/105-octopus-add-role.png"

    And I click the "Define Scope" button
    And I click the "Select environments" drop down list
    And I click the "Dev environment" option
    # Force click to fix:
    # org.openqa.selenium.ElementClickInterceptedException: element click intercepted: Element <input type="text" autocomplete="off" name="name9" title="Select environments" id="MultiSelect-40330" value="" style="padding: 0px; position: relative; width: 100%; border: none; outline: none; background-color: rgba(0, 0, 0, 0); color: rgb(51, 51, 51); cursor: inherit; font: inherit; opacity: 1; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); height: 100%; margin-top: 0px; text-overflow: ellipsis; overflow: hidden;">
    # is not clickable at point (960, 745). Other element would receive the click: <div role="presentation" style="position: fixed; z-index: 1300; right: 0px; bottom: 0px; top: 0px; left: 0px;">...</div>
    And I force click the "Select environments" drop down list
    And I click the "Test environment" option
    And I highlight outside the "Apply" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/110-octopus-role-scope.png"
    And I click the "Apply" button

    And I highlight the "Include User Role" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/115-octopus-user-roles.png"
    And I remove the highlight from the "Include User Role" button
    And I click the "Include User Role" button

    And I click the "Select user role" drop down list
    # force click to fix:
    # org.openqa.selenium.ElementClickInterceptedException: element click intercepted: Element <span role="menuitem" tabindex="0" style="border: 10px; box-sizing: border-box; display: block; font-family: Roboto, sans-serif; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); cursor: pointer; text-decoration: none; margin: 0px; padding: 0px; outline: none; font-size: 15px; font-weight: inherit; position: relative; color: rgb(51, 51, 51); line-height: 32px; transition: all 450ms cubic-bezier(0.23, 1, 0.32, 1) 0ms; min-height: 32px; white-space: nowrap; background: none;">...</span> is not clickable at point (947, 790). Other element would receive the click: <div>...</div>
    And I force click the "Project viewer" option
    And I highlight outside the "Select user role container" element with an offset of "2"
    And I highlight outside the "Apply" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/120-octopus-add-role.png"
    And I click the "Apply" button

    And I click the "Save" button
    And I sleep for "2" second

    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/123-octopus-team-roles.png"

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  @add-production-team
  Scenario: Configure Teams
    Given I set the following aliases:
      | More                           | //span[contains(.,'More')][1]                                   |
      | More Two                       | (//span[contains(.,'More')])[2]                                 |
      | Configuration                  | //span[contains(.,'Configuration')]                             |
      | Teams                          | //span[contains(.,'Teams')] \| //a[contains(.,'Teams')][not(*)] |
      | Add Team                       | //button[contains(.,'Add Team')]                                |
      | New team name                  | //input[@name='New team name']                                  |
      | New team description           | //textarea[@name='Team description']                            |
      | New team description container | //div[./textarea[@name='Team description']]                     |
      | Save                           | //button[@title='Save']                                         |
      | Add Member                     | //button[@title='Add Member']                                   |
      | Select users                   | //input[@title='Select users']                                  |
      | Select users container         | //div[./div/div/div/input[@title='Select users']]               |
      | Add                            | //button[@title='Add']                                          |
      | Production Deployer User       | //div[./div/span[text()='productiondeployer@example.org']]      |
      | User roles                     | //button[contains(.,'User Roles')]                              |
      | Include User Role              | //button[contains(.,'Include User Role')]                       |
      | Select user role               | (//div[../div[text()='Select a user role']])[2]                 |
      | Select user role container     | //div[./div/div[../div[text()='Select a user role']]]           |
      | Deployment creator             | //span[./div[contains(.,'Deployment creator')]]                 |
      | Project viewer                 | //span[./div[contains(.,'Project viewer')]]                     |
      | Apply                          | //button[contains(.,'Apply')]                                   |
      | Define Scope                   | //button[contains(.,'Define Scope')]                            |
      | Select environments            | //input[@title='Select environments']                           |
      | Prod environment               | //span[./div/div/div[text()='Prod']]                            |

    And I open the URL "http://localhost"
    And I clear the transition
    And I display a note with the text "Create the production deployment team" for "3" seconds

    And I highlight outside the "More" link if it exists
    And I click the "More" link waiting up to "1" second if it exists
    And I highlight inside the "Configuration" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/125-octopus-configuration.png"
    And I click the "Configuration" link
    And I remove the highlight from the "More" link
    And I sleep for "1" second

    And I highlight inside the "More Two" link if it exists
    And I click the "More Two" link waiting up to "1" seconds if it exists
    And I highlight inside the "Teams" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/130-octopus-teams.png"
    And I click the "Teams" link
    And I sleep for "1" second

    And I highlight outside the "Add Team" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/135-octopus-add-team.png"
    And I click the "Add Team" button

    And I highlight outside the "New team name" text box with an offset of "0"
    And I highlight outside the "New team description container" text box with an offset of "0"
    And I highlight outside the "Save" button with an offset of "2"
    And I populate the "New team name" text box with "Production Deployers"
    And I populate the "New team description" text box with "Grants access to perform a deployment to the production environment"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/140-octopus-new-team.png"
    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Add Member" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/145-octopus-add-member.png"
    And I remove the highlight from the "Add Member" button
    And I click the "Add Member" button

    And I highlight outside the "Select users container" element with an offset of "5"
    And I highlight outside the "Add" button with an offset of "2"
    And I click the "Select users" drop down list
    And I click the "Production Deployer User" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/150-octopus-add-internal-user.png"
    And I click the "Add" button

    # Force click to fix:
    # element click intercepted: Element <button class="MuiButtonBase-root MuiTab-root MuiTab-textColorInherit jss178" tabindex="0" type="button" role="tab" aria-selected="false">...</button> is not clickable at point (624, 303). Other element would receive the click: <div class="MuiDialog-container MuiDialog-scrollPaper" role="document" tabindex="-1" style="opacity: 0; transition: opacity 195ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;">...</div>
    And I force click the "User roles" tab
    And I highlight the "Include User Role" button
    And I highlight inside the "User roles" tab
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/155-octopus-user-roles.png"
    And I remove the highlight from the "User roles" tab
    And I remove the highlight from the "Include User Role" button
    And I click the "Include User Role" button

    And I click the "Select user role" drop down list
    And I click the "Deployment creator" option
    And I highlight outside the "Select user role container" element with an offset of "2"
    And I highlight outside the "Define Scope" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/160-octopus-add-role.png"

    And I click the "Define Scope" button
    And I click the "Select environments" drop down list
    And I click the "Prod environment" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/165-octopus-role-scope.png"
    And I click the "Apply" button

    And I highlight the "Include User Role" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/170-octopus-user-roles.png"
    And I remove the highlight from the "Include User Role" button
    And I click the "Include User Role" button

    And I click the "Select user role" drop down list
    # force click to fix:
    # org.openqa.selenium.ElementClickInterceptedException: element click intercepted: Element <span role="menuitem" tabindex="0" style="border: 10px; box-sizing: border-box; display: block; font-family: Roboto, sans-serif; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); cursor: pointer; text-decoration: none; margin: 0px; padding: 0px; outline: none; font-size: 15px; font-weight: inherit; position: relative; color: rgb(51, 51, 51); line-height: 32px; transition: all 450ms cubic-bezier(0.23, 1, 0.32, 1) 0ms; min-height: 32px; white-space: nowrap; background: none;">...</span> is not clickable at point (947, 790). Other element would receive the click: <div>...</div>
    And I force click the "Project viewer" option
    And I highlight outside the "Select user role container" element with an offset of "2"
    And I highlight outside the "Apply" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/175-octopus-add-role.png"
    And I click the "Apply" button

    And I click the "Save" button
    And I sleep for "2" second

    And I save a screenshot to "#{ExternalMediaPath}/octopus/permissions/178-octopus-team-roles.png"

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  Scenario: Shutdown
    And I stop recording the screen
    And I close the browser