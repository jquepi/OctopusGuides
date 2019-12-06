Feature: Add Artifactory NuGet feed

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username   | //input[@name='userName']                                                                                 |
      | Password   | //input[@name='password']                                                                                 |
      | Sign In    | //button[contains(.,'SIGN IN')]                                                                           |
      | Close help | //div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M11 18h2v-2h-2v2zm1-16C6.48 2 2')]] |
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button
    And I click the "Close help" button

  Scenario: Add Feed
    Given I set the following aliases:
      | Library             | //span[contains(.,'Library')]                                                  |
      | External Feeds      | //a[contains(.,'External Feeds')]                                              |
      | External Feeds text | //a[contains(.,'External Feeds')][not(*)] \| //a/span[text()='External Feeds'] |
      | Add Feed            | //button[contains(.,'Add feed')]                                               |
      | Feed name           | //input[contains(@id, 'Feedname')]                                             |
      | Feed url            | //input[contains(@id, 'Feedurl')]                                              |
      | Feed username       | //input[contains(@id, 'Feedusername')]                                         |
      | Feed password       | //input[contains(@id, 'Feedpassword')]                                         |
      | Save                | //button[@title='Save']                                                        |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Adding an external feed in Octopus" for "3" seconds

    And I highlight outside the "Library" link
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalfeeds/010-library.png"
    And I click the "Library" link

    And I highlight outside the "External Feeds text" link with an offset of "1"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalfeeds/020-external-feeds.png"
    And I click the "External Feeds" link

    And I highlight outside the "Add Feed" button with an offset of "1"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalfeeds/030-add-feed.png"
    And I remove the highlight from the "Library" link if it exists
    And I click the "Add Feed" button

    And I scroll the "Feed name" text box into view offset by "-200"
    And I highlight outside the "Feed name" text box with an offset of "1"
    And I populate the "Feed name" text box with "Artifactory"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalfeeds/040-external-feed.png"

    And I scroll the "Feed url" text box into view offset by "-200"
    And I highlight outside the "Feed url" text box with an offset of "1"
    And I populate the "Feed url" text box with "http://localhost:8041/artifactory/api/nuget/NuGet"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalfeeds/050-external-feed.png"

    And I scroll the "Feed username" text box into view offset by "-200"
    And I highlight outside the "Feed username" text box with an offset of "0"
    And I populate the "Feed username" text box with "admin"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalfeeds/060-external-feed.png"

    And I scroll the "Feed password" text box into view offset by "-200"
    And I highlight outside the "Feed password" text box with an offset of "0"
    And I populate the "Feed password" text box with "password"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalfeeds/070-external-feed.png"

    And I highlight outside the "Save" button with an offset of "1"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalfeeds/080-external-feed.png"
    And I click the "Save" button

    And I sleep for "2" seconds
    And I save a screenshot to "#{ExternalMediaPath}/octopus/externalfeeds/090-external-feed.png"

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  Scenario: Shutdown
    And I stop recording the screen
    And I close the browser