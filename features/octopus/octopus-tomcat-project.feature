Feature: Configure an Octopus Tomcat project

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments
    And I run the feature "shared/octopus-hide-wizard.feature" passing the original arguments
    And I run the feature "shared/octopus-create-project.feature" passing the original arguments
    And I run the feature "shared/octopus-define-variables.feature" passing the original arguments
    And I run the feature "shared/octopus-define-java-variables.feature" passing the original arguments

  @define-project @destinationspecific @tomcat
  Scenario: Add K8S Containers Step
    Given I set the following aliases:
      | Define your deployment process | //button[contains(.,'Define your deployment process')]                                                             |
      | Add Step                       | //button[contains(.,'Add Step')]                                                                                   |
      | Search                         | //input[@name='Filter by name, category or description...']                                                        |
      | Deploy to Tomcat via Manager   | //div[contains(@class, 'add-step-card') and contains(.,'Deploy to Tomcat via Manager')]                            |
      | Add                            | //div[contains(@class, 'add-step-card') and contains(.,'Deploy to Tomcat via Manager')]//button[contains(.,'Add')] |

    And I highlight outside the "Define your deployment process" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}030-octopus-define-process.png"

    And I click the "Define your deployment process" button
    And I sleep for "1" second

    And I highlight outside the "Add Step" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}035-octopus-tomcat-add-step.png"
    And I click the "Add Step" button

    And I highlight outside the "Search" text box with an offset of "3"
    And I populate the "Search" text box with "Tomcat"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}040-octopus-tomcat-search.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Deploy to Tomcat via Manager" tile into view offset by "-200"
    And I highlight outside the "Deploy to Tomcat via Manager" tile
    And I mouse over the "Deploy to Tomcat via Manager" tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}045-octopus-tomcat.png"
    And I force click the "Add" button

  @define-project @destinationspecific @tomcat
  Scenario: K8S Define step
    Given I set the following aliases:
      | Configure features                           | (//button[contains(.,'Configure features')])[1]                                                 |
      | Structured Configuration Variables           | //input[..//label[text()='Structured Configuration Variables']]                                 |
      | Structured Configuration Variables Container | //div[./input[..//label[text()='Structured Configuration Variables']]]                          |
      | OK                                           | //button[contains(.,'Ok')]                                                                      |
      | Step Name                                    | //input[@name='Step name']                                                                      |
      | On target roles                              | //input[../../label[contains(text(), 'Runs on targets in roles (type to add new)')]]            |
      | Web role                                     | //div[contains(@class, 'VirtualListWithKeyboard_menuContainer')]//span[contains(.,'web')]//span |

    And I highlight outside the "Configure features" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}046-octopus-java-enable-conf-features.png"
    And I scroll the "Configure features" button into view offset by "-300"
    And I click the "Configure features" button
    And I remove the highlight from the "Configure features" button

    And I highlight inside the "Structured Configuration Variables Container" option
    And I highlight outside the "OK" button with an offset of "2"
    And I force click the "Structured Configuration Variables" option
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}047-octopus-java-enable-structured-vars.png"
    And I click the "OK" button

    And I scroll the "Step Name" text box into view offset by "-300"
    And I highlight outside the "Step Name" text box
    And I force clear the "Step Name" text box
    And I populate the "Step Name" text box with "Deploy to Tomcat"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}050-octopus-tomcat-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "On target roles" text box into view offset by "-300"
    And I click the "On target roles" text box
    And I populate the "On target roles" text box with "web"
    And I sleep for "1" second
    And I highlight outside the "On target roles" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}055-octopus-tomcat-step-role.png"
    And I click the "Web role" option
    And I remove the highlight from the "On target roles" text box

  @define-project @destinationspecific @tomcat @repositoryspecific @artifactory
  Scenario: Select artifactory feed for the tomcat deployment
    Given I set the following aliases:
      | Package feed | //div[./label[text()='Package feed']]/div/div |
      | Artifactory  | //div[./div/div[text()='Artifactory']]        |
      | HTML Body    | //body                                        |
      | Package ID   | //input[@name='PackageID']                    |

    And I scroll the "Package feed" drop down list into view offset by "-300"
    And I click the "Package feed" drop down list
    And I sleep for "1" second
    And I force click the "Artifactory" option
    And I highlight outside the "Package feed" drop down list
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}056-octopus-step-feed.png"
    And I remove the highlight from the "Package feed" text box

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "com.octopus:randomquotes"
    And I sleep for "2" second
    And I press the escape key from the "Package ID" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}060-octopus-step-package.png"
    And I remove the highlight from the "Package ID" text box

  @define-project @destinationspecific @tomcat @repositoryspecific @octo-built-in-feed
  Scenario: Select built in feed for the tomcat deployment
    Given I set the following aliases:
      | HTML Body  | //body                     |
      | Package ID | //input[@name='PackageID'] |

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "randomquotes"
    And I sleep for "2" second
    And I press the escape key from the "Package ID" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}060-octopus-step-package.png"
    And I remove the highlight from the "Package ID" text box

  @define-project @destinationspecific @tomcat
  Scenario: Java Define step
    Given I set the following aliases:
      | Tomcat Manager URL  | //input[@name='Tomcat Manager URL']  |
      | Management user     | //input[@name='Management user']     |
      | Management password | //input[@name='Management password'] |
      | Context path        | //input[@name='Context path']        |
      | Target files        | //textarea[@name='Target files']     |
      | Save                | //button[contains(.,'Save')]         |

    And I scroll the "Tomcat Manager URL" text box into view offset by "-300"
    And I highlight outside the "Tomcat Manager URL" text box
    And I force clear the "Tomcat Manager URL" text box
    And I populate the "Tomcat Manager URL" text box with "http://localhost:9091/manager"

    And I scroll the "Management user" text box into view offset by "-300"
    And I highlight outside the "Management user" text box
    And I clear the "Management user" text box
    And I populate the "Management user" text box with "tomcat"

    And I scroll the "Management password" text box into view offset by "-300"
    And I highlight outside the "Management password" text box
    And I clear the "Management password" text box
    And I populate the "Management password" text box with "Password01!"

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}070-octopus-tomcat-manager.png"

    And I remove the highlight from the "Management user" text box
    And I remove the highlight from the "Management password" text box

    And I scroll the "Context path" text box into view offset by "-300"
    And I highlight outside the "Context path" text box
    And I clear the "Context path" text box
    And I populate the "Context path" text box with "randomquotes-#{Octopus.Environment.Name | ToLower}"

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}080-octopus-tomcat-context.png"

    And I scroll the "Target files" text box into view offset by "-300"
    And I highlight outside the "Target files" text box
    And I populate the "Target files" text box with "**/application.yml"

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}090-octopus-tomcat-varinjection.png"

    And I click the "Save" button

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

  @deploy-project
  Scenario: Deploy project
    And I run the feature "shared/octopus-deploy-project.feature" passing the original arguments

  @shutdown
  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser
