Feature: Define Java Project Variables
  @define-project
  Scenario: Define spring profile ports
    Given I set the following aliases:
      | New variable name       | //input[@name='Enter new variable']                |
      | New variable value      | //input[@name='Enter value']                       |
      | Save                    | //button[contains(.,'Save')]                       |

    And I populate the "New variable name" text box with "spring:profiles:active"
    And I populate the "New variable value" text box with "#{Octopus.Environment.Name}"

    And I click the "Save" button
    And I scroll down "10000" px

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "120" seconds

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}025-octopus-variables-populated.png"

  @define-project
  Scenario: Open the deployments view
    Given I set the following aliases:
      | Overview    | //a[contains(.,'Overview')][not(*)] \| //a//div[text()='Overview'] |
      | Deployments | //a[contains(.,'Deployments')]                                     |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I highlight inside the "Deployments" link
    And I click the "Deployments" link
    And I highlight inside the "Overview" link
    And I click the "Overview" link
    And I remove the highlight from the "Deployments" link