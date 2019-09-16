Feature: Build and deploy a ASP.NET application hosted in Git on a local Octopus instance

  @login
  Scenario: Log into Jenkins
    Given I set the following aliases:
      | Username | #j_username |
      | Password | body > div > div > form > div:nth-child(2) > input |
      | Sign In  | body > div > div > form > div.submit.formRow > input |
      | Profile Name | #header > div.login > span > a.model-link.inside.inverse > b |
    And I dump the aliases
    And I set the default explicit wait time to "30" seconds
    And I open the shared browser "FirefoxNoImplicitWait"
    And I maximize the window
    When I open the URL "http://localhost:8080"
    # It can take some time for Jenkins to start up, so we need to be able to wait here for the login box
    And I populate the "Username" text box with the text "jenkinsadmin" waiting up to "300" seconds
    And I populate the "Password" text box with the text "Password01!"
    And I click the "Sign In" button
    Then I verify the text from the "Profile Name" element matches the regex "jenkinsadmin"
    And I start recording the screen to the directory "C:\screenshots"

  @plugin-install
  Scenario: Install plugins
    Given I set the following aliases:
      | Manage Jenkins | #tasks > div:nth-child(4) > a.task-link |
      | Manage Plugins | #main-panel > div:nth-child(9) > a      |
      | Available      | #main-panel > form > div.tabBarFrame > div.tabBar > div:nth-child(2) > a |
      | Filter         | #filter-box                                                              |
      | MSBuild Plugin | #plugins > tbody > tr:nth-child(6) > td:nth-child(1) > input[type=checkbox] |
      | MSBuild Plugin Container | tr.plugin:nth-child(6) > td:nth-child(1)                          |
      | Install without restart | #yui-gen2-button                                                   |
      | Back to top             | //a[contains(.,'Go back to the top page')]                         |
    And I highlight outside the "Manage Jenkins" text box
    And I save a screenshot to "C:\screenshots\manage-jenkins.png"
    And I click the "Manage Jenkins" link
    And I scroll the "Manage Plugins" link into view offset by "-100"
    # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Manage Plugins" text box
    And I save a screenshot to "C:\screenshots\manage-plugins.png"
    And I click the "Manage Plugins" link
    And I click the "Available" tab
    And I populate the "Filter" text box with the text "MSBuild"
    And I click the "MSBuild Plugin" checkbox
    And I highlight inside the "Available" tab
    And I highlight outside the "Filter" tab
    And I highlight inside the "MSBuild Plugin Container" element
    And I highlight outside the "Install without restart" button
    And I save a screenshot to "C:\screenshots\msbuild-plugin.png"
    And I click the "Install without restart" button
    And I wait for "5" seconds
    And I highlight outside the "Back to top" link
    And I save a screenshot to "C:\screenshots\plugin-install.png"
    And I click the "Back to top" link

  @configure-tools
  Scenario: Configure tools
    Given I set the following aliases:
      | Manage Jenkins | #tasks > div:nth-child(4) > a.task-link |
      | Global Tool Configuration | div.manage-option:nth-child(7) > a:nth-child(1)      |
      | MSBuild                   | #yui-gen10-button                                    |
      | MSBuild Name              | #yui-gen16 > table:nth-child(2) > tbody:nth-child(1) > tr:nth-child(1) > td:nth-child(3) > input:nth-child(1) |
      | MSBuild Path              | #yui-gen16 > table:nth-child(2) > tbody:nth-child(1) > tr:nth-child(3) > td:nth-child(3) > input:nth-child(1) |
    And I open the URL "http://localhost:8080/"
    And I highlight outside the "Manage Jenkins" link
    And I save a screenshot to "C:\screenshots\manage-jenkins.png"
    And I click the "Manage Jenkins" link

    And I scroll the "Global Tool Configuration" link into view offset by "-100"
      # Give the top toolbar a change to realign itself
    And I wait for "1" seconds
    And I highlight outside the "Global Tool Configuration" link
    And I save a screenshot to "C:\screenshots\global-tool-configuration.png"
    And I click the "Global Tool Configuration" link

    And I scroll the "MSBuild" button into view offset by "-100"
    And I highlight outside the "MSBuild" button
    And I save a screenshot to "C:\screenshots\msbuild-global-tool.png"
    And I click the "MSBuild" button
    And I remove the highlight from the "MSBuild" button

    And I highlight inside the "MSBuild Name" text box
    And I populate the "MSBuild Name" text box with "MSBuild"
    And I highlight inside the "MSBuild Path" text box
    And I populate the "MSBuild Path" text box with the text "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin"
    And I save a screenshot to "C:\screenshots\msbuild-settings.png"

  Scenario: Shutdown
    And I close the browser
    And I stop recording the screen