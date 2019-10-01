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
    When I open the URL "http://localhost:9090/"

  Scenario: Create project
    Given I set the following aliases:
      | Project name | //input[contains(@id,'project-name-textfield')]           |
      | Description  | //textarea[contains(@id,'project-description-textfield')] |

    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\010-create-project.png"
    And I sleep for "5" seconds

  Scenario: Shutdown
    #Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser