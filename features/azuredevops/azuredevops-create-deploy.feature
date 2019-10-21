Feature: Create and deploy a release

  @login
  Scenario: Log into Azure DevOps
    And I open the shared browser "FirefoxNoImplicitWaitNoProxy"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    #And I set the window size to "1024" x "768"
    When I open the URL "http://localhost:9090/DefaultCollection"
    And I start recording the screen to the directory "C:\screenshots"

  @add-step
  Scenario: Add deploy step
    Given I set the following aliases:
      | Random Quotes            | //li[contains(@class,'project-card')]                                                                         |
      | Pipelines                | //div[@role='menuitem'][./a[@href='/DefaultCollection/Random%20Quotes/_build']]                               |
      | Build                    | //a[@name='Builds']                                                                                           |
      | Edit                     | //a[contains(.,'Edit')]                                                                                       |

    And I display a note with the text "Deploying an Octopus release from Azure DevOps" for "3" seconds

    And I highlight outside the "Random Quotes" tile
    And I save a screenshot to "c:\screenshots\azuredevops\createrelease\010-project-tile.png"
    And I click the "Random Quotes" tile

    And I mouse over the "Pipelines" menu item
    And I highlight inside the "Pipelines" menu item
    And I highlight inside the "Build" link
    And I save a screenshot to "c:\screenshots\azuredevops\createrelease\020-build.png"
    And I click the "Build" menu item

    And I highlight inside the "Edit" button
    And I save a screenshot to "c:\screenshots\azuredevops\createrelease\030-edit.png"
    And I click the "Edit" button

  @add-step @octo-built-in-feed
  Scenario: Click last step
    Given I set the following aliases:
      | Push Packages to Octopus | //div[./div/div/div/div[text()='Push Package(s) to Octopus']]                                                 |

    And I scroll the "Push Packages to Octopus" job tile into view
    And I click the "Push Packages to Octopus" job tile

  @add-step @artifactory
  Scenario: Click last step
    Given I set the following aliases:
      | Nuget push | //div[./div/div/div/div[text()='Nuget push']]                                                 |

    And I scroll the "Nuget push" job tile into view
    And I click the "Nuget push" job tile

  @add-step
  Scenario: Continue Adding deploy step
    Given I set the following aliases:
      | Add task                 | //button[@aria-label='Add a task to Agent job 1']                                                             |
      | Search                   | (//input[@aria-label='Search'])[2]                                                                            |
      | Create release tile      | //div[@class='info-name'][text()='Create Octopus Release']                                                    |
      | Create release           | //div[./div/div/div[text()='Create Octopus Release']]/button                                                  |
      | Create Octopus Release   | //div[@data-list-index='7'][contains(.,'Create Octopus Release')]/div/div/div/div                             |
      | Octopus Deploy Server    | //div[@aria-label='Expand'][../../../../../../../../../../div/div/label[contains(.,'Octopus Deploy Server')]] |
      | Octopus Deploy Space     | //div[@aria-label='Expand'][../../../../../../../../../div/div/label[contains(.,'Space')]]                    |
      | Octopus Deploy Project   | //div[@aria-label='Expand'][../../../../../../../../../div/div/label[contains(.,'Project')]]                  |
      | Space Refresh            | //button[./div/span[text()='Refresh Space']]                                                                  |
      | Project Refresh          | //button[./div/span[text()='Refresh Project']]                                                                |
      | Octopus Server           | //li[text()='Octopus']                                                                                        |
      | Default Space            | //li[text()='Default']                                                                                        |
      | Random Quotes Project    | //li[text()='Random Quotes']                                                                                  |
      | Save and queue           | //button[@name='Save & queue']                                                                                |
      | Save and queue two       | (//button[@name='Save & queue'])[2]                                                                           |
      | Save and queue three     | //button[@aria-label='Save & queue']                                                                          |
      | Comment                  | //textarea[../../../../../../../../div//label[contains(.,'Save')]]                                            |
      | Build link               | //a[contains(@class, 'ci-queued-build-link')]                                                                 |
      | Post job Checkout        | //div[text()='Post-job: Checkout']                                                                            |

    And I highlight inside the "Add task" button
    And I click the "Add task" button
    And I highlight outside the "Search" text box
    And I populate the "Search" text box with "Octopus Release"
    And I sleep for "2" seconds

    And I mouse over the "Create release tile" element
    And I highlight outside the "Create release tile" element with an offset of "5"

    And I click the "Create release" button
    And I save a screenshot to "c:\screenshots\azuredevops\createrelease\040-create-release-job.png"
    And I sleep for "1" second

    And I scroll the "Create Octopus Release" job tile into view
    And I click the "Create Octopus Release" job tile
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Octopus Deploy Server" drop down list with an offset of "2"
    And I click the "Octopus Deploy Server" drop down list
    And I click the "Octopus Server" option

    And I highlight outside the "Octopus Deploy Space" drop down list with an offset of "2"
    And I click the "Space Refresh" button
    And I sleep for "2" seconds
    And I click the "Octopus Deploy Space" drop down list
    And I click the "Default Space" option

    And I highlight outside the "Octopus Deploy Project" drop down list with an offset of "2"
    And I click the "Project Refresh" button
    And I sleep for "2" seconds
    And I click the "Octopus Deploy Project" drop down list
    And I click the "Random Quotes Project" option
    And I save a screenshot to "c:\screenshots\azuredevops\createrelease\050-populated.png"

    And I remove the highlight from the "Octopus Deploy Project" drop down list
    And I remove the highlight from the "Octopus Deploy Space" drop down list
    And I remove the highlight from the "Octopus Deploy Server" drop down list

    And I highlight inside the "Save and queue" button
    And I click the "Save and queue" button
    And I highlight inside the "Save and queue two" button
    And I save a screenshot to "c:\screenshots\azuredevops\createrelease\060-save-and-queue.png"
    And I click the "Save and queue two" button
    And I remove the highlight from the "Save and queue" button

    And I highlight outside the "Comment" text box with an offset of "0"
    And I highlight outside the "Save and queue three" button with an offset of "2"
    And I scroll the "Comment" text box into view offset by "100"
    And I populate the "Comment" text box with "Build and deploy"
    And I save a screenshot to "c:\screenshots\azuredevops\createrelease\070-initial-build.png"
    And I scroll the "Save and queue three" button into view
    And I save a screenshot to "c:\screenshots\azuredevops\createrelease\075-initial-build-save-and-continue.png"
    And I click the "Save and queue three" button
    And I sleep for "3" seconds

    And I highlight outside the "Build link" element
    And I click the "Build link" element
    And I sleep for "60" seconds
    And I scroll the "Post job Checkout" item into view
    And I save a screenshot to "c:\screenshots\azuredevops\createrelease\080-build-results.png"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser