Feature: Configure Bamboo

  Scenario: Configure Bamboo
    Given I run the feature "bamboo-login.feature"
    And I run the feature "bamboo-add-plugin.feature"
    And I run the feature "bamboo-configure-jdk.feature"
    And I run the feature "bamboo-configure-octopus.feature"
    And I run the feature "bamboo-configure-maven.feature"
    And I run the feature "bamboo-add-project.feature"

  @applicationspecific @java
  Scenario: Java Add tasks
    Given I set the following aliases:
      | Add task         | //a[@id='addTask']                                                                       |
      | Search           | //h2[contains(.,'Task types')]//input                                                    |
      | Maven Tile       | //li[.//div[@class='task-type-description']][.//h3[normalize-space(text())='Maven 3.x']] |
      | Task description | //input[@id='createTask_userDescription']                                                |
      | Goal             | //textarea[@id='goal']                                                                   |
      | Build JDK        | //select[@id='buildJdk']                                                                 |
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

    And I highlight outside the "Goal" text box
    And I scroll the "Goal" text box into view offset by "-300"
    And I clear the "Goal" text box
    And I populate the "Goal" text box with "clean test package -Pwar"

    And I scroll the "Build JDK" drop down list into view
    And I highlight outside the "Build JDK" drop down list
    And I select the option value "JDK" from the "Build JDK" drop down

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}120-maven-test.png"
    And I click the "Save" button

  @repositoryspecific @octo-built-in-feed
  Scenario: Add Octopus Push
    And I run the feature "bamboo-push-to-octo.feature"

  @repositoryspecific @artifactory
  Scenario: Add Octopus Push
    And I run the feature "bamboo-push-to-artifactory.feature"

  Scenario: Create plan
    And I run the feature "bamboo-create-plan.feature"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser