Feature: Configure Maven
  @executables
  Scenario: Configure Maven CLI
    Given I set the following aliases:
      | Close dialog     | //span[@class='aui-icon icon-close']         |
      | Administration   | //span[contains(.,'Administration')]         |
      | Overview         | //a[contains(.,'Overview')]                  |
      | Capability type  | //select[@id='addCapability_capabilityType'] |
      | Type             | //select[@id='executableTypeSelect']         |
      | Executable label | //input[@id='addCapability_builderLabel']    |
      | Executable path  | //input[@id='addCapability_builderPath']     |
      | Add              | //input[@id='addCapability_save']            |

    And I scroll the "Capability type" drop down list into view offset by "-300"
    And I select the option "Executable" from the "Capability type" drop down list
    And I select the option "Maven 3.x" from the "Type" drop down list
    And I populate the "Executable label" text box with "Maven"
    And I clear the "Executable path" text box
    And I populate the "Executable path" text box with "/usr"
    And I scroll the "Add" button into view offset by "-300"

    And I highlight outside the "Capability type" drop down list with an offset of "2"
    And I highlight outside the "Type" drop down list with an offset of "2"
    And I highlight outside the "Executable label" text box with an offset of "2"
    And I highlight outside the "Executable path" text box with an offset of "5"
    And I highlight outside the "Add" button with an offset of "5"

    And I save a screenshot to "#{ExternalMediaPath}/bamboo/executables/#{GuideSpecificScreenshotDir}030-mvn.png"
    And I click the "Add" button

    And I stop recording the screen