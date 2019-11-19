Feature: Generate an API key

  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@name='userName']       |
      | Password | //input[@name='password']       |
      | Sign In  | //button[contains(.,'SIGN IN')] |
    And I open the shared browser "ExternalBrowserType"
    And I set the window size to "1024" x "768"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

  Scenario: Generate an API Key
    Given I set the following aliases:
      | User         | //a[@href='#'][./span[text()='admin']]                                   |
      | Profile      | //div[text()='Profile']                                                  |
      | My API Keys  | //a[contains(.,'My API Keys')][not(*)] \| //a/span[text()='My API Keys'] |
      | New API Key  | (//button[contains(.,'New API Key')])[1]                                 |
      | Purpose      | //input[contains(@id,'Purpose')]                                         |
      | Generate New | //button[contains(.,'Generate New')]                                     |
      | Api Key      | //strong                                                                 |

    And I start recording the screen to the directory "C:\screenshots"

    And I click the "User" link
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\apikey\profile.png"
    And I click the "Profile" link
    And I remove the highlight from the "User" link

    And I click the "My API Keys" link
    And I highlight outside the "My API Keys" link with an offset of "-3"
    And I sleep for "10" second
    And I save a screenshot to "C:\screenshots\octopus\apikey\keys.png"
    And I click the "New API Key" button
    And I remove the highlight from the "My API Keys" link