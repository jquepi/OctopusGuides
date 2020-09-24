Feature: Configure an Octopus Kubernetes project

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments
    And I run the feature "shared/octopus-hide-wizard.feature" passing the original arguments

  Scenario: Display banner
    And I start recording the screen to the directory "ExternalMediaPath"
    And I display a note with the text "Creating the Kubernetes deployment project in Octopus" for "3" seconds

  Scenario:
    And I run the feature "shared/octopus-create-project.feature" passing the original arguments
    And I run the feature "shared/octopus-define-variables.feature" passing the original arguments

  @define-variables @destinationspecific @k8s @microk8s @applicationspecific @java @nodejs @aspnetcore
  Scenario: Define project config file variable. This is only valid for some docker images.
  Define the contents of the appsettings JSON file
    Given I set the following aliases:
      | New variable name       | //input[@name='Enter new variable']   |
      | New variable value      | //input[@name='Enter value']          |
      | Open Editor             | //span[text()='Open Editor']          |
      | Project Variables Title | //h2[contains(.,'Project Variables')] |
      | Done                    | //button[contains(.,'Done')]          |
      | Add to list             | //button[@title='Add To List']        |

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

  @define-project @destinationspecific @k8s @microk8s
  Scenario: Define node ports
    Given I set the following aliases:
      | Define scope            | //div[@title='Define scope']                       |
      | Select environments     | //input[../../label[text()='Select environments']] |
      | Dev environment         | //div[./div/div[text() = 'Dev']]                   |
      | Test environment        | //div[./div/div[text() = 'Test']]                  |
      | Prod environment        | //div[./div/div[text() = 'Prod']]                  |
      | Add Another Value       | //button[.//span[text() = 'Add Another Value']]    |
      | Project Variables Title | //h2[contains(.,'Project Variables')]              |
      | New variable name       | //input[@name='Enter new variable']                |
      | New variable value      | //input[@name='Enter value']                       |
      | New variable value 2    | (//input[@name='Enter value'])[2]                  |
      | New variable value 3    | (//input[@name='Enter value'])[3]                  |
      | Save                    | //button[contains(.,'Save')]                       |

    And I populate the "New variable name" text box with "K8S Node Port"
    And I populate the "New variable value" text box with "#{K8SDevNodePort:-30000}"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Dev environment" option
    And I force click the "Project Variables Title" element

    And I click the "Add Another Value" button
    And I populate the "New variable value 2" text box with "#{K8STestNodePort:-30001}"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Test environment" option
    And I force click the "Project Variables Title" element

    And I click the "Add Another Value" button
    And I populate the "New variable value 3" text box with "#{K8SProdNodePort:-30002}"
    And I force click the "Define scope" field
    And I force click the "Select environments" field
    And I force click the "Prod environment" option
    And I force click the "Project Variables Title" element

    And I click the "Save" button
    And I scroll down "10000" px

    And I sleep for "1" second
    And I stop recording the screen
    And I sleep for "10" seconds

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}025-octopus-variables-populated.png"

  @define-project
  Scenario: Open the deployments view
    Given I set the following aliases:
      | Overview    | //a[contains(.,'Overview')][not(*)] \| //a//div[text()='Overview'] |
      | Deployments | //a[contains(.,'Deployments')]                                     |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I highlight inside the "Deployments" link
    And I click the "Deployments" link
    And I highlight inside the "Overview" link
    And I click the "Overview" link
    And I remove the highlight from the "Deployments" link

  @define-project @destinationspecific @k8s @microk8s
  Scenario: Add K8S Containers Step
    Given I set the following aliases:
      | Define your deployment process | //button[contains(.,'Define your deployment process')]                                                             |
      | Add Step                       | //button[contains(.,'Add Step')]                                                                                   |
      | Search                         | //input[@name='Filter by name, category or description...']                                                        |
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
    And I force click the "Add" button

  @define-project @destinationspecific @k8s @microk8s
  Scenario: K8S Define step
    Given I set the following aliases:
      | Step Name       | //input[@name='Step name']                                                                      |
      | On behalf of    | //input[../../label[text()='On behalf of target roles (type to add new)']]                                   |
      | K8s role        | //div[contains(@class, 'VirtualListWithKeyboard_menuContainer')]//span[contains(.,'k8s')]//span |
      | Deployment name | //input[@name='Deployment name']                                                                |

    And I scroll the "Step Name" text box into view offset by "-300"
    And I highlight outside the "Step Name" text box
    And I force clear the "Step Name" text box
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

  @define-project @destinationspecific @k8s @microk8s @applicationspecific @java @nodejs @aspnetcore
  Scenario: Add the config map volume. This is only valid for some docker images.
    Given I set the following aliases:
      | Add Volume                 | (//button[@title='Add Volume'])[1]      |
      | Linked ConfigMap           | //input[@value='LinkedResource']        |
      | Linked ConfigMap Container | //div[./input[@value='LinkedResource']] |
      | Volume Name                | (//input[@name='Name'])[3]              |
      | OK                         | (//button[@title='Ok'])[1]              |

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

  @define-project @destinationspecific @k8s @microk8s
  Scenario: Add the container and ports.
    Given I set the following aliases:
      | Add Container | (//button[@title='Add Container'])[1] |
      | Image name    | (//input[@name='Name'])[3]            |
      | Add Port      | (//button[@title='Add Port'])[3]      |
      | Port name     | (//input[@name='Name'])[4]            |
      | Port number   | (//input[@name='Port'])[1]            |

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
    And I populate the "Port number" text box with "#{DockerPort:-80}"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}091-octopus-k8s.png"

    And I remove the highlight from the "Port name" text box
    And I remove the highlight from the "Port number" text box

  @define-project @destinationspecific @k8s @microk8s @applicationspecific @php @ruby
  Scenario: Define environment variable. This is only valid for some docker images.
    Given I set the following aliases:
      | Environment Variables    | //div[./div/span[text()='Environment Variables']]                                                             |
      | Add Environment Variable | //button[@title='Add Environment Variable']                                                                   |
      | Name                     | //input[@name='Name'][../../../../../../../../../../../../../../../div/span[text()='Environment Variables']]  |
      | Value                    | //input[@name='Value'][../../../../../../../../../../../../../../../div/span[text()='Environment Variables']] |

    And I click the "Environment Variables" section

    And I highlight outside the "Add Environment Variable" button with an offset of "2"
    And I scroll the "Add Environment Variable" button into view offset by "-300"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}093-octopus-k8s.png"
    And I click the "Add Environment Variable" button
    And I remove the highlight from the "Add Environment Variable" button

    And I highlight outside the "Name" text box with an offset of "2"
    And I highlight outside the "Value" text box with an offset of "2"

    And I scroll the "Name" text box into view offset by "-300"
    And I populate the "Name" text box with "ENVIRONMENT_NAME"
    And I populate the "Value" text box with "#{Octopus.Environment.Name}"

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}094-octopus-k8s.png"

    And I remove the highlight from the "Name" text box
    And I remove the highlight from the "Value" text box

  @define-project @destinationspecific @k8s @microk8s @applicationspecific @java @nodejs @aspnetcore
  Scenario: Add the config map volume mounting. This is only valid for some docker images.
    Given I set the following aliases:
      | Add Volume Mount      | (//button[@title='Add Volume Mount'])[1]           |
      | Container Volume name | (//input[@name='Name'])[5]                         |
      | Mount path            | (//input[@name='Mount path'])[1]                   |
      | Sub path              | (//input[@name='Sub path'])[1]                     |
      | appsettings volume    | //span[./div/div/div[text()='appsettings-volume']] |

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
    And I populate the "Sub path" text box with "ExternalConfigFileName"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}093-octopus-k8s.png"

  @define-project @destinationspecific @k8s @microk8s
  Scenario: Add the package and service
    Given I set the following aliases:
      | Package Id        | //input[@name='PackageID']                        |
      | Package Id label  | //label[contains(@for,'PackageID')]               |
      | OK                | (//button[@title='Ok'])[1]                        |
      | Save              | //button[@title='Save']                           |
      | Service name      | //input[@name='Service name']                     |
      | Node port option  | //input[@value='NodePort']                        |
      | Node port parent  | //div[./input[@value='NodePort']]                 |
      | Add Service Port  | (//button[@title='Add Port'])[1]                  |
      | Service Port Name | (//input[@name='Name'])[3]                        |
      | Port Suggestion   | //span[./div/div/div[text()='#{DockerPort:-80}']] |
      | Service Port      | (//input[@name='Port'])[1]                        |
      | Node Port         | //input[@name='NodePort']                         |

    And I highlight outside the "OK" button with an offset of "2"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}100-octopus-k8s.png"
    And I remove the highlight from the "OK" button

    And I highlight outside the "Package Id" text box
    And I scroll the "Package Id" text box into view offset by "-300"
    And I populate the "Package Id" text box with a keystroke delay of "0" with "#{ExternalOctopusDockerImage}"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}110-octopus-k8s.png"
    And I sleep for "1" second

    # Give the package suggestion box some time to drop down
    And I stop recording the screen
    And I sleep for "60" seconds
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I force click the "OK" button

    And I highlight outside the "Service name" text box
    And I scroll the "Service name" text box into view offset by "-300"
    And I populate the "Service name" text box with "randomquotes"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}120-octopus-k8s.png"

    And I highlight outside the "Node port parent" element
    And I scroll the "Node port option" element into view offset by "-300"
    And I force click the "Node port option" element
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}125-octopus-k8s.png"

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
    And I populate the "Service Port" text box with "#{DockerPort:-80}"
    And I click the "Port Suggestion" option
    And I populate the "Node Port" text box with "#{K8S Node Port}"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}140-octopus-k8s.png"
    And I click the "OK" button
    And I remove the highlight from the "Add Service Port" button

  @define-project @destinationspecific @k8s @microk8s @applicationspecific @java @nodejs @aspnetcore
  Scenario: Add the config map that holds the configuration file. This is only valid for some docker images.
    Given I set the following aliases:
      | ConfigMap name      | //input[@name='ConfigMap name']                  |
      | Add Config Map Item | (//button[contains(.,'Add Config map item')])[1] |
      | Key                 | //input[../label[text()='Key']]                  |
      | Value               | //textarea[@name='Value']                        |
      | Value container     | //div[./textarea[@name='Value']]                 |

    And I scroll the "ConfigMap name" text box into view offset by "-300"
    And I highlight outside the "ConfigMap name" text box with an offset of "2"
    And I populate the "ConfigMap name" text box with "randomquotes"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}141-octopus-k8s.png"

    And I highlight outside the "Add Config Map Item" button
    And I click the "Add Config Map Item" button
    And I highlight outside the "Key" text box with an offset of "2"
    And I highlight outside the "Value container" element with an offset of "2"
    And I populate the "Key" text box with "ExternalConfigFileName"
    And I populate the "Value" text box with "#{appsettings}"

  @define-project @destinationspecific @k8s @microk8s
  Scenario: Save the step
    Given I set the following aliases:
      | Save | //button[@title='Save'] |

    And I highlight outside the "Save" button
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}160-octopus-k8s.png"
    And I force click the "Save" button
    And I sleep for "10" seconds

  @deploy-project
  Scenario: Deploy project
    And I run the feature "shared/octopus-deploy-project.feature" passing the original arguments

  @shutdown
  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser
