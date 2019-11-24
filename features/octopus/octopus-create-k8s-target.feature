Feature: Create Azure Web App Target

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

  Scenario: Add target
    Given I set the following aliases:
      | Infrastructure                | //span[contains(.,'Infrastructure')]                                                                         |
      | Deployment Targets            | (//a[contains(.,'Deployment Targets')])[1]                                                                   |
      | Deployment Targets text       | (//a/span[contains(.,'Deployment Targets')] \| //a[contains(.,'Deployment Targets')])[1]                     |
      | Add Deployment Target         | //button[contains(.,'Add deployment target')]                                                                |
      | Kubernetes Cluster            | //button[contains(.,'Kubernetes Cluster')]                                                                   |
      | Kubernetes Cluster Target     | //div[contains(@class, 'EndpointCard_card') and contains(.,'Kubernetes Cluster')]                            |
      | Add                           | //div[contains(@class, 'EndpointCard_card') and contains(.,'Kubernetes Cluster')]//button[contains(.,'Add')] |
      | Display Name                  | //input[contains(@id,'Displayname')]                                                                         |
      | Environments                  | //input[@title='Select environments']                                                                        |
      | Environments Container        | //div[./div/div/div/input[@title='Select environments']]                                                     |
      | Dev environment               | //span[./div/div/div[text()='Dev']]                                                                          |
      | Target Roles                  | //input[@title='Roles (type to add new)']                                                                    |
      | Target Roles Container        | //div[./div/div/div/input[@title='Roles (type to add new)']]                                                 |
      | K8S web app role              | //span[./div/div/div[contains(.,'k8s')]]                                                                     |
      | Client Certificate            | //input[@value='KubernetesCertificate']                                                                      |
      | Select account certificate    | (//button[../../../../div[text()='Select certificate']])[1]                                                  |
      | Cluster account container     | (//div[./div[text()='Select certificate']])[1]                                                               |
      | Select cluster certificate    | (//button[../../../../div[text()='Select certificate']])[3]                                                  |
      | Cluster certificate container | (//div[./div[text()='Select certificate']])[2]                                                               |
      | Minikube certificate          | (//span[./div/div/div[text()='Minikube Client Certificate']])[1]                                             |
      | Kubernetes cluster URL        | //input[contains(@id,'KubernetesclusterURL')]                                                                |
      | Minikube CA                   | (//span[./div/div/div[text()='Minikube CA']])[1]                                                             |
      | Save                          | //button[contains(.,'Save')]                                                                                 |
      | Kubernetes namespace          | //input[contains(@id,'Kubernetesnamespace')]                                                                 |
      | Connectivity                  | //a[./span[text()='Connectivity']] \| //a[text()='Connectivity'][not(*)]                                     |
      | Check Health                  | //button[contains(.,'Check health')]                                                                         |
      | Task Log                      | //button[contains(.,'Task Log')]                                                                             |


    And I start recording the screen to the directory "ExternalMediaPath"
    And I display a note with the text "Creating Kubernetes deployment targets" for "3" seconds

    And I highlight outside the "Infrastructure" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/010-target.png"
    And I click the "Infrastructure" link
    And I remove the highlight from the "Infrastructure" link

    And I highlight outside the "Deployment Targets text" link with an offset of "-3" waiting up to "3" seconds if it exists
    And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/020-target.png"
    And I click the "Deployment Targets" link

    And I highlight outside the "Add Deployment Target" button
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/030-target.png"
    And I click the "Add Deployment Target" button

    And I click the "Kubernetes Cluster" button

    And I scroll the "Kubernetes Cluster Target" tile into view offset by "-200"
    And I highlight outside the "Kubernetes Cluster Target" tile
    And I mouse over the "Kubernetes Cluster Target" tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/040-target.png"
    And I click the "Add" button

    And I highlight outside the "Display Name" text box
    And I populate the "Display Name" text box with "ExternalTargetName"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/050-target.png"

    And I highlight inside the "Environments Container" element
    And I scroll the "Environments" text box into view offset by "-200"
    And I populate the "Environments" text box with "ExternalEnvironmentName"
    And I click the "ExternalEnvironment" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/055-target.png"

    And I highlight outside the "Target Roles Container" element
    And I scroll the "Target Roles" text box into view offset by "-200"
    And I populate the "Target Roles" text box with "k8s"
    And I click the "K8S web app role" option
    And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/060-target.png"

    And I highlight outside the "Client Certificate" option
    And I scroll the "Client Certificate" option into view offset by "-200"
    And I force click the "Client Certificate" option
    And I sleep for "1" second

    And I scroll the "Select account certificate" drop down list into view offset by "-200"
    And I click the "Select account certificate" drop down list
    And I click the "Minikube certificate" option
    And I highlight outside the "Cluster account container" element
    And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/070-target.png"

    And I highlight outside the "Kubernetes cluster URL" text box
    And I scroll the "Kubernetes cluster URL" text box into view offset by "-200"
    And I populate the "Kubernetes cluster URL" text box with "https://#{ExternalMinikubeIP}:8443"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/080-target.png"

    And I click the "Select cluster certificate" drop down list
    And I click the "Minikube CA" option
    And I highlight outside the "Cluster certificate container" element
    And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/090-target.png"

    And I scroll the "Kubernetes namespace" text box into view offset by "-200"
    And I highlight outside the "Kubernetes namespace" text box
    And I populate the "Kubernetes namespace" text box with "ExternalNamespace"

    And I highlight outside the "Save" button
    And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/100-target.png"
    And I click the "Save" button

    #And I highlight outside the "Connectivity" link
    #And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/110-target.png"
    #And I click the "Connectivity" link

    #And I highlight outside the "Check Health" button
    #And I save a screenshot to "#{ExternalMediaPath}/octopus/k8starget/120-target.png"
    #And I click the "Check Health" link

    #And I sleep for "10" seconds
    #And I click the "Task Log" link
    #And I scroll down "10000" px

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser