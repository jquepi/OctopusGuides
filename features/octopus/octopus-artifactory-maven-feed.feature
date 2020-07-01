Feature: Add Artifactory Maven feed

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments

  Scenario: Add Feed
    Given I set the following aliases:
      | Library             | //span[contains(.,'Library')]                                                  |
      | External Feeds      | //a[contains(.,'External Feeds')]                                              |
      | External Feeds text | //a[contains(.,'External Feeds')][not(*)] \| //a/span[text()='External Feeds'] |
      | Add Feed            | //button[contains(.,'Add feed')]                                               |
      | Feed Type           | //div[../../div[text()='Feed type']]                                           |
      | Maven Feed          | //span[./div/div/div[text()='Maven Feed']]                                     |
      | Feed name           | //input[contains(@id, 'Feedname')]                                             |
      | Feed url            | //input[contains(@id, 'Feedurl')]                                              |
      | Feed username       | //input[contains(@id, 'Feedusername')]                                         |
      | Feed password       | //input[contains(@id, 'Feedpassword')]                                         |
      | Save                | //button[@title='Save']                                                        |
      | Expand All          | //a[text()='EXPAND ALL']                                                       |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Adding an external feed in Octopus" for "3" seconds

    And I highlight outside the "Library" link
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalmavenfeeds/010-library.png"
    And I click the "Library" link

    And I highlight outside the "External Feeds text" link with an offset of "1"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalmavenfeeds/020-external-feeds.png"
    And I click the "External Feeds" link

    And I highlight outside the "Add Feed" button with an offset of "1"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalmavenfeeds/030-add-feed.png"
    And I remove the highlight from the "Library" link if it exists
    And I click the "Add Feed" button

    And I stop recording the screen
    And I sleep for "5" seconds
    And I click the "Expand All" link if the "Feed Type" text box does not exist
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I scroll the "Feed Type" drop down list into view offset by "-200"
    And I highlight outside the "Feed Type" text box with an offset of "1"
    And I click the "Feed Type" drop down list
    And I click the "Maven Feed" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalmavenfeeds/035-maven-feed.png"

    And I stop recording the screen
    And I sleep for "5" seconds
    And I click the "Expand All" link if the "Feed name" text box does not exist
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I scroll the "Feed name" text box into view offset by "-200"
    And I highlight outside the "Feed name" text box with an offset of "1"
    And I populate the "Feed name" text box with "Artifactory"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalmavenfeeds/040-external-feed.png"

    And I scroll the "Feed url" text box into view offset by "-200"
    And I highlight outside the "Feed url" text box with an offset of "1"
    And I clear the "Feed url" text box
    And I populate the "Feed url" text box with "http://artifactory:8081/artifactory/Maven"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalmavenfeeds/050-external-feed.png"

    And I scroll the "Feed username" text box into view offset by "-200"
    And I highlight outside the "Feed username" text box with an offset of "0"
    And I populate the "Feed username" text box with "admin"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalmavenfeeds/060-external-feed.png"

    And I scroll the "Feed password" text box into view offset by "-200"
    And I highlight outside the "Feed password" text box with an offset of "0"
    And I populate the "Feed password" text box with "Password01!"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalmavenfeeds/070-external-feed.png"

    And I highlight outside the "Save" button with an offset of "1"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalmavenfeeds/080-external-feed.png"
    And I click the "Save" button

    And I sleep for "1" seconds
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalmavenfeeds/090-external-feed.png"
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  Scenario: Shutdown
    And I stop recording the screen
    And I close the browser