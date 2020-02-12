Feature: Configure Bamboo

  Scenario: Configure Bamboo
    Given I run the feature "shared/bamboo-login.feature" passing the original arguments
    And I run the feature "shared/bamboo-manually-add-plugin.feature" passing the original arguments
    And I run the feature "shared/bamboo-configure-docker.feature" passing the original arguments
    And I run the feature "shared/bamboo-configure-octopus.feature" passing the original arguments
    And I run the feature "shared/bamboo-add-project.feature" passing the original arguments

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
    And I select the option "Shell" from the "Interpreter" drop down list

    And I highlight inside the "Script body" text box
    And I scroll the "Script body" text area into view offset by "-300"
    And I run the following JavaScript:
      """
      ace.edit(scriptBody).setValue("composer install\n./vendor/bin/phpunit --bootstrap ./vendor/autoload.php ./tests/quotetest.php")
      """
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}120-dotnet-test.png"
    And I remove the highlight from the "Script body" text box

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}130-dotnet-test.png"
    And I click the "Save" button

  @destinationspecific @k8s
  Scenario: ASP.NET Core Add tasks
    Given I set the following aliases:
      | Add task                                                  | //a[@id='addTask']                                                                         |
      | Search                                                    | //h2[contains(.,'Task types')]//input                                                      |
      | Docker Tile                                               | (//li[.//div[@class='task-type-description']][.//h3[normalize-space(text())='Docker']])[1] |
      | Task description                                          | //input[@id='createTask_userDescription']                                                  |
      | Command                                                   | //select[@id='commandOption']                                                              |
      | Repository                                                | //input[@id='repository']                                                                  |
      | Use an existing Dockerfile in the tasks working directory | //input[@id='dockerfileOptionexisting']                                                    |
      | Advanced options                                          | //h3[text()='Advanced options']                                                            |
      | Working subdirectory                                      | //input[@id='workingSubDirectory']                                                         |
      | Push repository                                           | //input[@id='pushRepository']                                                              |
      | Provide username and password                             | //input[@id='pushCredentialsSourceUSER']                                                   |
      | Username                                                  | //input[@id='username']                                                                    |
      | Password                                                  | //input[@id='password']                                                                    |
      | Save                                                      | //input[@id='createTask_save']                                                             |
      | Create                                                    | //button[@id='createPlan']                                                                 |


    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}140-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Docker"
    And I highlight inside the "Docker Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}150-search.png"
    And I click the "Docker Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Docker Build"

    And I highlight outside the "Repository" text box
    And I scroll the "Repository" text box into view offset by "-300"
    And I populate the "Repository" text box with "index.docker.io/octopusdeploy/randomquotesphp:1.0.${bamboo.buildNumber}"

    And I highlight outside the "Use an existing Dockerfile in the tasks working directory" radio button
    And I scroll the "Use an existing Dockerfile in the tasks working directory" radio button into view offset by "-300"
    And I click the "Use an existing Dockerfile in the tasks working directory" radio button

    And I highlight outside the "Advanced options" heading
    And I scroll the "Advanced options" heading into view offset by "-300"
    And I click the "Advanced options" heading

    And I highlight outside the "Working subdirectory" text box
    And I scroll the "Working subdirectory" text box into view offset by "-300"
    And I populate the "Working subdirectory" text box with "RandomQuotes"

    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}160-docker-build.png"
    And I click the "Save" button

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}170-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Docker"
    And I highlight inside the "Docker Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}180-search.png"
    And I click the "Docker Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Docker Push"

    And I highlight outside the "Command" drop down list
    And I scroll the "Command" drop down list into view offset by "-300"
    And I select the option value "push" from the "Command" drop down list

    And I highlight outside the "Push repository" text box
    And I scroll the "Push repository" text box into view offset by "-300"
    And I populate the "Push repository" text box with "octopusdeploy/randomquotesphp:1.0.${bamboo.buildNumber}"

    And I highlight outside the "Provide username and password" radio button
    And I scroll the "Provide username and password" radio button into view offset by "-300"
    And I click the "Provide username and password" radio button

    And I highlight outside the "Username" text box
    And I scroll the "Username" text box into view offset by "-300"
    And I populate the "Username" text box with "ExternalDockerUsername"

    And I highlight outside the "Password" text box
    And I scroll the "Password" text box into view offset by "-300"
    And I populate the "Password" text box with "ExternalDockerPassword"

    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}190-docker-push.png"
    And I click the "Save" button

    And I highlight outside the "Create" button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}200-create-project.png"
    And I click the "Create" button
    And I sleep for "5" seconds

  Scenario: Create plan
    And I run the feature "shared/bamboo-create-plan.feature"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser