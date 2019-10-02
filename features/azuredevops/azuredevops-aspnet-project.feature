Feature: Build and deploy a ASP.NET application hosted in Git on a local Octopus instance

  @login
  Scenario: Log into Azure Devops
    And I open the shared browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    #And I set the window size to "1024" x "768"
    When I open the URL "http://localhost:9090/"

  @install-extensions
  Scenario: Install Extensions
    Given I set the following aliases:
      | Admin settings        | //a[@href='/DefaultCollection/_settings/']                                    |
      | Extensions            | //a[@href='/DefaultCollection/_settings/extensions']                          |
      | Browse Marketplace    | //a[contains(.,'Browse Marketplace')]                                         |
      | Search                | //input[@aria-label='Search Azure DevOps extensions']                         |
      | Search button         | //span[@title='search']                                                       |
      | Octopus tile          | //a[@href='/items?itemName=octopusdeploy.octopus-deploy-build-release-tasks'] |
      | Get it free           | //button[text()='Get it free']                                                |
      | Install               | //button[contains(.,'Install')]                                               |
      | Proceed to collection | //a[@href='/DefaultCollection/']                                              |

    And I click the "Admin settings" button
    And I sleep for "2" seconds
    And I click the "Extensions" button
    And I mouse over the "Browse Marketplace" button
    And I open the URL "https://marketplace.visualstudio.com/search?target=AzureDevOps&category=All%20categories&hosting=onpremises&sortBy=Relevance"
    And I populate the "Search" text box with "Octopus Deploy"
    And I click the "Search button" element
    And I mouse over the "Octopus tile" element
    And I open the URL "https://marketplace.visualstudio.com/items?itemName=octopusdeploy.octopus-deploy-build-release-tasks"
    And I mouse over the "Get it free" button
    And I open the URL "http://localhost:9090/_gallery/acquisition?itemName=octopusdeploy.octopus-deploy-build-release-tasks"
    And I click the "Install" button
    And I click the "Proceed to collection" button
    And I sleep for "1" second

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
    And I sleep for "20" seconds

  @skip-new-features
  Scenario: Create project
    Given I set the following aliases:
      | Close | //button[contains(@class,'bolt-teaching-pane-close-button')] |

    And I open the URL "http://localhost:9090/DefaultCollection/Random%20Quotes/"
    And I click the "Close" button
    And I sleep for "1" second

  @create-project
  Scenario: Create project
    Given I set the following aliases:
      | Pipelines              | //div[@role='menuitem'][./a[@href='/DefaultCollection/Random%20Quotes/_build']] |
      | Build                  | //a[@name='Builds']                                                             |
      | New pipeline           | //button[contains(., 'New pipeline')]                                           |
      | External Git Container | //div[./label//div[contains(., 'External Git')]]                                |
      | External Git           | //input[../div[contains(., 'External Git')]]                                    |
      | Add connection         | //button[contains(.,'Add connection')]                                          |
      | Connection name        | //input[@id='INPUT-FIELD-STRING0']                                              |
      | Git repository URL     | //input[@id='INPUT-FIELD-STRING1']                                              |
      | OK                     | //button[contains(., 'OK')]                                                     |
      | Continue               | //button[contains(.,'Continue')]                                                |
      | ASP.NET Row            | //div[./div/div/div/div[text()='Build and test an ASP.NET web application.']]   |
      | ASP.NET                | //button[./div/span[text()='Apply ASP.NET template']]                           |

    And I open the URL "http://localhost:9090/DefaultCollection/Random%20Quotes/"
    And I mouse over the "Pipelines" menu item
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\020-build.png"
    And I click the "Build" link

    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\030-new-pipeline.png"
    And I click the "New pipeline" button

    And I click the "External Git Container" element
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\040-external-git.png"
    And I click the "Add connection" button

    And I clear the "Connection name" text box
    And I populate the "Connection name" text box with "Random Quotes GitHub"
    And I clear the "Git repository URL" text box
    And I populate the "Git repository URL" text box with "https://github.com/OctopusSamples/RandomQuotes-aspmvc4.git"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\050-git-details.png"
    And I click the "OK" button

    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\060-continue.png"
    And I click the "Continue" button

    And I mouse over the "ASP.NET Row" element
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\070-aspnet.png"
    And I click the "ASP.NET" button

    And I sleep for "1" seconds

  @configure-project
  Scenario: Configure project
    Given I set the following aliases:
      | Agent pool                 | //button[../input[@aria-label='Agent pool']]                                               |
      | Default                    | //button[@aria-label='Default']                                                            |
      | Save and queue             | //button[@name='Save & queue']                                                             |
      | Save and queue two         | (//button[@name='Save & queue'])[2]                                                        |
      | Save and queue three       | //button[@aria-label='Save & queue']                                                       |
      | Comment                    | //textarea[../../../../../../../../div//label[contains(.,'Save')]]                         |
      | Build link                 | //a[contains(@class, 'ci-queued-build-link')]                                              |
      | Publish artifact           | //div[@data-list-index='5'][contains(.,'Publish Artifact')]/div/div/div/div                |
      | Test Assemblies            | //div[@data-list-index='3'][contains(.,'Test Assemblies')]/div/div/div/div                 |
      | Build solution             | //div[@data-list-index='2'][contains(.,'Build solution')]/div/div/div/div                  |
      | Specific location          | //input[../label/span[text()='Specific location']]                                         |
      | Path to vstest.console.exe | //textarea[./../../../../../../../../div/label[text()='Path to vstest.console.exe']]       |
      | MSBuild Arguments          | //textarea[./../../../../../../../../div/label[text()='MSBuild Arguments']]                |
      | Add task                   | //button[@aria-label='Add a task to Agent job 1']                                          |
      | Search                     | (//input[@aria-label='Search'])[2]                                                         |
      | Push package title         | //div[text()='Push Package(s) to Octopus']                                                 |
      | Push package               | //div[./div/div/div[text()='Push Package(s) to Octopus']]/button                           |
      | Push Packages to Octopus   | //div[@data-list-index='6'][contains(.,'Push Packages to Octopus')]/div/div/div/div        |
      | New                        | //div[./span[text()='Add Octopus Deploy Server']]                                          |
      | Connection name            | //input[@id='connectionName']                                                              |
      | Server URL                 | //input[@id='url']                                                                         |
      | API Key                    | //input[@id='apitoken']                                                                    |
      | OK                         | //button[@id='ok']                                                                         |
      | Space                      | //div[@aria-label='Expand'][../../../../../../../../../div/div/label[contains(.,'Space')]] |
      | Default Space              | //li[text()='Default']                                                                     |
      | Package                    | //textarea[../../../../../../div/label[contains(.,'Package')]]                             |

    And I click the "Agent pool" drop down list
    And I click the "Default" option
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\080-default-agent-pool.png"

    And I click the "Build solution" row
    And I scroll the "MSBuild Arguments" text box into view offset by "200"
    And I clear the "MSBuild Arguments" text box
    And I populate the "MSBuild Arguments" text box with "/p:RunOctoPack=true /p:OctoPackPackageVersion=1.0.$(Build.BuildId) /p:OctoPackEnforceAddingFiles=true"

    And I click the "Test Assemblies" row
    And I scroll the "Specific location" option into view offset by "200"
    And I force click the "Specific location" option
    And I populate the "Path to vstest.console.exe" text box with "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe"

    And I click the "Publish artifact" row
    And I click the "Add task" button
    And I populate the "Search" text box with "Octopus Push"
    And I mouse over the "Push package title" element
    And I click the "Push package" button
    And I click the "Push Packages to Octopus" row
    And I click the "New" button
    And I populate the "Connection name" text box with "Octopus"
    And I populate the "Server URL" text box with "http://localhost"
    And I populate the "API Key" text box with "ExternalOctopusAPIKey"
    And I click the "OK" button

    And I click the "Space" drop down list
    And I click the "Default Space" option
    And I populate the "Package" text box with "RandomQuotes\obj\octopacked\RandomQuotes.1.0.$(Build.BuildId).nupkg"

    And I click the "Save and queue" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\090-save-and-queue.png"
    And I click the "Save and queue two" button

    And I populate the "Comment" text box with "Initial build"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\100-initial-build.png"
    And I click the "Save and queue three" button
    And I sleep for "3" seconds

    And I click the "Build link" element
    And I sleep for "3" seconds
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\110-build-results.png"

  Scenario: Shutdown
    #Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser