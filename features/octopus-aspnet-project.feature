Feature: Configure an Octopus ASP.NET project

  Scenario: Login
    Given I set the following aliases:
      | Username    | //input[@name='userName']            |
      | Password    | //input[@name='password']            |
      | Sign In     | //span[contains(.,'SIGN IN')]        |
      | Hide wizard | //em[contains(@class,'fa fa-minus')] |
    And I open the shared browser "FirefoxNoImplicitWait"
    And I maximize the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

  @hide-wizard
  Scenario: Hide wizard
    And I click the "Hide wizard" button

  @create-project
  Scenario: Create Project
    Given I set the following aliases:
      | Projects         | //span[contains(.,'Projects')]           |
      | Add project      | (//div[contains(.,'Add Project')])[11]   |
      | New project name | //input[contains(@id, 'Newprojectname')] |
      | Save             | (//div[contains(.,'Save')])[9]           |
    And I click the "Projects" link
    And I click the "Add project" button
    And I populate the "New project name" text box with "Random Quotes"
    And I click the "Save" button
    And I sleep for "2" seconds

  @define-project
  Scenario: Define project
    Given I set the following aliases:
      | Define your deployment process  | //span[contains(.,'Define your deployment process')]                                                |
      | Add Step                        | //span[contains(.,'Add Step')]                                                                      |
      | Search                          | //input[@type='search']                                                                             |
      | Deploy to IIS                   | //div[contains(@class, 'add-step-card') and contains(.,'Deploy to IIS')]                            |
      | Add                             | //div[contains(@class, 'add-step-card') and contains(.,'Deploy to IIS')]//button[contains(.,'Add')] |
      | Step Name                       | //input[contains(@id, 'Stepname')]                                                                  |
      | Runs on targets in roles        | //input[@title='Runs on targets in roles (type to add new)']                                        |
      | Web role                        | //div[contains(@class, 'VirtualListWithKeyboard_menuContainer')]//span[contains(.,'web')]//span     |
      | Package ID                      | //input[contains(@id, 'PackageID')]                                                                 |
      | Web site name                   | //input[contains(@id, 'Websitename')]                                                               |
      | Enable Anonymous authentication | //input[@type='checkbox'][../div[contains(.,'Enable Anonymous authentication')]]                    |
      | Enable Windows authentication   | //input[@type='checkbox'][../div[contains(.,'Enable Windows authentication')]]                      |
      | Application Pool name           | //input[contains(@id, 'ApplicationPoolname')]                                                       |
      | Remove binding                  | (//div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M19 6.41L17.59')]])[2]       |
      | HTML Body                       | /html/body                                                                                          |
      | Add binding                     | (//span[contains(.,'Add')])[1]                                                                      |
      | Port                            | //input[contains(@id, 'Port')]                                                                      |
      | OK                              | //span[contains(.,'Ok')]                                                                            |
      | Save                            | (//div[contains(.,'Save')])[20]                                                                     |
    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/overview"
    And I click the "Define your deployment process" button
    And I click the "Add Step" button

    And I populate the "Search" text box with "iis"
    And I sleep for "2" seconds
    And I scroll the "Deploy to IIS" tile into view offset by "-300"
    And I mouse over the "Deploy to IIS" tile
    And I click the "Add" button

    And I populate the "Step Name" text box with "Deploy web app to IIS"

    And I scroll the "Runs on targets in roles" text box into view offset by "-300"
    And I click the "Runs on targets in roles" text box
    And I click the "Web role" option

    And I scroll the "Package ID" text box into view offset by "-300"
    And I populate the "Package ID" text box with "RandomQuotes"
    And I click the "HTML Body" element

    And I scroll the "Web site name" text box into view offset by "-300"
    And I populate the "Web site name" text box with "RandomQuotes"

    And I scroll the "Application Pool name" text box into view offset by "-300"
    And I populate the "Application Pool name" text box with "RandomQuotes"

    And I scroll the "Remove binding" button into view offset by "-300"
    And I click the "Remove binding" button

    And I click the "Add binding" button
    And I clear the "Port" text box
    And I populate the "Port" text box with "8081"
    And I click the "OK" button

    And I scroll the "Enable Anonymous authentication" check box into view offset by "-300"
    And I force click the "Enable Anonymous authentication" check box
    And I force click the "Enable Windows authentication" check box

    And I click the "Save" button

  @deploy-project
  Scenario: Deploy project
    Given I set the following aliases:
      | Create Release | //button[contains(.,'Create release')]   |
      | Save           | //button[contains(.,'Save')]             |
      | Deploy To Dev  | //button[contains(.,'Deploy to Dev...')] |
      | Deploy         | //button[contains(.,'Deploy')]           |
    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/overview"
    And I click the "Create Release" button
    And I click the "Save" button
    And I click the "Deploy To Dev" button
    And I click the "Deploy" button
    And I sleep for "30" seconds

  Scenario: Shutdown
    And I close the browser