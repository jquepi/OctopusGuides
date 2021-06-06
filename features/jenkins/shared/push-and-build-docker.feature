Feature: Push and build docker image

  @configure-project @repositoryspecific @localdockerrepo
  Scenario: Set the docker registry
    Given I set the following aliases:
      | Registry            | //input[@name='_.registry'] |
      | Docker registry URL | (//input[@name='_.url'])[2] |

    And I scroll the "Registry" text box into view offset by "-300"
    And I highlight outside the "Registry" text box with an offset of "2"
    And I populate the "Registry" text box with "localhost:32000"

    And I scroll the "Docker registry URL" text box into view offset by "-300"
    And I highlight outside the "Docker registry URL" text box with an offset of "2"
    And I populate the "Docker registry URL" text box with "https://localhost:32000"

  @configure-project @repositoryspecific @dockerhub
  Scenario: Set the docker registry
    Given I set the following aliases:
      | Registry            | //input[@name='_.registry'] |
      | Docker registry URL | (//input[@name='_.url'])[2] |

    And I scroll the "Registry" text box into view offset by "-300"
    And I highlight outside the "Registry" text box with an offset of "2"
    And I populate the "Registry" text box with "octopusdeploy"

    And I scroll the "Docker registry URL" text box into view offset by "-300"
    And I highlight outside the "Docker registry URL" text box with an offset of "2"
    And I populate the "Docker registry URL" text box with "https://index.docker.io/v1/"

  @configure-project @repositoryspecific @dockerhub
  Scenario: Set the credentials for a public repository
    Given I set the following aliases:
      | Registry credentials | //select[../../../../div[normalize-space(text())='Registry credentials']] |
      | Save                 | //button[@type='submit'][contains(.,'Save')]                              |

    And I scroll the "Registry credentials" drop down list into view offset by "-200"
    And I highlight outside the "Registry credentials" drop down list with an offset of "2"
    And I highlight outside the "Save" button
    And I select the option value "DockerCredentials" from the "Registry credentials" drop down list
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}310-execute-docker-command-1.png"

  @configure-project
  Scenario: Set the credentials for a public repository
    Given I set the following aliases:
      | Save | //button[@type='submit'][contains(.,'Save')] |

    And I click the "Save" button
    And I stop recording the screen

  Scenario: Build project
    And I run the feature "shared/jenkins-build.feature"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser