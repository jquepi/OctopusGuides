Feature: Install Docker Plugin
  @plugin-install @destinationspecific @k8s @microk8s
  Scenario: Install plugins
    Given I set the following aliases:
      | Available               | //a[contains(@href,'available')]                         |
      | Filter                  | #filter-box                                              |
      | Docker Plugin           | //input[@name='plugin.docker-build-step.default']        |
      | Docker Plugin Container | //td[./input[@name='plugin.docker-build-step.default']]  |
      | Install without restart | //button[text()='Install without restart']               |
      | Back to top             | //a[contains(.,'Go back to the top page')]               |

    Given I run the feature "shared/jenkins-open-plugins.feature" passing the original arguments
   
    And I click the "Available" tab
    And I populate the "Filter" text box with the text "Docker"
    And I click the "Docker Plugin" checkbox
    And I highlight inside the "Available" tab
    And I highlight outside the "Filter" tab
    And I highlight inside the "Docker Plugin Container" element
    And I highlight outside the "Install without restart" button
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}030-msbuild-plugin.png"
    And I click the "Install without restart" button
    And I wait for "5" seconds

    And I stop recording the screen
    And I sleep for "60" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Back to top" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}040-plugin-install.png"
    # fake a click
    And I open the URL "http://localhost:8080/"