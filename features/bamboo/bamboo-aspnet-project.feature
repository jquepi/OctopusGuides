Feature: Configure Bamboo

  Scenario: Login
    Given I set the following aliases:
      | Log in     | //a[text()='Log in']                 |
      | Username   | //input[@id='loginForm_os_username'] |
      | Password   | //input[@id='loginForm_os_password'] |
      | Log in Two | // input[@id='loginForm_save']       |

    And I open the shared browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:6990/bamboo"
    And I click the "Log in" button
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "admin"
    And I save a screenshot to "c:\screenshots\bamboo\login\010-login.png"
    And I click the "Log in Two" button

  Scenario: Configure Git
    Given I set the following aliases:
      | Close dialog               | //span[@class='aui-icon icon-close']                       |
      | Administration             | //span[contains(.,'Administration')]                       |
      | Overview                   | //a[contains(.,'Overview')]                                |
      | Server capabilities        | //a[contains(.,'Server capabilities')]                     |
      | Git                        | //a[contains(.,'Git')]                                     |
      | Edit                       | //a[contains(.,'Edit')]                                    |
      | Path                       | //input[@id='updateSharedCapability_capabilityValue']      |
      | Update                     | //input[@id='updateSharedCapability_save']                 |
      | Find new apps              | //a[contains(.,'Find new apps')]                           |
      | Search the Marketplace     | //input[@id='upm-install-search-box']                      |
      | Install                    | //a[contains(.,'Install')]                                 |
      | Accept & install           | //button[normalize-space(text())='Accept & install']       |
      | Installed and ready to go! | //h2[normalize-space(text())='Installed and ready to go!'] |
      | Close                      | //button[text()='Close']                                   |

    And I click the "Close dialog" button waiting up to "10" seconds if it exists

    And I click the "Administration" button
    And I save a screenshot to "c:\screenshots\bamboo\updategit\010-administration.png"
    And I click the "Overview" link

    And I save a screenshot to "c:\screenshots\bamboo\updategit\020-server-capabilities.png"
    And I click the "Server capabilities" link

    And I save a screenshot to "c:\screenshots\bamboo\updategit\030-git.png"
    And I click the "Git" link
    And I click the "Edit" link

    And I populate the "Path" text box with "C:\Program Files\Git\cmd\git.exe"
    And I save a screenshot to "c:\screenshots\bamboo\updategit\040-path.png"
    And I click the "Update" button

    And I scroll the "Find new apps" link into view offset by "-300"
    And I click the "find new apps" link
    And I populate the "Search the Marketplace" text box with "Octopus"
    And I press the enter key from the "Search the Marketplace" text box
    And I sleep for "1" second
    And I click the "Install" button
    And I click the "Accept & install" button
    Then I verify the "Installed and ready to go!" title is present
    And I click the "Close" button

  Scenario: Add project
    Given I set the following aliases:
      | My Bamboo                    | //a[@id='myBamboo']                                                                            |
      | Create your first build plan | //a[@id='create-a-plan']                                                                       |
      | Project name                 | //input[@id='projectName']                                                                     |
      | Plan name                    | //input[@id='chainName']                                                                       |
      | Repository host              | //a[@id='repository-other']                                                                    |
      | Git                          | //a[@href='#com.atlassian.bamboo.plugins.atlassian-bamboo-plugin-git:gitv2']                   |
      | Display name                 | //input[@id='createPlan_repositoryName']                                                       |
      | Repository URL               | //input[@id='createPlan_repository_git_repositoryUrl']                                         |
      | Test connection              | //button[@id='test-connection-com-atlassian-bamboo-plugins-atlassian-bamboo-plugin-git-gitv2'] |
      | Connection successful        | //p[text()='Connection successful']                                                            |
      | Configure plan               | //input[@id='createPlan_save']                                                                 |
      | Add task                     | //a[@id='addTask']                                                                             |

    And I click the "My Bamboo" link
    And I click the "Create your first build plan" button
    And I populate the "Project name" text box with "Random Quotes"
    And I populate the "Plan name" text box with "Website"
    And I click the "Repository host" drop down list
    And I click the "Git" option
    And I populate the "Display name" text box with "Random Quotes GitHub"
    And I populate the "Repository URL" text box with "https://github.com/OctopusSamples/RandomQuotes-aspmvc4.git"
    And I click the "Test connection" button
    Then I verify the "Connection successful" message is present
    And I click the "Configure plan" button

    And I click the "Add task" button