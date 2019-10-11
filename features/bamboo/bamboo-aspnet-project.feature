Feature: Configure Bamboo

  Scenario: Login
    Given I set the following aliases:
      | Log in     | (//a[text()='Log in'])[1]            |
      | Username   | //input[@id='loginForm_os_username'] |
      | Password   | //input[@id='loginForm_os_password'] |
      | Log in Two | // input[@id='loginForm_save']       |

    And I open the shared browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:6990/bamboo"
    And I click the "Log in" button
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "admin"
    And I save a screenshot to "c:\screenshots\bamboo\login\010-login.png"
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

    And I scroll the "Administration" button into view
    And I click the "Administration" button
    And I save a screenshot to "c:\screenshots\bamboo\addins\010-administration.png"
    And I click the "Overview" link

    And I scroll the "Find new apps" link into view offset by "-300"
    And I save a screenshot to "c:\screenshots\bamboo\addins\020-find-apps.png"
    And I click the "Find new apps" link
    And I populate the "Search the Marketplace" text box with "Octopus"
    And I sleep for "2" second
    And I press the enter key from the "Search the Marketplace" text box
    And I sleep for "5" seconds
    And I save a screenshot to "c:\screenshots\bamboo\addins\030-octopus-addin.png"
    And I click the "Install" button
    And I sleep for "5" seconds
    And I save a screenshot to "c:\screenshots\bamboo\addins\040-accept.png"
    And I click the "Accept & install" button
    Then I verify the "Installed and ready to go!" title is present
    And I save a screenshot to "c:\screenshots\bamboo\addins\050-installed.png"
    And I click the "Close" button

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
      | Capability type     | //select[@id='addCapability_capabilityType']          |
      | Type                | //select[@id='executableTypeSelect']                  |
      | Executable label    | //input[@id='addCapability_builderLabel']             |
      | Executable path     | //input[@id='addCapability_builderPath']              |
      | Add                 | //input[@id='addCapability_save']                     |

    And I click the "Close dialog" button waiting up to "5" seconds if it exists

    And I scroll the "Administration" button into view
    And I click the "Administration" button
    And I save a screenshot to "c:\screenshots\bamboo\executables\010-administration.png"
    And I click the "Overview" link

    And I save a screenshot to "c:\screenshots\bamboo\executables\020-server-capabilities.png"
    And I click the "Server capabilities" link

    And I scroll the "Git" link into view offset by "-300"
    And I save a screenshot to "c:\screenshots\bamboo\executables\030-git.png"
    And I click the "Git" link
    And I click the "Edit" link

    And I clear the "Path" text box
    And I populate the "Path" text box with "C:\Program Files\Git\cmd\git.exe"
    And I save a screenshot to "c:\screenshots\bamboo\executables\040-path.png"
    And I click the "Update" button

    And I click the "Server capabilities" link

    And I scroll the "Capability type" drop down list into view offset by "-300"
    And I select the option "Executable" from the "Capability type" drop down list
    And I select the option "MSBuild" from the "Type" drop down list
    And I populate the "Executable label" text box with "MSBuild 2017"
    And I populate the "Executable path" text box with "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\msbuild.exe"
    And I scroll the "Add" button into view offset by "-300"
    And I save a screenshot to "c:\screenshots\bamboo\executables\050-msbuild.png"
    And I click the "Add" button

    And I scroll the "Capability type" drop down list into view offset by "-300"
    And I select the option "Executable" from the "Capability type" drop down list
    And I select the option "Octopus CLI" from the "Type" drop down list
    And I populate the "Executable label" text box with "Octopus CLI"
    And I populate the "Executable path" text box with "C:\ProgramData\chocolatey\bin\Octo.exe"
    And I scroll the "Add" button into view offset by "-300"
    And I save a screenshot to "c:\screenshots\bamboo\executables\060-octo.png"
    And I click the "Add" button

  Scenario: Add project
    Given I set the following aliases:
      | My Bamboo                          | //a[@id='myBamboo']                                                                            |
      | Create your first build plan       | //a[@id='create-a-plan']                                                                       |
      | Project name                       | //input[@id='projectName']                                                                     |
      | Plan name                          | //input[@id='chainName']                                                                       |
      | Repository host                    | //a[@id='repository-other']                                                                    |
      | Git                                | //a[@href='#com.atlassian.bamboo.plugins.atlassian-bamboo-plugin-git:gitv2']                   |
      | Display name                       | //input[@id='createPlan_repositoryName']                                                       |
      | Repository URL                     | //input[@id='createPlan_repository_git_repositoryUrl']                                         |
      | Test connection                    | //button[@id='test-connection-com-atlassian-bamboo-plugins-atlassian-bamboo-plugin-git-gitv2'] |
      | Connection successful              | //p[text()='Connection successful']                                                            |
      | Configure plan                     | //input[@id='createPlan_save']                                                                 |
      | Add task                           | //a[@id='addTask']                                                                             |
      | Search                             | //h2[contains(.,'Task types')]//input                                                          |
      | MSBuild Tile                       | //li[.//h3[normalize-space(text())='MSBuild']]                                                 |
      | Script Tile                        | //li[.//h3[normalize-space(text())='Script']]                                                  |
      | Octopus Deploy: Push Packages Tile | //li[.//h3[normalize-space(text())='Octopus Deploy: Push Packages']]                           |
      | Task description                   | //input[@id='createTask_userDescription']                                                      |
      | Solution                           | //input[@id='solution']                                                                        |
      | Options                            | //input[@id='options']                                                                         |
      | Save                               | //input[@id='createTask_save']                                                                 |
      | Create                             | //button[@id='createPlan']                                                                     |
      | Build one                          | //a[@href='/bamboo/browse/RQ-WEB-1']                                                           |
      | Interpreter                        | //select[@id='interpreter']                                                                    |
      | Script body                        | //div[@id='scriptBody']/textarea                                                               |
      | Server URL                         | //input[@id='serverUrl']                                                                       |
      | API key                            | //input[@id='apiKey']                                                                          |
      | Package paths                      | //textarea[@id='pushPattern']                                                                  |

    And I save a screenshot to "c:\screenshots\bamboo\initialproject\010-mybamboo.png"
    And I click the "My Bamboo" link

    And I save a screenshot to "c:\screenshots\bamboo\initialproject\020-create-build-plan.png"
    And I click the "Create your first build plan" button

    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\030-project-name.png"

    And I populate the "Plan name" text box with "Website"
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\040-plan-name.png"

    And I scroll the "Repository host" drop down list into view offset by "-300"
    And I click the "Repository host" drop down list

    And I scroll the "Git" option into view offset by "-300"
    And I click the "Git" option
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\050-git.png"

    And I scroll the "Display name" text box into view offset by "-300"
    And I populate the "Display name" text box with "Random Quotes GitHub"
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\060-display-name.png"

    And I scroll the "Repository URL" text box into view offset by "-300"
    And I populate the "Repository URL" text box with "https://github.com/OctopusSamples/RandomQuotes-aspmvc4.git"
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\070-repo-url.png"

    And I scroll the "Test connection" button into view offset by "-300"
    And I scroll the "Test connection" button into view
    And I click the "Test connection" button
    Then I verify the "Connection successful" message is present
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\080-test-connection.png"

    And I scroll the "Configure plan" button into view
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\090-configure-plan.png"
    And I click the "Configure plan" button

    And I scroll the "Add task" button into view
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\100-add-task.png"
    And I click the "Add task" button

    And I populate the "Search" box with "Script"
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\110-search.png"
    And I click the "Script Tile" element

    And I populate the "Task description" text box with "NuGet Restore"
    And I select the option "Windows PowerShell" from the "Interpreter" drop down list
    And I run the following JavaScript:
      """
      ace.edit(scriptBody).setValue("$ErrorActionPreference=\"SilentlyContinue\"\nC:\\ProgramData\\chocolatey\\bin\\nuget.exe restore")
      """
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\115-nuget-restore.png"
    And I scroll the "Save" button into view
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\120-nuget-restore.png"
    And I click the "Save" button

    And I scroll the "Add task" button into view
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\130-add-task.png"
    And I click the "Add task" button

    And I populate the "Search" box with "MSBuild"
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\140-search.png"
    And I click the "MSBuild Tile" element

    And I populate the "Task description" text box with "Build"
    And I clear the "Solution" text box
    And I populate the "Solution" text box with "RandomQuotes.sln"
    And I populate the "Options" text box with "/p:RunOctoPack=true /p:OctoPackPackageVersion=1.0.${bamboo.buildNumber} /p:OctoPackEnforceAddingFiles=true"
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\145-msbuild.png"
    And I scroll the "Save" button into view
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\150-msbuild.png"
    And I click the "Save" button

    And I scroll the "Add task" button into view
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\160-add-task.png"
    And I click the "Add task" button

    And I populate the "Search" box with "Octopus"
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\170-search.png"
    And I click the "Octopus Deploy: Push Packages Tile" element

    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Push to Octopus"
    And I scroll the "Server URL" text box into view offset by "-300"
    And I clear the "Server URL" text box
    And I populate the "Server URL" text box with "http://localhost"
    And I scroll the "API key" text box into view offset by "-300"
    And I populate the "API key" text box with "ExternalOctopusAPIKey"
    And I scroll the "Package paths" text box into view offset by "-300"
    And I populate the "Package paths" text box with "RandomQuotes/obj/octopacked/RandomQuotes.1.0.${bamboo.buildNumber}.nupkg"
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\175-octo-push.png"
    And I scroll the "Save" button into view
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\180-octo-push.png"
    And I click the "Save" button

    And I save a screenshot to "c:\screenshots\bamboo\initialproject\190-create.png"
    And I click the "Create" button
    And I sleep for "5" seconds

    And I save a screenshot to "c:\screenshots\bamboo\initialproject\200-build-one.png"
    And I click the "Build one" link

    And I sleep for "60" seconds
    And I save a screenshot to "c:\screenshots\bamboo\initialproject\210-build-results.png"