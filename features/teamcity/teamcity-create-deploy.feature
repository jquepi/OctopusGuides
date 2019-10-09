Feature: Create and deploy a release

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@id='username']      |
      | Password | //input[@id='password']      |
      | Log in   | //input[@name='submitLogin'] |

    And I open the shared browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:8111"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Log in" button

  @add-step
  Scenario: Add step
    Given I set the following aliases:
      | Build                         | //a[text()='Build']                                    |
      | Edit Configuration Settings   | //a[text()='Edit Configuration Settings']              |
      | Build Steps                   | //a[text()='Build Steps']                              |
      | Add build step                | //a[contains(.,'Add build step')]                      |
      | Runner type                   | //input[@id='-ufd-teamcity-ui-runTypeInfoKey']         |
      | Runner type container         | //span[./input[@id='-ufd-teamcity-ui-runTypeInfoKey']] |
      | OctopusDeploy: Create release | //li[@data-title='OctopusDeploy: Create release']      |
      | Step name                     | //input[@id='buildStepName']                           |
      | Octopus URL                   | //input[@id='octopus_host']                            |
      | Octopus API key               | //input[@id='secure:octopus_apikey']                   |
      | Octopus Project               | //input[@id='octopus_project_name']                    |
      | Octopus Environments          | //input[@id='octopus_deployto']                        |
      | Save                         | //input[@value='Save']                                 |

    And I start recording the screen to the directory "C:\screenshots"
    And I display a note with the text "Deploying an Octopus release from TeamCity" for "3" seconds

    And I highlight outside the "Build" link
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\001-create-release.png"
    And I click the "Build" link

    And I highlight outside the "Edit Configuration Settings" link
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\002-create-release.png"
    And I click the "Edit Configuration Settings" link

    And I highlight outside the "Build Steps" link
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\003-create-release.png"
    And I click the "Build Steps" link

    And I highlight outside the "Add build step" button
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\004-create-release.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list
    And I scroll the "OctopusDeploy: Create release" option into view
    And I click the "OctopusDeploy: Create release" option
    And I highlight outside the "Runner type container" drop down list
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\010-create-release.png"

    And I scroll the "Step name" text box into view offset by "-300"
    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Create and deploy release"
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\020-create-release.png"

    And I scroll the "Octopus URL" text box into view offset by "-300"
    And I highlight outside the "Octopus URL" text box
    And I populate the "Octopus URL" text box with "http://localhost"
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\030-create-release.png"

    And I scroll the "Octopus API key" text box into view offset by "-300"
    And I highlight outside the "Octopus API key" text box
    And I populate the "Octopus API key" text box with "ExternalOctopusAPIKey"
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\040-create-release.png"

    And I scroll the "Octopus Project" text box into view offset by "-300"
    And I highlight outside the "Octopus Project" text box
    And I populate the "Octopus Project" text box with "Random Quotes"
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\050-create-release.png"

    And I scroll the "Octopus Environments" text box into view offset by "-300"
    And I highlight outside the "Octopus Environments" text box
    And I populate the "Octopus Environments" text box with "Dev"
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\060-create-release.png"

    And I scroll the "Save" button into view
    And I highlight outside the "Save" button
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\070-create-release.png"
    And I click the "Save" button

  @run-build
  Scenario: Run a build
    Given I set the following aliases:
      | Run                      | //button[contains(.,'Run')]                                |
      | Build Configuration Home | //a[@href='/viewType.html?buildTypeId=RandomQuotes_Build'] |
      | Build Two                | //a[contains(.,'#2')]                                      |

    And I highlight outside the "Build Configuration Home" link
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\080-build-config-home.png"
    And I click the "Build Configuration Home" link

    And I highlight outside the "Run" button
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\090-run.png"
    And I click the "Run" button
    And I sleep for "10" seconds
    And I refresh the page

    And I highlight outside the "Build Two" link
    And I save a screenshot to "c:\screenshots\teamcity\createrelease\100-build-one.png"
    And I click the "Build Two" link
    And I sleep for "60" seconds

    And I save a screenshot to "c:\screenshots\teamcity\createrelease\110-build-one-results.png"

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  Scenario: Shutdown
    And I stop recording the screen
    And I close the browser