Feature: Add Artifactory NuGet feed

  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@name='userName']       |
      | Password | //input[@name='password']       |
      | Sign In  | //button[contains(.,'SIGN IN')] |
    And I open the shared browser "FirefoxNoImplicitWait"
    And I maximize the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

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

    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Adding an external feed in Octopus" for "3" seconds

    And I highlight outside the "Library" link
    And I save a screenshot to "C:\screenshots\octopus\externalfeeds\010-library.png"
    And I click the "Library" link

    And I save a screenshot to "C:\screenshots\octopus\externalfeeds\020-external-feeds.png"
    And I click the "External Feeds" link
    And I highlight outside the "External Feeds text" link with an offset of "2"
    And I highlight outside the "Add Feed" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\externalfeeds\030-add-feed.png"
    And I remove the highlight from the "Library" link
    And I click the "Add Feed" button

    And I scroll the "Feed name" text box into view offset by "-200"
    And I highlight outside the "Feed name" text box with an offset of "2"
    And I populate the "Feed name" text box with "Artifactory"
    And I save a screenshot to "C:\screenshots\octopus\externalfeeds\040-external-feed.png"

    And I scroll the "Feed url" text box into view offset by "-200"
    And I highlight outside the "Feed url" text box with an offset of "2"
    And I populate the "Feed url" text box with "http://localhost:8041/artifactory/api/nuget/NuGet"
    And I save a screenshot to "C:\screenshots\octopus\externalfeeds\050-external-feed.png"

    And I scroll the "Feed username" text box into view offset by "-200"
    And I highlight outside the "Feed username" text box with an offset of "2"
    And I populate the "Feed username" text box with "admin"
    And I save a screenshot to "C:\screenshots\octopus\externalfeeds\060-external-feed.png"

    And I scroll the "Feed password" text box into view offset by "-200"
    And I highlight outside the "Feed password" text box with an offset of "2"
    And I populate the "Feed password" text box with "password"
    And I save a screenshot to "C:\screenshots\octopus\externalfeeds\070-external-feed.png"

    And I highlight outside the "Save" button with an offset of "2"
    And I save a screenshot to "C:\screenshots\octopus\externalfeeds\080-external-feed.png"
    And I click the "Save" button