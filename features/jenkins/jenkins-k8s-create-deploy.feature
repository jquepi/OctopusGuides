Feature: Create and deploy a release from Jenkins

  Scenario: Log into Jenkins
    Given I set the following aliases:
      | Username     | #j_username                                                  |
      | Password     | body > div > div > form > div:nth-child(2) > input           |
      | Sign In      | body > div > div > form > div.submit.formRow > input         |
      | Profile Name | #header > div.login > span > a.model-link.inside.inverse > b |

    And I open the shared browser "ExternalBrowserType"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    When I open the URL "http://localhost:8080"
    And I populate the "Username" text box with the text "jenkinsadmin"
    And I populate the "Password" text box with the text "Password01!"
    And I click the "Sign In" button
    Then I verify the text from the "Profile Name" element matches the regex "jenkinsadmin"
    And I start recording the screen to the directory "#{ExternalMediaPath}"

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

    And I scroll the "Add build step" button into view offset by "-200"
    And I click the "Add build step" button
    And I highlight outside the "Add build step" button
    And I highlight outside the "Execute Windows batch command" option

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}015-create-release-build-step.png"
    And I click the "Execute shell" option
    And I remove the highlight from the "Add build step" button

  Scenario: Modify the existing project
    Given I set the following aliases:
      | Command | (//div[@class='CodeMirror'])[2]              |
      | Save    | //button[@type='button'][contains(.,'Save')] |

    And I scroll the "Command" text box into view offset by "-200"
    And I run the following JavaScript:
      """
      var textarea = document.evaluate("(//div[@class='CodeMirror'])[2]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
      var editor = textarea.CodeMirror
      editor.setValue("/opt/octo/Octo create-release --server http://localhost --apiKey %OctopusAPIKey% --project \"Random Quotes\" --progress --deployto Dev");
      """
    And I highlight outside the "Command" text box
    And I highlight outside the "Save" button
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}020-create-release-command.png"
    And I remove the highlight from the "Command" text box

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}025-create-release-save.png"
    And I click the "Save" button

    And I stop recording the screen

  @build-now
  Scenario: Run build
    Given I set the following aliases:
      | Build Now      | //a[contains(.,'Build Now')]      |
      | Build Two      | //a[contains(.,'#2')]             |
      | Console Output | //a[contains(.,'Console Output')] |

    And I open the URL "http://localhost:8080/job/Random%20Quotes/"
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight inside the "Build Now" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}030-build-and-deploy-now.png"
    And I click the "Build Now" link

    And I highlight inside the "Build Two" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}035-build-two.png"
    # Faking a click, because clicking this element fails a lot of the time
    And I mouse over the "Build Two" link
    And I open the URL "http://localhost:8080/job/Random%20Quotes/2/"

    And I highlight inside the "Console Output" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}040-build-and-deploy-console.png"
    And I click the "Console Output" link
    And I scroll down "10000" px
    And I sleep for "10" seconds

    And I stop recording the screen
    And I sleep for "120" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I scroll down "10000" px
    And I sleep for "5" seconds

    And I display a note with the text "'Deploy Random Quotes release 0.0.2 to Dev: Success' means Octopus deployed the project" for "3" seconds

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser