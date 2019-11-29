Feature: Create and deploy a release

  @login
  Scenario: Log into Azure DevOps
    And I open the shared browser "ExternalBrowserType"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    #And I set the window size to "1024" x "768"
    When I open the URL "http://localhost:9090/DefaultCollection"
    And I start recording the screen to the directory "#{ExternalMediaPath}"

  @add-step
  Scenario: Add deploy step
    Given I set the following aliases:
      | Random Quotes | //li[contains(@class,'project-card')] |
      | Pipelines     | //a[@aria-label='Pipelines']          |
      | Build         | //a[@aria-label='Builds']             |
      | Edit          | //a[contains(.,'Edit')]               |

    And I display a note with the text "Deploying an Octopus release from Azure DevOps" for "3" seconds

    And I highlight outside the "Random Quotes" tile
    And I save a screenshot to "#{ExternalMediaPath}/azuredevops/createrelease/#{GuideSpecificScreenshotDir}010-project-tile.png"
    And I click the "Random Quotes" tile

    And I click the "Pipelines" menu item
    And I highlight inside the "Pipelines" menu item
    And I highlight inside the "Build" link
    And I save a screenshot to "#{ExternalMediaPath}/azuredevops/createrelease/#{GuideSpecificScreenshotDir}020-build.png"
    And I click the "Build" menu item

    And I highlight inside the "Edit" button
    And I save a screenshot to "#{ExternalMediaPath}/azuredevops/createrelease/#{GuideSpecificScreenshotDir}030-edit.png"
    And I click the "Edit" button

    And I stop recording the screen

  @add-step @repositoryspecific @octo-built-in-feed
  Scenario: Click last step
    Given I set the following aliases:
      | Push Packages to Octopus | //div[./div/div/div/div[text()='Push Package(s) to Octopus']] |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I scroll the "Push Packages to Octopus" job tile into view
    And I click the "Push Packages to Octopus" job tile

    And I stop recording the screen

  @add-step @repositoryspecific @artifactory
  Scenario: Click last step
    Given I set the following aliases:
      | Nuget push | //div[./div/div/div/div[text()='Nuget push']] |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I scroll the "Nuget push" job tile into view
    And I click the "Nuget push" job tile

    And I stop recording the screen

  @add-step
  Scenario: Continue Adding deploy step
    Given I set the following aliases:
      | Add task                   | //button[@aria-label='Add a task to Agent job 1']                                 |
      | Search                     | (//input[@aria-label='Search'])[2]                                                |
      | Create release tile        | //div[@class='info-name'][text()='Create Octopus Release']                        |
      | Create release             | //div[./div/div/div[text()='Create Octopus Release']]/button                      |
      | Create Octopus Release Row | //div[@data-list-index='7'][contains(.,'Create Octopus Release')]/div/div/div/div |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight inside the "Add task" button
    And I click the "Add task" button
    And I highlight outside the "Search" text box
    And I populate the "Search" text box with "Create Octopus Release"
    And I sleep for "2" seconds

    And I mouse over the "Create release tile" element
    And I highlight outside the "Create release tile" element with an offset of "5"

    And I click the "Create release" button
    And I save a screenshot to "#{ExternalMediaPath}/azuredevops/createrelease/#{GuideSpecificScreenshotDir}040-create-release-job.png"
    And I sleep for "1" second

    And I scroll the "Create Octopus Release Row" job tile into view
    And I click the "Create Octopus Release Row" job tile
    And I remove the highlight from the "Add task" button

    And I stop recording the screen

  @add-step @repositoryspecific @octo-built-in-feed
  Scenario: Select existing Octopus server
    Given I set the following aliases:
      | Server Refresh        | //button[./div/span[text()='Refresh Octopus Deploy Server']]                                                  |
      | Octopus Deploy Server | //div[@aria-label='Expand'][../../../../../../../../../../div/div/label[contains(.,'Octopus Deploy Server')]] |
      | Octopus Server        | //li[text()='Octopus']                                                                                        |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I click the "Server Refresh" button
    # Don't record the full refresh time
    And I sleep for "2" seconds
    And I stop recording the screen
    And I sleep for "20" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I highlight outside the "Octopus Deploy Server" drop down list with an offset of "2"
    And I sleep for "1" second
    And I click the "Octopus Deploy Server" drop down list
    And I click the "Octopus Server" option

    And I stop recording the screen

  @add-step @repositoryspecific @artifactory
  Scenario: Add new Octopus server
    Given I set the following aliases:
      | New             | //div[./span[text()='Add Octopus Deploy Server']] |
      | Connection name | //input[@id='connectionName']                     |
      | Server URL      | //input[@id='url']                                |
      | API Key         | //input[@id='apitoken']                           |
      | OK              | //button[@id='ok']                                |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "New" button with an offset of "2"
    And I zoom the browser out
    And I save a screenshot to "#{ExternalMediaPath}/azuredevops/createrelease/#{GuideSpecificScreenshotDir}045-octopus-connection.png"
    And I zoom the browser in
    And I click the "New" button
    And I remove the highlight from the "New" button

    And I highlight outside the "Connection name" text box with an offset of "2"
    And I highlight outside the "Server URL" text box with an offset of "2"
    And I highlight outside the "API Key" text box with an offset of "2"
    And I highlight inside the "OK" button
    And I populate the "Connection name" text box with "Octopus"
    And I populate the "Server URL" text box with "http://localhost"
    And I populate the "API Key" text box with "ExternalOctopusAPIKey"
    And I save a screenshot to "#{ExternalMediaPath}/azuredevops/createrelease/#{GuideSpecificScreenshotDir}046-octopus-details.png"
    And I click the "OK" button
    And I sleep for "1" second
    And I remove the highlight from the "New" button

    And I stop recording the screen

  @add-step
  Scenario: Continue adding step
    Given I set the following aliases:
      | Space Refresh                | //button[./div/span[text()='Refresh Space']]                                                 |
      | Project Refresh              | //button[./div/span[text()='Refresh Project']]                                               |
      | Default Space                | //li[text()='Default']                                                                       |
      | Random Quotes Project        | //li[text()='Random Quotes']                                                                 |
      | Save and queue               | //button[@name='Save & queue']                                                               |
      | Save and queue two           | (//button[@name='Save & queue'])[2]                                                          |
      | Save and queue three         | //button[@aria-label='Save & queue']                                                         |
      | Comment                      | //textarea[../../../../../../../../div//label[contains(.,'Save')]]                           |
      | Build link                   | //a[contains(@class, 'ci-queued-build-link')]                                                |
      | Post job Checkout            | //div[text()='Post-job: Checkout']                                                           |
      | Octopus Deploy Space         | //div[@aria-label='Expand'][../../../../../../../../../div/div/label[contains(.,'Space')]]   |
      | Octopus Deploy Space Input   | //input[../../../../../../../../../../div/div/label[contains(.,'Space')]]                    |
      | Octopus Deploy Project       | //div[@aria-label='Expand'][../../../../../../../../../div/div/label[contains(.,'Project')]] |
      | Octopus Deploy Project Input | //input[../../../../../../../../../../div/div/label[contains(.,'Project')]]                  |
      | Deployment Section           | //div[@aria-label='Deployment']                                                              |
      | Environment                  | //input[../../../../../../../../../div/label[text()='To Environment']]                       |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I scroll the "Octopus Deploy Space Input" text box into view offset by "-300"
    And I highlight outside the "Octopus Deploy Space Input" text box list with an offset of "2"
    And I populate the "Octopus Deploy Space Input" text box with "Default"

    And I scroll the "Octopus Deploy Project Input" text box into view offset by "-300"
    And I highlight outside the "Octopus Deploy Project Input" text box with an offset of "2"
    And I populate the "Octopus Deploy Project Input" text box with "Random Quotes"

    And I save a screenshot to "#{ExternalMediaPath}/azuredevops/createrelease/#{GuideSpecificScreenshotDir}050-populated.png"

    And I remove the highlight from the "Octopus Deploy Project Input" text box
    And I remove the highlight from the "Octopus Deploy Space Input" text box
    And I remove the highlight from the "Octopus Deploy Server" drop down list

    And I highlight outside the "Deployment Section" heading with an offset of "2"
    And I scroll the "Deployment Section" heading into view offset by "-300"
    And I click the "Deployment Section" heading

    And I highlight inside the "Environment" text box
    And I populate the "Environment" text box with "Dev"

    And I save a screenshot to "#{ExternalMediaPath}/azuredevops/createrelease/#{GuideSpecificScreenshotDir}055-environment.png"

    And I stop recording the screen
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight inside the "Save and queue" button
    # Force click to fix the error:
    # Element <button id="CommandBar177save-and-queue-dropdown" class="ms-CommandBarItem-link itemLink_582ca1be" name="Save & queue"> is not clickable at point (780,132) because another element <div class="ms-Callout ms-Tooltip vss-Tooltip root-157 css-36"> obscures it
    And I force click the "Save and queue" button
    And I highlight inside the "Save and queue two" button
    And I save a screenshot to "#{ExternalMediaPath}/azuredevops/createrelease/#{GuideSpecificScreenshotDir}060-save-and-queue.png"
    And I click the "Save and queue two" button
    And I remove the highlight from the "Save and queue" button

    And I highlight outside the "Comment" text box with an offset of "0"
    And I highlight outside the "Save and queue three" button with an offset of "2"
    And I scroll the "Comment" text box into view offset by "-100"
    And I populate the "Comment" text box with "Build and deploy"
    And I zoom the browser out
    And I save a screenshot to "#{ExternalMediaPath}/azuredevops/createrelease/#{GuideSpecificScreenshotDir}070-initial-build.png"
    And I zoom the browser in
    And I scroll the "Save and queue three" button into view
    And I save a screenshot to "#{ExternalMediaPath}/azuredevops/createrelease/#{GuideSpecificScreenshotDir}075-initial-build-save-and-continue.png"
    And I click the "Save and queue three" button
    And I sleep for "3" seconds

    And I highlight outside the "Build link" element
    And I click the "Build link" element

    And I sleep for "10" seconds
    And I stop recording the screen

    And I sleep for "60" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I sleep for "5" seconds

    And I scroll the "Post job Checkout" item into view
    And I save a screenshot to "#{ExternalMediaPath}/azuredevops/createrelease/#{GuideSpecificScreenshotDir}080-build-results.png"

    And I stop recording the screen

  Scenario: Shutdown
    And I start recording the screen to the directory "#{ExternalMediaPath}"
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser