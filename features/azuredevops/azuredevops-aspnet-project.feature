Feature: Build and deploy a ASP.NET application hosted in Git on a local Octopus instance

  @login
  Scenario: Log into Azure DevOps
    And I open the shared browser "FirefoxNoImplicitWaitNoProxy"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    #And I set the window size to "1024" x "768"
    When I open the URL "http://localhost:9090/"
    And I start recording the screen to the directory "C:\screenshots"

  @admin-settings
  Scenario: Install Extensions
    Given I set the following aliases:
      | Admin settings | //a[@href='/DefaultCollection/_settings/'] |

    And I display a note with the text "Installing the Azure DevOps extensions" for "3" seconds
    And I highlight inside the "Admin settings" button
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\010-admin-settings.png"
    And I click the "Admin settings" button
    And I sleep for "3" seconds

  @install-extensions
  Scenario: Install extensions
    Given I set the following aliases:
      | Extensions | //a[@href='/DefaultCollection/_settings/extensions'] |

    And I save a screenshot to "c:\screenshots\azuredevops\extensions\debug1.png"
    And I highlight inside the "Extensions" button
    And I mouse over the "Extensions" button
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\015-extensions.png"
    And I open the URL "http://localhost:9090/DefaultCollection/_settings/extensions?tab=Manage&status=active"

  @skip-new-features @install-extensions
  Scenario: Close new features popup
    Given I set the following aliases:
      | Close | //button[contains(@class,'bolt-teaching-pane-close-button')] |
    And I click the "Close" button

  @install-extensions
  Scenario: Continue adding extensions
    Given I set the following aliases:
      | Browse Marketplace    | //a[contains(.,'Browse Marketplace')]                                         |
      | Search                | //input[@aria-label='Search Azure DevOps extensions']                         |
      | Search button         | //span[@title='search']                                                       |
      | Octopus tile          | //a[@href='/items?itemName=octopusdeploy.octopus-deploy-build-release-tasks'] |
      | Get it free           | //button[text()='Get it free']                                                |
      | Install               | //button[contains(.,'Install')]                                               |
      | Proceed to collection | //a[@href='/DefaultCollection/']                                              |

    And I highlight outside the "Browse Marketplace" button with an offset of "0"
    And I mouse over the "Browse Marketplace" button
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\020-browse-marketplace.png"
    # Open the marketplace URL directly to avoid it popping up in a new tab
    And I open the URL "https://marketplace.visualstudio.com/search?target=AzureDevOps&category=All%20categories&hosting=onpremises&sortBy=Relevance"

    And I highlight outside the "Search" text box
    And I populate the "Search" text box with "Octopus Deploy"
    And I click the "Search button" element

    And I highlight outside the "Octopus tile" element with an offset of "0"
    And I mouse over the "Octopus tile" element
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\030-octopus-extension-tile.png"
    # Open the URL directly, but make it look like we clicked on the tile
    And I open the URL "https://marketplace.visualstudio.com/items?itemName=octopusdeploy.octopus-deploy-build-release-tasks"

    And I highlight outside the "Get it free" button
    And I mouse over the "Get it free" button
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\040-octopus-extension-getit.png"
    # This is a workaround to the fact that we don't have a public url, so we don't click the button but instead
    # open the internal URL that allows us to add the extension.
    And I open the URL "http://localhost:9090/_gallery/acquisition?itemName=octopusdeploy.octopus-deploy-build-release-tasks&installContext=eyJpdGVtTmFtZSI6Im9jdG9wdXNkZXBsb3kub2N0b3B1cy1kZXBsb3ktYnVpbGQtcmVsZWFzZS10YXNrcyIsIml0ZW1VcmwiOiJodHRwczovL21hcmtldHBsYWNlLnZpc3VhbHN0dWRpby5jb20vaXRlbXM%2FaXRlbU5hbWU9b2N0b3B1c2RlcGxveS5vY3RvcHVzLWRlcGxveS1idWlsZC1yZWxlYXNlLXRhc2tzIiwiY29sbGVjdGlvbklkIjoiOGFmMWNhYzktYjU1Yi00ODY5LWE0ZGItY2UxODEwZTQ1NmY5In0%3D"
    And I sleep for "10" seconds

    And I highlight outside the "Install" button
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\050-octopus-extension-install.png"
    And I click the "Install" button
    And I sleep for "5" seconds

    And I highlight outside the "Proceed to collection" button with an offset of "5"
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\060-octopus-extension-continue.png"
    And I click the "Proceed to collection" button
    And I sleep for "1" second

  @create-project
  Scenario: Create project
    Given I set the following aliases:
      | Project name   | //input[contains(@id,'project-name-textfield')]           |
      | Description    | //textarea[contains(@id,'project-description-textfield')] |
      | Create project | //button[contains(.,'Create project')]                    |

    And I display a note with the text "Create the Azure DevOps project" for "3" seconds

    And I highlight outside the "Project name" text box
    And I highlight outside the "Description" text box
    And I highlight outside the "Create project" button
    And I populate the "Project name" text box with "Random Quotes"
    And I populate the "Description" text box with "Build and test an ASP.NET application, and push it to Octopus"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\010-create-project.png"
    And I click the "Create project" button
    And I sleep for "40" seconds

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
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\debug1.png"
    And I mouse over the "Pipelines" menu item
    And I highlight inside the "Pipelines" menu item
    And I highlight inside the "Build" link
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\020-build.png"
    And I click the "Build" link

    And I highlight outside the "New pipeline" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\030-new-pipeline.png"
    And I click the "New pipeline" button

    And I highlight outside the "External Git Container" element
    And I click the "External Git Container" element
    And I highlight outside the "Add connection" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\040-external-git.png"
    And I click the "Add connection" button
    And I remove the highlight from the "External Git Container" element
    And I remove the highlight from the "Add connection" button

    And I highlight outside the "Connection name" text box
    And I highlight outside the "Git repository URL" text box
    And I highlight outside the "OK" button with an offset of "2"
    And I clear the "Connection name" text box
    And I populate the "Connection name" text box with "Random Quotes GitHub"
    And I clear the "Git repository URL" text box
    And I populate the "Git repository URL" text box with "https://github.com/OctopusSamples/RandomQuotes-aspmvc4.git"
    And I sleep for "1" second
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\050-git-details.png"
    And I click the "OK" button

    And I sleep for "3" second
    And I highlight outside the "Continue" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\060-continue.png"
    And I click the "Continue" button

    And I highlight inside the "ASP.NET Row" element
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
      | Publish artifact           | //div[@data-list-index='5']/div/div/div/div[./div/div/div/div[text()='Publish Artifact']]  |
      | Test Assemblies            | //div[@data-list-index='3']/div/div/div/div[./div/div/div/div[text()='Test Assemblies']]   |
      | Build solution             | //div[@data-list-index='2']/div/div/div/div[./div/div/div/div[text()='Build solution']]    |
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
      | Space Refresh              | //button[./div/span[text()='Refresh Space']]                                               |
      | Default Space              | //li[text()='Default']                                                                     |
      | Package                    | //textarea[../../../../../../div/label[contains(.,'Package')]]                             |
      | Post job Checkout          | //div[text()='Post-job: Checkout']                                                         |

    And I highlight inside the "Agent pool" drop down list
    And I click the "Agent pool" drop down list
    And I click the "Default" option
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\080-default-agent-pool.png"

    And I highlight inside the "Build solution" row
    And I click the "Build solution" row
    And I highlight outside the "MSBuild Arguments" text box
    And I scroll the "MSBuild Arguments" text box into view offset by "-200"
    And I clear the "MSBuild Arguments" text box
    And I populate the "MSBuild Arguments" text box with "/p:RunOctoPack=true /p:OctoPackPackageVersion=1.0.$(Build.BuildId) /p:OctoPackEnforceAddingFiles=true"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\090-msbuild-arguments.png"
    And I remove the highlight from the "Build solution" row

    And I highlight inside the "Test Assemblies" row
    And I click the "Test Assemblies" row
    And I highlight inside the "Specific location" option
    And I scroll the "Specific location" option into view offset by "-200"
    And I force click the "Specific location" option
    And I highlight inside the "Path to vstest.console.exe" text box
    And I populate the "Path to vstest.console.exe" text box with "$(Build.Repository.LocalPath)\packages\Microsoft.TestPlatform.16.3.0\tools\net451\Common7\IDE\Extensions\TestPlatform\vstest.console.exe"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\100-vstest-location.png"
    And I remove the highlight from the "Test Assemblies" row

    And I highlight inside the "Add task" button
    And I click the "Publish artifact" row
    And I click the "Add task" button

    And I highlight outside the "Search" text box
    And I populate the "Search" text box with "Octopus Push"

    And I highlight outside the "Push package title" element with an offset of "5"
    And I mouse over the "Push package title" element
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\110-octopus-push.png"
    And I remove the highlight from the "Add task" button

    And I click the "Push package" button
    And I click the "Push Packages to Octopus" row
    And I highlight outside the "New" button with an offset of "2"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\120-octopus-connection.png"
    And I click the "New" button
    And I remove the highlight from the "New" button

    And I highlight outside the "Connection name" text box with an offset of "2"
    And I highlight outside the "Server URL" text box with an offset of "2"
    And I highlight outside the "API Key" text box with an offset of "2"
    And I highlight inside the "OK" button
    And I populate the "Connection name" text box with "Octopus"
    And I populate the "Server URL" text box with "http://localhost"
    And I populate the "API Key" text box with "ExternalOctopusAPIKey"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\130-octopus-details.png"
    And I click the "OK" button
    And I remove the highlight from the "New" button

    And I click the "Space Refresh" button
    And I sleep for "2" seconds

    And I highlight outside the "Space" drop down list with an offset of "2"
    And I click the "Space" drop down list
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\debug2.png"
    And I click the "Default Space" option

    And I highlight outside the "Package" text box
    And I populate the "Package" text box with "RandomQuotes\obj\octopacked\RandomQuotes.1.0.$(Build.BuildId).nupkg"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\140-space-and-package.png"
    And I remove the highlight from the "Space" drop down list
    And I remove the highlight from the "Package" text box

    And I highlight inside the "Save and queue" button
    And I click the "Save and queue" button
    And I highlight inside the "Save and queue two" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\150-save-and-queue.png"
    And I click the "Save and queue two" button
    And I remove the highlight from the "Save and queue" button

    And I highlight outside the "Comment" text box with an offset of "0"
    And I highlight outside the "Save and queue three" button with an offset of "2"
    And I scroll the "Comment" text box into view offset by "100"
    And I populate the "Comment" text box with "Initial build"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\160-initial-build.png"
    And I scroll the "Save and queue three" button into view
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\163-save-and-queue.png"
    And I click the "Save and queue three" button
    And I sleep for "3" seconds

    And I highlight outside the "Build link" element
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\165-build-link.png"
    And I click the "Build link" element

    And I sleep for "120" seconds
    And I scroll the "Post job Checkout" item into view
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\170-build-results.png"
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen

  Scenario: View agents
    Given I open the URL "http://localhost:9090/DefaultCollection/_settings/agentpools?poolId=1&_a=agents"
    And I sleep for "10" seconds
    Then I save a screenshot to "c:\screenshots\azuredevops\initialproject\build-agents.png"

  Scenario: Shutdown
    And I stop recording the screen
    And I close the browser