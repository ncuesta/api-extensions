Feature: Expand functional extension
  In order to reduce the amount of requests sent to the API
  As a client application
  I want to be able to specify which related links I need expanded

  Scenario Outline: Invalid expand values are ignored
    Given I get a request for resource "/articles/1.json"
    And I get the expand parameter "<value>"
    When I process the expand parameter
    Then the resulting response should be the same as the original one

    Examples:
      | value            |
      |                  |
      | ,                |
      | ,,               |
      | non-existing-key |
      | non,existing,key |
      | non(existing)    |


  Scenario Outline: Links expansion for singular documents
    Given I get a request for resource "/articles/1.json"
    And I get the expand parameter "<value>"
    When I process the expand parameter
    Then the resulting response should include the original response
    And the resulting response should also contain "<expanded_links>" as new attributes

  Examples:
    | value                         | expanded_links |
    | title                         | title          |
    | title,name                    | title,name     |
    | title,name,                   | title,name     |
    | title,name,non_existent_field | title,name     |


  Scenario: Links expansion for collective documents
    Given I get a request for resource "/articles.json"
    And I get the expand parameter "entries(self)"
    When I process the expand parameter
    Then the resulting response should include the original response
    And the resulting response should have the entries expanded