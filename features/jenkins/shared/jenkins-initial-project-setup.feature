Feature: Jenkins initial project setup
  @configure-project
  Scenario: Prepare the project
    Given I set the following aliases:
      | New Item          | //a[contains(.,'New Item')]                                                       |
      | Project name      | //input[@name='name']                                                             |
      | Freestyle project | .hudson_model_FreeStyleProject                                                    |
      | OK                | //button[@type='submit'][contains(.,'OK')]                                        |
      | Git               | (//label[contains(.,'Git')])[2]                                                   |
      | Repository URL    | //input[contains(@name,'_.url')]                                                  |
      | Poll SCM          | //input[@name='hudson-triggers-SCMTrigger']                                       |
      | Schedule          | //textarea[contains(@checkurl,'checkScmpoll_spec')]                               |
      | Use secrets       | //input[@name='org-jenkinsci-plugins-credentialsbinding-impl-SecretBuildWrapper'] |
      | Bindings Add      | //button[@suffix='bindings']                                                      |
      | Secret text       | //a[contains(.,'Secret text')]                                                    |
      | Variable          | //input[@name='_.variable']                                                       |
      | Credentials       | //select[@class='setting-input  select  credentials-select']                      |

    And I open the URL "http://localhost:8080/"
    And I clear the transition

    And I display a note with the text "Creating the Jenkins project" for "3" seconds

    And I highlight inside the "New Item" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}170-new-item.png"
    And I click the "New Item" link

    And I highlight outside the "Freestyle project" link
    And I highlight outside the "Project name" link
    And I highlight outside the "OK" button
    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}180-freestyle-project.png"
    And I click the "Freestyle project" link
    And I scroll the "OK" button into view
    And I click the "OK" button

    And I scroll the "Git" option into view offset by "-200"
    And I sleep for "1" second
    And I highlight outside the "Git" option
    And I click the "Git" option
    And I highlight outside the "Repository URL" text box
    And I populate the "Repository URL" text box with "GitUrl"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}190-git-settings.png"

    And I scroll the "Poll SCM" option into view offset by "-200"
    And I sleep for "1" second
    And I click the "Poll SCM" option
    And I populate the "Schedule" textarea with "H/5 * * * *"
    And I highlight outside the "Poll SCM" option
    And I highlight outside the "Schedule" textarea
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}200-git-polling.png"
    And I remove the highlight from the "Poll SCM" option
    And I remove the highlight from the "Schedule" textarea

    And I scroll the "Use secrets" option into view offset by "-200"
    And I sleep for "1" second
    And I highlight outside the "Use secrets" option
    And I click the "Use secrets" option

    And I highlight outside the "Bindings Add" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}210-binding-add.png"
    And I sleep for "2" seconds
    And I click the "Bindings Add" option
    And I highlight outside the "Secret text" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}220-secret-text.png"
    And I remove the highlight from the "Bindings Add" option
    And I remove the highlight from the "Use secrets" option
    And I click the "Secret text" link

    And I highlight outside the "Variable" text box
    And I highlight outside the "Credentials" drop down list
    And I populate the "Variable" text box with "OctopusAPIKey"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}230-credentials-octopusapikey.png"
    And I remove the highlight from the "Variable" text box
    And I remove the highlight from the "Credentials" drop down list