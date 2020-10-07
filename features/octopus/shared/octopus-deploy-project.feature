Feature: Deploy project
  @deploy-project
  Scenario: Deploy project
    Given I set the following aliases:
      | Create Release | //button[@title='Create release']        |
      | Save           | //button[@title='Save']                  |
      | Deploy To Dev  | //button[contains(.,'Deploy to Dev...')] |
      | Deploy         | //button[@title='Deploy']                |
      | Task Log       | //button[contains(.,'Task Log')]         |

    And I open the URL "#{OctopusURL:-http://localhost}/app#/Spaces-1/projects/random-quotes/overview"
    And I sleep for "1" second

    And I highlight inside the "Create Release" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}170-octopus-create-release.png"
    And I click the "Create Release" button

    And I highlight outside the "Save" button
    And I sleep for "1" second

    # Give the release some time to get the data
    And I stop recording the screen
    And I sleep for "10" seconds
    And I start recording the screen to the directory "ExternalMediaPath"

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}180-octopus-save-release.png"
    And I remove the highlight from the "Save" button
    And I force click the "Save" button
    And I sleep for "1" second

    And I highlight outside the "Deploy To Dev" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}190-octopus-deploy-to-dev.png"
    And I click the "Deploy To Dev" button

    And I highlight outside the "Deploy" button
    And I sleep for "3" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}200-octopus-deploy.png"
    And I force click the "Deploy" button

    And I stop recording the screen
    And I sleep for "300" seconds

    And I start recording the screen to the directory "ExternalMediaPath"
    And I sleep for "2" seconds
    And I click the "Task Log" button
    And I sleep for "2" seconds

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}210-octopus-deployment.png"