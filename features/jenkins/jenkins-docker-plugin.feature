Feature: Install Docker Plugin
  @plugin-install @destinationspecific @k8s
  Scenario: Install plugins
    Given I set the following aliases:
      | Manage Jenkins          | //a[@class='task-link' and contains(.,'Manage Jenkins')] |
      | Manage Plugins          | //a[@href='pluginManager']                               |
      | Available               | //a[contains(@href,'available')]                         |
      | Filter                  | #filter-box                                              |
      | Docker Plugin           | //input[@name='plugin.docker-build-step.default']        |
      | Docker Plugin Container | //td[./input[@name='plugin.docker-build-step.default']]  |
      | Install without restart | //button[text()='Install without restart']               |
      | Back to top             | //a[contains(.,'Go back to the top page')]               |

    And I display a note with the text "Installing the Jenkins plugins" for "3" seconds

    And I highlight inside the "Manage Jenkins" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}010-manage-jenkins.png"
    And I click the "Manage Jenkins" link
    And I scroll the "Manage Plugins" link into view offset by "-100"
    # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Manage Plugins" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}020-manage-plugins.png"
    And I click the "Manage Plugins" link
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