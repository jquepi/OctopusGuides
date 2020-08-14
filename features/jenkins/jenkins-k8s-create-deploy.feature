Feature: Create and deploy a release from Jenkins
  This feature calls Octopus CLI directly as a script step. This was implemented before the
  Octopus plugin was available. This feature is used by the Kubernetes steps, but also any
  other non-ASP guide like Ruby, PHP and Node.js.s

  Scenario: Initial Setup
    Given I run the feature "shared/jenkins-open-browser.feature" passing the original arguments
    And I run the feature "shared/jenkins-login.feature" passing the original arguments

  Scenario: Modify the existing project
    Given I set the following aliases:
      | Random Quotes Project | //a[contains(.,'Random Quotes')]                       |
      | Configure             | //a[contains(.,'Configure')]                           |
      | Add build step        | //button[@type='button'][contains(.,'Add build step')] |
      | Execute shell         | //a[contains(.,'Execute shell')]                       |

    And I display a note with the text "Deploying an Octopus release from Jenkins" for "3" seconds

    And I highlight outside the "Random Quotes Project" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}005-random-quotes-link.png"
    And I click the "Random Quotes Project" link

    And I highlight inside the "Configure" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}010-create-release-configure.png"
    And I click the "Configure" link
    # Try and prevent this when clicking the add build step button
    # org.openqa.selenium.ElementClickInterceptedException: element click intercepted: Element <button type="button" tabindex="0" id="yui-gen21-button" class="hetero-list-add" suffix="builder">...</button> is not clickable at point (317, 949). Other element would receive the click: <footer>...</footer>
    And I sleep for "5" second

    And I scroll the "Add build step" button into view offset by "-200"
    And I sleep for "2" seconds
    And I click the "Add build step" button
    And I highlight outside the "Add build step" button
    And I highlight outside the "Execute shell" option

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}015-create-release-build-step.png"
    And I click the "Execute shell" option
    And I remove the highlight from the "Add build step" button

  Scenario: Modify the existing project
    Given I set the following aliases:
      | Save    | //button[@type='button'][contains(.,'Save')] |

    And I scroll the "ExternalShellLocator" text box into view offset by "-200"
    And I run the following JavaScript:
      """
      var textarea = document.evaluate("#{ExternalShellLocator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
      var editor = textarea.CodeMirror
      editor.setValue("#!/bin/bash\n/opt/octo/Octo create-release \\\n--server http://localhost \\\n--apiKey $OctopusAPIKey \\\n--project \"Random Quotes\" \\\n--progress \\\n--deployto Dev");
      editor.save();
      """
    And I highlight outside the "ExternalShellLocator" text box
    And I highlight outside the "Save" button
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}020-create-release-command.png"
    And I remove the highlight from the "ExternalShellLocator" text box

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}025-create-release-save.png"
    And I click the "Save" button

    And I stop recording the screen

  @build-now
  Scenario: Build project
    And I run the feature "shared/jenkins-build-two.feature"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser