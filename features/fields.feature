Feature: Fields functional extension
  In order to reduce the size of an API response
  As a client application
  I want to be able to specify which fields I need

  Scenario Outline: Empty or invalid values
    Given I get a request for resource "/articles/1.json"
    And I get the fields parameter "<value>"
    When I process the fields parameter
    Then the resulting response should be the same as the original one

    Examples:
      | value |
      |       |
      | ,     |
      | ,,    |
      | ,,,   |
      | ,,,,  |
      | ,,,,, |


  Scenario Outline: Specify partial responses
    Given I get a request for resource "/articles/1.json"
    And I get the fields parameter "<value>"
    When I process the fields parameter
    Then the resulting response should include the required fields
    And the resulting response should only contain "<specific_non_required_fields>" as non-required fields

    Examples:
      | value                         | specific_non_required_fields |
      | title                         | title                        |
      | title,name                    | title,name                   |
      | title,name,                   | title,name                   |
      | title,name,non_existent_field | title,name                   |

  Scenario: A link to the full resource is added to partial responses
    Given I get a request for resource "/articles/1.json"
    And I get the fields parameter "title,name"
    When I process the fields parameter
    Then the resulting response should include a link to the full resource
