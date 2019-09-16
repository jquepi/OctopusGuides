Feature: Configure an Octopus ASP.NET project

  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@name='userName']     |
      | Password | //input[@name='password']     |
      | Sign In  | //span[contains(.,'SIGN IN')] |
    And I open the shared browser "FirefoxNoImplicitWait"
    And I maximize the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

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

  @define-project
  Scenario: Define project
    Given I set the following aliases:
      | Define your deployment process | //span[contains(.,'Define your deployment process')] |
      | Add Step                       | //span[contains(.,'Add Step')]                       |
      | Search                         | //input[@type='search']                              |
      | Deploy to IIS                  | (//div[contains(.,'Deploy to IIS')])[16]             |
    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/overview"
    And I click the "Define your deployment process" button
    And I click the "Add Step" button

    And I populate the "Search" text box with "iis"
    And I scroll the "Deploy to IIS" tile into view offset by "-300"
    And I mouse over the "Deploy to IIS" tile

    And I wait for "5" seconds

  Scenario: Shutdown
    And I close the browser