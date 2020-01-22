Feature: Create Project Manually
  These steps manually configure a project. This is here for reference only - we use the automatic
  project creation functionality for the guides.

  @create-project
  Scenario: Create Project Manually
    Given I set the following aliases:
      | Create project                     | //a[contains(.,'Create project')]             |
      | Manually                           | //a[@href='#createManually']                  |
      | Name                               | //input[@id='name']                           |
      | Create                             | //input[@id='createProject']                  |
      | Create build configuration         | //a[contains(.,'Create build configuration')] |
      | Build Configuration Name           | //input[@id='buildTypeName']                  |
      | Create Two                         | //input[@name='createBuildType']              |
      | Build Configuration Repository URL | //input[@id='repositoryUrl']                  |
      | Create Three                       | //input[@value='Create']                      |
      | Build Steps                        | //a[text()='Build Steps']                     |
      | Add build step                     | //a[contains(.,'Add build step')]             |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Create the TeamCity project" for "3" seconds

    And I highlight outside the "Create project" button with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}010-manual-project.png"
    And I click the "Create project" button

    And I highlight outside the "Manually" button with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}020-manual-project.png"
    And I remove the highlight from the "Manually" button
    And I click the "Manually" button

    And I highlight outside the "Name" text box
    And I populate the "Name" text box with the text "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}030-manual-project.png"

    And I highlight outside the "Create" button with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}040-manual-project.png"
    And I click the "Create" button

    And I highlight outside the "Create build configuration" button with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}050-manual-project.png"
    And I click the "Create build configuration" button

    And I highlight outside the "Build Configuration Name" text box
    And I populate the "Build Configuration Name" text box with the text "Build"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}060-manual-project.png"

    And I highlight outside the "Create Two" button with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}070-manual-project.png"
    And I click the "Create Two" button

    And I highlight outside the "Build Configuration Repository URL" text box
    And I populate the "Build Configuration Repository URL" text box with the text "GitUrl"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}080-manual-project.png"

    And I highlight outside the "Create Three" button with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}090-manual-project.png"
    And I click the "Create Three" button

    And I highlight outside the "Build Steps" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}100-manual-project.png"
    And I click the "Build Steps" link

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}110-manual-project.png"
    And I click the "Add build step" button