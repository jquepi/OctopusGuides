Feature: Create Azure Web App Target

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@name='userName']       |
      | Password | //input[@name='password']       |
      | Sign In  | //button[contains(.,'SIGN IN')] |
    And I open the shared browser "ChromeNoImplicitWait"
    And I maximize the window
    #And I set the window size to "1024" x "768"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"

    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

  @define-lifecycle
  Scenario: Add docker feed
    Given I set the following aliases:
      | Library                   | //span[contains(.,'Library')]                                                  |
      | External Feeds            | //a[contains(.,'External Feeds')]                                              |
      | External Feeds text       | //a[contains(.,'External Feeds')][not(*)] \| //a/span[text()='External Feeds'] |
      | Add Feed                  | //button[contains(.,'Add Feed')]                                               |
      | Feed type                 | //div[../../div[text()='Feed type']]                                           |
      | Docker Container Registry | //div[./div/div[text()='Docker Container Registry']]                           |
      | Feed name                 | //input[contains(@id,'Feedname')]                                              |
      | Save                      | //button[@title='Save']                                                        |


    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Create a lifecycle in Octopus" for "3" seconds

    And I highlight outside the "Library" link
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\#{GuideSpecificScreenshotDir}005-lifecycle-library.png"
    And I click the "Library" link

    And I save a screenshot to "C:\screenshots\octopus\lifecycle\#{GuideSpecificScreenshotDir}010-lifecycle-lifecycles.png"
    And I click the "External Feeds" link
    And I highlight outside the "External Feeds text" link with an offset of "2"
    And I highlight outside the "Add Lifecycle" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\lifecycle\#{GuideSpecificScreenshotDir}015-lifecycle-add-lifecycle.png"
    And I remove the highlight from the "Library" link
    And I click the "Add Feed" button

    And I click the "Feed type" drop down list
    And I click the "Docker Container Registry" option
    And I click the "Save" button