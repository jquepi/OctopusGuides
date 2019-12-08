Feature: Build and deploy a ASP.NET application hosted in Git on a local Octopus instance

  Scenario: Initial Setup
    Given I run the feature "shared/jenkins-open-browser.feature" passing the original arguments
    And I run the feature "shared/jenkins-login.feature" passing the original arguments
    And I run the feature "shared/jenkins-add-octo-creds.feature" passing the original arguments
    And I run the feature "shared/jenkins-initial-project-setup.feature" passing the original arguments

  @configure-project @applicationspecific @java
  Scenario: ASP.NET - Create the project
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
    And I remove the highlight from the "Execute Windows batch command" option

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
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Goals" text box into view offset by "-200"
    And I highlight outside the "Goals" text box
    And I populate the "Goals" text box with "clean test package -Pwar"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}140-maven.png"
    And I remove the highlight from the "Goals" text box

  Scenario: Java - Add Octopus Push Step
    Given I set the following aliases:
      | Add build step                | //button[@type='button'][contains(.,'Add build step')] |
      | Execute Windows batch command | //a[contains(.,'Execute Windows batch command')]       |
      | Command One                   | (//textarea[contains(@name,'command')])[1]             |
      | Save                          | //button[@type='button'][contains(.,'Save')]           |

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Execute Windows batch command" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}150-batch-command.png"
    And I click the "Execute Windows batch command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Windows batch command" option

    And I scroll the "Command One" text box into view offset by "-200"
    And I highlight outside the "Command One" text box
    And I highlight outside the "Save" button
    And I populate the "Command One" text box with "Octo.exe push --server http://localhost --package #{ArtifactPath} --apiKey %OctopusAPIKey%"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}160-octo-push.png"

    And I click the "Save" button
    And I stop recording the screen

  @build-now
  Scenario: Run build
    And I run the feature "shared/jenkins-build.feature"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser
