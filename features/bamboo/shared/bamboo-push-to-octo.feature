Feature: Push to built in feed
  @repositoryspecific @octo-built-in-feed
  Scenario: Add Octopus Push
    Given I set the following aliases:
      | Add task                           | //a[@id='addTask']                                                                                           |
      | Octopus Deploy: Push Packages Tile | //li[.//div[@class='task-type-description']][.//h4[normalize-space(text())='Octopus Deploy: Push Packages']] |
      | Search                             | //h2[contains(.,'Task types')]//input                                                                        |
      | Task description                   | //input[@id='createTask_userDescription']                                                                    |
      | Server URL                         | //input[@id='serverUrl']                                                                                     |
      | API key                            | //input[@id='apiKey']                                                                                        |
      | Package paths                      | //textarea[@id='pushPattern']                                                                                |
      | Save                               | //input[@id='createTask_save']                                                                               |

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}160-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Octopus"
    And I highlight inside the "Octopus Deploy: Push Packages Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}170-search.png"
    And I click the "Octopus Deploy: Push Packages Tile" element

    And I highlight outside the "Task description" text box with an offset of "5"
    And I highlight outside the "Server URL" text box with an offset of "5"
    And I highlight outside the "API key" text box with an offset of "5"

    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Push to Octopus"
    And I scroll the "Server URL" text box into view offset by "-300"
    And I clear the "Server URL" text box
    And I populate the "Server URL" text box with "http://localhost"
    And I scroll the "API key" text box into view offset by "-300"
    And I populate the "API key" text box with "ExternalOctopusAPIKey"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}173-octo-push.png"

    And I highlight outside the "Package paths" text box with an offset of "5"
    And I highlight outside the "Save" button
    And I scroll the "Package paths" text box into view offset by "-400"
    And I populate the "Package paths" text box with "ArtifactPath"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}175-octo-push.png"
    And I remove the highlight from the "Package paths" text box

    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}180-octo-push.png"
    And I click the "Save" button
    And I stop recording the screen