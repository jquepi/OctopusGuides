Feature: Configure Bamboo

  Scenario: Configure Bamboo
    Given I run the feature "shared/bamboo-login.feature" passing the original arguments
    And I run the feature "shared/bamboo-add-plugin.feature"
    And I run the feature "shared/bamboo-configure-jdk.feature"
    And I run the feature "shared/bamboo-configure-docker.feature"
    And I run the feature "shared/bamboo-configure-octopus.feature"
    And I run the feature "shared/bamboo-configure-maven.feature"
    And I run the feature "shared/bamboo-add-project.feature"

  @applicationspecific @java
  Scenario: Java Add tasks
    Given I set the following aliases:
      | Add task         | //a[@id='addTask']                                                                       |
      | Search           | //h2[contains(.,'Task types')]//input                                                    |
      | Maven Tile       | //li[.//div[@class='task-type-description']][.//h3[normalize-space(text())='Maven 3.x']] |
      | Task description | //input[@id='createTask_userDescription']                                                |
      | Build JDK        | //select[@id='buildJdk']                                                                  |
      | Save             | //input[@id='createTask_save']                                                           |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}100-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Maven"
    And I highlight inside the "Maven Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}110-search.png"
    And I click the "Maven Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Maven test"

    And I scroll the "Build JDK" drop down list into view
    And I highlight outside the "Build JDK" drop down list
    And I select the option value "JDK" from the "Build JDK" drop down

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}120-maven-test.png"
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
    And I populate the "Repository" text box with "index.docker.io/octopusdeploy/randomquotesjava:1.0.${bamboo.buildNumber}"

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
    And I populate the "Push repository" text box with "octopusdeploy/randomquotesjava:1.0.${bamboo.buildNumber}"

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