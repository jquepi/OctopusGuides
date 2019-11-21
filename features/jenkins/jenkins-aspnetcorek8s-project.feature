Feature: Build and deploy a ASP.NET Core application hosted in Git on a local Octopus instance

  @login
  Scenario: Log into Jenkins
    Given I set the following aliases:
      | Username     | #j_username                                                  |
      | Password     | body > div > div > form > div:nth-child(2) > input           |
      | Sign In      | body > div > div > form > div.submit.formRow > input         |
      | Profile Name | #header > div.login > span > a.model-link.inside.inverse > b |
    And I open the shared browser "ExternalBrowserType"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    #And I set the window size to "1024" x "768"
    When I open the URL "http://localhost:8080"
    # It can take some time for Jenkins to start up, so we need to be able to wait here for the login box
    And I verify the "Username" text box is present waiting up to "900" seconds if it exists
    And I refresh the page
    And I populate the "Username" text box with the text "jenkinsadmin"
    And I populate the "Password" text box with the text "Password01!"
    And I click the "Sign In" button
    Then I verify the text from the "Profile Name" element matches the regex "jenkinsadmin" waiting up to "120" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

  @plugin-install @destinationspecific @k8s
  Scenario: Install plugins
    Given I set the following aliases:
      | Manage Jenkins          | //a[@class='task-link' and contains(.,'Manage Jenkins')] |
      | Manage Plugins          | //a[@href='pluginManager']                               |
      | Available               | //a[contains(@href,'available')]                         |
      | Filter                  | #filter-box                                              |
      | Docker Plugin           | //input[@name='plugin.docker-build-step.default']        |
      | Docker Plugin Container | //td[./input[@name='plugin.docker-build-step.default']]  |
      | Install without restart | //button[text()='Install without restart']               |
      | Back to top             | //a[contains(.,'Go back to the top page')]               |

    And I display a note with the text "Installing the Jenkins plugins" for "3" seconds

    And I highlight inside the "Manage Jenkins" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}005-manage-jenkins.png"
    And I click the "Manage Jenkins" link
    And I scroll the "Manage Plugins" link into view offset by "-100"
    # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Manage Plugins" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}010-manage-plugins.png"
    And I click the "Manage Plugins" link
    And I click the "Available" tab
    And I populate the "Filter" text box with the text "Docker"
    And I click the "Docker Plugin" checkbox
    And I highlight inside the "Available" tab
    And I highlight outside the "Filter" tab
    And I highlight inside the "Docker Plugin Container" element
    And I highlight outside the "Install without restart" button
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}015-msbuild-plugin.png"
    And I click the "Install without restart" button
    And I wait for "5" seconds

    And I stop recording the screen
    And I sleep for "60" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Back to top" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}020-plugin-install.png"
    # fake a click
    And I open the URL "http://localhost:8080/"

  @configure-credentials
  Scenario: Configure credentials
    Given I set the following aliases:
      | Manage Jenkins          | //a[@class='task-link' and contains(.,'Manage Jenkins')]               |
      | Configure Credentials   | //a[@href='configureCredentials']                                      |
      | Credentials             | //a[@href='/credentials'][contains(.,'Credentials')]                   |
      | System                  | //a[@href='/credentials/store/system'][contains(.,'System')]           |
      | Global credentials      | //a[@href='domain/_'][contains(.,'Global credentials (unrestricted)')] |
      | Global credentials cell | .sortable > tbody:nth-child(1) > tr:nth-child(2) > td:nth-child(2)     |
      | Add Credentials         | //a[@href='newCredentials'][contains(.,'Add Credentials')]             |
      | Username                | //input[@name='_.username']                                            |
      | Password                | //input[@name='_.password']                                            |
      | ID                      | //input[@name='_.id']                                                  |
      | Description             | //input[@name='_.description']                                         |
      | Kind                    | //select[@class='setting-input dropdownList']                          |
      | Secret                  | //input[@name='_.secret']                                              |
      | OK                      | //button[@type='button'][contains(.,'OK')]                             |
      | ID Two                  | (//input[@name='_.id'])[2]                                             |
      | Description Two         | (//input[contains(@name,'_.description')])[2]                          |

    And I open the URL "http://localhost:8080/"
    And I clear the transition

    And I display a note with the text "Adding the Octopus API key as a Jenkins secret" for "3" seconds

    And I highlight inside the "Manage Jenkins" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}023-manage-jenkins.png"
    And I click the "Manage Jenkins" link

    And I scroll the "Configure Credentials" link into view offset by "-100"
    # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Configure Credentials" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}040-configure-credentials.png"
    And I click the "Configure Credentials" link

    And I highlight inside the "Credentials" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}045-credentials-parent.png"
    And I click the "Credentials" link

    And I highlight inside the "System" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}050-credentials-system.png"
    And I click the "System" link

    And I highlight outside the "Global credentials cell" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}055-global-credentials.png"
    And I click the "Global credentials" link

    And I highlight inside the "Add Credentials" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}060-add-credentials.png"
    And I click the "Add Credentials" link

    And I highlight outside the "Username" text box with an offset of "0"
    And I highlight outside the "Password" text box with an offset of "0"
    And I highlight outside the "ID" text box with an offset of "0"
    And I highlight outside the "Description" text box with an offset of "0"
    And I highlight outside the "OK" button

    And I populate the "Username" text box with "ExternalDockerUsername"
    And I populate the "Password" text box with "ExternalDockerPassword"
    And I populate the "ID" text box with "DockerCredentials"
    And I populate the "Description" text box with "The Dockerhub Credentials"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}065-octopus-credentials.png"
    And I click the "OK" button

    And I highlight inside the "Add Credentials" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}070-add-credentials.png"
    And I click the "Add Credentials" link

    And I highlight outside the "Kind" drop down list
    And I select the option "Secret text" from the "Kind" drop down list

    And I highlight outside the "Secret" text box with an offset of "0"
    And I highlight outside the "ID Two" text box with an offset of "0"
    And I highlight outside the "Description Two" text box with an offset of "0"
    And I highlight outside the "OK" button

    And I populate the "Secret" text box with "ExternalOctopusAPIKey"
    And I populate the "ID Two" text box with "OctopusAPIKey"
    And I populate the "Description Two" text box with "The Octopus API Key"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}071-octopus-credentials.png"
    And I click the "OK" button

    Then I fade the screen to "1" "1" "1" over "3000" milliseconds

  @configure-credentials
  Scenario: Configure Docker
    Given I set the following aliases:
      | Manage Jenkins   | //a[@class='task-link' and contains(.,'Manage Jenkins')] |
      | Configure System | //a[@href='configure']                                   |
      | Docker URL       | //input[@name='_.dockerUrl']                             |
      | Save             | //button[text()='Save']                                  |

    And I open the URL "http://localhost:8080/"
    And I clear the transition

    And I display a note with the text "Configure Docker" for "3" seconds

    And I highlight inside the "Manage Jenkins" text box
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}080-manage-jenkins.png"
    And I click the "Manage Jenkins" link

    And I scroll the "Configure System" link into view offset by "-100"
    # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Configure System" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}090-configure-system.png"
    And I click the "Configure System" link

    And I scroll the "Docker URL" text box into view offset by "-300"
    And I highlight outside the "Docker URL" text box
    And I highlight outside the "Save" button
    And I populate the "Docker URL" text box with "unix:///var/run/docker.sock"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}100-dockerurl.png"
    And I click the "Save" button

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
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}075-new-item.png"
    And I click the "New Item" link

    And I highlight outside the "Freestyle project" link
    And I highlight outside the "Project name" link
    And I highlight outside the "OK" button
    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}080-freestyle-project.png"
    And I click the "Freestyle project" link
    And I scroll the "OK" button into view
    And I click the "OK" button

    And I scroll the "Git" option into view offset by "-200"
    And I highlight outside the "Git" option
    And I click the "Git" option
    And I highlight outside the "Repository URL" text box
    And I populate the "Repository URL" text box with "GitUrl"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}085-git-settings.png"

    And I scroll the "Poll SCM" option into view offset by "-200"
    And I click the "Poll SCM" option
    And I populate the "Schedule" textarea with "H/5 * * * *"
    And I highlight outside the "Poll SCM" option
    And I highlight outside the "Schedule" textarea
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}090-git-polling.png"
    And I remove the highlight from the "Poll SCM" option
    And I remove the highlight from the "Schedule" textarea

    And I scroll the "Use secrets" option into view offset by "-200"
    And I highlight outside the "Use secrets" option
    And I click the "Use secrets" option

    And I highlight outside the "Bindings Add" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}095-binding-add.png"
    And I click the "Bindings Add" option
    And I highlight outside the "Secret text" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}100-secret-text.png"
    And I remove the highlight from the "Bindings Add" option
    And I remove the highlight from the "Use secrets" option
    And I click the "Secret text" link

    And I highlight outside the "Variable" text box
    And I highlight outside the "Credentials" drop down list
    And I populate the "Variable" text box with "OctopusAPIKey"
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}105-credentials-octopusapikey.png"
    And I remove the highlight from the "Variable" text box
    And I remove the highlight from the "Credentials" drop down list

  @configure-project
  Scenario: ASP.NET Core - Create the project
    Given I set the following aliases:
      | Add build step                               | //button[@type='button'][contains(.,'Add build step')] |
      | Execute Windows batch command                | //a[contains(.,'Execute Windows batch command')]       |
      | Execute Docker command                       | //a[contains(.,'Execute Docker command')]              |
      | Docker command one                           | (//select[../../td[text()='Docker command']])[1]       |
      | Docker command two                           | (//select[../../td[text()='Docker command']])[2]       |
      | Create/build image                           | 4                                                      |
      | Build context folder                         | //input[@name='_.dockerFolder']                        |
      | Tag of the resulting docker image            | //input[@name='_.imageTag']                            |
      | Push image                                   | 7                                                      |
      | Name of the image to push (repository/image) | //input[@name='_.image']                               |
      | Tag                                          | (//input[@name='_.tag'])[3]                            |
      | Registry                                     | //input[@name='_.registry']                            |
      | Docker registry URL                          | (//input[@name='_.url'])[2]                            |
      | Registry credentials                         | (//select[@name='_.credentialsId'])[3]                 |
      | Save                                         | //button[@type='button'][contains(.,'Save')]           |

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Execute Docker command" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}110-execute-docker-command-1.png"
    And I click the "Execute Docker command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Docker command" option

    And I scroll the "Docker command one" drop down list into view offset by "-300"
    And I highlight outside the "Docker command one" drop down list
    And I select the option value "Create/build image" from the "Docker command one" drop down list

    And I scroll the "Build context folder" text box into view offset by "-300"
    And I highlight outside the "Build context folder" text box
    And I clear the "Build context folder" text box
    And I populate the "Build context folder" text box with "$WORKSPACE/RandomQuotes"

    And I scroll the "Tag of the resulting docker image" text box into view offset by "-300"
    And I highlight outside the "Tag of the resulting docker image" text box
    And I clear the "Tag of the resulting docker image" text box
    And I populate the "Tag of the resulting docker image" text box with "octopusdeploy/randomquotes:1.0.$BUILD_NUMBER"

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}120-execute-docker-command-1.png"

    And I scroll the "Add build step" button into view offset by "-200"
    And I highlight outside the "Add build step" button
    And I click the "Add build step" button
    And I highlight outside the "Execute Docker command" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}130-execute-docker-command-1.png"
    And I click the "Execute Docker command" link
    And I remove the highlight from the "Add build step" option
    And I remove the highlight from the "Execute Docker command" option

    And I scroll the "Docker command two" drop down list into view offset by "-300"
    And I highlight outside the "Docker command two" drop down list
    And I select the option value "Push image" from the "Docker command two" drop down list

    And I scroll the "Name of the image to push (repository/image)" text box into view offset by "-300"
    And I highlight outside the "Name of the image to push (repository/image)" text box
    And I populate the "Name of the image to push (repository/image)" text box with "randomquotes"

    And I scroll the "Tag" text box into view offset by "-300"
    And I highlight outside the "Tag" text box
    And I populate the "Tag" text box with "1.0.$BUILD_NUMBER"

    And I scroll the "Registry" text box into view offset by "-300"
    And I highlight outside the "Registry" text box
    And I populate the "Registry" text box with "octopusdeploy"

    And I scroll the "Docker registry URL" text box into view offset by "-300"
    And I highlight outside the "Docker registry URL" text box
    And I populate the "Docker registry URL" text box with "https://index.docker.io/v1/"

    And I scroll the "Registry credentials" drop down list into view offset by "-300"
    And I highlight outside the "Registry credentials" drop down list
    And I select the option value "DockerCredentials" from the "Registry credentials" drop down list

    And I click the "Save" button
    And I stop recording the screen

  @build-now
  Scenario: Run build
    Given I set the following aliases:
      | Build Now      | //a[contains(.,'Build Now')]      |
      | Build One      | //a[contains(.,'#1')]             |
      | Console Output | //a[contains(.,'Console Output')] |

    And I open the URL "http://localhost:8080/job/Random%20Quotes/"
    And I clear the transition
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight inside the "Build Now" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}140-build-now.png"
    And I click the "Build Now" link

    And I highlight inside the "Build One" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}145-build-one.png"
    # Fake a click here to fix stale element errors in WebDriver
    And I mouse over the "Build One" link
    And I open the URL "http://localhost:8080/job/Random%20Quotes/1/"

    And I highlight inside the "Console Output" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/initialproject/#{GuideSpecificScreenshotDir}150-console.png"
    And I click the "Console Output" link
    And I scroll down "10000" px
    And I sleep for "10" seconds

    And I stop recording the screen
    And I sleep for "120" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I scroll down "10000" px
    And I sleep for "5" seconds

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser