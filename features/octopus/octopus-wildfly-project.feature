Feature: Configure an Octopus Wildfly project

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments
    And I run the feature "shared/octopus-hide-wizard.feature" passing the original arguments
    And I run the feature "shared/octopus-create-project.feature" passing the original arguments
    And I run the feature "shared/octopus-define-variables.feature" passing the original arguments
    And I run the feature "shared/octopus-define-java-variables.feature" passing the original arguments

  @define-project @destinationspecific @wildfly
  Scenario: Add Wildfly Step
    Given I set the following aliases:
      | Define your deployment process | //button[contains(.,'Create Process')]                                         |
      | Add Step                       | //button[contains(.,'Add Step')]                                               |
      | Search                         | //input[@name='Filter by name, category or description...']                    |
      | Deploy to WildFly or EAP       | //div[./div/div[text()='Deploy to WildFly or EAP']]                            |
      | Add                            | //div[./div/div[text()='Deploy to WildFly or EAP']]//button[contains(.,'Add')] |

    And I highlight outside the "Define your deployment process" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}030-octopus-define-process.png"

    And I click the "Define your deployment process" button
    And I sleep for "1" second

    And I scroll the "Add Step" button into view offset by "-500"
    And I highlight outside the "Add Step" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}040-octopus-wildfly-add-step.png"
    And I click the "Add Step" button

    And I highlight outside the "Search" text box with an offset of "3"
    And I populate the "Search" text box with "Wildfly"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}050-octopus-wildfly-search.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Deploy to WildFly or EAP" tile into view offset by "-200"
    And I highlight outside the "Deploy to WildFly or EAP" tile
    And I mouse over the "Deploy to WildFly or EAP" tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}060-octopus-wildfly.png"
    And I force click the "Add" button

  @define-project @destinationspecific @wildfly
  Scenario: K8S Define step
    Given I set the following aliases:
      | Configure features                           | (//button[contains(.,'Configure features')])[1]                                      |
      | Structured Configuration Variables           | //input[..//label[text()='Structured Configuration Variables']]                      |
      | Structured Configuration Variables Container | //div[./input[..//label[text()='Structured Configuration Variables']]]               |
      | OK                                           | //button[contains(.,'Ok')]                                                           |
      | Step Name                                    | //input[@name='Step name']                                                           |
      | On target roles                              | //input[../../label[contains(text(), 'Runs on targets in roles (type to add new)')]] |
      | Web role                                     | //div[contains(@class, 'VirtualListWithKeyboard')]//span[contains(.,'web')]//span    |

    And I highlight outside the "Configure features" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}070-octopus-java-enable-conf-features.png"
    And I scroll the "Configure features" button into view offset by "-300"
    And I click the "Configure features" button
    And I remove the highlight from the "Configure features" button

    And I highlight inside the "Structured Configuration Variables Container" option
    And I highlight outside the "OK" button with an offset of "2"
    And I force click the "Structured Configuration Variables" option
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}080-octopus-java-enable-structured-vars.png"
    And I click the "OK" button

    And I scroll the "Step Name" text box into view offset by "-300"
    And I highlight outside the "Step Name" text box
    And I force clear the "Step Name" text box
    And I populate the "Step Name" text box with "Deploy to Wildfly"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}090-octopus-wildfly-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "On target roles" text box into view offset by "-300"
    And I click the "On target roles" text box
    And I populate the "On target roles" text box with "web"
    And I sleep for "1" second
    And I highlight outside the "On target roles" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}100-octopus-wildfly-step-role.png"
    And I click the "Web role" option
    And I remove the highlight from the "On target roles" text box

  @define-project @destinationspecific @wildfly @repositoryspecific @artifactory
  Scenario: Select artifactory feed for the Wildfly deployment
    Given I set the following aliases:
      | Package feed | //div[./label[text()='Package feed']]/div/div |
      | Artifactory  | //button[./div/div[text()='Artifactory']]     |
      | HTML Body    | //body                                        |
      | Package ID   | //input[@name='PackageID']                    |

    And I scroll the "Package feed" drop down list into view offset by "-300"
    And I click the "Package feed" drop down list
    And I sleep for "1" second
    And I force click the "Artifactory" option
    And I highlight outside the "Package feed" drop down list
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}110-octopus-step-feed.png"
    And I remove the highlight from the "Package feed" text box

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "com.octopus:randomquotes"
    And I sleep for "2" second
    And I press the escape key from the "Package ID" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}120-octopus-step-package.png"
    And I remove the highlight from the "Package ID" text box

  @define-project @destinationspecific @wildfly @repositoryspecific @octo-built-in-feed
  Scenario: Select built in feed for the Wildfly deployment
    Given I set the following aliases:
      | HTML Body  | //body                     |
      | Package ID | //input[@name='PackageID'] |

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "randomquotes"
    And I sleep for "2" second
    And I press the escape key from the "Package ID" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}130-octopus-step-package.png"
    And I remove the highlight from the "Package ID" text box

  @define-project @destinationspecific @wildfly
  Scenario: K8S Define step
    Given I set the following aliases:
      | Deployment Name | //input[@name='Deployment name'] |
      | Target files    | //textarea[@name='Target files'] |
      | Save            | //button[contains(.,'Save')]     |

    And I scroll the "Deployment Name" text box into view offset by "-300"
    And I highlight outside the "Deployment Name" text box
    And I clear the "Deployment Name" text box
    And I populate the "Deployment Name" text box with "randomquotes-#{Octopus.Environment.Name | ToLower}.war"

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}140-octopus-wildfly-deploymentname.png"

    And I scroll the "Target files" text box into view offset by "-300"
    And I highlight outside the "Target files" text box
    And I populate the "Target files" text box with "**/application.yml"

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}150-octopus-wildfly-varinjection.png"

    And I click the "Save" button

    And I sleep for "3" seconds
    # Give the step time to save
    And I stop recording the screen
    And I sleep for "60" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

  @deploy-project
  Scenario: Deploy project
    And I run the feature "shared/octopus-deploy-project.feature" passing the original arguments

  @shutdown
  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser
