Feature: Build and deploy a ASP.NET application hosted in Git on a local Octopus instance

  Scenario: Initial setup
    Given I run the feature "shared/jenkins-open-browser.feature" passing the original arguments
    And I run the feature "shared/jenkins-login.feature" passing the original arguments
    And I run the feature "shared/jenkins-install-octo-plugin.feature" passing the original arguments

  @plugin-install @applicationspecific @aspnet
  Scenario: Install plugins
    Given I set the following aliases:
      | Available                | //a[contains(@href,'available')]              |
      | Filter                   | #filter-box                                   |
      | MSBuild Plugin           | //input[@name='plugin.msbuild.default']       |
      | MSBuild Plugin Container | //td[./input[@name='plugin.msbuild.default']] |
      | Install without restart  | //button[text()='Install without restart']    |
      | Back to top              | //a[contains(.,'Go back to the top page')]    |

    Given I run the feature "shared/jenkins-open-plugins.feature"

    And I click the "Available" tab
    And I populate the "Filter" text box with the text "MSBuild"
    And I click the "MSBuild Plugin" checkbox
    And I highlight inside the "Available" tab
    And I highlight outside the "Filter" tab
    And I highlight inside the "MSBuild Plugin Container" element
    And I highlight outside the "Install without restart" button
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}015-msbuild-plugin.png"
    And I click the "Install without restart" button
    And I wait for "5" seconds

    And I stop recording the screen
    And I sleep for "60" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Back to top" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}020-plugin-install.png"
    # fake a click
    And I open the URL "http://localhost:8080/"

  @configure-tools @applicationspecific @aspnet
  Scenario: Configure tools
    Given I set the following aliases:
      | Manage Jenkins            | //a[@class='task-link' and contains(.,'Manage Jenkins')]                                              |
      | Global Tool Configuration | //a[@href='configureTools']                                                                           |
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
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}025-global-tool-configuration.png"
    And I click the "Global Tool Configuration" link

    And I scroll the "MSBuild Tool" button into view offset by "-100"
    And I highlight outside the "MSBuild Tool" button
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}030-msbuild-global-tool.png"
    And I click the "MSBuild Tool" button
    And I remove the highlight from the "MSBuild Tool" button

    And I highlight inside the "MSBuild Name" text box
    And I highlight inside the "MSBuild Path" text box
    And I highlight outside the "Save" button
    And I populate the "MSBuild Name" text box with "MSBuild"
    And I populate the "MSBuild Path" text box with the text "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}035-msbuild-settings.png"
    And I click the "Save" button

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  @configure-project
  Scenario: Prepare the project
    Given I set the following aliases:
      | New Item          | //a[contains(.,'New Item')]                                                       |
      | Project name      | //input[@name='name']                                                             |
      | Freestyle project | .hudson_model_FreeStyleProject                                                    |
      | OK                | //button[@type='submit'][contains(.,'OK')]                                        |
      | Git               | (//label[contains(.,'Git')])[2]                                                   |
      | Repository URL    | //input[contains(@name,'_.url')]                                                  |
      | Poll SCM          | //input[@name='hudson-triggers-SCMTrigger']                                       |
      | Schedule          | //textarea[contains(@checkurl,'checkScmpoll_spec')]                               |
      | Use secrets       | //input[@name='org-jenkinsci-plugins-credentialsbinding-impl-SecretBuildWrapper'] |
      | Bindings Add      | //button[@suffix='bindings']                                                      |
      | Secret text       | //a[contains(.,'Secret text')]                                                    |
      | Variable          | //input[@name='_.variable']                                                       |
      | Credentials       | //select[@class='setting-input  select  credentials-select']                      |

    And I open the URL "http://localhost:8080/"
    And I clear the transition

    And I display a note with the text "Creating the Jenkins project" for "3" seconds

    And I highlight inside the "New Item" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}075-new-item.png"
    And I click the "New Item" link

    And I highlight outside the "Freestyle project" link
    And I highlight outside the "Project name" link
    And I highlight outside the "OK" button
    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}080-freestyle-project.png"
    And I click the "Freestyle project" link
    And I scroll the "OK" button into view
    And I click the "OK" button

    And I scroll the "Git" option into view offset by "-200"
    And I highlight outside the "Git" option
    And I click the "Git" option
    And I highlight outside the "Repository URL" text box
    And I populate the "Repository URL" text box with "GitUrl"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}085-git-settings.png"

    And I scroll the "Poll SCM" option into view offset by "-200"
    And I click the "Poll SCM" option
    And I populate the "Schedule" textarea with "H/5 * * * *"
    And I highlight outside the "Poll SCM" option
    And I highlight outside the "Schedule" textarea
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}090-git-polling.png"
    And I remove the highlight from the "Poll SCM" option
    And I remove the highlight from the "Schedule" textarea

  @configure-project @applicationspecific @aspnet
  Scenario: ASP.NET - Create the project
    Given I set the following aliases:
      | Add build step                                          | //button[@type='button'][contains(.,'Add build step')]                     |
      | Execute Windows batch command                           | //a[contains(.,'Execute Windows batch command')]                           |
      | Command                                                 | //textarea[@name='command']                                                |
      | Build a Visual Studio project or solution using MSBuild | //a[contains(.,'Build a Visual Studio project or solution using MSBuild')] |
      | MSBuild Version                                         | //select[@name='msBuildBuilder.msBuildName']                               |
      | MSBuild Build File                                      | //input[@name='msBuildBuilder.msBuildFile']                                |
      | Command Line Arguments                                  | //textarea[@name='msBuildBuilder.cmdLineArgs']                             |
      | Command Two                                             | (//textarea[contains(@name,'command')])[2]                                 |

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}110-batch-command-1.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command" text box into view offset by "-200"
    And I highlight outside the "Command" text box
    And I populate the "Command" text box with "C:\ProgramData\chocolatey\bin\nuget.exe restore"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}115-nuget-restore.png"
    And I remove the highlight from the "Command" text box

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" second
    And I click the "Add build step" button
    And I highlight outside the "Build a Visual Studio project or solution using MSBuild" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}120-msbuild-step-add.png"
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
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}125-msbuild-step.png"
    And I remove the highlight from the "MSBuild Version" drop down list
    And I remove the highlight from the "MSBuild Build File" text box
    And I remove the highlight from the "Command Line Arguments" text box

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}127-batch-command-2.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command Two" text box into view offset by "-200"
    And I highlight outside the "Command Two" text box
    And I populate the "Command Two" text box with ".\packages\NUnit.ConsoleRunner.3.10.0\tools\nunit3-console.exe .\RandomQuotes.Tests\bin\Debug\RandomQuotes.Tests.dll"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}128-nunit-test.png"
    And I remove the highlight from the "Command Two" text box

  @configure-project @repositoryspecific @artifactory @applicationspecific @aspnet
  Scenario: ASP.NET - Add Artifactory Push Step
    Given I set the following aliases:
      | Add build step                | //button[@type='button'][contains(.,'Add build step')] |
      | Execute Windows batch command | //a[contains(.,'Execute Windows batch command')]       |
      | Command Three                 | (//textarea[contains(@name,'command')])[3]             |
      | Save                          | //button[@type='button'][contains(.,'Save')]           |

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}130-artifactory-batch-command-1.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command Three" text box into view offset by "-200"
    And I highlight outside the "Command Three" text box
    And I populate the "Command Three" text box with "C:\ProgramData\chocolatey\bin\nuget.exe push -Source Artifactory .\RandomQuotes\obj\octopacked\RandomQuotes.1.0.%BUILD_NUMBER%.nupkg"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}135-nuget-push.png"
    And I remove the highlight from the "Command Three" text box

    And I click the "Save" button
    And I stop recording the screen

  @configure-project @repositoryspecific @octo-built-in-feed @applicationspecific @aspnet
  Scenario: ASP.NET - Add Octopus Push Step
    Given I set the following aliases:
      | Add build step | //button[@type='button'][contains(.,'Add build step')] |
      | Push packages  | //a[contains(.,'Octopus Deploy: Push packages')]       |
      | Package paths  | //textarea[@name='_.packagePaths']                     |
      | Save           | //button[@type='button'][contains(.,'Save')]           |

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I sleep for "1" second
    And I highlight outside the "Push packages" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}130-octo-plugin-push-package.png"
    And I click the "Push packages" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Push packages" option

    And I scroll the "Package paths" text box into view offset by "-200"
    And I highlight outside the "Package paths" text box
    And I populate the "Package paths" text box with "${WORKSPACE}\RandomQuotes\obj\octopacked\RandomQuotes.1.0.${BUILD_NUMBER}.nupkg"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}135-octo-plugin-push.png"
    And I remove the highlight from the "Package paths" text box

    And I click the "Save" button
    And I stop recording the screen

  @configure-project @applicationspecific @aspnetcore
  Scenario: ASP.NET Core - Create the project
    Given I set the following aliases:
      | Add build step                                          | //button[@type='button'][contains(.,'Add build step')]                     |
      | Execute Windows batch command                           | //a[contains(.,'Execute Windows batch command')]                           |
      | Command                                                 | //textarea[@name='command']                                                |
      | Build a Visual Studio project or solution using MSBuild | //a[contains(.,'Build a Visual Studio project or solution using MSBuild')] |
      | MSBuild Version                                         | //select[@name='msBuildBuilder.msBuildName']                               |
      | MSBuild Build File                                      | //input[@name='msBuildBuilder.msBuildFile']                                |
      | Command Line Arguments                                  | //textarea[@name='msBuildBuilder.cmdLineArgs']                             |
      | Command Two                                             | (//textarea[contains(@name,'command')])[2]                                 |
      | Package application                                     | //a[contains(.,'Octopus Deploy: Package application')]                     |
      | Package ID                                              | //input[@name='_.packageId']                                               |
      | Version number                                          | //input[@name='_.packageVersion']                                          |
      | Package output folder                                   | //input[@name='_.outputPath']                                              |
      | Package include paths                                   | //textarea[@name='_.includePaths']                                         |
      | Package base path                                       | //input[@name='_.sourcePath']                                              |
      | Nuget                                                   | //input[@value='nuget']                                                    |

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}110-batch-command-1.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command" text box into view offset by "-200"
    And I highlight outside the "Command" text box
    And I populate the "Command" text box with "dotnet test"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}120-dotnet-test.png"
    And I remove the highlight from the "Command" text box

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}130-batch-command-2.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command Two" text box into view offset by "-200"
    And I highlight outside the "Command Two" text box
    And I populate the "Command Two" text box with "dotnet publish -c Release"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}140-dotnet-publish.png"
    And I remove the highlight from the "Command Two" text box

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I sleep for "1" second
    And I highlight outside the "Package application" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}160-pack-command.png"
    And I click the "Package application" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Package application" option

    And I scroll the "Package ID" text box into view offset by "-200"
    And I highlight outside the "Package ID" text box
    And I highlight outside the "Version number" text box
    And I highlight outside the "Package base path" text box
    And I highlight outside the "Package include paths" text box
    And I highlight outside the "Package output folder" text box
    And I highlight outside the "Nuget" text box

    And I populate the "Package ID" text box with "RandomQuotes"
    And I populate the "Version number" text box with "1.0.${BUILD_NUMBER}"
    And I populate the "Package base path" text box with "${WORKSPACE}\RandomQuotes\bin\Release\netcoreapp2.2\publish"
    And I populate the "Package include paths" text box with "**"
    And I populate the "Package output folder" text box with "${WORKSPACE}"
    And I click the "Nuget" check box

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}165-octo-plugin-pack.png"

  @configure-project @repositoryspecific @artifactory @applicationspecific @aspnetcore
  Scenario: ASP.NET Core Artifactory - Add Artifactory Push Step
    Given I set the following aliases:
      | Add build step                | //button[@type='button'][contains(.,'Add build step')] |
      | Execute Windows batch command | //a[contains(.,'Execute Windows batch command')]       |
      | Command Three                 | (//textarea[contains(@name,'command')])[3]             |
      | Save                          | //button[@type='button'][contains(.,'Save')]           |

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}170-artifactory-batch-command-1.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command Three" text box into view offset by "-200"
    And I highlight outside the "Command Three" text box
    And I populate the "Command Three" text box with "C:\ProgramData\chocolatey\bin\nuget.exe push -Source Artifactory RandomQuotes.1.0.%BUILD_NUMBER%.nupkg"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}180-nuget-push.png"
    And I remove the highlight from the "Command Three" text box

    And I click the "Save" button
    And I stop recording the screen

  @configure-project @repositoryspecific @octo-built-in-feed @applicationspecific @aspnetcore
  Scenario: ASP.NET Core Built-in Feed - Add Octopus Push Step
    Given I set the following aliases:
      | Add build step | //button[@type='button'][contains(.,'Add build step')] |
      | Push packages  | //a[contains(.,'Octopus Deploy: Push packages')]       |
      | Package paths  | //textarea[@name='_.packagePaths']                     |
      | Save           | //button[@type='button'][contains(.,'Save')]           |

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I sleep for "1" second
    And I highlight outside the "Push packages" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}170-octo-plugin-push-package.png"
    And I click the "Push packages" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Push packages" option

    And I scroll the "Package paths" text box into view offset by "-200"
    And I highlight outside the "Package paths" text box
    And I populate the "Package paths" text box with "${WORKSPACE}\RandomQuotes.1.0.${BUILD_NUMBER}.nupkg"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}180-octo-plugin-push.png"
    And I remove the highlight from the "Package paths" text box

    And I click the "Save" button
    And I stop recording the screen

  @build-now
  Scenario: Run build
    And I run the feature "shared/jenkins-build.feature"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser
