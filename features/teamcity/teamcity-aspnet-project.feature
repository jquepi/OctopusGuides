Feature: Create ASP.NET project

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
      | OctopusDeploy: Push Packages | //li[@data-title='OctopusDeploy: Push Packages']       |
      | Octopus URL                  | //input[@id='octopus_host']                            |
      | Octopus API key              | //input[@id='secure:octopus_apikey']                   |
      | Package paths                | //textarea[@id='octopus_packagepaths']                 |
      | Got it                       | //button[contains(.,'Got it')]                         |

    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Create the TeamCity project" for "3" seconds

    And I highlight outside the "Create project" button
    And I save a screenshot to "c:\screenshots\teamcity\initialproject\010-create-project.png"
    And I click the "Create project" button

    And I highlight outside the "Repository URL" text box
    And I highlight outside the "Proceed" button
    And I populate the "Repository URL" text box with the text "https://github.com/OctopusSamples/RandomQuotes-aspmvc4.git"
    And I save a screenshot to "c:\screenshots\teamcity\initialproject\020-repo-url.png"
    And I click the "Proceed" button

    And I highlight outside the "Project name" text box
    And I highlight outside the "Proceed Two" button
    And I mouse over the "Project name" text box
    And I clear the "Project name" text box
    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "c:\screenshots\teamcity\initialproject\030-project-name.png"
    And I click the "Proceed Two" button

    And I highlight outside the "Configure manually" link
    And I save a screenshot to "c:\screenshots\teamcity\initialproject\040-configure-manually.png"
    And I click the "Configure manually" link

    And I highlight outside the "Runner type container" drop down list
    And I click the "Runner type" drop down list
    And I scroll the "NuGet Installer" option into view
    And I click the "NuGet Installer" option

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "NuGet Restore"

    And I highlight outside the "NuGet.exe" drop down with an offset of "5"
    And I scroll the "NuGet.exe" drop down into view
    And I select the option value "custom" from the "NuGet.exe" drop down list

    And I highlight outside the "NuGet.exe path" text box with an offset of "5"
    And I scroll the "NuGet.exe path" text box into view offset by "-200"
    And I populate the "NuGet.exe path" text box with "C:\ProgramData\chocolatey\bin\nuget.exe"

    And I highlight outside the "Path to solution file" text box
    And I scroll the "Path to solution file" text box into view offset by "-200"
    And I populate the "Path to solution file" text box with "RandomQuotes.sln"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "c:\screenshots\teamcity\initialproject\050-nuget-installer.png"
    And I click the "Save" button

    And I click the "Got it" button waiting up to "5" seconds if it exists

    And I highlight outside the "Add build step" button
    And I save a screenshot to "c:\screenshots\teamcity\initialproject\060-add-build-step.png"
    And I click the "Add build step" button

    And I highlight outside the "Runner type container" drop down list
    And I click the "Runner type" drop down list

    And I scroll the "Visual Studio (sln)" option into view
    And I click the "Visual Studio (sln)" option

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Build Project"

    And I highlight outside the "Solution file path" text box
    And I scroll the "Solution file path" text box into view offset by "-200"
    And I populate the "Solution file path" text box with "RandomQuotes.sln"

    And I highlight outside the "Visual Studio" drop down list
    And I click the "Visual Studio" drop down list
    And I click the "Microsoft Visual Studio 2017" option

    And I save a screenshot to "c:\screenshots\teamcity\initialproject\070-build-options.png"

    And I highlight outside the "Run OctoPack" check box
    And I scroll the "Run OctoPack" check box into view offset by "-200"
    And I click the "Run OctoPack" check box

    And I highlight outside the "OctoPack package version" text box
    And I scroll the "OctoPack package version" text box into view offset by "-200"
    And I populate the "OctoPack package version" text box with "1.0.%build.counter%"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view

    And I save a screenshot to "c:\screenshots\teamcity\initialproject\080-octopack-options.png"

    And I click the "Save" button

    And I highlight outside the "Run OctoPack" check box
    And I save a screenshot to "c:\screenshots\teamcity\initialproject\090-add-build-step.png"
    And I click the "Add build step" button

    And I highlight outside the "Runner type container" drop down list
    And I click the "Runner type" drop down list

    And I scroll the "NUnit" option into view
    And I click the "NUnit" option

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Run Tests"

    And I highlight outside the "NUnit Console" drop down
    And I scroll the "NUnit Console" drop down list into view offset by "-200"
    And I select the option value "custom" from the "NUnit Console" drop down list

    And I highlight outside the "NUnit Console Path" text box
    And I scroll the "NUnit Console Path" text box list into view
    And I populate the "NUnit Console Path" text box with "packages\NUnit.ConsoleRunner.3.10.0\tools\nunit3-console.exe"

    And I save a screenshot to "c:\screenshots\teamcity\initialproject\100-nunit-settings.png"

    And I highlight outside the "Run tests from" text box
    And I scroll the "Run tests from" text box list into view
    And I populate the "Run tests from" text box with "RandomQuotes.Tests\bin\Debug\RandomQuotes.Tests.dll"

    And I highlight outside the "Save" button into view
    And I scroll the "Save" button into view

    And I save a screenshot to "c:\screenshots\teamcity\initialproject\110-nunit-files.png"

    And I click the "Save" button

    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I save a screenshot to "c:\screenshots\teamcity\initialproject\120-add-build-step.png"

    And I highlight outside the "Runner type container" drop down list
    And I click the "Runner type" drop down list

    And I scroll the "OctopusDeploy: Push Packages" option into view
    And I click the "OctopusDeploy: Push Packages" option

    And I highlight outside the "Step name" text box
    And I scroll the "Step name" text box into view offset by "-200"
    And I populate the "Step name" text box with "Push to Octopus"

    And I save a screenshot to "c:\screenshots\teamcity\initialproject\130-push-top-octo.png"

    And I highlight outside the "Octopus URL" text box
    And I scroll the "Octopus URL" text box into view offset by "-200"
    And I populate the "Octopus URL" text box with "http://localhost"

    And I highlight outside the "Octopus API key" text box
    And I scroll the "Octopus API key" text box into view offset by "-200"
    And I populate the "Octopus API key" text box with "ExternalOctopusAPIKey"

    And I save a screenshot to "c:\screenshots\teamcity\initialproject\140-push-top-octo.png"

    And I highlight outside the "Package paths" text box
    And I scroll the "Package paths" text box into view offset by "-200"
    And I populate the "Package paths" text box with "RandomQuotes/obj/octopacked/RandomQuotes.1.0.%build.counter%.nupkg"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view

    And I save a screenshot to "c:\screenshots\teamcity\initialproject\150-push-top-octo.png"

    And I click the "Save" button

  Scenario: Run a build
    Given I set the following aliases:
      | Run                      | //button[contains(.,'Run')]                                |
      | Build Configuration Home | //a[@href='/viewType.html?buildTypeId=RandomQuotes_Build'] |
      | Build One                | //a[contains(.,'#1')]                                      |

    And I highlight outside the "Build Configuration Home" link
    And I save a screenshot to "c:\screenshots\teamcity\initialproject\160-build-config-home.png"
    And I click the "Build Configuration Home" link

    And I highlight outside the "Run" button
    And I save a screenshot to "c:\screenshots\teamcity\initialproject\170-run.png"
    And I click the "Run" button

    And I highlight outside the "Build One" link
    And I save a screenshot to "c:\screenshots\teamcity\initialproject\180-build-one.png"
    And I click the "Build One" link
    And I sleep for "60" seconds

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  Scenario: Shutdown
    And I stop recording the screen
    And I close the browser
