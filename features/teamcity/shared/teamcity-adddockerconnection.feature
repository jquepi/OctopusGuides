Feature: Add Docker connection
  Scenario: Add Connection
    Given I set the following aliases:
      | Random Quotes   | //a[@href='/admin/editProject.html?init=1&projectId=RandomQuotes']               |
      | Show more       | //a[contains(.,'Show more')]                                                     |
      | Connections     | //a[@href='/admin/editProject.html?projectId=RandomQuotes&tab=oauthConnections'] |
      | Add Connection  | //a[contains(.,'Add Connection')]                                                |
      | Connection type | //input[@id='-ufd-teamcity-ui-typeSelector']                                     |
      | Docker Registry | //li[@data-title='Docker Registry']                                              |
      | Username        | //input[@id='userName']                                                          |
      | Password        | //input[@id='secure:userPass']                                                   |
      | Save            | (//input[@value='Save'])[1]                                                      |
      | Project Home    | //a[@href='/project.html?projectId=RandomQuotes&tab=projectOverview']            |

    And I highlight outside the "Random Quotes" project link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}100-connections.png"
    And I click the "Random Quotes" project link

    And I highlight outside the "Show more" link if it exists
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}110-connections.png"
    And I remove the highlight from the "Show more" link if it exists
    And I click the "Show more" link if it exists

    And I highlight outside the "Connections" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}120-connections.png"
    And I click the "Connections" link

    And I highlight outside the "Add Connection" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}140-connections.png"
    And I click the "Add Connection" button

    And I highlight outside the "Connection type" drop down list
    And I click the "Connection type" drop down list
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}150-connections.png"
    And I click the "Docker Registry" option

    And I highlight outside the "Username" text box
    And I highlight outside the "Password" text box
    And I highlight outside the "Save" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}160-connections.png"
    And I populate the "Username" text box with "ExternalDockerUsername"
    And I populate the "Password" text box with "ExternalDockerPassword"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}170-connections.png"

    And I click the "Save" button

    And I highlight outside the "Project Home" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}180-connections.png"
    And I click the "Project Home" link

    And I stop recording the screen