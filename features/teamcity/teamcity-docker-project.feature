Feature: Create Docker project

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@id='username']      |
      | Password | //input[@id='password']      |
      | Log in   | //input[@name='submitLogin'] |

    And I open the shared browser "ChromeNoImplicitWait"
    And I maximize the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:8111"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Log in" button

  @create-project @applicationspecific @aspnetcore
  Scenario: Create Project
    Given I set the following aliases:
      | Create project        | //a[contains(.,'Create project')]                        |
      | Repository URL        | //input[@id='url']                                       |
      | Proceed               | //input[@name='createProjectFromUrl']                    |
      | Project name          | //input[@id='projectName']                               |
      | Proceed Two           | //input[@name='createProject']                           |
      | Configure manually    | //a[text()='configure build steps manually']             |
      | Runner type           | //input[@id='-ufd-teamcity-ui-runTypeInfoKey']           |
      | Runner type container | //span[./input[@id='-ufd-teamcity-ui-runTypeInfoKey']]   |
      | DotNet CLI            | //li[@data-title='.NET CLI (dotnet)']                    |
      | Docker                | //li[@data-title='Docker']                               |
      | Step name             | //input[@id='buildStepName']                             |
      | Command               | //input[@id='-ufd-teamcity-ui-command']                  |
      | Test option           | //li[@data-title='test']                                 |
      | Path to file          | //input[@id='path']                                      |
      | Image name:tag        | //textarea[@id='docker.image.namesAndTags']              |
      | Push                  | //input[@name='prop:docker.command.type'][@value='push'] |
      | Save                  | (//input[@value='Save'])[1]                              |
      | Got it                | //button[contains(.,'Got it')]                           |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Create the TeamCity project" for "3" seconds

    And I highlight outside the "Create project" button with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}010-create-project.png"
    And I click the "Create project" button

    And I highlight outside the "Repository URL" text box
    And I highlight outside the "Proceed" button
    And I populate the "Repository URL" text box with the text "GitUrl"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}020-repo-url.png"
    And I click the "Proceed" button

    And I highlight outside the "Project name" text box
    And I highlight outside the "Proceed Two" button
    And I mouse over the "Project name" text box
    And I clear the "Project name" text box
    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}030-project-name.png"
    And I click the "Proceed Two" button

    And I highlight outside the "Configure manually" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}040-configure-manually.png"
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
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}045-dotnet-test.png"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}050-dotnet-test.png"
    And I click the "Save" button

    And I click the "Got it" button waiting up to "5" seconds if it exists

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}060-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list
    And I scroll the "Docker" option into view offset by "-200"
    And I click the "Docker" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Docker Build"

    And I scroll the "Path to file" text box into view offset by "-300"
    And I populate the "Path to file" text box with "RandomQuotes/Dockerfile"

    And I scroll the "Image name:tag" text box into view offset by "-300"
    And I populate the "Image name:tag" text box with "octopusdeploy/randomquotes:1.0.%build.counter%"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}070-docker-build.png"
    And I click the "Save" button

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}080-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list
    And I scroll the "Docker" option into view offset by "-200"
    And I click the "Docker" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Docker Push"

    And I click the "Push" radio button

    And I scroll the "Image name:tag" text box into view offset by "-300"
    And I populate the "Image name:tag" text box with "octopusdeploy/randomquotes:1.0.%build.counter%"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}090-docker-push.png"
    And I click the "Save" button

  Scenario: Add Connection
    Given I set the following aliases:
      | Random Quotes   | //a[@href='/admin/editProject.html?init=1&projectId=RandomQuotes']               |
      | Show more       | //a[contains(.,'Show more')]                                                     |
      | Connections     | //a[@href='/admin/editProject.html?projectId=RandomQuotes&tab=oauthConnections'] |
      | Add Connection  | //a[contains(.,'Add Connection')]                                                |
      | Connection type | //input[@id='-ufd-teamcity-ui-typeSelector']                                     |
      | Docker Registry | //li[@data-title='Docker Registry']                                              |
      | Username        | //input[@id='userName']                                                          |
      | Password        | //input[@id='secure:userPass']                                                   |
      | Save            | (//input[@value='Save'])[1]                                                      |
      | Project Home    | //a[@href='/project.html?projectId=RandomQuotes&tab=projectOverview']            |

    And I highlight outside the "Random Quotes" project link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}100-connections.png"
    And I click the "Random Quotes" project link

    And I highlight outside the "Show more" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}110-connections.png"
    And I remove the highlight from the "Show more" link
    And I click the "Show more" link

    And I highlight outside the "Connections" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}120-connections.png"
    And I click the "Connections" link

    And I highlight outside the "Add Connection" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}130-connections.png"
    And I click the "Add Connection" button

    And I highlight outside the "Connection type" drop down list
    And I click the "Connection type" drop down list
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}130-connections.png"
    And I click the "Docker Registry" option

    And I highlight outside the "Username" text box
    And I highlight outside the "Password" text box
    And I highlight outside the "Save" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}130-connections.png"
    And I populate the "Username" text box with "ExternalDockerUsername"
    And I populate the "Password" text box with "ExternalDockerPassword"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}140-connections.png"

    And I click the "Save" button

    And I highlight outside the "Project Home" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}150-connections.png"
    And I click the "Project Home" link

  @run-build
  Scenario: Run a build
    Given I set the following aliases:
      | Run                      | //button[contains(.,'Run')]                                |
      | Build Configuration Home | //a[@href='/viewType.html?buildTypeId=RandomQuotes_Build'] |
      | Build One                | //a[contains(.,'#1')]                                      |
      | Build log                | //a[contains(.,'Build Log')]                               |

    And I start recording the screen to the directory "C:\screenshots"

    And I highlight outside the "Run" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}160-run.png"
    And I click the "Run" button
    And I sleep for "10" seconds
    And I refresh the page

    And I highlight outside the "Build One" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}170-build-one.png"
    And I click the "Build One" link
    And I click the "Build log" link
    And I scroll down "10000" px
    And I sleep for "20" seconds
    And I stop recording the screen

    And I sleep for "150" seconds
    And I start recording the screen to the directory "C:\screenshots"
    And I sleep for "5" seconds

    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}180-build-one-results.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser