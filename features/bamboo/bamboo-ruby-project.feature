Feature: Configure Bamboo

  Scenario: Configure Bamboo
    Given I run the feature "shared/bamboo-login.feature" passing the original arguments
    And I run the feature "shared/bamboo-manually-add-plugin.feature" passing the original arguments
    And I run the feature "shared/bamboo-configure-octopus.feature" passing the original arguments
    And I run the feature "shared/bamboo-add-project.feature" passing the original arguments

  @applicationspecific @ruby
  Scenario: Ruby Add tasks
    Given I set the following aliases:
      | Add task                     | //a[@id='addTask']                                                                          |
      | Search                       | //h2[contains(.,'Task types')]//input                                                       |
      | Script Tile                  | //li[.//div[@class='task-type-description']][.//h4[normalize-space(text())='Script']]       |
      | Interpreter                  | //select[@id='interpreter']                                                                 |
      | Script body                  | //div[@id='scriptBody']                                                                     |
      | Environment Variables        | //input[@id='environmentVariables']                                                         |
      | PHP Tile                     | (//li[.//div[@class='task-type-description']][.//h4[normalize-space(text())='PHPUnit']])[1] |
      | Octopus Deploy: Pack Package | //li[.//h4[normalize-space(text())='Octopus Deploy: Pack Package']]                         |
      | Task description             | //input[@id='createTask_userDescription']                                                   |
      | Command                      | //input[@id='command']                                                                      |
      | Add new executable           | //a[@class='addSharedBuilderCapability']                                                    |
      | Executable label             | //input[@id='addSharedBuilderCapability_builderLabel']                                      |
      | Path                         | //input[@id='addSharedBuilderCapability_builderPath']                                       |
      | Add                          | //input[@id='addSharedBuilderCapability_save']                                              |
      | Arguments                    | //textarea[@id='arguments']                                                                 |
      | Working subdirectory         | //input[@id='workingSubDirectory']                                                          |
      | Package ID                   | //input[@id='packId']                                                                       |
      | Version number               | //input[@id='packVersion']                                                                  |
      | Nuget                        | //input[@id='packFormatnuget']                                                              |
      | Base folder                  | //input[@id='packBasePath']                                                                 |
      | Output folder                | //input[@id='packOutFolder']                                                                |
      | Save                         | //input[@id='createTask_save']                                                              |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    # Bundle install

    And I highlight outside the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}100-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight outside the "Search" box
    And I populate the "Search" box with "Script"
    And I highlight inside the "Script Tile" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}110-search.png"
    And I click the "Script Tile" element

    And I highlight outside the "Task description" text box
    And I scroll the "Task description" text box into view offset by "-300"
    And I populate the "Task description" text box with "Bundle Install and Test"

    And I highlight outside the "Interpreter" text box
    And I scroll the "Interpreter" drop down list into view offset by "-300"
    And I select the option "Shell" from the "Interpreter" drop down list

    And I highlight inside the "Script body" text box
    And I scroll the "Script body" text area into view offset by "-300"
    And I run the following JavaScript:
      """
      ace.edit(scriptBody).setValue("# Set the default gem installation path\nexport GEM_HOME=\"${bamboo.agentWorkingDirectory}\/vendor\"\nexport GEM_PATH=\"${bamboo.agentWorkingDirectory}\/vendor\"\nexport PATH=\"$PATH:${bamboo.agentWorkingDirectory}\/vendor\/bin\"\n# Install the specific version of Bundler defined in the Gemfile.lock file\ngem install bundler -v \"$(grep -A 1 \"BUNDLED WITH\" Gemfile.lock | tail -n 1)\"\n# Use bundler to install the other dependencies\nbundle install\n# Run the tests\nrspec spec\/index_spec.rb")
      """
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}120-composer-install.png"
    And I remove the highlight from the "Script body" text box

    And I highlight outside the "Environment Variables" text box
    And I scroll the "Environment Variables" text box into view offset by "-300"
    And I populate the "Environment Variables" text box with "HOME=/home/runner"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}130-composer-install.png"
    And I click the "Save" button

    # Create package

    And I highlight the "Add task" button with an offset of "2"
    And I scroll the "Add task" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}180-add-task.png"
    And I click the "Add task" button
    And I remove the highlight from the "Add task" button

    And I highlight the "Search" box
    And I populate the "Search" box with "Octopus"
    And I highlight inside the "Octopus Deploy: Pack Package" element
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}190-search.png"
    And I click the "Octopus Deploy: Pack Package" element

    And I highlight the "Task description" text box
    And I populate the "Task description" text box with "Create package"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}200-description.png"

    And I highlight the "Package ID" text box
    And I populate the "Package ID" text box with "RandomQuotes"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}210-packageid.png"

    And I highlight the "Version number" text box
    And I populate the "Version number" text box with "1.0.${bamboo.buildNumber}"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}220-version.png"

    And I highlight the "Nuget" radio button
    And I scroll the "Nuget" radio button into view offset by "-300"
    And I click the "Nuget" radio button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}230-nuget.png"

    And I highlight the "Base folder" text box
    And I populate the "Base folder" text box with "${bamboo.build.working.directory}"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}240-base-folder.png"

    And I highlight the "Output folder" text box
    And I populate the "Output folder" text box with "${bamboo.build.working.directory}"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}250-base-folder.png"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}260-octo-pack.png"
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