Feature: Create Docker project

  Scenario: Prepare TeamCity
    Given I run the feature "shared/teamcity-login.feature" passing the original arguments

  @create-project @applicationspecific @php
  Scenario: Create Project
    Given I set the following aliases:
      | Create project        | //a[contains(.,'Create project')]                        |
      | Repository URL        | //input[@id='url']                                       |
      | Proceed               | //input[@name='createProjectFromUrl']                    |
      | Project name          | //input[@id='projectName']                               |
      | Proceed Two           | //input[@name='createProject']                           |
      | Configure manually    | //a[text()='configure build steps manually']             |
      | Runner type           | //input[@id='-ufd-teamcity-ui-runTypeInfoKey']           |
      | Runner type container | //span[./input[@id='-ufd-teamcity-ui-runTypeInfoKey']]   |
      | Command Line          | //li[@data-title='Command Line']                         |
      | Docker                | //li[@data-title='Docker']                               |
      | Step name             | //input[@id='buildStepName']                             |
      | Script content        | //textarea[@id='script.content']                         |
      | Test option           | //li[@data-title='test']                                 |
      | Path to file          | //input[@id='path']                                      |
      | Image name:tag        | //textarea[@id='docker.image.namesAndTags']              |
      | Push                  | //input[@name='prop:docker.command.type'][@value='push'] |
      | Save                  | (//input[@value='Save'])[1]                              |
      | Got it                | //button[contains(.,'Got it')]                           |

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
    And I sleep for "3" seconds
    And I stop recording the screen

    And I verify the "Project name" text box is present waiting up to "120" seconds

    And I start recording the screen to the directory "#{ExternalMediaPath}"
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
    And I populate the "Step name" text box with "Dependency Install and Test"

    And I highlight outside the "Script content" text area
    And I scroll the "Script content" text area into view offset by "-200"

    # TeamCity 2019.1 uses a plain text box for scripts
#    And I populate the "Script content" text area with:
#    """
#    composer install
#    ./vendor/bin/phpunit --bootstrap ./vendor/autoload.php ./tests/QuoteTest.php
#    """

    # TeamCity 2019.2 introduced rich script editors that have to be populated with javascript
    And I run the following JavaScript:
    """
    var textarea = document.evaluate("//div[contains(@class,'CodeMirror')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    var editor = textarea.CodeMirror
    editor.setValue("composer install\n./vendor/bin/phpunit --bootstrap ./vendor/autoload.php ./tests/QuoteTest.php");
    editor.save();
    """
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}045-npm-install.png"

    And I highlight outside the "Save" button
    And I scroll the "Save" button into view
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}050-npm-install.png"
    And I click the "Save" button

    And I click the "Got it" button waiting up to "5" seconds if it exists

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}060-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list
    And I scroll the "Docker" option into view offset by "-200"
    And I click the "Docker" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Docker Build"

    And I scroll the "Path to file" text box into view offset by "-300"
    And I highlight outside the "Path to file" text box
    And I populate the "Path to file" text box with "Dockerfile"

    And I scroll the "Image name:tag" text box into view offset by "-300"
    And I highlight outside the "Image name:tag" text box
    And I highlight outside the "Save" button
    And I populate the "Image name:tag" text box with "octopussamples/randomquotesphp:1.0.%build.counter%"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}070-docker-build.png"
    And I click the "Save" button

    And I highlight outside the "Add build step" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}080-add-build-step.png"
    And I click the "Add build step" button

    And I click the "Runner type" drop down list
    And I scroll the "Docker" option into view offset by "-200"
    And I click the "Docker" option
    And I sleep for "1" second
    And I highlight outside the "Runner type container" drop down list

    And I highlight outside the "Step name" text box
    And I populate the "Step name" text box with "Docker Push"

    And I click the "Push" radio button

    And I scroll the "Image name:tag" text box into view offset by "-300"
    And I highlight outside the "Image name:tag" text box
    And I highlight outside the "Save" button
    And I populate the "Image name:tag" text box with "octopussamples/randomquotesphp:1.0.%build.counter%"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}090-docker-push.png"
    And I click the "Save" button

  Scenario: Add Connection
    And I run the feature "shared/teamcity-adddockerconnection.feature"
    And I run the feature "shared/teamcity-docker-build-feature.feature"

  @run-build
  Scenario: Run a build
    And I run the feature "shared/teamcity-runbuild-after-other-config.feature"
    And I run the feature "shared/teamcity-close.feature"