Feature: Create PHP project

  Scenario: Prepare TeamCity
    Given I run the feature "shared/teamcity-login.feature" passing the original arguments

  @create-project @applicationspecific @php
  Scenario: Create Project
    Given I set the following aliases:
      | Create project        | //a[contains(.,'Create project')]                      |
      | Repository URL        | //input[@id='url']                                     |
      | Proceed               | //input[@name='createProjectFromUrl']                  |
      | Project name          | //input[@id='projectName']                             |
      | Proceed Two           | //input[@name='createProject']                         |
      | Configure manually    | //a[text()='configure build steps manually']           |
      | Runner type           | //input[@id='-ufd-teamcity-ui-runTypeInfoKey']         |
      | Runner type container | //span[./input[@id='-ufd-teamcity-ui-runTypeInfoKey']] |
      | Command Line          | //li[@data-title='Command Line']                       |
      | Step name             | //input[@id='buildStepName']                           |
      | Script content        | //textarea[@id='script.content']                       |
      | OctopusDeploy: Pack   | //li[@data-title='OctopusDeploy: Pack']                |
      | Package ID            | //input[@id='octopus_packageid']                       |
      | Package Version       | //input[@id='octopus_packageversion']                  |
      | Source path           | //input[@id='octopus_packagesourcepath']               |
      | Output path           | //input[@id='octopus_packageoutputpath']               |
      | Save                  | (//input[@value='Save'])[1]                            |
      | Got it                | //button[contains(.,'Got it')]                         |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Create the TeamCity project" for "3" seconds

    And I highlight outside the "Create project" button with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}010-create-project.png"
    And I click the "Create project" button

    And I highlight outside the "Repository URL" text box
    And I highlight outside the "Proceed" button
    And I populate the "Repository URL" text box with the text "GitUrl"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}020-repo-url.png"
    And I click the "Proceed" button

    And I verify the "Project name" text box is present waiting up to "300" seconds
    And I highlight outside the "Project name" text box
    And I highlight outside the "Proceed Two" button
    And I mouse over the "Project name" text box
    And I clear the "Project name" text box
    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}030-project-name.png"
    And I click the "Proceed Two" button

    And I highlight outside the "Configure manually" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}040-configure-manually.png"
    And I click the "Configure manually" link

    And I click the "Runner type" drop down list
    And I scroll the "Command Line" option into view offset by "-300"
    And I click the "Command Line" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Composer Install and Test"

    And I highlight outside the "Script content" text area
    And I scroll the "Script content" text area into view offset by "-200"
    And I run the following JavaScript:
      """
      var textarea = document.evaluate("//div[contains(@class,'CodeMirror')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
      var editor = textarea.CodeMirror
      editor.setValue("composer install\n./vendor/bin/phpunit ./tests/quotetest.php");
      editor.save();
      """
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}050-npm-install.png"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}060-npm-install.png"
    And I click the "Save" button

    And I click the "Got it" button waiting up to "5" seconds if it exists

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}070-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list

    And I scroll the "OctopusDeploy: Pack" option into view
    And I click the "OctopusDeploy: Pack" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Pack Project"

    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "RandomQuotes"

    And I highlight outside the "Package Version" text box
    And I populate the "Package Version" text box with "1.0.%build.counter%"

    And I highlight outside the "Source path" text box
    And I populate the "Source path" text box with "."

    And I highlight outside the "Output path" text box
    And I populate the "Output path" text box with "."

    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}080-octo-pack.png"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}090-octo-pack.png"
    And I click the "Save" button

  @create-project @repositoryspecific @octo-built-in-feed
  Scenario: Add octopus push step
    Given I set the following aliases:
      | Add build step               | //a[contains(.,'Add build step')]                          |
      | Runner type                  | //input[@id='-ufd-teamcity-ui-runTypeInfoKey']             |
      | Runner type container        | //span[./input[@id='-ufd-teamcity-ui-runTypeInfoKey']]     |
      | OctopusDeploy: Push Packages | //li[@data-title='OctopusDeploy: Push Packages']           |
      | Octopus URL                  | //input[@id='octopus_host']                                |
      | Octopus API key              | //input[@id='secure:octopus_apikey']                       |
      | Package paths                | //textarea[@id='octopus_packagepaths']                     |
      | Save                         | //input[@value='Save']                                     |
      | Step name                    | //input[@id='buildStepName']                               |
      | Build Configuration Home     | //a[@href='/viewType.html?buildTypeId=RandomQuotes_Build'] |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}120-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list

    And I scroll the "OctopusDeploy: Push Packages" option into view
    And I click the "OctopusDeploy: Push Packages" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I scroll the "Step name" text box into view offset by "-300"
    And I populate the "Step name" text box with "Push to Octopus"

    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}130-push-top-octo.png"

    And I remove the highlight from the "Runner type container" drop down list
    And I remove the highlight from the "Step name" text box

    And I highlight outside the "Octopus URL" text box
    And I scroll the "Octopus URL" text box into view offset by "-300"
    And I populate the "Octopus URL" text box with "http://localhost"

    And I highlight outside the "Octopus API key" text box
    And I scroll the "Octopus API key" text box into view offset by "-300"
    And I populate the "Octopus API key" text box with "ExternalOctopusAPIKey"

    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}140-push-top-octo.png"

    And I remove the highlight from the "Octopus URL" text box
    And I remove the highlight from the "Octopus API key" text box

    And I highlight outside the "Package paths" text box
    And I scroll the "Package paths" text box into view offset by "-300"
    And I populate the "Package paths" text box with "RandomQuotes.1.0.%build.counter%.nupkg"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view

    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}150-push-top-octo.png"

    And I click the "Save" button

    And I highlight outside the "Build Configuration Home" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}160-build-config-home.png"
    And I click the "Build Configuration Home" link

    And I stop recording the screen

  @run-build
  Scenario: Run a build
    And I run the feature "shared/teamcity-runbuild.feature"
    And I run the feature "shared/teamcity-close.feature"