Feature: Build and deploy a ASP.NET application hosted in Git on a local Octopus instance

  @login
  Scenario: Log into Azure DevOps
    And I open the shared browser "FirefoxNoImplicitWaitNoProxy"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    #And I set the window size to "1024" x "768"
    When I open the URL "http://localhost:9090/"

  @install-extensions
  Scenario: Install Extensions
    Given I set the following aliases:
      | Admin settings | //a[@href='/DefaultCollection/_settings/'] |

    And I start recording the screen to the directory "C:\screenshots"

    And I display a note with the text "Installing the Azure DevOps extensions" for "3" seconds
    And I highlight inside the "Admin settings" button
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\#{GuideSpecificScreenshotDir}010-admin-settings.png"
    And I click the "Admin settings" button
    And I sleep for "3" seconds

  @install-extensions
  Scenario: Install extensions
    Given I set the following aliases:
      | Extensions            | //a[@href='/DefaultCollection/_settings/extensions']                          |
      | Close                 | //button[contains(@class,'bolt-teaching-pane-close-button')]                  |
      | Browse Marketplace    | //a[contains(.,'Browse marketplace')]                                         |
      | Search                | //input[@aria-label='Search Azure DevOps extensions']                         |
      | Search button         | //span[@title='search']                                                       |
      | Octopus tile          | //a[@href='/items?itemName=octopusdeploy.octopus-deploy-build-release-tasks'] |
      | Get it free           | //button[text()='Get it free']                                                |
      | Install               | //button[contains(.,'Install')]                                               |
      | Proceed to collection | //a[@href='/DefaultCollection/']                                              |

    And I save a screenshot to "c:\screenshots\azuredevops\extensions\#{GuideSpecificScreenshotDir}debug1.png"
    And I highlight inside the "Extensions" button
    And I mouse over the "Extensions" button
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\#{GuideSpecificScreenshotDir}015-extensions.png"
    And I open the URL "http://localhost:9090/DefaultCollection/_settings/extensions?tab=Manage&status=active"

    And I click the "Close" button if it exists

    And I highlight outside the "Browse Marketplace" button with an offset of "0"
    And I mouse over the "Browse Marketplace" button
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\#{GuideSpecificScreenshotDir}020-browse-marketplace.png"
    # Open the marketplace URL directly to avoid it popping up in a new tab
    And I open the URL "https://marketplace.visualstudio.com/search?target=AzureDevOps&category=All%20categories&hosting=onpremises&sortBy=Relevance"

    And I highlight outside the "Search" text box
    And I populate the "Search" text box with "Octopus Deploy"
    And I click the "Search button" element

    And I highlight outside the "Octopus tile" element with an offset of "0"
    And I mouse over the "Octopus tile" element
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\#{GuideSpecificScreenshotDir}030-octopus-extension-tile.png"
    # Open the URL directly, but make it look like we clicked on the tile
    And I open the URL "https://marketplace.visualstudio.com/items?itemName=octopusdeploy.octopus-deploy-build-release-tasks"

    And I highlight outside the "Get it free" button
    And I mouse over the "Get it free" button
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\#{GuideSpecificScreenshotDir}040-octopus-extension-getit.png"
    # This is a workaround to the fact that we don't have a public url, so we don't click the button but instead
    # open the internal URL that allows us to add the extension.
    And I open the URL "http://localhost:9090/_gallery/acquisition?itemName=octopusdeploy.octopus-deploy-build-release-tasks&installContext=eyJpdGVtTmFtZSI6Im9jdG9wdXNkZXBsb3kub2N0b3B1cy1kZXBsb3ktYnVpbGQtcmVsZWFzZS10YXNrcyIsIml0ZW1VcmwiOiJodHRwczovL21hcmtldHBsYWNlLnZpc3VhbHN0dWRpby5jb20vaXRlbXM%2FaXRlbU5hbWU9b2N0b3B1c2RlcGxveS5vY3RvcHVzLWRlcGxveS1idWlsZC1yZWxlYXNlLXRhc2tzIiwiY29sbGVjdGlvbklkIjoiOGFmMWNhYzktYjU1Yi00ODY5LWE0ZGItY2UxODEwZTQ1NmY5In0%3D"
    And I sleep for "10" seconds

    And I highlight outside the "Install" button
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\#{GuideSpecificScreenshotDir}050-octopus-extension-install.png"
    And I click the "Install" button
    And I sleep for "5" seconds

    And I highlight outside the "Proceed to collection" button with an offset of "5"
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\#{GuideSpecificScreenshotDir}060-octopus-extension-continue.png"
    And I click the "Proceed to collection" button
    And I sleep for "1" second
    And I stop recording the screen

  @create-project @sourcespecific @tfvc
  Scenario: Create project
    Given I set the following aliases:
      | Project name                    | //input[contains(@class,'project-name-textfield')]                                                                         |
      | Description                     | //textarea[contains(@class,'description-textarea-input')]                                                               |
      | Create project                  | //button[contains(.,'Create project')]                                                                                     |
      | Pipelines                       | //a[@aria-label='Pipelines']                                                                                               |
      | Advanced                        | //button[contains(.,'Advanced')]                                                                                           |
      | Version control                 | //div[@aria-label='Select a version control type for the default repository. You can always add more repositories later.'] |
      | Team Foundation Version Control | //button[contains(.,'Team Foundation Version Control')]                                                                    |

    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Create the Azure DevOps project" for "3" seconds

    And I highlight inside the "Project name" text box
    And I highlight inside the "Description" text box
    And I highlight outside the "Create project" button
    And I highlight outside the "Advanced" link
    And I scroll the "Project name" text box into view offset by "-200"
    And I populate the "Project name" text box with "Random Quotes"
    And I populate the "Description" text box with "Build and test an ASP.NET application, and push it to Octopus"
    And I click the "Advanced" link
    And I scroll the "Version control" drop down list into view offset by "-200"
    And I click the "Version control" drop down list
    And I click the "Team Foundation Version Control" option
    And I highlight outside the "Version control" drop down list
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}010-create-project-tfvc.png"
    And I scroll the "Create project" button list into view offset by "-200"
    And I click the "Create project" button
    And I sleep for "5" seconds
    And I stop recording the screen
    And I verify the "Pipelines" menu item is present waiting up to "40" seconds if it exists

  @create-project @sourcespecific @git
  Scenario: Create project
    Given I set the following aliases:
      | Project name   | //input[contains(@id,'project-name-textfield')]           |
      | Description    | //textarea[contains(@id,'project-description-textfield')] |
      | Create project | //button[contains(.,'Create project')]                    |
      | Pipelines      | //a[@aria-label='Pipelines']                              |

    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Create the Azure DevOps project" for "3" seconds

    And I highlight outside the "Project name" text box
    And I highlight outside the "Description" text box
    And I highlight outside the "Create project" button
    And I populate the "Project name" text box with "Random Quotes"
    And I populate the "Description" text box with "Build and test an ASP.NET application, and push it to Octopus"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}010-create-project.png"
    And I click the "Create project" button
    And I sleep for "5" seconds
    And I stop recording the screen
    And I verify the "Pipelines" menu item is present waiting up to "40" seconds if it exists

  @create-project @sourcespecific @tfvc
  Scenario: Create project
    Given I set the following aliases:
      | Pipelines      | //a[@aria-label='Pipelines']             |
      | Build          | //a[@aria-label='Builds']                |
      | New pipeline   | //button[contains(., 'New pipeline')]    |
      | TFVC Container | //div[./label//div[contains(., 'TFVC')]] |
      | TFVC           | //input[../div[contains(., 'TFVC')]]     |
      | Continue       | //button[contains(.,'Continue')]         |

    And I open the URL "http://localhost:9090/DefaultCollection/Random%20Quotes/"
    And I start recording the screen to the directory "C:\screenshots"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}debug1-tfvc.png"
    And I mouse over the "Pipelines" menu item
    And I highlight inside the "Pipelines" menu item
    And I highlight inside the "Build" link
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}020-build-tfvc.png"
    And I click the "Build" link

    And I highlight outside the "New pipeline" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}030-new-pipeline-tfvc.png"
    And I click the "New pipeline" button

    And I highlight outside the "TFVC Container" element
    And I click the "TFVC Container" element

    And I sleep for "3" second
    And I highlight outside the "Continue" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}060-continue-tfvc.png"
    And I click the "Continue" button

  @create-project @sourcespecific @git
  Scenario: Create project
    Given I set the following aliases:
      | Pipelines              | //div[@role='menuitem'][./a[@href='/DefaultCollection/Random%20Quotes/_build']] |
      | Build                  | //a[@aria-label='Builds']                                                       |
      | New pipeline           | //button[contains(., 'New pipeline')]                                           |
      | External Git Container | //div[./label//div[contains(., 'External Git')]]                                |
      | External Git           | //input[../div[contains(., 'External Git')]]                                    |
      | Add connection         | //button[contains(.,'Add connection')]                                          |
      | Connection name        | //input[@id='INPUT-FIELD-STRING0']                                              |
      | Git repository URL     | //input[@id='INPUT-FIELD-STRING1']                                              |
      | OK                     | //button[contains(., 'OK')]                                                     |
      | Continue               | //button[contains(.,'Continue')]                                                |

    And I open the URL "http://localhost:9090/DefaultCollection/Random%20Quotes/"
    And I start recording the screen to the directory "C:\screenshots"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}debug1.png"
    And I click the "Pipelines" menu item
    And I highlight inside the "Pipelines" menu item
    And I highlight inside the "Build" link
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}020-build.png"
    And I click the "Build" link

    And I highlight outside the "New pipeline" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}030-new-pipeline.png"
    And I click the "New pipeline" button

    And I highlight outside the "External Git Container" element
    And I click the "External Git Container" element
    And I highlight outside the "Add connection" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}040-external-git.png"
    And I click the "Add connection" button
    And I remove the highlight from the "External Git Container" element
    And I remove the highlight from the "Add connection" button

    And I highlight outside the "Connection name" text box
    And I highlight outside the "Git repository URL" text box
    And I highlight outside the "OK" button with an offset of "2"
    And I clear the "Connection name" text box
    And I populate the "Connection name" text box with "Random Quotes GitHub"
    And I clear the "Git repository URL" text box
    And I populate the "Git repository URL" text box with "GitUrl"
    And I sleep for "1" second
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}050-git-details.png"
    And I click the "OK" button

    And I sleep for "3" second
    And I highlight outside the "Continue" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}060-continue.png"
    And I click the "Continue" button

  @create-project @applicationspecific @aspnet
  Scenario: Create project
    Given I set the following aliases:
      | ASP.NET Row | //div[./div/div/div/div[text()='Build and test an ASP.NET web application.']] |
      | ASP.NET     | //button[./div/span[text()='Apply ASP.NET template']]                         |

    And I highlight inside the "ASP.NET Row" element
    And I mouse over the "ASP.NET Row" element
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}070-aspnet.png"
    And I click the "ASP.NET" button

    And I sleep for "1" seconds
    And I stop recording the screen

  @create-project @applicationspecific @aspnetcore
  Scenario: Create project
    Given I set the following aliases:
      | ASP.NET Core Row | //div[./div/div/div/div[text()='Build and test an ASP.NET Core web application.']] |
      | ASP.NET Core     | //button[./div/span[text()='Apply ASP.NET Core template']]                         |

    And I scroll the "ASP.NET Core Row" element into view offset by "-200"
    And I highlight inside the "ASP.NET Core Row" element
    And I mouse over the "ASP.NET Core Row" element
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}070-aspnet.png"
    And I click the "ASP.NET Core" button

    And I sleep for "1" seconds
    And I stop recording the screen

  @configure-project
  Scenario: Configure build agent
    Given I set the following aliases:
      | Agent pool | //button[../input[@aria-label='Agent pool']] |
      | Default    | //button[@aria-label='Default']              |

    And I start recording the screen to the directory "C:\screenshots"

    And I highlight inside the "Agent pool" drop down list
    And I click the "Agent pool" drop down list
    And I click the "Default" option
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}080-default-agent-pool.png"

  @configure-project @applicationspecific @aspnet
  Scenario: Configure project
    Given I set the following aliases:
      | Test Assemblies            | //div[@data-list-index]/div/div/div/div[./div/div/div/div[normalize-space(text())='Test Assemblies']] |
      | Build solution             | //div[@data-list-index]/div/div/div/div[./div/div/div/div[normalize-space(text())='Build solution']]  |
      | Specific location          | //input[../label/span[text()='Specific location']]                                                    |
      | Path to vstest.console.exe | //textarea[./../../../../../../../../div/label[text()='Path to vstest.console.exe']]                  |
      | MSBuild Arguments          | //textarea[./../../../../../../../../div/label[text()='MSBuild Arguments']]                           |
      | Add task                   | //button[@aria-label='Add a task to Agent job 1']                                                     |
      | Search                     | (//input[@aria-label='Search'])[2]                                                                    |

    And I highlight inside the "Build solution" row
    And I click the "Build solution" row
    And I highlight outside the "MSBuild Arguments" text box
    And I scroll the "MSBuild Arguments" text box into view offset by "-200"
    And I clear the "MSBuild Arguments" text box
    And I populate the "MSBuild Arguments" text box with "/p:RunOctoPack=true /p:OctoPackPackageVersion=1.0.$(Build.BuildId) /p:OctoPackEnforceAddingFiles=true"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}090-msbuild-arguments.png"
    And I remove the highlight from the "Build solution" row

    And I highlight inside the "Test Assemblies" row
    And I click the "Test Assemblies" row
    And I highlight inside the "Specific location" option
    And I scroll the "Specific location" option into view offset by "-200"
    And I force click the "Specific location" option
    And I highlight inside the "Path to vstest.console.exe" text box
    And I populate the "Path to vstest.console.exe" text box with "$(Build.Repository.LocalPath)\packages\Microsoft.TestPlatform.16.3.0\tools\net451\Common7\IDE\Extensions\TestPlatform\vstest.console.exe"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}100-vstest-location.png"
    And I remove the highlight from the "Test Assemblies" row

    And I stop recording the screen

  @configure-project @applicationspecific @aspnetcore
  Scenario: ASP.Net Core Configure project
    Given I set the following aliases:
      | Publish row               | //div[@data-list-index]/div/div/div/div[./div/div/div/div[normalize-space(text())='Publish']]          |
      | Add task                  | //button[@aria-label='Add a task to Agent job 1']                                                      |
      | Publish artifact          | //div[@data-list-index]/div/div/div/div[./div/div/div/div[normalize-space(text())='Publish Artifact']] |
      | Search                    | (//input[@aria-label='Search'])[2]                                                                     |
      | Package application title | //div[text()='Package Application for Octopus']                                                        |
      | Package application       | //div[./div/div/div[text()='Package Application for Octopus']]/button                                  |
      | Package application row   | //div[@data-list-index]/div/div/div/div[./div/div/div/div[normalize-space(text())='Package']]          |
      | Package ID                | //textarea[../../../../../../../../div/label[normalize-space(text())='Package ID']]                    |
      | Package Version           | //textarea[../../../../../../../../div/label[normalize-space(text())='Package Version']]               |
      | Source Path               | //textarea[../../../../../../../../div/label[normalize-space(text())='Source Path']]                   |
      | Zip Published Projects    | //button[.//span[text()='Zip Published Projects']]                                                     |

    And I click the "Publish row" element

    And I scroll the "Zip Published Projects" check box into view offset by "-200"
    And I highlight outside the "Zip Published Projects" check box with an offset of "5"
    And I click the "Zip Published Projects" check box
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}090-publish.png"

    And I highlight inside the "Add task" button
    And I click the "Publish artifact" row
    And I click the "Add task" button

    And I highlight outside the "Search" text box
    And I populate the "Search" text box with "Package Application"

    And I highlight outside the "Package application title" element with an offset of "5"
    And I mouse over the "Package application title" element
    And I zoom the browser out
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}095-octopus-pack.png"
    And I zoom the browser in
    And I remove the highlight from the "Add task" button

    And I click the "Package application" button
    And I click the "Package application row" element

    And I scroll the "Package ID" text box into view offset by "-200"
    And I highlight outside the "Package ID" text box with an offset of "5"
    And I populate the "Package ID" text box with "RandomQuotes"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}096-octopus-pack.png"
    And I remove the highlight from the "Package ID" text box

    And I scroll the "Package Version" text box into view offset by "-200"
    And I highlight outside the "Package Version" text box with an offset of "5"
    And I populate the "Package Version" text box with "1.0.$(Build.BuildId)"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}097-octopus-pack.png"
    And I remove the highlight from the "Package Version" text box

    And I scroll the "Source Path" text box into view offset by "-200"
    And I highlight outside the "Source Path" text box with an offset of "5"
    And I populate the "Source Path" text box with "$(build.artifactstagingdirectory)\RandomQuotes"
    And I remove the highlight from the "Source Path" text box

    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}100-octopus-pack.png"

    And I stop recording the screen

  @configure-project @applicationspecific @aspnet
  Scenario: Push to Octopus
  The last task need to be selected and then the "Add task" button clicked to ensure the new task is appended to the end.
  This Scenario selects the final task for the ASP.NET builds.

    Given I set the following aliases:
      | Add task         | //button[@aria-label='Add a task to Agent job 1']                                                      |
      | Publish artifact | //div[@data-list-index]/div/div/div/div[./div/div/div/div[normalize-space(text())='Publish Artifact']] |

    And I start recording the screen to the directory "C:\screenshots"

    And I highlight inside the "Add task" button
    And I click the "Publish artifact" row
    And I click the "Add task" button

  @configure-project @applicationspecific @aspnetcore
  Scenario: Push to Octopus
  The last task need to be selected and then the "Add task" button clicked to ensure the new task is appended to the end.
  This Scenario selects the final task for the ASP.NET Core builds.

    Given I set the following aliases:
      | Add task                | //button[@aria-label='Add a task to Agent job 1']                                                          |
      | Package application row | //div[@data-list-index]/div/div/div/div[./div/div/div/div[normalize-space(text())='Package RandomQuotes']] |

    And I start recording the screen to the directory "C:\screenshots"

    And I highlight inside the "Add task" button
    And I click the "Package application row" element
    And I click the "Add task" button

  @configure-project @repositoryspecific @artifactory
  Scenario: Push to Artifactory
    Given I set the following aliases:
      | Search                                                       | (//input[@aria-label='Search'])[2]                                                                             |
      | NuGet title                                                  | //div[@class='info-name'][text()='NuGet']                                                                      |
      | NuGet Task                                                   | //div[./div/div/div[text()='NuGet']]/button                                                                    |
      | NuGet restore                                                | (//div[@data-list-index]/div/div/div/div[./div/div/div/div[normalize-space(text())='NuGet restore']])[last()]  |
      | Display name                                                 | //input[../../../../../../div/label[normalize-space(text())='Display name']]                                   |
      | Command                                                      | //input[../../../../../../../../../div/label[normalize-space(text())='Command']]                               |
      | Push command                                                 | //div[contains(@class,'combo-drop-popup')]//*[normalize-space(text())='push']                                  |
      | Path to NuGet package(s) to publish                          | //textarea[../../../../../../../../div/label[normalize-space(text())='Path to NuGet package(s) to publish']]   |
      | External NuGet server (including other accounts/collections) | //input[../label/span[normalize-space(text())='External NuGet server (including other accounts/collections)']] |
      | New                                                          | //div[./span[text()='Add NuGet server']]                                                                       |
      | ApiKey Option                                                | //input[@value='None']                                                                                         |
      | Connection name                                              | //input[@id='connectionName']                                                                                  |
      | Feed URL                                                     | //input[@id='url']                                                                                             |
      | ApiKey                                                       | //input[@id='nugetkey']                                                                                        |
      | OK                                                           | //button[@id='ok']                                                                                             |

    And I highlight outside the "Search" text box
    And I populate the "Search" text box with "Nuget"

    And I highlight outside the "NuGet title" element with an offset of "5"
    And I mouse over the "NuGet title" element
    And I zoom the browser out
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}110-nuget-push.png"
    And I zoom the browser in
    And I remove the highlight from the "Add task" button

    And I click the "NuGet Task" button
    And I click the "NuGet restore" row

    And I highlight outside the "Display name" text box list with an offset of "2"
    And I clear the "Display name" text box
    And I populate the "Display name" text box with "Nuget push"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}115-nuget-push.png"
    And I remove the highlight from the "Display name" text box

    And I highlight outside the "Command" drop down list with an offset of "2"
    And I click the "Command" drop down list
    And I click the "Push command" option
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}120-nuget-push.png"
    And I remove the highlight from the "Command" drop down list

    And I highlight outside the "Path to NuGet package(s) to publish" text box with an offset of "2"
    And I clear the "Path to NuGet package(s) to publish" text box
    And I populate the "Path to NuGet package(s) to publish" text box with "#{NugetPath}RandomQuotes.1.0.$(Build.BuildId).nupkg"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}125-nuget-push.png"
    And I remove the highlight from the "Path to NuGet package(s) to publish" text box

    And I highlight outside the "External NuGet server (including other accounts/collections)" radio button with an offset of "2"
    And I force click the "External NuGet server (including other accounts/collections)" radio button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}130-nuget-push.png"

    And I highlight outside the "New" button with an offset of "2"
    And I scroll the "New" button into view offset by "-300"
    And I click the "New" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}135-nuget-push.png"
    And I remove the highlight from the "New" button
    And I remove the highlight from the "External NuGet server (including other accounts/collections)" radio button

    And I highlight outside the "Connection name" text box with an offset of "2"
    And I highlight outside the "Feed URL" text box with an offset of "2"
    And I highlight outside the "ApiKey" text box with an offset of "2"
    And I highlight outside the "OK" button with an offset of "2"
    And I populate the "Connection name" text box with "Artifactory"
    And I populate the "Feed URL" text box with "http://localhost:8041/artifactory/api/nuget/NuGet"
    And I populate the "ApiKey" text box with "admin:password"
    And I click the "OK" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}140-nuget-push.png"

    And I stop recording the screen

  @configure-project @repositoryspecific @octo-built-in-feed
  Scenario: Push to Octopus
    Given I set the following aliases:
      | Search                   | (//input[@aria-label='Search'])[2]                                                                             |
      | Push package title       | //div[text()='Push Package(s) to Octopus']                                                                     |
      | Push package             | //div[./div/div/div[text()='Push Package(s) to Octopus']]/button                                               |
      | Push Packages to Octopus | //div[@data-list-index]/div/div/div/div[./div/div/div/div[normalize-space(text())='Push Packages to Octopus']] |
      | New                      | //div[./span[text()='Add Octopus Deploy Server']]                                                              |
      | Connection name          | //input[@id='connectionName']                                                                                  |
      | Server URL               | //input[@id='url']                                                                                             |
      | API Key                  | //input[@id='apitoken']                                                                                        |
      | OK                       | //button[@id='ok']                                                                                             |
      | Space                    | //div[@aria-label='Expand'][../../../../../../../../../div/div/label[contains(.,'Space')]]                     |
      | Space Refresh            | //button[./div/span[text()='Refresh Space']]                                                                   |
      | Default Space            | //li[text()='Default']                                                                                         |
      | Package                  | //textarea[../../../../../../div/label[contains(.,'Package')]]                                                 |

    And I highlight outside the "Search" text box
    And I populate the "Search" text box with "Octopus Push"
    And I sleep for "5" seconds

    And I highlight outside the "Push package title" element with an offset of "5"
    And I mouse over the "Push package title" element
    And I zoom the browser out
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}110-octopus-push.png"
    And I zoom the browser in
    And I remove the highlight from the "Add task" button

    And I click the "Push package" button
    And I click the "Push Packages to Octopus" row
    And I highlight outside the "New" button with an offset of "2"
    And I zoom the browser out
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}120-octopus-connection.png"
    And I zoom the browser in
    And I click the "New" button
    And I remove the highlight from the "New" button

    And I highlight outside the "Connection name" text box with an offset of "2"
    And I highlight outside the "Server URL" text box with an offset of "2"
    And I highlight outside the "API Key" text box with an offset of "2"
    And I highlight inside the "OK" button
    And I populate the "Connection name" text box with "Octopus"
    And I populate the "Server URL" text box with "http://localhost"
    And I populate the "API Key" text box with "ExternalOctopusAPIKey"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}130-octopus-details.png"
    And I click the "OK" button
    And I remove the highlight from the "New" button

    And I sleep for "1" second
    And I click the "Space Refresh" button
    And I sleep for "2" seconds

    And I highlight outside the "Space" drop down list with an offset of "2"
    And I click the "Space" drop down list
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}debug2.png"
    And I click the "Default Space" option

    And I highlight outside the "Package" text box
    And I populate the "Package" text box with "#{NugetPath}RandomQuotes.1.0.$(Build.BuildId).nupkg"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}140-space-and-package.png"
    And I remove the highlight from the "Space" drop down list
    And I remove the highlight from the "Package" text box

  @save-project
  Scenario: Save project
    Given I set the following aliases:
      | Save and queue | //button[@name='Save & queue'] |
      | Save           | (//button[@name='Save'])[1]    |
      | Save two       | //button[@aria-label='Save']   |

    And I highlight inside the "Save and queue" button
    And I click the "Save and queue" button
    And I highlight inside the "Save" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}150-save.png"
    And I click the "Save" button
    And I remove the highlight from the "Save and queue" button

    And I highlight outside the "Save two" button with an offset of "2"
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}160-save.png"
    And I click the "Save two" button
    And I sleep for "3" seconds

    And I stop recording the screen

  @execute-project @sourcespecific @tfvc
  Scenario: Open pipeline again
  We interrupt the flow of the build to populate the TFVC repo behind the scenes. This scenario gets us back into
  the pipeline edit from where we will queue a build.

    Given I set the following aliases:
      | Edit | //a[contains(.,'Edit')] |

    And I open the URL "http://localhost:9090/DefaultCollection/Random Quotes/_build"
    And I click the "Edit" button

  @execute-project
  Scenario: Execute build
  The pipeline is saved, so we queue a build here.

    Given I set the following aliases:
      | More commands     | //button[@aria-label='More commands']         |
      | Queue             | //button[@name='Queue']                       |
      | Queue two         | //button[@aria-label='Queue']                 |
      | Build link        | //a[contains(@class, 'ci-queued-build-link')] |
      | Post job Checkout | //div[text()='Post-job: Checkout']            |

    And I start recording the screen to the directory "C:\screenshots"

    And I highlight inside the "More commands" button
    And I click the "More commands" button if it exists waiting up to "5" seconds

    And I highlight inside the "Queue" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}163-queue.png"
    And I click the "Queue" button

    And I remove the highlight from the "More commands" button

    And I highlight inside the "Queue two" button
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}164-queue.png"
    And I click the "Queue two" button

    And I highlight outside the "Build link" element
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}165-build-link.png"
    And I click the "Build link" element

    And I sleep for "20" seconds
    And I stop recording the screen
    And I sleep for "120" seconds

    And I start recording the screen to the directory "C:\screenshots"
    And I scroll the "Post job Checkout" item into view
    And I save a screenshot to "c:\screenshots\azuredevops\initialproject\#{GuideSpecificScreenshotDir}170-build-results.png"
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen

  Scenario: Shutdown
    And I stop recording the screen
    And I close the browser

  @execute-project @sourcespecific @tfvc
  Scenario: Shutdown after TFVC build
    And I stop recording the screen
    And I close the browser