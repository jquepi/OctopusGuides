Feature: Add NuGet feed

#  Scenario: Login
#    Given I run the feature "teamcity-login.feature" passing the original arguments
#    And I open the URL "http://localhost:8111/admin/editBuild.html?id=buildType:RandomQuotes_Build"
#    And I set the default explicit wait time to "30" seconds

  @repositoryspecific @tcnuget
  Scenario: Add NuGet feed
    Given I set the following aliases:
      | Random Quotes      | //a[@href='/admin/editProject.html?init=1&projectId=RandomQuotes'] |
      | Show more          | //a[contains(.,'Show more')]                                       |
      | NuGet Feed         | //a[text()='NuGet Feed']                                           |
      | Add new NuGet Feed | //a[contains(.,'Add new NuGet Feed')]                              |
      | Name               | //input[@id='name']                                                |
      | Save               | (//input[@value='Save'])[1]                                        |

    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I highlight outside the "Random Quotes" project link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}100-nugetfeed.png"
    And I click the "Random Quotes" project link

    And I highlight outside the "Show more" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}110-nugetfeed.png"
    And I remove the highlight from the "Show more" link
    And I click the "Show more" link

    And I highlight outside the "NuGet Feed" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}120-nugetfeed.png"
    And I click the "NuGet Feed" link

    And I highlight outside the "Add new NuGet Feed" button
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}130-nugetfeed.png"
    And I click the "Add new NuGet Feed" button

    And I highlight outside the "Name" text box
    And I highlight outside the "Save" button
    And I populate the "Name" text box with "NuGet"
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}140-nugetfeed.png"
    And I click the "Save" button

    And I highlight outside the "Project Home" link
    And I save a screenshot to "#{ExternalMediaPath}/teamcity/initialproject/#{GuideSpecificScreenshotDir}180-connections.png"
    And I click the "Project Home" link

    And I stop recording the screen