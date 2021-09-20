Feature: Create and deploy a release from Jenkins
  This feature is used by the asp.net and asp.net core guides to create and deploy a release.

  Scenario: Log into Jenkins
    Given I set the following aliases:
      | Username     | #j_username                                          |
      | Password     | body > div > div > form > div:nth-child(2) > input   |
      | Sign In      | body > div > div > form > div.submit.formRow > input |
      | Profile Name | /html/body/div[2]/header/div[3]/a[1]/span            |

    And I open the shared browser "ExternalBrowserType"
    And I set the default explicit wait time to "30" seconds
    And I fullscreen the window
    When I open the URL "http://localhost:8080/login"
    And I populate the "Username" text box with the text "admin"
    And I populate the "Password" text box with the text "Password01!"
    And I click the "Sign In" button
    Then I verify the text from the "Profile Name" element matches the regex "admin"
    And I start recording the screen to the directory "#{ExternalMediaPath}"

  Scenario: Modify the existing project
    Given I set the following aliases:
      | Random Quotes Project | //a[contains(.,'Random Quotes')]                              |
      | Configure             | //a[contains(.,'Configure')]                                  |
      | Add post-build action | //button[@type='button'][contains(.,'Add post-build action')] |
      | Create Release        | //a[contains(.,'Octopus Deploy: Create Release')]             |

    And I display a note with the text "Deploying an Octopus release from Jenkins" for "3" seconds

    And I highlight outside the "Random Quotes Project" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}005-random-quotes-link.png"
    And I click the "Random Quotes Project" link

    And I highlight inside the "Configure" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}010-create-release-configure.png"
    And I click the "Configure" link

    And I scroll the "Add post-build action" button into view offset by "-200"
    And I sleep for "2" seconds
    And I click the "Add post-build action" button
    And I highlight outside the "Add post-build action" button
    And I highlight outside the "Create Release" option

  @repositoryspecific @octo-built-in-feed
  Scenario: Modify the existing project
    Given I set the following aliases:
      | Add post-build action | //button[@type='button'][contains(.,'Add post-build action')] |
      | Create Release        | //a[contains(.,'Octopus Deploy: Create Release')]             |

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}015-octo-plugin-create-release-build-step.png"
    And I click the "Create Release" option
    And I remove the highlight from the "Add post-build action" button

#    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}015-create-release-build-step.png"
#    And I click the "Execute Windows batch command" option
#    And I remove the highlight from the "Add post-build action" button

  @repositoryspecific @artifactory
  Scenario: Modify the existing project
    Given I set the following aliases:
      | Add post-build action | //button[@type='button'][contains(.,'Add post-build action')] |
      | Create Release        | //a[contains(.,'Octopus Deploy: Create Release')]             |

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}015-octo-plugin-create-release-build-step-artifactory.png"
    And I click the "Create Release" option
    And I remove the highlight from the "Add post-build action" button

#    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}015-create-release-build-step-artifactory.png"
#    And I click the "Execute Windows batch command" option
#    And I remove the highlight from the "Add build step" button

  Scenario: Modify the existing project
    Given I set the following aliases:
      | Project name             | //input[@name='_.project']                                     |
      | Environment              | //input[@name='_.environment']                                 |
      | Deploy after create      | //input[@name='deployThisRelease']                             |
      | Show deployment progress | //input[@name='waitForDeployment']                             |
      | Save                     | //button[@type='submit' or @type='button'][contains(.,'Save')] |

    And I scroll the "Project name" text box into view offset by "-200"
    And I highlight the "Project name" text box
    And I populate the "Project name" text box with "Random Quotes"

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}020-octo-plugin-create-release-command.png"

    And I scroll the "Deploy after create" text box into view offset by "-200"
    And I highlight the "Deploy after create" check box
    And I click the "Deploy after create" check box

    And I highlight the "Show deployment progress" check box
    And I click the "Show deployment progress" check box

    And I highlight the "Environment" text box
    And I populate the "Environment" text box with "Dev"

    And I highlight outside the "Save" button
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}025-octo-plugin-create-release-command.png"

    And I remove the highlight from the "Project name" text box
    And I remove the highlight from the "Deploy after create" check box
    And I remove the highlight from the "Environment" text box

#    And I scroll the "Command Four" text box into view offset by "-200"
#    And I populate the "Command Four" text box with "Create Release Command"
#    And I highlight outside the "Command Four" text box
#    And I highlight outside the "Save" button
#    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}020-create-release-command.png"
#    And I remove the highlight from the "Command Four" text box
#
#    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}025-create-release-save.png"

    And I click the "Save" button

    And I stop recording the screen

#  @applicationspecific @aspnetcore
#  Scenario: Modify the existing project
#    Given I set the following aliases:
#      | Command Five           | (//textarea[contains(@name,'command')])[5]                                                                                     |
#      | Save                   | //button[@type='submit' or @type='button'][contains(.,'Save')]                                                                                   |
#      | Create Release Command | Octo.exe create-release --server http://localhost --apiKey %OctopusAPIKey% --project "Random Quotes" --progress --deployto Dev |
#
#    And I scroll the "Command Five" text box into view offset by "-200"
#    And I populate the "Command Five" text box with "Create Release Command"
#    And I highlight outside the "Command Five" text box
#    And I highlight outside the "Save" button
#    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}020-create-release-command.png"
#    And I remove the highlight from the "Command Five" text box
#
#    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}025-create-release-save.png"
#    And I click the "Save" button
#
#    And I stop recording the screen

  @build-now
  Scenario: Run build
    And I run the feature "shared/jenkins-build-two.feature"

  @destinationspecific @iis
  Scenario: Get log screenshot
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}045-build-and-deploy-logs.png"

  @destinationspecific @azure-web-app
  Scenario: Get log screenshot
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}045-build-and-deploy-logs-azure.png"

  Scenario: display message
    And I display a note with the text "'Deploy Random Quotes release 0.0.2 to Dev: Success' means Octopus deployed the project" for "3" seconds

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser