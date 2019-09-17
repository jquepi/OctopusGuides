Feature: Build and deploy a ASP.NET application hosted in Git on a local Octopus instance

  @login
  Scenario: Log into Jenkins
    Given I set the following aliases:
      | Username     | #j_username                                                  |
      | Password     | body > div > div > form > div:nth-child(2) > input           |
      | Sign In      | body > div > div > form > div.submit.formRow > input         |
      | Profile Name | #header > div.login > span > a.model-link.inside.inverse > b |
    And I open the shared browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    When I open the URL "http://localhost:8080"
    # It can take some time for Jenkins to start up, so we need to be able to wait here for the login box
    And I populate the "Username" text box with the text "jenkinsadmin" waiting up to "300" seconds
    And I populate the "Password" text box with the text "Password01!"
    And I click the "Sign In" button
    Then I verify the text from the "Profile Name" element matches the regex "jenkinsadmin"
    And I start recording the screen to the directory "C:\screenshots"

  @plugin-install
  Scenario: Install plugins
    Given I set the following aliases:
      | Manage Jenkins           | //a[@class='task-link' and contains(.,'Manage Jenkins')]                    |
      | Manage Plugins           | #main-panel > div:nth-child(9) > a                                          |
      | Available                | #main-panel > form > div.tabBarFrame > div.tabBar > div:nth-child(2) > a    |
      | Filter                   | #filter-box                                                                 |
      | MSBuild Plugin           | #plugins > tbody > tr:nth-child(6) > td:nth-child(1) > input[type=checkbox] |
      | MSBuild Plugin Container | tr.plugin:nth-child(6) > td:nth-child(1)                                    |
      | Install without restart  | #yui-gen2-button                                                            |
      | Back to top              | //a[contains(.,'Go back to the top page')]                                  |

    And I dump the aliases

    And I highlight outside the "Manage Jenkins" text box
    And I save a screenshot to "C:\screenshots\manage-jenkins.png"
    And I click the "Manage Jenkins" link
    And I scroll the "Manage Plugins" link into view offset by "-100"
    # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Manage Plugins" text box
    And I save a screenshot to "C:\screenshots\manage-plugins.png"
    And I click the "Manage Plugins" link
    And I click the "Available" tab
    And I populate the "Filter" text box with the text "MSBuild"
    And I click the "MSBuild Plugin" checkbox
    And I highlight inside the "Available" tab
    And I highlight outside the "Filter" tab
    And I highlight inside the "MSBuild Plugin Container" element
    And I highlight outside the "Install without restart" button
    And I save a screenshot to "C:\screenshots\msbuild-plugin.png"
    And I click the "Install without restart" button
    And I wait for "5" seconds

    And I highlight outside the "Back to top" link
    And I save a screenshot to "C:\screenshots\plugin-install.png"
    And I click the "Back to top" link

  @configure-tools
  Scenario: Configure tools
    Given I set the following aliases:
      | Manage Jenkins            | //a[@class='task-link' and contains(.,'Manage Jenkins')]                                              |
      | Global Tool Configuration | div.manage-option:nth-child(7) > a:nth-child(1)                                                       |
      | MSBuild Tool              | //button[contains(.,'Add MSBuild')]                                                                   |
      | MSBuild Name              | //input[contains(@checkurl,'/descriptorByName/hudson.plugins.msbuild.MsBuildInstallation/checkName')] |
      | MSBuild Path              | //input[contains(@checkurl,'/descriptorByName/hudson.plugins.msbuild.MsBuildInstallation/checkHome')] |
      | Save                      | //button[contains(.,'Save')]                                                                          |
    And I open the URL "http://localhost:8080/"
    And I highlight outside the "Manage Jenkins" link
    And I click the "Manage Jenkins" link

    And I scroll the "Global Tool Configuration" link into view offset by "-100"
      # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Global Tool Configuration" link
    And I save a screenshot to "C:\screenshots\global-tool-configuration.png"
    And I click the "Global Tool Configuration" link

    And I scroll the "MSBuild Tool" button into view offset by "-100"
    And I highlight outside the "MSBuild Tool" button
    And I save a screenshot to "C:\screenshots\msbuild-global-tool.png"
    And I click the "MSBuild Tool" button
    And I remove the highlight from the "MSBuild Tool" button

    And I highlight inside the "MSBuild Name" text box
    And I highlight inside the "MSBuild Path" text box
    And I highlight outside the "Save" button
    And I populate the "MSBuild Name" text box with "MSBuild"
    And I populate the "MSBuild Path" text box with the text "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin"
    And I save a screenshot to "C:\screenshots\msbuild-settings.png"
    And I click the "Save" button

  @configure-credentials
  Scenario: Configure credentials
    Given I set the following aliases:
      | Manage Jenkins          | //a[@class='task-link' and contains(.,'Manage Jenkins')]               |
      | Configure Credentials   | div.manage-option:nth-child(6) > a:nth-child(1)                        |
      | Credentials             | //a[@href='/credentials'][contains(.,'Credentials')]                   |
      | System                  | //a[@href='/credentials/store/system'][contains(.,'System')]           |
      | Global credentials      | //a[@href='domain/_'][contains(.,'Global credentials (unrestricted)')] |
      | Global credentials cell | .sortable > tbody:nth-child(1) > tr:nth-child(2) > td:nth-child(2)     |
      | Add Credentials         | //a[@href='newCredentials'][contains(.,'Add Credentials')]             |
      | Kind                    | //select[@class='setting-input dropdownList']                          |
      | Secret                  | //input[@name='_.secret']                                              |
      | ID                      | (//input[@name='_.id'])[2]                                             |
      | Description             | (//input[contains(@name,'_.description')])[2]                          |
      | OK                      | //button[@type='button'][contains(.,'OK')]                             |

    And I open the URL "http://localhost:8080/"
    And I highlight outside the "Manage Jenkins" link
    And I click the "Manage Jenkins" link

    And I scroll the "Configure Credentials" link into view offset by "-100"
      # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Configure Credentials" link
    And I save a screenshot to "C:\screenshots\configure-credentials.png"
    And I click the "Configure Credentials" link

    And I highlight outside the "Credentials" link
    And I save a screenshot to "C:\screenshots\credentials-parent.png"
    And I click the "Credentials" link

    And I highlight outside the "System" link
    And I save a screenshot to "C:\screenshots\credentials-system.png"
    And I click the "System" link

    And I highlight outside the "Global credentials cell" link
    And I save a screenshot to "C:\screenshots\global-credentials.png"
    And I click the "Global credentials" link

    And I highlight outside the "Add Credentials" link
    And I save a screenshot to "C:\screenshots\add-credentials.png"
    And I click the "Add Credentials" link

    And I highlight outside the "Kind" drop down list
    And I select the option "Secret text" from the "Kind" drop down list

    And I highlight outside the "Secret" text box with an offset of "0"
    And I highlight outside the "ID" text box with an offset of "0"
    And I highlight outside the "Description" text box with an offset of "0"
    And I highlight outside the "OK" button

    And I populate the "Secret" text box with "OctopusAPIKeyAlias"
    And I populate the "ID" text box with "OctopusAPIKey"
    And I populate the "Description" text box with "The Octopus API Key"
    And I save a screenshot to "C:\screenshots\octopus-credentials.png"
    And I click the "OK" button

  @configure-project
  Scenario: Configure credentials
    Given I set the following aliases:
      | New Item                                                | //a[contains(.,'New Item')]                                                       |
      | Project name                                            | //input[@name='name']                                                             |
      | Freestyle project                                       | .hudson_model_FreeStyleProject                                                    |
      | OK                                                      | //button[@type='submit'][contains(.,'OK')]                                        |
      | Git                                                     | (//label[contains(.,'Git')])[2]                                                   |
      | Repository URL                                          | //input[contains(@name,'_.url')]                                                  |
      | Use secrets                                             | //input[@name='org-jenkinsci-plugins-credentialsbinding-impl-SecretBuildWrapper'] |
      | Bindings Add                                            | //button[@suffix='bindings']                                                      |
      | Secret text                                             | //a[contains(.,'Secret text')]                                                    |
      | Variable                                                | //input[@name='_.variable']                                                       |
      | Credentials                                             | //select[@class='setting-input  select  credentials-select']                      |
      | Add build step                                          | //button[@type='button'][contains(.,'Add build step')]                            |
      | Execute Windows batch command                           | //a[contains(.,'Execute Windows batch command')]                                  |
      | Command                                                 | //textarea[@name='command']                                                       |
      | Save                                                    | //button[@type='button'][contains(.,'Save')]                                      |
      | Build a Visual Studio project or solution using MSBuild | //a[contains(.,'Build a Visual Studio project or solution using MSBuild')]        |
      | MSBuild Version                                         | //select[@name='msBuildBuilder.msBuildName']                                      |
      | MSBuild Build File                                      | //input[@name='msBuildBuilder.msBuildFile']                                       |
      | Command Line Arguments                                  | //textarea[@name='msBuildBuilder.cmdLineArgs']                                    |
      | Command Two                                             | (//textarea[contains(@name,'command')])[2]                                        |

    And I open the URL "http://localhost:8080/"
    And I highlight outside the "New Item" link
    And I save a screenshot to "C:\screenshots\new-item.png"
    And I click the "New Item" link

    And I highlight outside the "Freestyle project" link
    And I highlight outside the "Project name" link
    And I highlight outside the "OK" button
    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "C:\screenshots\freestyle-project.png"
    And I click the "Freestyle project" link
    And I scroll the "OK" button into view
    And I click the "OK" button

    And I scroll the "Git" option into view offset by "-200"
    And I highlight outside the "Git" option
    And I click the "Git" option
    And I highlight outside the "Repository URL" text box
    And I populate the "Repository URL" text box with "https://github.com/OctopusSamples/RandomQuotes-aspmvc4.git"
    And I save a screenshot to "C:\screenshots\git-settings.png"

    And I scroll the "Use secrets" option into view offset by "-200"
    And I highlight outside the "Use secrets" option
    And I click the "Use secrets" option

    And I highlight outside the "Bindings Add" link
    And I save a screenshot to "C:\screenshots\binding-add.png"
    And I click the "Bindings Add" option
    And I highlight outside the "Secret text" link
    And I save a screenshot to "C:\screenshots\secret-text.png"
    And I remove the highlight from the "Bindings Add" option
    And I remove the highlight from the "Use secrets" option
    And I click the "Secret text" link

    And I highlight outside the "Variable" text box
    And I highlight outside the "Credentials" drop down list
    And I populate the "Variable" text box with "OctopusAPIKey"
    And I save a screenshot to "C:\screenshots\credentials-octopusapikey.png"
    And I remove the highlight from the "Variable" text box
    And I remove the highlight from the "Credentials" drop down list

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "C:\screenshots\batch-command-1.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command" text box into view offset by "-200"
    And I highlight outside the "Command" text box
    And I populate the "Command" text box with "C:\ProgramData\chocolatey\bin\nuget.exe restore"
    And I save a screenshot to "C:\screenshots\nuget-restore.png"
    And I remove the highlight from the "Command" text box

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Build a Visual Studio project or solution using MSBuild" link
    And I save a screenshot to "C:\screenshots\msbuild-step-add.png"
    And I click the "Build a Visual Studio project or solution using MSBuild" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Build a Visual Studio project or solution using MSBuild" option

    And I scroll the "MSBuild Version" drop down list into view offset by "-200"
    And I highlight outside the "MSBuild Version" drop down list with an offset of "0"
    And I highlight outside the "MSBuild Build File" text box with an offset of "0"
    And I highlight outside the "Command Line Arguments" text box with an offset of "0"
    And I select the option "MSBuild" from the "MSBuild Version" drop down list
    And I populate the "MSBuild Build File" text box with "RandomQuotes.sln"
    And I populate the "Command Line Arguments" text box with "/p:RunOctoPack=true /p:OctoPackEnforceAddingFiles=true /p:OctoPackPackageVersion=1.0.0.$BUILD_NUMBER"
    And I save a screenshot to "C:\screenshots\msbuild-step.png"
    And I remove the highlight from the "MSBuild Version" drop down list
    And I remove the highlight from the "MSBuild Build File" text box
    And I remove the highlight from the "Command Line Arguments" text box

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "C:\screenshots\batch-command-2.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command Two" text box into view offset by "-200"
    And I highlight outside the "Command Two" text box
    And I populate the "Command Two" text box with "Octo.exe push --server http://localhost --apiKey %OctopusAPIKey% --package .\RandomQuotes\obj\octopacked\RandomQuotes.1.0.0.%BUILD_NUMBER%.nupkg"
    And I save a screenshot to "C:\screenshots\octo-push.png"
    And I remove the highlight from the "Command Two" text box

    And I highlight outside the "Save" button
    And I save a screenshot to "C:\screenshots\project-save.png"
    And I click the "Save" button

  @build-now
  Scenario: Run build
    Given I set the following aliases:
      | Build Now      | //a[contains(.,'Build Now')]      |
      | Build One      | //a[contains(.,'#1')] |
      | Console Output | //a[contains(.,'Console Output')] |

    And I open the URL "http://localhost:8080/job/Random%20Quotes/"
    And I highlight outside the "Build Now" link
    And I save a screenshot to "C:\screenshots\build-now.png"
    And I click the "Build Now" link
    And I remove the highlight from the "Build Now" link
    And I highlight outside the "Build One" link
    And I save a screenshot to "C:\screenshots\build-one.png"
    And I force click the "Build One" link
    And I click the "Console Output" link
    And I scroll down "10000" px
    And I sleep for "45" seconds
    And I save a screenshot to "C:\screenshots\build-logs.png"

  Scenario: Shutdown
    And I close the browser

  @configure-octopus-environments
  Scenario: Create octopus environments
    Then I run the feature "octopus-environments.feature"

  @configure-octopus-project
  Scenario: Create octopus project
    Then I run the feature "octopus-aspnet-project.feature"

  Scenario: Stop recording
    And I stop recording the screen
