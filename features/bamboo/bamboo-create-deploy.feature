Feature: Create deployment

  Scenario: Login
    Given I set the following aliases:
      | Log in     | (//a[text()='Log in'])[1]            |
      | Username   | //input[@id='loginForm_os_username'] |
      | Password   | //input[@id='loginForm_os_password'] |
      | Log in Two | // input[@id='loginForm_save']       |

    And I open the shared browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:6990/bamboo"
    And I click the "Log in" button
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "admin"
    And I click the "Log in Two" button

  Scenario: Add create deployment step
    Given I set the following aliases:
      | Configure plan                      | //a[@id='editBuild:RQ-WEB']                                           |
      | Default job                         | //a[@id='viewJob_RQ-WEB-JOB1']                                        |
      | Add task                            | //a[@id='addTask']                                                    |
      | Octopus Deploy: Create Release Tile | //li[.//h3[normalize-space(text())='Octopus Deploy: Create Release']] |
      | Task description                    | //input[@id='createTask_userDescription']                             |
      | Server URL                          | //input[@id='serverUrl']                                              |
      | API key                             | //input[@id='apiKey']                                                 |
      | Project                             | //input[@id='projectName']                                            |
      | Environment                         | //input[@id='environmentName']                                        |
      | Run                                 | //button[@aria-controls='runMenuParent']                              |
      | Run plan                            | //a[@id='manualBuild_RQ-WEB']                                         |
      | Search                              | //h2[contains(.,'Task types')]//input                                 |
      | Save                                | //input[@id='createTask_save']                                        |

    And I display a note with the text "Creating a deploying a release in Octopus" for "3" seconds

    And I highlight inside the "Configure plan" link
    And I save a screenshot to "c:\screenshots\bamboo\createrelease\#{GuideSpecificScreenshotDir}010-configure-plan.png"
    And I click the "Configure plan" link

    And I highlight the "Default job" link
    And I save a screenshot to "c:\screenshots\bamboo\createrelease\#{GuideSpecificScreenshotDir}020-default-job.png"
    And I click the "Default job" link

    And I highlight the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "c:\screenshots\bamboo\createrelease\#{GuideSpecificScreenshotDir}030-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight the "Search" box
    And I populate the "Search" box with "Octopus"
    And I highlight inside the "Octopus Deploy: Create Release Tile" element
    And I save a screenshot to "c:\screenshots\bamboo\createrelease\#{GuideSpecificScreenshotDir}040-search.png"
    And I click the "Octopus Deploy: Create Release Tile" element

    And I highlight the "Task description" text box
    And I populate the "Task description" text box with "Create deployment"
    And I save a screenshot to "c:\screenshots\bamboo\createrelease\#{GuideSpecificScreenshotDir}050-description.png"

    And I highlight the "Server URL" text box
    And I scroll the "Server URL" text box into view offset by "-300"
    And I clear the "Server URL" text box
    And I populate the "Server URL" text box with "http://localhost"
    And I save a screenshot to "c:\screenshots\bamboo\createrelease\#{GuideSpecificScreenshotDir}060-server-url.png"

    And I highlight the "API key" text box
    And I scroll the "API key" text box into view offset by "-300"
    And I populate the "API key" text box with "ExternalOctopusAPIKey"
    And I save a screenshot to "c:\screenshots\bamboo\createrelease\#{GuideSpecificScreenshotDir}070-api-key.png"
    And I remove the highlight from the "Server URL" text box
    And I remove the highlight from the "API key" text box

    And I highlight the "Project" text box
    And I scroll the "Project" text box into view offset by "-300"
    And I populate the "Project" text box with "Random Quotes"
    And I save a screenshot to "c:\screenshots\bamboo\createrelease\#{GuideSpecificScreenshotDir}080-project.png"

    And I highlight the "Environment" text box
    And I scroll the "Environment" text box into view offset by "-300"
    And I populate the "Environment" text box with "Dev"
    And I save a screenshot to "c:\screenshots\bamboo\createrelease\#{GuideSpecificScreenshotDir}090-environment.png"

    And I highlight the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "c:\screenshots\bamboo\createrelease\#{GuideSpecificScreenshotDir}100-octo-push.png"
    And I click the "Save" button

    And I scroll the "Run" button into view
    And I highlight the "Run" button with an offset of "5"
    And I click the "Run" button
    And I highlight the "Run plan" link with an offset of "5"
    And I save a screenshot to "c:\screenshots\bamboo\createrelease\#{GuideSpecificScreenshotDir}110-run.png"
    And I click the "Run plan" link

    And I scroll down "10000" px

    And I stop recording the screen
    And I start recording the screen to the directory "C:\screenshots"
    And I sleep for "60" seconds
    And I save a screenshot to "c:\screenshots\bamboo\createrelease\#{GuideSpecificScreenshotDir}120-build-results.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser