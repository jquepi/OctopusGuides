Feature: Add project

  Scenario: Add project
    Given I set the following aliases:
      | My Bamboo                    | //a[@id='myBamboo']                                                                            |
      | Create your first build plan | //a[@id='create-a-plan']                                                                       |
      | Project name                 | //input[@id='projectName']                                                                     |
      | Plan name                    | //input[@id='chainName']                                                                       |
      | Create                       | //input[@id='newPlanDetails_save']                                                             |
      | Link new repository          | //input[@id='repositoryTypeCreateOption']                                                      |
      | Repository host              | //a[@id='repository-other']                                                                    |
      | Git                          | //a[@href='#com.atlassian.bamboo.plugins.atlassian-bamboo-plugin-git:gitv2']                   |
      | Display name                 | //input[@id='addRepositoryToPlan_repositoryName']                                              |
      | Repository URL               | //input[@id='addRepositoryToPlan_repository_git_repositoryUrl']                                |
      | Test connection              | //button[@id='test-connection-com-atlassian-bamboo-plugins-atlassian-bamboo-plugin-git-gitv2'] |
      | Connection successful        | //p[text()='Connection successful']                                                            |
      | Save and continue            | //input[@id='addRepositoryToPlan_save']                                                        |

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Creating the build project" for "3" seconds

    And I highlight inside the "My Bamboo" link
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}010-mybamboo.png"
    And I click the "My Bamboo" link

    And I highlight outside the "Create your first build plan" button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}020-create-build-plan.png"
    And I click the "Create your first build plan" button

    And I highlight outside the "Project name" text box with an offset of "5"
    And I populate the "Project name" text box with "Random Quotes"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}030-project-name.png"

    And I highlight outside the "Plan name" text box with an offset of "5"
    And I populate the "Plan name" text box with "Website"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}040-plan-name.png"
    And I remove the highlight from the "Project name" text box
    And I remove the highlight from the "Plan name" text box

    And I highlight outside the "Create" text box with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}041-create.png"
    And I remove the highlight from the "Create" text box
    And I remove the highlight from the "Create" text box
    And I click the "Create" button

    And I highlight outside the "Link new repository" text box with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}042-link-new-repository.png"
    And I remove the highlight from the "Link new repository" text box
    And I click the "Link new repository" radio button

    And I highlight outside the "Repository host" drop down list
    And I scroll the "Repository host" drop down list into view offset by "-300"
    And I click the "Repository host" drop down list

    And I scroll the "Git" option into view offset by "-300"
    And I highlight outside the "Git" option with an offset of "0"
    And I click the "Git" option
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}050-git.png"

    And I highlight outside the "Display name" text box with an offset of "0"
    And I scroll the "Display name" text box into view offset by "-300"
    And I populate the "Display name" text box with "Random Quotes GitHub"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}060-display-name.png"

    And I highlight outside the "Repository URL" text box with an offset of "5"
    And I scroll the "Repository URL" text box into view offset by "-300"
    And I populate the "Repository URL" text box with "GitUrl"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}070-repo-url.png"
    And I remove the highlight from the "Git" option
    And I remove the highlight from the "Display name" text box
    And I remove the highlight from the "Repository URL" text box

    And I highlight outside the "Test connection" button
    And I scroll the "Test connection" button into view offset by "-300"
    And I scroll the "Test connection" button into view
    And I click the "Test connection" button
    Then I verify the "Connection successful" message is present
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}080-test-connection.png"

    And I highlight outside the "Save and continue" text box with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/initialproject/#{GuideSpecificScreenshotDir}081-save-and-continue.png"
    And I remove the highlight from the "Save and continue" text box
    And I click the "Save and continue" radio button