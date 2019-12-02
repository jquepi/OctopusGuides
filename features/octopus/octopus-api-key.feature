Feature: Generate an API key

  Scenario: Initial window open
  I've noticed that sometimes the browser is hidden behind a command prompt, so this scenario opens
  and closes the browser so the next browser is in front of any windows.
    And I open the browser "ExternalBrowserType"
    And I fullscreen the window
    And I open the URL "http://localhost"
    And I sleep for "10" seconds
    And I close the browser

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username   | //input[@name='userName']                                                                                 |
      | Password   | //input[@name='password']                                                                                 |
      | Sign In    | //button[contains(.,'SIGN IN')]                                                                           |
      | Close help | //div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M11 18h2v-2h-2v2zm1-16C6.48 2 2')]] |
    And I open the shared browser "ExternalBrowserType"
    And I fullscreen the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button
    And I click the "Close help" button

  Scenario: Generate an API Key
    Given I set the following aliases:
      | User         | //a[@href='#'][./span[text()='admin']]                                   |
      | Profile      | //div[text()='Profile']                                                  |
      | My API Keys  | //a[contains(.,'My API Keys')][not(*)] \| //a/span[text()='My API Keys'] |
      | New API Key  | (//button[contains(.,'New API Key')])[1]                                 |
      | Purpose      | //input[contains(@id,'Purpose')]                                         |
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