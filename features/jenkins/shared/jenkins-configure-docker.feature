Feature: Configure docker

  @configure-docker
  Scenario: Configure Docker
    Given I set the following aliases:
      | Manage Jenkins   | //div[contains(@class, 'task')][.//a[@href="/manage"]]           |
      | Configure System | //a[@href='configure']       |
      | Docker URL       | //input[@name='_.dockerUrl'] |
      | Save             | //button[text()='Save']      |

    And I open the URL "http://localhost:8080/"
    And I clear the transition

    And I display a note with the text "Configure Docker" for "3" seconds

    And I highlight inside the "Manage Jenkins" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}140-manage-jenkins.png"
    And I click the "Manage Jenkins" link

    And I scroll the "Configure System" link into view offset by "-100"
    # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Configure System" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}150-configure-system.png"
    And I click the "Configure System" link

    And I scroll the "Docker URL" text box into view offset by "-300"
    And I highlight outside the "Docker URL" text box
    And I highlight outside the "Save" button
    And I populate the "Docker URL" text box with "unix:///var/run/docker.sock"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}160-dockerurl.png"
    And I click the "Save" button