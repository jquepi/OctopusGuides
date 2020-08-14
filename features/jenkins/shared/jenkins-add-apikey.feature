  Feature: Jenkins initial project setup

  @configure-project
  Scenario: Prepare the project
    Given I set the following aliases:
      | Use secrets       | //input[@name='org-jenkinsci-plugins-credentialsbinding-impl-SecretBuildWrapper'] |
      | Bindings Add      | //button[@suffix='bindings']                                                      |
      | Secret text       | //a[contains(.,'Secret text')]                                                    |
      | Variable          | //input[@name='_.variable']                                                       |
      | Credentials       | //select[@class='setting-input  select  credentials-select']                      |

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