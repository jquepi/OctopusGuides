Feature: Generate an API key

  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@name='userName']       |
      | Password | //input[@name='password']       |
      | Sign In  | //button[contains(.,'SIGN IN')] |
    And I open the shared browser "FirefoxNoImplicitWait"
    And I maximize the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Creating an API key" for "3" seconds
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button

  Scenario: Generate an API Key
    Given I set the following aliases:
      | User         | //a[@href='#'][./span[text()='admin']] |
      | Profile      | //div[text()='Profile']                |
      | My API Keys  | //a[contains(.,'My API Keys')]         |
      | New API Key  | //button[contains(.,'New API Key')]    |
      | Purpose      | //input[contains(@id,'Purpose')]       |
      | Generate New | //button[contains(.,'Generate New')]   |

    And I click the "User" link
    And I highlight inside the "User" link
    And I highlight inside the "Profile" link
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\apikey\profile.png"
    And I click the "Profile" link

    And I click the "My API Keys" link
    And I highlight inside the "My API Keys" link
    And I highlight outside the "New API Key" button
    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\apikey\keys.png"
    And I click the "New API Key" button

    And I highlight outside the "Purpose" text box
    And I highlight outside the "Generate New" button with an offset of "2"
    And I populate the "Purpose" text box with "My API Key"
    And I save a screenshot to "C:\screenshots\octopus\apikey\new-key.png"
    And I click the "Generate New" button

    And I sleep for "1" second
    And I save a screenshot to "C:\screenshots\octopus\apikey\api-key.png"

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  Scenario: Shutdown
    And I stop recording the screen
    And I close the browser