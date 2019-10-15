Feature: Setup Artifactory

  Scenario: Log in
    Given I set the following aliases:
      | Username       | //input[@id='user']                                     |
      | Password       | //input[@id='password']                                 |
      | Login          | //button[@id='login']                                   |
      | Close Wizard   | //span[@ng-click='$wizardCtrl.cancel()']                |
      | Admin          | //i[@class='icon icon-admin-new']                       |
      | License        | //a[@href='#/admin/configuration/artifactory_licenses'] |
      | License Key    | //textarea[@name='dndtext']                             |
      | Save           | //button[text()='Save']                                 |
      | Local          | //a[@href='#/admin/repositories/local']                 |
      | New            | //a[@id='repositories-new']                             |
      | NuGet          | //li[@id='repository-select-package-type-nuget']        |
      | Repository Key | //input[@id='repoKey-new']                              |
      | Save & Finish  | //button[@id='repository-save-button']                  |

    And I open the shared browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:8040"
    And I populate the "Username" text box with "admin" waiting up to "300" seconds
    And I populate the "Password" text box with "password"
    And I click the "Login" button
    And I click the "Close Wizard" element waiting up to "10" seconds if it exists

  Scenario: Add license
    Given I set the following aliases:
      | Admin       | //i[@class='icon icon-admin-new']                       |
      | License     | //a[@href='#/admin/configuration/artifactory_licenses'] |
      | License Key | //textarea[@name='dndtext']                             |
      | Save        | //button[normalize-space(text())='Save']                |

    And I click the "Admin" icon
    And I click the "License" link
    And I clear the "License Key" text box
    And I populate the "License Key" text box with "ExternalArtifactoryKey"
    And I click the "Save" button
    And I sleep for "30" seconds

  Scenario: Add NuGet repo
    Given I set the following aliases:
      | Admin          | //i[@class='icon icon-admin-new']                |
      | Local          | //a[@href='#/admin/repositories/local']          |
      | New            | //a[@id='repositories-new']                      |
      | NuGet Icon     | //li[@id='repository-select-package-type-nuget'] |
      | Repository Key | //input[@id='repoKey-new']                       |
      | Save & Finish  | //button[@id='repository-save-button']           |

    And I open the URL "http://localhost:8040/artifactory/webapp/#/home"
    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Creating the NuGet repository in Artifactory" for "3" seconds

    And I click the "Admin" link
    And I click the "Local" link
    And I click the "New" button
    And I click the "NuGet Icon" element
    And I populate the "Repository Key" text box with "NuGet"
    And I sleep for "5" seconds
    And I click the "Save & Finish" button

  Scenario: Open URL
    And I sleep for "5" seconds
    And I open the URL "http://admin:password@localhost:8041/artifactory/api/nuget/NuGet"