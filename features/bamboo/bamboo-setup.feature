Feature: Configure Bamboo

  Scenario: Initial Setup
    Given I set the following aliases:
      | License key          | //textarea[@id='validateLicense_licenseString'] |
      | Express installation | //input[@id='expressInstall']                   |

    And I open the URL "http://localhost:8085"
    And I populate the "License key" text box with "ExternalBambooLicenseKey"
    And I click the "Express installation" button