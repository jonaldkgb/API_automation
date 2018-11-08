Feature: API

  @api_get
  Scenario: api get
    Given I want to get the users
    When I send an api request
    Then the response is a success

  @api_get_single_user
  Scenario: Get single user
    Given I want to get a single user
    When I send an api GET single user request
    Then the user details are retrieved

  @api_post
  Scenario: api post
    Given I want to post a user
    When I send an api request
    Then the user is added

  @api_put
  Scenario: api put
    Given I want to update a user
    When I send an api request
    Then the response is a success
    And the user is updated

  @api_get_parameters
  Scenario: api get with parameters
    Given I want to get the users with parameters
    And I want to get "3" pages with "4" users per page
    When I send an api request
    Then the response is a success
    And the response displays "3" pages with "4" users per page

  @api_delete
  Scenario: api delete
    Given I want to delete a user
    When I send an api request
    Then the user is deleted


    @api_register
  Scenario Outline: user register validation
    Given I want to register a user with email <email> and password <password>
    When I send an api request
    Then the following <error_message> is returned

    Examples:
      | email             | password  | error_message             |
      |                   | password1 | Missing email or username |
      | email@address.com |           | Missing password          |