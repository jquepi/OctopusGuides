Feature: Create ASP.NET project

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@id='username']      |
      | Password | //input[@id='password']      |
      | Log in   | //input[@name='submitLogin'] |

    And I open the shared browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:8111"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Log in" button

  @create-project @applicationspecific @aspnetcore
  Scenario: Create Project
    Given I set the following aliases:
      | Create project        | //a[contains(.,'Create project')]                      |
      | Repository URL        | //input[@id='url']                                     |
      | Proceed               | //input[@name='createProjectFromUrl']                  |
      | Project name          | //input[@id='projectName']                             |
      | Proceed Two           | //input[@name='createProject']                         |
      | Configure manually    | //a[text()='configure build steps manually']           |
      | Runner type           | //input[@id='-ufd-teamcity-ui-runTypeInfoKey']         |
      | Runner type container | //span[./input[@id='-ufd-teamcity-ui-runTypeInfoKey']] |
      | DotNet CLI            | //li[@data-title='.NET CLI (dotnet)']                  |
      | Step name             | //input[@id='buildStepName']                           |
      | Command               | //input[@id='-ufd-teamcity-ui-command']                |
      | Test option           | //li[@data-title='test']                               |
      | Publish option        | //li[@data-title='publish']                            |
      | Show advanced options | //a[text()='Show advanced options']                    |
      | Configuration         | //input[@id='configuration']                           |
      | Save                  | //input[@value='Save']                                 |
      | OctopusDeploy: Pack   | //li[@data-title='OctopusDeploy: Pack']                |
      | Package ID            | //input[@id='octopus_packageid']                       |
      | Package Version       | //input[@id='octopus_packageversion']                  |
      | Source path           | //input[@id='octopus_packagesourcepath']               |
      | Output path           | //input[@id='octopus_packageoutputpath']               |
      | Got it                | //button[contains(.,'Got it')]                         |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Create the TeamCity project" for "3" seconds

    And I highlight outside the "Create project" button with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}010-create-project.png"
    And I click the "Create project" button

    And I highlight outside the "Repository URL" text box
    And I highlight outside the "Proceed" button
    And I populate the "Repository URL" text box with the text "GitUrl"
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}020-repo-url.png"
    And I click the "Proceed" button

    And I highlight outside the "Project name" text box
    And I highlight outside the "Proceed Two" button
    And I mouse over the "Project name" text box
    And I clear the "Project name" text box
    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}030-project-name.png"
    And I click the "Proceed Two" button

    And I highlight outside the "Configure manually" link
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}040-configure-manually.png"
    And I click the "Configure manually" link

    And I click the "Runner type" drop down list
    And I scroll the "DotNet CLI" option into view offset by "-200"
    And I click the "DotNet CLI" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "DotNet Test"

    And I highlight outside the "Command" drop down list
    And I click the "Command" drop down list
    And I scroll the "Test option" element into view offset by "-200"
    And I click the "Test option" element
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}045-dotnet-test.png"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}050-dotnet-test.png"
    And I click the "Save" button

    And I click the "Got it" button waiting up to "5" seconds if it exists

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}060-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list

    And I scroll the "DotNet CLI" option into view
    And I click the "DotNet CLI" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Publish Project"

    And I highlight outside the "Command" drop down list
    And I click the "Command" drop down list
    And I scroll the "Publish option" element into view offset by "-200"
    And I click the "Publish option" element

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}063-add-build-step.png"

    And I scroll the "Show advanced options" link into view offset by "-200" if it exists
    And I click the "Show advanced options" link if it exists

    And I highlight outside the "Configuration" text box
    And I scroll the "Configuration" text box into view offset by "-200"
    And I populate the "Configuration" text box with "Release"

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}065-add-build-step.png"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}070-dotnet-publish.png"
    And I click the "Save" button

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}080-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list

    And I scroll the "OctopusDeploy: Pack" option into view
    And I click the "OctopusDeploy: Pack" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Pack Project"

    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "RandomQuotes"

    And I highlight outside the "Package Version" text box
    And I populate the "Package Version" text box with "1.0.%build.counter%"

    And I highlight outside the "Source path" text box
    And I populate the "Source path" text box with "RandomQuotes\bin\Release\netcoreapp2.2\publish\"

    And I highlight outside the "Output path" text box
    And I populate the "Output path" text box with "."

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}085-octo-pack.png"

    And I remove the highlight from the "Runner type container" drop down list
    And I remove the highlight from the "Step name" text box
    And I remove the highlight from the "Package ID" text box
    And I remove the highlight from the "Package Version" text box
    And I remove the highlight from the "Source path" text box
    And I remove the highlight from the "Output path" text box

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}090-octo-pack.png"
    And I click the "Save" button

    And I stop recording the screen

  @create-project @applicationspecific @aspnet
  Scenario: Create Project
    Given I set the following aliases:
      | Create project               | //a[contains(.,'Create project')]                      |
      | Repository URL               | //input[@id='url']                                     |
      | Proceed                      | //input[@name='createProjectFromUrl']                  |
      | Project name                 | //input[@id='projectName']                             |
      | Proceed Two                  | //input[@name='createProject']                         |
      | Configure manually           | //a[text()='configure build steps manually']           |
      | Runner type                  | //input[@id='-ufd-teamcity-ui-runTypeInfoKey']         |
      | Runner type container        | //span[./input[@id='-ufd-teamcity-ui-runTypeInfoKey']] |
      | NuGet Installer              | //li[@data-title='NuGet Installer']                    |
      | Visual Studio (sln)          | //li[@data-title='Visual Studio (sln)']                |
      | Step name                    | //input[@id='buildStepName']                           |
      | NuGet.exe                    | //select[@id='toolPathSelectorNuGet.CommandLine']      |
      | NuGet.exe path               | //input[@id='toolCustomPathNuGet.CommandLine']         |
      | Path to solution file        | //input[@id='sln.path']                                |
      | Add build step               | //a[contains(.,'Add build step')]                      |
      | Save                         | //input[@value='Save']                                 |
      | Solution file path           | //input[@id='build-file-path']                         |
      | Visual Studio                | //input[@id='-ufd-teamcity-ui-vs.version']             |
      | Microsoft Visual Studio 2017 | //li[@data-title='Microsoft Visual Studio 2017']       |
      | Run OctoPack                 | //input[@id='octopus_run_octopack']                    |
      | OctoPack package version     | //input[@id='octopus_octopack_package_version']        |
      | NUnit                        | //li[@data-title='NUnit']                              |
      | NUnit Console                | //select[@id='toolPathSelectorNUnit.Console']          |
      | NUnit Console Path           | //input[@id='toolCustomPathNUnit.Console']             |
      | Run tests from               | //textarea[@id='nunit_include']                        |
      | Got it                       | //button[contains(.,'Got it')]                         |
      | Show advanced options        | //a[text()='Show advanced options']                    |
      | Command line parameters      | //textarea[@id='runnerArgs']                           |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Create the TeamCity project" for "3" seconds

    And I highlight outside the "Create project" button with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}010-create-project.png"
    And I click the "Create project" button

    And I highlight outside the "Repository URL" text box
    And I highlight outside the "Proceed" button
    And I populate the "Repository URL" text box with the text "GitUrl"
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}020-repo-url.png"
    And I click the "Proceed" button

    And I highlight outside the "Project name" text box
    And I highlight outside the "Proceed Two" button
    And I mouse over the "Project name" text box
    And I clear the "Project name" text box
    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}030-project-name.png"
    And I click the "Proceed Two" button

    And I highlight outside the "Configure manually" link
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}040-configure-manually.png"
    And I click the "Configure manually" link

    And I click the "Runner type" drop down list
    And I scroll the "NuGet Installer" option into view offset by "-200"
    And I click the "NuGet Installer" option
    And I sleep for "2" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "NuGet Restore"

    And I highlight outside the "NuGet.exe" drop down with an offset of "5"
    And I scroll the "NuGet.exe" drop down into view
    And I select the option value "custom" from the "NuGet.exe" drop down list

    And I highlight outside the "NuGet.exe path" text box with an offset of "5"
    And I scroll the "NuGet.exe path" text box into view offset by "-300"
    And I populate the "NuGet.exe path" text box with "C:\ProgramData\chocolatey\bin\nuget.exe"

    And I highlight outside the "Path to solution file" text box
    And I scroll the "Path to solution file" text box into view offset by "-300"
    And I populate the "Path to solution file" text box with "RandomQuotes.sln"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}050-nuget-installer.png"
    And I click the "Save" button

    And I click the "Got it" button waiting up to "5" seconds if it exists

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}060-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list

    And I scroll the "Visual Studio (sln)" option into view
    And I click the "Visual Studio (sln)" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Build Project"

    And I highlight outside the "Solution file path" text box
    And I scroll the "Solution file path" text box into view offset by "-300"
    And I populate the "Solution file path" text box with "RandomQuotes.sln"

    And I click the "Visual Studio" drop down list
    And I click the "Microsoft Visual Studio 2017" option
    And I sleep for "1" second
    And I highlight outside the "Visual Studio" drop down list

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}070-build-options.png"

    And I highlight outside the "Run OctoPack" check box
    And I scroll the "Run OctoPack" check box into view offset by "-300"
    And I click the "Run OctoPack" check box

    And I highlight outside the "OctoPack package version" text box
    And I scroll the "OctoPack package version" text box into view offset by "-300"
    And I populate the "OctoPack package version" text box with "1.0.%build.counter%"

    And I highlight outside the "Show advanced options" link waiting up to "1" second if it exists
    And I click the "Show advanced options" link waiting up to "1" second if it exists

    And I highlight outside the "Command line parameters" text box
    And I populate the "Command line parameters" text box with "/p:OctoPackEnforceAddingFiles=true"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}080-octopack-options.png"

    And I click the "Save" button

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}090-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list

    And I scroll the "NUnit" option into view offset by "-200"
    And I click the "NUnit" option
    And I sleep for "2" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Run Tests"

    And I highlight outside the "NUnit Console" drop down with an offset of "5"
    And I scroll the "NUnit Console" drop down list into view offset by "-300"
    And I select the option value "custom" from the "NUnit Console" drop down list

    And I highlight outside the "NUnit Console Path" text box with an offset of "5"
    And I scroll the "NUnit Console Path" text box list into view offset by "-300"
    And I populate the "NUnit Console Path" text box with "packages\NUnit.ConsoleRunner.3.10.0\tools\nunit3-console.exe"

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}100-nunit-settings.png"

    And I remove the highlight from the "Runner type" drop down list
    And I remove the highlight from the "Step name" text box
    And I remove the highlight from the "NUnit Console Path" text box
    And I remove the highlight from the "NUnit Console" drop down

    And I highlight outside the "Run tests from" text box
    And I scroll the "Run tests from" text box list into view
    And I populate the "Run tests from" text box with "RandomQuotes.Tests\bin\Debug\RandomQuotes.Tests.dll"

    And I highlight outside the "Save" button into view
    And I scroll the "Save" button into view

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}110-nunit-files.png"

    And I click the "Save" button

    And I stop recording the screen

  @create-project @repositoryspecific @artifactory
  Scenario: Add artifactory push step
    Given I set the following aliases:
      | Add build step           | //a[contains(.,'Add build step')]                          |
      | Runner type              | //input[@id='-ufd-teamcity-ui-runTypeInfoKey']             |
      | Runner type container    | //span[./input[@id='-ufd-teamcity-ui-runTypeInfoKey']]     |
      | NuGet Publish            | //li[@data-title='NuGet Publish']                          |
      | Step name                | //input[@id='buildStepName']                               |
      | Save                     | //input[@value='Save']                                     |
      | NuGet.exe                | //select[@id='toolPathSelectorNuGet.CommandLine']          |
      | NuGet.exe path           | //input[@id='toolCustomPathNuGet.CommandLine']             |
      | Packages                 | //textarea[@id='nuget.publish.files']                      |
      | API key                  | //input[@id='secure:nuget.api.key']                        |
      | Package source           | //input[@id='nuget.publish.source']                        |
      | Show advanced options    | //a[text()='Show advanced options']                        |
      | Build Configuration Home | //a[@href='/viewType.html?buildTypeId=RandomQuotes_Build'] |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}120-artifactory-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list

    And I scroll the "NuGet Publish" option into view
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}130-nuget-publish.png"
    And I click the "NuGet Publish" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I scroll the "Step name" text box into view offset by "-300"
    And I populate the "Step name" text box with "Push to Artifactory"

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}140-nuget-publish.png"

    And I remove the highlight from the "Runner type container" drop down list
    And I remove the highlight from the "Step name" text box

    And I highlight outside the "NuGet.exe" drop down with an offset of "5"
    And I scroll the "NuGet.exe" drop down into view
    And I select the option value "custom" from the "NuGet.exe" drop down list

    And I highlight outside the "NuGet.exe path" text box with an offset of "5"
    And I scroll the "NuGet.exe path" text box into view offset by "-300"
    And I populate the "NuGet.exe path" text box with "C:\ProgramData\chocolatey\bin\nuget.exe"

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}150-nuget-publish.png"

    And I remove the highlight from the "NuGet.exe" drop down
    And I remove the highlight from the "NuGet.exe path" text box

    And I highlight outside the "Packages" text box with an offset of "5"
    And I scroll the "Packages" text box into view offset by "-300"
    And I populate the "Packages" text box with "#{NuGetPath}RandomQuotes.1.0.%build.counter%.nupkg"

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}160-nuget-publish.png"

    And I remove the highlight from the "Packages" text box

    And I highlight outside the "Show advanced options" link if it exists waiting up to "1" second
    And I click the "Show advanced options" link if it exists waiting up to "1" second

    And I highlight outside the "Package source" text box with an offset of "5"
    And I scroll the "Package source" text box into view offset by "-300"
    And I populate the "Package source" text box with "Artifactory"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}170-artifactory-save.png"

    And I click the "Save" button

    And I highlight outside the "Build Configuration Home" link with an offset of "2"
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}160-build-config-home-artifactory.png"
    And I click the "Build Configuration Home" link

    And I stop recording the screen

  @create-project @repositoryspecific @octo-built-in-feed
  Scenario: Add octopus push step
    Given I set the following aliases:
      | Add build step               | //a[contains(.,'Add build step')]                          |
      | Runner type                  | //input[@id='-ufd-teamcity-ui-runTypeInfoKey']             |
      | Runner type container        | //span[./input[@id='-ufd-teamcity-ui-runTypeInfoKey']]     |
      | OctopusDeploy: Push Packages | //li[@data-title='OctopusDeploy: Push Packages']           |
      | Octopus URL                  | //input[@id='octopus_host']                                |
      | Octopus API key              | //input[@id='secure:octopus_apikey']                       |
      | Package paths                | //textarea[@id='octopus_packagepaths']                     |
      | Save                         | //input[@value='Save']                                     |
      | Step name                    | //input[@id='buildStepName']                               |
      | Build Configuration Home     | //a[@href='/viewType.html?buildTypeId=RandomQuotes_Build'] |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}120-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list

    And I scroll the "OctopusDeploy: Push Packages" option into view
    And I click the "OctopusDeploy: Push Packages" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I scroll the "Step name" text box into view offset by "-300"
    And I populate the "Step name" text box with "Push to Octopus"

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}130-push-top-octo.png"

    And I remove the highlight from the "Runner type container" drop down list
    And I remove the highlight from the "Step name" text box

    And I highlight outside the "Octopus URL" text box
    And I scroll the "Octopus URL" text box into view offset by "-300"
    And I populate the "Octopus URL" text box with "http://localhost"

    And I highlight outside the "Octopus API key" text box
    And I scroll the "Octopus API key" text box into view offset by "-300"
    And I populate the "Octopus API key" text box with "ExternalOctopusAPIKey"

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}140-push-top-octo.png"

    And I remove the highlight from the "Octopus URL" text box
    And I remove the highlight from the "Octopus API key" text box

    And I highlight outside the "Package paths" text box
    And I scroll the "Package paths" text box into view offset by "-300"
    And I populate the "Package paths" text box with "#{NuGetPath}RandomQuotes.1.0.%build.counter%.nupkg"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view

    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}150-push-top-octo.png"

    And I click the "Save" button

    And I highlight outside the "Build Configuration Home" link
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}160-build-config-home.png"
    And I click the "Build Configuration Home" link

    And I stop recording the screen

  @run-build
  Scenario: Run a build
    Given I set the following aliases:
      | Run                      | //button[contains(.,'Run')]                                |
      | Build Configuration Home | //a[@href='/viewType.html?buildTypeId=RandomQuotes_Build'] |
      | Build One                | //a[contains(.,'#1')]                                      |
      | Build log                | //a[contains(.,'Build Log')]                               |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Run" button
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}170-run.png"
    And I click the "Run" button
    And I sleep for "10" seconds
    And I refresh the page

    And I highlight outside the "Build One" link
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}180-build-one.png"
    And I click the "Build One" link
    And I click the "Build log" link
    And I scroll down "10000" px
    And I sleep for "20" seconds
    And I stop recording the screen

    And I sleep for "150" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I sleep for "5" seconds

  @octo-built-in-feed
  Scenario: Get screenshot
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}190-build-one-results.png"

  @artifactory
  Scenario: Get screenshot
    And I save a screenshot to "#{ExternalMediaPath}\teamcity\initialproject\#{GuideSpecificScreenshotDir}190-build-one-artifactory-results.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser
