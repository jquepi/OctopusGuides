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

    And I click the "Administration" button
    And I save a screenshot to "c:\screenshots\bamboo\addins\010-administration.png"
    And I click the "Overview" link

    And I scroll the "Find new apps" link into view offset by "-300"
    And I save a screenshot to "c:\screenshots\bamboo\addins\020-find-apps.png"
    And I click the "Find new apps" link
    And I populate the "Search the Marketplace" text box with "Octopus"
    And I sleep for "1" second
    And I press the enter key from the "Search the Marketplace" text box
    And I sleep for "5" seconds
    And I save a screenshot to "c:\screenshots\bamboo\addins\030-octopus-addin.png"
    And I click the "Install" button
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

    And I click the "Administration" button
    And I save a screenshot to "c:\screenshots\bamboo\executables\010-administration.png"
    And I click the "Overview" link

    And I save a screenshot to "c:\screenshots\bamboo\executables\020-server-capabilities.png"
    And I click the "Server capabilities" link

    And I save a screenshot to "c:\screenshots\bamboo\executables\030-git.png"
    And I scroll the "Git" link into view offset by "-300"
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
    And I click the "Add" button

    And I scroll the "Capability type" drop down list into view offset by "-300"
    And I select the option "Executable" from the "Capability type" drop down list
    And I select the option "Octopus CLI" from the "Type" drop down list
    And I populate the "Executable label" text box with "Octopus CLI"
    And I populate the "Executable path" text box with "C:\ProgramData\chocolatey\bin\Octo.exe"
    And I scroll the "Add" button into view offset by "-300"
    And I click the "Add" button

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
      | Add task                     | //a[@id='addTask']                                                                             |
      | Search                       | //h2[contains(.,'Task types')]//input                                                          |
      | MSBuild Tile                 | //a[@title='MSBuild']                                                                          |
      | Script Tile                  | //a[@title='Script']                                                                           |
      | Task description             | //input[@id='createTask_userDescription']                                                      |
      | Solution                     | //input[@id='solution']                                                                        |
      | Options                      | //input[@id='options']                                                                         |
      | Save                         | //input[@id='createTask_save']                                                                 |
      | Create                       | //input[@id='createPlan']                                                                      |
      | Build one                    | //a[@href='/bamboo/browse/RQ-WEB-1']                                                           |
      | Interpreter                  | //select[@id='interpreter']                                                                    |
      | Script body                  | //div[@id='scriptBody']/textarea                                                               |

    And I click the "My Bamboo" link
    And I click the "Create your first build plan" button
    And I populate the "Project name" text box with "Random Quotes"
    And I populate the "Plan name" text box with "Website"

    And I scroll the "Repository host" drop down list into view offset by "-300"
    And I click the "Repository host" drop down list

    And I scroll the "Git" option into view offset by "-300"
    And I click the "Git" option

    And I scroll the "Display name" text box into view offset by "-300"
    And I populate the "Display name" text box with "Random Quotes GitHub"

    And I scroll the "Repository URL" text box into view offset by "-300"
    And I populate the "Repository URL" text box with "https://github.com/OctopusSamples/RandomQuotes-aspmvc4.git"

    And I scroll the "Test connection" button into view offset by "-300"
    And I scroll the "Test connection" button into view
    And I click the "Test connection" button
    Then I verify the "Connection successful" message is present

    And I scroll the "Configure plan" button into view
    And I click the "Configure plan" button

    And I scroll the "Add task" button into view
    And I click the "Add task" button
    And I populate the "Search" box with "Script"
    And I click the "Script Tile" element

    And I populate the "Task description" text box with "NuGet Restore"
    And I select the option "Windows PowerShell" from the "Interpreter" drop down list
    And I populate the "Script body" text box with "C:\ProgramData\chocolatey\bin\nuget.exe restore"
    And I scroll the "Save" button into view
    And I click the "Save" button

    And I scroll the "Add task" button into view
    And I click the "Add task" button
    And I populate the "Search" box with "MSBuild"
    And I click the "MSBuild Tile" element

    And I populate the "Task description" text box with "Build"
    And I clear the "Solution" text box
    And I populate the "Solution" text box with "RandomQuotes.sln"
    And I populate the "Options" text box with "/p:RunOctoPack=true /p:OctoPackPackageVersion=1.0.${bamboo.buildNumber} /p:OctoPackEnforceAddingFiles=true"
    And I click the "Save" button

    And I click the "Create" button
    And I click the "Build one" link