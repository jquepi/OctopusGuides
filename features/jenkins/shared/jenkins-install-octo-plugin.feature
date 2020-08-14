Feature: Install the octopus plugin

  @plugin-install
  Scenario: Install Octopus plugins
    Given I set the following aliases:
      | Available                | //a[contains(@href,'available')]                    |
      | Filter                   | #filter-box                                         |
      | Octopus Plugin           | //input[@name='plugin.octopusdeploy.default']       |
      | Octopus Plugin Container | //td[./input[@name='plugin.octopusdeploy.default']] |
      | Install without restart  | //button[text()='Install without restart']          |
      | Back to top              | //a[contains(.,'Go back to the top page')]          |

    Given I run the feature "shared/jenkins-open-plugins.feature" passing the original arguments

    And I click the "Available" tab
    And I populate the "Filter" text box with the text "Octopus"
    And I click the "Octopus Plugin" checkbox
    And I highlight inside the "Available" tab
    And I highlight outside the "Filter" tab
    And I highlight inside the "Octopus Plugin Container" element
    And I highlight outside the "Install without restart" button
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}010-octopus-plugin.png"
    And I click the "Install without restart" button
    And I wait for "5" seconds

    And I stop recording the screen
    And I sleep for "60" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Back to top" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}020-octopus-plugin-install.png"
    # fake a click
    And I open the URL "http://localhost:8080/"

  @plugin-install
  Scenario: Configure server
    Given I set the following aliases:
      | Manage Jenkins   | //a[@class='task-link' and contains(.,'Manage Jenkins')] |
      | Configure System | //a[@href='configure']                                   |
      | Server Id        | //input[@name='_.serverId']                              |
      | URL              | (//input[@name='_.url'])[3]                              |
      | API Key          | //input[@name='_.apiKey']                                |
      | Save             | //button[@type='button'][contains(.,'Save')]             |

    And I display a note with the text "Configuring the Octopus server" for "3" seconds

    And I highlight inside the "Manage Jenkins" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}005-manage-jenkins.png"
    And I click the "Manage Jenkins" link
    And I scroll the "Configure System" link into view offset by "-100"
    # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Configure System" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}010-configure-system.png"
    And I click the "Configure System" link

    And I scroll the "Server Id" text box into view offset by "-200"
    And I highlight the "Server Id" text box
    And I populate the "Server Id" text box with "Local"

    And I highlight the "URL" text box
    And I populate the "URL" text box with "http://localhost"

    And I highlight the "API Key" text box
    And I populate the "API Key" text box with "#{ExternalOctopusAPIKey}"

    And I click the "Save" button

  @plugin-install
  Scenario: Configure global tools
    Given I set the following aliases:
      | Manage Jenkins            | //a[@class='task-link' and contains(.,'Manage Jenkins')] |
      | Global Tool Configuration | //a[@href='configureTools']                              |
      | Path                      | (//input[@name='_.home'])[2]                             |
      | Save                      | //button[@type='button'][contains(.,'Save')]             |

    And I display a note with the text "Configuring the Octopus server" for "3" seconds

    And I highlight inside the "Manage Jenkins" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}005-manage-jenkins.png"
    And I click the "Manage Jenkins" link
    And I scroll the "Global Tool Configuration" link into view offset by "-100"
    # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Global Tool Configuration" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}010-configure-tools.png"
    And I click the "Global Tool Configuration" link

    And I scroll the "Path" text box into view offset by "-200"
    And I highlight the "Path" text box
    And I clear the "Path" text box
    And I populate the "Path" text box with "/opt/octo/Octo"

    And I click the "Save" button