Feature: Configure an Octopus Kubernetes project

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments
    And I run the feature "shared/octopus-hide-wizard.feature" passing the original arguments
    And I run the feature "shared/octopus-create-project.feature" passing the original arguments
    And I run the feature "shared/octopus-define-variables.feature" passing the original arguments

  @define-project @destinationspecific @nginx
  Scenario: Define node ports
    Given I set the following aliases:
      | Define scope            | //div[@title='Define scope']                    |
      | Select environments     | //input[@title='Select environments']           |
      | Dev environment         | //div[./div/div[text() = 'Dev']]                |
      | Test environment        | //div[./div/div[text() = 'Test']]               |
      | Prod environment        | //div[./div/div[text() = 'Prod']]               |
      | Add Another Value       | //button[.//span[text() = 'Add Another Value']] |
      | Project Variables Title | //h2[contains(.,'Project Variables')]           |
      | New variable name       | //input[contains(@id,'Enternewvariable')]       |
      | New variable value      | //input[contains(@id,'Entervalue')]             |
      | New variable value 2    | (//input[contains(@id,'Entervalue')])[2]        |
      | New variable value 3    | (//input[contains(@id,'Entervalue')])[3]        |
      | Save                    | //button[contains(.,'Save')]                    |

    And I populate the "New variable name" text box with "Nginx Port"
    And I populate the "New variable value" text box with "8081"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Dev environment" option
    And I force click the "Project Variables Title" element

    And I click the "Add Another Value" button
    And I populate the "New variable value 2" text box with "8082"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Test environment" option
    And I force click the "Project Variables Title" element

    And I click the "Add Another Value" button
    And I populate the "New variable value 3" text box with "8083"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Prod environment" option
    And I force click the "Project Variables Title" element

    And I populate the "New variable name" text box with "Nodejs Port"
    And I populate the "New variable value" text box with "5555"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Dev environment" option
    And I force click the "Project Variables Title" element

    And I click the "Add Another Value" button
    And I populate the "New variable value 2" text box with "5556"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Test environment" option
    And I force click the "Project Variables Title" element

    And I click the "Add Another Value" button
    And I populate the "New variable value 3" text box with "5557"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Prod environment" option
    And I force click the "Project Variables Title" element

    And I click the "Save" button
    And I scroll down "10000" px
    And I sleep for "7" second
    And I zoom the browser out
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}030-octopus-variables-populated.png"
    And I zoom the browser in

  @define-project
  Scenario: Open the deployments view
    Given I set the following aliases:
      | Overview    | //a[contains(.,'Overview')][not(*)] \| //a//div[text()='Overview'] |
      | Deployments | //a[contains(.,'Deployments')]                                     |

    And I highlight inside the "Deployments" link
    And I click the "Deployments" link
    And I highlight inside the "Overview" link
    And I click the "Overview" link
    And I remove the highlight from the "Deployments" link

  @define-project @destinationspecific @nginx
  Scenario: Add K8S Containers Step
    Given I set the following aliases:
      | Define your deployment process | //button[contains(.,'Define your deployment process')]                                                |
      | Add Step                       | //button[contains(.,'Add Step')]                                                                      |
      | Search                         | //input[contains(@id, 'Filterbynamecategoryordescription')]                                           |
      | Deploy Kubernetes containers   | //div[contains(@class, 'add-step-card') and contains(.,'Deploy to NGINX')]                            |
      | Add                            | //div[contains(@class, 'add-step-card') and contains(.,'Deploy to NGINX')]//button[contains(.,'Add')] |

    And I highlight outside the "Define your deployment process" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}040-octopus-define-process.png"

    And I click the "Define your deployment process" button
    And I sleep for "1" second

    And I highlight outside the "Add Step" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}050-octopus-k8s-add-step.png"
    And I click the "Add Step" button

    And I highlight outside the "Search" text box with an offset of "3"
    And I populate the "Search" text box with "Nginx"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}060-octopus-k8s-search.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Deploy Kubernetes containers" tile into view offset by "-200"
    And I highlight outside the "Deploy Kubernetes containers" tile
    And I mouse over the "Deploy Kubernetes containers" tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}070-octopus-k8s-add-containers.png"
    And I click the "Add" button

  @define-project @destinationspecific @iis
  Scenario: Define IIS project
    Given I set the following aliases:
      | Add                      | //div[contains(@class, 'add-step-card') and contains(.,'Deploy to IIS')]//button[contains(.,'Add')] |
      | Step Name                | //input[contains(@id, 'Stepname')]                                                                  |
      | Runs on targets in roles | //input[@title='Runs on targets in roles (type to add new)']                                        |
      | Web role                 | //div[contains(@class, 'VirtualListWithKeyboard_menuContainer')]//span[contains(.,'web')]//span     |

    And I scroll the "Step Name" text box into view offset by "-300"
    And I highlight outside the "Step Name" text box
    And I populate the "Step Name" text box with "Deploy web app to IIS"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}080-octopus-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "Runs on targets in roles" text box into view offset by "-300"
    And I click the "Runs on targets in roles" text box
    And I populate the "Runs on targets in roles" text box with "web"
    And I sleep for "1" second
    And I highlight outside the "Runs on targets in roles" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}090-octopus-step-role.png"
    And I click the "Web role" option
    And I remove the highlight from the "Runs on targets in roles" text box

  @define-project @destinationspecific @nginx @repositoryspecific @octo-built-in-feed
  Scenario: Select built in feed for the iis deployment
    Given I set the following aliases:
      | HTML Body  | //body                              |
      | Package ID | //input[contains(@id, 'PackageID')] |

    And I scroll the "Package ID" text box into view offset by "-300"
    And I highlight outside the "Package ID" text box
    And I populate the "Package ID" text box with "RandomQuotes"
    And I sleep for "2" second
    And I press the escape key from the "Package ID" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}100-octopus-step-package.png"
    And I remove the highlight from the "Package ID" text box

  @define-project @destinationspecific @iis
  Scenario: Nginx - Continue to define project
    Given I set the following aliases:
      | Remove binding | (//div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M19 6.41L17.59')]])[1]               |
      | Add binding    | //div[contains(@class, 'actionsMenu')][not(contains(@class, 'hidden'))]//button[contains(.,'Add binding')]  |
      | Add location   | //div[contains(@class, 'actionsMenu')][not(contains(@class, 'hidden'))]//button[contains(.,'Add location')] |
      | Port           | //input[contains(@id,'Port')]                                                                               |
      | Location       | //input[contains(@id,'Location')]                                                                           |
      | Proxy URL      | //input[contains(@id,'ProxyrequeststothisURL')]                                                             |
      | Reverse Proxy  | //input[..//label[text()='Reverse Proxy']]                                                                  |
      | OK             | //button[contains(.,'Ok')]                                                                                  |
      | Save           | //button[contains(.,'Save')]                                                                                |

    And I scroll the "Remove binding" button into view offset by "-300"
    And I highlight outside the "Remove binding" button
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}110-octopus-step-remove-binding.png"
    And I click the "Remove binding" button
    And I sleep for "1" second

    And I highlight outside the "Add binding" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}120-octopus-step-add-binding.png"
    And I force click the "Add binding" button
    And I remove the highlight from the "Add binding" button

    And I highlight outside the "Port" text box
    And I highlight outside the "OK" button with an offset of "2"
    And I clear the "Port" text box
    And I populate the "Port" text box with "#{Nginx Port}"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}130-octopus-step-binding-port.png"
    And I click the "OK" button

    And I highlight outside the "Add location" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}140-octopus-step-add-binding.png"
    And I force click the "Add location" button
    And I remove the highlight from the "Add location" button

    And I highlight outside the "Location" text box
    And I highlight outside the "Reverse Proxy" check box
    And I highlight outside the "OK" button with an offset of "2"
    And I populate the "Location" text box with "/"
    And I click the "Reverse Proxy" check box
    And I highlight outside the "Proxy URL" text box
    And I populate the "Proxy URL" text box with "http://localhost:#{Nodejs Port}"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}160-octopus-step-binding-port.png"
    And I click the "OK" button

    And I click the "Save" button
    And I sleep for "2" seconds

  @deploy-project
  Scenario: Deploy project
    And I run the feature "shared/octopus-deploy-project.feature" passing the original arguments

  @shutdown
  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser
