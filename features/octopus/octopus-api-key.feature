Feature: Generate an API key

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments

  Scenario: Generate an API Key
    Given I set the following aliases:
      | User         | //a[@href='#'][./span[text()='admin']]                                   |
      | Profile      | //div[text()='Profile'] \| //a[text()='Profile']                         |
      | My API Keys  | //a[contains(.,'My API Keys')][not(*)] \| //a/span[text()='My API Keys'] |
      | New API Key  | (//button[contains(.,'New API Key')])[1]                                 |
      | Purpose      | //input[@name='Purpose']                                                 |
      | Generate New | //button[contains(.,'Generate New')]                                     |
      | Api Key      | //strong                                                                 |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating an API key" for "3" seconds

    And I click the "User" link
    And I highlight inside the "User" link
    And I highlight inside the "Profile" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/apikey/profile.png"
    And I click the "Profile" link
    And I remove the highlight from the "User" link

    And I click the "My API Keys" link
    And I highlight outside the "My API Keys" link with an offset of "-3"
    And I highlight outside the "New API Key" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/apikey/keys.png"
    And I click the "New API Key" button
    And I remove the highlight from the "My API Keys" link

    And I highlight outside the "Purpose" text box
    And I highlight outside the "Generate New" button with an offset of "2"
    And I populate the "Purpose" text box with "My API Key"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/apikey/new-key.png"
    And I click the "Generate New" button

    And I sleep for "3" seconds
    And I save a screenshot to "#{ExternalMediaPath}/octopus/apikey/api-key.png"

    And I get the text from the "Api Key" element
    And I write the value of the alias "LastReturn" to the file "ExternalApiKeyFile"

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  Scenario: Shutdown
    And I stop recording the screen
    And I close the browser