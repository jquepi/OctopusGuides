Feature: Add Docker build feature

  @add-build-feature
  Scenario: Run a build
    Given I set the following aliases:
      | No thanks                                      | //button[contains(.,'No, thanks')]                                                |
      | Build                                          | //a[@href='/viewType.html?buildTypeId=RandomQuotes_Build']                        |
      | Edit Configuration Settings                    | //a[@title='Edit build configuration settings']                                   |
      | Build Features                                 | //a[@href='/admin/editBuildFeatures.html?init=1&id=buildType:RandomQuotes_Build'] |
      | Add build feature                              | //a[contains(.,'Add build feature')]                                              |
      | Features                                       | //input[@ID='-ufd-teamcity-ui-featureTypeSelector']                               |
      | Docker Support                                 | //li[@data-title='Docker Support']                                                |
      | Log in to the Docker registry before the build | //input[@id='loginCheckbox']                                                      |
      | Docker registries                              | //select[@id='login2registry']                                                    |
      | Save                                           | //input[@id='submitBuildFeatureId']                                               |

    And I stop recording the screen
    And I click the "No thanks" button if it exists
    And I sleep for "1" second

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight the "Build" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}100-docker-feature.png"
    And I click the "Build" link

    And I highlight the "Edit Configuration Settings" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}110-docker-feature.png"
    And I click the "Edit Configuration Settings" link

    And I highlight the "Build Features" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}120-docker-feature.png"
    And I click the "Build Features" link

    And I highlight the "Add build feature" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}130-docker-feature.png"
    And I click the "Add build feature" button

    And I highlight the "Features" drop down list
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}140-docker-feature.png"
    And I click the "Features" drop down list

    And I highlight the "Docker Support" option
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}150-docker-feature.png"
    And I click the "Docker Support" option

    And I highlight the "Log in to the Docker registry before the build" option
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}160-docker-feature.png"
    And I click the "Log in to the Docker registry before the build" option

    And I highlight the "Docker registries" drop down list
    And I select the option "Docker Registry" from the "Docker registries" drop down list

    And I highlight the "Save" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}170-docker-feature.png"
    And I click the "Save" button