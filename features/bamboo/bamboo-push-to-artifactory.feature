Feature: Push to Artifactory
  @repositoryspecific @artifactory
  Scenario: Add Octopus Push
    Given I set the following aliases:
      | Add task         | //a[@id='addTask']                                                                    |
      | Script Tile      | //li[.//div[@class='task-type-description']][.//h3[normalize-space(text())='Script']] |
      | Search           | //h2[contains(.,'Task types')]//input                                                 |
      | Task description | //input[@id='createTask_userDescription']                                             |
      | Interpreter      | //select[@id='interpreter']                                                           |
      | Script body      | //div[@id='scriptBody']                                                               |
      | Save             | //input[@id='createTask_save']                                                        |

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}160-add-task-nuget-push.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Script"
    And I highlight inside the "Script Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}170-search-nuget-push.png"
    And I click the "Script Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "NuGet Push"

    And I highlight outside the "Interpreter" text box
    And I scroll the "Interpreter" drop down list into view offset by "-300"
    And I select the option "Windows PowerShell" from the "Interpreter" drop down list

    And I highlight inside the "Script body" text box
    And I scroll the "Script body" text area into view offset by "-300"
    And I run the following JavaScript:
      """
      ace.edit(scriptBody).setValue("C:\\ProgramData\\chocolatey\\bin\\nuget.exe push `\n-Source Artifactory `\n#{ArtifactPath}")
      """
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}180-nuget-push.png"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}190-nuget-push.png"
    And I click the "Save" button
    And I stop recording the screen