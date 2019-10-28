Feature: Replace Video
  Scenario: Log in
    Given I open the shared browser "FirefoxNoImplicitWait"
    And I set the default explicit wait time to "30" seconds
    And I maximize the window
    And I open the URL "https://auth.wistia.com/session/new?app=wistia"
    And I populate the "user_email" text box with "matthew.casperson@octopus.com"
    And I populate the "user_password" text box with "ExternalPassword"
    And I click the "//button[text()='Sign in']" button

  Scenario: Replace video
    And I open the URL "https://octopushq.wistia.com/medias/l4x3nd27e2"
    And I click the "replace_video" link
    And I click the "overwrite" option
    And I populate the "(//input[@type='file'])[2]" file selector with "C:\Users\Matthew\Downloads\aspnet-azuredevops-artifactory-feed-azure.mp4"
    And I sleep for "120" seconds