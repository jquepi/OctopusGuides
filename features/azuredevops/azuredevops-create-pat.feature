Feature: Create Azure Devops PAT

  @login
  Scenario: Log into Azure Devops
    And I open the shared browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    #And I set the window size to "1024" x "768"
    When I open the URL "http://localhost:9090/"

  Scenario: Create PAT
    Given I set the following aliases:
      | Profile      | //div[contains(@class, 'navigation-profile-menu')]       |
      | Security     | //a[@href='/DefaultCollection/_details/security/tokens'] |
      | Add          | //li[contains(.,'Add')]                                  |
      | Description  | //input[@id='pat-descritionInput']                       |
      | Create Token | //button[contains(.,'Create Token')]                     |
      | Token Value  | //input[@class='token-container-content']                |

    And I click the "Profile" menu bar link
    And I save a screenshot to "c:\screenshots\azuredevops\security\010-security.png"
    And I click the "Security" link

    And I save a screenshot to "c:\screenshots\azuredevops\security\020-add-token.png"
    And I click the "Add" button

    And I populate the "Description" text box with "Agent token"
    And I save a screenshot to "c:\screenshots\azuredevops\security\030-token-description.png"
    And I scroll the "Create Token" button into view
    And I save a screenshot to "c:\screenshots\azuredevops\security\040-create-token.png"
    And I click the "Create Token" button

    And I get the text from the "Token Value" text box
    And I write the value of the alias "LastReturn" to the file "c:\azure-pat.txt"
    And I save a screenshot to "c:\screenshots\azuredevops\security\050-token-value.png"

  Scenario: Shutdown
    #Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser