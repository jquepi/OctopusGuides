Feature: Build and deploy a Ruby application hosted in Git on a local Octopus instance

  Scenario: Initial setup
    Given I run the feature "shared/jenkins-open-browser.feature" passing the original arguments
    And I run the feature "shared/jenkins-login.feature" passing the original arguments
    And I run the feature "shared/jenkins-install-octo-plugin.feature" passing the original arguments
    And I run the feature "shared/jenkins-configure-octo-cli.feature" passing the original arguments
    And I run the feature "shared/jenkins-initial-project-setup.feature" passing the original arguments

  @configure-project
  Scenario: Node.js - Create the project
    Given I set the following aliases:
      | Add build step        | //button[@type='button'][contains(.,'Add build step')]         |
      | Execute shell         | //a[contains(.,'Execute shell')]                               |
      | Command               | //div[@class='CodeMirror']                                     |
      | Push packages         | //a[contains(.,'Octopus Deploy: Push packages')]               |
      | Package application   | //a[contains(.,'Octopus Deploy: Package application')]         |
      | Package paths         | //textarea[@name='_.packagePaths']                             |
      | Package ID            | //input[@name='_.packageId']                                   |
      | Version number        | //input[@name='_.packageVersion']                              |
      | Package output folder | //input[@name='_.outputPath']                                  |
      | Package include paths | //textarea[@name='_.includePaths']                             |
      | Save                  | //button[@type='submit' or @type='button'][contains(.,'Save')] |

    And I scroll the "Add build step" button into view offset by "-200"
    # Need sleep to fix this:
    # org.openqa.selenium.ElementClickInterceptedException: element click intercepted: Element <button type="button" tabindex="0" id="yui-gen11-button" class="hetero-list-add" suffix="builder">...</button> is not clickable at point (317, 894). Other element would receive the click: <div class="bottom-sticker-inner">...</div>
    And I sleep for "5" second

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
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}250-npm-test.png"
    And I remove the highlight from the "Command" text box

     ################

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I sleep for "1" second
    And I highlight outside the "Package application" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}260-pack-command.png"
    And I click the "Package application" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Package application" option

    And I scroll the "Package ID" text box into view offset by "-200"
    And I highlight outside the "Package ID" text box
    And I highlight outside the "Version number" text box
    And I highlight outside the "Package include paths" text box
    And I highlight outside the "Package output folder" text box

    And I populate the "Package ID" text box with "RandomQuotes"
    And I populate the "Version number" text box with "1.0.${BUILD_NUMBER}"
    And I populate the "Package include paths" text box with "${WORKSPACE}/**"
    And I populate the "Package output folder" text box with "${WORKSPACE}"

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}270-octo-plugin-pack.png"

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I sleep for "1" second
    And I highlight outside the "Push packages" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}280-push-command.png"
    And I click the "Push packages" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Push packages" option

    And I scroll the "Package paths" text box into view offset by "-200"
    And I highlight outside the "Package paths" text box
    And I populate the "Package paths" text box with "${WORKSPACE}/RandomQuotes.1.0.${BUILD_NUMBER}.zip"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}290-octo-plugin-push.png"
    And I remove the highlight from the "Package paths" text box

    #############

    And I click the "Save" button
    And I stop recording the screen

  Scenario: Build project
    And I run the feature "shared/jenkins-build.feature"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser