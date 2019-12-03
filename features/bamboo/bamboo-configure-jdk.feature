Feature: Configure Maven

  @executables
  Scenario: Configure JDK
    Given I set the following aliases:
      | Close dialog        | //span[@class='aui-icon icon-close']                  |
      | Administration      | //span[contains(.,'Administration')]                  |
      | Overview            | //a[contains(.,'Overview')]                           |
      | Server capabilities | //a[contains(.,'Server capabilities')]                |
      | JDK                 | //a[id='title:system.jdk.JDK']                        |
      | Edit                | //a[contains(.,'Edit')]                               |
      | Path                | //input[@id='updateSharedCapability_capabilityValue'] |
      | Update              | //input[@id='updateSharedCapability_save']            |

    And I click the "Close dialog" button waiting up to "5" seconds if it exists

    And I start recording the screen to the directory "#{ExternalMediaPath}"
    And I display a note with the text "Configuring the executables" for "3" seconds

    And I scroll the "Administration" button into view
    And I force click the "Administration" button
    And I highlight inside the "Administration" button
    And I highlight outside the "Overview" link
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}010-administration.png"
        # There were some issues trying to click this link, so we mouse over and then manually redirect
    And I force mouse over the "Overview" link
    And I open the URL "http://localhost:6990/bamboo/admin/administer.action"

    And I highlight outside the "Server capabilities" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}020-server-capabilities.png"
    And I click the "Server capabilities" link

    And I scroll the "JDK" link into view offset by "-300"
    And I highlight outside the "JDK" link
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}030-jdk.png"
    And I click the "JDK" link

    And I highlight outside the "Edit" link with an offset of "5"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}035-edit.png"
    And I click the "Edit" link

    And I clear the "Path" text box
    And I populate the "Path" text box with "/usr/lib/jvm/java-1.8.0-openjdk-amd64"
    And I highlight outside the "Path" text box with an offset of "2"
    And I highlight outside the "Update" button with an offset of "2"
    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}040-path.png"
    And I click the "Update" button

    And I click the "Server capabilities" link