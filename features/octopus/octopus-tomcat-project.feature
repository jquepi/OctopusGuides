Feature: Configure an Octopus Tomcat project

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username   | //input[@name='userName']                                                                                 |
      | Password   | //input[@name='password']                                                                                 |
      | Sign In    | //button[contains(.,'SIGN IN')]                                                                           |
      | Close help | //div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M11 18h2v-2h-2v2zm1-16C6.48 2 2')]] |
    And I open the shared browser "ExternalBrowserType"
    And I fullscreen the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Sign In" button
    And I click the "Close help" button

  @hide-wizard
  Scenario: Hide wizard
    Given I set the following aliases:
      | Hide wizard | //em[contains(@class,'fa fa-minus')] |
    And I click the "Hide wizard" button if it exists

  @create-project
  Scenario: Create Project
    Given I set the following aliases:
      | Projects         | //span[contains(.,'Projects')]           |
      | Add project      | (//div[contains(.,'Add Project')])[11]   |
      | New project name | //input[contains(@id, 'Newprojectname')] |
      | Save             | (//div[contains(.,'Save')])[9]           |

    And I start recording the screen to the directory "ExternalMediaPath"
    And I display a note with the text "Creating the Kubernetes deployment project in Octopus" for "3" seconds

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
    And I sleep for "2" seconds

  @define-project @destinationspecific @tomcat
  Scenario: Add K8S Containers Step
    Given I set the following aliases:
      | Define your deployment process | //button[contains(.,'Define your deployment process')]                                                             |
      | Add Step                       | //button[contains(.,'Add Step')]                                                                                   |
      | Search                         | //input[contains(@id, 'Filterbynamecategoryordescription')]                                                        |
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
    And I click the "Add" button

  @define-project @destinationspecific @tomcat
  Scenario: K8S Define step
    Given I set the following aliases:
      | Step Name       | //input[contains(@id, 'Stepname')]                                                              |
      | On target roles | //input[@title='Runs on targets in roles (type to add new)']                                    |
      | Web role        | //div[contains(@class, 'VirtualListWithKeyboard_menuContainer')]//span[contains(.,'web')]//span |


    And I scroll the "Step Name" text box into view offset by "-300"
    And I highlight outside the "Step Name" text box
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
      | Package feed | (//div[./div[text()='Package feed']]/div)[2]/div |
      | Artifactory  | //div[./div/div[text()='Artifactory']]           |
      | HTML Body    | //body                                           |
      | Package ID   | //input[contains(@id, 'PackageID')]              |

    And I scroll the "Package feed" drop down list into view offset by "-300"
    And I click the "Package feed" drop down list
    And I sleep for "1" second
    And I force click the "Artifactory" option
    And I highlight outside the "Package feed" drop down list
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}056-octopus-step-feed.png"
    And I remove the highlight from the "Package feed" text box

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "randomquotes"
    And I sleep for "2" second
    And I press the escape key from the "Package ID" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}060-octopus-step-package-artifactory.png"
    And I remove the highlight from the "Package ID" text box

  @define-project @destinationspecific @tomcat @repositoryspecific @octo-built-in-feed
  Scenario: Select built in feed for the tomcat deployment
    Given I set the following aliases:
      | HTML Body  | //body                              |
      | Package ID | //input[contains(@id, 'PackageID')] |

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "randomquotes"
    And I sleep for "2" second
    And I press the escape key from the "Package ID" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}060-octopus-step-package.png"
    And I remove the highlight from the "Package ID" text box

  @define-project @destinationspecific @tomcat
  Scenario: K8S Define step
    Given I set the following aliases:
      | Tomcat Manager URL  | //input[contains(@id, 'TomcatManagerURL')]   |
      | Management user     | //input[contains(@id, 'Managementuser')]     |
      | Management password | //input[contains(@id, 'Managementpassword')] |
      | Context path        | //input[contains(@id, 'Contextpath')]        |
      | Save                | //button[contains(.,'Save')]                 |

    And I scroll the "Tomcat Manager URL" text box into view offset by "-300"
    And I highlight outside the "Tomcat Manager URL" text box
    And I clear the "Tomcat Manager URL" text box
    And I populate the "Tomcat Manager URL" text box with "http://localhost:9091/manager"

    And I scroll the "Management user" text box into view offset by "-300"
    And I highlight outside the "Management user" text box
    And I clear the "Management user" text box
    And I populate the "Management user" text box with "tomcat"

    And I scroll the "Management password" text box into view offset by "-300"
    And I highlight outside the "Management password" text box
    And I clear the "Management password" text box
    And I populate the "Management password" text box with "Password01!"

    And I scroll the "Context path" text box into view offset by "-300"
    And I highlight outside the "Context path" text box
    And I clear the "Context path" text box
    And I populate the "Context path" text box with "randomquotes-#{Octopus.Environment.Name | ToLower}"

    And I click the "Save" button
    And I sleep for "2" seconds

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
