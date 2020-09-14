Feature: Open plugins

  @plugin-install
  Scenario: Open plugins
    Given I set the following aliases:
      | Manage Jenkins | (//a[@href="/manage"])[2]             |
      | Manage Plugins | //a[@href='pluginManager']       |
      | Available      | //a[contains(@href,'available')] |

    And I display a note with the text "Installing the Jenkins plugins" for "3" seconds

    And I highlight inside the "Manage Jenkins" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}005-manage-jenkins.png"
    And I click the "Manage Jenkins" link
    And I scroll the "Manage Plugins" link into view offset by "-100"
    # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Manage Plugins" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}010-manage-plugins.png"
    And I click the "Manage Plugins" link
    