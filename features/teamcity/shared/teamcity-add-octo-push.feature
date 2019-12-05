Feature: Add Push to Octopus Step
  Scenario: Add push step
    Given I set the following aliases:
      | Add build step               | //a[contains(.,'Add build step')]                          |
      | Runner type                  | //input[@id='-ufd-teamcity-ui-runTypeInfoKey']             |
      | Runner type container        | //span[./input[@id='-ufd-teamcity-ui-runTypeInfoKey']]     |
      | OctopusDeploy: Push Packages | //li[@data-title='OctopusDeploy: Push Packages']           |
      | Octopus URL                  | //input[@id='octopus_host']                                |
      | Octopus API key              | //input[@id='secure:octopus_apikey']                       |
      | Package paths                | //textarea[@id='octopus_packagepaths']                     |
      | Save                         | //input[@value='Save']                                     |
      | Step name                    | //input[@id='buildStepName']                               |

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}120-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list

    And I scroll the "OctopusDeploy: Push Packages" option into view offset by "-300"
    And I click the "OctopusDeploy: Push Packages" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I scroll the "Step name" text box into view offset by "-300"
    And I populate the "Step name" text box with "Push to Octopus"

    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}130-push-top-octo.png"

    And I remove the highlight from the "Runner type container" drop down list
    And I remove the highlight from the "Step name" text box

    And I highlight outside the "Octopus URL" text box
    And I scroll the "Octopus URL" text box into view offset by "-300"
    And I populate the "Octopus URL" text box with "http://localhost"

    And I highlight outside the "Octopus API key" text box
    And I scroll the "Octopus API key" text box into view offset by "-300"
    And I populate the "Octopus API key" text box with "ExternalOctopusAPIKey"

    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}140-push-top-octo.png"

    And I remove the highlight from the "Octopus URL" text box
    And I remove the highlight from the "Octopus API key" text box

    And I highlight outside the "Package paths" text box
    And I scroll the "Package paths" text box into view offset by "-300"
    And I populate the "Package paths" text box with "`ArtifactPath`"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view

    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}150-push-top-octo.png"

    And I click the "Save" button