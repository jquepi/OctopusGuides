Feature: Create and deploy a release from Jenkins
  This feature uses the Octopus plugin to create and deploy a release. This is an upgrade from
  the previous guides which called the Octopus CLI directly as a script step.

  Scenario: Initial Setup
    Given I run the feature "shared/jenkins-open-browser.feature" passing the original arguments
    And I run the feature "shared/jenkins-login.feature" passing the original arguments

  Scenario: Modify the existing project
    Given I set the following aliases:
      | Random Quotes Project     | //a[contains(.,'Random Quotes')]                               |
      | Configure                 | //a[contains(.,'Configure')]                                   |
      | Add post-build action     | //button[@type='button'][contains(.,'Add post-build action')]  |
      | Create Release            | //a[contains(.,'Octopus Deploy: Create Release')]              |
      | Project name              | //input[@name='_.project']                                     |
      | Environment               | //input[@name='_.environment']                                 |
      | Deploy after create label | //label[../input[@name='deployThisRelease']]                   |
      | Deploy after create       | //input[@name='deployThisRelease']                             |
      | Show deployment progress  | //input[@name='waitForDeployment']                             |
      | Save                      | //button[@type='submit' or @type='button'][contains(.,'Save')] |

    And I display a note with the text "Deploying an Octopus release from Jenkins" for "3" seconds

    And I highlight outside the "Random Quotes Project" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}005-random-quotes-link.png"
    And I click the "Random Quotes Project" link

    And I highlight inside the "Configure" link
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}010-octo-plugin-create-release-configure.png"
    And I click the "Configure" link
    # Try and prevent this when clicking the add build step button
    # org.openqa.selenium.ElementClickInterceptedException: element click intercepted: Element <button type="button" tabindex="0" id="yui-gen21-button" class="hetero-list-add" suffix="builder">...</button> is not clickable at point (317, 949). Other element would receive the click: <footer>...</footer>
    And I sleep for "5" second

    And I scroll the "Add post-build action" button into view offset by "-200"
    And I sleep for "2" seconds
    And I click the "Add post-build action" button
    And I highlight outside the "Add post-build action" button
    And I highlight outside the "Create Release" option

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}015-octo-plugin-create-release-build-step.png"
    And I click the "Create Release" option
    And I remove the highlight from the "Add post-build action" button

    And I scroll the "Project name" text box into view offset by "-200"
    And I highlight the "Project name" text box
    And I populate the "Project name" text box with "Random Quotes"

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}017-octo-plugin-create-release-command.png"

    And I scroll the "Deploy after create label" element into view offset by "-200"
    And I highlight the "Deploy after create label" element
    And I click the "Deploy after create" check box

    And I highlight the "Show deployment progress" check box
    And I click the "Show deployment progress" check box

    And I highlight the "Environment" text box
    And I populate the "Environment" text box with "Dev"

    And I highlight outside the "Save" button
    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}020-octo-plugin-create-release-command.png"

    And I remove the highlight from the "Project name" text box
    And I remove the highlight from the "Deploy after create" check box
    And I remove the highlight from the "Environment" text box

    And I save a screenshot to "#{ExternalMediaPath}/jenkins/createrelease/#{GuideSpecificScreenshotDir}025-octo-plugin-create-release-save.png"
    And I click the "Save" button

    And I stop recording the screen

  @build-now
  Scenario: Build project
    And I run the feature "shared/jenkins-build-two.feature"

  Scenario: Shutdown
    Then I fade the screen to "1" "1" "1" over "3000" milliseconds
    And I stop recording the screen
    And I close the browser