Feature: Test

  Scenario: Login
    Given I set the following aliases:
      | Username | //input[@id='username']      |
      | Password | //input[@id='password']      |
      | Log in   | //input[@name='submitLogin'] |

    And I open the shared browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://localhost:8111"
    And I populate the "Username" text box with "admin"
    And I populate the "Password" text box with "Password01!"
    And I click the "Log in" button

   Scenario: scrolling
    Given I set the following aliases:
      | Runner type                  | //input[@id='-ufd-teamcity-ui-runTypeInfoKey']    |
      | Visual Studio (sln)          | //li[@data-title='Visual Studio (sln)']           |

    And I open the URL "http://localhost:8111/admin/editRunType.html?id=buildType:RandomQuotesAspmvc4_Build&runnerId=__NEW_RUNNER__&cameFromUrl=%2Fadmin%2FeditBuildRunners.html%3Finit%3D1%26id%3DbuildType%3ARandomQuotesAspmvc4_Build%26cameFromUrl%3D%252Fadmin%252FeditProject.html%253Finit%253D1%2526projectId%253DRandomQuotesAspmvc4&cameFromTitle="
    And I click the "Runner type" drop down list
    And I scroll the "Visual Studio (sln)" option into view
    And I sleep for "5" seconds
    And I click the "Visual Studio (sln)" option