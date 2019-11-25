Feature: Test feature
  Scenario: Open google
    And I open the shared browser "ExternalBrowserType"
    And I block the request to "https://cdnjs.cloudflare.com/ajax/libs/.*\.png" returning the HTTP code "200"
    And I capture the HAR file
    And I open the URL "ExternalURL"
    And I sleep for "10" seconds
    And I verify there were no network errors