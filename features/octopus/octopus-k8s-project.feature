Feature: Configure an Octopus Kubernetes project

  @login
  Scenario: Login
    Given I set the following aliases:
      | Username   | //input[@name='userName']                                                                                 |
      | Password   | //input[@name='password']                                                                                 |
      | Sign In    | //button[contains(.,'SIGN IN')]                                                                           |
      | Close help | //div[*[local-name() = 'svg']/*[local-name()='path'][starts-with(@d, 'M11 18h2v-2h-2v2zm1-16C6.48 2 2')]] |
    And I open the shared browser "ExternalBrowserType"
    And I maximize the window
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
    And I click the "Hide wizard" button

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

  @define-variables
  Scenario: Open the variables section
    Given I set the following aliases:
      | Variables         | //a[contains(.,'Variables')]                                                                                                                                 |
      | Variables text    | //a[contains(.,'Variables')][not(*)] \| //a/span[text()='Variables']                                                                                         |
      | Project Variables | //a[@href='#/Spaces-1/projects/random-quotes/variables']/div/span[contains(.,'Project')] \| //a[@href='#/Spaces-1/projects/random-quotes/variables'][not(*)] |

    And I open the URL "http://localhost/app#/Spaces-1/projects/random-quotes/overview"
    And I sleep for "1" second

    And I highlight outside the "Variables text" link with an offset of "2"
    And I click the "Variables" link
    And I highlight inside the "Project Variables" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}020-octopus-variables.png"
    And I force click the "Project Variables" link
    And I remove the highlight from the "Variables text" link

  @define-variables @destinationspecific @k8s
  Scenario: Define project EnvironmentName Variable
  Define the contents of the appsettings JSON file
    Given I set the following aliases:
      | New variable name       | //input[contains(@id,'Enternewvariable')] |
      | New variable value      | //input[contains(@id,'Entervalue')]       |
      | Open Editor             | //span[text()='Open Editor']              |
      | Project Variables Title | //h2[contains(.,'Project Variables')]     |
      | Done                    | //button[contains(.,'Done')]              |
      | Add to list             | //button[@title='Add To List']            |

    And I populate the "New variable name" text box with "appsettings"
    And I click the "New variable value" text box
    And I click the "Open Editor" link
    And I sleep for "1" second
    And I run the following JavaScript:
    """
window.findReactComponent = function(el) {
  for (const key in el) {
    if (key.startsWith('__reactInternalInstance$')) {
      const fiberNode = el[key];

      return fiberNode && fiberNode.return && fiberNode.return.stateNode;
    }
  }
  return null;
};

elements = document.getElementsByClassName("ReactCodeMirror");
if (elements.length !== 0) {
  cm = findReactComponent(document.getElementsByClassName("ReactCodeMirror")[0]);
  cm.props.onChange("#{ExternalConfigFile}");
}
    """
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}023-octopus-variables-appsettings.png"
    And I sleep for "1" second
    And I click the "Done" button
    And I click the "Add to list" button
    And I force click the "Project Variables Title" element

  @define-project @destinationspecific @k8s
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

    And I populate the "New variable name" text box with "K8S Node Port"
    And I populate the "New variable value" text box with "30000"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Dev environment" option
    And I force click the "Project Variables Title" element

    And I click the "Add Another Value" button
    And I populate the "New variable value 2" text box with "30001"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Test environment" option
    And I force click the "Project Variables Title" element

    And I click the "Add Another Value" button
    And I populate the "New variable value 3" text box with "30002"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Prod environment" option
    And I force click the "Project Variables Title" element

    And I click the "Save" button
    And I scroll down "10000" px
    And I sleep for "7" second
    And I zoom the browser out
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}025-octopus-variables-populated.png"
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

  @define-project @destinationspecific @k8s
  Scenario: Add K8S Containers Step
    Given I set the following aliases:
      | Define your deployment process | //button[contains(.,'Define your deployment process')]                                                             |
      | Add Step                       | //button[contains(.,'Add Step')]                                                                                   |
      | Search                         | //input[contains(@id, 'Filterbynamecategoryordescription')]                                                        |
      | Deploy Kubernetes containers   | //div[contains(@class, 'add-step-card') and contains(.,'Deploy Kubernetes containers')]                            |
      | Add                            | //div[contains(@class, 'add-step-card') and contains(.,'Deploy Kubernetes containers')]//button[contains(.,'Add')] |

    And I highlight outside the "Define your deployment process" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}030-octopus-define-process.png"

    And I click the "Define your deployment process" button
    And I sleep for "1" second

    And I highlight outside the "Add Step" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}035-octopus-k8s-add-step.png"
    And I click the "Add Step" button

    And I highlight outside the "Search" text box with an offset of "3"
    And I populate the "Search" text box with "Kubernetes"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}040-octopus-k8s-search.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Deploy Kubernetes containers" tile into view offset by "-200"
    And I highlight outside the "Deploy Kubernetes containers" tile
    And I mouse over the "Deploy Kubernetes containers" tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}045-octopus-k8s-add-containers.png"
    And I click the "Add" button

  @define-project @destinationspecific @k8s
  Scenario: K8S Define step
    Given I set the following aliases:
      | Step Name                  | //input[contains(@id, 'Stepname')]                                                              |
      | On behalf of               | //input[@title='On behalf of target roles (type to add new)']                                   |
      | K8s role                   | //div[contains(@class, 'VirtualListWithKeyboard_menuContainer')]//span[contains(.,'k8s')]//span |
      | Deployment name            | //input[contains(@id,'Deploymentname')]                                                         |
      | Add Volume                 | (//button[@title='Add Volume'])[1]                                                              |
      | Linked ConfigMap           | //input[@value='LinkedResource']                                                                |
      | Linked ConfigMap Container | //div[./input[@value='LinkedResource']]                                                         |
      | Volume Name                | (//input[contains(@id,'Name')])[2]                                                              |
      | Add Container              | (//button[@title='Add Container'])[1]                                                           |
      | Image name                 | (//input[contains(@id,'Name')])[2]                                                              |
      | Package Id                 | //input[contains(@id,'PackageID')]                                                              |
      | Package Id label           | //label[contains(@for,'PackageID')]                                                             |
      | Add Port                   | (//button[@title='Add Port'])[3]                                                                |
      | Port name                  | (//input[contains(@id,'Name')])[3]                                                              |
      | Port number                | (//input[contains(@id,'Port')])[1]                                                              |
      | Add Volume Mount           | (//button[@title='Add Volume Mount'])[1]                                                        |
      | Container Volume name      | (//input[contains(@id,'Name')])[4]                                                              |
      | Mount path                 | (//input[contains(@id,'Mountpath')])[1]                                                         |
      | Sub path                   | (//input[contains(@id,'Subpath')])[1]                                                           |
      | appsettings volume         | //span[./div/div/div[text()='appsettings-volume']]                                              |
      | OK                         | (//button[@title='Ok'])[1]                                                                      |
      | Save                       | //button[@title='Save']                                                                         |
      | Service name               | //input[contains(@id,'Servicename')]                                                            |
      | Add Service Port           | (//button[@title='Add Port'])[1]                                                                |
      | Service Port Name          | (//input[contains(@id,'Name')])[2]                                                              |
      | Port 80                    | //span[./div/div/div[text()='80']]                                                              |
      | Service Port               | (//input[contains(@id,'Port')])[1]                                                              |
      | Node Port                  | //input[contains(@id,'NodePort')]                                                               |
      | ConfigMap name             | //input[contains(@id,'ConfigMapname')]                                                          |
      | Add Config Map Item        | (//button[contains(.,'Add Config map item')])[1]                                                |
      | Key                        | //input[../label[text()='Key']]                                                                 |
      | Value                      | //textarea[contains(@id,'Value')]                                                               |
      | Value container            | //div[./textarea[contains(@id,'Value')]]                                                        |

    And I scroll the "Step Name" text box into view offset by "-300"
    And I highlight outside the "Step Name" text box
    And I populate the "Step Name" text box with "Deploy container to Kubernetes"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}050-octopus-k8s-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "On behalf of" text box into view offset by "-300"
    And I click the "On behalf of" text box
    And I populate the "On behalf of" text box with "k8s"
    And I sleep for "1" second
    And I highlight outside the "On behalf of" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}055-octopus-k8s-step-role.png"
    And I click the "K8s role" option
    And I remove the highlight from the "On behalf of" text box

    And I scroll the "Deployment name" text box into view offset by "-300"
    And I highlight outside the "Deployment name" text box
    And I populate the "Deployment name" text box with "randomquotes"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}060-octopus-k8s.png"

    And I highlight outside the "Add Volume" button
    And I scroll the "Add Volume" button into view offset by "-300"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}061-octopus-k8s.png"
    And I click the "Add Volume" button

    And I highlight outside the "Volume Name" text box with an offset of "2"
    And I highlight outside the "Linked ConfigMap Container" option with an offset of "2"
    And I highlight outside the "OK" button with an offset of "2"
    And I populate the "Volume Name" text box with "appsettings-volume"
    And I force click the "Linked ConfigMap" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}062-octopus-k8s.png"
    And I click the "OK" button

    And I highlight outside the "Add Container" button
    And I scroll the "Add Container" button into view offset by "-300"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}070-octopus-k8s.png"
    And I click the "Add Container" button

    And I highlight outside the "Image name" text box
    And I scroll the "Image name" text box into view offset by "-300"
    And I populate the "Image name" text box with "randomquotes"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}080-octopus-k8s.png"
    And I remove the highlight from the "Image name" text box

    And I highlight outside the "Add Port" button with an offset of "2"
    And I scroll the "Add Port" button into view offset by "-300"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}090-octopus-k8s.png"
    And I force click the "Add Port" button
    And I remove the highlight from the "Add Port" button

    And I highlight outside the "Port name" text box with an offset of "2"
    And I highlight outside the "Port number" text box with an offset of "2"

    And I scroll the "Port name" text box into view offset by "-300"
    And I populate the "Port name" text box with "web"

    And I scroll the "Port number" text box into view offset by "-300"
    And I populate the "Port number" text box with "80"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}091-octopus-k8s.png"

    And I scroll the "Add Volume Mount" button into view offset by "-200"
    And I highlight outside the "Add Volume Mount" button with an offset of "2"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}092-octopus-k8s.png"
    And I click the "Add Volume Mount" button
    And I remove the highlight from the "Add Volume Mount" button

    And I highlight outside the "Container Volume name" text box with an offset of "2"
    And I highlight outside the "Mount path" text box with an offset of "2"
    And I highlight outside the "Sub path" text box with an offset of "2"
    And I populate the "Container Volume name" text box with "appsettings-volume"
    And I click the "appsettings volume" option
    And I populate the "Mount path" text box with "ExternalConfigMountPath"
    And I populate the "Sub path" text box with "appsettings.json"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}093-octopus-k8s.png"

    And I highlight outside the "OK" button with an offset of "2"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}100-octopus-k8s.png"
    And I remove the highlight from the "OK" button

    And I highlight outside the "Package Id" text box
    And I scroll the "Package Id" text box into view offset by "-300"
    And I populate the "Package Id" text box with a keystroke delay of "0" with "ExternalDockerImage"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}110-octopus-k8s.png"
    And I sleep for "1" second

    And I force click the "OK" button

    And I highlight outside the "Service name" text box
    And I scroll the "Service name" text box into view offset by "-300"
    And I populate the "Service name" text box with "randomquotes"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}120-octopus-k8s.png"

    And I highlight outside the "Add Service Port" button
    And I scroll the "Add Service Port" button into view offset by "-300"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}130-octopus-k8s.png"
    And I click the "Add Service Port" button

    And I highlight outside the "OK" button with an offset of "2"
    And I highlight outside the "Service Port Name" text box with an offset of "2"
    And I highlight outside the "Service Port" text box with an offset of "2"
    And I highlight outside the "Node Port" text box with an offset of "2"
    And I highlight outside the "OK" button with an offset of "2"
    And I populate the "Service Port Name" text box with "web"
    And I populate the "Service Port" text box with "80"
    And I click the "Port 80" option
    And I populate the "Node Port" text box with "#{K8S Node Port}"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}140-octopus-k8s.png"
    And I click the "OK" button
    And I remove the highlight from the "Add Service Port" button

    And I scroll the "ConfigMap name" text box into view offset by "-300"
    And I highlight outside the "ConfigMap name" text box with an offset of "2"
    And I populate the "ConfigMap name" text box with "randomquotes"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}141-octopus-k8s.png"

    And I highlight outside the "Add Config Map Item" button
    And I click the "Add Config Map Item" button
    And I highlight outside the "Key" text box with an offset of "2"
    And I highlight outside the "Value container" element with an offset of "2"
    And I populate the "Key" text box with "appsettings.json"
    And I populate the "Value" text box with "#{appsettings}"

    And I highlight outside the "Save" button
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}160-octopus-k8s.png"
    And I force click the "Save" button
    And I sleep for "10" seconds

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
    And I start recording the screen to the directory "ExternalMediaPath"
    And I sleep for "23" seconds

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}210-octopus-deployment.png"

  @shutdown
  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser
