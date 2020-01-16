Feature: Build and deploy a Java application hosted in Git on a local Octopus instance

  Scenario: Initial Setup
    Given I run the feature "shared/jenkins-open-browser.feature" passing the original arguments
    And I run the feature "shared/jenkins-login.feature" passing the original arguments
    And I run the feature "shared/jenkins-add-octo-creds.feature" passing the original arguments
    And I run the feature "shared/jenkins-initial-project-setup.feature" passing the original arguments

  @configure-project
  Scenario: Java - Create the project
    Given I set the following aliases:
      | Add build step                 | //button[@type='button'][contains(.,'Add build step')] |
      | Invoke top-level Maven targets | //a[contains(.,'Invoke top-level Maven targets')]      |
      | Goals One                      | (//input[@id='textarea._.targets'])[1]                 |
      | Goals Two                      | (//input[@id='textarea._.targets'])[2]                 |

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Invoke top-level Maven targets" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}110-maven.png"
    And I click the "Invoke top-level Maven targets" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Invoke top-level Maven targets" option

    And I scroll the "Goals One" text box into view offset by "-200"
    And I highlight outside the "Goals One" text box
    And I populate the "Goals One" text box with "versions:set -DnewVersion=1.0.$BUILD_NUMBER"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}120-maven.png"
    And I remove the highlight from the "Goals One" text box

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Invoke top-level Maven targets" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}130-maven.png"
    And I click the "Invoke top-level Maven targets" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Invoke top-level Maven targets" option

  @repositoryspecific @artifactory
  Scenario: Java - Add Octopus Push Step
    Given I set the following aliases:
      | Goals Two      | (//input[@id='textarea._.targets'])[2]                 |
      | Add build step | //button[@type='button'][contains(.,'Add build step')] |
      | Execute shell  | //a[contains(.,'Execute shell')]                       |
      | Command        | //div[@class='CodeMirror']                             |
      | Save           | //button[@type='button'][contains(.,'Save')]           |

    And I scroll the "Goals Two" text box into view offset by "-200"
    And I highlight outside the "Goals Two" text box
    And I populate the "Goals Two" text box with "clean test package deploy -Pwar -s /opt/settings.xml"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}140-maven.png"
    And I remove the highlight from the "Goals Two" text box

  @repositoryspecific @octo-built-in-feed
  Scenario: Java - Add Octopus Push Step
    Given I set the following aliases:
      | Goals Two      | (//input[@id='textarea._.targets'])[2]                 |
      | Add build step | //button[@type='button'][contains(.,'Add build step')] |
      | Execute shell  | //a[contains(.,'Execute shell')]                       |
      | Command        | //div[@class='CodeMirror']                             |
      | Save           | //button[@type='button'][contains(.,'Save')]           |

    And I scroll the "Goals Two" text box into view offset by "-200"
    And I highlight outside the "Goals Two" text box
    And I populate the "Goals Two" text box with "clean test package -Pwar"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}140-maven.png"
    And I remove the highlight from the "Goals Two" text box

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I sleep for "1" second
    And I highlight outside the "Execute shell" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}150-batch-command.png"
    And I click the "Execute shell" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute shell" option

    And I scroll the "Command" text box into view offset by "-200"
    And I highlight outside the "Command" text box
    And I run the following JavaScript:
      """
      var textarea = document.evaluate("//div[@class='CodeMirror']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
      var editor = textarea.CodeMirror
      editor.setValue("#!/bin/bash\n/opt/octo/Octo push --server http://localhost --package \"#{ArtifactPath}\" --apiKey $OctopusAPIKey");
      editor.save();
      """
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}160-octo-push.png"
    And I remove the highlight from the "Command" text box

  Scenario: Save project
    Given I set the following aliases:
      | Save | //button[@type='button'][contains(.,'Save')] |

    And I click the "Save" button
    And I stop recording the screen

  @build-now
  Scenario: Run build
    And I run the feature "shared/jenkins-build.feature"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser
