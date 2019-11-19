Feature: Configure Bamboo

  Scenario: Login
    Given I set the following aliases:
      | Log in     | (//a[text()='Log in'])[1]            |
      | Username   | //input[@id='loginForm_os_username'] |
      | Password   | //input[@id='loginForm_os_password'] |
      | Log in Two | // input[@id='loginForm_save']       |

    And I open the shared browser "ExternalBrowserType"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:6990/bamboo"
    And I click the "Log in" button
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "admin"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/login/010-login.png"
    And I click the "Log in Two" button

  @add-plugins
  Scenario: Add plugins
    Given I set the following aliases:
      | Close dialog               | //span[@class='aui-icon icon-close']                       |
      | Administration             | //span[contains(.,'Administration')]                       |
      | Overview                   | //a[contains(.,'Overview')]                                |
      | Find new apps              | //a[contains(.,'Find new apps')]                           |
      | Search the Marketplace     | //input[@id='upm-install-search-box']                      |
      | Install                    | //a[contains(.,'Install')]                                 |
      | Accept & install           | //button[normalize-space(text())='Accept & install']       |
      | Installed and ready to go! | //h2[normalize-space(text())='Installed and ready to go!'] |
      | Close                      | //button[text()='Close']                                   |

    And I click the "Close dialog" button waiting up to "5" seconds if it exists
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I display a note with the text "Installing the Bamboo add ons" for "3" seconds

    And I scroll the "Administration" button into view
    And I click the "Administration" button
    And I highlight inside the "Administration" button
    And I highlight outside the "Overview" link
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/addins/#{GuideSpecificScreenshotDir}010-administration.png"
    And I click the "Overview" link

    And I scroll the "Find new apps" link into view offset by "-300"
    And I highlight outside the "Find new apps" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/addins/#{GuideSpecificScreenshotDir}020-find-apps.png"
    And I click the "Find new apps" link

    And I stop recording the screen
    And I refresh the page if the "Search the Marketplace" text box does not exist
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I populate the "Search the Marketplace" text box with "Octopus"
    And I highlight outside the "Search the Marketplace" text box with an offset of "5"
    And I sleep for "2" second
    And I press the enter key from the "Search the Marketplace" text box
    And I sleep for "5" seconds

    And I highlight outside the "Install" button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/addins/#{GuideSpecificScreenshotDir}030-octopus-addin.png"
    And I click the "Install" button
    And I remove the highlight from the "Search the Marketplace" text box
    And I sleep for "5" seconds

    And I highlight outside the "Accept & install" button with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/addins/#{GuideSpecificScreenshotDir}040-accept.png"
    And I click the "Accept & install" button

    And I highlight outside the "Close" button
    Then I verify the "Installed and ready to go!" title is present
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/addins/#{GuideSpecificScreenshotDir}050-installed.png"
    And I click the "Close" button
    And I stop recording the screen

  @executables
  Scenario: Configure Git
    Given I set the following aliases:
      | Close dialog        | //span[@class='aui-icon icon-close']                  |
      | Administration      | //span[contains(.,'Administration')]                  |
      | Overview            | //a[contains(.,'Overview')]                           |
      | Server capabilities | //a[contains(.,'Server capabilities')]                |
      | Git                 | //a[contains(.,'Git')]                                |
      | Edit                | //a[contains(.,'Edit')]                               |
      | Path                | //input[@id='updateSharedCapability_capabilityValue'] |
      | Update              | //input[@id='updateSharedCapability_save']            |

    And I click the "Close dialog" button waiting up to "5" seconds if it exists

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Configuring the executables" for "3" seconds

    And I scroll the "Administration" button into view
    And I click the "Administration" button
    And I highlight inside the "Administration" button
    And I highlight outside the "Overview" link
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}010-administration.png"
    And I click the "Overview" link

    And I highlight outside the "Server capabilities" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}020-server-capabilities.png"
    And I click the "Server capabilities" link

    And I scroll the "Git" link into view offset by "-300"
    And I highlight outside the "Git" link
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}030-git.png"
    And I click the "Git" link

    And I highlight outside the "Edit" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}035-edit.png"
    And I click the "Edit" link

    And I clear the "Path" text box
    And I populate the "Path" text box with "C:\Program Files\Git\cmd\git.exe"
    And I highlight outside the "Path" text box with an offset of "2"
    And I highlight outside the "Update" button with an offset of "2"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}040-path.png"
    And I click the "Update" button

    And I click the "Server capabilities" link

  @executables @applicationspecific @aspnet
  Scenario: Configure MSBuild
    Given I set the following aliases:
      | Capability type  | //select[@id='addCapability_capabilityType'] |
      | Type             | //select[@id='executableTypeSelect']         |
      | Executable label | //input[@id='addCapability_builderLabel']    |
      | Executable path  | //input[@id='addCapability_builderPath']     |
      | Add              | //input[@id='addCapability_save']            |

    And I scroll the "Capability type" drop down list into view offset by "-300"
    And I select the option "Executable" from the "Capability type" drop down list
    And I select the option "MSBuild" from the "Type" drop down list
    And I populate the "Executable label" text box with "MSBuild 2017"
    And I populate the "Executable path" text box with "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\msbuild.exe"
    And I scroll the "Add" button into view offset by "-300"

    And I highlight outside the "Capability type" drop down list with an offset of "2"
    And I highlight outside the "Type" drop down list with an offset of "2"
    And I highlight outside the "Executable label" text box with an offset of "2"
    And I highlight outside the "Executable path" text box with an offset of "5"
    And I highlight outside the "Add" button with an offset of "5"

    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}050-msbuild.png"
    And I click the "Add" button

  @executables
  Scenario: Configure Octo CLI
    Given I set the following aliases:
      | Capability type  | //select[@id='addCapability_capabilityType'] |
      | Type             | //select[@id='executableTypeSelect']         |
      | Executable label | //input[@id='addCapability_builderLabel']    |
      | Executable path  | //input[@id='addCapability_builderPath']     |
      | Add              | //input[@id='addCapability_save']            |

    And I scroll the "Capability type" drop down list into view offset by "-300"
    And I select the option "Executable" from the "Capability type" drop down list
    And I select the option "Octopus CLI" from the "Type" drop down list
    And I populate the "Executable label" text box with "Octopus CLI"
    And I populate the "Executable path" text box with "C:\ProgramData\chocolatey\bin\Octo.exe"
    And I scroll the "Add" button into view offset by "-300"

    And I highlight outside the "Capability type" drop down list with an offset of "2"
    And I highlight outside the "Type" drop down list with an offset of "2"
    And I highlight outside the "Executable label" text box with an offset of "2"
    And I highlight outside the "Executable path" text box with an offset of "5"
    And I highlight outside the "Add" button with an offset of "5"

    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}060-octo.png"
    And I click the "Add" button

    And I stop recording the screen

  Scenario: Add project
    Given I set the following aliases:
      | My Bamboo                    | //a[@id='myBamboo']                                                                            |
      | Create your first build plan | //a[@id='create-a-plan']                                                                       |
      | Project name                 | //input[@id='projectName']                                                                     |
      | Plan name                    | //input[@id='chainName']                                                                       |
      | Repository host              | //a[@id='repository-other']                                                                    |
      | Git                          | //a[@href='#com.atlassian.bamboo.plugins.atlassian-bamboo-plugin-git:gitv2']                   |
      | Display name                 | //input[@id='createPlan_repositoryName']                                                       |
      | Repository URL               | //input[@id='createPlan_repository_git_repositoryUrl']                                         |
      | Test connection              | //button[@id='test-connection-com-atlassian-bamboo-plugins-atlassian-bamboo-plugin-git-gitv2'] |
      | Connection successful        | //p[text()='Connection successful']                                                            |
      | Configure plan               | //input[@id='createPlan_save']                                                                 |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating the build project" for "3" seconds

    And I highlight inside the "My Bamboo" link
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}010-mybamboo.png"
    And I click the "My Bamboo" link

    And I highlight outside the "Create your first build plan" button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}020-create-build-plan.png"
    And I click the "Create your first build plan" button

    And I highlight outside the "Project name" text box with an offset of "5"
    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}030-project-name.png"

    And I highlight outside the "Plan name" text box with an offset of "5"
    And I populate the "Plan name" text box with "Website"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}040-plan-name.png"
    And I remove the highlight from the "Project name" text box
    And I remove the highlight from the "Plan name" text box

    And I highlight outside the "Repository host" drop down list
    And I scroll the "Repository host" drop down list into view offset by "-300"
    And I click the "Repository host" drop down list

    And I scroll the "Git" option into view offset by "-300"
    And I highlight outside the "Git" option with an offset of "0"
    And I click the "Git" option
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}050-git.png"

    And I highlight outside the "Display name" text box with an offset of "0"
    And I scroll the "Display name" text box into view offset by "-300"
    And I populate the "Display name" text box with "Random Quotes GitHub"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}060-display-name.png"

    And I highlight outside the "Repository URL" text box with an offset of "5"
    And I scroll the "Repository URL" text box into view offset by "-300"
    And I populate the "Repository URL" text box with "GitUrl"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}070-repo-url.png"
    And I remove the highlight from the "Git" option
    And I remove the highlight from the "Display name" text box
    And I remove the highlight from the "Repository URL" text box

    And I highlight outside the "Test connection" button
    And I scroll the "Test connection" button into view offset by "-300"
    And I scroll the "Test connection" button into view
    And I click the "Test connection" button
    Then I verify the "Connection successful" message is present
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}080-test-connection.png"

    And I highlight outside the "Configure plan" button
    And I scroll the "Configure plan" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}090-configure-plan.png"
    And I click the "Configure plan" button

    And I stop recording the screen

  @applicationspecific @aspnetcore
  Scenario: ASP.NET Core Add tasks
    Given I set the following aliases:
      | Add task                          | //a[@id='addTask']                                                                                          |
      | Search                            | //h2[contains(.,'Task types')]//input                                                                       |
      | Script Tile                       | //li[.//div[@class='task-type-description']][.//h3[normalize-space(text())='Script']]                       |
      | Task description                  | //input[@id='createTask_userDescription']                                                                   |
      | Solution                          | //input[@id='solution']                                                                                     |
      | Options                           | //input[@id='options']                                                                                      |
      | Save                              | //input[@id='createTask_save']                                                                              |
      | Interpreter                       | //select[@id='interpreter']                                                                                 |
      | Script body                       | //div[@id='scriptBody']                                                                                     |
      | Octopus Deploy: Pack Package Tile | //li[.//div[@class='task-type-description']][.//h3[normalize-space(text())='Octopus Deploy: Pack Package']] |
      | Package ID                        | //input[@id='packId']                                                                                       |
      | Version number                    | //input[@id='packVersion']                                                                                  |
      | NuGet Package format              | //input[@id='packFormatnuget']                                                                              |
      | Package include paths             | //textarea[@id='packInclude']                                                                               |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    # dotnet test script task
    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}100-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Script"
    And I highlight inside the "Script Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}110-search.png"
    And I click the "Script Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Dotnet Test"

    And I highlight outside the "Interpreter" text box
    And I scroll the "Interpreter" drop down list into view offset by "-300"
    And I select the option "Windows PowerShell" from the "Interpreter" drop down list

    And I highlight inside the "Script body" text box
    And I scroll the "Script body" text area into view offset by "-300"
    And I run the following JavaScript:
      """
      ace.edit(scriptBody).setValue("dotnet test")
      """
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}120-dotnet-test.png"
    And I remove the highlight from the "Script body" text box

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}130-dotnet-test.png"
    And I click the "Save" button

    # dotnet publish script task
    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}140-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Script"
    And I highlight inside the "Script Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}150-search.png"
    And I click the "Script Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Dotnet Publish"

    And I highlight outside the "Interpreter" text box
    And I scroll the "Interpreter" drop down list into view offset by "-300"
    And I select the option "Windows PowerShell" from the "Interpreter" drop down list

    And I highlight inside the "Script body" text box
    And I scroll the "Script body" text area into view offset by "-300"
    And I run the following JavaScript:
      """
      ace.edit(scriptBody).setValue("dotnet publish -c Release")
      """
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}160-dotnet-publish.png"
    And I remove the highlight from the "Script body" text box

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}170-dotnet-publish.png"
    And I click the "Save" button

    # Pack package step
    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}180-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Octopus"
    And I highlight inside the "Octopus Deploy: Pack Package Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}190-search.png"
    And I click the "Octopus Deploy: Pack Package Tile" element

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "RandomQuotes"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}200-octo-pack.png"

    And I scroll the "Version number" text box into view offset by "-300"
    And I highlight outside the "Version number" text box
    And I populate the "Version number" text box with "1.0.${bamboo.buildNumber}"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}210-octo-pack.png"

    And I scroll the "NuGet Package format" radio button into view offset by "-300"
    And I highlight outside the "NuGet Package format" radio button
    And I click the "NuGet Package format" radio button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}220-octo-pack.png"

    And I scroll the "Package include paths" text box into view offset by "-300"
    And I highlight outside the "Package include paths" text box
    And I populate the "Package include paths" text box with "RandomQuotes\bin\Release\netcoreapp2.2\publish\"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}230-octo-pack.png"

    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}240-octo-pack.png"
    And I click the "Save" button

  @applicationspecific @aspnet
  Scenario: ASP.NET Add tasks
    Given I set the following aliases:
      | Add task         | //a[@id='addTask']                                                                     |
      | Search           | //h2[contains(.,'Task types')]//input                                                  |
      | Script Tile      | //li[.//div[@class='task-type-description']][.//h3[normalize-space(text())='Script']]  |
      | MSBuild Tile     | //li[.//div[@class='task-type-description']][.//h3[normalize-space(text())='MSBuild']] |
      | Task description | //input[@id='createTask_userDescription']                                              |
      | Solution         | //input[@id='solution']                                                                |
      | Options          | //input[@id='options']                                                                 |
      | Save             | //input[@id='createTask_save']                                                         |
      | Interpreter      | //select[@id='interpreter']                                                            |
      | Script body      | //div[@id='scriptBody']                                                                |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}100-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Script"
    And I highlight inside the "Script Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}110-search.png"
    And I click the "Script Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "NuGet Restore"

    And I highlight outside the "Interpreter" text box
    And I scroll the "Interpreter" drop down list into view offset by "-300"
    And I select the option "Windows PowerShell" from the "Interpreter" drop down list

    And I highlight inside the "Script body" text box
    And I scroll the "Script body" text area into view offset by "-300"
    And I run the following JavaScript:
      """
      ace.edit(scriptBody).setValue("$ErrorActionPreference=\"SilentlyContinue\"\nC:\\ProgramData\\chocolatey\\bin\\nuget.exe restore")
      """
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}115-nuget-restore.png"
    And I remove the highlight from the "Script body" text box

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}120-nuget-restore.png"
    And I click the "Save" button

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}130-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "MSBuild"
    And I highlight inside the "MSBuild Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}140-search.png"
    And I click the "MSBuild Tile" element

    And I highlight outside the "Task description" text box with an offset of "5"
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Build"

    And I highlight outside the "Solution" text box with an offset of "5"
    And I scroll the "Solution" text box into view offset by "-300"
    And I clear the "Solution" text box
    And I populate the "Solution" text box with "RandomQuotes.sln"

    And I highlight outside the "Options" text box with an offset of "5"
    And I scroll the "Options" text box into view offset by "-300"
    And I populate the "Options" text box with "/p:RunOctoPack=true /p:OctoPackPackageVersion=1.0.${bamboo.buildNumber} /p:OctoPackEnforceAddingFiles=true"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}145-msbuild.png"
    And I remove the highlight from the "Solution" text box
    And I remove the highlight from the "Options" text box

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}150-msbuild.png"
    And I click the "Save" button

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}151-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Script"
    And I highlight inside the "Script Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}152-search.png"
    And I click the "Script Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Run Tests"

    And I highlight outside the "Interpreter" text box
    And I scroll the "Interpreter" drop down list into view offset by "-300"
    And I select the option "Windows PowerShell" from the "Interpreter" drop down list

    And I highlight inside the "Script body" text box
    And I scroll the "Script body" text area into view offset by "-300"
    And I run the following JavaScript:
      """
      ace.edit(scriptBody).setValue(".\\packages\\NUnit.ConsoleRunner.3.10.0\\tools\\nunit3-console.exe `\n.\\RandomQuotes.Tests\\bin\\Debug\\RandomQuotes.Tests.dll")
      """
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}153-run-tests.png"
    And I remove the highlight from the "Script body" text box

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}154-run-tests.png"
    And I click the "Save" button

  @repositoryspecific @octo-built-in-feed
  Scenario: Add Octopus Push
    Given I set the following aliases:
      | Add task                           | //a[@id='addTask']                                                                                           |
      | Octopus Deploy: Push Packages Tile | //li[.//div[@class='task-type-description']][.//h3[normalize-space(text())='Octopus Deploy: Push Packages']] |
      | Search                             | //h2[contains(.,'Task types')]//input                                                                        |
      | Task description                   | //input[@id='createTask_userDescription']                                                                    |
      | Server URL                         | //input[@id='serverUrl']                                                                                     |
      | API key                            | //input[@id='apiKey']                                                                                        |
      | Package paths                      | //textarea[@id='pushPattern']                                                                                |
      | Save                               | //input[@id='createTask_save']                                                                               |

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}160-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Octopus"
    And I highlight inside the "Octopus Deploy: Push Packages Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}170-search.png"
    And I click the "Octopus Deploy: Push Packages Tile" element

    And I highlight outside the "Task description" text box with an offset of "5"
    And I highlight outside the "Server URL" text box with an offset of "5"
    And I highlight outside the "API key" text box with an offset of "5"

    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Push to Octopus"
    And I scroll the "Server URL" text box into view offset by "-300"
    And I clear the "Server URL" text box
    And I populate the "Server URL" text box with "http://localhost"
    And I scroll the "API key" text box into view offset by "-300"
    And I populate the "API key" text box with "ExternalOctopusAPIKey"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}173-octo-push.png"

    And I highlight outside the "Package paths" text box with an offset of "5"
    And I highlight outside the "Save" button
    And I scroll the "Package paths" text box into view offset by "-200"
    And I populate the "Package paths" text box with "#{NugetPath}RandomQuotes.1.0.${bamboo.buildNumber}.nupkg"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}175-octo-push.png"
    And I remove the highlight from the "Package paths" text box

    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}180-octo-push.png"
    And I click the "Save" button
    And I stop recording the screen

  @repositoryspecific @artifactory
  Scenario: Add Octopus Push
    Given I set the following aliases:
      | Add task         | //a[@id='addTask']                                                                    |
      | Script Tile      | //li[.//div[@class='task-type-description']][.//h3[normalize-space(text())='Script']] |
      | Search           | //h2[contains(.,'Task types')]//input                                                 |
      | Task description | //input[@id='createTask_userDescription']                                             |
      | Interpreter      | //select[@id='interpreter']                                                           |
      | Script body      | //div[@id='scriptBody']                                                               |
      | Save             | //input[@id='createTask_save']                                                        |

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}160-add-task-nuget-push.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Script"
    And I highlight inside the "Script Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}170-search-nuget-push.png"
    And I click the "Script Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "NuGet Push"

    And I highlight outside the "Interpreter" text box
    And I scroll the "Interpreter" drop down list into view offset by "-300"
    And I select the option "Windows PowerShell" from the "Interpreter" drop down list

    And I highlight inside the "Script body" text box
    And I scroll the "Script body" text area into view offset by "-300"
    And I run the following JavaScript:
      """
      ace.edit(scriptBody).setValue("C:\\ProgramData\\chocolatey\\bin\\nuget.exe push `\n-Source Artifactory `\n#{NugetPath}RandomQuotes.1.0.${bamboo.buildNumber}.nupkg")
      """
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}180-nuget-push.png"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}190-nuget-push.png"
    And I click the "Save" button
    And I stop recording the screen

  @repositoryspecific @artifactory
  Scenario: Create plan
    Given I set the following aliases:
      | Create    | //button[@id='createPlan']               |
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Create" button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}190-create-artifactory.png"
    And I click the "Create" button
    And I sleep for "5" seconds

  @repositoryspecific @octo-built-in-feed
  Scenario: Create plan
    Given I set the following aliases:
      | Create    | //button[@id='createPlan']               |
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Create" button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}190-create-builtinfeed.png"
    And I click the "Create" button
    And I sleep for "5" seconds

  Scenario: Create plan
    Given I set the following aliases:
      | Build one | //a[@href='/bamboo/browse/RQ-WEB-1']     |
      | Logs      | //a[@href='/bamboo/browse/RQ-WEB-1/log'] |
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Build one" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}200-build-one.png"
    And I click the "Build one" link
    And I click the "Logs" link
    And I sleep for "10" seconds
    And I scroll down "10000" px
    And I sleep for "50" seconds
    And I stop recording the screen
    And I sleep for "120" seconds
    And I scroll down "10000" px
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}210-build-results.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser