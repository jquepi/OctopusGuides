Feature: Add Octopus plugin

  @add-plugins
  Scenario: Add plugins
    Given I set the following aliases:
      | Close dialog               | //span[@class='aui-icon icon-close']                       |
      | Administration             | //span[contains(.,'Administration')]                       |
      | Overview                   | //a[contains(.,'Overview')]                                |
      | Manage apps                | //a[@id='upm-admin-link']                                  |
      | Upload app                 | //a[@id='upm-upload']                                      |
      | File                       | //input[@id='upm-upload-file']                             |
      | Upload                     | //button[normalize-space(text())='Upload']                 |
      | Installed and ready to go! | //h2[normalize-space(text())='Installed and ready to go!'] |
      | Close                      | //button[text()='Close']                                   |

    And I click the "Close dialog" button waiting up to "5" seconds if it exists
    And I start recording the screen to the directory "#{ExternalMediaPath}"

    And I display a note with the text "Installing the Bamboo add ons" for "3" seconds

    And I scroll the "Administration" button into view
    And I force click the "Administration" button
    And I highlight inside the "Administration" button
    And I highlight outside the "Overview" link
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/manualaddins/#{GuideSpecificScreenshotDir}010-administration.png"
    # There were some issues trying to click this link, so we mouse over and then manually redirect
    And I force mouse over the "Overview" link
    And I open the URL "http://#{Hostname}:6990/bamboo/admin/administer.action"

    And I scroll the "Manage apps" link into view offset by "-300"
    And I highlight outside the "Manage apps" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/manualaddins/#{GuideSpecificScreenshotDir}020-find-apps.png"
    And I click the "Manage apps" link

    And I highlight outside the "Upload app" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/manualaddins/#{GuideSpecificScreenshotDir}020-find-apps.png"
    And I click the "Upload app" link

    And I populate the "File" file selector with a keystroke delay of "0" with "ExternalBambooPlugin"
    And I highlight outside the "Upload app" file selector with an offset of "5"

    And I highlight outside the "Upload" button
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/manualaddins/#{GuideSpecificScreenshotDir}030-octopus-addin.png"
    And I click the "Upload" button
    And I sleep for "5" seconds

    Then I verify the "Installed and ready to go!" title is present
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/manualaddins/#{GuideSpecificScreenshotDir}050-installed.png"
    And I click the "Close" button
    And I stop recording the screen