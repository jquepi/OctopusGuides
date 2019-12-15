Feature: Configure Bamboo

  Scenario: Configure Bamboo
    Given I run the feature "shared/bamboo-login.feature" passing the original arguments
    And I run the feature "shared/bamboo-add-plugin.feature" passing the original arguments
    And I run the feature "shared/bamboo-configure-docker.feature" passing the original arguments
    And I run the feature "shared/bamboo-configure-octopus.feature" passing the original arguments
    And I run the feature "shared/bamboo-add-project.feature" passing the original arguments

  @applicationspecific @nodejs
  Scenario: Node.js Add tasks
    Given I set the following aliases:
      | Add task           | //a[@id='addTask']                                                                 |
      | Search             | //h2[contains(.,'Task types')]//input                                              |
      | NPM Tile           | //li[.//div[@class='task-type-description']][.//h3[normalize-space(text())='npm']] |
      | Task description   | //input[@id='createTask_userDescription']                                          |
      | Command            | //input[@id='command']                                                             |
      | Add new executable | //a[@class='addSharedBuilderCapability']                                           |
      | Executable label   | //input[@id='addSharedBuilderCapability_builderLabel']                             |
      | Path               | //input[@id='addSharedBuilderCapability_builderPath']                              |
      | Add                | //input[@id='addSharedBuilderCapability_save']                                     |
      | Save               | //input[@id='createTask_save']                                                     |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}100-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Node"
    And I highlight inside the "NPM Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}110-search.png"
    And I click the "NPM Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "npm Install"

    And I highlight outside the "Add new executable" link
    And I click the "Add new executable" link
    And I highlight outside the "Executable label" text box
    And I highlight outside the "Path" text box
    And I highlight outside the "Add" button with an offset of "5"
    And I populate the "Executable label" text box with "node"
    And I populate the "Path" text box with "/usr/bin/node"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}115-npm-executable.png"
    And I click the "Add" button

    And I highlight outside the "Command" text box
    And I scroll the "Command" text box into view offset by "-300"
    And I populate the "Command" text box with "install"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}120-npm-install.png"
    And I click the "Save" button

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}130-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Node"
    And I highlight inside the "NPM Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}140-search.png"
    And I click the "NPM Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "npm Test"

    And I highlight outside the "Command" text box
    And I scroll the "Command" text box into view offset by "-300"
    And I populate the "Command" text box with "test"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}150-npm-test.png"
    And I click the "Save" button

  @destinationspecific @k8s
  Scenario: Docker Add tasks
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
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}160-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Docker"
    And I highlight inside the "Docker Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}170-search.png"
    And I click the "Docker Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Docker Build"

    And I highlight outside the "Repository" text box
    And I scroll the "Repository" text box into view offset by "-300"
    And I populate the "Repository" text box with "index.docker.io/octopusdeploy/randomquotesnodejs:1.0.${bamboo.buildNumber}"

    And I highlight outside the "Use an existing Dockerfile in the tasks working directory" radio button
    And I scroll the "Use an existing Dockerfile in the tasks working directory" radio button into view offset by "-300"
    And I click the "Use an existing Dockerfile in the tasks working directory" radio button

    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}180-docker-build.png"
    And I click the "Save" button

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}190-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Docker"
    And I highlight inside the "Docker Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}200-search.png"
    And I click the "Docker Tile" element

    # Don't highlight this to save a screenshot
    #And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Docker Push"

    And I highlight outside the "Command" drop down list
    And I scroll the "Command" drop down list into view offset by "-300"
    And I select the option value "push" from the "Command" drop down list

    And I highlight outside the "Push repository" text box
    And I scroll the "Push repository" text box into view offset by "-300"
    And I populate the "Push repository" text box with "octopusdeploy/randomquotesnodejs:1.0.${bamboo.buildNumber}"

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
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}210-docker-push.png"
    And I click the "Save" button

    And I highlight outside the "Create" button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}220-create-project.png"
    And I click the "Create" button
    And I sleep for "5" seconds

  Scenario: Create plan
    And I run the feature "shared/bamboo-create-plan.feature"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser