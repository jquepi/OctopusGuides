Feature: Create Project

  @create-project
  Scenario: Create Project
    Given I set the following aliases:
      | Projects         | //span[contains(.,'Projects')]               |
      | Add project      | //div[./div/span[contains(.,'Add Project')]] |
      | New project name | //input[@name='New project name']            |
      | Save             | (//div[contains(.,'Save')])[8]               |

    And I highlight outside the "Projects" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}005-octopus-projects.png"
    And I click the "Projects" link
    And I sleep for "1" second

    And I highlight outside the "Add project" link with an offset of "1"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}010-octopus-add-project.png"
    And I click the "Add project" button
    And I remove the highlight from the "Add project" link
    And I remove the highlight from the "Projects" link

    And I highlight outside the "New project name" text box with an offset of "2"
    And I highlight outside the "Save" button with an offset of "2"
    And I populate the "New project name" text box with "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}015-octopus-new-project-name.png"
    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"