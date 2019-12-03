Feature: Add Octopus plugin

  @add-plugins
  Scenario: Add plugins
    Given I set the following aliases:
      | Close dialog               | //span[@class='aui-icon icon-close']                       |
      | Administration             | //span[contains(.,'Administration')]                       |
      | Overview                   | //a[contains(.,'Overview')]                                |
      | Find new apps              | //a[contains(.,'Find new apps')]                           |
      | Search the Marketplace     | //input[@id='upm-install-search-box']                      |
      | Install                    | //a[contains(.,'Install')]                                 |
      | Accept & install           | //button[normalize-space(text())='Accept & install']       |
      | Installed and ready to go! | //h2[normalize-space(text())='Installed and ready to go!'] |
      | Close                      | //button[text()='Close']                                   |

    And I click the "Close dialog" button waiting up to "5" seconds if it exists
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I display a note with the text "Installing the Bamboo add ons" for "3" seconds

    And I scroll the "Administration" button into view
    And I force click the "Administration" button
    And I highlight inside the "Administration" button
    And I highlight outside the "Overview" link
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/addins/#{GuideSpecificScreenshotDir}010-administration.png"
    # There were some issues trying to click this link, so we mouse over and then manually redirect
    And I mouse over the "Overview" link
    And I open the URL "http://localhost:6990/bamboo/admin/administer.action"

    And I scroll the "Find new apps" link into view offset by "-300"
    And I highlight outside the "Find new apps" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/addins/#{GuideSpecificScreenshotDir}020-find-apps.png"
    And I click the "Find new apps" link

    And I stop recording the screen
    And I refresh the page if the "Search the Marketplace" text box does not exist
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I populate the "Search the Marketplace" text box with "Octopus"
    And I highlight outside the "Search the Marketplace" text box with an offset of "5"
    And I sleep for "2" second
    And I press the enter key from the "Search the Marketplace" text box
    And I sleep for "5" seconds

    And I highlight outside the "Install" button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/addins/#{GuideSpecificScreenshotDir}030-octopus-addin.png"
    And I click the "Install" button
    And I remove the highlight from the "Search the Marketplace" text box
    And I sleep for "5" seconds

    And I highlight outside the "Accept & install" button with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/addins/#{GuideSpecificScreenshotDir}040-accept.png"
    And I click the "Accept & install" button

    And I highlight outside the "Close" button
    Then I verify the "Installed and ready to go!" title is present
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/addins/#{GuideSpecificScreenshotDir}050-installed.png"
    And I click the "Close" button
    And I stop recording the screen