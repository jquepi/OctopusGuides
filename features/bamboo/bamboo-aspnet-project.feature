Feature: Configure Bamboo

  Scenario: Login
    Given I set the following aliases:
      | Log in     | //a[text()='Log in']                 |
      | Username   | //input[@id='loginForm_os_username'] |
      | Password   | //input[@id='loginForm_os_password'] |
      | Log in Two | // input[@id='loginForm_save']       |

    And I open the URL "http://localhost:6990"
    And I click the "Log in" button
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "admin"
    And I save a screenshot to "c:\screenshots\bamboo\login\010-login.png"
    And I click the "Log in Two" button

  Scenario: Configure Git
    Given I set the following aliases:
      | Close dialog                 | //span[@class='aui-icon icon-close']                                         |
      | Administration               | //span[contains(.,'Administration')]                                         |
      | Overview                     | //a[contains(.,'Overview')]                                                  |
      | Server capabilities          | //a[contains(.,'Server capabilities')]                                       |
      | Git                          | //a[contains(.,'Git')]                                                       |
      | Edit                         | //a[contains(.,'Edit')]                                                      |
      | Path                         | //input[@id='updateSharedCapability_capabilityValue']                        |
      | Update                       | //input[@id='updateSharedCapability_save']                                   |

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

  Scenario: Add project
    Given I set the following aliases:
      | My Bamboo                    | //a[@id='myBamboo']                                                          |
      | Create your first build plan | //a[@id='create-a-plan']                                                     |
      | Project name                 | //input[@id='projectName']                                                   |
      | Plan name                    | //input[@id='chainName']                                                     |
      | Repository host              | //a[@id='repository-other']                                                  |
      | Git                          | //a[@href='#com.atlassian.bamboo.plugins.atlassian-bamboo-plugin-git:gitv2'] |
      | Display name                 | //input[@id='createPlan_repositoryName']                                     |
      | Repository URL               | //input[@id='createPlan_repository_git_repositoryUrl']                       |
      | Configure plan               |                                                                              |
      | Add task                     | //a[@id='addTask']                                                           |

    And I click the "My Bamboo" link
    And I click the "Create your first build plan" button

