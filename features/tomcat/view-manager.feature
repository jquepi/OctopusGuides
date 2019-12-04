Feature: Debug Tomcat

  Scenario: Open Manager
    And I open the browser "ExternalBrowserType"
    And I fullscreen the window
    And I set the default explicit wait time to "30" seconds
    And I open the URL "http://tomcat:Password01!@localhost:9091/manager/html"
    And I sleep for "5" seconds