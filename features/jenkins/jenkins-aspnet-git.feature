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
    #And I set the window size to "1024" x "768"
    When I open the URL "http://localhost:8080"
    # It can take some time for Jenkins to start up, so we need to be able to wait here for the login box
    And I populate the "Username" text box with the text "jenkinsadmin" waiting up to "600" seconds
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

    And I display a note with the text "Installing the Jenkins plugins" for "3" seconds

    And I highlight inside the "Manage Jenkins" text box
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\005-manage-jenkins.png"
    And I click the "Manage Jenkins" link
    And I scroll the "Manage Plugins" link into view offset by "-100"
    # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Manage Plugins" text box
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\010-manage-plugins.png"
    And I click the "Manage Plugins" link
    And I click the "Available" tab
    And I populate the "Filter" text box with the text "MSBuild"
    And I click the "MSBuild Plugin" checkbox
    And I highlight inside the "Available" tab
    And I highlight outside the "Filter" tab
    And I highlight inside the "MSBuild Plugin Container" element
    And I highlight outside the "Install without restart" button
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\015-msbuild-plugin.png"
    And I click the "Install without restart" button
    And I wait for "5" seconds

    And I highlight outside the "Back to top" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\020-plugin-install.png"
    # fake a click
    And I open the URL "http://localhost:8080/"

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

    And I display a note with the text "Configuring the MSBuild tool" for "3" seconds

    And I highlight inside the "Manage Jenkins" link
    And I click the "Manage Jenkins" link

    And I scroll the "Global Tool Configuration" link into view offset by "-100"
      # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Global Tool Configuration" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\025-global-tool-configuration.png"
    And I click the "Global Tool Configuration" link

    And I scroll the "MSBuild Tool" button into view offset by "-100"
    And I highlight outside the "MSBuild Tool" button
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\030-msbuild-global-tool.png"
    And I click the "MSBuild Tool" button
    And I remove the highlight from the "MSBuild Tool" button

    And I highlight inside the "MSBuild Name" text box
    And I highlight inside the "MSBuild Path" text box
    And I highlight outside the "Save" button
    And I populate the "MSBuild Name" text box with "MSBuild"
    And I populate the "MSBuild Path" text box with the text "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin"
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\035-msbuild-settings.png"
    And I click the "Save" button

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

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
    And I clear the transition

    And I display a note with the text "Adding the Octopus API key as a Jenkins secret" for "3" seconds

    And I highlight inside the "Manage Jenkins" link
    And I click the "Manage Jenkins" link

    And I scroll the "Configure Credentials" link into view offset by "-100"
      # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Configure Credentials" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\040-configure-credentials.png"
    And I click the "Configure Credentials" link

    And I highlight inside the "Credentials" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\045-credentials-parent.png"
    And I click the "Credentials" link

    And I highlight inside the "System" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\050-credentials-system.png"
    And I click the "System" link

    And I highlight outside the "Global credentials cell" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\055-global-credentials.png"
    And I click the "Global credentials" link

    And I highlight inside the "Add Credentials" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\060-add-credentials.png"
    And I click the "Add Credentials" link

    And I highlight outside the "Kind" drop down list
    And I select the option "Secret text" from the "Kind" drop down list

    And I highlight outside the "Secret" text box with an offset of "0"
    And I highlight outside the "ID" text box with an offset of "0"
    And I highlight outside the "Description" text box with an offset of "0"
    And I highlight outside the "OK" button

    And I populate the "Secret" text box with "ExternalOctopusAPIKey"
    And I populate the "ID" text box with "OctopusAPIKey"
    And I populate the "Description" text box with "The Octopus API Key"
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\065-octopus-credentials.png"
    And I click the "OK" button

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  @configure-project
  Scenario: Create the project
    Given I set the following aliases:
      | New Item                                                | //a[contains(.,'New Item')]                                                       |
      | Project name                                            | //input[@name='name']                                                             |
      | Freestyle project                                       | .hudson_model_FreeStyleProject                                                    |
      | OK                                                      | //button[@type='submit'][contains(.,'OK')]                                        |
      | Git                                                     | (//label[contains(.,'Git')])[2]                                                   |
      | Repository URL                                          | //input[contains(@name,'_.url')]                                                  |
      | Poll SCM                                                | //input[@name='hudson-triggers-SCMTrigger']                                       |
      | Schedule                                                | //textarea[contains(@checkurl,'checkScmpoll_spec')]                               |
      | Use secrets                                             | //input[@name='org-jenkinsci-plugins-credentialsbinding-impl-SecretBuildWrapper'] |
      | Bindings Add                                            | //button[@suffix='bindings']                                                      |
      | Secret text                                             | //a[contains(.,'Secret text')]                                                    |
      | Variable                                                | //input[@name='_.variable']                                                       |
      | Credentials                                             | //select[@class='setting-input  select  credentials-select']                      |
      | Add build step                                          | //button[@type='button'][contains(.,'Add build step')]                            |
      | Execute Windows batch command                           | //a[contains(.,'Execute Windows batch command')]                                  |
      | Command                                                 | //textarea[@name='command']                                                       |
      | Build a Visual Studio project or solution using MSBuild | //a[contains(.,'Build a Visual Studio project or solution using MSBuild')]        |
      | MSBuild Version                                         | //select[@name='msBuildBuilder.msBuildName']                                      |
      | MSBuild Build File                                      | //input[@name='msBuildBuilder.msBuildFile']                                       |
      | Command Line Arguments                                  | //textarea[@name='msBuildBuilder.cmdLineArgs']                                    |
      | Command Two                                             | (//textarea[contains(@name,'command')])[2]                                        |

    And I open the URL "http://localhost:8080/"
    And I clear the transition

    And I display a note with the text "Creating the Jenkins project" for "3" seconds

    And I highlight inside the "New Item" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\075-new-item.png"
    And I click the "New Item" link

    And I highlight outside the "Freestyle project" link
    And I highlight outside the "Project name" link
    And I highlight outside the "OK" button
    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\080-freestyle-project.png"
    And I click the "Freestyle project" link
    And I scroll the "OK" button into view
    And I click the "OK" button

    And I scroll the "Git" option into view offset by "-200"
    And I highlight outside the "Git" option
    And I click the "Git" option
    And I highlight outside the "Repository URL" text box
    And I populate the "Repository URL" text box with "https://github.com/OctopusSamples/RandomQuotes-aspmvc4.git"
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\085-git-settings.png"

    And I scroll the "Poll SCM" option into view offset by "-200"
    And I click the "Poll SCM" option
    And I populate the "Schedule" textarea with "H/5 * * * *"
    And I highlight outside the "Poll SCM" option
    And I highlight outside the "Schedule" textarea
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\090-git-polling.png"
    And I remove the highlight from the "Poll SCM" option
    And I remove the highlight from the "Schedule" textarea

    And I scroll the "Use secrets" option into view offset by "-200"
    And I highlight outside the "Use secrets" option
    And I click the "Use secrets" option

    And I highlight outside the "Bindings Add" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\095-binding-add.png"
    And I click the "Bindings Add" option
    And I highlight outside the "Secret text" link
    And I sleep for "1" second
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\100-secret-text.png"
    And I remove the highlight from the "Bindings Add" option
    And I remove the highlight from the "Use secrets" option
    And I click the "Secret text" link

    And I highlight outside the "Variable" text box
    And I highlight outside the "Credentials" drop down list
    And I populate the "Variable" text box with "OctopusAPIKey"
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\105-credentials-octopusapikey.png"
    And I remove the highlight from the "Variable" text box
    And I remove the highlight from the "Credentials" drop down list

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\110-batch-command-1.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command" text box into view offset by "-200"
    And I highlight outside the "Command" text box
    And I populate the "Command" text box with "C:\ProgramData\chocolatey\bin\nuget.exe restore"
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\115-nuget-restore.png"
    And I remove the highlight from the "Command" text box

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Build a Visual Studio project or solution using MSBuild" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\120-msbuild-step-add.png"
    And I click the "Build a Visual Studio project or solution using MSBuild" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Build a Visual Studio project or solution using MSBuild" option

    And I scroll the "MSBuild Version" drop down list into view offset by "-200"
    And I highlight outside the "MSBuild Version" drop down list with an offset of "0"
    And I highlight outside the "MSBuild Build File" text box with an offset of "0"
    And I highlight outside the "Command Line Arguments" text box with an offset of "0"
    And I select the option "MSBuild" from the "MSBuild Version" drop down list
    And I populate the "MSBuild Build File" text box with "RandomQuotes.sln"
    And I populate the "Command Line Arguments" text box with "/p:RunOctoPack=true /p:OctoPackEnforceAddingFiles=true /p:OctoPackPackageVersion=1.0.$BUILD_NUMBER"
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\125-msbuild-step.png"
    And I remove the highlight from the "MSBuild Version" drop down list
    And I remove the highlight from the "MSBuild Build File" text box
    And I remove the highlight from the "Command Line Arguments" text box

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\127-batch-command-2.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command Two" text box into view offset by "-200"
    And I highlight outside the "Command Two" text box
    And I populate the "Command Two" text box with ".\packages\NUnit.ConsoleRunner.3.10.0\tools\nunit3-console.exe .\RandomQuotes.Tests\bin\Debug\RandomQuotes.Tests.dll"
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\128-nunit-test.png"
    And I remove the highlight from the "Command Two" text box

  @configure-project @repositoryspecific @artifactory
  Scenario: Add Artifactory Push Step
    Given I set the following aliases:
      | Add build step                | //button[@type='button'][contains(.,'Add build step')] |
      | Execute Windows batch command | //a[contains(.,'Execute Windows batch command')]       |
      | Command Three                 | (//textarea[contains(@name,'command')])[3]             |
      | Save                          | //button[@type='button'][contains(.,'Save')]           |

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\130-artifactory-batch-command-1.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command Three" text box into view offset by "-200"
    And I highlight outside the "Command Three" text box
    And I populate the "Command Three" text box with "C:\ProgramData\chocolatey\bin\nuget.exe push -Source Artifactory .\RandomQuotes\obj\octopacked\RandomQuotes.1.0.%BUILD_NUMBER%.nupkg"
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\135-nuget-push.png"
    And I remove the highlight from the "Command Three" text box

    And I click the "Save" button
    And I stop recording the screen

  @configure-project @repositoryspecific @octo-built-in-feed
  Scenario: Add Octopus Push Step
    Given I set the following aliases:
      | Add build step                | //button[@type='button'][contains(.,'Add build step')] |
      | Execute Windows batch command | //a[contains(.,'Execute Windows batch command')]       |
      | Command Three                 | (//textarea[contains(@name,'command')])[3]             |
      | Save                          | //button[@type='button'][contains(.,'Save')]           |

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\130-batch-command-3.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command Three" text box into view offset by "-200"
    And I highlight outside the "Command Three" text box
    And I highlight outside the "Save" button
    And I populate the "Command Three" text box with "Octo.exe push --server http://localhost --package .\RandomQuotes\obj\octopacked\RandomQuotes.1.0.%BUILD_NUMBER%.nupkg --apiKey %OctopusAPIKey%"
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\135-octo-push.png"

    And I click the "Save" button
    And I stop recording the screen

  @build-now
  Scenario: Run build
    Given I set the following aliases:
      | Build Now      | //a[contains(.,'Build Now')]      |
      | Build One      | //a[contains(.,'#1')]             |
      | Console Output | //a[contains(.,'Console Output')] |

    And I open the URL "http://localhost:8080/job/Random%20Quotes/"
    And I clear the transition
    And I start recording the screen to the directory "C:\screenshots"

    And I highlight inside the "Build Now" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\140-build-now.png"
    And I click the "Build Now" link

    And I highlight inside the "Build One" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\145-build-one.png"
    # Fake a click here to fix stale element errors in WebDriver
    And I mouse over the "Build One" link
    And I open the URL "http://localhost:8080/job/Random%20Quotes/1/"

    And I highlight inside the "Console Output" link
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\150-console.png"
    And I click the "Console Output" link
    And I scroll down "10000" px
    And I sleep for "30" seconds

  @destinationspecific @iis
  Scenario: Get log screenshot
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\155-build-logs.png"

  @destinationspecific @azure-web-app
  Scenario: Get log screenshot
    And I save a screenshot to "c:\screenshots\jenkins\initialproject\155-build-logs-azure.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser
