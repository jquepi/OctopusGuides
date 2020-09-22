Feature: Configure an Octopus payara project

  Scenario: Open Browser
    Given I run the feature "shared/octopus-open-browser.feature" passing the original arguments
    And I run the feature "shared/octopus-login.feature" passing the original arguments
    And I run the feature "shared/octopus-hide-wizard.feature" passing the original arguments
    And I run the feature "shared/octopus-create-project.feature" passing the original arguments

  @define-project @destinationspecific @payara
  Scenario: Add Java Archive Step
    Given I set the following aliases:
      | Define your deployment process | //button[contains(.,'Define your deployment process')]                                                    |
      | Add Step                       | //button[contains(.,'Add Step')]                                                                          |
      | Search                         | //input[@name='Filter by name, category or description...']                                               |
      | Deploy Java Archive            | //div[contains(@class, 'add-step-card') and contains(.,'Deploy Java Archive')]                            |
      | Add                            | //div[contains(@class, 'add-step-card') and contains(.,'Deploy Java Archive')]//button[contains(.,'Add')] |

    And I highlight outside the "Define your deployment process" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}030-octopus-define-process.png"

    And I click the "Define your deployment process" button
    And I sleep for "1" second

    And I highlight outside the "Add Step" button with an offset of "2"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}040-octopus-payara-add-step.png"
    And I click the "Add Step" button

    And I highlight outside the "Search" text box with an offset of "3"
    And I populate the "Search" text box with "Deploy java archive"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}050-octopus-payara-search.png"
    And I sleep for "2" seconds
    And I remove the highlight from the "Search" text box

    And I scroll the "Deploy Java Archive" tile into view offset by "-200"
    And I highlight outside the "Deploy Java Archive" tile
    And I mouse over the "Deploy Java Archive" tile
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}060-octopus-payara.png"
    And I force click the "Add" button

  @define-project @destinationspecific @payara
  Scenario: Java Define step
    Given I set the following aliases:
      | Configure features | (//button[contains(.,'Configure features')])[1]                                                 |
      | OK                 | //button[contains(.,'Ok')]                                                                      |
      | Step Name          | //input[@name='Step name']                                                                      |
      | On target roles    | //input[../../label[contains(text(), 'Runs on targets in roles (type to add new)')]]            |
      | Web role           | //div[contains(@class, 'VirtualListWithKeyboard_menuContainer')]//span[contains(.,'web')]//span |

    And I scroll the "Step Name" text box into view offset by "-300"
    And I highlight outside the "Step Name" text box
    And I force clear the "Step Name" text box
    And I populate the "Step Name" text box with "Deploy to Payara"
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}090-octopus-payara-step-name.png"
    And I remove the highlight from the "Step Name" text box

    And I scroll the "On target roles" text box into view offset by "-300"
    And I click the "On target roles" text box
    And I populate the "On target roles" text box with "web"
    And I sleep for "1" second
    And I highlight outside the "On target roles" text box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}100-octopus-payara-step-role.png"
    And I click the "Web role" option
    And I remove the highlight from the "On target roles" text box

  @define-project @destinationspecific @payara @repositoryspecific @artifactory
  Scenario: Select artifactory feed for the payara deployment
    Given I set the following aliases:
      | Package feed | (//div[./div[text()='Package feed']]/div)[2]/div |
      | Artifactory  | //div[./div/div[text()='Artifactory']]           |
      | HTML Body    | //body                                           |
      | Package ID   | //input[@name='PackageID']                       |

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

  @define-project @destinationspecific @payara @repositoryspecific @octo-built-in-feed
  Scenario: Select built in feed for the payara deployment
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

  @define-project @destinationspecific @payara
  Scenario: Java Define step
    Given I set the following aliases:
      | Deployed package file name                | //input[@name='Deployed package file name']                                           |
      | Use custom deployment directory           | //input[../div/label[normalize-space(text())='Use custom deployment directory']]      |
      | Use custom deployment directory container | //div[./div/div/div/label[normalize-space(text())='Use custom deployment directory']] |
      | Deploy Directory                          | //input[@name='Deploy Directory']                                                     |
      | Target files                              | //textarea[@name='Target files']                                                      |
      | Save                                      | //button[contains(.,'Save')]                                                          |

    And I scroll the "Deployed package file name" text box into view offset by "-300"
    And I highlight outside the "Deployed package file name" text box
    And I clear the "Deployed package file name" text box
    And I populate the "Deployed package file name" text box with "randomquotes-#{Octopus.Environment.Name | ToLower}.war"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}140-octopus-payara-deployedpackagefilename.png"
    And I remove the highlight from the "Deployed package file name" text box

    And I scroll the "Use custom deployment directory" text box into view offset by "-300"
    And I highlight outside the "Use custom deployment directory container" element
    And I force click the "Use custom deployment directory" check box
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}150-octopus-payara-usecustomdirectory.png"
    And I remove the highlight from the "Use custom deployment directory container" element

    And I scroll the "Deploy Directory" text box into view offset by "-300"
    And I highlight outside the "Deploy Directory" text box
    And I clear the "Deploy Directory" text box
    And I populate the "Deploy Directory" text box with "/opt/payara5/glassfish/domains/domain1/autodeploy"
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}160-octopus-payara-customdirectory.png"
    And I remove the highlight from the "Deploy Directory" text box

    And I scroll the "Target files" text box into view offset by "-300"
    And I highlight outside the "Target files" text box
    And I populate the "Target files" text box with "**/deployed-application.yml"

    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}170-octopus-payara-filereplacement.png"

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