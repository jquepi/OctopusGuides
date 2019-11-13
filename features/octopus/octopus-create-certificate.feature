Feature: Create Certificate

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

  Scenario: Add Client PFX
    Given I set the following aliases:
      | More            | //a[contains(.,'More')]                                                         |
      | Library         | //span[./div/div/div[contains(.,'Library')]] \| //a[@href='#/Spaces-1/library'] |
      | Certificates    | //a[contains(.,'Certificates')]                                                 |
      | Add Certificate | //button[contains(.,'Add certificate')]                                         |
      | Name            | //input[contains(@id,'Name')]                                                   |
      | File            | //input[@type='file']                                                           |
      | Save            | //button[contains(.,'Save')]                                                    |

    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Upload Certificates" for "3" seconds

    And I click the "More" link if it exists
    And I click the "Library" link
    And I click the "Certificates" link
    And I click the "Add Certificate" button
    And I populate the "Name" text box with "Minikube Client Certificate"
    And I populate the hidden "File" file selector with "/tmp/client.pfx"
    And I sleep for "1" second
    And I click the "Save" button
    And I sleep for "1" second

  Scenario: Add Minikube CA
    Given I set the following aliases:
      | More            | //a[contains(.,'More')]                                                         |
      | Library         | //span[./div/div/div[contains(.,'Library')]] \| //a[@href='#/Spaces-1/library'] |
      | Certificates    | //a[contains(.,'Certificates')]                                                 |
      | Add Certificate | //button[contains(.,'Add certificate')]                                         |
      | Name            | //input[contains(@id,'Name')]                                                   |
      | File            | //input[@type='file']                                                           |
      | Save            | //button[contains(.,'Save')]                                                    |

    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Upload Certificates" for "3" seconds

    And I click the "More" link if it exists
    And I click the "Library" link
    And I click the "Certificates" link
    And I click the "Add Certificate" button
    And I populate the "Name" text box with "Minikube CA"
    And I populate the hidden "File" file selector with "/tmp/ca.crt"
    And I click the "Save" button
    And I sleep for "1" second

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser