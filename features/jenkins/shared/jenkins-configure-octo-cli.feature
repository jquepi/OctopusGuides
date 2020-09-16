Feature: Install the octopus plugin

  @plugin-install
  Scenario: Configure global tools
    Given I set the following aliases:
      | Manage Jenkins            | //div[contains(@class, 'task')][.//a[@href="/manage"]] |
      | Global Tool Configuration | //a[@href='configureTools']                            |
      | Path                      | (//input[@name='_.home'])[2]                           |
      | Save                      | //button[@type='button'][contains(.,'Save')]           |

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

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}020-configured-tools.png"

    And I click the "Save" button