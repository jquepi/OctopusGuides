Feature: Define Variables
  @define-variables
  Scenario: Open the variables section
    Given I set the following aliases:
      | Variables         | //a[contains(.,'Variables')]                                                                                                                                 |
      | Variables text    | //a[contains(.,'Variables')][not(*)] \| //a/span[text()='Variables']                                                                                         |
      | Project Variables | //a[@href='#/Spaces-1/projects/random-quotes/variables']/div/span[contains(.,'Project')] \| //a[@href='#/Spaces-1/projects/random-quotes/variables'][not(*)] |

    And I open the URL "#{OctopusURL:-http://localhost}/app#/Spaces-1/projects/random-quotes/overview"
    And I sleep for "1" second

    And I click the "Variables" link
    # This is only used when the variables are in a collapsed menu
    #And I highlight outside the "Variables text" link with an offset of "2"
    And I highlight inside the "Project Variables" link
    And I sleep for "1" second
    And I save a screenshot to "#{ExternalMediaPath}/octopus/project/#{GuideSpecificScreenshotDir}020-octopus-variables.png"
    #And I remove the highlight from the "Variables text" link
    And I remove the highlight from the "Project Variables" link

    And I force click the "Project Variables" link
