Feature: Setup Artifactory

  Scenario: Initial window open
  I've noticed that sometimes the browser is hidden behind a command prompt, so this scenario opens
  and closes the browser so the next browser is in front of any windows.
    And I open the browser "ExternalBrowserType"
    And I open the URL "http://localhost:8041"
    And I sleep for "10" seconds
    And I close the browser

  @login @browserspecific @firefox
  Scenario: Open Browser
    And I open the shared browser "ExternalBrowserType"
    And I fullscreen the window

  @login @browserspecific @chrome
  Scenario: Open Browser
    And I open the shared browser "ExternalBrowserType"
    # Maximise in Linux because we don't have an os taskbar, but we want to see the Chrome UI
    And I maximize the window

  Scenario: Log in
    Given I set the following aliases:
      | Username | //input[@id='user']               |
      | Password | //input[@id='password']           |
      | Login    | //button[@id='login']             |
      | Spinner  | //div[contains(@class,'spinner')] |

    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:8041"
    And I verify the "Spinner" overlay is present waiting up to "60" seconds if it exists
    And I verify the "Spinner" overlay is not present waiting up to "60" seconds
    And I populate the "Username" text box with "admin" waiting up to "300" seconds
    And I populate the "Password" text box with "password"
    And I click the "Login" button
    And I sleep for "30" seconds


  Scenario: Add license
    Given I set the following aliases:
      | Next                | //button[text()='Next']     |
      | License             | //textarea                  |
      | License Key         | //textarea[@name='dndtext'] |
      | New Password        | //input[@id='newPassword']  |
      | Retype New Password | //input[@id='password']     |
      | Skip                | //button[text()='Skip']     |
      | Finish              | //button[text()='Finish']   |

    And I click the "Next" button
    And I clear the "License" text box
    And I populate the "License" text box with "ExternalArtifactoryKey"
    And I click the "Next" button
    And I sleep for "60" seconds
    And I populate the "New Password" text box with "Password01!"
    And I populate the "Retype New Password" text box with "Password01!"
    And I click the "Next" button
    And I click the "Skip" button
    And I click the "Skip" button
    And I click the "Finish" button

  @applicationspecific @aspnetcore @aspnet
  Scenario: Add NuGet repo
    Given I set the following aliases:
      | Admin          | //i[@class='icon icon-admin-new']                |
      | Local          | //a[@href='#/admin/repositories/local']          |
      | New            | //a[@id='repositories-new']                      |
      | NuGet Icon     | //li[@id='repository-select-package-type-nuget'] |
      | Repository Key | //input[@id='repoKey-new']                       |
      | Save & Finish  | //button[@id='repository-save-button']           |
      | Spinner        | //div[contains(@class,'spinner')]                |

    And I open the URL "http://localhost:8041/artifactory/webapp/#/home"
    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating the NuGet repository in Artifactory" for "3" seconds

    And I highlight inside the "Admin" link
    And I save a screenshot to "#{ExternalMediaPath}/artifactory/nugetrepo/010-nuget-repo.png"
    And I click the "Admin" link

    And I highlight inside the "Local" link
    And I save a screenshot to "#{ExternalMediaPath}/artifactory/nugetrepo/020-nuget-repo.png"
    And I mouse over the "Local" link
    And I open the URL "http://localhost:8041/artifactory/webapp/#/admin/repositories/local"

    And I remove the highlight from the "Admin" link

    And I verify the "Spinner" overlay is not present waiting up to "60" seconds

    And I highlight outside the "New" button
    And I save a screenshot to "#{ExternalMediaPath}/artifactory/nugetrepo/030-nuget-repo.png"
    And I click the "New" button

    And I highlight outside the "NuGet Icon" element
    And I save a screenshot to "#{ExternalMediaPath}/artifactory/nugetrepo/040-nuget-repo.png"
    And I click the "NuGet Icon" element

    And I highlight outside the "Repository Key" text box with an offset of "5"
    And I highlight outside the "Save & Finish" button
    And I populate the "Repository Key" text box with "NuGet"
    And I sleep for "5" seconds
    And I save a screenshot to "#{ExternalMediaPath}/artifactory/nugetrepo/050-nuget-repo.png"
    And I click the "Save & Finish" button

  @applicationspecific @java
  Scenario: Add NuGet repo
    Given I set the following aliases:
      | License Key    | //textarea[@name='dndtext']                      |
      | Admin          | //i[@class='icon icon-admin-new']                |
      | Local          | //a[@href='#/admin/repositories/local']          |
      | New            | //a[@id='repositories-new']                      |
      | Maven Icon     | //li[@id='repository-select-package-type-maven'] |
      | Repository Key | //input[@id='repoKey-new']                       |
      | Save & Finish  | //button[@id='repository-save-button']           |
      | Spinner        | //div[contains(@class,'spinner')]                |

    And I open the URL "http://localhost:8041/artifactory/webapp/#/home"
    And I verify the "License Key" text box is not present waiting up to "60" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating the Maven repository in Artifactory" for "3" seconds

    And I highlight inside the "Admin" link
    And I save a screenshot to "#{ExternalMediaPath}/artifactory/mavenrepo/010-maven-repo.png"
    And I click the "Admin" link

    And I highlight inside the "Local" link
    And I save a screenshot to "#{ExternalMediaPath}/artifactory/mavenrepo/020-maven-repo.png"
    And I mouse over the "Local" link
    And I open the URL "http://localhost:8041/artifactory/webapp/#/admin/repositories/local"

    And I remove the highlight from the "Admin" link

    And I verify the "Spinner" overlay is not present waiting up to "60" seconds

    And I highlight outside the "New" button
    And I save a screenshot to "#{ExternalMediaPath}/artifactory/mavenrepo/030-maven-repo.png"
    And I click the "New" button

    And I highlight outside the "Maven Icon" element
    And I save a screenshot to "#{ExternalMediaPath}/artifactory/mavenrepo/040-maven-repo.png"
    And I click the "Maven Icon" element

    And I highlight outside the "Repository Key" text box with an offset of "5"
    And I highlight outside the "Save & Finish" button
    And I populate the "Repository Key" text box with "Maven"
    And I sleep for "5" seconds
    And I save a screenshot to "#{ExternalMediaPath}/artifactory/mavenrepo/050-maven-repo.png"
    And I click the "Save & Finish" button

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser