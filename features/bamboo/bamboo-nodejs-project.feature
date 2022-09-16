Feature: Configure Bamboo

  Scenario: Configure Bamboo
    Given I run the feature "shared/bamboo-login.feature" passing the original arguments
    And I run the feature "shared/bamboo-manually-add-plugin.feature" passing the original arguments
    And I run the feature "shared/bamboo-configure-octopus.feature" passing the original arguments
    And I run the feature "shared/bamboo-add-project.feature" passing the original arguments

  @applicationspecific @nodejs
  Scenario: Node.js Add tasks
    Given I set the following aliases:
      | Add task                     | //a[@id='addTask']                                                                 |
      | Search                       | //h2[contains(.,'Task types')]//input                                              |
      | NPM Tile                     | //li[.//div[@class='task-type-description']][.//h4[normalize-space(text())='npm']] |
      | Octopus Deploy: Pack Package | //li[.//h4[normalize-space(text())='Octopus Deploy: Pack Package']]                |
      | Task description             | //input[@id='createTask_userDescription']                                          |
      | Command                      | //input[@id='command']                                                             |
      | Add new executable           | //a[@class='addSharedBuilderCapability']                                           |
      | Executable label             | //input[@id='addSharedBuilderCapability_builderLabel']                             |
      | Path                         | //input[@id='addSharedBuilderCapability_builderPath']                              |
      | Add                          | //input[@id='addSharedBuilderCapability_save']                                     |
      | Package ID                   | //input[@id='packId']                                                              |
      | Version number               | //input[@id='packVersion']                                                         |
      | Nuget                        | //input[@id='packFormatnuget']                                                     |
      | Base folder                  | //input[@id='packBasePath']                                                        |
      | Output folder                | //input[@id='packOutFolder']                                                       |
      | Save                         | //input[@id='createTask_save']                                                     |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}100-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Node"
    And I highlight inside the "NPM Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}110-search.png"
    And I click the "NPM Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "npm Install"

    And I highlight outside the "Add new executable" link
    And I click the "Add new executable" link
    And I highlight outside the "Executable label" text box
    And I highlight outside the "Path" text box
    And I highlight outside the "Add" button with an offset of "5"
    And I populate the "Executable label" text box with "node"
    And I populate the "Path" text box with "/usr/bin/node"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}115-npm-executable.png"
    And I click the "Add" button

    And I highlight outside the "Command" text box
    And I scroll the "Command" text box into view offset by "-300"
    And I populate the "Command" text box with "install"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}120-npm-install.png"
    And I click the "Save" button

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}130-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Node"
    And I highlight inside the "NPM Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}140-search.png"
    And I click the "NPM Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "npm Test"

    And I highlight outside the "Command" text box
    And I scroll the "Command" text box into view offset by "-300"
    And I populate the "Command" text box with "test"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}150-npm-test.png"
    And I click the "Save" button

    And I highlight the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}160-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight the "Search" box
    And I populate the "Search" box with "Octopus"
    And I highlight inside the "Octopus Deploy: Pack Package" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}170-search.png"
    And I click the "Octopus Deploy: Pack Package" element

    And I highlight the "Task description" text box
    And I populate the "Task description" text box with "Create package"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}180-description.png"

    And I highlight the "Package ID" text box
    And I populate the "Package ID" text box with "RandomQuotes"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}190-packageid.png"

    And I highlight the "Version number" text box
    And I populate the "Version number" text box with "1.0.${bamboo.buildNumber}"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}200-version.png"

    And I highlight the "Nuget" radio button
    And I scroll the "Nuget" radio button into view offset by "-300"
    And I click the "Nuget" radio button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}210-nuget.png"

    And I highlight the "Base folder" text box
    And I populate the "Base folder" text box with "${bamboo.build.working.directory}"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}220-base-folder.png"

    And I highlight the "Output folder" text box
    And I populate the "Output folder" text box with "${bamboo.build.working.directory}"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}230-base-folder.png"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}240-octo-pack.png"
    And I click the "Save" button

  @repositoryspecific @octo-built-in-feed
  Scenario: Add Octopus Push
    And I run the feature "shared/bamboo-push-to-octo.feature" passing the original arguments

  Scenario: Create plan
    Given I set the following aliases:
      | Create   | //button[@id='createPlan']  |

    And I highlight outside the "Create" button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}220-create-project.png"
    And I click the "Create" button

  Scenario: Create plan
    And I run the feature "shared/bamboo-create-plan.feature"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser