Feature: Build and deploy a ASP.NET application hosted in Git on a local Octopus instance

  @login
  Scenario: Log into Azure Devops
    Given I set the following aliases:
      | Username     | #j_username                                                  |
      | Password     | body > div > div > form > div:nth-child(2) > input           |
      | Sign In      | body > div > div > form > div.submit.formRow > input         |
      | Profile Name | #header > div.login > span > a.model-link.inside.inverse > b |
    And I open the shared browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    #And I set the window size to "1024" x "768"
    When I open the URL "http://localhost:9090/"

  @create-project
  Scenario: Create project
    Given I set the following aliases:
      | Project name   | //input[contains(@id,'project-name-textfield')]           |
      | Description    | //textarea[contains(@id,'project-description-textfield')] |
      | Create project | //button[contains(.,'Create project')]                    |

    And I populate the "Project name" text box with "Random Quotes"
    And I populate the "Description" text box with "Build and test an ASP.NET application, and push it to Octopus"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\010-create-project.png"
    And I click the "Create project" button
    And I sleep for "40" seconds

  @configure-project
  Scenario: Create project
    Given I set the following aliases:
      | Pipelines | //div[@role='menuitem'][./a[@href='/DefaultCollection/Random%20Quotes/_build']] |
      | Build     | //a[@name='Builds']                                                             |

    And I open the URL "http://localhost:9090/DefaultCollection/Random%20Quotes/"
    And I mouse over the "Pipelines" menu item
    #And I click the "Build" link
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\020-build.png"

    And I sleep for "5" seconds

  Scenario: Shutdown
    #Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser