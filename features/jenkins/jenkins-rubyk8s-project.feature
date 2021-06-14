Feature: Build and deploy a PHP application hosted in Git on a local Octopus instance

  Scenario: Initial setup
    Given I run the feature "shared/jenkins-open-browser.feature" passing the original arguments
    And I run the feature "shared/jenkins-login.feature" passing the original arguments
    And I run the feature "shared/jenkins-install-octo-plugin.feature" passing the original arguments
    And I run the feature "shared/jenkins-configure-octo-cli.feature" passing the original arguments
    And I run the feature "shared/jenkins-docker-plugin.feature" passing the original arguments
    And I run the feature "shared/jenkins-docker-creds.feature" passing the original arguments
    And I run the feature "shared/jenkins-configure-docker.feature" passing the original arguments
    And I run the feature "shared/jenkins-initial-project-setup.feature" passing the original arguments

  @configure-project
  Scenario: ASP.NET Core - Create the project
    Given I set the following aliases:
      | Add build step                               | //button[@type='button'][contains(.,'Add build step')]                    |
      | Execute shell                                | //a[contains(.,'Execute shell')]                                          |
      | Command                                      | //div[@class='CodeMirror']                                                |
      | Execute Docker command                       | //a[contains(.,'Execute Docker command')]                                 |
      | Docker command one                           | (//select[../../div[normalize-space(text())='Docker command']])[1]        |
      | Docker command two                           | (//select[../../div[normalize-space(text())='Docker command']])[2]        |
      | Create/build image                           | 4                                                                         |
      | Build context folder                         | //input[@name='_.dockerFolder']                                           |
      | Tag of the resulting docker image            | //input[@name='_.imageTag']                                               |
      | Push image                                   | 7                                                                         |
      | Name of the image to push (repository/image) | //input[@name='_.image']                                                  |
      | Tag                                          | (//input[@name='_.tag'])[3]                                               |
      | Registry                                     | //input[@name='_.registry']                                               |
      | Docker registry URL                          | (//input[@name='_.url'])[2]                                               |
      | Registry credentials                         | //select[../../../../div[normalize-space(text())='Registry credentials']] |
      | Save                                         | //button[@type='submit' or @type='button'][contains(.,'Save')]            |

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I highlight outside the "Execute shell" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}240-shell-command-1.png"
    And I click the "Execute shell" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute shell" option

    And I scroll the "Command" text box into view offset by "-200"
    And I highlight outside the "Command" text box
    And I run the following JavaScript:
      """
      var textarea = document.evaluate("//div[@class='CodeMirror']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
      var editor = textarea.CodeMirror;
      editor.setValue("#!\/bin\/bash -l\n# Set the default gem installation path\nexport GEM_HOME=\"$WORKSPACE\/vendor\"\nexport GEM_PATH=\"$WORKSPACE\/vendor\"\nexport PATH=\"$PATH:$WORKSPACE\/vendor\/bin\"\n# Install the specific version of Bundler defined in the Gemfile.lock file\ngem install bundler -v \"$(grep -A 1 \"BUNDLED WITH\" Gemfile.lock | tail -n 1)\"\n# Use bundler to install the other dependencies\nbundle install\n# Run the tests\nrspec spec\/index_spec.rb");
      editor.save();
      """
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}250-dotnet-test.png"
    And I remove the highlight from the "Command" text box

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I highlight outside the "Execute Docker command" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}260-execute-docker-command-1.png"
    And I click the "Execute Docker command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Docker command" option

    And I scroll the "Docker command one" drop down list into view offset by "-300"
    And I highlight outside the "Docker command one" drop down list with an offset of "2"
    And I select the option value "Create/build image" from the "Docker command one" drop down list

    And I scroll the "Build context folder" text box into view offset by "-300"
    And I highlight outside the "Build context folder" text box with an offset of "2"
    And I clear the "Build context folder" text box
    And I populate the "Build context folder" text box with "$WORKSPACE"

    And I scroll the "Tag of the resulting docker image" text box into view offset by "-300"
    And I highlight outside the "Tag of the resulting docker image" text box with an offset of "2"
    And I clear the "Tag of the resulting docker image" text box
    And I populate the "Tag of the resulting docker image" text box with "octopussamples/randomquotesruby:1.0.$BUILD_NUMBER"

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}270-execute-docker-command-1.png"

    And I remove the highlight from the "Docker command one" drop down list
    And I remove the highlight from the "Build context folder" text box
    And I remove the highlight from the "Tag of the resulting docker image" text box

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I highlight outside the "Execute Docker command" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}280-execute-docker-command-1.png"
    And I click the "Execute Docker command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Docker command" option

    And I scroll the "Docker command two" drop down list into view offset by "-300"
    And I highlight outside the "Docker command two" drop down list with an offset of "2"
    And I select the option value "Push image" from the "Docker command two" drop down list

    And I scroll the "Name of the image to push (repository/image)" text box into view offset by "-300"
    And I highlight outside the "Name of the image to push (repository/image)" text box with an offset of "2"
    And I populate the "Name of the image to push (repository/image)" text box with "randomquotesruby"

    And I scroll the "Tag" text box into view offset by "-300"
    And I highlight outside the "Tag" text box with an offset of "2"
    And I populate the "Tag" text box with "1.0.$BUILD_NUMBER"

  Scenario: Build project
    And I run the feature "shared/push-and-build-docker.feature" passing the original arguments