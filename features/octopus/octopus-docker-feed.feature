Feature: Create Azure Web App Target

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments

  @define-feed
  Scenario: Add docker feed
    Given I set the following aliases:
      | More                      | //span[contains(.,'More')]                                                     |
      | Library                   | //span[contains(.,'Library')]                                                  |
      | External Feeds            | //a[contains(.,'External Feeds')]                                              |
      | External Feeds text       | //a[contains(.,'External Feeds')][not(*)] \| //a/span[text()='External Feeds'] |
      | Add Feed                  | //button[contains(.,'Add feed')]                                               |
      | Feed type                 | //div[../../div[text()='Feed type']]                                           |
      | Docker Container Registry | //div[./div/div[text()='Docker Container Registry']]                           |
      | Feed name                 | //input[contains(@id,'Feedname')]                                              |
      | Expand All                | //a[text()='EXPAND ALL']                                                       |

    And I start recording the screen to the directory "ExternalMediaPath"
    And I display a note with the text "Create a Docker feed" for "3" seconds
    And I click the "More" link waiting up to "1" seconds if the "Library" link does not exist

    And I highlight outside the "Library" link
    And I save a screenshot to "#{ExternalMediaPath}/octopus/target/docker/010-feed-library.png"
    And I click the "Library" link

    And I save a screenshot to "#{ExternalMediaPath}/octopus/target/docker/020-feed-feeds.png"
    And I click the "External Feeds" link
    And I highlight outside the "External Feeds text" link with an offset of "2"
    And I highlight outside the "Add Feed" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/target/docker/030-feed-add-feed.png"
    And I remove the highlight from the "Library" link if it exists
    And I click the "Add Feed" button

    And I highlight outside the "Feed type" drop down list
    And I click the "Feed type" drop down list
    And I click the "Docker Container Registry" option

    And I stop recording the screen
    And I sleep for "5" seconds
    And I click the "Expand All" link if the "Feed name" text box does not exist
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Feed name" text box
    And I scroll the "Feed name" text box into view offset by "-300"
    And I populate the "Feed name" text box with "Docker"

  @define-feed @repositoryspecific @localdockerrepo
  Scenario: Define the local feed url
    Given I set the following aliases:
      | URL           | //input[contains(@id,'Feedurl')]      |
      | Registry path | //input[contains(@id,'Registrypath')] |

    And I force clear the "URL" text box
    And I populate the "URL" text box with "http://registry:5000"

    And I populate the "Registry path" text box with "localhost:5000"

  @define-feed
  Scenario: Add docker feed
    Given I set the following aliases:
      | Save | //button[@title='Save'] |

    And I highlight outside the "Save" button
    And I save a screenshot to "#{ExternalMediaPath}/octopus/target/docker/040-feed-add-feed.png"
    And I click the "Save" button
    And I sleep for "1" seconds

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser