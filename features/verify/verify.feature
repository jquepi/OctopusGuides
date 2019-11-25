Feature: Test feature
  Scenario: Open google
    And I set the Octopus step percentage to "10" with a message of "Starting test"
    And I open the shared browser "ExternalBrowserType"
    And I block the request to "https://cdnjs.cloudflare.com/ajax/libs/.*\.png" returning the HTTP code "200"
    And I capture the HAR file
    And I open the URL "ExternalURL"
    And I sleep for "10" seconds
    And I save a screenshot to "C:\Temp\screenshot.png" and capture as an Octopus artifact called "screenshot.png"
    And I verify there were no network errors
    And I close the browser