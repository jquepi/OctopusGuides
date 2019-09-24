Feature: Configure an Octopus ASP.NET project

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
    And I display a note with the text "Creating the IIS deployment project in Octopus" for "3" seconds
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

  @hide-wizard
  Scenario: Hide wizard
    Given I set the following aliases:
      | Hide wizard | //em[contains(@class,'fa fa-minus')] |
    And I click the "Hide wizard" button

  @create-project
  Scenario: Create Project
    Given I set the following aliases:
      | Projects         | //span[contains(.,'Projects')]           |
      | Add project      | (//div[contains(.,'Add Project')])[11]   |
      | New project name | //input[contains(@id, 'Newprojectname')] |
      | Save             | (//div[contains(.,'Save')])[9]           |
    And I highlight outside the "Projects" link with an offset of "5"
    And I save a screenshot to "C:\screenshots\octopus-projects.png"
    And I click the "Projects" link
    And I sleep for "1" second

    And I highlight outside the "Add project" link with an offset of "1"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-add-project.png"
    And I click the "Add project" button
    And I remove the highlight from the "Add project" link
    And I remove the highlight from the "Projects" link

    And I highlight outside the "New project name" text box with an offset of "2"
    And I highlight outside the "Save" button with an offset of "2"
    And I populate the "New project name" text box with "Random Quotes"
    And I save a screenshot to "C:\screenshots\octopus-new-project-name.png"
    And I click the "Save" button
    And I sleep for "2" seconds

  @define-project
  Scenario: Define project
    Given I set the following aliases:
      | Define your deployment process            | //button[contains(.,'Define your deployment process')]                                              |
      | Add Step                                  | //button[contains(.,'Add Step')]                                                                    |
      | Search                                    | //input[@type='search']                                                                             |
      | Deploy to IIS                             | //div[contains(@class, 'add-step-card') and contains(.,'Deploy to IIS')]                            |
      | Add                                       | //div[contains(@class, 'add-step-card') and contains(.,'Deploy to IIS')]//button[contains(.,'Add')] |
      | Step Name                                 | //input[contains(@id, 'Stepname')]                                                                  |
      | Runs on targets in roles                  | //input[@title='Runs on targets in roles (type to add new)']                                        |
      | Web role                                  | //div[contains(@class, 'VirtualListWithKeyboard_menuContainer')]//span[contains(.,'web')]//span     |
      | Package ID                                | //input[contains(@id, 'PackageID')]                                                                 |
      | Web site name                             | //input[contains(@id, 'Websitename')]                                                               |
      | Enable Anonymous authentication           | //input[@type='checkbox'][../div[contains(.,'Enable Anonymous authentication')]]                    |
      | Enable Anonymous authentication container | //div[./div/div/label[contains(.,'Enable Anonymous authentication')]]                               |
      | Enable Windows authentication             | //input[@type='checkbox'][../div[contains(.,'Enable Windows authentication')]]                      |
      | Enable Windows authentication container   | //div[./div/div/label[contains(.,'Enable Windows authentication')]]                                 |
      | Application Pool name                     | //input[contains(@id, 'ApplicationPoolname')]                                                       |
      | Remove binding                            | (//div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M19 6.41L17.59')]])[2]       |
      | HTML Body                                 | //body                                                                                              |
      | Add binding                               | //div[contains(@class, 'actionsMenu')][not(contains(@class, 'hidden'))]//button[contains(.,'Add')]  |
      | Port                                      | //input[contains(@id, 'Port')]                                                                      |
      | OK                                        | //button[contains(.,'Ok')]                                                                          |
      | Save                                      | //button[contains(.,'Save')]                                                                        |
      | Process                                   | //a[contains(.,'Process')]                                                                          |
      | Overview                                  | //a[contains(.,'Overview')]                                                                         |
      | Variables                                 | //a[contains(.,'Variables')]                                                                        |
      | Project Variables                         | //a[@href='#/Spaces-1/projects/random-quotes/variables'][contains(.,'Project')]                     |
      | New variable name                         | //input[contains(@id,'Enternewvariable')]                                                           |
      | New variable value                        | //input[contains(@id,'Entervalue')]                                                                 |
      | Define scope                              | //div[@title='Define scope']                                                                        |
      | Select environments                       | //input[@title='Select environments']                                                               |
      | Dev environment                           | //div[./div/div[text() = 'Dev']]                                                                    |
      | Test environment                          | //div[./div/div[text() = 'Test']]                                                                   |
      | Prod environment                          | //div[./div/div[text() = 'Prod']]                                                                   |
      | Add Another Value                         | //button[.//span[text() = 'Add Another Value']]                                                     |
      | Space next buttons                        | //div[.//button[.//span[text() = 'Add Another Value']]]                                             |
      | New variable value 2                      | (//input[contains(@id,'Entervalue')])[2]                                                            |
      | New variable value 3                      | (//input[contains(@id,'Entervalue')])[3]                                                            |

    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/overview"
    And I sleep for "1" second

    And I highlight inside the "Variables" link
    And I click the "Variables" link
    And I highlight inside the "Project Variables" link
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\project\octopus-variables.png"
    And I click the "Project Variables" link
    And I remove the highlight from the "Variables" link
    And I remove the highlight from the "Project Variables" link
    And I sleep for "1" second

    And I populate the "New variable name" text box with "IIS Port"
    And I populate the "New variable value" text box with "8081"
    And I click the "Define scope" field
    And I click the "Select environments" field
    And I click the "Dev environment" option
    And I click the "Space next buttons" element

    And I click the "Add Another Value" button
    And I populate the "New variable value 2" text box with "8082"
    And I click the "Define scope" field
    And I click the "Select environments" field
    And I click the "Test environment" option
    And I click the "Space next buttons" element

    And I click the "Add Another Value" button
    And I populate the "New variable value 3" text box with "8083"
    And I click the "Define scope" field
    And I click the "Select environments" field
    And I click the "Prod environment" option
    And I click the "Space next buttons" element

    And I click the "Save" button
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\project\octopus-variables-populated.png"

    And I highlight inside the "Overview" link
    And I click the "Overview" link
    And I highlight outside the "Define your deployment process" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-define-process.png"
    And I remove the highlight from the "Overview" link
    And I click the "Define your deployment process" button
    And I sleep for "1" second

    And I highlight outside the "Add Step" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-add-step.png"
    And I click the "Add Step" button

    And I highlight outside the "Search" text box with an offset of "3"
    And I populate the "Search" text box with "iis"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-search-iis.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Deploy to IIS" tile into view offset by "-200"
    And I highlight outside the "Deploy to IIS" tile
    And I save a screenshot to "C:\screenshots\octopus-add-iis.png"
    And I mouse over the "Deploy to IIS" tile
    And I click the "Add" button

    And I highlight outside the "Step Name" text box
    And I populate the "Step Name" text box with "Deploy web app to IIS"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "Runs on targets in roles" text box into view offset by "-300"
    And I click the "Runs on targets in roles" text box
    And I populate the "Runs on targets in roles" text box with "web"
    And I sleep for "1" second
    And I highlight outside the "Runs on targets in roles" text box
    And I save a screenshot to "C:\screenshots\octopus-step-role.png"
    And I click the "Web role" option
    And I remove the highlight from the "Runs on targets in roles" text box

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "RandomQuotes"
    And I sleep for "1" second
    And I click the "HTML Body" element
    And I save a screenshot to "C:\screenshots\octopus-step-package.png"
    And I remove the highlight from the "Package ID" text box

    And I scroll the "Web site name" text box into view offset by "-300"
    And I highlight outside the "Web site name" text box
    And I populate the "Web site name" text box with "RandomQuotes"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-step-website-name.png"
    And I remove the highlight from the "Web site name" text box

    And I scroll the "Application Pool name" text box into view offset by "-300"
    And I highlight outside the "Application Pool name" text box
    And I populate the "Application Pool name" text box with "RandomQuotes"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-step-apppool-name.png"
    And I remove the highlight from the "Application Pool name" text box

    And I scroll the "Remove binding" button into view offset by "-300"
    And I highlight outside the "Remove binding" button
    And I save a screenshot to "C:\screenshots\octopus-step-remove-binding.png"
    And I click the "Remove binding" button
    And I sleep for "1" second

    And I highlight outside the "Add binding" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-step-add-binding.png"
    And I force click the "Add binding" button
    And I remove the highlight from the "Add binding" button

    And I highlight outside the "Port" text box
    And I highlight outside the "OK" button with an offset of "2"
    And I clear the "Port" text box
    And I populate the "Port" text box with "8081"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-step-binding-port.png"
    And I click the "OK" button

    And I scroll the "Enable Anonymous authentication" check box into view offset by "-300"
    And I highlight outside the "Enable Anonymous authentication container" element
    And I highlight outside the "Enable Windows authentication container" element
    And I highlight outside the "Save" button with an offset of "2"
    And I force click the "Enable Anonymous authentication" check box
    And I force click the "Enable Windows authentication" check box
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-step-auth.png"
    And I remove the highlight from the "Enable Anonymous authentication container" element
    And I remove the highlight from the "Enable Windows authentication container" element

    And I click the "Save" button
    And I sleep for "2" seconds

    And I click the "Overview" link

  @deploy-project
  Scenario: Deploy project
    Given I set the following aliases:
      | Create Release | //button[@title='Create release']        |
      | Save           | //button[@title='Save']                  |
      | Deploy To Dev  | //button[contains(.,'Deploy to Dev...')] |
      | Deploy         | //button[@title='Deploy']                |
    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/overview"
    And I sleep for "1" second

    And I highlight outside the "Create Release" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-create-release.png"
    And I click the "Create Release" button

    And I highlight outside the "Save" button
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-save-release.png"
    And I click the "Save" button
    And I sleep for "1" second

    And I highlight outside the "Deploy To Dev" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-deploy-to-dev.png"
    And I click the "Deploy To Dev" button

    And I highlight outside the "Deploy" button
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus-deploy.png"
    And I click the "Deploy" button
    And I sleep for "23" seconds

    And I save a screenshot to "C:\screenshots\octopus-deployment.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser