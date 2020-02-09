Feature: Build and deploy a ASP.NET application hosted in Git on a local Octopus instance

  @login
  Scenario: Log into Azure DevOps
    And I open the shared browser "ExternalBrowserType"
    And I set the default explicit wait time to "30" seconds
    And I fullscreen the window
    #And I set the window size to "1024" x "768"
    When I open the URL "#{AZURE_URL}"
    And I zoom the browser out

  @install-extensions
  Scenario: Install Extensions
    Given I set the following aliases:
      | Admin settings        | //a[@href='/DefaultCollection/_settings/']                                    |
      | Extensions            | //a[@href='/DefaultCollection/_settings/extensions']                          |
      | Browse Marketplace    | //a[contains(.,'Browse Marketplace')]                                         |
      | Search                | //input[@aria-label='Search Azure DevOps extensions']                         |
      | Search button         | //span[@title='search']                                                       |
      | Octopus tile          | //a[@href='/items?itemName=octopusdeploy.octopus-deploy-build-release-tasks'] |
      | Get it free           | //button[text()='Get it free']                                                |
      | Install               | //button[contains(.,'Install')]                                               |
      | Proceed to collection | //a[@href='/DefaultCollection/']                                              |

    And I click the "Admin settings" button
    And I sleep for "2" seconds
    And I save a screenshot to "c:\screenshots\azuredevops\extensions\debug.png"