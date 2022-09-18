Feature: Configure an Octopus ASP.NET project

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments
    And I run the feature "shared/octopus-hide-wizard.feature" passing the original arguments

  @create-project @destinationspecific @iis
  Scenario: IIS - Display annotation
    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating the IIS deployment project in Octopus" for "3" seconds

  @create-project @destinationspecific @azure-web-app
  Scenario: Azure Web App - Display annotation
    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating the Azure Web App deployment project in Octopus" for "3" seconds

  @create-project
  Scenario: Create Project
    Given I set the following aliases:
      | Projects         | //span[contains(.,'Projects')]               |
      | Add project      | //div[./div/span[contains(.,'Add Project')]] |
      | New project name | //input[@name='New project name']            |
      | Save             | (//div[contains(.,'Save')])[8]               |

    And I highlight outside the "Projects" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}005-octopus-projects.png"
    And I click the "Projects" link
    And I sleep for "1" second

    And I highlight outside the "Add project" link with an offset of "1"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}010-octopus-add-project.png"
    And I click the "Add project" button
    And I remove the highlight from the "Add project" link
    And I remove the highlight from the "Projects" link

    And I highlight outside the "New project name" text box with an offset of "2"
    And I highlight outside the "Save" button with an offset of "2"
    And I populate the "New project name" text box with "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}015-octopus-new-project-name.png"
    And I click the "Save" button
    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds

  @define-variables
  Scenario: Open the variables section
    Given I set the following aliases:
      | Variables         | //a[contains(.,'Variables')]                                                                                                                                 |
      | Variables text    | //a[contains(.,'Variables')][not(*)] \| //a/span[text()='Variables']                                                                                         |
      | Project Variables | //a[@href='#/Spaces-1/projects/random-quotes/variables']/div/span[contains(.,'Project')] \| //a[@href='#/Spaces-1/projects/random-quotes/variables'][not(*)] |

    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/overview"
    And I sleep for "1" second
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Variables text" link with an offset of "2"
    And I click the "Variables" link
    And I highlight inside the "Project Variables" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}020-octopus-variables.png"
    And I force click the "Project Variables" link
    And I remove the highlight from the "Variables text" link

  @define-variables @applicationspecific @aspnet
  Scenario: ASP.NET - Define project EnvironmentName Variable
  ASP.NET apps use the Configuration Variables feature, which matches variables to those in the .config files
    Given I set the following aliases:
      | New variable name       | //input[@name='Enter new variable']   |
      | New variable value      | //input[@name='Enter value']          |
      | Project Variables Title | //h2[contains(.,'Project Variables')] |
      | Add to list             | //button[@title='Add To List']        |

    And I populate the "New variable name" text box with "EnvironmentName"
    And I populate the "New variable value" text box with "#{Octopus.Environment.Name}"
    And I sleep for "1" second
    And I click the "Add to list" button
    And I force click the "Project Variables Title" element

  @define-variables @applicationspecific @aspnetcore
  Scenario: ASP.NET Core - Define project EnvironmentName Variable
  ASP.NET Core apps use the JSON Configuration Variables feature, which uses the parent:child syntax for variables.
    Given I set the following aliases:
      | New variable name       | //input[@name='Enter new variable']                                                                                                                          |
      | New variable value      | //input[@name='Enter value']                                                                                                                                 |
      | Project Variables       | //a[@href='#/Spaces-1/projects/random-quotes/variables']/div/span[contains(.,'Project')] \| //a[@href='#/Spaces-1/projects/random-quotes/variables'][not(*)] |
      | Project Variables Title | //h2[contains(.,'Project Variables')]                                                                                                                        |
      | Add to list             | //button[@title='Add To List']                                                                                                                               |

    And I populate the "New variable name" text box with "AppSettings:EnvironmentName"
    And I populate the "New variable value" text box with "#{Octopus.Environment.Name}"
    And I sleep for "1" second
    And I click the "Add to list" button
    And I force click the "Project Variables Title" element

  @define-project @destinationspecific @iis
  Scenario: Define iis ports
    Given I set the following aliases:
      | Define scope            | //div[@title='Define scope']                       |
      | Select environments     | //input[../../label[text()='Select environments']] |
      | Dev environment         | //span[./div/div/div[text()='Dev']]                |
      | Test environment        | //span[./div/div/div[text()='Test']]               |
      | Prod environment        | //span[./div/div/div[text()='Prod']]               |
      | Add Another Value       | //button[.//span[text() = 'Add Another Value']]    |
      | Project Variables Title | //h2[contains(.,'Project Variables')]              |
      | New variable name       | //input[@name='Enter new variable']                |
      | New variable value      | //input[@name='Enter value']                       |
      | New variable value 2    | (//input[@name='Enter value'])[2]                  |
      | New variable value 3    | (//input[@name='Enter value'])[3]                  |
      | Save                    | //button[contains(.,'Save')]                       |

    And I populate the "New variable name" text box with "IIS Port"
    And I populate the "New variable value" text box with "8081"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Dev environment" option
    And I force click the "Project Variables Title" element

    And I click the "Add Another Value" button
    And I populate the "New variable value 2" text box with "8082"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Test environment" option
    And I force click the "Project Variables Title" element

    And I click the "Add Another Value" button
    And I populate the "New variable value 3" text box with "8083"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Prod environment" option
    And I force click the "Project Variables Title" element

    And I click the "Save" button
    And I scroll down "10000" px
    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "120" seconds

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}025-octopus-variables-populated.png"


  @define-project @destinationspecific @azure-web-app
  Scenario: Save the variables
    Given I set the following aliases:
      | Save | //button[contains(.,'Save')] |

    And I click the "Save" button
    And I scroll down "10000" px
    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}025-octopus-variables-azure-populated.png"

  @define-project
  Scenario: Open the deployments view
    Given I set the following aliases:
      | Overview    | //a[contains(.,'Overview')][not(*)] \| //a//div[text()='Overview'] |
      | Deployments | //a[contains(.,'Deployments')]                                     |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I highlight inside the "Deployments" link
    And I click the "Deployments" link
    And I highlight inside the "Overview" link
    And I click the "Overview" link
    And I remove the highlight from the "Deployments" link

  @define-project @destinationspecific @azure-web-app
  Scenario: Add Azure Web App Step
    Given I set the following aliases:
      | Define your deployment process | //button[contains(.,'Create Process')]                                                     |
      | Add Step                       | //button[contains(.,'Add Step')]                                                           |
      | Search                         | //input[@name='Filter by name, category or description...']                                |
      | Deploy an Azure Web App        | //div[./div/div[text()='Deploy an Azure Web App (Web Deploy)']]                            |
      | Add                            | //div[./div/div[text()='Deploy an Azure Web App (Web Deploy)']]//button[contains(.,'Add')] |

    And I highlight outside the "Define your deployment process" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}030-octopus-define-process.png"

    And I click the "Define your deployment process" button
    And I sleep for "1" second

    And I scroll the "Add Step" button into view offset by "-500"
    And I highlight outside the "Add Step" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}035-octopus-azure-add-step.png"
    And I click the "Add Step" button

    And I highlight outside the "Search" text box with an offset of "3"
    And I populate the "Search" text box with "Azure Web App"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}040-octopus-azure-search-webapp.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Deploy an Azure Web App" tile into view offset by "-200"
    And I highlight outside the "Deploy an Azure Web App" tile
    And I mouse over the "Deploy an Azure Web App" tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}045-octopus-azure-add-azure-webapp.png"
    And I force click the "Add" button

  @define-project @destinationspecific @iis
  Scenario: Add IIS Step
    Given I set the following aliases:
      | Define your deployment process | //button[contains(.,'Create Process')]                              |
      | Add Step                       | //button[contains(.,'Add Step')]                                    |
      | Search                         | //input[@name='Filter by name, category or description...']         |
      | Deploy to IIS                  | //div[./div/div[text()='Deploy to IIS']]                            |
      | Add                            | //div[./div/div[text()='Deploy to IIS']]//button[contains(.,'Add')] |

    And I highlight outside the "Define your deployment process" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}030-octopus-define-process.png"

    And I click the "Define your deployment process" button
    And I sleep for "1" second

    And I scroll the "Add Step" button into view offset by "-500"
    And I highlight outside the "Add Step" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}035-octopus-add-step.png"
    And I click the "Add Step" button

    And I highlight outside the "Search" text box with an offset of "3"
    And I populate the "Search" text box with "iis"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}040-octopus-search-iis.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Deploy to IIS" tile into view offset by "-200"
    And I highlight outside the "Deploy to IIS" tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}045-octopus-add-iis.png"
    And I mouse over the "Deploy to IIS" tile
    And I force click the "Add" button

  @define-project @destinationspecific @azure-web-app @applicationspecific @aspnet
  Scenario: ASP.NET Azure Configure Features

    Given I set the following aliases:
      | Configure features                | (//button[contains(.,'Configure features')])[1]                        |
      | Configuration Variables           | //input[..//label[text()='Structured Configuration Variables']]        |
      | Configuration Variables Container | //div[./input[..//label[text()='Structured Configuration Variables']]] |
      | OK                                | //button[contains(.,'Ok')]                                             |

    And I highlight outside the "Configure features" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}046-octopus-azure-enable-conf-features.png"
    And I scroll the "Configure features" button into view offset by "-300"
    And I click the "Configure features" button
    And I remove the highlight from the "Configure features" button

    And I highlight inside the "Configuration Variables Container" option
    And I highlight outside the "OK" button with an offset of "2"
    And I force click the "Configuration Variables" option
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}047-octopus-azure-enable-conf-vars.png"
    And I click the "OK" button

  @define-project @applicationspecific @aspnetcore
  Scenario: ASP.NET Core Configure Features
  Enable the JSON Configuration Variables feature for ASP.NET Core apps

    Given I set the following aliases:
      | Configure features                | (//button[contains(.,'Configure features')])[1]                        |
      | Configuration Variables           | //input[..//label[text()='Structured Configuration Variables']]        |
      | Configuration Variables Container | //div[./input[..//label[text()='Structured Configuration Variables']]] |
      | OK                                | //button[contains(.,'Ok')]                                             |

    And I highlight outside the "Configure features" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}046-octopus-enable-conf-features.png"
    And I scroll the "Configure features" button into view offset by "-300"
    And I click the "Configure features" button
    And I remove the highlight from the "Configure features" button

    And I highlight inside the "Configuration Variables Container" option
    And I highlight outside the "OK" button with an offset of "2"
    And I force click the "Configuration Variables" option
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}047-octopus-enable-conf-vars.png"
    And I click the "OK" button

  @define-project @destinationspecific @azure-web-app
  Scenario: Azure Define step
    Given I set the following aliases:
      | Step Name    | //input[@name='Step name']                                                                |
      | On behalf of | //input[../../label[text()='On behalf of target roles (type to add new)']]                |
      | Azure role   | //div[contains(@class, 'VirtualListWithKeyboard')]//span[contains(.,'azurewebapp')]//span |

    And I scroll the "Step Name" text box into view offset by "-300"
    And I highlight outside the "Step Name" text box
    And I force clear the "Step Name" text box
    And I populate the "Step Name" text box with "Deploy web app to Azure"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}050-octopus-azure-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "On behalf of" text box into view offset by "-300"
    And I click the "On behalf of" text box
    And I populate the "On behalf of" text box with "azurewebapp"
    And I sleep for "1" second
    And I highlight outside the "On behalf of" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}055-octopus-azure-step-role.png"
    And I click the "Azure role" option
    And I remove the highlight from the "On behalf of" text box

  @define-project @destinationspecific @iis
  Scenario: Define IIS project
    Given I set the following aliases:
      | Add                      | //div[./div/div[text()='Deploy to IIS']]//button[contains(.,'Add')]                  |
      | Step Name                | //input[@name='Step name']                                                           |
      | Runs on targets in roles | //input[../../label[contains(text(), 'Runs on targets in roles (type to add new)')]] |
      | Web role                 | //div[contains(@class, 'VirtualListWithKeyboard')]//span[contains(.,'web')]//span    |

    And I scroll the "Step Name" text box into view offset by "-300"
    And I highlight outside the "Step Name" text box
    And I force clear the "Step Name" text box
    And I populate the "Step Name" text box with "Deploy web app to IIS"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}050-octopus-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "Runs on targets in roles" text box into view offset by "-300"
    And I click the "Runs on targets in roles" text box
    And I populate the "Runs on targets in roles" text box with "web"
    And I sleep for "1" second
    And I highlight outside the "Runs on targets in roles" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}055-octopus-step-role.png"
    And I click the "Web role" option
    And I remove the highlight from the "Runs on targets in roles" text box

  @define-project @destinationspecific @iis @repositoryspecific @artifactory
  Scenario: Select artifactory feed for the iis deployment
    Given I set the following aliases:
      | Package feed             | //div[./label[text()='Package feed']]/div/div                                              |
      | Artifactory              | //button[./div/div[text()='Artifactory']]                                                  |
      | HTML Body                | //body                                                                                     |
      | Package ID               | //input[@name='PackageID']                                                                 |
      | Random Quotes Suggestion | //div[contains(@class, 'VirtualListWithKeyboard')]//span[contains(.,'RandomQuotes')]//span |

    And I scroll the "Package feed" drop down list into view offset by "-300"
    And I click the "Package feed" drop down list
    And I sleep for "1" second
    And I force click the "Artifactory" option
    And I highlight outside the "Package feed" drop down list
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}056-octopus-step-feed.png"
    And I remove the highlight from the "Package feed" text box

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "RandomQuotes"

    # Give the suggestion drop down list some time to populate
    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "20" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I click the "Random Quotes Suggestion" option
    And I press the escape key from the "Package ID" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}060-octopus-step-package-artifactory.png"
    And I remove the highlight from the "Package ID" text box

  @define-project @destinationspecific @iis @repositoryspecific @octo-built-in-feed
  Scenario: Select built in feed for the iis deployment
    Given I set the following aliases:
      | HTML Body                | //body                                                                                     |
      | Package ID               | //input[@name='PackageID']                                                                 |
      | Random Quotes Suggestion | //div[contains(@class, 'VirtualListWithKeyboard')]//span[contains(.,'RandomQuotes')]//span |

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "RandomQuotes"
    And I sleep for "2" second

    # Give the suggestion drop down list some time to populate
    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "20" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I click the "Random Quotes Suggestion" option
    And I press the escape key from the "Package ID" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}060-octopus-step-package.png"
    And I remove the highlight from the "Package ID" text box

  @define-project @destinationspecific @azure-web-app @repositoryspecific @artifactory
  Scenario: Select artifactory feed for the azure web app deployment
    Given I set the following aliases:
      | Package feed             | //div[./label[text()='Package feed']]/div/div                                              |
      | Artifactory              | //button[./div/div[text()='Artifactory']]                                                  |
      | HTML Body                | //body                                                                                     |
      | Package ID               | //input[@name='PackageID']                                                                 |
      | Random Quotes Suggestion | //div[contains(@class, 'VirtualListWithKeyboard')]//span[contains(.,'RandomQuotes')]//span |

    And I scroll the "Package feed" drop down list into view offset by "-300"
    And I click the "Package feed" drop down list
    And I sleep for "1" second
    And I force click the "Artifactory" option
    And I highlight outside the "Package feed" drop down list
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}056-octopus-step-feed-azure.png"
    And I remove the highlight from the "Package feed" text box

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "RandomQuotes"

    # Give the suggestion drop down list some time to populate
    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "20" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I click the "Random Quotes Suggestion" option
    And I press the escape key from the "Package ID" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}060-octopus-step-package-artifactory-azure.png"
    And I remove the highlight from the "Package ID" text box

  @define-project @destinationspecific @azure-web-app @repositoryspecific @octo-built-in-feed
  Scenario: Select built in feed for the azure web app deployment
    Given I set the following aliases:
      | HTML Body                | //body                                                                                     |
      | Package ID               | //input[@name='PackageID']                                                                 |
      | Random Quotes Suggestion | //div[contains(@class, 'VirtualListWithKeyboard')]//span[contains(.,'RandomQuotes')]//span |

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "RandomQuotes"

    # Give the suggestion drop down list some time to populate
    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "20" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I click the "Random Quotes Suggestion" option
    And I press the escape key from the "Package ID" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}060-octopus-step-package-azure.png"
    And I remove the highlight from the "Package ID" text box

  @define-project @destinationspecific @azure-web-app
  Scenario: Azure Web apps - Continue to define project
    Given I set the following aliases:
      | Save | //button[contains(.,'Save')] |

    And I highlight outside the "Save" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}061-octopus-step-package-artifactory-azure-save.png"

  @define-project @destinationspecific @iis
  Scenario: IIS - Continue to define project
    Given I set the following aliases:
      | Web site name                             | //input[@name='Web site name']                                                                                                                               |
      | Enable Anonymous authentication           | //input[@type='checkbox'][../div[contains(.,'Enable Anonymous authentication')]]                                                                             |
      | Enable Anonymous authentication container | //div[./div/div/label[contains(.,'Enable Anonymous authentication')]]                                                                                        |
      | Enable Windows authentication             | //input[@type='checkbox'][../div[contains(.,'Enable Windows authentication')]]                                                                               |
      | Enable Windows authentication container   | //div[./div/div/label[contains(.,'Enable Windows authentication')]]                                                                                          |
      | Application Pool name                     | //input[@name='Application Pool name']                                                                                                                       |
      | Remove binding                            | (//div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M19 6.41L17.59')]])[2]                                                                |
      | Add binding                               | //div[contains(@class, 'actionsMenu')][not(contains(@class, 'hidden'))]//button[contains(.,'Add')]                                                           |
      | Port                                      | //input[@name='Port']                                                                                                                                        |
      | OK                                        | //button[contains(.,'Ok')]                                                                                                                                   |
      | Save                                      | //button[contains(.,'Save')]                                                                                                                                 |
      | Process                                   | //a[contains(.,'Process')]                                                                                                                                   |
      | Variables                                 | //a[contains(.,'Variables')]                                                                                                                                 |
      | Variables text                            | //a[contains(.,'Variables')][not(*)] \| //a/span[text()='Variables']                                                                                         |
      | Project Variables                         | //a[@href='#/Spaces-1/projects/random-quotes/variables']/div/span[contains(.,'Project')] \| //a[@href='#/Spaces-1/projects/random-quotes/variables'][not(*)] |
      | New variable name                         | //input[@name='Enter new variable']                                                                                                                          |
      | New variable value                        | //input[@name='Enter value']                                                                                                                                 |
      | Define scope                              | //div[@title='Define scope']                                                                                                                                 |
      | Select environments                       | //input[../../label[text()='Select environments']]                                                                                                           |
      | Dev environment                           | //span[./div/div/div[text()='Dev']]                                                                                                                          |
      | Test environment                          | //span[./div/div/div[text()='Test']]                                                                                                                         |
      | Prod environment                          | //span[./div/div/div[text()='Prod']]                                                                                                                         |
      | Add Another Value                         | //button[.//span[text() = 'Add Another Value']]                                                                                                              |
      | New variable value 2                      | (//input[@name='Enter value'])[2]                                                                                                                            |
      | New variable value 3                      | (//input[@name='Entervalue'])[3]                                                                                                                             |
      | Project Variables Title                   | //h2[contains(.,'Project Variables')]                                                                                                                        |
      | Add to list                               | //button[@title='Add To List']                                                                                                                               |

    And I scroll the "Web site name" text box into view offset by "-300"
    And I highlight outside the "Web site name" text box
    # This is to clear any drop downs left over from the package selection
    And I force focus on the "Web site name" text box if it exists
    And I populate the "Web site name" text box with "RandomQuotes"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}065-octopus-step-website-name.png"
    And I remove the highlight from the "Web site name" text box

    And I scroll the "Application Pool name" text box into view offset by "-300"
    And I highlight outside the "Application Pool name" text box
    And I populate the "Application Pool name" text box with "RandomQuotes"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}070-octopus-step-apppool-name.png"
    And I remove the highlight from the "Application Pool name" text box

    And I scroll the "Remove binding" button into view offset by "-300"
    And I highlight outside the "Remove binding" button
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}075-octopus-step-remove-binding.png"
    And I click the "Remove binding" button
    And I sleep for "1" second

    And I highlight outside the "Add binding" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}080-octopus-step-add-binding.png"
    And I force click the "Add binding" button
    And I remove the highlight from the "Add binding" button

    And I highlight outside the "Port" text box
    And I highlight outside the "OK" button with an offset of "2"
    And I clear the "Port" text box
    And I populate the "Port" text box with "#{IIS Port}"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}085-octopus-step-binding-port.png"
    And I click the "OK" button

    And I scroll the "Enable Anonymous authentication" check box into view offset by "-300"
    And I highlight outside the "Enable Anonymous authentication container" element
    And I highlight outside the "Enable Windows authentication container" element
    And I highlight outside the "Save" button with an offset of "2"
    And I force click the "Enable Anonymous authentication" check box
    And I force click the "Enable Windows authentication" check box
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}090-octopus-step-auth.png"
    And I remove the highlight from the "Enable Anonymous authentication container" element
    And I remove the highlight from the "Enable Windows authentication container" element

  @define-project @applicationspecific @aspnetcore
  Scenario: ASP.NET Core Configure Features
  Configure the JSON Configuration variables section
    Given I set the following aliases:
      | Target files           | //textarea[@name='Target files']        |
      | Target files container | //div[./textarea[@name='Target files']] |

    And I scroll the "Target files" text box into view offset by "-200"
    And I highlight outside the "Target files container" element
    And I populate the "Target files" text box with "appsettings.json"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}092-octopus-target-files.png"
    And I remove the highlight from the "Target files container" element

  @define-project
  Scenario: Save the project
    Given I set the following aliases:
      | Save | //button[contains(.,'Save')] |

    # Sometimes the package selection popover will be fading, resulting in:
    # Element <button type="submit"> is not clickable at point (1660,96) because another element <div> obscures it
    # So we force click
    And I force click the "Save" button
    And I sleep for "3" seconds

    # Give the step time to save
    And I stop recording the screen
    And I sleep for "60" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

  @deploy-project
  Scenario: Deploy project
    And I run the feature "shared/octopus-deploy-project.feature" passing the original arguments

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser