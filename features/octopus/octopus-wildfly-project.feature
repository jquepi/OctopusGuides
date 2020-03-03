Feature: Configure an Octopus Wildfly project

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments

  @hide-wizard
  Scenario: Hide wizard
    Given I set the following aliases:
      | Hide wizard | //em[contains(@class,'fa fa-minus')] |
    And I click the "Hide wizard" button if it exists

  @create-project
  Scenario: Create Project
    Given I set the following aliases:
      | Projects         | //span[contains(.,'Projects')]               |
      | Add project      | //div[./div/span[contains(.,'Add Project')]] |
      | New project name | //input[contains(@id, 'Newprojectname')]     |
      | Save             | (//div[contains(.,'Save')])[9]               |

    And I start recording the screen to the directory "ExternalMediaPath"
    And I display a note with the text "Creating the Wildfly deployment project in Octopus" for "3" seconds

    And I highlight outside the "Projects" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}005-octopus-projects.png"
    And I click the "Projects" link
    And I sleep for "1" second

    And I highlight outside the "Add project" link with an offset of "1"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}010-octopus-add-project.png"
    And I click the "Add project" button
    And I remove the highlight from the "Add project" link
    And I remove the highlight from the "Projects" link

    And I highlight outside the "New project name" text box with an offset of "2"
    And I highlight outside the "Save" button with an offset of "2"
    And I populate the "New project name" text box with "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}015-octopus-new-project-name.png"
    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

  @define-project @destinationspecific @wildfly
  Scenario: Add K8S Containers Step
    Given I set the following aliases:
      | Define your deployment process | //button[contains(.,'Define your deployment process')]                                                         |
      | Add Step                       | //button[contains(.,'Add Step')]                                                                               |
      | Search                         | //input[contains(@id, 'Filterbynamecategoryordescription')]                                                    |
      | Deploy to WildFly or EAP       | //div[contains(@class, 'add-step-card') and contains(.,'Deploy to WildFly or EAP')]                            |
      | Add                            | //div[contains(@class, 'add-step-card') and contains(.,'Deploy to WildFly or EAP')]//button[contains(.,'Add')] |

    And I highlight outside the "Define your deployment process" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}030-octopus-define-process.png"

    And I click the "Define your deployment process" button
    And I sleep for "1" second

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
      | Configure features                      | (//button[contains(.,'Configure features')])[1]                                                 |
      | Substitute Variables in Files           | //input[..//label[text()='Substitute Variables in Files']]                                      |
      | Substitute Variables in Files Container | //div[./input[..//label[text()='Substitute Variables in Files']]]                               |
      | OK                                      | //button[contains(.,'Ok')]                                                                      |
      | Step Name                               | //input[contains(@id, 'Stepname')]                                                              |
      | On target roles                         | //input[@title='Runs on targets in roles (type to add new)']                                    |
      | Web role                                | //div[contains(@class, 'VirtualListWithKeyboard_menuContainer')]//span[contains(.,'web')]//span |

    And I highlight outside the "Configure features" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}070-octopus-java-enable-conf-features.png"
    And I scroll the "Configure features" button into view offset by "-300"
    And I click the "Configure features" button
    And I remove the highlight from the "Configure features" button

    And I highlight inside the "Substitute Variables in Files Container" option
    And I highlight outside the "OK" button with an offset of "2"
    And I force click the "Substitute Variables in Files" option
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}080-octopus-java-enable-conf-vars.png"
    And I click the "OK" button

    And I scroll the "Step Name" text box into view offset by "-300"
    And I highlight outside the "Step Name" text box
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
      | Package feed | (//div[./div[text()='Package feed']]/div)[2]/div |
      | Artifactory  | //div[./div/div[text()='Artifactory']]           |
      | HTML Body    | //body                                           |
      | Package ID   | //input[contains(@id, 'PackageID')]              |

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
      | HTML Body  | //body                              |
      | Package ID | //input[contains(@id, 'PackageID')] |

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
      | Deployment Name | //input[contains(@id, 'Deploymentname')] |
      | Target files    | //textarea[contains(@id, 'Targetfiles')] |
      | Save            | //button[contains(.,'Save')]             |

    And I scroll the "Deployment Name" text box into view offset by "-300"
    And I highlight outside the "Deployment Name" text box
    And I clear the "Deployment Name" text box
    And I populate the "Deployment Name" text box with "randomquotes-#{Octopus.Environment.Name | ToLower}.war"

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}140-octopus-wildfly-deploymentname.png"

    And I scroll the "Target files" text box into view offset by "-300"
    And I highlight outside the "Target files" text box
    And I populate the "Target files" text box with "**/deployed-application.yml"

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}150-octopus-tomcat-filereplacement.png"

    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

  @deploy-project
  Scenario: Deploy project
    Given I set the following aliases:
      | Create Release | //button[@title='Create release']        |
      | Save           | //button[@title='Save']                  |
      | Deploy To Dev  | //button[contains(.,'Deploy to Dev...')] |
      | Deploy         | //button[@title='Deploy']                |

    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/overview"
    And I sleep for "1" second

    And I highlight inside the "Create Release" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}170-octopus-create-release.png"
    And I click the "Create Release" button

    And I highlight outside the "Save" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}180-octopus-save-release.png"
    And I remove the highlight from the "Create Release" button
    And I force click the "Save" button
    And I sleep for "1" second

    And I highlight outside the "Deploy To Dev" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}190-octopus-deploy-to-dev.png"
    And I click the "Deploy To Dev" button

    And I highlight outside the "Deploy" button
    And I sleep for "3" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}200-octopus-deploy.png"
    And I force click the "Deploy" button

    And I stop recording the screen
    And I sleep for "60" seconds

    And I start recording the screen to the directory "ExternalMediaPath"
    And I sleep for "5" seconds

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}210-octopus-deployment.png"

  @shutdown
  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser